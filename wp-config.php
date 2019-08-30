<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'mariadb' );

/** MySQL database username */
define( 'DB_USER', 'root' );

/** MySQL database password */
define( 'DB_PASSWORD', 'redhat#123' );

/** MySQL hostname */
define( 'DB_HOST', 'mariadb.cpjdikjnnqmk.us-west-2.rds.amazonaws.com' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '^^GV&)f=~Y*QkYz *(qH1Kz9S?mzI;hVYatE>cr,~;w|Tt,jX)lWaY(9$vc?e4UF' );
define( 'SECURE_AUTH_KEY',  'sYMj}^gPDN>.~j+:J6rV7w;.gk$}3xQw<V$0:0D5S((ntdJLW^,i=Ldgvvd_~g93' );
define( 'LOGGED_IN_KEY',    'pN+uNNOk%LEM!~^GA=h}L5i)3XDRR>ZE8!!>YSR3BuUP[x`%*j8OY_}DA7U_}[kE' );
define( 'NONCE_KEY',        'h1{w6Ke<R:AW3ELCgC]pw.;<k$MQj?:Gqz|p7^r4)<0|95{{n=7p7p3]R#HcRMvm' );
define( 'AUTH_SALT',        '}`b`XuwQFXRIn($^Y^TrRZ53-A_R#NS`y`-IhQH5l7Z08$vY^wyAZGD;-$~-)b6F' );
define( 'SECURE_AUTH_SALT', 'W8 uZRh3k *a#yPk|K<@#H$D1+qx*/G^)ZG:/:Q###!m0YuT*d.c9Oe?6m7U5Gp7' );
define( 'LOGGED_IN_SALT',   'iIxsFF191:P7&K<^c^V)2Br-1!|siCFmKwW!@cO|S5%Ft8olr_Dh`#PpWuqh{Q6_' );
define( 'NONCE_SALT',       'w+qjY;RzqLn9tBCok8BRi)#Bvw4_hG>}ig8&GW:3K_P6LvJZem&F+G9JS2bm3}=3' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );

