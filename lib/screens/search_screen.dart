import 'package:emoodie_app/utils/colors.dart';
import 'package:emoodie_app/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/search_provider.dart';
import 'widgets/albumgrid_widget.dart';
import 'widgets/artistlist_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.darkBlack,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Search',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.blockSizeVertical * 3.5,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.blockSizeVertical*2),
              TextField(
                onChanged: (value) => searchProvider.updateSearchTerm(value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Color.fromARGB(
                      122, 82, 81, 81)),
                  hintText: 'Artists, albums',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.blockSizeVertical*2),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ChoiceChip(
                    label: const Text('Albums'),
                    selected: searchProvider.isAlbumsSelected,
                    onSelected: (selected) => searchProvider.toggleTabSelection(true),
                    shape: const StadiumBorder(),
                    backgroundColor: const Color.fromARGB(255, 9, 9, 9),
                    selectedColor: Colors.green,
                    labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    showCheckmark: false,
                  ),
                  SizedBox(width: Dimensions.blockSizeHorizontal*4.3),
                  ChoiceChip(
                    label: const Text('Artists'),
                    selected: !searchProvider.isAlbumsSelected,
                    onSelected: (selected) =>
                        searchProvider.toggleTabSelection(false),
                    shape: const StadiumBorder(),
                    backgroundColor: const Color.fromARGB(255, 9, 9, 9),
                    selectedColor: Colors.green,
                    labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    showCheckmark: false,
                  ),
                ],
              ),
              SizedBox(height: Dimensions.blockSizeVertical*2),
              Expanded(
                child: searchProvider.isAlbumsSelected
                    ? const AlbumGrid() // Display AlbumGrid if Albums tab is selected
                    : const ArtistList(), // Display ArtistList if Artists tab is selected
              ),
            ],
          ),
        ),
      ),
    );
  }
}

