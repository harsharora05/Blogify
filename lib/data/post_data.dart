import '../model/post_model.dart';

List<Post> dummyPosts = [
  Post(
      photo:
          'https://plus.unsplash.com/premium_photo-1673448391005-d65e815bd026?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGhvdG98ZW58MHx8MHx8fDA%3D',
      username: 'alice_wonder',
      title: 'A Day in the Park',
      content:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget nulla .\n\nClass aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur sodales ligula in libero. Sed dignissim lacinia nunc. Curabitur tortor. Pellentesque nibh. Aenean quam. In scelerisque sem at dolor. Maecenas mattis. Sed convallis tristique sem. Proin ut ligula vel nunc egestas porttitor. Morbi lectus risus, iaculis vel, suscipit quis, luctus non, massa.\n\n Fusce ac turpis quis ligula lacinia aliquet. Mauris ipsum.Nulla metus metus, ullamcorper vel, tincidunt sed, euismod in, nibh. Quisque volutpat condimentum velit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nam nec ante. Sed lacinia, urna non tincidunt mattis, tortor neque adipiscing diam, a cursus ipsum ante quis turpis. Nulla facilisi. Ut fringilla. Suspendisse potenti. Nunc feugiat mi a tellus consequat imperdiet. Vestibulum sapien. Proin quam. Etiam ultrices.\n\nSuspendisse in justo eu magna luctus suscipit. Sed lectus. Integer euismod lacus luctus magna. Quisque cursus, metus vitae pharetra auctor, sem massa mattis sem, at interdum magna augue eget diam. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Morbi lacinia molestie dui. Praesent blandit dolor. Sed non quam. In vel mi sit amet augue congue elementum. Morbi in ipsum sit amet pede facilisis laoreet. Donec lacus nunc, viverra nec.",
      category: "Food"),
  Post(
      photo:
          'https://img.freepik.com/free-photo/photorealistic-view-tree-nature-with-branches-trunk_23-2151478039.jpg',
      username: 'tech_guru',
      title: 'Flutter vs React Native',
      content:
          'In this post, I compare Flutter and React Native based on performance, ease of use, and community support.',
      category: "Life"),
  Post(
      photo:
          'https://images.pexels.com/photos/3139497/pexels-photo-3139497.jpeg?cs=srgb&dl=pexels-achraf210-3139497.jpg&fm=jpg',
      username: 'chef_master',
      title: 'Best Pasta Recipe',
      content:
          'Sharing my secret recipe for the best homemade pasta. It’s all about the sauce!',
      category: "Entertainment"),
  Post(
      photo:
          'https://images.unsplash.com/photo-1541516160071-4bb0c5af65ba?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8Z2lybCUyMHdpdGglMjBjYW1lcmF8ZW58MHx8MHx8fDA%3D',
      username: 'travel_junkie',
      title: 'Exploring the Alps',
      content:
          'Hiking through the Alps was a breathtaking experience. Here are some shots from the trip.',
      category: "sports"),
  Post(
      photo:
          'https://img.freepik.com/premium-photo/wide-angle-shot-single-tree-growing-clouded-sky-sunset-surrounded-by-grass_1033124-10.jpg',
      username: 'art_addict',
      title: 'My Latest Artwork',
      content:
          'This piece took me 2 weeks to complete. It’s a blend of abstract and surrealism.',
      category: "business"),
];

List<String> tags = [
  "All",
  "Sports",
  "Business",
  "Entertainment",
  "Life",
  "Food"
];
