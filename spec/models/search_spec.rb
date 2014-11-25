require 'spec_helper'

describe Search do
  let!(:calvin) { create(:user, name: "Calvin") }
  let!(:susie)  { create(:user, name: "Susie Derkins") }

  describe "#results" do
    context "searching with 1 availability match" do
      before do
        create_availability(calvin, "8  am", "4 pm", 2)
        create_availability(calvin, "10 am", "4 pm", 3)
        create_availability(susie,  "8  am", "2 pm", 3)
      end

      it "only returns matching availability" do
        search = create_search([["9 am", "3 pm"]], 2)
        search.reload.results.should == [calvin]
      end

      it "matches up to the exact time" do
        search = create_search([["8 am", "1 pm"]], 2)
        search.reload.results.should == [calvin]
      end

      it "can return multiple users" do
        search = create_search([["10 am", "2 pm"]], 3)
        search.reload.results.should =~ [calvin, susie]
      end
    end

    context "searching with 2 availability matches" do
      before do
        create_availability(calvin, "8  am", "4 pm", 2)
        create_availability(calvin, "10 am", "4 pm", 3)
        create_availability(susie,  "8  am", "2 pm", 3)
      end

      it "returns only Users with availability in both times" do
        search = create_search([["10 am", "2 pm"], ["9 am", "3 pm"]], 2)
        search.reload.results.should == [calvin]
      end
    end

    context "searching early in the morning" do
      it "works as expected" do
        create_availability(calvin, "2 am", "3 am", 2)

        search = create_search([["2 am", "3 am"]], 2)
        search.results.should == [calvin]
      end
    end

    context "searching late at night" do
      it "works as expected" do
        create_availability(calvin, "10 pm", "11:50 pm", 2)

        search = create_search([["10 pm", "11:50 pm"]], 2)
        search.results.should == [calvin]
      end
    end

    context "setting time then having daylight savings start" do
      # begins early March
      it "works as expected" do
        Timecop.freeze("2014-2-20")

        create_availability(calvin, "10 am", "11 am", 2)

        Timecop.freeze("2014-4-20")

        search = create_search([["10 am", "11 am"]], 2)
        search.results.should == [calvin]
      end
    end

    context "setting time then having daylight savings stop" do
      it "works as expected" do
        # ends early November
        Timecop.freeze("2014-10-20")

        create_availability(calvin, "10 am", "11 am", 2)

        Timecop.freeze("2014-12-20")

        search = create_search([["10 am", "11 am"]], 2)
        search.results.should == [calvin]
      end
    end

    def create_search(times, day)
      search = Search.create(time_zone: mountain_time)

      times.each do |start_time, end_time|
        SubSearch.create(search: search,
          input_start: start_time,
          input_end:   end_time,
          day:         day
          )
      end

      search.reload
    end
  end

  def create_availability(user, start_time, end_time, day)
    create(:availability, user: user,
      input_start: start_time,
      input_end:   end_time,
      time_zone:   mountain_time,
      day:         day
      )
  end

  def mountain_time
    "Mountain Time (US & Canada)"
  end
end
