Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AE12A43EC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 12:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgKCLT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 06:19:28 -0500
Received: from mga09.intel.com ([134.134.136.24]:16030 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728552AbgKCLTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 06:19:25 -0500
IronPort-SDR: PxuuaRrkRvycx1p1GH4LeMMjGIM7wTKwfZX42s2JsJKGKqvFCrzy1JVQp+Qj2kUmfsXFb4Dgtj
 L0skUw41ajwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="169168644"
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="gz'50?scan'50,208,50";a="169168644"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 03:19:23 -0800
IronPort-SDR: 0MK8m4K0Rw+WBnBdfZ3KW8SMHdF78gcDNbUcv9SNzRu9kmc+y71Q8J5EPlvS5NAuCzMVnuz5+n
 quSA4h4SGX2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="gz'50?scan'50,208,50";a="305782489"
Received: from lkp-server02.sh.intel.com (HELO e61783667810) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 03 Nov 2020 03:19:21 -0800
Received: from kbuild by e61783667810 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kZuLQ-0000Cq-Md; Tue, 03 Nov 2020 11:19:20 +0000
Date:   Tue, 3 Nov 2020 19:18:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: drivers/rtc/rtc-m41t80.c:736:21: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202011031948.KOuq5tip-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b7cbaf59f62f8ab8f157698f9e31642bff525bd0
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   9 weeks ago
config: sh-randconfig-s032-20201031 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-76-gf680124b-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   drivers/rtc/rtc-m41t80.c:736:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/rtc/rtc-m41t80.c:736:21: sparse:     expected int const *__gu_addr
   drivers/rtc/rtc-m41t80.c:736:21: sparse:     got int [noderef] __user *
>> drivers/rtc/rtc-m41t80.c:736:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> drivers/rtc/rtc-m41t80.c:736:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/rtc/rtc-m41t80.c:736:21: sparse:     got int const *__gu_addr

vim +736 drivers/rtc/rtc-m41t80.c

617780d290bd6e Atsushi Nemoto      2007-07-17  702  
617780d290bd6e Atsushi Nemoto      2007-07-17  703  /**
617780d290bd6e Atsushi Nemoto      2007-07-17  704   *	wdt_ioctl:
617780d290bd6e Atsushi Nemoto      2007-07-17  705   *	@file: file handle to the device
617780d290bd6e Atsushi Nemoto      2007-07-17  706   *	@cmd: watchdog command
617780d290bd6e Atsushi Nemoto      2007-07-17  707   *	@arg: argument pointer
617780d290bd6e Atsushi Nemoto      2007-07-17  708   *
617780d290bd6e Atsushi Nemoto      2007-07-17  709   *	The watchdog API defines a common set of functions for all watchdogs
617780d290bd6e Atsushi Nemoto      2007-07-17  710   *	according to their available features. We only actually usefully support
617780d290bd6e Atsushi Nemoto      2007-07-17  711   *	querying capabilities and current status.
617780d290bd6e Atsushi Nemoto      2007-07-17  712   */
55929332c92e5d Arnd Bergmann       2010-04-27  713  static int wdt_ioctl(struct file *file, unsigned int cmd,
617780d290bd6e Atsushi Nemoto      2007-07-17  714  		     unsigned long arg)
617780d290bd6e Atsushi Nemoto      2007-07-17  715  {
617780d290bd6e Atsushi Nemoto      2007-07-17  716  	int new_margin, rv;
617780d290bd6e Atsushi Nemoto      2007-07-17  717  	static struct watchdog_info ident = {
617780d290bd6e Atsushi Nemoto      2007-07-17  718  		.options = WDIOF_POWERUNDER | WDIOF_KEEPALIVEPING |
617780d290bd6e Atsushi Nemoto      2007-07-17  719  			WDIOF_SETTIMEOUT,
617780d290bd6e Atsushi Nemoto      2007-07-17  720  		.firmware_version = 1,
617780d290bd6e Atsushi Nemoto      2007-07-17  721  		.identity = "M41T80 WTD"
617780d290bd6e Atsushi Nemoto      2007-07-17  722  	};
617780d290bd6e Atsushi Nemoto      2007-07-17  723  
617780d290bd6e Atsushi Nemoto      2007-07-17  724  	switch (cmd) {
617780d290bd6e Atsushi Nemoto      2007-07-17  725  	case WDIOC_GETSUPPORT:
617780d290bd6e Atsushi Nemoto      2007-07-17  726  		return copy_to_user((struct watchdog_info __user *)arg, &ident,
617780d290bd6e Atsushi Nemoto      2007-07-17  727  				    sizeof(ident)) ? -EFAULT : 0;
617780d290bd6e Atsushi Nemoto      2007-07-17  728  
617780d290bd6e Atsushi Nemoto      2007-07-17  729  	case WDIOC_GETSTATUS:
617780d290bd6e Atsushi Nemoto      2007-07-17  730  	case WDIOC_GETBOOTSTATUS:
617780d290bd6e Atsushi Nemoto      2007-07-17  731  		return put_user(boot_flag, (int __user *)arg);
617780d290bd6e Atsushi Nemoto      2007-07-17  732  	case WDIOC_KEEPALIVE:
617780d290bd6e Atsushi Nemoto      2007-07-17  733  		wdt_ping();
617780d290bd6e Atsushi Nemoto      2007-07-17  734  		return 0;
617780d290bd6e Atsushi Nemoto      2007-07-17  735  	case WDIOC_SETTIMEOUT:
617780d290bd6e Atsushi Nemoto      2007-07-17 @736  		if (get_user(new_margin, (int __user *)arg))
617780d290bd6e Atsushi Nemoto      2007-07-17  737  			return -EFAULT;
617780d290bd6e Atsushi Nemoto      2007-07-17  738  		/* Arbitrary, can't find the card's limits */
617780d290bd6e Atsushi Nemoto      2007-07-17  739  		if (new_margin < 1 || new_margin > 124)
617780d290bd6e Atsushi Nemoto      2007-07-17  740  			return -EINVAL;
617780d290bd6e Atsushi Nemoto      2007-07-17  741  		wdt_margin = new_margin;
617780d290bd6e Atsushi Nemoto      2007-07-17  742  		wdt_ping();
c3e04915b8674a Gustavo A. R. Silva 2018-10-04  743  		/* Fall through */
617780d290bd6e Atsushi Nemoto      2007-07-17  744  	case WDIOC_GETTIMEOUT:
617780d290bd6e Atsushi Nemoto      2007-07-17  745  		return put_user(wdt_margin, (int __user *)arg);
617780d290bd6e Atsushi Nemoto      2007-07-17  746  
617780d290bd6e Atsushi Nemoto      2007-07-17  747  	case WDIOC_SETOPTIONS:
617780d290bd6e Atsushi Nemoto      2007-07-17  748  		if (copy_from_user(&rv, (int __user *)arg, sizeof(int)))
617780d290bd6e Atsushi Nemoto      2007-07-17  749  			return -EFAULT;
617780d290bd6e Atsushi Nemoto      2007-07-17  750  
617780d290bd6e Atsushi Nemoto      2007-07-17  751  		if (rv & WDIOS_DISABLECARD) {
a737e835e5769e Joe Perches         2015-04-16  752  			pr_info("disable watchdog\n");
617780d290bd6e Atsushi Nemoto      2007-07-17  753  			wdt_disable();
617780d290bd6e Atsushi Nemoto      2007-07-17  754  		}
617780d290bd6e Atsushi Nemoto      2007-07-17  755  
617780d290bd6e Atsushi Nemoto      2007-07-17  756  		if (rv & WDIOS_ENABLECARD) {
a737e835e5769e Joe Perches         2015-04-16  757  			pr_info("enable watchdog\n");
617780d290bd6e Atsushi Nemoto      2007-07-17  758  			wdt_ping();
617780d290bd6e Atsushi Nemoto      2007-07-17  759  		}
617780d290bd6e Atsushi Nemoto      2007-07-17  760  
617780d290bd6e Atsushi Nemoto      2007-07-17  761  		return -EINVAL;
617780d290bd6e Atsushi Nemoto      2007-07-17  762  	}
617780d290bd6e Atsushi Nemoto      2007-07-17  763  	return -ENOTTY;
617780d290bd6e Atsushi Nemoto      2007-07-17  764  }
617780d290bd6e Atsushi Nemoto      2007-07-17  765  

:::::: The code at line 736 was first introduced by commit
:::::: 617780d290bd6eb2b260928c6acff5b7c6084154 rtc: watchdog support for rtc-m41t80 driver

:::::: TO: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--+QahgC5+KEYLbs62
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--+QahgC5+KEYLbs62--
