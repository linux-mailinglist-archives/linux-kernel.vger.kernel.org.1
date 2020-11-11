Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FE52AEA49
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgKKHoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:44:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:18852 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgKKHoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:44:00 -0500
IronPort-SDR: X8K9F4sfCCJCY+0M6GC9+9OcRh8vdvMjQ3zUFRk3mjYmmT50fcKS/ioURJogDN1Qr8Y3Dt+zSz
 qcS2nf12PjdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="157889220"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="gz'50?scan'50,208,50";a="157889220"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 23:43:56 -0800
IronPort-SDR: PxbaAQvMK3C6ZK5zMWZuNdUF7Cd5PeHOfe6bHTuPj+dJgAXtpa4cTi+OOyQX4eQ+08ARB7kqrA
 A3fU/5Z63LZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="gz'50?scan'50,208,50";a="327999087"
Received: from lkp-server02.sh.intel.com (HELO 898ef09051d7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Nov 2020 23:43:53 -0800
Received: from kbuild by 898ef09051d7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kcknJ-00005C-8Z; Wed, 11 Nov 2020 07:43:53 +0000
Date:   Wed, 11 Nov 2020 15:43:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: drivers/watchdog/pcwd_usb.c:375:37: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202011111537.wYFqMXfY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   eccc876724927ff3b9ff91f36f7b6b159e948f0c
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   2 months ago
config: sh-randconfig-s032-20201111 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-106-gd020cf33-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
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
   drivers/usb/misc/sisusbvga/sisusb.c:780:37: sparse:     expected void const volatile [noderef] __user *ptr
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

vim +375 drivers/watchdog/pcwd_usb.c

58b519f3e5e491d drivers/char/watchdog/pcwd_usb.c Wim Van Sebroeck    2006-05-21  354  
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  355  /*
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  356   *	/dev/watchdog handling
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  357   */
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  358  
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  359  static ssize_t usb_pcwd_write(struct file *file, const char __user *data,
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  360  						size_t len, loff_t *ppos)
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  361  {
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  362  	/* See if we got the magic character 'V' and reload the timer */
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  363  	if (len) {
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  364  		if (!nowayout) {
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  365  			size_t i;
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  366  
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  367  			/* note: just in case someone wrote the magic character
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  368  			 * five months ago... */
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  369  			expect_release = 0;
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  370  
143a2e54bf53216 drivers/watchdog/pcwd_usb.c      Wim Van Sebroeck    2009-03-18  371  			/* scan to see whether or not we got the
143a2e54bf53216 drivers/watchdog/pcwd_usb.c      Wim Van Sebroeck    2009-03-18  372  			 * magic character */
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  373  			for (i = 0; i != len; i++) {
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  374  				char c;
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16 @375  				if (get_user(c, data + i))
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  376  					return -EFAULT;
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  377  				if (c == 'V')
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  378  					expect_release = 42;
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  379  			}
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  380  		}
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  381  
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  382  		/* someone wrote to us, we should reload the timer */
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  383  		usb_pcwd_keepalive(usb_pcwd_device);
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  384  	}
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  385  	return len;
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  386  }
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  387  
c9488520512df65 drivers/watchdog/pcwd_usb.c      Alan Cox            2008-07-03  388  static long usb_pcwd_ioctl(struct file *file, unsigned int cmd,
c9488520512df65 drivers/watchdog/pcwd_usb.c      Alan Cox            2008-07-03  389  						unsigned long arg)
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  390  {
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  391  	void __user *argp = (void __user *)arg;
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  392  	int __user *p = argp;
42747d712de56cf drivers/watchdog/pcwd_usb.c      Wim Van Sebroeck    2009-12-26  393  	static const struct watchdog_info ident = {
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  394  		.options =		WDIOF_KEEPALIVEPING |
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  395  					WDIOF_SETTIMEOUT |
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  396  					WDIOF_MAGICCLOSE,
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  397  		.firmware_version =	1,
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  398  		.identity =		DRIVER_NAME,
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  399  	};
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  400  
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  401  	switch (cmd) {
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  402  	case WDIOC_GETSUPPORT:
7944d3a5a70ee5c drivers/watchdog/pcwd_usb.c      Wim Van Sebroeck    2008-08-06  403  		return copy_to_user(argp, &ident, sizeof(ident)) ? -EFAULT : 0;
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  404  
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  405  	case WDIOC_GETSTATUS:
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  406  	case WDIOC_GETBOOTSTATUS:
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  407  		return put_user(0, p);
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  408  
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  409  	case WDIOC_GETTEMP:
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  410  	{
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  411  		int temperature;
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  412  
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  413  		if (usb_pcwd_get_temperature(usb_pcwd_device, &temperature))
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  414  			return -EFAULT;
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  415  
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  416  		return put_user(temperature, p);
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  417  	}
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  418  
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  419  	case WDIOC_SETOPTIONS:
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  420  	{
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  421  		int new_options, retval = -EINVAL;
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  422  
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16 @423  		if (get_user(new_options, p))
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  424  			return -EFAULT;
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  425  
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  426  		if (new_options & WDIOS_DISABLECARD) {
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  427  			usb_pcwd_stop(usb_pcwd_device);
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  428  			retval = 0;
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  429  		}
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  430  
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  431  		if (new_options & WDIOS_ENABLECARD) {
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  432  			usb_pcwd_start(usb_pcwd_device);
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  433  			retval = 0;
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  434  		}
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  435  
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  436  		return retval;
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  437  	}
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  438  
0c06090c9472db0 drivers/watchdog/pcwd_usb.c      Wim Van Sebroeck    2008-07-18  439  	case WDIOC_KEEPALIVE:
0c06090c9472db0 drivers/watchdog/pcwd_usb.c      Wim Van Sebroeck    2008-07-18  440  		usb_pcwd_keepalive(usb_pcwd_device);
0c06090c9472db0 drivers/watchdog/pcwd_usb.c      Wim Van Sebroeck    2008-07-18  441  		return 0;
0c06090c9472db0 drivers/watchdog/pcwd_usb.c      Wim Van Sebroeck    2008-07-18  442  
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  443  	case WDIOC_SETTIMEOUT:
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  444  	{
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  445  		int new_heartbeat;
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  446  
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  447  		if (get_user(new_heartbeat, p))
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  448  			return -EFAULT;
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  449  
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  450  		if (usb_pcwd_set_heartbeat(usb_pcwd_device, new_heartbeat))
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  451  			return -EINVAL;
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  452  
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  453  		usb_pcwd_keepalive(usb_pcwd_device);
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  454  	}
bd490f8222510de drivers/watchdog/pcwd_usb.c      Gustavo A. R. Silva 2020-07-07  455  		fallthrough;
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  456  
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  457  	case WDIOC_GETTIMEOUT:
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  458  		return put_user(heartbeat, p);
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  459  
58b519f3e5e491d drivers/char/watchdog/pcwd_usb.c Wim Van Sebroeck    2006-05-21  460  	case WDIOC_GETTIMELEFT:
58b519f3e5e491d drivers/char/watchdog/pcwd_usb.c Wim Van Sebroeck    2006-05-21  461  	{
58b519f3e5e491d drivers/char/watchdog/pcwd_usb.c Wim Van Sebroeck    2006-05-21  462  		int time_left;
58b519f3e5e491d drivers/char/watchdog/pcwd_usb.c Wim Van Sebroeck    2006-05-21  463  
58b519f3e5e491d drivers/char/watchdog/pcwd_usb.c Wim Van Sebroeck    2006-05-21  464  		if (usb_pcwd_get_timeleft(usb_pcwd_device, &time_left))
58b519f3e5e491d drivers/char/watchdog/pcwd_usb.c Wim Van Sebroeck    2006-05-21  465  			return -EFAULT;
58b519f3e5e491d drivers/char/watchdog/pcwd_usb.c Wim Van Sebroeck    2006-05-21  466  
58b519f3e5e491d drivers/char/watchdog/pcwd_usb.c Wim Van Sebroeck    2006-05-21  467  		return put_user(time_left, p);
58b519f3e5e491d drivers/char/watchdog/pcwd_usb.c Wim Van Sebroeck    2006-05-21  468  	}
58b519f3e5e491d drivers/char/watchdog/pcwd_usb.c Wim Van Sebroeck    2006-05-21  469  
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  470  	default:
795b89d207d8ff5 drivers/char/watchdog/pcwd_usb.c Samuel Tardieu      2006-09-09  471  		return -ENOTTY;
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  472  	}
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  473  }
^1da177e4c3f415 drivers/char/watchdog/pcwd_usb.c Linus Torvalds      2005-04-16  474  

:::::: The code at line 375 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--tThc/1wpZn/ma/RB
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICHCMq18AAy5jb25maWcAnDzbcuM4ru/7FaqeqlO7Dz3jOOl0UqfyQEuUxbEkqkXKcfKi
cjvuadek46ztzEz//QGoGylDjut01e4kAHgDARA35Zd//eKxt8P2x/KwWS2fn396f6xf1rvl
Yf3kfds8r//XC6SXSu3xQOhfgTjevLz989v+u/fp19tfRx93q7E3W+9e1s+ev335tvnjDcZu
ti//+uVfvkxDMS19v5zzXAmZlpov9N2H/ferj884y8c/Vivv31Pf/493++vlr6MP1hChSkDc
/WxA026au9vR5WjUIOKghY8vr0bmXztPzNJpix5Z00dMlUwl5VRq2S1iIUQai5R3KJF/Ke9l
PgMIHO0Xb2q49Ozt14e31+6wk1zOeFrCWVWSWaNToUuezkuWw45FIvTd5RhmadaVSSZiDvxR
2tvsvZftASdujyh9Fjen+PCBApessA8yKQTwRbFYW/QRm/NyxvOUx+X0UVjbszETwIxpVPyY
MBqzeBwagZtqz2ktThyzt4H+KFzdHtXHLx5PYWEnxJIBD1kRa3M/FqcacCSVTlnC7z78+2X7
sv7Ph25a9aDmIvPJJTOpxKJMvhS84MSi90z7UWmw9jELxWMxISdkBSgfMZNhNcthNkMBewKJ
iBsRBZH19m9f9z/3h/WPTkQT9lANVBnLFUfJttSMpzwXvhF3Fcl7GiPS37mvURpJtB/ZwoWQ
QCZMpC5MicQFhDL3eVDqKOcsEOm0w76304BPimmoDDfXL0/e9lvv8P1BPujOjM95qlXDLb35
sd7tKYZFj2UGo2QgfPu+UokYEcScvDODJjGRmEZlzlWpRQLa69LU2z/ajSVdOedJpmGBlF65
IZjLuEg1yx8IyalpOnY2g3wJY47A1VUbPvlZ8Zte7v/0DrBFbwnb3R+Wh723XK22by+Hzcsf
Hee08GclDCiZb+atLrXd6EQFsID0uVJIocnTaKZmSjOt6LMqQfLvjF2a0+R+4anjK9dw7BJw
x/ypgO368GvJFyAelHoqZwYzZw+EZzNz1IJJoI5ARcApuM6Z30PgxMC6OMYHJrG1FTEpB2VT
fOpPYqG0rTsuU1oVnVU/WEo7a5kjHdUQswhUuCfb7auFz1MI1kWE+m486hgsUj2DNyvkPZqL
y776Kj+CvRslbsRSrb6vn96e1zvv23p5eNut9wZcn4jAtm/+NJdFpuztJzzxp6S4VcTV+qcI
MhHQ8lrj82DgLavxIcjKI89PkQR8LnzaANQUoAODWtXsk+fh6UXAsNLmDZ5FMMugu/T4iPuz
TMKVoqXTMqd3Wl0k+i5mPZrmQYUKdgIa6DM9wPecx4yyc5N4hpwyD3weuA5ZzhKYWMkCnh3r
8c+DxjvqZg8qr4RYAFCuWwQA4w3Zg3vOh4u6GkI9Kh1QR5ISzXStih3H/VKCoU7EI8eX1Fyt
zBOW+pQP0qdW8IP13oIjoeOeS1eI4OLacjGzsPulMoHd7z3aBJwpAf5Nbi0x5ToBw1V2Tkvv
xmsEsfkwYik8u/aQyuU6flAd42Jbc2Ns0kTYPrNl2ngcAo9ziycTBh5IWMQWW8ICAprer6D6
Pb5VYD/JFn5kr5BJey4lpimLQ0tEzWEMoD2l8VhCSiiYcBxtIcsCjjilKIO5gJPU3O3bvQnL
c+EansaPRuqHRHUbbCAlsw/SQg3DUC+1mDt3BZJz4nJhDzwIeNDjIopz2XpszTUiEOSqnCcw
mfsGZf7FyFEt8x7UoWq23n3b7n4sX1Zrj/+1fgHPgMFL4aNvAH5X5wiQyxqrSC9evzdnLtNM
OE+qNSrvC0TYUWwIDpmGyHJGm8eY0UGDiosJ5ZTEcmKJHYyGe8+nvAl6HEWMijCEuDRjgDeH
ZGDKiUmThGWG4L4sUrStgsVgURzhBSchFDEtlMZ5Mc+F48S7QXa75wJYHx1HAo4CN8DonoO7
bZkmcIj8WeUswUSZtM0WOhTw0BwjwJkXEkEQPVmhTTbVbAL8ieH2QJXGtSti/Cbv8PN1bWVB
wAtWkRVY1wDmXDXCiol+yGBz0efri1v6cbXIfh+/SwIzjUcX1CPQJ7o8sZnx6Pqsla4vzyOj
n70jsvc5kCwGfDV3qs+jT+eRnXXMz6PP55HdnEf2/jGR7GJ0HtlZMgE3eh7ZxVlkn86abXR7
7mwDzu8R3YD/2ac7c9mL85a9PuewV+V4dOZNnKUzn8dn6czny/PIPp0nwefpM4jwWWQ3Z5Kd
p6s35+jq4qwDXF6deQdn3ejltbMz8ywk6x/b3U8PvIHlH+sf4Ax421fMlNveBr6zMgwV13ej
f0YjN5tt8mPwAC3KR5lymUOAfXdx1T7BPJH5Az5vuRl84w5u0OjnA7aXKL8cT4T13JmUYgie
G4wqeYpvXA9ZZeTOQHdehYPnMfd1s6lEBtzyIIvUZyYuhLc266WMDIfwEOXVjPJuOvzNbEIP
vLie0Q5TR3J91SepHZLhO6xyY8vV97W36tVBOiHBY5X3udB8Ak4ILUgdjY4gJp5G1MNtiEBQ
bGeJWtysnu22q/V+v+2lRizJjYXW4MbwNBAsHXAUJuibGwLLlwIpyQrXp8ECSgVsd0ZswOxg
sl3unrz92+vrdnfotABm9QulZVL68cx1R8tczciLcafqErom9bd63q7+PLqWbtIM1sGUy5e7
y/qfvZUYU5hT59A1DPy+KfMf7KOeXrRJoHrhbv3ft/XL6qe3Xy2fq5zpSaTFYLPRn31IOZXz
kmkNoTzXA+g2C+hcvkFjhnXQsBmKpiaCEw3kFt4ZJO8hsoFYbkDAjgZgwsCkmMgd25QyDTjs
ZiAlR40AHMw+N7Hpqf30TjvA2PZoA3j7JBS+2f/gvXWbtdLw3re+oHhPu81fTvwKZNXZXZmo
YWUGNj7gc1e4Oxmz0+mUWJ5Gm31iorPT8HaEDa7Os/3xunwBJfH875tXJ3nbRxkce3raoE5B
dKjeXte7yAvWf20gzg5aFnQFFw5v4oQzKkefFXBkdS+0H9kHfn/6NrVsRXt2ioGytdFjeTGi
PSBAjQdcaEBduqOc6UZWpuTx7sIuf+cMDhcUdiU6ix6U8Fk86Cgo7mPGwYqkC8XaLHvFi988
FX1Mtl83zw1DPNn3ZWBlCOf9thiJGY/d2+sBTeJht33GZHznAHWZKxjTPPxU+rnh+vsb6eVi
+k/PlvC/HnkuCSdsbLHHZF9jkc5skhuHgzzV4NQcz2A9Vtue4zB52zvMaAgtcPWUb/+GIx67
H96/TQZWJLA2i/9jMzRLjjxRVFfx9NzLTogg7tknhBgDFLMgMMlbx6i2aFi1GDCiLY3msm9Q
qi20TsKZR3O6L5a71ffNYb3Cm/34tH6FuUjH2qQQZZWBcp6TGcAmnEoZV20MFbrf3JBzTSKc
fHJXnDfZpkhKKwHdVrKSrOJRVfUmytuIxFQxvuuFpZZmZuO3o6iVurdwzqeqhCelyndhedVU
WY+y09F9OYGVq1pND5eIBXjhHVqZWXtbuGepLkXml1WNvmlTIdhQW5YS7kA7pYABeNWkgNsH
ZmuIF6Q9qA/vvEQHA7/mksw5QtRRxFyZFC6m+zFV3c0vsX9GTFWhMm4/zDWc9dof6iRtdR+Y
uXc1KZUlD0PhC0zyhqHFQ0w52snfth9h6sv5x6/L/frJ+7OyYK+77bdN7Q+2p0WyuseFSvYj
39EjN2S1/JdNuaXJsp5aqZ+KfUfj2ioYBHdY97BVxBQEFCbLu1as+hKcKoQB1dFuLBnt1dVU
RXqKohZGOkVUz6Byv+2hcgsSR5SCTjTWaBSBHJTsFE2VIk+EUvi8tTXUUiSYXKaHFilIKAjd
QzKRMU2iwTw2dDMsvpwQd9OGEIMxKpwS5wQFkZIglV7YoXnVFwcBvkgN87sKPP9nvXo7LL/C
U4yNg56pfBycx30i0jDRRtvCIBM+sV5NovxcZP2sAQpyjcfkhLP9Djw8KfDdt1U257Vv1Er5
0BnsBE5yIoFD5zXaXTYpFfD1C0bpa5c3qUgse9dgCJCJ3uzmEZVBRF9m2hgXsD/q7tb86+U6
co5SR1dkUogVi7Iu5VQCxhf4htxdtCTYQAJPs7Fws8RxD2LOqiwOKa+PmZTU8R8nhVsy4rlJ
rPXbf1rPNCsnPPWjhOUzQlYyjYLKfcEcezd8j93JdCPV6frw93b3JwZXhLcKyjvjlMSBoiwc
tVmASDssMrBAMNqm6AFNX4R5YsJJuimDa3gLqD4IUR2pc7OzqijvM0XH/UDAgjnGvEGZSzDl
VNkPiLLUbvUzv5dB5Ge9xRCMrjPd4lET5Cyn8XgukYlTyGmOFcykWFCybChKXaQp7zUapGAG
5EwMdLFUA+daDGJDWZzCdcvSC+C1lCwaxsH7MIwErwvenIHb7o5rA1HgeiDtZw3Ynb4IsmEB
NRQ5u3+HArFwL+iEPdCCDqvDj9NW2qjqcEPjFxPbzDUJnQZ/92H19nWz+uDOngSfei93K3Xz
a1dM59e1rGO7H90YZYiq1hkF6lMGA94Hnv761NVen7zba+Jy3T0kIqOrHwbbk1kbpYQ+OjXA
yuuc4r1BpwG8nPAkBBwLHEejK0k7sVW0NBkGOVgqGNAEQ2i4P4xXfHpdxvfvrWfI4FGgu7Or
a87i0xMlGcjOkGrjhwAYtuC7c5Imix5MNAAvWJL1HlqbuAp9SOwkO4EE8xL4A/sU2Kc4YHDz
gfZEPdTSDn4LCY/HAytMchFMqdRqFSijaVBO70MNIiebxywtb0bjiy8kOuB+yulnLI59umDH
NIvpu1uM6eJjzLKBulEkh5a/Bnc/c0sq3f1wzvFMn+hyLfJjuM808KnqV5BiiK4kfhVy98O6
DLg+4CCYWHIyCSHuvMqB0uxX2C0/EJ7APk06bPAdSLKBxw9PmCp6yUgNezjVTgNOHwYp4kvw
nxXa8SGqL7keXiD1+13ljVtbdcUiTZYLuqfTovFjBoEeZVXN47koJ4V6KN0+wMmXuOd6eof1
/tCL+s0OZnrKadEyupRLePskOPCyd9LaDT6avoewXV7rYliSs2Do7AOiPqG1g4XAhHzI4oTl
zE8I3t2LHKIs5fbIhVNUJafJo+JXg3hZr5/23mHrfV3DOTHCe8LozoNXwhDY38dUEAw7MIyI
TMm9Kpx3K94LgNK2NZwJsrMRb+U269u821Nd1j4TA/3ZPIvKoc+F0nDguyQFr9DQ5yroT4Y0
jnooG4ujdFWNtjKXuYTt9VpLQyZiOSeDCK4jDeFgY0ga6T8q5zSH8H2Wu1Gin0CId3T1mf9x
hUXhr7vN0x+mDtOljjer47pFF5lV6biIxxm5YbApOslCpyG0goC+OV/PgASlAYul/SEheJZm
+lDkyT2DqMV8q9ecOtzsfvy93K295+3yab3rjh3em1yYnR9tQSaaD/CLiQ7JFzpn7SJWe3s3
CsPI+pTUpBYari+OsWWBomvyXnaI3T+GpdYmA4Yt+U3+ZeBJxxbbIBfzAc+nJuDzfMChrAjw
i8p6GngZEzmnJdyQMQgH/YbY5PeJy8/51GkBrX4vxdg/gqnMLgfUwPuLI1CSCHk8of2tW5Cw
UkVwj+aSQ/u+EBVyCJyqKsNR9+yxpLcFpyejYZZqJZHAJ8mew6azrI8Ec+DTrcDTVFmakWhH
VeFXw2t1rK3L3cFUXL3X5W7vaDwOYvlnLDBod+rSTwKTjiRQMqSgwEJTwTuBCuB9wbM9VDnR
u48X7v6dKcoirfuiycj1mB6rPDKNnaaR47MblhTwo5ds8bulqm9c75Yv+2fTSuLFy59HTJKy
9x0TwHBVgbUK00+leoFE9Q0cS37LZfJb+Lzcf/dW3zevx30Ehtmh6M/+Owffe0hVkAA8lEqV
+iNhMvRHTSjdy9BbVKgJEwbe5b0IdFReuDfWw45PYq96kgPriwsCNiZgqQaPY6GPMSyBBzA4
hoPhZ8fQQou4J3Ms6TMGbmKAGWyieOp+qDd8c1XGevn6arWFGIfHUC1X2JDVu16JzsGiKb73
tAP7BhzDZwHr6heNa/oM+v2IFknMrY/zbQRen7m9uzGFliG9JNZzmO5Vem2CKU9ESrv4Dlkm
JAhpQH7xAHSFD8anWPQ2ETPdXGuTcH7nGqrWivXzt4/YG7HcvIBvClPVhpdWRhUTspNFABw8
Fvyvh64crc3+z4/y5SM21wx6XTg+kP700opU/Mh0JukysdpQO6i+u+pY8P7pqpAH/CV3UYT0
vsQypi7lqdMwZQHx/kX4UDVR9lnU0NT19YGbbaikzoYmGC/QsE17HO3vnPs+xKsYNSW9TtYB
klIlQ5vCbGt96MFZJm4IX9n35d+/wcOyfH5ePxsOe98qe9E24jjubzsldnfGvqbc/pYmWdgJ
2RaMmkOAUTewlY48gQ/eZK+hsDJim/2KkAn8v+pPCBxPFQg1kyn+GQI68kUpM3PHGWr3/1T/
HUPIkHg/quoQqXSGzD3XF5GG0nri6iXen9gxJBPhzgqA8j42TSEqkhAeXI1ur/sEEz6p/5bI
eOQyAbEhPPZgxIZMF1BM44L3F44ewN2vfMDGwdTWBcvQ5je4WEUq9MBfLQEs1jux3mxPUM7k
5HcHEDykLBHOKsbqctuRBJjjEsPvqd3oKsMm8+XAMOaM2UOvOJjgJ2H1d4WmccX92msIAMQU
DKKs0Pn60kKZb9UGsiUNGVvc3Hy+vSZY2FBcjG+u2qzQPOHY/tbvqHTgreJYTn4XggWfxp8W
ZZBJ6togJEseXF4LX91ejtXV6MI+JShrLFUBESw2pwqf7KJiWaBub0Zj5qYDhIrHt6PRJTGi
Qo2trkbwepTMVakB8+kTgZhEF58/j5zCXo0xy9+O6ERNlPjXl5/o9HCgLq5vaJSiTf4Cv21c
lCoIuW0RsXACfr/lJGTzjKW2uPvjWtqqNgqeoQt41BVfwUumx5YnWwOtPnQXkbDF9c1nOp9d
k9xe+gu6kFQTgP9V3txGGVc0G2syzi9GoyvS3vaOVHXnr/9Z7j3xsj/s3n6YL2P335c7cA0O
GOQgnfcMroL3BEK8ecUfbRHW6GKTa/0/5j0Wm1ioSwzp6cQkVmMY+rVZfPRYYZvrswfWDGz/
bv1s/oyW3f5czzGXGUba5AlOTWFx3Y+oP2jUyltZqInjg9rGoHI4MctdO2HH32AAEvtX7Cmo
AU5VB2IAZr/xNQ7sdPXHKpQDa7y6Lkss02CoRmasEonBdPC0YDldJ+FfCvMl8nCyX/Mhl5n5
WHcaqiEOoeaLIQy6nAP5pwnLeRHQqbDpQIUN9qc4LaJwLvTB5UCuVxf0BgFezs3N5FKBFtCj
51zTNZs0TmR6pBEQXhx2m69vKMbq781h9d1jVg+h5Wh1HwecOcTKIGMDpHbFa87TQOagrszH
QMCPaHTCHu1GThsFspNqwWhk7tPwIpc5PaR2cAdwc1EkNMr0aDm10ip+bc9Na0xKNiZZE/PH
+g91ddpiIGWaKew/Y7AMZqr5uzNNpZzG9MGigt1zQaLEDbghCxqFGRcSk7B8zt0/F5LMk15B
ihgGY1gqF864eAERkz/0t2kAHd6/M6vwc7ejaKZubj5dwNihApA1Urp/J62PVTyh+ZYyPYzj
2O4s/4+xK+l220bWf8XL7kVecxAHLXpBkZTEXE4mqCtdb3Ru7JuOz3MSH8fpzvv3DwVwwPCB
6oUH1VcYiKFQAKoKDe6MFidKw72mPQGFdF0ixxbumpXser6K8h1WB8sieUx+aGp5Q/NwhA18
ELJM0yH59tSQRCAZXVwPsCIsa9hFDTKnYqXqYqcCXZ0NfFcz4PZlDdNikPC9/N7HWpOAnBiz
QFSXnI51b1js8c0fDSKMvbRdz14YBJ8dAu9afTBsCCXlfo1cPk0LA3ZfUjKXyrOa+aROZzcu
5lyWPBNPzTfKTh4SDVuxsvrzi+sata8dFod974hUVcO4llwTm27k6WZJG8ME5dmIq07gE5ee
juWW4J4r/szUIxV8GOvUd7iVrTje5xDOZWaS3vAoJZz/ca0/BFf9GU/Ra521+lCSd/r3a4F2
kcS+LLBFM5bKRaSGjWdNjo1n+24dJmvU1UaFDkOXFVxeYTTn2naHIWMFM6GBVdq6QZFG4WGN
mnBd+xBYFlXmbBmw3qjwkE1X7wgracfjAlmFATZi+ujg//BSZAxDQg0r23bxQiyF/ca762cy
wfibba7yd7Lz+OPt7d33X2auT7ZX6NWhpsvtCqvwrkAY9gJjBuVoo7CV4Oq3r39+d262qra/
6DaZRLgfj+RIULtcSiQTWQ+5jJwkh3QTeDLOAg2mJhuH6mYyLdeQX8ij/TO5cP78apwmTek7
cj7ZrMeP3cs2Q/n8CDemstK0rnsLmfKpfDl0htXITOMCBYtfhaGPohQH8jGY9mAGryzj0wFX
4f3oew4prfE4gqwoPIHvCE2z8BSTtd4QO4KsLJz1E6/vNgud8z/mEIPUYci4MI55Fu98rHSq
TOnOf9AVciw/+LYmDUMc8UXJ55aEEY7MtDLleHauDP3gO0IoLTxteR07LI0WHjLSpL3Kg+Im
tfYB09hds2uGD1RWrkv7cABU71kcPGjrjksVbOOq9GvIJ8+DfG7jw+rkWc/15gf5HKBZoSLH
lONb+nnvWQBI96zuGaIfXgpErrtTxf/tewRylTzrxyqHGS4g3xlodzMrS/7S6/clK0R2QYt7
76oXL3hZ0/LqMP1VKlGSRlM5tOy1tO6Sn59gtPKV6UiR6/UjGaWgZrZB0iBWDlXm8s8khqzv
61IUv8HE+z7aJ3g0So78JeuxFbrEqbmcZ8OS5ZndbrdsKxOn3Jy+denw7YJWPq5tby+95KyC
7d0li3DNcLiCSQZqWZYPpcPmeJo/XCOG8NBUO+usRSzg59dvn4StYPWP7h0pRpo/5aBeJIuf
9Ld+PSfJXM2R66tG5Zs7bfpK6pBdTdJ0rA+YOanRQlhNCYYccWc9KlAugyr9YnzbKWvK6bPW
c76Jdm8ZVy7AlFoY6p16Uo+adL1eAKqoVOh+ef32+pHreLZl4Dhqt0vPLpfHfXrvR/VgQd5M
OYlTuPkgWi63a+FqRBGhybx01vjZ27fPr1/sS3kpFO5lNtQvuXqMOwFpoN8XLkQlnvRsgob5
/DiKvOz+nHHSHJ0UsB1pU4f8p1WmXJ7Ju/JoyparEzBmq8LVDveLMF7cIXSgKPtNubDAgsob
304VDoVMZcxYTz6+z5TbQ+bi+pBlGIM0dZx5STay2pwukCxB0f7+2w+UDaeI0SAu88Dl2pRV
1dyWgbFVJH1cXY3IgnHioAhBeWWND0leO8T3MMPa7RB2Dl7d6kkhunOsjtWzi+xOleftrXeQ
N1L5ccWS2w0M5wUz1y+dbRK5P44ZXeCNVhEG7qyKg48rYn3G7Hk9sW8VKbLh+r+IymDNNJXp
kF2KgYuRf/p+FHjmCFA5XbWfTjF7NtfIbE2dYc5na0jzpWkLPrKaQhgd6/L2aGbndMJMEV6K
6lTlXCbjQ4+JmyTYBz809pWLCaAmw41WaPJxqA27sQlqyZyQHCn0DXx7Pxe14/7zfmJIx28v
dFY8KuZA06sZwunXpDJ5JGZ+JPkuGHf36yppRZpfaTJK9D+XlU5Q1VLrHq0QfW+cisz6Vt9U
dxkIX8lDUEmC3ots1O4MJUKWJzLcjCtLeVYuDymPWsg6AavnfZLApYtBEg8cFd3JrBZFyZNB
K1fyYaPA85Uram2hnr4uJBkev+pkRIz1HHXBD9kuREGvV46cDzndJpNXhecHEnHgSYu9Meb8
T48r1ms1EpwVHC4SIRm5HEGbyQTIp2rVlo5VTGVsL8+dcZCgcD3zmpGl4u3F+A6emo1h+KFX
TYtMRHdx4TKpfjF8RWz9ceaeW2a4sFGEgVhcmeQRHl8k7ENRtTj6OLF5J2tLbVRzQFqfo/FM
4JmnUiMcErERRtvSSO7PL98/f/3y9hevNtVDWEGjynChepBqPM+yrsv2VJoV4dlaOzsLlmVb
6eox34UeMgKcOfo820c73/qSCfgLAFVLUhUVN5QwIgJHRRCNraRNfcv7uoAyfrM11VImvzL9
1ToCjBMO0fD1qdPCE89E/uHqEFp2PeS0tHbhOsRkpMafyKVpssT/26+///H9y/+9e/v1p7dP
n94+vfvHxPUD1zXJRP/v+hjIeeXmRUprmKKkBzyEPx/SXxXOsimfA/1bUIZipM2P0/1oOVtp
vE9lY3WIAnfWsaEC8jYEJluiJ6pmLI05uNzTThGf+GSnEJkc+gfvON6wr59evwoJYB3EUyNV
HR2eXMyZvdrbavUeukM3Hi8fPtw75nCDJbYx6xhf0lztPVbty2QMp1CfK7Jznu4ExMd033+R
g3b6EmWY6F9xZJUq9ZwjT68lG+FrHAKqtcixC2myrLSHGjk2Os1WVhaaIg9YnDaIikRW0oUO
tbJHwUZ098cz039o4lyeA7HKcElYyV8+kymnEs+RZ0CSXVeUgFfh2E+BmA15MF0hTrf/dLvl
DNmh3CW+rlFhRa5//I9qtmYXtqh6izSdCHN0xwm4L2+QrQka1bFI4ScRfLy0uXFmQTnx/+Ei
JKCoOeL9Glk2tnCY6lVkey9Gz17NDE3eByHzUn25NlEbofh3hp47Izc/8pDpy8IwNsebnWOf
1U3GbPrwlHqRTe7ysu5GULHzvT+CT5F0Y4OigNQlDpTSLc+rGFjd5ec2O2UDaDxSkTKbnrNd
Uu89F6CsLVMgNNr6y3jqYlFRX87hv/n4twjCeaQn8wnpXxL5i/9ddzS+ck5SDe91+wI5ymxm
+byXQbPePxRUcQPnrbraHH3/61e+VAtNC9zri5TJ7nYTjtXo0LRfjnuN8lYLTT234mrEflHB
40j/eL5nJVumoFsjkHyDqQHIjqqvyKdYYHSZlD9b7XVIY5bcrJz4vvyDH+D3PmSXZE0WFQEf
St0BhfKVTFVnZ00PecEdh0AXfUFr+qa4H/Vw2xs9u6hvgvr211curLU1efLSFHf0ZkmSajwc
K5G2t/vrejf0KHswemiIBqDJJZ2KdmUo9PbQTjrRzaSAyWEPMDEc0yhBglTAY1/lQToNWmXV
N1pZzrtj8aD1h+pDZ5goE/1QJF4UwIuLCfbTwOw0qc1aedV9uN8hh6EJTZPQHGhEjOLI6rFJ
rtodlsQRMlSU7WmsL7IV5b21Se0ZzyiNrTIEEDjsF1aONN7oNo7v/cDO+lrH3m5jPFybNIQm
pQsamWObE/d77WIJjARpI8QO2yNE07eX7EAyfVydTnyjmmmBn2VndfmTGgxbRNUQNfF/+M/n
SRFvXv/QH/O7+ktYKBbsdJtnHXO4fqlM/hUGJ1o49IVvpbOTtn0A9VW/g315/bdub8VzkrsD
Mv53VEEyMONsbAHoCx2voek8aOZqHH6ofaKSNHYAQeiqUqpXCSUOPUeuoe8CnMVx6J4P6HZC
50pdGUQOt0KVx3jvCnI4qp6W3s6F+AkYQtNQUTRqOm+9Z8+Ol7MFOpQMmt5LlN5BrLWbX5Xu
tK3VmM5X7eXpvsgkbu9UsiKnSHV8kigHlFwsp/sgMtNIaXanmER6HOsJEOyo6YWcW3JbT1Ep
AJAr0VSpe5r2TRp7irinPeiJGpkrGl6s9OScJL8Gnh+pJc0I9b3DVk9lcTyYprGgY26NIUAV
qMtTdy+f0ZI6s7ADs79VI0o3oZlolXF4HyS3G1p1lvrxHaY6rRW6HwE6Hw9+whc6VNqEof2q
xhL4oAvdncs1Kd65YWgjFeupQBsQo9Z4TnOCSClxqOIqS4pk78ygry1roaIvYKFjGEfwCdC1
wv4uShI716KcHlIQLHEUw68VqpON8P7f+RFoUwHoK7AKBfrjhIAjCSOYa+QqjutpsDjWHMLd
VmlSm9uDr5vUucQepafscirpTD/Y73w0VIcx8hz2p3Puw7jfRWhJnBkuOfM9LwBfK9VuBOz3
+0gZr4ZwFj+5rqZp35I4nToaITWkXcbrd75VQ8Y5kxN+kex8pVCNri2vK9L4XoDGq84RoUwJ
iN25YntejQfeG6ocvjpRFGAf7EB4gqwYk5vvAHZuwMcfwSF4JKdxJK5cE9RmLIT8LE/iwAfA
jcKLUOj0dhy6GlZTWA5tN/V467Fd9MyR87+yit4XGNA5zsxWsDiA0R8oiMPmKDry/acXHe0v
JCANjieERGESMRs4Ga5/E7nJ/TBJQ9PLwMx15HuDy5iNJcq5jvyUNRAIPAhwzSKD5ABQ5U1T
ayPn6hz7IRgZ1aHJSlAup/flDdDpNEsXNQs0pmAu/ZjvQE25fjb4AQoNQkEAs1MJAOV81eob
KZ/xRkjnSZyGuBrfHmn7CgdfC8F0IiDQlUQNCrZmu+DYgUktgBjOCwltTQxa62MvBtkKxN87
gDjFwD6BcyO7hX4SbjUaBTCBMkgAIa5HHKPRI4AINoiA9kgJ0Ku6B0OvyfvQC6CsHvPYEdx7
SVy2x8A/NLmcHlv93MQh6OQmCWEPNwnSHBQYTDpOBd1XNykeRHwntVlEigZlk8KRUDfbU6fZ
gw7lVNgk+ygIgbohgB3sKAltC4I+T5Mw3qolcewC0LD0pKE4ramY+VbZzJGPfO5stSdxJGjx
5gDfJILmIWDv7WBxfd4kDjeZ9WuOabRHQqI3HTSWJA22i1NVpwB9w6GkWzIgvquW9Re+z+pZ
D0ushjAKHN5VCk/qxbuNelVDzyIZ3cpEWB2nfAFHoyngm0KoZ4qlIEH7N4UjTLHEnyTvA7Eh
ZK33QIIHXoIWb4mghUgKOTRvCdntkHJLO904BXKjv5V8oYCig++bdnyb7givtTJFYZxsq+uX
vNh7MLiAyhF4oOK3oi+5MmEDH2pebVjv/tqQorRRGjuPPmg+TsYrBAfCv7bzy0FHFU3J100w
Kkuubu48IBU5EPgOIKYzKlDphuW7pNlA9gH8JoEews31lOXnKL7dwJPUGkfwMI8wBvUbRyYH
OKhcw5WATRmV+0FapD4Y0lnBEu2+agF4I6a4h6s2CzzkFqwy3JDO3GZh4NIrki1xNp6bHOs5
Y9PzHfBWUmIAo0TQwYdzOpSbRHfUvekjHx98zCzPo2885WCxXNMwSUJ09qxypH6BqkDQ3kf3
vBpHUNjfJQDQPoIO5blESGyYxjY2Y81l7wg2gBKKdVtlBeTT5HzczpqzlOcjTO+6F1QZ1LM9
oclkurGyJM1POCD744lDvFTIdEfXGSubcjiVLXmGTZbi96Kss5d7w9bw0DOzsZ2cyXqA0plK
kYDJv5HeMeyhKfbEqD4Rz3fk/f1asRLlqDIe6YxChOfHBtogiXhbQTz9uZnEnTtg3KwvMRyy
9iT+epDRWjntvLS/zFywzkX5LF6V3+JZe/pSZ2TAtsnlMN+RNmnKMJzo6jWSBdouCTPFcLNa
yG13zV46PS7HAkq/C/kYeNnS0ELiZGEn331hVEj5eSA/YRJlHaxeX79//OXT7/961397+/75
17ff//z+7vT7v9++/fa7GcpkyqcfyqkY6kl3hq5wGaw7jqCtpgNlgIjOCF1AAABpWbCSDSuF
+UuE7Ro9P5pnMJbaunO2iyBzJy/eo06Xt4MYiDwATM5XqMIfqmqgK9kZQ0f10qAMJi+uWymH
NhpjHzU5HVaEN/QRvPMvgCwNau7XYtSa6J4F/kScbTimV6CXYZK/fvukjA7O0edK/qsDxc9/
/vZRPEvhDFl/LKx4n0TL8jHd7yKHrzwxsDBxKAMz7NhI9I0QBn0UBfgOVaTPxiBNvI0ogMRE
zjl3cpfL8eMMC8+5zgs1+u+xkBEHPN1NUtCLfZT4zRVHvBFZ3vrAc7lQEoNtybRS3ZEDqCfI
UtTH5x0LbrrxmXiK1OgFVY/KVqKy3RLdI25/raYhahRsfoFgcVVAyh69fCmoLJqvK8qCWrdI
RSbolI0lGYnPp/1qq+c+n5Q3SJyMo/Ve6oM4QPsCAs9VzNVn0URrhnwreO8zVuXaiR9RefbY
bpHykhFa9HotJnYKTdx/ex4iRoCo3ZTLYbfcIBvDkS6HA7RHX+HIszLjVN2CbqXv0UHZAqe7
0Mos3XsJIAYRKCDd7/H1/Iqjsx2Bjnw/ag0oosLNsADndUyvnmYvp9BJxOsU2zphppAmBKjG
2wyUqbiMNqs95NEYwTNJgT6l6oZQkOSSpRNZmZvPdxC12iXxDQFPLykfRtrBQna4Rd4DEc34
vhK+QUSYMFHWyxnp7Z4wjG73keWZKbOlralJI6MMK5e6MfvDsBMlIwHfizQhJ00KfDQnJJQY
k0uxKLWopqS1rRLmqho2sgpZs5JVMjG/d7JONYfKZJXqmuOK0SqgIunIMS6LQrzuj9d654X2
gFhhsoQFg+ta+0ESQj2kbsIodI311cpXr+T75pYij02Roe3YIdb0xVLaJuo+NMuiGezMgq9N
hI9xZtA3hoQw5E0ALbVoO3MJkCozotn1NY8KVhrklcbFqgTpzo20CjdX0hnR7Vr0NEFqNhQb
aQlFx+STzDjKTlW9V12q7Kpkn2jzqpokLyRpJYOAY3WjQCpdPWa63/DK8lwN40WGXGCXxhFd
cmWnXbrYpP+3CfiyfcKW5RrPpATgDGjdRyvZykQKfRpHOIesiEK4eK4sirpsY2b/a5DuSmBA
uv6tdJhQQDdrZGqTBhI6kMB3NKPA0JhURkvWRmEURXAkEZamHsJMN6IVkRrlZqGS5TkKYdYV
q/ehB2tEl2RB4me4ZC5Z4wctDGSlAvK1OPGdCOwYYWMJh5C5BuoIbnFrgdShFI66Wi4aLihO
YgTZZpg6FukqsQa6vFc0pjTewToJKIY9b6nPBhTAlhGQrscZYIKWW/OLtr8XbgQMJu1u3MQC
3AvTtk3XIHQ8SeHEJyjd4xLz3uc9hLE+2vmuT+3TNEI7RZ0ldki4pn+f7OH2S+HhOxQfzrFF
mwU5kwva7sGQs3cnCna8fCh9Dw66/pmLuNghQQXoMIw3uPYPuaAbz4q/z7tmdmUHyQVMoc6f
LVd6i1dsmTYLs3ZQCsTVHEi39m4rxoKmz6CVgM7DcN+zqEmTGE58ZZtmY/WJXgSA3cp4Mi/O
HFAa7KBoFlDSIoisBPw4dMiZee+12QLEFISusSb3WAG+sTTZEmxSY7LBTYPJtIcNKDB/63tp
6/ff1MJwQ8RMUqpgTNvQKWqsHulgBcyNhI5E8HPNDYmGaNsHY0rW2aE6HLRWyl0bxtw6oiBK
243VsVJ9jojaV5qxwkS6l8MgAvv/CG8qiioTnOQRpQUuFSWfk1A1QyGafkQjHnq41KxMCdTp
Q1a17JwV3XXC1v2PKHYq0roJOn17/frL549WnJxsaLQnA6edkUqW79R/e/317d1Pf/7889u3
6TZJu5E6GuFo53fhUTL5IPnrx//98vlfv3ynRzPzwo6Vv2TN0XteZ4xtPetBjmG1eOXRzTo/
cf6g5OU5dbPJlLv07tIWVhufq8KOJHU2nCuqYvW2GoeyPTle++CMQ4YjbF6oIHvcUdZrWAUZ
RvXr20eKwUcJQOQESpHtnLGgBZznF3eMZckxXBzvLRJKQZq30QpvZAV+occonPChrJ8qfKcs
4bHr70ccSYgY8jOfxzgouoQr/msD7y58D+OEm4yuMjeSixnrhvmnjxTGkx28yOHoLfhkJHAn
zofRqWuHirm7oWzYVjOVdWncgxkwjjoksA9PpbsFTmVzqBwP+Qn8OLiLPdXdUHUOJYwYzl1t
hOjVYF6x7YH99OJusUsuAnI48WtW87HnhJ+r8sq6diOD08vgNpgghoqumt3o6MZ+zA6De9iN
16o9O15Kkc3WUiwf1/MFxFLnlmOtjpdt9+weM03GW1bEO99gqenZsw385ciXAXffDqWcFu4c
xIts3REHSxUcHQWw3BjdFEO82h5i7YgfpZfYUOFnHQjla/zG2O6zlixi+AxxT66+bBsKxr3B
MGb1S+uW7T0FiM03SqCHBv6fsqfpbhQH8r6/wm9OM4fZMWD8sfvmgAHbdBAQhB2nL7xM4u72
m8TO2s570/vrt0oCLImSM3tKXFUSQkilqlJ9lLjM7Zu0KBMs12P/TtDBjXVe5mEY2F+BB8mt
abpVO0PgMabNdHDTKazVRBtsnGIWWUsRD0Gzzor0BhcrmX2JLDE5f8BvHCKcBWX1JX+8+Qg4
Zey7EdgYt0X2CfwKk3zKXBd2domyTF1wWquSDPPWEbNNYK1asV/jMr/5glhrKrzFL6TrY71a
00UVhCiSFvYHYN6zXlhCmwaZkMG6HCqkyIhyPiE2Fgn9FRryXi0lJeeK+phr+kzt2V13Ilun
+Sg196HarCtAoD5AGVe+CpM6Taoqjes4A3En09WZnoYkCuT1fMRF6bm0SCx5mGWjLCP0qCYl
Gq9XYaRhzO6DLANuGMZYm6fRHvoOelhUeff6+nTYHT/OYmabCmTqBGJvre9ngYXfzMrVKt1j
FqBfDEuyvLSX9csrdPXLo3VYpUZ3BlWUcOH4iin/ywz9ZtdzY0ZAnudrYG1ZJN1t/3RVtJz5
6wI9ni+DsMvSqHgQagMMx5PtcIiTbBvbdu06w1XR+w4ip4Iz3vYRa8dz+1CeTh2nAWtD6BDQ
I+VGKrTnaTAe+7NJv1tsJ3KCMDhu1AloPCfD16czkR9UTGjIDN29S/StDfAhohkc4ioW9hZb
llfxfw3Eq1U5SCsxaKrvsN/Og+NB1ub+6+MymKd3IkM5jwZvTz9btf7p9Xwc/LUbHHa7l93L
fw8woaXa02r3+j74djwN3o6n3WB/+HZsW+I7J29P37G8Xq8siFggUWjcGAI0KWzGFtFEzHBU
GrYMCc5555FYvD5dYFBvg+Xrx26QPv3cndphMfEtWAADftEqw4tO0JM0z3Rdy1hiE/WyQwHS
C1IgYGQgYKTachA1KAhVWhbH5BPS8C5mXiST7y3aLuu+meK/T9RLmajgeMIKPb2mggySMkSm
cLv7oLzzHGdMdi8VbRIVrjw1R7WCeViB8LUCJdYyLKwwgPYFUC9NkxXxmALYx5YegVSAazYl
0TEr4iWJWVQR5rfPLePbAB+hsgMpJEkR3FtaJ580jaNl3D/6DKSsnkl1v5g6rmev43ql8sm7
WHVZBSBi0t82KR5sb7emskYqBKBdc9BCMP0T2XWDp3GpmjtYReTzBIuN0JPGwqpeu55LI1GR
sLwMy/nks40riKYjk+912O368zWcBRsW9OSaBlmkrjek5WOFKq+S8dSn8wkqZPdhYLHJqURN
Ze7bg+ZFWEy3vmXUPFjQypnGm+ISxP+m4u+n1I9sntMmP4WqohJQazxhHpdfgvCOXAxbYIg5
o5nWg2VRyqJRNIpliVEq22gYWnQPdUyog9TskyX0kPDVPM9snJ7ztUNGx6qfvaJ3yLqIJtNF
E0JM8msz+1t3KOpiMSkkxSwZG88FkGscN0G0rvRyCfL5Gx7TWrqoWR0v88pqcBIUVrG0PTvC
x0moevZInIgqMoSDyKgYiUBxkMRpf28L+zaI5EUaULKJQNdskYj8yzJpk/FtEhDV55ulwURT
Q2SpygBUl00yL3VHNTHi/CEoyyTvyaMo7lqmJV7xuJLy8CLZVuvSGFbC8apl8aBDH4HOOKLj
r2J+tsanB6UE/7q+szW0kxUHbQj+8fyhR2NGYz3HgZgPLHELc4w5uuIb6hZMcc4Ni3S3iosf
P8/7Z9DUheBJL+NipaQqzPJCALdhnGz0wcocqFpliypYbfJG8zRBUtacP7Z6Y18g9YYyulZR
6i3j1d94GYAoQU9I9VjEVKSJUJSwnBZ/SKpQK7DOGBmaEjNRbfI66hbS+Ucq6bz5Zf/8NyVC
d43WGR4rmKpyzfrlI9Ve/oV22vXalDXH1yPeAbV+2Kqa5wv+lteJvUFg/B/xCqJFWvh+F+l+
o6XQv/563R/+/tX5TXzRcjkfNJGFH5gdl7IdDX6VVrckW7LfWu0IG1Wn/ffv2oJF2ZrzBGSm
RJTAaq8En/7+eMfKC+fj625wft/tnn+od78Wiu7ivQprLYc8AsQs6aBVWOX8kQY2BpY/fzld
noe/qASArPJVqLdqgPZW7TLrPgQCM7O2k3hJwOiFzZUWoLYvumz1Wl8CU5S5pdZpS2GrZy7G
WG56zKmzxeGoegynbdWPv9EwFCKYz/2vMfcoTJx/nVHwLdlTxIH3TMz5uGLqMM7ggKCvQVRS
MoWBQjCeuNRTVo9s6o8t7jgNjTV/ZkuAIZQzza/kimh8HXudNr6Ot3ttPRYNjBEs04G5H3r0
ayY8dVzaW0yjUD1HDAwxji3A/T5YpPpxicUhELqLs4rxrBgrYuqRcztyKps/X0NiTyXfUdx7
7h3x2L4HY7v77LnWuy8UokMesT2453uzYUB1u2CeQ+Y06zqFneUQiw/gvpoNWqV3ic8WM2+o
ppvq6DcAn1JDK9ElkvSZbV/LZ8S7RrCvp92BUSR29iQqc2V4U5ao9Fhfp8/WCLbgGUaM/hJy
Hesrz0JiM0hMly5CtyveZLPAg1xqMwPcd4jPhHCfWPfIy6aYAYQl6aMNbWGo4ymd/0ghmbhT
OlBXpRn9C5opGdCr9ULMr0j2PiKHL6Ijbj6WV3fOpApusurRtKK+AsI9YlMg3Cc2LONs7FIv
ML8fSRfx/m4p/JD2nm0IcGkNqZbWnCoqgU82bR2mbzT++pjds6JdzMfD72Gxvr2U+ar/3j3z
cYu4FsExGVsF/5Gc6xr83J/EiafPYecax3cgT56MgQtsxIL5eqHcpTV98scsBAXUqKD9IODE
fMluapZvYunNqWWyb7A8ThcohtGGqIZoFQfmbW8jHBtD7UTt9bZR86+TtYpGo4kat3PHh1pS
Jfm7Flbg4T/eZGogjNu5hC0xRW+SoD3j2ktTTA99PuJUBWeYZK+ptDc0wGUuptW/vrlEgIKc
LWNQmjjHayJqitBMgS6Zc0y+QzuNqSRU9jQFL9x0jFFffzaEVwDGzMEySzZxqR3xCJd1jyi7
9CYqtJN7I9Rtk7i54X0+Hc/Hb5fB6uf77vT7ZvD9YwdKpnpR3kYPfkLaPn1Zxo+aJaAB1DHX
86lVwTIhk/XIkl6pIuzAD7z0S/NcK4siCNN4GYSPDf3Vg+ABDuYszcO73juHooYdP36cqEwe
qK411/SYn64OmVpF20Cyaq1m2FvJqr1GmxbaEF9VdfS5wozjdZFU4xHtUUwOtrM7BEk6z9Vi
cU0lrpqt1uqjmjrdDIgpg4bsRqhrLdstd2/Hy+79dHzWJJpmVARWtnp/O38n+HTBuK6vIkAs
d+ocEEjh5r5MZY1qCwYBqplIf3z3AdB7Ge3xnch2/Di8PGBNkatnt0SAwvsrl2VU84Oo7vob
2gOe99/2z4q1RbqSv70evwOYH0Nqiii0bIcGhhdrsz5W+o+fjk8vz8c3WzsSL+/Vt8Ufi9Nu
d35+et0N7o+n5N7WyWekgnb/n2xr66CHE8j7j6dXGJp17CT++vVCeS0oWmz3r/vDP0ZHDWWT
ymgTrtU1QbXoTD//6nt3m4u1ScDa0TQ/taRV7cnapAsTmcvEbTWcDVHMQHvQTmmFrIhL3Lto
2qZOe5USzf9cq6qqorvQaRpdBJwnm9h8iV6yrOv7yorq197ibRVe1Y34n8vz8dDPudW9pCQX
icvwjoo8QxuaBQ9mI7KoUEOguzw1wH5Y6RXheWrU6xXeJlIxRyD16VtjLKrMd8i4wIagrDD6
MyA658z3h/Q1dkPRWtNJGhazvKRuVhJ1UjAbPQhtCzW25wqrwzkJXj10gfY6/m6RLASVDkZ3
3WVcxhH5LPmvWgZTadMjFU/luAE6Elcl4a2Lmt4SwNceJW99ft697k7Ht93FWINBtE29kW/J
NiWwaqx1A9DTOsxZ4KgCLvzWorfkbzPfxxy0B38oPT9oITxwLcahKPDISHqQystoqMXTShAV
RiswqlYjpq6SA6q9YJtwCw6tHQb+bsujmfFTn6S7bfjlzhk6er6d0HM9S5YyFkxGfu/DaPgx
mZccMFMtRhMAM993zMwoEmoC9PFtQ/hyloRg23Dskrm4QL0HPVgVAAEwD3yt6KSxJOUyPTyB
cICVl1/23/cXLLd8PADX1Mv5BdFkOHNKzXYCMHdGp40B1Hg4rpMF5swARShI05jKLAh0Mz3Z
SxAlouYJXcMjDDHa1WmyLSlrE5OLAa+iW8XZJk7zIu7qKylS+3ai2pekNVtP5oQpxkdqVgQB
0M1IAkTnnYLjQNpurx8x2M7G5F7C+gYjVxfM46z+6sgxUXdnwXpimFTkoWGdDCGxbvD86/v6
dgHYdXKjsSDYGJ/gigEEadxqkixqc8sjcRKzPOryvFzvSEVXw6lD70WB5rC56Z2yWYydoWXS
rgm/9NE0Qtu2fbV219zaIeoeWpyOh8sgPqh5HJGJlTEPg8aSoveptGjk+PdXkPe0rbdi4ahJ
ntaJ8x2VPFZ+7N7EbbQ086jbtgIdvy5WjZe9ttEEKv6aNzhinuYsHutnDP7WWWwY8qm6g5Lg
3sz5xMPInkEKH56UCcojy0L3f+EFt/DpzdfpzPCxalVUcyqkCWz/0prA4HsMQpDvjwdV6qcJ
1G/I+DVbuHsN8uRF267faR9pnGx6hzSumUwpHTfLD1bik1w/GqtWeKhPF2HAnEB6hRGAjEZU
iDwg/Jlb1vNA9bgRUK/UANotHP6ejU2xIyryCpg0vZEjPhq5dA0GNnY98pICWKivZV2D30ZS
eOClo4lLMwfgHTAa359QTFhyDsCrW+7m1MurZKyj/fH29rNR7XQW0Khd0ZoxzTJq4qR2QwVa
9Cg7UfcaImIOoQkf3/3Px+7w/HPAfx4uP3bn/f+iL0MU8T+KNG0tCNK2s9wddqeny/H0R7Q/
X077vz7Q1qou6pt08sbnx9N593sKZLuXQXo8vg9+hef8NvjWjeOsjEPt+//b8hrpfvMNtb3z
/efpeH4+vu9gbg1mOWdLZ6yxO/xtruXFNuAu1gK0iIjF2hvKHGy2j1hhhGlukXYFShV2r0ul
WnrucEiyPfvbSf63e3q9/FCOhxZ6ugzKp8tuwI6H/cVIdB0s4tFoSLER1GSHWjKZBuKqq5Hs
XkGqI5Lj+Xjbv+wvP5Uvcx0Mcz2HEiuiVaUX71tFKCNSpsVVxV21vJX8rXPfVbXWKmAlk6F6
i4+/XU2k7g1aMgPYHhf0HnrbPZ0/Tru3HRzzHzAJ2kvNWdIsMGK0i23OpxN1kluIoeOw7Vib
gCTb1EnIsCCZdRkCCSzUsViomrquIohTKeVsHPGtDd7tlZYh2adB+k6JVBC9jRhEX6Kae/p3
DaL1FlYYpXwFqTfUM8ABBPZKQNEWEZ956rQKyEzb+Ctnot8YIsSiF4fMc50prQYhzhIpACjP
kukGUGOyPjcixnqtlWXhBsWQTFApUTALw6FqLsEUxaBApXSNJ566syGZrUYnUdP/CYij5/f9
wgPHdUj/gqIc+vpRnValP6RnMN3Alx2F1IEIPAf4k8GFEKLYBLI8cLRMenlRwcdXdngRYJXD
Bnadj8RxyHthRGgVAKs7z9PKilb1epNwrVxqC9K3VBVyT6vVKgCq4aer4wITrLn5CMDUAEx0
7yYAjXyyuuqa+85UrbiyCbO0mcmriC1gHrUMNzFLx0NdVpewCbU7N+lYs1R9hW/gurpPrc4I
5G3g0/fD7iJNFeSJcDedkX5tAqFMf3A3nM1UFaUxgrFgmZHAXpLcYAm8yGYxCj3ftaQIaZij
6FMc5ze2FdYR0rJpGwh97bTIknkOVXBLwk12TE7pf3SFBd5fd/8YmoTQfMxwFjWDa9umOfWe
X/cH4pN1xwGBFwStA+3g98H58nR4AQn7sDMHsirl3WVjZ7WIVyL+s1wXFW3hrdB7Ps3zgkYL
D1QF1Y2dHmFzih1A1BGOV0+H7x+v8P/78bwXiW17Z5vgv6O6yLm+/j/vQhNj348XOEv3pHHZ
dycU4404bENP45b+SA3ZQo1pqKWhBgCwEIXNFKkp5VkGRA4WJu6iTEXKipnTsh1Ld7KJ1CtO
uzMKESQzmBfD8ZBRF/hzVri6EQN/69spSlfAvRSOGBXc0yWKVUE68yVh4QyNEnagozmOzboP
SGAmagZw7o9V7iR/GzmcAaaWoGsYi4ifoaHGUeNrhepWhTscK+ivRQBiyrgHMPlH7wtchbgD
xiwTW76PbL7l8Z/9G4rNuORf9rilngmVTIgWvn42p0kUlJjYIK43pG1g7miRiEWSqWmiF9Fk
MtItprxckHoO386MVQAQny6BCF0oOwdPT9NhbZP6XtqvMaLM7s05aTwhzsdXjF+wmesVr4ib
lJLr7t7eUY23bCrBqoYBBiOxgprodDsbjlUJRkL0jIkVA/mUsjAJhOb+XQH3JZ0ABcKNNH5M
jL374g+KZy0WkuzFFSCwF1OnYZUaM5a8paJCJcdQZuNpzbzpwK7MgfYUTOs61n1B5Ula3g+e
f+zf+wlKAINuOop4AyNQXQvbkjTlvaaJmR0qn7kIwjtLdg9gJXHV1p5P9bwKEjcvQ8areWPj
pj1QBSGey2m9pNPqSZIqaepH9OajWD0O+MdfZ+EecZ2MtgyZFho2D1l9hyn+McqtQV0nffXY
FYqq8rKMMzpAS6WL8OnE91dIZJyt8sVVXJBucnMMuHAStp2yezMoSiNjyRYmjSVF0huFRlds
g9qdZkxE6lnG2tHgvBhDhXVY6PFx4ulBUazyLK5ZxMZjVc5EbB7GaY6G6jKKNWFG/1hdE/QT
gcco5xWWdUuyL7EaVM5UlwD4ARuns7YXuxO6kgu2+CZNSpRz4C2ybmGLMIXm8ubldNy/KOaH
LCrzROM2LY1itQ4oE5OIe1LUT/zZcR8diFdlPApYO4zVw+ByenoWR2U/MxCvGHloEK06c1Gh
hq42XncFFng2LqV7KOG6p9idoCPY50m07DdalHH8Nb5iuwE3d2kF1mkI83WRkgK76LqMl1p4
d76g4QIYLdI+pF6wmIbWbKkxLQ0nR20bVktlG0YdLJRyNAs1bwL8aHMZ1ZlMaqNgZMIuw3tI
QWhpgxR4IHKiaW8DSE7XSROoeYz+MnpneageFpgnD77N9uq2oqh1RGm59RYUjOVk5qplVQBo
FDoCCFaU1JRPot+ON7A6LxTOwBPVkRR/4fnUK7nA08Ssgq5YQWHK4P8MuAttZcMEfGbgequF
6O5j8hplj/GYgqcpE7IJUBwFURS0xiIouapPIijnCcxYqKzZeIseuypDaCH1HF2EYSYUHLqK
Y82GO02IRc89vC5/tOChLzh6ysc2b4KyYOoNnJgVdZ4teOe43/I4E5BIgHDq07oNJIKc6Pt1
XpGW2HWVL/ioVqdCwjTQAh6mAcK1Xna18T9fUPJLDm+LVW3V9lcYpqJMSlggNfxRu6RIgvQh
eIShgRyU00KM0irJopg6HxQSFldBmBddcHD49PzDyOsMElW4ohMpN9TyWDzvPl6Og2+wQHvr
E+NmtbcXgA0z7+gVcOPehreMlNQvKFFMq1KjV5BL0wgkqiv4Li4z9eHGSdgliFsmyyCrUJAL
1DNG/mnXw/V877+vonwnXMatYOByzKhFkcUVFhZUqZTT2Vh++HvjGr81OV5CcJNTz0Lk6M83
g3xU0+buEovcZguapWFL3AxNkEGUkS/XEOHUg+gIRPrY2yR166hQMgCqz6DydSxL4cgFrCNX
rCTId8yf+LbaAzsvo3YNrLOyCM3f9ZJzdZYaqF1HC+NiRe/5MFloXeFvUQubU9YCgQ1wT8Om
5XG4LtsJVqdFUD3EwR1obbhi6bSygmpdmFV0dfw2qCpKFBLIXjD9FWq5RurwYr+K3E43CD8Z
Xx4FtWXxBWJfkKhZQX+ILFXXXsq7DBu/7M9HrLPyu/OLsvJSXCtRjCygHnmUL51GMlENYjpG
tf5rmKla+cDAuFaMdrFl4D4d5lQvdmHgaC5gENFf3iCijJMGycj2huMbbzge/5unU76+GsnM
G1ufMfPp6xOjg38xDbPRpwOZToxpSHiOa7GeWmbHca2LBlCOjhIxgnT/Dg12zWlpEbYP2uJH
tobUlZ2KH9MDmdDgmeVtPAvcMrtOb4nd5cm0pvNGdWgqoBCRLAjhqDQSurWIMAadhvSV7QhA
8F+XuT5SgSnzoNIS5XaYxzJJU9XO1mKWQUzDQTO+o8YHslUaZNQp21Fk66Tq9yjemBxdtf6/
yo5lOW4cd5+vcOW0W5WZih07Ozn4QKnZLU3rZT3cti+qjt2xuxI/yt2umezXLwCKaj5AJXtI
OQ1AFEmBIACCQL1MzbuciOjauZWYYJax6eaKNLYs1AEAdmudg3FzQ6nwx6u7ph5mWUQqHHJz
+/aKHmzvOjHuS2Zn8Dfo1hcd5rli1FytV6ocvvDB8IkajBx+C2oxEbaceduftrCUMTQQmPop
qFEJWFxSZfx3uzgUpokVkj29BYUBzKl+lsuG3JhtncaWRqVJJp62fdOoqlC6LVljQtxEZhXr
O9F5jg99EGbUepOfv8NYvbvnv5/e/1g/rt9/f17fvWyf3u/WXzfQzvbuPSbjuccP9v7Ly9d3
6hsuN69Pm+9HD+vXuw0d3By+5W+HHFBH26ctRvZs/7seIgRHEzFtcQhgyBYqWZ6JwJtXoGvF
Y+dNzVBToE/JJjg4EfiXa3S472NMrsuho/qFDFKOxtjrj5f989EtZuh9fj162Hx/MSM6FTEM
ZSEqQ9xb4BMfLsWMBfqkzTJOq8QqiGQj/EcS6zK3AfRJa9NXcICxhH5aNN3xYE9EqPPLqvKp
l6bjR7cARgNDCuJPLJh2B7i1lQ4oXEWcsm09OBpFlJzAa34xPz75M+8yD1F0GQ/0u05/mK/f
tQkIJ6bjbLqq6u3L9+3t7982P45uiUPvsU7SD48x60Z4r5r53CFNV+AIYwnrGdMkyJ1LeXJ2
Rkl7lC/9bf+A5/a36/3m7kg+US8xiOHv7f7hSOx2z7dbQs3W+7XX7djM5q0nn4HFCWwY4uRD
VWbXdnjXuKgWKWaUYea1kRcpnyhsHGsiQBJdepMfUeQz5sDe+T2P/JmM55EPa33ujRmWk7H/
bFavPFg5j5gxVtCdqSFeBTJw6BUpr1e14Hw/msWT8MxjnYG2878ZZsO71GySrHcPoZnMhT+V
SS64NXLljNPGXqqHdCTKZrf3X1bHH0+4lgkRbvrqapC27nNRJpbyhEtyaBH4Hxxe2B5/mKVz
fwGwgj34AfLZKQM7O390YSnwOZ0t+tNd57NjM8DTAJthsgfwydknDvzxxKduEnHMAbkmAHx2
fOJ1HcAffdqcgbWgSUSlv9m1i/r4sy+kV9UZ3aBUKsD25cE6+xhli//1AOakC9eIoovSycUm
6pi/+zIyTLmapyGH08A8IpdgnHBO9pEC1WzHE2fgzrg1AHAubkPvJ8w8zOkv09YyETeCM3n0
lxJZIxhu0ZKeFeRyqkFZV1aagJFNTpm2WsmX8dHoVel+AsUiz48vGBKlr8i4EzTPRKAWmBbp
N1y1jAH556nPodkN132AJpMC/6Zp/ZKJ9frp7vnxqHh7/LJ51Td6LF1+ZOIm7eOK0xpndURX
VDsek3DCXGF4+Um4mPePHii8Jv9KsaqjxCiV6pppFrXAHnTyCdetQ6j17F8irgN1rFw61PXD
I8O+gQ00d42Q79svr2swel6f3/bbJ2bLzNKIlUoEB/HiCVBEDBuRn5rMp2FxamUaj3tMORKF
h0w0oxI52RdL1/TRnDRCuN4nQSVOb+T58RTJ1OuN/TY80INGOj3kcbtzm0pWzIOiuc6xhEIa
k0sCU0cfumggqy7KBpqmiwayQzzG2YfPfSzrwZ8hh9Nq7oBvGTd/YiGdSyTD5saDbcWWeKfn
K6n4O8qjvNveP6lAvNuHze03sLt/MzNYtTI3/TO1dVLt45vzd+8crLxqa2F23nveo+jpc59+
+PzJcLaUxUzU1z/tDLA9FrRt2l+goEWL/8NeH05nf2GKdJNRWmCnqHDRXM9xFlzzWVpIUfc1
5oozj3WFEwIQpaD8YKo2Y7J0uBzoRUVcXffzmgqqmxa1SZLJIoAtZNt3bWqe78RlPTPXDhYX
lGAM55GTLi7G4tAxCGx2jcTHlhoY975WHPdp2/XW1h5/PHF+2g5LGwOrREbXfCEPiySkmBGJ
qFfO7m7ho9Tu4SdLLY/tX4bvHeTDaJUcCAxlfLQ9ht/ACbMyt0c8oECDQKXPCRNHKMZkufAb
FE2w/2TWAgPdgmkDoVwbVzcItuQOQfortg77gKTQQPNMeICn4tMp05aoOUf2AdkmwHVeYw1I
Mf8VUfyXB7Mn8TDMfnFjBt4aiOwmFyzi6sZfPOQAtWtFRHFi/aA8RC0lTjFjE0TTlHGqKhOL
urYSXoqmT0s7+LDEdDvGb1CY+4Zy8GAZ2EVrvBNh0O1M1BLenZAuZWOLstAITFpTmd8F8ajf
eKf1WmouMjVqo8kLw3O2yMrI/sUwc5HhwTkznW0JNqy1vLKbvhVmZqn6Ajdw4415lVp59OHH
fGa8rKT6pwuQ67UxyejcLxbsWYgnsG1fut4VCfryun3af1NR/o+b3b1/WkKbwZJSNZrzPIDx
/J73aqpSZn1WLjKQ/dnou/1PkOKiS2V7fjrOi0o+6rcwUuiqiTpSgQM78aWqrBAgZV0DlZUJ
Dqnh3yXmY2msDCnBWRpNr+33ze/77eOwp+6I9FbBX/05Ve8a9GsPhnFeXSydfHgjVi/oQDFW
g7KpspQPODSIZitRz/ndZTED5o/rtGKTQMiC/NR5h+Z8Is26H3OQFbKHhovz4w8npybPViA5
MAw5t1OzgzVCrQGSeVUi8SIBhrI1rTDXjhoHqFN0MJinTS5aU365GOoTlQj0J3de1rHs512h
HhFZilclWQeaGl9VevUdzZZUiA4mlqs6e3q1ZvarfENcRkbx9lav49nmy9s9VWdMn3b71ze8
zm4Gx2LxbFQR6eqFDxzPtNRXPP/wzzFHNVYrDOLQid1R3uiDqjzMQsPMjI5vcsJ+XCI8BCE6
Kk090Q6e63EMI2hbgg++BCY2n8ffLLN3UeOWOx++0y/NvD0EFfHm9xsjAj3nx3CQOLZryF6U
f1jCtWic4FnVHOJpM+MPrPHpclXwlhUigYOx/Lypq9tw3LhhWlTdGLvhAw3WXQ5+TKKt5dxd
s2WEdy2aAJjZc208nsuGcHQzl2E+jceAywmpqMnquCPBExyaJoQ1DktcB3GHejWIS72JHVus
OnAN6EwZSA2/6xoz0W11zt25+bq1IAQJPRtosOKvI7BVE5e5/+bLnA4vglERI1XNL6sRXy1A
mw+ETCiioszzbrjiwG04wxKiXJ90QG+oWTFpnUsBzMr4ThQWv7viaWJpMMp7MZsNRoN7rH9Y
jc5ek6jbbOooB4mOyueX3fsjTBX09qIkeLJ+urfCpyt4YYzxBGVZcUOz8BjI30krV3saE1eX
HaZwP0RnlPMWA127aswmGJheRPZJV2CtsYbnotUFbI6wRc5K3oFIVeDU2wL3FKbmQoXkwCZ3
90YFunxZpzjUUeUU0FaUCEYxtOZn49p2GQyncClllQZ8pIPEAtGSV/6BNw7KEP7/2r1sn/AY
Fsb7+Lbf/LOB/2z2t3/88ce/DRdJqaufLUhdd+ucVzVWKThcmjCD4AFRi5VqooDZD3WbCHBC
gmumBjupa+WV9OStTgbvwgPkq5XC9A1svpWwzDb1plVjhbArKPXQsbooQltWvsQZEMHBKCML
eiBDT+NMk+N8ssYDdQqWDJY1DBVBPIyXs7P+D4bQDbYUvA4ihIShac6BZCakOSTSVmHesBQe
WMywFJSHZYJ7l2q/+TlFj3VYRRPUnhh7yJB535QudLfer49QCbpFh6Jn4ZAz0uGFagC629fU
klShb7CpM52lPbboZ6IVaOthto3UDtSa7LH7qhiML1m0oNn61f5AI2C1NLVUY+PgyWQry84B
nQLTmYf4DfFTz4Ii1VP+zqkGUBkhO2ncM06OrRfUVgp0BMkLM95fX9u3husIgovByqnJvjGW
tQBtNb5uS8M7VVCGE3ipmewWeWw0tqaxi1pUCU+jbf25MyjVgFptOWlmMHfoF3ZI8PIQzRRS
kkFnluqkN2JyEnfOVMOxLTnJIeMm/aYcikRvqdnwB8RKO9TW9MZmNDUYOs3KvK487FHoTAr2
3Hqf9lC5LxoI/Y3JndCoLFtkJ6PpkTOdz8guZKV6+gTWhA7DgiWwWGRmvGZ9AbrO3Ov9SO/A
ldrgMcwqEwbtofvq5QMrcDJmYISmEFWTlK3HIRqhzX3na0VYljfR1XZ0LKq51RNcFCDnBJ4G
qQckv2+N5MC2HKFep8PKUEk8TQ9Y0SYHqBG2jJOg2FVdhA9EN2t26yNY6EkuAsaUycIspfNe
rJ4uKq/Mk/44rQCpWIXL+pqv+ymxsXyouFKY0pgtXEMThALTofp7xu6B2zJsNYC7/NYkOAw8
JAR2SEueFdSiCrm66RLWEFB/2OXQ3Qf6xAqvhXIrEV4MRn+EaXuUiTXuB9ZQTJ9yu9ntUQNC
dT/Gkh/reyth1rIrUm6z0ts6OmPLeuA6x9FRzklwh+n5WxuyVffdf/KAZjJyhZnvHxFpplwY
Wns9MCai5qgcsj1wmhz9VpyrXJmnYJTG5aWWhGaBNti9SPIqG0DHuBwU2eXMzchg2Wx4NtwA
e4VJ8rSgWmdhiuDzkdZbSUWeWJ8RBsBN4OlEqMzKvJxYZeRwRVEx3djgkQnoSPqUhj2XpdEm
8sq9cexMhzp9Ufch2B1joGpiOwiI4EtAtGzFKUKPx+8mMEpb56RLg4HBM/4ogCi6Lp3AXtHZ
XRiPl8TnoUvmRFHjEXCLvq0wTTDUibDpjI94U9y7nGBtGH3pFuizxo7RTnixfaKJiq9dp5AY
W5GU5LbjA7XnIEaxG9NbHLY1T+scZK/0PqG6vz4xCNqipniR7ugEb9uqFS7zGJQfzqrWjaDd
nPprAZ5MefENGNckntwQvJsx6iTyfy3c98SKUgEA

--tThc/1wpZn/ma/RB--
