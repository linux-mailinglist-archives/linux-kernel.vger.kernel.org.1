Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5942E2A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 10:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgLYJaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 04:30:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:38643 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbgLYJaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 04:30:18 -0500
IronPort-SDR: L+lUTmDxGbSDHourkE3EErM1GfjW7KBnI/lDLo+e8RMIVC6uvI91fFLXrHjZuJilO2mnRsatCb
 NAncy0Gtdf5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9845"; a="155417007"
X-IronPort-AV: E=Sophos;i="5.78,447,1599548400"; 
   d="gz'50?scan'50,208,50";a="155417007"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2020 01:29:35 -0800
IronPort-SDR: nnt9HqfyvXgm3odn8T7iEhsRFChNIVoOV68PPIXmgwDu4tKdSQ/nYiEtpdXuxaNr/DLGqPmxOZ
 ULGaDkxOqEpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,447,1599548400"; 
   d="gz'50?scan'50,208,50";a="563976154"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 25 Dec 2020 01:29:33 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ksjPg-0001Sa-Qd; Fri, 25 Dec 2020 09:29:32 +0000
Date:   Fri, 25 Dec 2020 17:28:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/misc/altera-stapl/altera.c:2113:1: warning: the frame size
 of 4236 bytes is larger than 1024 bytes
Message-ID: <202012251743.OoKhvFvl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   71c5f03154ac1cb27423b984743ccc2f5d11d14d
commit: 18c07d23da5a48525b2955aa269b8bb108c19300 csky: Fixup calltrace panic
date:   8 months ago
config: csky-randconfig-r013-20201225 (attached as .config)
compiler: csky-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=18c07d23da5a48525b2955aa269b8bb108c19300
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 18c07d23da5a48525b2955aa269b8bb108c19300
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=csky 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/misc/altera-stapl/altera.c: In function 'altera_execute':
>> drivers/misc/altera-stapl/altera.c:2113:1: warning: the frame size of 4236 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    2113 | }
         | ^
--
   In file included from include/linux/kernel.h:11,
                    from drivers/net/ethernet/marvell/sky2.c:16:
   include/asm-generic/fixmap.h: In function 'fix_to_virt':
   include/asm-generic/fixmap.h:32:19: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
      32 |  BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |                   ^~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   include/linux/compiler.h:330:3: note: in expansion of macro 'if'
     330 |   if (!(condition))     \
         |   ^~
   include/linux/compiler.h:338:2: note: in expansion of macro '__compiletime_assert'
     338 |  __compiletime_assert(condition, msg, prefix, suffix)
         |  ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |  ^~~~~~~~~~~~~~~~
   include/asm-generic/fixmap.h:32:2: note: in expansion of macro 'BUILD_BUG_ON'
      32 |  BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |  ^~~~~~~~~~~~
   include/asm-generic/fixmap.h:32:19: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
      32 |  BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |                   ^~
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   include/linux/compiler.h:330:3: note: in expansion of macro 'if'
     330 |   if (!(condition))     \
         |   ^~
   include/linux/compiler.h:338:2: note: in expansion of macro '__compiletime_assert'
     338 |  __compiletime_assert(condition, msg, prefix, suffix)
         |  ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |  ^~~~~~~~~~~~~~~~
   include/asm-generic/fixmap.h:32:2: note: in expansion of macro 'BUILD_BUG_ON'
      32 |  BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |  ^~~~~~~~~~~~
   include/asm-generic/fixmap.h:32:19: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
      32 |  BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |                   ^~
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
      69 |  (cond) ?     \
         |   ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   include/linux/compiler.h:330:3: note: in expansion of macro 'if'
     330 |   if (!(condition))     \
         |   ^~
   include/linux/compiler.h:338:2: note: in expansion of macro '__compiletime_assert'
     338 |  __compiletime_assert(condition, msg, prefix, suffix)
         |  ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |  ^~~~~~~~~~~~~~~~
   include/asm-generic/fixmap.h:32:2: note: in expansion of macro 'BUILD_BUG_ON'
      32 |  BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |  ^~~~~~~~~~~~
   In function 'sky2_name',
       inlined from 'sky2_probe' at drivers/net/ethernet/marvell/sky2.c:5048:2:
>> drivers/net/ethernet/marvell/sky2.c:4903:3: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
    4903 |   strncpy(buf, name[chipid - CHIP_ID_YUKON_XL], sz);
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/net/ethernet/intel/e1000/e1000.h:10,
                    from drivers/net/ethernet/intel/e1000/e1000_main.c:4:
   include/asm-generic/fixmap.h: In function 'fix_to_virt':
   include/asm-generic/fixmap.h:32:19: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
      32 |  BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |                   ^~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   include/linux/compiler.h:330:3: note: in expansion of macro 'if'
     330 |   if (!(condition))     \
         |   ^~
   include/linux/compiler.h:338:2: note: in expansion of macro '__compiletime_assert'
     338 |  __compiletime_assert(condition, msg, prefix, suffix)
         |  ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |  ^~~~~~~~~~~~~~~~
   include/asm-generic/fixmap.h:32:2: note: in expansion of macro 'BUILD_BUG_ON'
      32 |  BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |  ^~~~~~~~~~~~
   include/asm-generic/fixmap.h:32:19: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
      32 |  BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |                   ^~
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   include/linux/compiler.h:330:3: note: in expansion of macro 'if'
     330 |   if (!(condition))     \
         |   ^~
   include/linux/compiler.h:338:2: note: in expansion of macro '__compiletime_assert'
     338 |  __compiletime_assert(condition, msg, prefix, suffix)
         |  ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |  ^~~~~~~~~~~~~~~~
   include/asm-generic/fixmap.h:32:2: note: in expansion of macro 'BUILD_BUG_ON'
      32 |  BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |  ^~~~~~~~~~~~
   include/asm-generic/fixmap.h:32:19: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
      32 |  BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |                   ^~
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
      69 |  (cond) ?     \
         |   ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   include/linux/compiler.h:330:3: note: in expansion of macro 'if'
     330 |   if (!(condition))     \
         |   ^~
   include/linux/compiler.h:338:2: note: in expansion of macro '__compiletime_assert'
     338 |  __compiletime_assert(condition, msg, prefix, suffix)
         |  ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |  ^~~~~~~~~~~~~~~~
   include/asm-generic/fixmap.h:32:2: note: in expansion of macro 'BUILD_BUG_ON'
      32 |  BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |  ^~~~~~~~~~~~
   In file included from drivers/net/ethernet/intel/e1000/e1000_hw.h:11,
                    from drivers/net/ethernet/intel/e1000/e1000.h:54,
                    from drivers/net/ethernet/intel/e1000/e1000_main.c:4:
   drivers/net/ethernet/intel/e1000/e1000_osdep.h: At top level:
>> drivers/net/ethernet/intel/e1000/e1000_osdep.h:13: warning: "CONFIG_RAM_BASE" redefined
      13 | #define CONFIG_RAM_BASE         0x60000
         | 
   In file included from include/linux/kconfig.h:5,
                    from <command-line>:
   ./include/generated/autoconf.h:1818: note: this is the location of the previous definition
    1818 | #define CONFIG_RAM_BASE 0x0
         | 
--
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/net/ethernet/intel/e1000/e1000.h:10,
                    from drivers/net/ethernet/intel/e1000/e1000_hw.c:8:
   include/asm-generic/fixmap.h: In function 'fix_to_virt':
   include/asm-generic/fixmap.h:32:19: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
      32 |  BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |                   ^~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   include/linux/compiler.h:330:3: note: in expansion of macro 'if'
     330 |   if (!(condition))     \
         |   ^~
   include/linux/compiler.h:338:2: note: in expansion of macro '__compiletime_assert'
     338 |  __compiletime_assert(condition, msg, prefix, suffix)
         |  ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |  ^~~~~~~~~~~~~~~~
   include/asm-generic/fixmap.h:32:2: note: in expansion of macro 'BUILD_BUG_ON'
      32 |  BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |  ^~~~~~~~~~~~
   include/asm-generic/fixmap.h:32:19: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
      32 |  BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |                   ^~
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   include/linux/compiler.h:330:3: note: in expansion of macro 'if'
     330 |   if (!(condition))     \
         |   ^~
   include/linux/compiler.h:338:2: note: in expansion of macro '__compiletime_assert'
     338 |  __compiletime_assert(condition, msg, prefix, suffix)
         |  ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |  ^~~~~~~~~~~~~~~~
   include/asm-generic/fixmap.h:32:2: note: in expansion of macro 'BUILD_BUG_ON'
      32 |  BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |  ^~~~~~~~~~~~
   include/asm-generic/fixmap.h:32:19: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
      32 |  BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |                   ^~
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
      69 |  (cond) ?     \
         |   ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   include/linux/compiler.h:330:3: note: in expansion of macro 'if'
     330 |   if (!(condition))     \
         |   ^~
   include/linux/compiler.h:338:2: note: in expansion of macro '__compiletime_assert'
     338 |  __compiletime_assert(condition, msg, prefix, suffix)
         |  ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |  ^~~~~~~~~~~~~~~~
   include/asm-generic/fixmap.h:32:2: note: in expansion of macro 'BUILD_BUG_ON'
      32 |  BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |  ^~~~~~~~~~~~
   In file included from drivers/net/ethernet/intel/e1000/e1000_hw.h:11,
                    from drivers/net/ethernet/intel/e1000/e1000.h:54,
                    from drivers/net/ethernet/intel/e1000/e1000_hw.c:8:
   drivers/net/ethernet/intel/e1000/e1000_osdep.h: At top level:
>> drivers/net/ethernet/intel/e1000/e1000_osdep.h:13: warning: "CONFIG_RAM_BASE" redefined
      13 | #define CONFIG_RAM_BASE         0x60000
         | 
   In file included from include/linux/kconfig.h:5,
                    from <command-line>:
   ./include/generated/autoconf.h:1818: note: this is the location of the previous definition
    1818 | #define CONFIG_RAM_BASE 0x0
         | 
   drivers/net/ethernet/intel/e1000/e1000_hw.c: In function 'e1000_phy_init_script':
   drivers/net/ethernet/intel/e1000/e1000_hw.c:132:6: warning: variable 'ret_val' set but not used [-Wunused-but-set-variable]
     132 |  u32 ret_val;
         |      ^~~~~~~
   drivers/net/ethernet/intel/e1000/e1000_hw.c: In function 'e1000_reset_hw':
   drivers/net/ethernet/intel/e1000/e1000_hw.c:380:6: warning: variable 'icr' set but not used [-Wunused-but-set-variable]
     380 |  u32 icr;
         |      ^~~
   drivers/net/ethernet/intel/e1000/e1000_hw.c: In function 'e1000_check_for_link':
   drivers/net/ethernet/intel/e1000/e1000_hw.c:2378:6: warning: variable 'signal' set but not used [-Wunused-but-set-variable]
    2378 |  u32 signal = 0;
         |      ^~~~~~
   drivers/net/ethernet/intel/e1000/e1000_hw.c:2374:6: warning: variable 'ctrl' set but not used [-Wunused-but-set-variable]
    2374 |  u32 ctrl;
         |      ^~~~
   drivers/net/ethernet/intel/e1000/e1000_hw.c:2373:6: warning: variable 'rxcw' set but not used [-Wunused-but-set-variable]
    2373 |  u32 rxcw = 0;
         |      ^~~~
   drivers/net/ethernet/intel/e1000/e1000_hw.c: In function 'e1000_clear_hw_cntrs':
   drivers/net/ethernet/intel/e1000/e1000_hw.c:4678:15: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
    4678 |  volatile u32 temp;
         |               ^~~~


vim +2113 drivers/misc/altera-stapl/altera.c

fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   203  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   204  static int altera_execute(struct altera_state *astate,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   205  				u8 *p,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   206  				s32 program_size,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   207  				s32 *error_address,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   208  				int *exit_code,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   209  				int *format_version)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   210  {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   211  	struct altera_config *aconf = astate->config;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   212  	char *msg_buff = astate->msg_buff;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   213  	long *stack = astate->stack;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   214  	int status = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   215  	u32 first_word = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   216  	u32 action_table = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   217  	u32 proc_table = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   218  	u32 str_table = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   219  	u32 sym_table = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   220  	u32 data_sect = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   221  	u32 code_sect = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   222  	u32 debug_sect = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   223  	u32 action_count = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   224  	u32 proc_count = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   225  	u32 sym_count = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   226  	long *vars = NULL;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   227  	s32 *var_size = NULL;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   228  	char *attrs = NULL;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   229  	u8 *proc_attributes = NULL;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   230  	u32 pc;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   231  	u32 opcode_address;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   232  	u32 args[3];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   233  	u32 opcode;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   234  	u32 name_id;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   235  	u8 charbuf[4];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   236  	long long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   237  	u32 variable_id;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   238  	u8 *charptr_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   239  	u8 *charptr_tmp2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   240  	long *longptr_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   241  	int version = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   242  	int delta = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   243  	int stack_ptr = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   244  	u32 arg_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   245  	int done = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   246  	int bad_opcode = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   247  	u32 count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   248  	u32 index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   249  	u32 index2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   250  	s32 long_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   251  	s32 long_idx;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   252  	s32 long_idx2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   253  	u32 i;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   254  	u32 j;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   255  	u32 uncomp_size;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   256  	u32 offset;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   257  	u32 value;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   258  	int current_proc = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   259  	int reverse;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   260  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   261  	char *name;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   262  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   263  	dprintk("%s\n", __func__);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   264  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   265  	/* Read header information */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   266  	if (program_size > 52L) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   267  		first_word    = get_unaligned_be32(&p[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   268  		version = (first_word & 1L);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   269  		*format_version = version + 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   270  		delta = version * 8;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   271  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   272  		action_table  = get_unaligned_be32(&p[4]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   273  		proc_table    = get_unaligned_be32(&p[8]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   274  		str_table  = get_unaligned_be32(&p[4 + delta]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   275  		sym_table  = get_unaligned_be32(&p[16 + delta]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   276  		data_sect  = get_unaligned_be32(&p[20 + delta]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   277  		code_sect  = get_unaligned_be32(&p[24 + delta]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   278  		debug_sect = get_unaligned_be32(&p[28 + delta]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   279  		action_count  = get_unaligned_be32(&p[40 + delta]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   280  		proc_count    = get_unaligned_be32(&p[44 + delta]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   281  		sym_count  = get_unaligned_be32(&p[48 + (2 * delta)]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   282  	}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   283  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   284  	if ((first_word != 0x4A414D00L) && (first_word != 0x4A414D01L)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   285  		done = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   286  		status = -EIO;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   287  		goto exit_done;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   288  	}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   289  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   290  	if (sym_count <= 0)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   291  		goto exit_done;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   292  
6396bb221514d28 drivers/misc/altera-stapl/altera.c    Kees Cook         2018-06-12   293  	vars = kcalloc(sym_count, sizeof(long), GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   294  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   295  	if (vars == NULL)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   296  		status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   297  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   298  	if (status == 0) {
6396bb221514d28 drivers/misc/altera-stapl/altera.c    Kees Cook         2018-06-12   299  		var_size = kcalloc(sym_count, sizeof(s32), GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   300  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   301  		if (var_size == NULL)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   302  			status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   303  	}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   304  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   305  	if (status == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   306  		attrs = kzalloc(sym_count, GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   307  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   308  		if (attrs == NULL)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   309  			status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   310  	}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   311  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   312  	if ((status == 0) && (version > 0)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   313  		proc_attributes = kzalloc(proc_count, GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   314  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   315  		if (proc_attributes == NULL)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   316  			status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   317  	}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   318  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   319  	if (status != 0)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   320  		goto exit_done;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   321  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   322  	delta = version * 2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   323  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   324  	for (i = 0; i < sym_count; ++i) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   325  		offset = (sym_table + ((11 + delta) * i));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   326  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   327  		value = get_unaligned_be32(&p[offset + 3 + delta]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   328  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   329  		attrs[i] = p[offset];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   330  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   331  		/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   332  		 * use bit 7 of attribute byte to indicate that
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   333  		 * this buffer was dynamically allocated
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   334  		 * and should be freed later
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   335  		 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   336  		attrs[i] &= 0x7f;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   337  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   338  		var_size[i] = get_unaligned_be32(&p[offset + 7 + delta]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   339  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   340  		/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   341  		 * Attribute bits:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   342  		 * bit 0: 0 = read-only, 1 = read-write
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   343  		 * bit 1: 0 = not compressed, 1 = compressed
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   344  		 * bit 2: 0 = not initialized, 1 = initialized
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   345  		 * bit 3: 0 = scalar, 1 = array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   346  		 * bit 4: 0 = Boolean, 1 = integer
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   347  		 * bit 5: 0 = declared variable,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   348  		 *	1 = compiler created temporary variable
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   349  		 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   350  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   351  		if ((attrs[i] & 0x0c) == 0x04)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   352  			/* initialized scalar variable */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   353  			vars[i] = value;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   354  		else if ((attrs[i] & 0x1e) == 0x0e) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   355  			/* initialized compressed Boolean array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   356  			uncomp_size = get_unaligned_le32(&p[data_sect + value]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   357  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   358  			/* allocate a buffer for the uncompressed data */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   359  			vars[i] = (long)kzalloc(uncomp_size, GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   360  			if (vars[i] == 0L)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   361  				status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   362  			else {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   363  				/* set flag so buffer will be freed later */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   364  				attrs[i] |= 0x80;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   365  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   366  				/* uncompress the data */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   367  				if (altera_shrink(&p[data_sect + value],
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   368  						var_size[i],
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   369  						(u8 *)vars[i],
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   370  						uncomp_size,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   371  						version) != uncomp_size)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   372  					/* decompression failed */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   373  					status = -EIO;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   374  				else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   375  					var_size[i] = uncomp_size * 8L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   376  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   377  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   378  		} else if ((attrs[i] & 0x1e) == 0x0c) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   379  			/* initialized Boolean array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   380  			vars[i] = value + data_sect + (long)p;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   381  		} else if ((attrs[i] & 0x1c) == 0x1c) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   382  			/* initialized integer array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   383  			vars[i] = value + data_sect;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   384  		} else if ((attrs[i] & 0x0c) == 0x08) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   385  			/* uninitialized array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   386  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   387  			/* flag attrs so that memory is freed */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   388  			attrs[i] |= 0x80;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   389  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   390  			if (var_size[i] > 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   391  				u32 size;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   392  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   393  				if (attrs[i] & 0x10)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   394  					/* integer array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   395  					size = (var_size[i] * sizeof(s32));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   396  				else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   397  					/* Boolean array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   398  					size = ((var_size[i] + 7L) / 8L);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   399  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   400  				vars[i] = (long)kzalloc(size, GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   401  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   402  				if (vars[i] == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   403  					status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   404  				} else {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   405  					/* zero out memory */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   406  					for (j = 0; j < size; ++j)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   407  						((u8 *)(vars[i]))[j] = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   408  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   409  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   410  			} else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   411  				vars[i] = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   412  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   413  		} else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   414  			vars[i] = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   415  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   416  	}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   417  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   418  exit_done:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   419  	if (status != 0)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   420  		done = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   421  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   422  	altera_jinit(astate);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   423  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   424  	pc = code_sect;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   425  	msg_buff[0] = '\0';
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   426  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   427  	/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   428  	 * For JBC version 2, we will execute the procedures corresponding to
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   429  	 * the selected ACTION
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   430  	 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   431  	if (version > 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   432  		if (aconf->action == NULL) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   433  			status = -EINVAL;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   434  			done = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   435  		} else {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   436  			int action_found = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   437  			for (i = 0; (i < action_count) && !action_found; ++i) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   438  				name_id = get_unaligned_be32(&p[action_table +
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   439  								(12 * i)]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   440  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   441  				name = &p[str_table + name_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   442  
30614cf34105c5b drivers/misc/altera-stapl/altera.c    Rasmus Villemoes  2014-10-13   443  				if (strncasecmp(aconf->action, name, strlen(name)) == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   444  					action_found = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   445  					current_proc =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   446  						get_unaligned_be32(&p[action_table +
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   447  								(12 * i) + 8]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   448  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   449  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   450  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   451  			if (!action_found) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   452  				status = -EINVAL;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   453  				done = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   454  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   455  		}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   456  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   457  		if (status == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   458  			int first_time = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   459  			i = current_proc;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   460  			while ((i != 0) || first_time) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   461  				first_time = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   462  				/* check procedure attribute byte */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   463  				proc_attributes[i] =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   464  						(p[proc_table +
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   465  								(13 * i) + 8] &
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   466  									0x03);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   467  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   468  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   469  				 * BIT0 - OPTIONAL
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   470  				 * BIT1 - RECOMMENDED
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   471  				 * BIT6 - FORCED OFF
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   472  				 * BIT7 - FORCED ON
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   473  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   474  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   475  				i = get_unaligned_be32(&p[proc_table +
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   476  							(13 * i) + 4]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   477  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   478  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   479  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   480  			 * Set current_proc to the first procedure
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   481  			 * to be executed
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   482  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   483  			i = current_proc;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   484  			while ((i != 0) &&
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   485  				((proc_attributes[i] == 1) ||
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   486  				((proc_attributes[i] & 0xc0) == 0x40))) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   487  				i = get_unaligned_be32(&p[proc_table +
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   488  							(13 * i) + 4]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   489  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   490  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   491  			if ((i != 0) || ((i == 0) && (current_proc == 0) &&
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   492  				((proc_attributes[0] != 1) &&
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   493  				((proc_attributes[0] & 0xc0) != 0x40)))) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   494  				current_proc = i;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   495  				pc = code_sect +
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   496  					get_unaligned_be32(&p[proc_table +
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   497  								(13 * i) + 9]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   498  				if ((pc < code_sect) || (pc >= debug_sect))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   499  					status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   500  			} else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   501  				/* there are no procedures to execute! */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   502  				done = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   503  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   504  		}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   505  	}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   506  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   507  	msg_buff[0] = '\0';
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   508  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   509  	while (!done) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   510  		opcode = (p[pc] & 0xff);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   511  		opcode_address = pc;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   512  		++pc;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   513  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   514  		if (debug > 1)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   515  			printk("opcode: %02x\n", opcode);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   516  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   517  		arg_count = (opcode >> 6) & 3;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   518  		for (i = 0; i < arg_count; ++i) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   519  			args[i] = get_unaligned_be32(&p[pc]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   520  			pc += 4;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   521  		}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   522  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   523  		switch (opcode) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   524  		case OP_NOP:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   525  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   526  		case OP_DUP:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   527  			if (altera_check_stack(stack_ptr, 1, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   528  				stack[stack_ptr] = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   529  				++stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   530  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   531  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   532  		case OP_SWP:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   533  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   534  				long_tmp = stack[stack_ptr - 2];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   535  				stack[stack_ptr - 2] = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   536  				stack[stack_ptr - 1] = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   537  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   538  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   539  		case OP_ADD:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   540  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   541  				--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   542  				stack[stack_ptr - 1] += stack[stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   543  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   544  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   545  		case OP_SUB:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   546  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   547  				--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   548  				stack[stack_ptr - 1] -= stack[stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   549  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   550  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   551  		case OP_MULT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   552  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   553  				--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   554  				stack[stack_ptr - 1] *= stack[stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   555  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   556  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   557  		case OP_DIV:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   558  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   559  				--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   560  				stack[stack_ptr - 1] /= stack[stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   561  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   562  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   563  		case OP_MOD:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   564  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   565  				--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   566  				stack[stack_ptr - 1] %= stack[stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   567  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   568  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   569  		case OP_SHL:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   570  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   571  				--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   572  				stack[stack_ptr - 1] <<= stack[stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   573  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   574  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   575  		case OP_SHR:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   576  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   577  				--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   578  				stack[stack_ptr - 1] >>= stack[stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   579  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   580  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   581  		case OP_NOT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   582  			if (altera_check_stack(stack_ptr, 1, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   583  				stack[stack_ptr - 1] ^= (-1L);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   584  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   585  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   586  		case OP_AND:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   587  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   588  				--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   589  				stack[stack_ptr - 1] &= stack[stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   590  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   591  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   592  		case OP_OR:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   593  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   594  				--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   595  				stack[stack_ptr - 1] |= stack[stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   596  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   597  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   598  		case OP_XOR:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   599  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   600  				--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   601  				stack[stack_ptr - 1] ^= stack[stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   602  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   603  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   604  		case OP_INV:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   605  			if (!altera_check_stack(stack_ptr, 1, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   606  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   607  			stack[stack_ptr - 1] = stack[stack_ptr - 1] ? 0L : 1L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   608  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   609  		case OP_GT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   610  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   611  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   612  			--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   613  			stack[stack_ptr - 1] =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   614  				(stack[stack_ptr - 1] > stack[stack_ptr]) ?
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   615  									1L : 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   616  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   617  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   618  		case OP_LT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   619  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   620  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   621  			--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   622  			stack[stack_ptr - 1] =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   623  				(stack[stack_ptr - 1] < stack[stack_ptr]) ?
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   624  									1L : 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   625  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   626  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   627  		case OP_RET:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   628  			if ((version > 0) && (stack_ptr == 0)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   629  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   630  				 * We completed one of the main procedures
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   631  				 * of an ACTION.
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   632  				 * Find the next procedure
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   633  				 * to be executed and jump to it.
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   634  				 * If there are no more procedures, then EXIT.
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   635  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   636  				i = get_unaligned_be32(&p[proc_table +
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   637  						(13 * current_proc) + 4]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   638  				while ((i != 0) &&
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   639  					((proc_attributes[i] == 1) ||
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   640  					((proc_attributes[i] & 0xc0) == 0x40)))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   641  					i = get_unaligned_be32(&p[proc_table +
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   642  								(13 * i) + 4]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   643  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   644  				if (i == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   645  					/* no procedures to execute! */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   646  					done = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   647  					*exit_code = 0;	/* success */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   648  				} else {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   649  					current_proc = i;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   650  					pc = code_sect + get_unaligned_be32(
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   651  								&p[proc_table +
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   652  								(13 * i) + 9]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   653  					if ((pc < code_sect) ||
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   654  					    (pc >= debug_sect))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   655  						status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   656  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   657  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   658  			} else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   659  				if (altera_check_stack(stack_ptr, 1, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   660  					pc = stack[--stack_ptr] + code_sect;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   661  					if ((pc <= code_sect) ||
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   662  					    (pc >= debug_sect))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   663  						status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   664  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   665  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   666  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   667  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   668  		case OP_CMPS:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   669  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   670  			 * Array short compare
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   671  			 * ...stack 0 is source 1 value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   672  			 * ...stack 1 is source 2 value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   673  			 * ...stack 2 is mask value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   674  			 * ...stack 3 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   675  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   676  			if (altera_check_stack(stack_ptr, 4, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   677  				s32 a = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   678  				s32 b = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   679  				long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   680  				count = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   681  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   682  				if ((count < 1) || (count > 32))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   683  					status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   684  				else {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   685  					long_tmp &= ((-1L) >> (32 - count));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   686  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   687  					stack[stack_ptr - 1] =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   688  					((a & long_tmp) == (b & long_tmp))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   689  								? 1L : 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   690  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   691  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   692  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   693  		case OP_PINT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   694  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   695  			 * PRINT add integer
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   696  			 * ...stack 0 is integer value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   697  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   698  			if (!altera_check_stack(stack_ptr, 1, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   699  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   700  			sprintf(&msg_buff[strlen(msg_buff)],
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   701  					"%ld", stack[--stack_ptr]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   702  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   703  		case OP_PRNT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   704  			/* PRINT finish */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   705  			if (debug)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   706  				printk(msg_buff, "\n");
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   707  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   708  			msg_buff[0] = '\0';
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   709  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   710  		case OP_DSS:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   711  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   712  			 * DRSCAN short
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   713  			 * ...stack 0 is scan data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   714  			 * ...stack 1 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   715  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   716  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   717  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   718  			long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   719  			count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   720  			put_unaligned_le32(long_tmp, &charbuf[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   721  			status = altera_drscan(astate, count, charbuf, 0);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   722  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   723  		case OP_DSSC:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   724  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   725  			 * DRSCAN short with capture
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   726  			 * ...stack 0 is scan data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   727  			 * ...stack 1 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   728  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   729  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   730  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   731  			long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   732  			count = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   733  			put_unaligned_le32(long_tmp, &charbuf[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   734  			status = altera_swap_dr(astate, count, charbuf,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   735  							0, charbuf, 0);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   736  			stack[stack_ptr - 1] = get_unaligned_le32(&charbuf[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   737  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   738  		case OP_ISS:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   739  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   740  			 * IRSCAN short
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   741  			 * ...stack 0 is scan data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   742  			 * ...stack 1 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   743  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   744  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   745  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   746  			long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   747  			count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   748  			put_unaligned_le32(long_tmp, &charbuf[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   749  			status = altera_irscan(astate, count, charbuf, 0);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   750  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   751  		case OP_ISSC:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   752  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   753  			 * IRSCAN short with capture
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   754  			 * ...stack 0 is scan data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   755  			 * ...stack 1 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   756  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   757  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   758  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   759  			long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   760  			count = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   761  			put_unaligned_le32(long_tmp, &charbuf[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   762  			status = altera_swap_ir(astate, count, charbuf,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   763  							0, charbuf, 0);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   764  			stack[stack_ptr - 1] = get_unaligned_le32(&charbuf[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   765  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   766  		case OP_DPR:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   767  			if (!altera_check_stack(stack_ptr, 1, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   768  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   769  			count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   770  			status = altera_set_dr_pre(&astate->js, count, 0, NULL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   771  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   772  		case OP_DPRL:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   773  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   774  			 * DRPRE with literal data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   775  			 * ...stack 0 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   776  			 * ...stack 1 is literal data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   777  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   778  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   779  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   780  			count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   781  			long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   782  			put_unaligned_le32(long_tmp, &charbuf[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   783  			status = altera_set_dr_pre(&astate->js, count, 0,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   784  						charbuf);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   785  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   786  		case OP_DPO:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   787  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   788  			 * DRPOST
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   789  			 * ...stack 0 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   790  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   791  			if (altera_check_stack(stack_ptr, 1, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   792  				count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   793  				status = altera_set_dr_post(&astate->js, count,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   794  								0, NULL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   795  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   796  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   797  		case OP_DPOL:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   798  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   799  			 * DRPOST with literal data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   800  			 * ...stack 0 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   801  			 * ...stack 1 is literal data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   802  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   803  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   804  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   805  			count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   806  			long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   807  			put_unaligned_le32(long_tmp, &charbuf[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   808  			status = altera_set_dr_post(&astate->js, count, 0,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   809  							charbuf);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   810  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   811  		case OP_IPR:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   812  			if (altera_check_stack(stack_ptr, 1, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   813  				count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   814  				status = altera_set_ir_pre(&astate->js, count,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   815  								0, NULL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   816  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   817  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   818  		case OP_IPRL:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   819  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   820  			 * IRPRE with literal data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   821  			 * ...stack 0 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   822  			 * ...stack 1 is literal data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   823  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   824  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   825  				count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   826  				long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   827  				put_unaligned_le32(long_tmp, &charbuf[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   828  				status = altera_set_ir_pre(&astate->js, count,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   829  							0, charbuf);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   830  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   831  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   832  		case OP_IPO:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   833  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   834  			 * IRPOST
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   835  			 * ...stack 0 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   836  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   837  			if (altera_check_stack(stack_ptr, 1, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   838  				count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   839  				status = altera_set_ir_post(&astate->js, count,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   840  							0, NULL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   841  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   842  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   843  		case OP_IPOL:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   844  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   845  			 * IRPOST with literal data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   846  			 * ...stack 0 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   847  			 * ...stack 1 is literal data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   848  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   849  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   850  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   851  			count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   852  			long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   853  			put_unaligned_le32(long_tmp, &charbuf[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   854  			status = altera_set_ir_post(&astate->js, count, 0,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   855  							charbuf);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   856  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   857  		case OP_PCHR:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   858  			if (altera_check_stack(stack_ptr, 1, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   859  				u8 ch;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   860  				count = strlen(msg_buff);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   861  				ch = (char) stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   862  				if ((ch < 1) || (ch > 127)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   863  					/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   864  					 * character code out of range
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   865  					 * instead of flagging an error,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   866  					 * force the value to 127
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   867  					 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   868  					ch = 127;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   869  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   870  				msg_buff[count] = ch;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   871  				msg_buff[count + 1] = '\0';
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   872  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   873  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   874  		case OP_EXIT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   875  			if (altera_check_stack(stack_ptr, 1, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   876  				*exit_code = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   877  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   878  			done = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   879  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   880  		case OP_EQU:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   881  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   882  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   883  			--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   884  			stack[stack_ptr - 1] =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   885  				(stack[stack_ptr - 1] == stack[stack_ptr]) ?
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   886  									1L : 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   887  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   888  		case OP_POPT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   889  			if (altera_check_stack(stack_ptr, 1, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   890  				--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   891  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   892  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   893  		case OP_ABS:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   894  			if (!altera_check_stack(stack_ptr, 1, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   895  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   896  			if (stack[stack_ptr - 1] < 0)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   897  				stack[stack_ptr - 1] = 0 - stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   898  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   899  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   900  		case OP_BCH0:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   901  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   902  			 * Batch operation 0
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   903  			 * SWP
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   904  			 * SWPN 7
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   905  			 * SWP
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   906  			 * SWPN 6
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   907  			 * DUPN 8
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   908  			 * SWPN 2
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   909  			 * SWP
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   910  			 * DUPN 6
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   911  			 * DUPN 6
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   912  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   913  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   914  			/* SWP  */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   915  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   916  				long_tmp = stack[stack_ptr - 2];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   917  				stack[stack_ptr - 2] = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   918  				stack[stack_ptr - 1] = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   919  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   920  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   921  			/* SWPN 7 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   922  			index = 7 + 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   923  			if (altera_check_stack(stack_ptr, index, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   924  				long_tmp = stack[stack_ptr - index];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   925  				stack[stack_ptr - index] = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   926  				stack[stack_ptr - 1] = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   927  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   928  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   929  			/* SWP  */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   930  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   931  				long_tmp = stack[stack_ptr - 2];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   932  				stack[stack_ptr - 2] = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   933  				stack[stack_ptr - 1] = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   934  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   935  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   936  			/* SWPN 6 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   937  			index = 6 + 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   938  			if (altera_check_stack(stack_ptr, index, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   939  				long_tmp = stack[stack_ptr - index];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   940  				stack[stack_ptr - index] = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   941  				stack[stack_ptr - 1] = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   942  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   943  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   944  			/* DUPN 8 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   945  			index = 8 + 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   946  			if (altera_check_stack(stack_ptr, index, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   947  				stack[stack_ptr] = stack[stack_ptr - index];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   948  				++stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   949  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   950  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   951  			/* SWPN 2 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   952  			index = 2 + 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   953  			if (altera_check_stack(stack_ptr, index, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   954  				long_tmp = stack[stack_ptr - index];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   955  				stack[stack_ptr - index] = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   956  				stack[stack_ptr - 1] = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   957  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   958  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   959  			/* SWP  */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   960  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   961  				long_tmp = stack[stack_ptr - 2];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   962  				stack[stack_ptr - 2] = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   963  				stack[stack_ptr - 1] = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   964  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   965  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   966  			/* DUPN 6 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   967  			index = 6 + 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   968  			if (altera_check_stack(stack_ptr, index, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   969  				stack[stack_ptr] = stack[stack_ptr - index];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   970  				++stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   971  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   972  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   973  			/* DUPN 6 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   974  			index = 6 + 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   975  			if (altera_check_stack(stack_ptr, index, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   976  				stack[stack_ptr] = stack[stack_ptr - index];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   977  				++stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   978  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   979  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   980  		case OP_PSH0:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   981  			stack[stack_ptr++] = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   982  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   983  		case OP_PSHL:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   984  			stack[stack_ptr++] = (s32) args[0];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   985  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   986  		case OP_PSHV:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   987  			stack[stack_ptr++] = vars[args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   988  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   989  		case OP_JMP:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   990  			pc = args[0] + code_sect;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   991  			if ((pc < code_sect) || (pc >= debug_sect))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   992  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   993  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   994  		case OP_CALL:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   995  			stack[stack_ptr++] = pc;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   996  			pc = args[0] + code_sect;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   997  			if ((pc < code_sect) || (pc >= debug_sect))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   998  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   999  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1000  		case OP_NEXT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1001  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1002  			 * Process FOR / NEXT loop
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1003  			 * ...argument 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1004  			 * ...stack 0 is step value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1005  			 * ...stack 1 is end value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1006  			 * ...stack 2 is top address
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1007  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1008  			if (altera_check_stack(stack_ptr, 3, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1009  				s32 step = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1010  				s32 end = stack[stack_ptr - 2];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1011  				s32 top = stack[stack_ptr - 3];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1012  				s32 iterator = vars[args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1013  				int break_out = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1014  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1015  				if (step < 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1016  					if (iterator <= end)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1017  						break_out = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1018  				} else if (iterator >= end)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1019  					break_out = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1020  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1021  				if (break_out) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1022  					stack_ptr -= 3;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1023  				} else {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1024  					vars[args[0]] = iterator + step;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1025  					pc = top + code_sect;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1026  					if ((pc < code_sect) ||
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1027  					    (pc >= debug_sect))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1028  						status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1029  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1030  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1031  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1032  		case OP_PSTR:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1033  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1034  			 * PRINT add string
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1035  			 * ...argument 0 is string ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1036  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1037  			count = strlen(msg_buff);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1038  			strlcpy(&msg_buff[count],
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1039  				&p[str_table + args[0]],
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1040  				ALTERA_MESSAGE_LENGTH - count);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1041  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1042  		case OP_SINT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1043  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1044  			 * STATE intermediate state
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1045  			 * ...argument 0 is state code
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1046  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1047  			status = altera_goto_jstate(astate, args[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1048  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1049  		case OP_ST:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1050  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1051  			 * STATE final state
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1052  			 * ...argument 0 is state code
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1053  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1054  			status = altera_goto_jstate(astate, args[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1055  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1056  		case OP_ISTP:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1057  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1058  			 * IRSTOP state
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1059  			 * ...argument 0 is state code
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1060  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1061  			status = altera_set_irstop(&astate->js, args[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1062  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1063  		case OP_DSTP:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1064  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1065  			 * DRSTOP state
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1066  			 * ...argument 0 is state code
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1067  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1068  			status = altera_set_drstop(&astate->js, args[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1069  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1070  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1071  		case OP_SWPN:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1072  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1073  			 * Exchange top with Nth stack value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1074  			 * ...argument 0 is 0-based stack entry
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1075  			 * to swap with top element
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1076  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1077  			index = (args[0]) + 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1078  			if (altera_check_stack(stack_ptr, index, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1079  				long_tmp = stack[stack_ptr - index];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1080  				stack[stack_ptr - index] = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1081  				stack[stack_ptr - 1] = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1082  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1083  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1084  		case OP_DUPN:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1085  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1086  			 * Duplicate Nth stack value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1087  			 * ...argument 0 is 0-based stack entry to duplicate
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1088  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1089  			index = (args[0]) + 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1090  			if (altera_check_stack(stack_ptr, index, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1091  				stack[stack_ptr] = stack[stack_ptr - index];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1092  				++stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1093  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1094  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1095  		case OP_POPV:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1096  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1097  			 * Pop stack into scalar variable
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1098  			 * ...argument 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1099  			 * ...stack 0 is value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1100  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1101  			if (altera_check_stack(stack_ptr, 1, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1102  				vars[args[0]] = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1103  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1104  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1105  		case OP_POPE:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1106  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1107  			 * Pop stack into integer array element
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1108  			 * ...argument 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1109  			 * ...stack 0 is array index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1110  			 * ...stack 1 is value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1111  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1112  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1113  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1114  			variable_id = args[0];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1115  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1116  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1117  			 * If variable is read-only,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1118  			 * convert to writable array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1119  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1120  			if ((version > 0) &&
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1121  				((attrs[variable_id] & 0x9c) == 0x1c)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1122  				/* Allocate a writable buffer for this array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1123  				count = var_size[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1124  				long_tmp = vars[variable_id];
6396bb221514d28 drivers/misc/altera-stapl/altera.c    Kees Cook         2018-06-12  1125  				longptr_tmp = kcalloc(count, sizeof(long),
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1126  								GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1127  				vars[variable_id] = (long)longptr_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1128  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1129  				if (vars[variable_id] == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1130  					status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1131  					break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1132  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1133  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1134  				/* copy previous contents into buffer */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1135  				for (i = 0; i < count; ++i) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1136  					longptr_tmp[i] =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1137  						get_unaligned_be32(&p[long_tmp]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1138  					long_tmp += sizeof(long);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1139  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1140  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1141  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1142  				 * set bit 7 - buffer was
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1143  				 * dynamically allocated
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1144  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1145  				attrs[variable_id] |= 0x80;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1146  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1147  				/* clear bit 2 - variable is writable */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1148  				attrs[variable_id] &= ~0x04;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1149  				attrs[variable_id] |= 0x01;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1150  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1151  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1152  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1153  			/* check that variable is a writable integer array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1154  			if ((attrs[variable_id] & 0x1c) != 0x18)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1155  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1156  			else {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1157  				longptr_tmp = (long *)vars[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1158  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1159  				/* pop the array index */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1160  				index = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1161  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1162  				/* pop the value and store it into the array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1163  				longptr_tmp[index] = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1164  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1165  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1166  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1167  		case OP_POPA:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1168  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1169  			 * Pop stack into Boolean array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1170  			 * ...argument 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1171  			 * ...stack 0 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1172  			 * ...stack 1 is array index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1173  			 * ...stack 2 is value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1174  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1175  			if (!altera_check_stack(stack_ptr, 3, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1176  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1177  			variable_id = args[0];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1178  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1179  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1180  			 * If variable is read-only,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1181  			 * convert to writable array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1182  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1183  			if ((version > 0) &&
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1184  				((attrs[variable_id] & 0x9c) == 0x0c)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1185  				/* Allocate a writable buffer for this array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1186  				long_tmp =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1187  					(var_size[variable_id] + 7L) >> 3L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1188  				charptr_tmp2 = (u8 *)vars[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1189  				charptr_tmp =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1190  					kzalloc(long_tmp, GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1191  				vars[variable_id] = (long)charptr_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1192  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1193  				if (vars[variable_id] == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1194  					status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1195  					break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1196  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1197  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1198  				/* zero the buffer */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1199  				for (long_idx = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1200  					long_idx < long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1201  					++long_idx) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1202  					charptr_tmp[long_idx] = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1203  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1204  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1205  				/* copy previous contents into buffer */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1206  				for (long_idx = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1207  					long_idx < var_size[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1208  					++long_idx) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1209  					long_idx2 = long_idx;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1210  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1211  					if (charptr_tmp2[long_idx2 >> 3] &
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1212  						(1 << (long_idx2 & 7))) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1213  						charptr_tmp[long_idx >> 3] |=
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1214  							(1 << (long_idx & 7));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1215  					}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1216  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1217  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1218  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1219  				 * set bit 7 - buffer was
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1220  				 * dynamically allocated
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1221  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1222  				attrs[variable_id] |= 0x80;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1223  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1224  				/* clear bit 2 - variable is writable */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1225  				attrs[variable_id] &= ~0x04;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1226  				attrs[variable_id] |= 0x01;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1227  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1228  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1229  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1230  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1231  			 * check that variable is
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1232  			 * a writable Boolean array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1233  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1234  			if ((attrs[variable_id] & 0x1c) != 0x08) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1235  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1236  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1237  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1238  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1239  			charptr_tmp = (u8 *)vars[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1240  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1241  			/* pop the count (number of bits to copy) */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1242  			long_count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1243  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1244  			/* pop the array index */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1245  			long_idx = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1246  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1247  			reverse = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1248  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1249  			if (version > 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1250  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1251  				 * stack 0 = array right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1252  				 * stack 1 = array left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1253  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1254  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1255  				if (long_idx > long_count) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1256  					reverse = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1257  					long_tmp = long_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1258  					long_count = 1 + long_idx -
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1259  								long_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1260  					long_idx = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1261  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1262  					/* reverse POPA is not supported */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1263  					status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1264  					break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1265  				} else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1266  					long_count = 1 + long_count -
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1267  								long_idx;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1268  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1269  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1270  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1271  			/* pop the data */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1272  			long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1273  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1274  			if (long_count < 1) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1275  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1276  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1277  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1278  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1279  			for (i = 0; i < long_count; ++i) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1280  				if (long_tmp & (1L << (s32) i))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1281  					charptr_tmp[long_idx >> 3L] |=
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1282  						(1L << (long_idx & 7L));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1283  				else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1284  					charptr_tmp[long_idx >> 3L] &=
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1285  						~(1L << (long_idx & 7L));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1286  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1287  				++long_idx;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1288  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1289  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1290  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1291  		case OP_JMPZ:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1292  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1293  			 * Pop stack and branch if zero
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1294  			 * ...argument 0 is address
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1295  			 * ...stack 0 is condition value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1296  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1297  			if (altera_check_stack(stack_ptr, 1, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1298  				if (stack[--stack_ptr] == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1299  					pc = args[0] + code_sect;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1300  					if ((pc < code_sect) ||
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1301  					    (pc >= debug_sect))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1302  						status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1303  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1304  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1305  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1306  		case OP_DS:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1307  		case OP_IS:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1308  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1309  			 * DRSCAN
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1310  			 * IRSCAN
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1311  			 * ...argument 0 is scan data variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1312  			 * ...stack 0 is array index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1313  			 * ...stack 1 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1314  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1315  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1316  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1317  			long_idx = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1318  			long_count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1319  			reverse = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1320  			if (version > 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1321  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1322  				 * stack 0 = array right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1323  				 * stack 1 = array left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1324  				 * stack 2 = count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1325  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1326  				long_tmp = long_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1327  				long_count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1328  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1329  				if (long_idx > long_tmp) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1330  					reverse = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1331  					long_idx = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1332  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1333  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1334  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1335  			charptr_tmp = (u8 *)vars[args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1336  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1337  			if (reverse) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1338  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1339  				 * allocate a buffer
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1340  				 * and reverse the data order
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1341  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1342  				charptr_tmp2 = charptr_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1343  				charptr_tmp = kzalloc((long_count >> 3) + 1,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1344  								GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1345  				if (charptr_tmp == NULL) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1346  					status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1347  					break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1348  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1349  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1350  				long_tmp = long_idx + long_count - 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1351  				long_idx2 = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1352  				while (long_idx2 < long_count) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1353  					if (charptr_tmp2[long_tmp >> 3] &
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1354  							(1 << (long_tmp & 7)))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1355  						charptr_tmp[long_idx2 >> 3] |=
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1356  							(1 << (long_idx2 & 7));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1357  					else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1358  						charptr_tmp[long_idx2 >> 3] &=
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1359  							~(1 << (long_idx2 & 7));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1360  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1361  					--long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1362  					++long_idx2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1363  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1364  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1365  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1366  			if (opcode == 0x51) /* DS */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1367  				status = altera_drscan(astate, long_count,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1368  						charptr_tmp, long_idx);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1369  			else /* IS */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1370  				status = altera_irscan(astate, long_count,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1371  						charptr_tmp, long_idx);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1372  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1373  			if (reverse)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1374  				kfree(charptr_tmp);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1375  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1376  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1377  		case OP_DPRA:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1378  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1379  			 * DRPRE with array data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1380  			 * ...argument 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1381  			 * ...stack 0 is array index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1382  			 * ...stack 1 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1383  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1384  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1385  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1386  			index = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1387  			count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1388  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1389  			if (version > 0)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1390  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1391  				 * stack 0 = array right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1392  				 * stack 1 = array left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1393  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1394  				count = 1 + count - index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1395  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1396  			charptr_tmp = (u8 *)vars[args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1397  			status = altera_set_dr_pre(&astate->js, count, index,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1398  							charptr_tmp);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1399  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1400  		case OP_DPOA:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1401  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1402  			 * DRPOST with array data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1403  			 * ...argument 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1404  			 * ...stack 0 is array index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1405  			 * ...stack 1 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1406  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1407  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1408  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1409  			index = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1410  			count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1411  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1412  			if (version > 0)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1413  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1414  				 * stack 0 = array right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1415  				 * stack 1 = array left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1416  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1417  				count = 1 + count - index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1418  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1419  			charptr_tmp = (u8 *)vars[args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1420  			status = altera_set_dr_post(&astate->js, count, index,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1421  							charptr_tmp);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1422  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1423  		case OP_IPRA:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1424  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1425  			 * IRPRE with array data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1426  			 * ...argument 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1427  			 * ...stack 0 is array index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1428  			 * ...stack 1 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1429  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1430  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1431  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1432  			index = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1433  			count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1434  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1435  			if (version > 0)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1436  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1437  				 * stack 0 = array right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1438  				 * stack 1 = array left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1439  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1440  				count = 1 + count - index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1441  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1442  			charptr_tmp = (u8 *)vars[args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1443  			status = altera_set_ir_pre(&astate->js, count, index,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1444  							charptr_tmp);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1445  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1446  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1447  		case OP_IPOA:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1448  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1449  			 * IRPOST with array data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1450  			 * ...argument 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1451  			 * ...stack 0 is array index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1452  			 * ...stack 1 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1453  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1454  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1455  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1456  			index = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1457  			count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1458  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1459  			if (version > 0)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1460  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1461  				 * stack 0 = array right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1462  				 * stack 1 = array left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1463  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1464  				count = 1 + count - index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1465  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1466  			charptr_tmp = (u8 *)vars[args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1467  			status = altera_set_ir_post(&astate->js, count, index,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1468  							charptr_tmp);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1469  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1470  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1471  		case OP_EXPT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1472  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1473  			 * EXPORT
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1474  			 * ...argument 0 is string ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1475  			 * ...stack 0 is integer expression
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1476  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1477  			if (altera_check_stack(stack_ptr, 1, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1478  				name = &p[str_table + args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1479  				long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1480  				altera_export_int(name, long_tmp);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1481  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1482  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1483  		case OP_PSHE:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1484  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1485  			 * Push integer array element
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1486  			 * ...argument 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1487  			 * ...stack 0 is array index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1488  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1489  			if (!altera_check_stack(stack_ptr, 1, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1490  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1491  			variable_id = args[0];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1492  			index = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1493  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1494  			/* check variable type */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1495  			if ((attrs[variable_id] & 0x1f) == 0x19) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1496  				/* writable integer array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1497  				longptr_tmp = (long *)vars[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1498  				stack[stack_ptr - 1] = longptr_tmp[index];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1499  			} else if ((attrs[variable_id] & 0x1f) == 0x1c) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1500  				/* read-only integer array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1501  				long_tmp = vars[variable_id] +
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1502  						(index * sizeof(long));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1503  				stack[stack_ptr - 1] =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1504  					get_unaligned_be32(&p[long_tmp]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1505  			} else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1506  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1507  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1508  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1509  		case OP_PSHA:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1510  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1511  			 * Push Boolean array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1512  			 * ...argument 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1513  			 * ...stack 0 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1514  			 * ...stack 1 is array index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1515  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1516  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1517  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1518  			variable_id = args[0];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1519  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1520  			/* check that variable is a Boolean array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1521  			if ((attrs[variable_id] & 0x18) != 0x08) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1522  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1523  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1524  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1525  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1526  			charptr_tmp = (u8 *)vars[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1527  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1528  			/* pop the count (number of bits to copy) */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1529  			count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1530  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1531  			/* pop the array index */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1532  			index = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1533  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1534  			if (version > 0)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1535  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1536  				 * stack 0 = array right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1537  				 * stack 1 = array left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1538  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1539  				count = 1 + count - index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1540  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1541  			if ((count < 1) || (count > 32)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1542  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1543  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1544  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1545  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1546  			long_tmp = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1547  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1548  			for (i = 0; i < count; ++i)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1549  				if (charptr_tmp[(i + index) >> 3] &
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1550  						(1 << ((i + index) & 7)))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1551  					long_tmp |= (1L << i);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1552  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1553  			stack[stack_ptr - 1] = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1554  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1555  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1556  		case OP_DYNA:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1557  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1558  			 * Dynamically change size of array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1559  			 * ...argument 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1560  			 * ...stack 0 is new size
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1561  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1562  			if (!altera_check_stack(stack_ptr, 1, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1563  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1564  			variable_id = args[0];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1565  			long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1566  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1567  			if (long_tmp > var_size[variable_id]) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1568  				var_size[variable_id] = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1569  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1570  				if (attrs[variable_id] & 0x10)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1571  					/* allocate integer array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1572  					long_tmp *= sizeof(long);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1573  				else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1574  					/* allocate Boolean array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1575  					long_tmp = (long_tmp + 7) >> 3;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1576  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1577  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1578  				 * If the buffer was previously allocated,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1579  				 * free it
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1580  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1581  				if (attrs[variable_id] & 0x80) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1582  					kfree((void *)vars[variable_id]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1583  					vars[variable_id] = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1584  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1585  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1586  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1587  				 * Allocate a new buffer
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1588  				 * of the requested size
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1589  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1590  				vars[variable_id] = (long)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1591  					kzalloc(long_tmp, GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1592  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1593  				if (vars[variable_id] == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1594  					status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1595  					break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1596  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1597  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1598  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1599  				 * Set the attribute bit to indicate that
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1600  				 * this buffer was dynamically allocated and
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1601  				 * should be freed later
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1602  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1603  				attrs[variable_id] |= 0x80;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1604  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1605  				/* zero out memory */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1606  				count = ((var_size[variable_id] + 7L) /
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1607  									8L);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1608  				charptr_tmp = (u8 *)(vars[variable_id]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1609  				for (index = 0; index < count; ++index)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1610  					charptr_tmp[index] = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1611  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1612  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1613  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1614  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1615  		case OP_EXPV:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1616  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1617  			 * Export Boolean array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1618  			 * ...argument 0 is string ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1619  			 * ...stack 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1620  			 * ...stack 1 is array right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1621  			 * ...stack 2 is array left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1622  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1623  			if (!altera_check_stack(stack_ptr, 3, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1624  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1625  			if (version == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1626  				/* EXPV is not supported in JBC 1.0 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1627  				bad_opcode = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1628  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1629  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1630  			name = &p[str_table + args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1631  			variable_id = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1632  			long_idx = stack[--stack_ptr];/* right indx */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1633  			long_idx2 = stack[--stack_ptr];/* left indx */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1634  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1635  			if (long_idx > long_idx2) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1636  				/* reverse indices not supported */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1637  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1638  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1639  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1640  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1641  			long_count = 1 + long_idx2 - long_idx;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1642  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1643  			charptr_tmp = (u8 *)vars[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1644  			charptr_tmp2 = NULL;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1645  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1646  			if ((long_idx & 7L) != 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1647  				s32 k = long_idx;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1648  				charptr_tmp2 =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1649  					kzalloc(((long_count + 7L) / 8L),
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1650  							GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1651  				if (charptr_tmp2 == NULL) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1652  					status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1653  					break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1654  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1655  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1656  				for (i = 0; i < long_count; ++i) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1657  					if (charptr_tmp[k >> 3] &
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1658  							(1 << (k & 7)))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1659  						charptr_tmp2[i >> 3] |=
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1660  								(1 << (i & 7));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1661  					else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1662  						charptr_tmp2[i >> 3] &=
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1663  								~(1 << (i & 7));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1664  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1665  					++k;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1666  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1667  				charptr_tmp = charptr_tmp2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1668  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1669  			} else if (long_idx != 0)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1670  				charptr_tmp = &charptr_tmp[long_idx >> 3];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1671  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1672  			altera_export_bool_array(name, charptr_tmp,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1673  							long_count);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1674  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1675  			/* free allocated buffer */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1676  			if ((long_idx & 7L) != 0)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1677  				kfree(charptr_tmp2);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1678  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1679  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1680  		case OP_COPY: {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1681  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1682  			 * Array copy
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1683  			 * ...argument 0 is dest ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1684  			 * ...argument 1 is source ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1685  			 * ...stack 0 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1686  			 * ...stack 1 is dest index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1687  			 * ...stack 2 is source index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1688  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1689  			s32 copy_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1690  			s32 copy_index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1691  			s32 copy_index2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1692  			s32 destleft;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1693  			s32 src_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1694  			s32 dest_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1695  			int src_reverse = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1696  			int dest_reverse = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1697  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1698  			if (!altera_check_stack(stack_ptr, 3, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1699  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1700  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1701  			copy_count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1702  			copy_index = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1703  			copy_index2 = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1704  			reverse = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1705  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1706  			if (version > 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1707  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1708  				 * stack 0 = source right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1709  				 * stack 1 = source left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1710  				 * stack 2 = destination right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1711  				 * stack 3 = destination left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1712  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1713  				destleft = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1714  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1715  				if (copy_count > copy_index) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1716  					src_reverse = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1717  					reverse = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1718  					src_count = 1 + copy_count - copy_index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1719  					/* copy_index = source start index */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1720  				} else {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1721  					src_count = 1 + copy_index - copy_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1722  					/* source start index */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1723  					copy_index = copy_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1724  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1725  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1726  				if (copy_index2 > destleft) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1727  					dest_reverse = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1728  					reverse = !reverse;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1729  					dest_count = 1 + copy_index2 - destleft;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1730  					/* destination start index */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1731  					copy_index2 = destleft;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1732  				} else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1733  					dest_count = 1 + destleft - copy_index2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1734  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1735  				copy_count = (src_count < dest_count) ?
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1736  							src_count : dest_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1737  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1738  				if ((src_reverse || dest_reverse) &&
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1739  					(src_count != dest_count))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1740  					/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1741  					 * If either the source or destination
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1742  					 * is reversed, we can't tolerate
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1743  					 * a length mismatch, because we
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1744  					 * "left justify" arrays when copying.
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1745  					 * This won't work correctly
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1746  					 * with reversed arrays.
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1747  					 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1748  					status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1749  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1750  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1751  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1752  			count = copy_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1753  			index = copy_index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1754  			index2 = copy_index2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1755  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1756  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1757  			 * If destination is a read-only array,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1758  			 * allocate a buffer and convert it to a writable array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1759  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1760  			variable_id = args[1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1761  			if ((version > 0) &&
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1762  				((attrs[variable_id] & 0x9c) == 0x0c)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1763  				/* Allocate a writable buffer for this array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1764  				long_tmp =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1765  					(var_size[variable_id] + 7L) >> 3L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1766  				charptr_tmp2 = (u8 *)vars[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1767  				charptr_tmp =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1768  					kzalloc(long_tmp, GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1769  				vars[variable_id] = (long)charptr_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1770  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1771  				if (vars[variable_id] == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1772  					status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1773  					break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1774  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1775  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1776  				/* zero the buffer */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1777  				for (long_idx = 0L; long_idx < long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1778  								++long_idx)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1779  					charptr_tmp[long_idx] = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1780  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1781  				/* copy previous contents into buffer */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1782  				for (long_idx = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1783  					long_idx < var_size[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1784  								++long_idx) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1785  					long_idx2 = long_idx;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1786  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1787  					if (charptr_tmp2[long_idx2 >> 3] &
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1788  						(1 << (long_idx2 & 7)))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1789  						charptr_tmp[long_idx >> 3] |=
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1790  							(1 << (long_idx & 7));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1791  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1792  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1793  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1794  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1795  				set bit 7 - buffer was dynamically allocated */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1796  				attrs[variable_id] |= 0x80;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1797  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1798  				/* clear bit 2 - variable is writable */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1799  				attrs[variable_id] &= ~0x04;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1800  				attrs[variable_id] |= 0x01;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1801  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1802  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1803  			charptr_tmp = (u8 *)vars[args[1]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1804  			charptr_tmp2 = (u8 *)vars[args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1805  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1806  			/* check if destination is a writable Boolean array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1807  			if ((attrs[args[1]] & 0x1c) != 0x08) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1808  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1809  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1810  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1811  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1812  			if (count < 1) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1813  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1814  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1815  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1816  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1817  			if (reverse)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1818  				index2 += (count - 1);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1819  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1820  			for (i = 0; i < count; ++i) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1821  				if (charptr_tmp2[index >> 3] &
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1822  							(1 << (index & 7)))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1823  					charptr_tmp[index2 >> 3] |=
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1824  							(1 << (index2 & 7));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1825  				else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1826  					charptr_tmp[index2 >> 3] &=
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1827  						~(1 << (index2 & 7));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1828  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1829  				++index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1830  				if (reverse)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1831  					--index2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1832  				else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1833  					++index2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1834  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1835  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1836  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1837  		}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1838  		case OP_DSC:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1839  		case OP_ISC: {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1840  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1841  			 * DRSCAN with capture
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1842  			 * IRSCAN with capture
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1843  			 * ...argument 0 is scan data variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1844  			 * ...argument 1 is capture variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1845  			 * ...stack 0 is capture index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1846  			 * ...stack 1 is scan data index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1847  			 * ...stack 2 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1848  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1849  			s32 scan_right, scan_left;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1850  			s32 capture_count = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1851  			s32 scan_count = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1852  			s32 capture_index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1853  			s32 scan_index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1854  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1855  			if (!altera_check_stack(stack_ptr, 3, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1856  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1857  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1858  			capture_index = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1859  			scan_index = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1860  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1861  			if (version > 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1862  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1863  				 * stack 0 = capture right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1864  				 * stack 1 = capture left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1865  				 * stack 2 = scan right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1866  				 * stack 3 = scan left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1867  				 * stack 4 = count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1868  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1869  				scan_right = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1870  				scan_left = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1871  				capture_count = 1 + scan_index - capture_index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1872  				scan_count = 1 + scan_left - scan_right;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1873  				scan_index = scan_right;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1874  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1875  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1876  			long_count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1877  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1878  			 * If capture array is read-only, allocate a buffer
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1879  			 * and convert it to a writable array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1880  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1881  			variable_id = args[1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1882  			if ((version > 0) &&
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1883  				((attrs[variable_id] & 0x9c) == 0x0c)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1884  				/* Allocate a writable buffer for this array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1885  				long_tmp =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1886  					(var_size[variable_id] + 7L) >> 3L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1887  				charptr_tmp2 = (u8 *)vars[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1888  				charptr_tmp =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1889  					kzalloc(long_tmp, GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1890  				vars[variable_id] = (long)charptr_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1891  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1892  				if (vars[variable_id] == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1893  					status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1894  					break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1895  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1896  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1897  				/* zero the buffer */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1898  				for (long_idx = 0L; long_idx < long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1899  								++long_idx)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1900  					charptr_tmp[long_idx] = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1901  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1902  				/* copy previous contents into buffer */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1903  				for (long_idx = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1904  					long_idx < var_size[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1905  								++long_idx) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1906  					long_idx2 = long_idx;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1907  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1908  					if (charptr_tmp2[long_idx2 >> 3] &
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1909  						(1 << (long_idx2 & 7)))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1910  						charptr_tmp[long_idx >> 3] |=
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1911  							(1 << (long_idx & 7));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1912  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1913  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1914  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1915  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1916  				 * set bit 7 - buffer was
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1917  				 * dynamically allocated
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1918  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1919  				attrs[variable_id] |= 0x80;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1920  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1921  				/* clear bit 2 - variable is writable */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1922  				attrs[variable_id] &= ~0x04;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1923  				attrs[variable_id] |= 0x01;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1924  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1925  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1926  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1927  			charptr_tmp = (u8 *)vars[args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1928  			charptr_tmp2 = (u8 *)vars[args[1]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1929  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1930  			if ((version > 0) &&
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1931  					((long_count > capture_count) ||
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1932  					(long_count > scan_count))) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1933  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1934  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1935  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1936  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1937  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1938  			 * check that capture array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1939  			 * is a writable Boolean array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1940  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1941  			if ((attrs[args[1]] & 0x1c) != 0x08) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1942  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1943  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1944  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1945  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1946  			if (status == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1947  				if (opcode == 0x82) /* DSC */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1948  					status = altera_swap_dr(astate,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1949  							long_count,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1950  							charptr_tmp,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1951  							scan_index,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1952  							charptr_tmp2,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1953  							capture_index);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1954  				else /* ISC */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1955  					status = altera_swap_ir(astate,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1956  							long_count,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1957  							charptr_tmp,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1958  							scan_index,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1959  							charptr_tmp2,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1960  							capture_index);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1961  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1962  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1963  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1964  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1965  		}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1966  		case OP_WAIT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1967  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1968  			 * WAIT
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1969  			 * ...argument 0 is wait state
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1970  			 * ...argument 1 is end state
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1971  			 * ...stack 0 is cycles
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1972  			 * ...stack 1 is microseconds
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1973  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1974  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1975  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1976  			long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1977  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1978  			if (long_tmp != 0L)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1979  				status = altera_wait_cycles(astate, long_tmp,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1980  								args[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1981  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1982  			long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1983  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1984  			if ((status == 0) && (long_tmp != 0L))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1985  				status = altera_wait_msecs(astate,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1986  								long_tmp,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1987  								args[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1988  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1989  			if ((status == 0) && (args[1] != args[0]))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1990  				status = altera_goto_jstate(astate,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1991  								args[1]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1992  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1993  			if (version > 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1994  				--stack_ptr; /* throw away MAX cycles */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1995  				--stack_ptr; /* throw away MAX microseconds */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1996  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1997  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1998  		case OP_CMPA: {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1999  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2000  			 * Array compare
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2001  			 * ...argument 0 is source 1 ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2002  			 * ...argument 1 is source 2 ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2003  			 * ...argument 2 is mask ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2004  			 * ...stack 0 is source 1 index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2005  			 * ...stack 1 is source 2 index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2006  			 * ...stack 2 is mask index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2007  			 * ...stack 3 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2008  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2009  			s32 a, b;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2010  			u8 *source1 = (u8 *)vars[args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2011  			u8 *source2 = (u8 *)vars[args[1]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2012  			u8 *mask = (u8 *)vars[args[2]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2013  			u32 index1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2014  			u32 index2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2015  			u32 mask_index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2016  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2017  			if (!altera_check_stack(stack_ptr, 4, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2018  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2019  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2020  			index1 = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2021  			index2 = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2022  			mask_index = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2023  			long_count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2024  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2025  			if (version > 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2026  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2027  				 * stack 0 = source 1 right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2028  				 * stack 1 = source 1 left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2029  				 * stack 2 = source 2 right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2030  				 * stack 3 = source 2 left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2031  				 * stack 4 = mask right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2032  				 * stack 5 = mask left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2033  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2034  				s32 mask_right = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2035  				s32 mask_left = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2036  				/* source 1 count */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2037  				a = 1 + index2 - index1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2038  				/* source 2 count */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2039  				b = 1 + long_count - mask_index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2040  				a = (a < b) ? a : b;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2041  				/* mask count */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2042  				b = 1 + mask_left - mask_right;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2043  				a = (a < b) ? a : b;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2044  				/* source 2 start index */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2045  				index2 = mask_index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2046  				/* mask start index */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2047  				mask_index = mask_right;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2048  				long_count = a;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2049  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2050  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2051  			long_tmp = 1L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2052  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2053  			if (long_count < 1)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2054  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2055  			else {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2056  				count = long_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2057  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2058  				for (i = 0; i < count; ++i) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2059  					if (mask[mask_index >> 3] &
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2060  						(1 << (mask_index & 7))) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2061  						a = source1[index1 >> 3] &
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2062  							(1 << (index1 & 7))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2063  								? 1 : 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2064  						b = source2[index2 >> 3] &
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2065  							(1 << (index2 & 7))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2066  								? 1 : 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2067  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2068  						if (a != b) /* failure */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2069  							long_tmp = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2070  					}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2071  					++index1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2072  					++index2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2073  					++mask_index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2074  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2075  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2076  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2077  			stack[stack_ptr++] = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2078  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2079  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2080  		}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2081  		default:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2082  			/* Unrecognized opcode -- ERROR! */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2083  			bad_opcode = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2084  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2085  		}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2086  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2087  		if (bad_opcode)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2088  			status = -ENOSYS;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2089  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2090  		if ((stack_ptr < 0) || (stack_ptr >= ALTERA_STACK_SIZE))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2091  			status = -EOVERFLOW;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2092  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2093  		if (status != 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2094  			done = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2095  			*error_address = (s32)(opcode_address - code_sect);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2096  		}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2097  	}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2098  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2099  	altera_free_buffers(astate);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2100  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2101  	/* Free all dynamically allocated arrays */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2102  	if ((attrs != NULL) && (vars != NULL))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2103  		for (i = 0; i < sym_count; ++i)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2104  			if (attrs[i] & 0x80)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2105  				kfree((void *)vars[i]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2106  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2107  	kfree(vars);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2108  	kfree(var_size);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2109  	kfree(attrs);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2110  	kfree(proc_attributes);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2111  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2112  	return status;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25 @2113  }
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2114  

:::::: The code at line 2113 was first introduced by commit
:::::: fa766c9be58bd872784b081074a7d15a3ce61c5f [media] Altera FPGA firmware download module

:::::: TO: Igor M. Liplianin <liplianin@me.by>
:::::: CC: Mauro Carvalho Chehab <mchehab@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--sdtB3X0nJg68CQEu
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
H7D/6v9OF6VHb+XqDcuJnq81IfPlcYmkzyV0ox9SxLXWKcHeXXlm/4EqjXXiJlQU5cxJCRIX
gKuC5Bh9ETuxb3aQ48ShyeqFmiANee8e1/r341DPXKPkAhKtbOYK6R91/kSNKbF0UkgRI6rn
HErKyBgEPMseZjTjExgY2tE0VfA2cZiQhxqXBuXmxyyO7OanvzN8+hYsE737kWaMXqirF10p
osBtW+lcIn1NoGHsZiqlDFdK3NWldiut5+ojMwUXBk1ADBo/0GQhKzbY3NXG6IYRoFZMRzxC
nPgO6dR1wBFem7Iq6qUNyGS7dnTRzVNDRnG0+aEhjmBse05HUFeu9igXAB0rvZh8aW9BtdYc
iegJaeVBxRrrOXzOXJhO8QBRQ915nEsXO7LopuMMYBVa1Aqxrt5Ec3qk8OjKVSi4aHYXWQ95
1pfX9683ybfz69Pjw8un28vr+eHlhi2D6FPK56WMDdaSgVR6jqOJatMFY9wNpXGQ7JJbXnyv
MQW/WZ8pyl3GfF9Pf6QGJDVM9HzLHXSVfRzzkepQK5RcPA9x4GlCIWgnaBc9qxEZVtRW+JyZ
Oyuuos+uay61pGtLLLhxyMX0Yd9Zn3pOr2SszuD/8XFpZDlL8dKJ1jDcXFj58+M92XiGSkrw
5vLy/NdoFX5qy1JNVayIK/USMxzUDhS+rXYSz3oeWX2eTs+PTis4N39cXoXtojctaGZ/fbz/
1ZJBWW/2XmAIFlJtggNgqw9OTtPaDG+zrHRZ5kT9a0HURjZ68MYZrXLXx7uSWneeUdNaTdgG
DFbLywCjagnD4E9LqsXRC5zAGBHcH/KuTfU4AZCH/BHcN92h9xOtzn3aME87RbbPy7yeryin
l2/fLi/SpeGf8jpwPM/9mX6SVlPQzlo3MFtvSppdLs9vN++43fav8/Pl+83L+d9WY/1QVfen
bU64R4YXxBPfvT58/4qXnpfjj8sa5i7BV5Lphuwqw0hPgLYsXc75y2SxyPn68O188/uPP/7A
hyP1tc4ttEiVlcrjkECrG1Zs72WS3PPTWZgTOIvURLjFU4GpkiAP+Q8THXH+G4sAP9uiLDtx
skMF0qa9h8wSAyiqZJdvykL9pL/v6bQQINNCQE5rqSeUqunyYlef8hr8Yiq45pSjco4HGyDf
5l2XZyf5pBcyQz8rb7Vh4yTpbVns9mp58YGE8X1nNWlWlLyorKjn4zZKL3+d3mE1RgC2XNF1
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
6t7goKDBeq+xT66uY9Ou7oP/A8llGXg0mwEA

--sdtB3X0nJg68CQEu--
