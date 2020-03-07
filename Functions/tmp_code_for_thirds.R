positions <- fread('positions_tmp.csv')
schedule <- fread('schedule_tmp.csv')
third_place_pairing <- fread('./Data/third_place_pairing.csv', sep = ';')


thirds_table <- positions[position == 3][order(-points, -goal_diff, -goals_for, -won)]


a = fill8Final(schedule, positions, third_place_pairing)

