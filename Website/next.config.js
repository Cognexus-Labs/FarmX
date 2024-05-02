/** @type {import('next').NextConfig} */

const nextConfig = {
  env: {
    API_KEY: 'AIzaSyB2aI6e-BwKhxaZUgP5C98s70zzXn7t_UI',
  },
  reactStrictMode: true,
  swcMinify: true,
  images: {
    domains: ["localhost"],
    remotePatterns: [
      {
        protocol: "https",
        hostname: "cdn.sanity.io",
        port: "",
      },
    ],
  },
};

module.exports = nextConfig;
