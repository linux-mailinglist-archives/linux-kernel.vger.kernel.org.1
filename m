Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04634269E17
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 07:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgIOFzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 01:55:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:16584 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgIOFzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 01:55:19 -0400
IronPort-SDR: yskPSr/GknznJN/S1MrCwH5mW5cRgPqCW1I7sazOFEszeiCjKeS899tAdQO3syza0+MrPz7Siv
 WSTI/o6k+WqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="159251427"
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; 
   d="gz'50?scan'50,208,50";a="159251427"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 22:54:56 -0700
IronPort-SDR: n6dtUlBiHVQsFma0bCnifT4PmOJBg90XduLRiNt1YT5r/HrDGEvK90TFvBq+Llvd7HBvBhtYkg
 8zYLXCe4KXDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; 
   d="gz'50?scan'50,208,50";a="287863512"
Received: from lkp-server01.sh.intel.com (HELO 96654786cb26) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 14 Sep 2020 22:54:53 -0700
Received: from kbuild by 96654786cb26 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kI3vZ-00001B-A8; Tue, 15 Sep 2020 05:54:53 +0000
Date:   Tue, 15 Sep 2020 13:54:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: drivers/tty/vt/vt_ioctl.c:1004:21: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202009151322.EGgsJItW%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fc4f28bb3daf3265d6bc5f73b497306985bb23ab
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   2 weeks ago
config: sh-randconfig-s031-20200913 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-191-g10164920-dirty
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/tty/vt/vt_ioctl.c:1004:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] __user * @@
   drivers/tty/vt/vt_ioctl.c:1004:21: sparse:     expected unsigned short const *__gu_addr
   drivers/tty/vt/vt_ioctl.c:1004:21: sparse:     got unsigned short [noderef] __user *
>> drivers/tty/vt/vt_ioctl.c:1004:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
>> drivers/tty/vt/vt_ioctl.c:1004:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/vt_ioctl.c:1004:21: sparse:     got unsigned short const *__gu_addr
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] __user * @@
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse:     expected unsigned short const *__gu_addr
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse:     got unsigned short [noderef] __user *
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse:     got unsigned short const *__gu_addr
--
   drivers/tty/vt/vt.c:4301:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char [noderef] __user * @@
   drivers/tty/vt/vt.c:4301:13: sparse:     expected char const *__gu_addr
   drivers/tty/vt/vt.c:4301:13: sparse:     got char [noderef] __user *
>> drivers/tty/vt/vt.c:4301:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
>> drivers/tty/vt/vt.c:4301:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/vt.c:4301:13: sparse:     got char const *__gu_addr
   drivers/tty/vt/vt.c:225:5: sparse: sparse: symbol 'console_blank_hook' was not declared. Should it be static?
   drivers/tty/vt/vt.c:2991:19: sparse: sparse: symbol 'console_driver' was not declared. Should it be static?
   drivers/tty/vt/vt.c:3147:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char [noderef] __user *p @@
   drivers/tty/vt/vt.c:3147:13: sparse:     expected char const *__gu_addr
   drivers/tty/vt/vt.c:3147:13: sparse:     got char [noderef] __user *p
   drivers/tty/vt/vt.c:3147:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   drivers/tty/vt/vt.c:3147:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/vt.c:3147:13: sparse:     got char const *__gu_addr
   drivers/tty/vt/vt.c:3200:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char [noderef] __user * @@
   drivers/tty/vt/vt.c:3200:37: sparse:     expected char const *__gu_addr
   drivers/tty/vt/vt.c:3200:37: sparse:     got char [noderef] __user *
   drivers/tty/vt/vt.c:3200:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   drivers/tty/vt/vt.c:3200:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/vt.c:3200:37: sparse:     got char const *__gu_addr
   drivers/tty/vt/vt.c:3213:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] [usertype] __user * @@
   drivers/tty/vt/vt.c:3213:29: sparse:     expected signed int const *__gu_addr
   drivers/tty/vt/vt.c:3213:29: sparse:     got signed int [noderef] [usertype] __user *
>> drivers/tty/vt/vt.c:3213:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int const *__gu_addr @@
   drivers/tty/vt/vt.c:3213:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/vt.c:3213:29: sparse:     got signed int const *__gu_addr
   drivers/tty/vt/vt.c:3032:13: sparse: sparse: context imbalance in 'vt_console_print' - wrong count at exit
--
   drivers/tty/vt/keyboard.c:1730:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tty/vt/keyboard.c:1730:21: sparse:     expected unsigned int const *__gu_addr
   drivers/tty/vt/keyboard.c:1730:21: sparse:     got unsigned int [noderef] __user *
>> drivers/tty/vt/keyboard.c:1730:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
>> drivers/tty/vt/keyboard.c:1730:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/keyboard.c:1730:21: sparse:     got unsigned int const *__gu_addr
   drivers/tty/vt/keyboard.c:1768:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tty/vt/keyboard.c:1768:21: sparse:     expected unsigned int const *__gu_addr
   drivers/tty/vt/keyboard.c:1768:21: sparse:     got unsigned int [noderef] __user *
   drivers/tty/vt/keyboard.c:1768:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/tty/vt/keyboard.c:1768:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/keyboard.c:1768:21: sparse:     got unsigned int const *__gu_addr

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
vim +1004 drivers/tty/vt/vt_ioctl.c

5422337d569ead drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   821  
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   822  /*
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   823   * We handle the console-specific ioctl's here.  We allow the
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   824   * capability to modify any console, not just the fg_console.
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   825   */
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   826  int vt_ioctl(struct tty_struct *tty,
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   827  	     unsigned int cmd, unsigned long arg)
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   828  {
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   829  	struct vc_data *vc = tty->driver_data;
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   830  	void __user *up = (void __user *)arg;
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   831  	int i, perm;
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   832  	int ret;
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   833  
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   834  	/*
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   835  	 * To have permissions to do most of the vt ioctls, we either have
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   836  	 * to be the owner of the tty, or have CAP_SYS_TTY_CONFIG.
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   837  	 */
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   838  	perm = 0;
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   839  	if (current->signal->tty == tty || capable(CAP_SYS_TTY_CONFIG))
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   840  		perm = 1;
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   841  
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   842  	ret = vt_k_ioctl(tty, cmd, arg, perm);
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   843  	if (ret != -ENOIOCTLCMD)
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   844  		return ret;
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   845  
bfbbdfa4de133e drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   846  	ret = vt_io_ioctl(vc, cmd, up, perm);
bfbbdfa4de133e drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   847  	if (ret != -ENOIOCTLCMD)
bfbbdfa4de133e drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   848  		return ret;
bfbbdfa4de133e drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   849  
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   850  	switch (cmd) {
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   851  	case TIOCLINUX:
832a62ab6b7d32 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   852  		return tioclinux(tty, arg);
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   853  	case VT_SETMODE:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   854  	{
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   855  		struct vt_mode tmp;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   856  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   857  		if (!perm)
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox           2012-03-02   858  			return -EPERM;
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   859  		if (copy_from_user(&tmp, up, sizeof(struct vt_mode)))
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   860  			return -EFAULT;
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   861  		if (tmp.mode != VT_AUTO && tmp.mode != VT_PROCESS)
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   862  			return -EINVAL;
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   863  
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn        2011-01-25   864  		console_lock();
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   865  		vc->vt_mode = tmp;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   866  		/* the frsig is ignored, so we set it to 0 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   867  		vc->vt_mode.frsig = 0;
8b6312f4dcc1ef drivers/char/vt_ioctl.c   Eric W. Biederman  2007-02-10   868  		put_pid(vc->vt_pid);
8b6312f4dcc1ef drivers/char/vt_ioctl.c   Eric W. Biederman  2007-02-10   869  		vc->vt_pid = get_pid(task_pid(current));
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   870  		/* no switch is required -- saw@shade.msu.ru */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   871  		vc->vt_newvt = -1;
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn        2011-01-25   872  		console_unlock();
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox           2008-04-30   873  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   874  	}
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   875  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   876  	case VT_GETMODE:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   877  	{
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   878  		struct vt_mode tmp;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   879  		int rc;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   880  
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn        2011-01-25   881  		console_lock();
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   882  		memcpy(&tmp, &vc->vt_mode, sizeof(struct vt_mode));
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn        2011-01-25   883  		console_unlock();
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   884  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   885  		rc = copy_to_user(up, &tmp, sizeof(struct vt_mode));
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox           2008-04-30   886  		if (rc)
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   887  			return -EFAULT;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox           2008-04-30   888  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   889  	}
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   890  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   891  	/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   892  	 * Returns global vt state. Note that VT 0 is always open, since
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   893  	 * it's an alias for the current VT, and people can't use it here.
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   894  	 * We cannot return state for more than 16 VTs, since v_state is short.
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   895  	 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   896  	case VT_GETSTATE:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   897  	{
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   898  		struct vt_stat __user *vtstat = up;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   899  		unsigned short state, mask;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   900  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   901  		if (put_user(fg_console + 1, &vtstat->v_active))
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   902  			return -EFAULT;
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   903  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   904  		state = 1;	/* /dev/tty0 is always open */
7cf64b18b0b96e drivers/tty/vt/vt_ioctl.c Eric Biggers       2020-03-21   905  		console_lock(); /* required by vt_in_use() */
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox           2008-04-30   906  		for (i = 0, mask = 2; i < MAX_NR_CONSOLES && mask;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox           2008-04-30   907  				++i, mask <<= 1)
e587e8f17433dd drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-02-19   908  			if (vt_in_use(i))
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   909  				state |= mask;
7cf64b18b0b96e drivers/tty/vt/vt_ioctl.c Eric Biggers       2020-03-21   910  		console_unlock();
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   911  		return put_user(state, &vtstat->v_state);
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   912  	}
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   913  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   914  	/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   915  	 * Returns the first available (non-opened) console.
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   916  	 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   917  	case VT_OPENQRY:
7cf64b18b0b96e drivers/tty/vt/vt_ioctl.c Eric Biggers       2020-03-21   918  		console_lock(); /* required by vt_in_use() */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   919  		for (i = 0; i < MAX_NR_CONSOLES; ++i)
e587e8f17433dd drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-02-19   920  			if (!vt_in_use(i))
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   921  				break;
7cf64b18b0b96e drivers/tty/vt/vt_ioctl.c Eric Biggers       2020-03-21   922  		console_unlock();
eca734d8f0043e drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   923  		i = i < MAX_NR_CONSOLES ? (i+1) : -1;
eca734d8f0043e drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   924  		return put_user(i, (int __user *)arg);
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   925  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   926  	/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   927  	 * ioctl(fd, VT_ACTIVATE, num) will cause us to switch to vt # num,
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   928  	 * with num >= 1 (switches to vt 0, our console, are not allowed, just
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   929  	 * to preserve sanity).
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   930  	 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   931  	case VT_ACTIVATE:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   932  		if (!perm)
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox           2012-03-02   933  			return -EPERM;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   934  		if (arg == 0 || arg > MAX_NR_CONSOLES)
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   935  			return -ENXIO;
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   936  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   937  		arg--;
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn        2011-01-25   938  		console_lock();
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox           2008-04-30   939  		ret = vc_allocate(arg);
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn        2011-01-25   940  		console_unlock();
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox           2008-04-30   941  		if (ret)
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   942  			return ret;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   943  		set_console(arg);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox           2008-04-30   944  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   945  
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox           2009-09-19   946  	case VT_SETACTIVATE:
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox           2009-09-19   947  		if (!perm)
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox           2012-03-02   948  			return -EPERM;
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox           2009-09-19   949  
ebf1efbb1a7f79 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   950  		return vt_setactivate(up);
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox           2009-09-19   951  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   952  	/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   953  	 * wait until the specified VT has been activated
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   954  	 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   955  	case VT_WAITACTIVE:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   956  		if (!perm)
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox           2012-03-02   957  			return -EPERM;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   958  		if (arg == 0 || arg > MAX_NR_CONSOLES)
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   959  			return -ENXIO;
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   960  		return vt_waitactive(arg);
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   961  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   962  	/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   963  	 * If a vt is under process control, the kernel will not switch to it
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   964  	 * immediately, but postpone the operation until the process calls this
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   965  	 * ioctl, allowing the switch to complete.
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   966  	 *
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   967  	 * According to the X sources this is the behavior:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   968  	 *	0:	pending switch-from not OK
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   969  	 *	1:	pending switch-from OK
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   970  	 *	2:	completed switch-to OK
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   971  	 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   972  	case VT_RELDISP:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   973  		if (!perm)
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox           2012-03-02   974  			return -EPERM;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   975  
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox           2012-03-02   976  		console_lock();
535082d9078d0b drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   977  		ret = vt_reldisp(vc, arg);
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox           2012-03-02   978  		console_unlock();
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   979  
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   980  		return ret;
535082d9078d0b drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   981  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   982  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   983  	 /*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   984  	  * Disallocate memory associated to VT (but leave VT1)
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   985  	  */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   986  	 case VT_DISALLOCATE:
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   987  		if (arg > MAX_NR_CONSOLES)
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   988  			return -ENXIO;
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   989  
421b40a6286ee3 drivers/tty/vt/vt_ioctl.c Peter Hurley       2013-05-17   990  		if (arg == 0)
421b40a6286ee3 drivers/tty/vt/vt_ioctl.c Peter Hurley       2013-05-17   991  			vt_disallocate_all();
421b40a6286ee3 drivers/tty/vt/vt_ioctl.c Peter Hurley       2013-05-17   992  		else
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15   993  			return vt_disallocate(--arg);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox           2008-04-30   994  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   995  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   996  	case VT_RESIZE:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   997  	{
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16   998  		struct vt_sizes __user *vtsizes = up;
e400b6ec4ede4d drivers/char/vt_ioctl.c   Antonino A. Daplas 2007-10-16   999  		struct vc_data *vc;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16  1000  		ushort ll,cc;
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15  1001  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16  1002  		if (!perm)
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox           2012-03-02  1003  			return -EPERM;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16 @1004  		if (get_user(ll, &vtsizes->v_rows) ||
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16  1005  		    get_user(cc, &vtsizes->v_cols))
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15  1006  			return -EFAULT;
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15  1007  
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn        2011-01-25  1008  		console_lock();
e400b6ec4ede4d drivers/char/vt_ioctl.c   Antonino A. Daplas 2007-10-16  1009  		for (i = 0; i < MAX_NR_CONSOLES; i++) {
e400b6ec4ede4d drivers/char/vt_ioctl.c   Antonino A. Daplas 2007-10-16  1010  			vc = vc_cons[i].d;
e400b6ec4ede4d drivers/char/vt_ioctl.c   Antonino A. Daplas 2007-10-16  1011  
e400b6ec4ede4d drivers/char/vt_ioctl.c   Antonino A. Daplas 2007-10-16  1012  			if (vc) {
e400b6ec4ede4d drivers/char/vt_ioctl.c   Antonino A. Daplas 2007-10-16  1013  				vc->vc_resize_user = 1;
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox           2012-03-02  1014  				/* FIXME: review v tty lock */
8c9a9dd0fa3a26 drivers/char/vt_ioctl.c   Alan Cox           2008-08-15  1015  				vc_resize(vc_cons[i].d, cc, ll);
e400b6ec4ede4d drivers/char/vt_ioctl.c   Antonino A. Daplas 2007-10-16  1016  			}
e400b6ec4ede4d drivers/char/vt_ioctl.c   Antonino A. Daplas 2007-10-16  1017  		}
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn        2011-01-25  1018  		console_unlock();
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox           2008-04-30  1019  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16  1020  	}
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16  1021  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16  1022  	case VT_RESIZEX:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16  1023  		if (!perm)
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox           2012-03-02  1024  			return -EPERM;
6cd1ed50efd882 drivers/tty/vt/vt_ioctl.c Eric Dumazet       2020-02-10  1025  
5422337d569ead drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15  1026  		return vt_resizex(vc, up);
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16  1027  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16  1028  	case VT_LOCKSWITCH:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16  1029  		if (!capable(CAP_SYS_TTY_CONFIG))
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox           2012-03-02  1030  			return -EPERM;
f400991bf872de drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-02-19  1031  		vt_dont_switch = true;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox           2008-04-30  1032  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16  1033  	case VT_UNLOCKSWITCH:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16  1034  		if (!capable(CAP_SYS_TTY_CONFIG))
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox           2012-03-02  1035  			return -EPERM;
f400991bf872de drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-02-19  1036  		vt_dont_switch = false;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox           2008-04-30  1037  		break;
533475d3d48eb8 drivers/char/vt_ioctl.c   Samuel Thibault    2006-08-27  1038  	case VT_GETHIFONTMASK:
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15  1039  		return put_user(vc->vc_hi_font_mask,
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox           2008-04-30  1040  					(unsigned short __user *)arg);
8b92e87d39bfd0 drivers/char/vt_ioctl.c   Alan Cox           2009-09-19  1041  	case VT_WAITEVENT:
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15  1042  		return vt_event_wait_ioctl((struct vt_event __user *)arg);
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16  1043  	default:
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15  1044  		return -ENOIOCTLCMD;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16  1045  	}
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15  1046  
0ce8179e248023 drivers/tty/vt/vt_ioctl.c Jiri Slaby         2020-06-15  1047  	return 0;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16  1048  }
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds     2005-04-16  1049  

:::::: The code at line 1004 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--tKW2IUtsqtDRztdT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--tKW2IUtsqtDRztdT--
