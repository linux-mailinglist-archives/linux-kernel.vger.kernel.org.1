Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73080280462
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 18:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732819AbgJAQ5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 12:57:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:14476 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732709AbgJAQ5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 12:57:13 -0400
IronPort-SDR: WCJuFXq7yS6rQcssYKYpwH1grNEm96dLUJCZ5R2g6pTbQH8tHY8TVNSMEGM5+KcDwlwnOtf8H9
 5+n5GDmequKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="226899592"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="gz'50?scan'50,208,50";a="226899592"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 09:57:06 -0700
IronPort-SDR: WwH+n/gqPDm05zAWsQ7gvg9RvxWYXSX8mEwE9Tvz0OfTWv/dFtLAsKWCtYQB0GnGW4ijUT52Ax
 Bcl4uYbV9I0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="gz'50?scan'50,208,50";a="295046608"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 01 Oct 2020 09:57:03 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kO1t9-0000fV-0I; Thu, 01 Oct 2020 16:57:03 +0000
Date:   Fri, 2 Oct 2020 00:56:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: drivers/usb/misc/sisusbvga/sisusb.c:780:37: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202010020025.jrP5zOlk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   60e720931556fc1034d0981460164dcf02697679
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   5 weeks ago
config: sh-randconfig-s031-20200930 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-201-g24bdaac6-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

	echo
	echo "sparse warnings: (new ones prefixed by >>)"
	echo
   drivers/usb/misc/sisusbvga/sisusb.c:542:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short header @@     got restricted __le16 [usertype] @@
   drivers/usb/misc/sisusbvga/sisusb.c:542:9: sparse:     expected unsigned short header
   drivers/usb/misc/sisusbvga/sisusb.c:542:9: sparse:     got restricted __le16 [usertype]
   drivers/usb/misc/sisusbvga/sisusb.c:542:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] address @@     got restricted __le32 [usertype] @@
   drivers/usb/misc/sisusbvga/sisusb.c:542:9: sparse:     expected unsigned int [usertype] address
   drivers/usb/misc/sisusbvga/sisusb.c:542:9: sparse:     got restricted __le32 [usertype]
   drivers/usb/misc/sisusbvga/sisusb.c:542:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] data @@     got restricted __le32 [usertype] @@
   drivers/usb/misc/sisusbvga/sisusb.c:542:9: sparse:     expected unsigned int [usertype] data
   drivers/usb/misc/sisusbvga/sisusb.c:542:9: sparse:     got restricted __le32 [usertype]
   drivers/usb/misc/sisusbvga/sisusb.c:578:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short header @@     got restricted __le16 [usertype] @@
   drivers/usb/misc/sisusbvga/sisusb.c:578:9: sparse:     expected unsigned short header
   drivers/usb/misc/sisusbvga/sisusb.c:578:9: sparse:     got restricted __le16 [usertype]
   drivers/usb/misc/sisusbvga/sisusb.c:578:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] address @@     got restricted __le32 [usertype] @@
   drivers/usb/misc/sisusbvga/sisusb.c:578:9: sparse:     expected unsigned int [usertype] address
   drivers/usb/misc/sisusbvga/sisusb.c:578:9: sparse:     got restricted __le32 [usertype]
   drivers/usb/misc/sisusbvga/sisusb.c:578:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] data @@     got restricted __le32 [usertype] @@
   drivers/usb/misc/sisusbvga/sisusb.c:578:9: sparse:     expected unsigned int [usertype] data
   drivers/usb/misc/sisusbvga/sisusb.c:578:9: sparse:     got restricted __le32 [usertype]
   drivers/usb/misc/sisusbvga/sisusb.c:780:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/usb/misc/sisusbvga/sisusb.c:780:37: sparse:     expected unsigned char const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:780:37: sparse:     got unsigned char [noderef] [usertype] __user *
>> drivers/usb/misc/sisusbvga/sisusb.c:780:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__gu_addr @@
>> drivers/usb/misc/sisusbvga/sisusb.c:780:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/misc/sisusbvga/sisusb.c:780:37: sparse:     got unsigned char const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:795:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] [usertype] __user * @@
   drivers/usb/misc/sisusbvga/sisusb.c:795:37: sparse:     expected unsigned short const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:795:37: sparse:     got unsigned short [noderef] [usertype] __user *
>> drivers/usb/misc/sisusbvga/sisusb.c:795:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   drivers/usb/misc/sisusbvga/sisusb.c:795:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/misc/sisusbvga/sisusb.c:795:37: sparse:     got unsigned short const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:842:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/usb/misc/sisusbvga/sisusb.c:842:37: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:842:37: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/usb/misc/sisusbvga/sisusb.c:842:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/misc/sisusbvga/sisusb.c:842:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/misc/sisusbvga/sisusb.c:842:37: sparse:     got unsigned int const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:2653:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/usb/misc/sisusbvga/sisusb.c:2653:29: sparse:     expected unsigned char const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:2653:29: sparse:     got unsigned char [noderef] [usertype] __user *
   drivers/usb/misc/sisusbvga/sisusb.c:2653:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__gu_addr @@
   drivers/usb/misc/sisusbvga/sisusb.c:2653:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/misc/sisusbvga/sisusb.c:2653:29: sparse:     got unsigned char const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:2664:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] [usertype] __user * @@
   drivers/usb/misc/sisusbvga/sisusb.c:2664:29: sparse:     expected unsigned short const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:2664:29: sparse:     got unsigned short [noderef] [usertype] __user *
   drivers/usb/misc/sisusbvga/sisusb.c:2664:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   drivers/usb/misc/sisusbvga/sisusb.c:2664:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/misc/sisusbvga/sisusb.c:2664:29: sparse:     got unsigned short const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:2675:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/usb/misc/sisusbvga/sisusb.c:2675:29: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:2675:29: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/usb/misc/sisusbvga/sisusb.c:2675:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/misc/sisusbvga/sisusb.c:2675:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/misc/sisusbvga/sisusb.c:2675:29: sparse:     got unsigned int const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:2740:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/usb/misc/sisusbvga/sisusb.c:2740:21: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:2740:21: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/usb/misc/sisusbvga/sisusb.c:2740:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/misc/sisusbvga/sisusb.c:2740:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/misc/sisusbvga/sisusb.c:2740:21: sparse:     got unsigned int const *__gu_addr
--
   drivers/watchdog/pcwd_usb.c:375:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   drivers/watchdog/pcwd_usb.c:375:37: sparse:     expected char const *__gu_addr
   drivers/watchdog/pcwd_usb.c:375:37: sparse:     got char const [noderef] __user *
>> drivers/watchdog/pcwd_usb.c:375:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
>> drivers/watchdog/pcwd_usb.c:375:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/pcwd_usb.c:375:37: sparse:     got char const *__gu_addr
   drivers/watchdog/pcwd_usb.c:423:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     got int [noderef] __user *p
>> drivers/watchdog/pcwd_usb.c:423:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     got int const *__gu_addr
   drivers/watchdog/pcwd_usb.c:447:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     got int [noderef] __user *p
   drivers/watchdog/pcwd_usb.c:447:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     got int const *__gu_addr
--
   drivers/media/rc/lirc_dev.c:378:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/media/rc/lirc_dev.c:378:23: sparse:     expected unsigned int const *__gu_addr
   drivers/media/rc/lirc_dev.c:378:23: sparse:     got unsigned int [noderef] [usertype] __user *argp
>> drivers/media/rc/lirc_dev.c:378:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
>> drivers/media/rc/lirc_dev.c:378:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/media/rc/lirc_dev.c:378:23: sparse:     got unsigned int const *__gu_addr
--
   drivers/usb/image/mdc800.c:806:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   drivers/usb/image/mdc800.c:806:20: sparse:     expected char const *__gu_addr
   drivers/usb/image/mdc800.c:806:20: sparse:     got char const [noderef] __user *
>> drivers/usb/image/mdc800.c:806:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
>> drivers/usb/image/mdc800.c:806:20: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/image/mdc800.c:806:20: sparse:     got char const *__gu_addr
--
   sound/core/oss/pcm_oss.c:2592:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/oss/pcm_oss.c:2592:21: sparse:     expected int const *__gu_addr
   sound/core/oss/pcm_oss.c:2592:21: sparse:     got int [noderef] __user *p
>> sound/core/oss/pcm_oss.c:2592:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> sound/core/oss/pcm_oss.c:2592:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2592:21: sparse:     got int const *__gu_addr
   sound/core/oss/pcm_oss.c:2603:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/oss/pcm_oss.c:2603:21: sparse:     expected int const *__gu_addr
   sound/core/oss/pcm_oss.c:2603:21: sparse:     got int [noderef] __user *p
   sound/core/oss/pcm_oss.c:2603:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/oss/pcm_oss.c:2603:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2603:21: sparse:     got int const *__gu_addr
   sound/core/oss/pcm_oss.c:2615:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/oss/pcm_oss.c:2615:21: sparse:     expected int const *__gu_addr
   sound/core/oss/pcm_oss.c:2615:21: sparse:     got int [noderef] __user *p
   sound/core/oss/pcm_oss.c:2615:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/oss/pcm_oss.c:2615:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2615:21: sparse:     got int const *__gu_addr
   sound/core/oss/pcm_oss.c:2627:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/oss/pcm_oss.c:2627:21: sparse:     expected int const *__gu_addr
   sound/core/oss/pcm_oss.c:2627:21: sparse:     got int [noderef] __user *p
   sound/core/oss/pcm_oss.c:2627:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/oss/pcm_oss.c:2627:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2627:21: sparse:     got int const *__gu_addr
   sound/core/oss/pcm_oss.c:2644:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/oss/pcm_oss.c:2644:21: sparse:     expected int const *__gu_addr
   sound/core/oss/pcm_oss.c:2644:21: sparse:     got int [noderef] __user *p
   sound/core/oss/pcm_oss.c:2644:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/oss/pcm_oss.c:2644:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2644:21: sparse:     got int const *__gu_addr
   sound/core/oss/pcm_oss.c:2651:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/oss/pcm_oss.c:2651:21: sparse:     expected int const *__gu_addr
   sound/core/oss/pcm_oss.c:2651:21: sparse:     got int [noderef] __user *p
   sound/core/oss/pcm_oss.c:2651:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/oss/pcm_oss.c:2651:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2651:21: sparse:     got int const *__gu_addr
   sound/core/oss/pcm_oss.c:2678:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/oss/pcm_oss.c:2678:21: sparse:     expected int const *__gu_addr
   sound/core/oss/pcm_oss.c:2678:21: sparse:     got int [noderef] __user *p
   sound/core/oss/pcm_oss.c:2678:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/oss/pcm_oss.c:2678:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2678:21: sparse:     got int const *__gu_addr
--
   fs/cifs/dfs_cache.c:195:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user *buffer @@
   fs/cifs/dfs_cache.c:195:14: sparse:     expected char const *__gu_addr
   fs/cifs/dfs_cache.c:195:14: sparse:     got char const [noderef] __user *buffer
>> fs/cifs/dfs_cache.c:195:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
>> fs/cifs/dfs_cache.c:195:14: sparse:     expected void const volatile [noderef] __user *ptr
   fs/cifs/dfs_cache.c:195:14: sparse:     got char const *__gu_addr
--
   net/tls/tls_main.c:341:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/tls/tls_main.c:341:13: sparse:     expected int const *__gu_addr
   net/tls/tls_main.c:341:13: sparse:     got int [noderef] __user *optlen
>> net/tls/tls_main.c:341:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> net/tls/tls_main.c:341:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/tls/tls_main.c:341:13: sparse:     got int const *__gu_addr
--
   net/ipv6/ip6mr.c:1837:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv6/ip6mr.c:1837:13: sparse:     expected int const *__gu_addr
   net/ipv6/ip6mr.c:1837:13: sparse:     got int [noderef] __user *optlen
>> net/ipv6/ip6mr.c:1837:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> net/ipv6/ip6mr.c:1837:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ip6mr.c:1837:13: sparse:     got int const *__gu_addr
   net/ipv6/ip6mr.c:405:13: sparse: sparse: context imbalance in 'ip6mr_vif_seq_start' - different lock contexts for basic block
   net/ipv6/ip6mr.c: note: in included file (through include/linux/mroute6.h):
   include/linux/mroute_base.h:427:31: sparse: sparse: context imbalance in 'mr_mfc_seq_stop' - unexpected unlock
--
   net/dccp/proto.c:535:52: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 const [usertype] service @@     got int [addressable] val @@
   net/dccp/proto.c:535:52: sparse:     expected restricted __be32 const [usertype] service
   net/dccp/proto.c:535:52: sparse:     got int [addressable] val
   net/dccp/proto.c:620:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/dccp/proto.c:620:13: sparse:     expected int const *__gu_addr
   net/dccp/proto.c:620:13: sparse:     got int [noderef] __user *optlen
>> net/dccp/proto.c:620:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> net/dccp/proto.c:620:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/dccp/proto.c:620:13: sparse:     got int const *__gu_addr
   net/dccp/proto.c:718:57: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 [usertype] param @@     got int cmsg_type @@
   net/dccp/proto.c:718:57: sparse:     expected restricted __be32 [usertype] param
   net/dccp/proto.c:718:57: sparse:     got int cmsg_type
--
   fs/ocfs2/ioctl.c:860:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ocfs2/ioctl.c:860:21: sparse:     expected int const *__gu_addr
   fs/ocfs2/ioctl.c:860:21: sparse:     got int [noderef] __user *
>> fs/ocfs2/ioctl.c:860:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> fs/ocfs2/ioctl.c:860:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ocfs2/ioctl.c:860:21: sparse:     got int const *__gu_addr
   fs/ocfs2/ioctl.c:882:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ocfs2/ioctl.c:882:21: sparse:     expected int const *__gu_addr
   fs/ocfs2/ioctl.c:882:21: sparse:     got int [noderef] __user *
   fs/ocfs2/ioctl.c:882:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/ocfs2/ioctl.c:882:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ocfs2/ioctl.c:882:21: sparse:     got int const *__gu_addr
--
   net/x25/af_x25.c:470:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/x25/af_x25.c:470:13: sparse:     expected int const *__gu_addr
   net/x25/af_x25.c:470:13: sparse:     got int [noderef] __user *optlen
>> net/x25/af_x25.c:470:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> net/x25/af_x25.c:470:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/x25/af_x25.c:470:13: sparse:     got int const *__gu_addr
--
   net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/netrom/af_netrom.c:359:13: sparse:     expected int const *__gu_addr
   net/netrom/af_netrom.c:359:13: sparse:     got int [noderef] __user *optlen
>> net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> net/netrom/af_netrom.c:359:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/netrom/af_netrom.c:359:13: sparse:     got int const *__gu_addr
--
   net/rose/af_rose.c:438:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/rose/af_rose.c:438:13: sparse:     expected int const *__gu_addr
   net/rose/af_rose.c:438:13: sparse:     got int [noderef] __user *optlen
>> net/rose/af_rose.c:438:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> net/rose/af_rose.c:438:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/rose/af_rose.c:438:13: sparse:     got int const *__gu_addr
--
   net/ax25/af_ax25.c:695:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ax25/af_ax25.c:695:13: sparse:     expected int const *__gu_addr
   net/ax25/af_ax25.c:695:13: sparse:     got int [noderef] __user *optlen
>> net/ax25/af_ax25.c:695:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> net/ax25/af_ax25.c:695:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ax25/af_ax25.c:695:13: sparse:     got int const *__gu_addr
   net/ax25/af_ax25.c:1742:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long const *__gu_addr @@     got long [noderef] __user * @@
   net/ax25/af_ax25.c:1742:21: sparse:     expected long const *__gu_addr
   net/ax25/af_ax25.c:1742:21: sparse:     got long [noderef] __user *
>> net/ax25/af_ax25.c:1742:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long const *__gu_addr @@
   net/ax25/af_ax25.c:1742:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ax25/af_ax25.c:1742:21: sparse:     got long const *__gu_addr
--
   net/rxrpc/af_rxrpc.c:697:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *_optlen @@
   net/rxrpc/af_rxrpc.c:697:13: sparse:     expected int const *__gu_addr
   net/rxrpc/af_rxrpc.c:697:13: sparse:     got int [noderef] __user *_optlen
>> net/rxrpc/af_rxrpc.c:697:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> net/rxrpc/af_rxrpc.c:697:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/rxrpc/af_rxrpc.c:697:13: sparse:     got int const *__gu_addr
--
   net/l2tp/l2tp_ppp.c:1376:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/l2tp/l2tp_ppp.c:1376:13: sparse:     expected int const *__gu_addr
   net/l2tp/l2tp_ppp.c:1376:13: sparse:     got int [noderef] __user *optlen
>> net/l2tp/l2tp_ppp.c:1376:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> net/l2tp/l2tp_ppp.c:1376:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/l2tp/l2tp_ppp.c:1376:13: sparse:     got int const *__gu_addr
--
   net/sctp/socket.c:7814:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/sctp/socket.c:7814:13: sparse:     expected int const *__gu_addr
   net/sctp/socket.c:7814:13: sparse:     got int [noderef] __user *optlen
>> net/sctp/socket.c:7814:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> net/sctp/socket.c:7814:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:7814:13: sparse:     got int const *__gu_addr
   net/sctp/socket.c:8210:20: sparse: sparse: context imbalance in 'sctp_get_port_local' - unexpected unlock
--
   drivers/block/rbd.c:699:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/block/rbd.c:699:13: sparse:     expected int const *__gu_addr
   drivers/block/rbd.c:699:13: sparse:     got int [noderef] __user *
>> drivers/block/rbd.c:699:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> drivers/block/rbd.c:699:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/block/rbd.c:699:13: sparse:     got int const *__gu_addr
--
   drivers/net/tap.c:53:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *sp @@
   drivers/net/tap.c:53:13: sparse:     expected int const *__gu_addr
   drivers/net/tap.c:53:13: sparse:     got int [noderef] __user *sp
>> drivers/net/tap.c:53:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> drivers/net/tap.c:53:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/tap.c:53:13: sparse:     got int const *__gu_addr
   drivers/net/tap.c:991:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected short const *__gu_addr @@     got short [noderef] __user * @@
   drivers/net/tap.c:991:21: sparse:     expected short const *__gu_addr
   drivers/net/tap.c:991:21: sparse:     got short [noderef] __user *
>> drivers/net/tap.c:991:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got short const *__gu_addr @@
   drivers/net/tap.c:991:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/tap.c:991:21: sparse:     got short const *__gu_addr
   drivers/net/tap.c:1020:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected short const *__gu_addr @@     got short [noderef] __user * @@
   drivers/net/tap.c:1020:21: sparse:     expected short const *__gu_addr
   drivers/net/tap.c:1020:21: sparse:     got short [noderef] __user *
   drivers/net/tap.c:1020:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got short const *__gu_addr @@
   drivers/net/tap.c:1020:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/tap.c:1020:21: sparse:     got short const *__gu_addr
   drivers/net/tap.c:1033:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *sp @@
   drivers/net/tap.c:1033:21: sparse:     expected int const *__gu_addr
   drivers/net/tap.c:1033:21: sparse:     got int [noderef] __user *sp
   drivers/net/tap.c:1033:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/tap.c:1033:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/tap.c:1033:21: sparse:     got int const *__gu_addr
   drivers/net/tap.c:1048:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *sp @@
   drivers/net/tap.c:1048:21: sparse:     expected int const *__gu_addr
   drivers/net/tap.c:1048:21: sparse:     got int [noderef] __user *sp
   drivers/net/tap.c:1048:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/tap.c:1048:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/tap.c:1048:21: sparse:     got int const *__gu_addr
   drivers/net/tap.c:1063:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *sp @@
   drivers/net/tap.c:1063:21: sparse:     expected int const *__gu_addr
   drivers/net/tap.c:1063:21: sparse:     got int [noderef] __user *sp
   drivers/net/tap.c:1063:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/tap.c:1063:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/tap.c:1063:21: sparse:     got int const *__gu_addr
--
   drivers/net/tun.c:330:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *argp @@
   drivers/net/tun.c:330:13: sparse:     expected int const *__gu_addr
   drivers/net/tun.c:330:13: sparse:     got int [noderef] __user *argp
>> drivers/net/tun.c:330:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> drivers/net/tun.c:330:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/tun.c:330:13: sparse:     got int const *__gu_addr
   drivers/net/tun.c:3227:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/net/tun.c:3227:21: sparse:     expected int const *__gu_addr
   drivers/net/tun.c:3227:21: sparse:     got int [noderef] __user *
   drivers/net/tun.c:3227:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/tun.c:3227:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/tun.c:3227:21: sparse:     got int const *__gu_addr
--
   drivers/net/hamradio/6pack.c:710:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/net/hamradio/6pack.c:710:21: sparse:     expected int const *__gu_addr
   drivers/net/hamradio/6pack.c:710:21: sparse:     got int [noderef] __user *
>> drivers/net/hamradio/6pack.c:710:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> drivers/net/hamradio/6pack.c:710:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/hamradio/6pack.c:710:21: sparse:     got int const *__gu_addr
--
   drivers/net/ppp/ppp_async.c:420:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_async.c:420:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_async.c:420:21: sparse:     got int [noderef] __user *p
>> drivers/net/ppp/ppp_async.c:420:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> drivers/net/ppp/ppp_async.c:420:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_async.c:420:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_async.c:435:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/net/ppp/ppp_async.c:435:21: sparse:     expected unsigned int const *__gu_addr
   drivers/net/ppp/ppp_async.c:435:21: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/net/ppp/ppp_async.c:435:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/net/ppp/ppp_async.c:435:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_async.c:435:21: sparse:     got unsigned int const *__gu_addr
   drivers/net/ppp/ppp_async.c:446:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/net/ppp/ppp_async.c:446:21: sparse:     expected unsigned int const *__gu_addr
   drivers/net/ppp/ppp_async.c:446:21: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/net/ppp/ppp_async.c:446:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/net/ppp/ppp_async.c:446:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_async.c:446:21: sparse:     got unsigned int const *__gu_addr
   drivers/net/ppp/ppp_async.c:471:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_async.c:471:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_async.c:471:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_async.c:471:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_async.c:471:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_async.c:471:21: sparse:     got int const *__gu_addr
--
   drivers/net/ppp/pppoe.c:765:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/net/ppp/pppoe.c:765:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/pppoe.c:765:21: sparse:     got int [noderef] __user *
>> drivers/net/ppp/pppoe.c:765:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> drivers/net/ppp/pppoe.c:765:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/pppoe.c:765:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/pppoe.c:778:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/net/ppp/pppoe.c:778:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/pppoe.c:778:21: sparse:     got int [noderef] __user *
   drivers/net/ppp/pppoe.c:778:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/pppoe.c:778:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/pppoe.c:778:21: sparse:     got int const *__gu_addr
--
   drivers/net/ppp/ppp_generic.c:925:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     got int [noderef] __user *p
>> drivers/net/ppp/ppp_generic.c:925:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> drivers/net/ppp/ppp_generic.c:925:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:939:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:939:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:954:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:954:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:651:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:651:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:681:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:681:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:688:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:688:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:726:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:726:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:755:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:755:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:823:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:823:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     got int const *__gu_addr
--
   drivers/usb/core/devio.c:313:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] *p @@     got restricted __le16 * @@
   drivers/usb/core/devio.c:313:17: sparse:     expected unsigned short [usertype] *p
   drivers/usb/core/devio.c:313:17: sparse:     got restricted __le16 *
   drivers/usb/core/devio.c:314:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] *p @@     got restricted __le16 * @@
   drivers/usb/core/devio.c:314:17: sparse:     expected unsigned short [usertype] *p
   drivers/usb/core/devio.c:314:17: sparse:     got restricted __le16 *
   drivers/usb/core/devio.c:315:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] *p @@     got restricted __le16 * @@
   drivers/usb/core/devio.c:315:17: sparse:     expected unsigned short [usertype] *p
   drivers/usb/core/devio.c:315:17: sparse:     got restricted __le16 *
   drivers/usb/core/devio.c:316:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] *p @@     got restricted __le16 * @@
   drivers/usb/core/devio.c:316:17: sparse:     expected unsigned short [usertype] *p
   drivers/usb/core/devio.c:316:17: sparse:     got restricted __le16 *
   drivers/usb/core/devio.c:937:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:937:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:937:13: sparse:     got unsigned int [noderef] __user *
>> drivers/usb/core/devio.c:937:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
>> drivers/usb/core/devio.c:937:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:937:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:938:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:938:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:938:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:938:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:938:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:938:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:953:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] __user * @@
   drivers/usb/core/devio.c:953:21: sparse:     expected unsigned char const *__gu_addr
   drivers/usb/core/devio.c:953:21: sparse:     got unsigned char [noderef] __user *
>> drivers/usb/core/devio.c:953:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__gu_addr @@
   drivers/usb/core/devio.c:953:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:953:21: sparse:     got unsigned char const *__gu_addr
   drivers/usb/core/devio.c:1290:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:1290:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:1290:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:1290:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:1290:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:1290:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:1309:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:1309:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:1309:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:1309:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:1309:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:1309:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:1441:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/usb/core/devio.c:1441:13: sparse:     expected int const *__gu_addr
   drivers/usb/core/devio.c:1441:13: sparse:     got int [noderef] __user *
>> drivers/usb/core/devio.c:1441:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/usb/core/devio.c:1441:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:1441:13: sparse:     got int const *__gu_addr
   drivers/usb/core/devio.c:2189:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:2189:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2189:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:2189:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:2189:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2189:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2199:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:2199:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2199:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:2199:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:2199:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2199:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2315:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:2315:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2315:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:2315:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:2315:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2315:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2328:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:2328:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2328:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:2328:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:2328:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2328:13: sparse:     got unsigned int const *__gu_addr

vim +780 drivers/usb/misc/sisusbvga/sisusb.c

^1da177e4c3f415 Linus Torvalds       2005-04-16  743  
^1da177e4c3f415 Linus Torvalds       2005-04-16  744  /* The xxx_bulk routines copy a buffer of variable size. They treat the
^1da177e4c3f415 Linus Torvalds       2005-04-16  745   * buffer as chars, therefore lsb/msb has to be corrected if using the
^1da177e4c3f415 Linus Torvalds       2005-04-16  746   * byte/word/long/etc routines for speed-up
^1da177e4c3f415 Linus Torvalds       2005-04-16  747   *
^1da177e4c3f415 Linus Torvalds       2005-04-16  748   * If data is from userland, set "userbuffer" (and clear "kernbuffer"),
^1da177e4c3f415 Linus Torvalds       2005-04-16  749   * if data is in kernel space, set "kernbuffer" (and clear "userbuffer");
^1da177e4c3f415 Linus Torvalds       2005-04-16  750   * if neither "kernbuffer" nor "userbuffer" are given, it is assumed
^1da177e4c3f415 Linus Torvalds       2005-04-16  751   * that the data already is in the transfer buffer "sisusb->obuf[index]".
^1da177e4c3f415 Linus Torvalds       2005-04-16  752   */
^1da177e4c3f415 Linus Torvalds       2005-04-16  753  
^1da177e4c3f415 Linus Torvalds       2005-04-16  754  static int sisusb_write_mem_bulk(struct sisusb_usb_data *sisusb, u32 addr,
06e21efa2d344b5 Peter Senna Tschudin 2016-01-15  755  		char *kernbuffer, int length, const char __user *userbuffer,
06e21efa2d344b5 Peter Senna Tschudin 2016-01-15  756  		int index, ssize_t *bytes_written)
^1da177e4c3f415 Linus Torvalds       2005-04-16  757  {
^1da177e4c3f415 Linus Torvalds       2005-04-16  758  	struct sisusb_packet packet;
^1da177e4c3f415 Linus Torvalds       2005-04-16  759  	int  ret = 0;
f996c49d4fa4e8e Peter Senna Tschudin 2016-01-15  760  	static int msgcount;
^1da177e4c3f415 Linus Torvalds       2005-04-16  761  	u8   swap8, fromkern = kernbuffer ? 1 : 0;
^1da177e4c3f415 Linus Torvalds       2005-04-16  762  	u16  swap16;
^1da177e4c3f415 Linus Torvalds       2005-04-16  763  	u32  swap32, flag = (length >> 28) & 1;
2b53a19284f5371 Changming Liu        2020-07-11  764  	u8 buf[4];
^1da177e4c3f415 Linus Torvalds       2005-04-16  765  
^1da177e4c3f415 Linus Torvalds       2005-04-16  766  	/* if neither kernbuffer not userbuffer are given, assume
^1da177e4c3f415 Linus Torvalds       2005-04-16  767  	 * data in obuf
^1da177e4c3f415 Linus Torvalds       2005-04-16  768  	 */
^1da177e4c3f415 Linus Torvalds       2005-04-16  769  	if (!fromkern && !userbuffer)
^1da177e4c3f415 Linus Torvalds       2005-04-16  770  		kernbuffer = sisusb->obuf[index];
^1da177e4c3f415 Linus Torvalds       2005-04-16  771  
^1da177e4c3f415 Linus Torvalds       2005-04-16  772  	(*bytes_written = 0);
^1da177e4c3f415 Linus Torvalds       2005-04-16  773  
^1da177e4c3f415 Linus Torvalds       2005-04-16  774  	length &= 0x00ffffff;
^1da177e4c3f415 Linus Torvalds       2005-04-16  775  
^1da177e4c3f415 Linus Torvalds       2005-04-16  776  	while (length) {
^1da177e4c3f415 Linus Torvalds       2005-04-16  777  		switch (length) {
^1da177e4c3f415 Linus Torvalds       2005-04-16  778  		case 1:
^1da177e4c3f415 Linus Torvalds       2005-04-16  779  			if (userbuffer) {
^1da177e4c3f415 Linus Torvalds       2005-04-16 @780  				if (get_user(swap8, (u8 __user *)userbuffer))
^1da177e4c3f415 Linus Torvalds       2005-04-16  781  					return -EFAULT;
^1da177e4c3f415 Linus Torvalds       2005-04-16  782  			} else
^1da177e4c3f415 Linus Torvalds       2005-04-16  783  				swap8 = kernbuffer[0];
^1da177e4c3f415 Linus Torvalds       2005-04-16  784  
06e21efa2d344b5 Peter Senna Tschudin 2016-01-15  785  			ret = sisusb_write_memio_byte(sisusb, SISUSB_TYPE_MEM,
^1da177e4c3f415 Linus Torvalds       2005-04-16  786  					addr, swap8);
^1da177e4c3f415 Linus Torvalds       2005-04-16  787  
^1da177e4c3f415 Linus Torvalds       2005-04-16  788  			if (!ret)
^1da177e4c3f415 Linus Torvalds       2005-04-16  789  				(*bytes_written)++;
^1da177e4c3f415 Linus Torvalds       2005-04-16  790  
^1da177e4c3f415 Linus Torvalds       2005-04-16  791  			return ret;
^1da177e4c3f415 Linus Torvalds       2005-04-16  792  
^1da177e4c3f415 Linus Torvalds       2005-04-16  793  		case 2:
^1da177e4c3f415 Linus Torvalds       2005-04-16  794  			if (userbuffer) {
^1da177e4c3f415 Linus Torvalds       2005-04-16 @795  				if (get_user(swap16, (u16 __user *)userbuffer))
^1da177e4c3f415 Linus Torvalds       2005-04-16  796  					return -EFAULT;
^1da177e4c3f415 Linus Torvalds       2005-04-16  797  			} else
1bbb4f2035d94d8 Thomas Winischhofer  2005-08-29  798  				swap16 = *((u16 *)kernbuffer);
^1da177e4c3f415 Linus Torvalds       2005-04-16  799  
06e21efa2d344b5 Peter Senna Tschudin 2016-01-15  800  			ret = sisusb_write_memio_word(sisusb, SISUSB_TYPE_MEM,
06e21efa2d344b5 Peter Senna Tschudin 2016-01-15  801  					addr, swap16);
^1da177e4c3f415 Linus Torvalds       2005-04-16  802  
^1da177e4c3f415 Linus Torvalds       2005-04-16  803  			if (!ret)
^1da177e4c3f415 Linus Torvalds       2005-04-16  804  				(*bytes_written) += 2;
^1da177e4c3f415 Linus Torvalds       2005-04-16  805  
^1da177e4c3f415 Linus Torvalds       2005-04-16  806  			return ret;
^1da177e4c3f415 Linus Torvalds       2005-04-16  807  
^1da177e4c3f415 Linus Torvalds       2005-04-16  808  		case 3:
^1da177e4c3f415 Linus Torvalds       2005-04-16  809  			if (userbuffer) {
^1da177e4c3f415 Linus Torvalds       2005-04-16  810  				if (copy_from_user(&buf, userbuffer, 3))
^1da177e4c3f415 Linus Torvalds       2005-04-16  811  					return -EFAULT;
1bbb4f2035d94d8 Thomas Winischhofer  2005-08-29  812  #ifdef __BIG_ENDIAN
^1da177e4c3f415 Linus Torvalds       2005-04-16  813  				swap32 = (buf[0] << 16) |
^1da177e4c3f415 Linus Torvalds       2005-04-16  814  					 (buf[1] <<  8) |
^1da177e4c3f415 Linus Torvalds       2005-04-16  815  					 buf[2];
1bbb4f2035d94d8 Thomas Winischhofer  2005-08-29  816  #else
1bbb4f2035d94d8 Thomas Winischhofer  2005-08-29  817  				swap32 = (buf[2] << 16) |
1bbb4f2035d94d8 Thomas Winischhofer  2005-08-29  818  					 (buf[1] <<  8) |
1bbb4f2035d94d8 Thomas Winischhofer  2005-08-29  819  					 buf[0];
1bbb4f2035d94d8 Thomas Winischhofer  2005-08-29  820  #endif
^1da177e4c3f415 Linus Torvalds       2005-04-16  821  			} else
1bbb4f2035d94d8 Thomas Winischhofer  2005-08-29  822  #ifdef __BIG_ENDIAN
^1da177e4c3f415 Linus Torvalds       2005-04-16  823  				swap32 = (kernbuffer[0] << 16) |
^1da177e4c3f415 Linus Torvalds       2005-04-16  824  					 (kernbuffer[1] <<  8) |
^1da177e4c3f415 Linus Torvalds       2005-04-16  825  					 kernbuffer[2];
1bbb4f2035d94d8 Thomas Winischhofer  2005-08-29  826  #else
1bbb4f2035d94d8 Thomas Winischhofer  2005-08-29  827  				swap32 = (kernbuffer[2] << 16) |
1bbb4f2035d94d8 Thomas Winischhofer  2005-08-29  828  					 (kernbuffer[1] <<  8) |
1bbb4f2035d94d8 Thomas Winischhofer  2005-08-29  829  					 kernbuffer[0];
1bbb4f2035d94d8 Thomas Winischhofer  2005-08-29  830  #endif
^1da177e4c3f415 Linus Torvalds       2005-04-16  831  
06e21efa2d344b5 Peter Senna Tschudin 2016-01-15  832  			ret = sisusb_write_memio_24bit(sisusb, SISUSB_TYPE_MEM,
06e21efa2d344b5 Peter Senna Tschudin 2016-01-15  833  					addr, swap32);
^1da177e4c3f415 Linus Torvalds       2005-04-16  834  
^1da177e4c3f415 Linus Torvalds       2005-04-16  835  			if (!ret)
^1da177e4c3f415 Linus Torvalds       2005-04-16  836  				(*bytes_written) += 3;
^1da177e4c3f415 Linus Torvalds       2005-04-16  837  
^1da177e4c3f415 Linus Torvalds       2005-04-16  838  			return ret;
^1da177e4c3f415 Linus Torvalds       2005-04-16  839  
^1da177e4c3f415 Linus Torvalds       2005-04-16  840  		case 4:
^1da177e4c3f415 Linus Torvalds       2005-04-16  841  			if (userbuffer) {
^1da177e4c3f415 Linus Torvalds       2005-04-16 @842  				if (get_user(swap32, (u32 __user *)userbuffer))
^1da177e4c3f415 Linus Torvalds       2005-04-16  843  					return -EFAULT;
^1da177e4c3f415 Linus Torvalds       2005-04-16  844  			} else
1bbb4f2035d94d8 Thomas Winischhofer  2005-08-29  845  				swap32 = *((u32 *)kernbuffer);
^1da177e4c3f415 Linus Torvalds       2005-04-16  846  
06e21efa2d344b5 Peter Senna Tschudin 2016-01-15  847  			ret = sisusb_write_memio_long(sisusb, SISUSB_TYPE_MEM,
06e21efa2d344b5 Peter Senna Tschudin 2016-01-15  848  					addr, swap32);
^1da177e4c3f415 Linus Torvalds       2005-04-16  849  			if (!ret)
^1da177e4c3f415 Linus Torvalds       2005-04-16  850  				(*bytes_written) += 4;
^1da177e4c3f415 Linus Torvalds       2005-04-16  851  
^1da177e4c3f415 Linus Torvalds       2005-04-16  852  			return ret;
^1da177e4c3f415 Linus Torvalds       2005-04-16  853  
^1da177e4c3f415 Linus Torvalds       2005-04-16  854  		default:
^1da177e4c3f415 Linus Torvalds       2005-04-16  855  			if ((length & ~3) > 0x10000) {
^1da177e4c3f415 Linus Torvalds       2005-04-16  856  
^1da177e4c3f415 Linus Torvalds       2005-04-16  857  				packet.header  = 0x001f;
^1da177e4c3f415 Linus Torvalds       2005-04-16  858  				packet.address = 0x000001d4;
^1da177e4c3f415 Linus Torvalds       2005-04-16  859  				packet.data    = addr;
^1da177e4c3f415 Linus Torvalds       2005-04-16  860  				ret = sisusb_send_bridge_packet(sisusb, 10,
^1da177e4c3f415 Linus Torvalds       2005-04-16  861  						&packet, 0);
^1da177e4c3f415 Linus Torvalds       2005-04-16  862  				packet.header  = 0x001f;
^1da177e4c3f415 Linus Torvalds       2005-04-16  863  				packet.address = 0x000001d0;
^1da177e4c3f415 Linus Torvalds       2005-04-16  864  				packet.data    = (length & ~3);
^1da177e4c3f415 Linus Torvalds       2005-04-16  865  				ret |= sisusb_send_bridge_packet(sisusb, 10,
^1da177e4c3f415 Linus Torvalds       2005-04-16  866  						&packet, 0);
^1da177e4c3f415 Linus Torvalds       2005-04-16  867  				packet.header  = 0x001f;
^1da177e4c3f415 Linus Torvalds       2005-04-16  868  				packet.address = 0x000001c0;
^1da177e4c3f415 Linus Torvalds       2005-04-16  869  				packet.data    = flag | 0x16;
^1da177e4c3f415 Linus Torvalds       2005-04-16  870  				ret |= sisusb_send_bridge_packet(sisusb, 10,
^1da177e4c3f415 Linus Torvalds       2005-04-16  871  						&packet, 0);
^1da177e4c3f415 Linus Torvalds       2005-04-16  872  				if (userbuffer) {
^1da177e4c3f415 Linus Torvalds       2005-04-16  873  					ret |= sisusb_send_bulk_msg(sisusb,
^1da177e4c3f415 Linus Torvalds       2005-04-16  874  							SISUSB_EP_GFX_LBULK_OUT,
^1da177e4c3f415 Linus Torvalds       2005-04-16  875  							(length & ~3),
^1da177e4c3f415 Linus Torvalds       2005-04-16  876  							NULL, userbuffer, 0,
^1da177e4c3f415 Linus Torvalds       2005-04-16  877  							bytes_written, 0, 1);
^1da177e4c3f415 Linus Torvalds       2005-04-16  878  					userbuffer += (*bytes_written);
^1da177e4c3f415 Linus Torvalds       2005-04-16  879  				} else if (fromkern) {
^1da177e4c3f415 Linus Torvalds       2005-04-16  880  					ret |= sisusb_send_bulk_msg(sisusb,
^1da177e4c3f415 Linus Torvalds       2005-04-16  881  							SISUSB_EP_GFX_LBULK_OUT,
^1da177e4c3f415 Linus Torvalds       2005-04-16  882  							(length & ~3),
^1da177e4c3f415 Linus Torvalds       2005-04-16  883  							kernbuffer, NULL, 0,
^1da177e4c3f415 Linus Torvalds       2005-04-16  884  							bytes_written, 0, 1);
^1da177e4c3f415 Linus Torvalds       2005-04-16  885  					kernbuffer += (*bytes_written);
^1da177e4c3f415 Linus Torvalds       2005-04-16  886  				} else {
^1da177e4c3f415 Linus Torvalds       2005-04-16  887  					ret |= sisusb_send_bulk_msg(sisusb,
^1da177e4c3f415 Linus Torvalds       2005-04-16  888  							SISUSB_EP_GFX_LBULK_OUT,
^1da177e4c3f415 Linus Torvalds       2005-04-16  889  							(length & ~3),
^1da177e4c3f415 Linus Torvalds       2005-04-16  890  							NULL, NULL, index,
^1da177e4c3f415 Linus Torvalds       2005-04-16  891  							bytes_written, 0, 1);
^1da177e4c3f415 Linus Torvalds       2005-04-16  892  					kernbuffer += ((*bytes_written) &
^1da177e4c3f415 Linus Torvalds       2005-04-16  893  							(sisusb->obufsize-1));
^1da177e4c3f415 Linus Torvalds       2005-04-16  894  				}
^1da177e4c3f415 Linus Torvalds       2005-04-16  895  
^1da177e4c3f415 Linus Torvalds       2005-04-16  896  			} else {
^1da177e4c3f415 Linus Torvalds       2005-04-16  897  
^1da177e4c3f415 Linus Torvalds       2005-04-16  898  				packet.header  = 0x001f;
^1da177e4c3f415 Linus Torvalds       2005-04-16  899  				packet.address = 0x00000194;
^1da177e4c3f415 Linus Torvalds       2005-04-16  900  				packet.data    = addr;
^1da177e4c3f415 Linus Torvalds       2005-04-16  901  				ret = sisusb_send_bridge_packet(sisusb, 10,
^1da177e4c3f415 Linus Torvalds       2005-04-16  902  						&packet, 0);
^1da177e4c3f415 Linus Torvalds       2005-04-16  903  				packet.header  = 0x001f;
^1da177e4c3f415 Linus Torvalds       2005-04-16  904  				packet.address = 0x00000190;
^1da177e4c3f415 Linus Torvalds       2005-04-16  905  				packet.data    = (length & ~3);
^1da177e4c3f415 Linus Torvalds       2005-04-16  906  				ret |= sisusb_send_bridge_packet(sisusb, 10,
^1da177e4c3f415 Linus Torvalds       2005-04-16  907  						&packet, 0);
^1da177e4c3f415 Linus Torvalds       2005-04-16  908  				if (sisusb->flagb0 != 0x16) {
^1da177e4c3f415 Linus Torvalds       2005-04-16  909  					packet.header  = 0x001f;
^1da177e4c3f415 Linus Torvalds       2005-04-16  910  					packet.address = 0x00000180;
^1da177e4c3f415 Linus Torvalds       2005-04-16  911  					packet.data    = flag | 0x16;
f74a039c7e0bf6b Peter Senna Tschudin 2016-01-15  912  					ret |= sisusb_send_bridge_packet(sisusb,
f74a039c7e0bf6b Peter Senna Tschudin 2016-01-15  913  							10, &packet, 0);
^1da177e4c3f415 Linus Torvalds       2005-04-16  914  					sisusb->flagb0 = 0x16;
^1da177e4c3f415 Linus Torvalds       2005-04-16  915  				}
^1da177e4c3f415 Linus Torvalds       2005-04-16  916  				if (userbuffer) {
^1da177e4c3f415 Linus Torvalds       2005-04-16  917  					ret |= sisusb_send_bulk_msg(sisusb,
^1da177e4c3f415 Linus Torvalds       2005-04-16  918  							SISUSB_EP_GFX_BULK_OUT,
^1da177e4c3f415 Linus Torvalds       2005-04-16  919  							(length & ~3),
^1da177e4c3f415 Linus Torvalds       2005-04-16  920  							NULL, userbuffer, 0,
^1da177e4c3f415 Linus Torvalds       2005-04-16  921  							bytes_written, 0, 1);
^1da177e4c3f415 Linus Torvalds       2005-04-16  922  					userbuffer += (*bytes_written);
^1da177e4c3f415 Linus Torvalds       2005-04-16  923  				} else if (fromkern) {
^1da177e4c3f415 Linus Torvalds       2005-04-16  924  					ret |= sisusb_send_bulk_msg(sisusb,
^1da177e4c3f415 Linus Torvalds       2005-04-16  925  							SISUSB_EP_GFX_BULK_OUT,
^1da177e4c3f415 Linus Torvalds       2005-04-16  926  							(length & ~3),
^1da177e4c3f415 Linus Torvalds       2005-04-16  927  							kernbuffer, NULL, 0,
^1da177e4c3f415 Linus Torvalds       2005-04-16  928  							bytes_written, 0, 1);
^1da177e4c3f415 Linus Torvalds       2005-04-16  929  					kernbuffer += (*bytes_written);
^1da177e4c3f415 Linus Torvalds       2005-04-16  930  				} else {
^1da177e4c3f415 Linus Torvalds       2005-04-16  931  					ret |= sisusb_send_bulk_msg(sisusb,
^1da177e4c3f415 Linus Torvalds       2005-04-16  932  							SISUSB_EP_GFX_BULK_OUT,
^1da177e4c3f415 Linus Torvalds       2005-04-16  933  							(length & ~3),
^1da177e4c3f415 Linus Torvalds       2005-04-16  934  							NULL, NULL, index,
^1da177e4c3f415 Linus Torvalds       2005-04-16  935  							bytes_written, 0, 1);
^1da177e4c3f415 Linus Torvalds       2005-04-16  936  					kernbuffer += ((*bytes_written) &
^1da177e4c3f415 Linus Torvalds       2005-04-16  937  							(sisusb->obufsize-1));
^1da177e4c3f415 Linus Torvalds       2005-04-16  938  				}
^1da177e4c3f415 Linus Torvalds       2005-04-16  939  			}
^1da177e4c3f415 Linus Torvalds       2005-04-16  940  			if (ret) {
^1da177e4c3f415 Linus Torvalds       2005-04-16  941  				msgcount++;
^1da177e4c3f415 Linus Torvalds       2005-04-16  942  				if (msgcount < 500)
06e21efa2d344b5 Peter Senna Tschudin 2016-01-15  943  					dev_err(&sisusb->sisusb_dev->dev,
06e21efa2d344b5 Peter Senna Tschudin 2016-01-15  944  							"Wrote %zd of %d bytes, error %d\n",
06e21efa2d344b5 Peter Senna Tschudin 2016-01-15  945  							*bytes_written, length,
06e21efa2d344b5 Peter Senna Tschudin 2016-01-15  946  							ret);
^1da177e4c3f415 Linus Torvalds       2005-04-16  947  				else if (msgcount == 500)
06e21efa2d344b5 Peter Senna Tschudin 2016-01-15  948  					dev_err(&sisusb->sisusb_dev->dev,
06e21efa2d344b5 Peter Senna Tschudin 2016-01-15  949  							"Too many errors, logging stopped\n");
^1da177e4c3f415 Linus Torvalds       2005-04-16  950  			}
^1da177e4c3f415 Linus Torvalds       2005-04-16  951  			addr += (*bytes_written);
^1da177e4c3f415 Linus Torvalds       2005-04-16  952  			length -= (*bytes_written);
^1da177e4c3f415 Linus Torvalds       2005-04-16  953  		}
^1da177e4c3f415 Linus Torvalds       2005-04-16  954  
^1da177e4c3f415 Linus Torvalds       2005-04-16  955  		if (ret)
^1da177e4c3f415 Linus Torvalds       2005-04-16  956  			break;
^1da177e4c3f415 Linus Torvalds       2005-04-16  957  
^1da177e4c3f415 Linus Torvalds       2005-04-16  958  	}
^1da177e4c3f415 Linus Torvalds       2005-04-16  959  
^1da177e4c3f415 Linus Torvalds       2005-04-16  960  	return ret ? -EIO : 0;
^1da177e4c3f415 Linus Torvalds       2005-04-16  961  }
^1da177e4c3f415 Linus Torvalds       2005-04-16  962  

:::::: The code at line 780 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--CE+1k2dSO48ffgeK
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--CE+1k2dSO48ffgeK--
