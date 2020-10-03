Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC8B282287
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 10:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgJCIla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 04:41:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:8550 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgJCIl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 04:41:29 -0400
IronPort-SDR: gEEy8QFY/ROP+gw2R9KgKNj7WAEXkz3+Ub1EYjSY/OIe6FzdYxFxOTPgF1HyuE12nztPn6z6Gb
 sFgUeMjAmxiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="142567081"
X-IronPort-AV: E=Sophos;i="5.77,331,1596524400"; 
   d="gz'50?scan'50,208,50";a="142567081"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2020 01:41:26 -0700
IronPort-SDR: WFntKQ6WXa3PQVxvt5o1GUHV2IUGCaAGrC2g1MEOQLR71/yhBoeqxSz+K7QEkLyO76qQUsPTZD
 UW1ekb3Ln50Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,331,1596524400"; 
   d="gz'50?scan'50,208,50";a="313760430"
Received: from lkp-server02.sh.intel.com (HELO 404f47266ee4) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 03 Oct 2020 01:41:24 -0700
Received: from kbuild by 404f47266ee4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kOd6Z-0000KI-Q9; Sat, 03 Oct 2020 08:41:23 +0000
Date:   Sat, 3 Oct 2020 16:40:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>
Subject: arch/arm/include/asm/arch_gicv3.h:44:2: error: implicit declaration
 of function 'write_sysreg'
Message-ID: <202010031647.4mRtqrlB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peng,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d3d45f8220d60a0b2aaaacf8fb2be4e6ffd9008e
commit: d82bcef5157de1368c08244a846ab968b3e5cb7e soc: imx: select ARM_GIC_V3 for i.MX8M
date:   3 months ago
config: arm-randconfig-r002-20201003 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d82bcef5157de1368c08244a846ab968b3e5cb7e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d82bcef5157de1368c08244a846ab968b3e5cb7e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/irqchip/arm-gic-v3.h:662,
                    from drivers/irqchip/irq-gic-v3.c:24:
   arch/arm/include/asm/arch_gicv3.h: In function 'write_ICC_PMR_EL1':
>> arch/arm/include/asm/arch_gicv3.h:44:2: error: implicit declaration of function 'write_sysreg' [-Werror=implicit-function-declaration]
      44 |  write_sysreg(val, a32);   \
         |  ^~~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:51:1: note: in expansion of macro 'CPUIF_MAP'
      51 | CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
         | ^~~~~~~~~
>> arch/arm/include/asm/arch_gicv3.h:22:20: error: implicit declaration of function '__ACCESS_CP15' [-Werror=implicit-function-declaration]
      22 | #define ICC_PMR    __ACCESS_CP15(c4, 0, c6, 0)
         |                    ^~~~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:51:11: note: in expansion of macro 'ICC_PMR'
      51 | CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
         |           ^~~~~~~
>> arch/arm/include/asm/arch_gicv3.h:22:34: error: 'c4' undeclared (first use in this function)
      22 | #define ICC_PMR    __ACCESS_CP15(c4, 0, c6, 0)
         |                                  ^~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:51:11: note: in expansion of macro 'ICC_PMR'
      51 | CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
         |           ^~~~~~~
   arch/arm/include/asm/arch_gicv3.h:22:34: note: each undeclared identifier is reported only once for each function it appears in
      22 | #define ICC_PMR    __ACCESS_CP15(c4, 0, c6, 0)
         |                                  ^~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:51:11: note: in expansion of macro 'ICC_PMR'
      51 | CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
         |           ^~~~~~~
>> arch/arm/include/asm/arch_gicv3.h:22:41: error: 'c6' undeclared (first use in this function)
      22 | #define ICC_PMR    __ACCESS_CP15(c4, 0, c6, 0)
         |                                         ^~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:51:11: note: in expansion of macro 'ICC_PMR'
      51 | CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
         |           ^~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'read_ICC_PMR_EL1':
>> arch/arm/include/asm/arch_gicv3.h:48:9: error: implicit declaration of function 'read_sysreg' [-Werror=implicit-function-declaration]
      48 |  return read_sysreg(a32);   \
         |         ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:51:1: note: in expansion of macro 'CPUIF_MAP'
      51 | CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
         | ^~~~~~~~~
>> arch/arm/include/asm/arch_gicv3.h:22:34: error: 'c4' undeclared (first use in this function)
      22 | #define ICC_PMR    __ACCESS_CP15(c4, 0, c6, 0)
         |                                  ^~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:51:11: note: in expansion of macro 'ICC_PMR'
      51 | CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
         |           ^~~~~~~
>> arch/arm/include/asm/arch_gicv3.h:22:41: error: 'c6' undeclared (first use in this function)
      22 | #define ICC_PMR    __ACCESS_CP15(c4, 0, c6, 0)
         |                                         ^~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:51:11: note: in expansion of macro 'ICC_PMR'
      51 | CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
         |           ^~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'write_ICC_AP0R0_EL1':
>> arch/arm/include/asm/arch_gicv3.h:29:40: error: 'c12' undeclared (first use in this function)
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                        ^~~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:30:21: note: in expansion of macro '__ICC_AP0Rx'
      30 | #define ICC_AP0R0   __ICC_AP0Rx(0)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:52:11: note: in expansion of macro 'ICC_AP0R0'
      52 | CPUIF_MAP(ICC_AP0R0, ICC_AP0R0_EL1)
         |           ^~~~~~~~~
>> arch/arm/include/asm/arch_gicv3.h:29:48: error: 'c8' undeclared (first use in this function); did you mean 'u8'?
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                                ^~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:30:21: note: in expansion of macro '__ICC_AP0Rx'
      30 | #define ICC_AP0R0   __ICC_AP0Rx(0)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:52:11: note: in expansion of macro 'ICC_AP0R0'
      52 | CPUIF_MAP(ICC_AP0R0, ICC_AP0R0_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'read_ICC_AP0R0_EL1':
>> arch/arm/include/asm/arch_gicv3.h:29:40: error: 'c12' undeclared (first use in this function)
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                        ^~~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:30:21: note: in expansion of macro '__ICC_AP0Rx'
      30 | #define ICC_AP0R0   __ICC_AP0Rx(0)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:52:11: note: in expansion of macro 'ICC_AP0R0'
      52 | CPUIF_MAP(ICC_AP0R0, ICC_AP0R0_EL1)
         |           ^~~~~~~~~
>> arch/arm/include/asm/arch_gicv3.h:29:48: error: 'c8' undeclared (first use in this function); did you mean 'u8'?
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                                ^~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:30:21: note: in expansion of macro '__ICC_AP0Rx'
      30 | #define ICC_AP0R0   __ICC_AP0Rx(0)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:52:11: note: in expansion of macro 'ICC_AP0R0'
      52 | CPUIF_MAP(ICC_AP0R0, ICC_AP0R0_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'write_ICC_AP0R1_EL1':
>> arch/arm/include/asm/arch_gicv3.h:29:40: error: 'c12' undeclared (first use in this function)
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                        ^~~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:31:21: note: in expansion of macro '__ICC_AP0Rx'
      31 | #define ICC_AP0R1   __ICC_AP0Rx(1)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:53:11: note: in expansion of macro 'ICC_AP0R1'
      53 | CPUIF_MAP(ICC_AP0R1, ICC_AP0R1_EL1)
         |           ^~~~~~~~~
>> arch/arm/include/asm/arch_gicv3.h:29:48: error: 'c8' undeclared (first use in this function); did you mean 'u8'?
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                                ^~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:31:21: note: in expansion of macro '__ICC_AP0Rx'
      31 | #define ICC_AP0R1   __ICC_AP0Rx(1)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:53:11: note: in expansion of macro 'ICC_AP0R1'
      53 | CPUIF_MAP(ICC_AP0R1, ICC_AP0R1_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'read_ICC_AP0R1_EL1':
>> arch/arm/include/asm/arch_gicv3.h:29:40: error: 'c12' undeclared (first use in this function)
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                        ^~~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:31:21: note: in expansion of macro '__ICC_AP0Rx'
      31 | #define ICC_AP0R1   __ICC_AP0Rx(1)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:53:11: note: in expansion of macro 'ICC_AP0R1'
      53 | CPUIF_MAP(ICC_AP0R1, ICC_AP0R1_EL1)
         |           ^~~~~~~~~
>> arch/arm/include/asm/arch_gicv3.h:29:48: error: 'c8' undeclared (first use in this function); did you mean 'u8'?
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                                ^~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:31:21: note: in expansion of macro '__ICC_AP0Rx'
      31 | #define ICC_AP0R1   __ICC_AP0Rx(1)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:53:11: note: in expansion of macro 'ICC_AP0R1'
      53 | CPUIF_MAP(ICC_AP0R1, ICC_AP0R1_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'write_ICC_AP0R2_EL1':
>> arch/arm/include/asm/arch_gicv3.h:29:40: error: 'c12' undeclared (first use in this function)
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                        ^~~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:32:21: note: in expansion of macro '__ICC_AP0Rx'
      32 | #define ICC_AP0R2   __ICC_AP0Rx(2)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:54:11: note: in expansion of macro 'ICC_AP0R2'
      54 | CPUIF_MAP(ICC_AP0R2, ICC_AP0R2_EL1)
         |           ^~~~~~~~~
>> arch/arm/include/asm/arch_gicv3.h:29:48: error: 'c8' undeclared (first use in this function); did you mean 'u8'?
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                                ^~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:32:21: note: in expansion of macro '__ICC_AP0Rx'
      32 | #define ICC_AP0R2   __ICC_AP0Rx(2)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:54:11: note: in expansion of macro 'ICC_AP0R2'
      54 | CPUIF_MAP(ICC_AP0R2, ICC_AP0R2_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'read_ICC_AP0R2_EL1':
>> arch/arm/include/asm/arch_gicv3.h:29:40: error: 'c12' undeclared (first use in this function)
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                        ^~~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:32:21: note: in expansion of macro '__ICC_AP0Rx'
      32 | #define ICC_AP0R2   __ICC_AP0Rx(2)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:54:11: note: in expansion of macro 'ICC_AP0R2'
      54 | CPUIF_MAP(ICC_AP0R2, ICC_AP0R2_EL1)
         |           ^~~~~~~~~
>> arch/arm/include/asm/arch_gicv3.h:29:48: error: 'c8' undeclared (first use in this function); did you mean 'u8'?
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                                ^~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:32:21: note: in expansion of macro '__ICC_AP0Rx'
      32 | #define ICC_AP0R2   __ICC_AP0Rx(2)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:54:11: note: in expansion of macro 'ICC_AP0R2'
      54 | CPUIF_MAP(ICC_AP0R2, ICC_AP0R2_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'write_ICC_AP0R3_EL1':
>> arch/arm/include/asm/arch_gicv3.h:29:40: error: 'c12' undeclared (first use in this function)
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                        ^~~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:33:21: note: in expansion of macro '__ICC_AP0Rx'
      33 | #define ICC_AP0R3   __ICC_AP0Rx(3)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:55:11: note: in expansion of macro 'ICC_AP0R3'
      55 | CPUIF_MAP(ICC_AP0R3, ICC_AP0R3_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:29:48: error: 'c8' undeclared (first use in this function); did you mean 'u8'?
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                                ^~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:33:21: note: in expansion of macro '__ICC_AP0Rx'
      33 | #define ICC_AP0R3   __ICC_AP0Rx(3)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:55:11: note: in expansion of macro 'ICC_AP0R3'
      55 | CPUIF_MAP(ICC_AP0R3, ICC_AP0R3_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'read_ICC_AP0R3_EL1':
   arch/arm/include/asm/arch_gicv3.h:29:40: error: 'c12' undeclared (first use in this function)
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                        ^~~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:33:21: note: in expansion of macro '__ICC_AP0Rx'
      33 | #define ICC_AP0R3   __ICC_AP0Rx(3)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:55:11: note: in expansion of macro 'ICC_AP0R3'
      55 | CPUIF_MAP(ICC_AP0R3, ICC_AP0R3_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:29:48: error: 'c8' undeclared (first use in this function); did you mean 'u8'?
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                                ^~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:33:21: note: in expansion of macro '__ICC_AP0Rx'
      33 | #define ICC_AP0R3   __ICC_AP0Rx(3)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:55:11: note: in expansion of macro 'ICC_AP0R3'
      55 | CPUIF_MAP(ICC_AP0R3, ICC_AP0R3_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'write_ICC_AP1R0_EL1':
   arch/arm/include/asm/arch_gicv3.h:35:40: error: 'c12' undeclared (first use in this function)
      35 | #define __ICC_AP1Rx(x)   __ACCESS_CP15(c12, 0, c9, x)
         |                                        ^~~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:36:21: note: in expansion of macro '__ICC_AP1Rx'
      36 | #define ICC_AP1R0   __ICC_AP1Rx(0)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:56:11: note: in expansion of macro 'ICC_AP1R0'
      56 | CPUIF_MAP(ICC_AP1R0, ICC_AP1R0_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:35:48: error: 'c9' undeclared (first use in this function)
      35 | #define __ICC_AP1Rx(x)   __ACCESS_CP15(c12, 0, c9, x)
         |                                                ^~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:36:21: note: in expansion of macro '__ICC_AP1Rx'
      36 | #define ICC_AP1R0   __ICC_AP1Rx(0)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:56:11: note: in expansion of macro 'ICC_AP1R0'
      56 | CPUIF_MAP(ICC_AP1R0, ICC_AP1R0_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'read_ICC_AP1R0_EL1':
   arch/arm/include/asm/arch_gicv3.h:35:40: error: 'c12' undeclared (first use in this function)
      35 | #define __ICC_AP1Rx(x)   __ACCESS_CP15(c12, 0, c9, x)
         |                                        ^~~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:36:21: note: in expansion of macro '__ICC_AP1Rx'
      36 | #define ICC_AP1R0   __ICC_AP1Rx(0)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:56:11: note: in expansion of macro 'ICC_AP1R0'
      56 | CPUIF_MAP(ICC_AP1R0, ICC_AP1R0_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:35:48: error: 'c9' undeclared (first use in this function)
      35 | #define __ICC_AP1Rx(x)   __ACCESS_CP15(c12, 0, c9, x)
         |                                                ^~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:36:21: note: in expansion of macro '__ICC_AP1Rx'
      36 | #define ICC_AP1R0   __ICC_AP1Rx(0)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:56:11: note: in expansion of macro 'ICC_AP1R0'
      56 | CPUIF_MAP(ICC_AP1R0, ICC_AP1R0_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'write_ICC_AP1R1_EL1':
   arch/arm/include/asm/arch_gicv3.h:35:40: error: 'c12' undeclared (first use in this function)
..

vim +/write_sysreg +44 arch/arm/include/asm/arch_gicv3.h

d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   17  
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   18  #define ICC_EOIR1			__ACCESS_CP15(c12, 0, c12, 1)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  @19  #define ICC_DIR				__ACCESS_CP15(c12, 0, c11, 1)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   20  #define ICC_IAR1			__ACCESS_CP15(c12, 0, c12, 0)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  @21  #define ICC_SGI1R			__ACCESS_CP15_64(0, c12)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  @22  #define ICC_PMR				__ACCESS_CP15(c4, 0, c6, 0)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   23  #define ICC_CTLR			__ACCESS_CP15(c12, 0, c12, 4)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   24  #define ICC_SRE				__ACCESS_CP15(c12, 0, c12, 5)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   25  #define ICC_IGRPEN1			__ACCESS_CP15(c12, 0, c12, 7)
91ef84428a86b75 Daniel Thompson       2016-08-19   26  #define ICC_BPR1			__ACCESS_CP15(c12, 0, c12, 3)
e99da7c6f51b487 Julien Thierry        2019-01-31   27  #define ICC_RPR				__ACCESS_CP15(c12, 0, c11, 3)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   28  
d6062a6d62c643a Marc Zyngier          2018-03-09  @29  #define __ICC_AP0Rx(x)			__ACCESS_CP15(c12, 0, c8, 4 | x)
d6062a6d62c643a Marc Zyngier          2018-03-09   30  #define ICC_AP0R0			__ICC_AP0Rx(0)
d6062a6d62c643a Marc Zyngier          2018-03-09   31  #define ICC_AP0R1			__ICC_AP0Rx(1)
d6062a6d62c643a Marc Zyngier          2018-03-09   32  #define ICC_AP0R2			__ICC_AP0Rx(2)
d6062a6d62c643a Marc Zyngier          2018-03-09   33  #define ICC_AP0R3			__ICC_AP0Rx(3)
d6062a6d62c643a Marc Zyngier          2018-03-09   34  
d6062a6d62c643a Marc Zyngier          2018-03-09  @35  #define __ICC_AP1Rx(x)			__ACCESS_CP15(c12, 0, c9, x)
d6062a6d62c643a Marc Zyngier          2018-03-09   36  #define ICC_AP1R0			__ICC_AP1Rx(0)
d6062a6d62c643a Marc Zyngier          2018-03-09   37  #define ICC_AP1R1			__ICC_AP1Rx(1)
d6062a6d62c643a Marc Zyngier          2018-03-09   38  #define ICC_AP1R2			__ICC_AP1Rx(2)
d6062a6d62c643a Marc Zyngier          2018-03-09   39  #define ICC_AP1R3			__ICC_AP1Rx(3)
d6062a6d62c643a Marc Zyngier          2018-03-09   40  
a078bedf17c2e43 Vladimir Murzin       2016-09-12   41  #define CPUIF_MAP(a32, a64)			\
a078bedf17c2e43 Vladimir Murzin       2016-09-12   42  static inline void write_ ## a64(u32 val)	\
a078bedf17c2e43 Vladimir Murzin       2016-09-12   43  {						\
a078bedf17c2e43 Vladimir Murzin       2016-09-12  @44  	write_sysreg(val, a32);			\
a078bedf17c2e43 Vladimir Murzin       2016-09-12   45  }						\
a078bedf17c2e43 Vladimir Murzin       2016-09-12   46  static inline u32 read_ ## a64(void)		\
a078bedf17c2e43 Vladimir Murzin       2016-09-12   47  {						\
a078bedf17c2e43 Vladimir Murzin       2016-09-12  @48  	return read_sysreg(a32); 		\
a078bedf17c2e43 Vladimir Murzin       2016-09-12   49  }						\
a078bedf17c2e43 Vladimir Murzin       2016-09-12   50  
33625282adaaba9 Marc Zyngier          2018-03-20   51  CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
d6062a6d62c643a Marc Zyngier          2018-03-09   52  CPUIF_MAP(ICC_AP0R0, ICC_AP0R0_EL1)
d6062a6d62c643a Marc Zyngier          2018-03-09   53  CPUIF_MAP(ICC_AP0R1, ICC_AP0R1_EL1)
d6062a6d62c643a Marc Zyngier          2018-03-09   54  CPUIF_MAP(ICC_AP0R2, ICC_AP0R2_EL1)
d6062a6d62c643a Marc Zyngier          2018-03-09   55  CPUIF_MAP(ICC_AP0R3, ICC_AP0R3_EL1)
d6062a6d62c643a Marc Zyngier          2018-03-09   56  CPUIF_MAP(ICC_AP1R0, ICC_AP1R0_EL1)
d6062a6d62c643a Marc Zyngier          2018-03-09   57  CPUIF_MAP(ICC_AP1R1, ICC_AP1R1_EL1)
d6062a6d62c643a Marc Zyngier          2018-03-09   58  CPUIF_MAP(ICC_AP1R2, ICC_AP1R2_EL1)
d6062a6d62c643a Marc Zyngier          2018-03-09   59  CPUIF_MAP(ICC_AP1R3, ICC_AP1R3_EL1)
d6062a6d62c643a Marc Zyngier          2018-03-09   60  
a078bedf17c2e43 Vladimir Murzin       2016-09-12   61  #define read_gicreg(r)                 read_##r()
a078bedf17c2e43 Vladimir Murzin       2016-09-12   62  #define write_gicreg(v, r)             write_##r(v)
a078bedf17c2e43 Vladimir Murzin       2016-09-12   63  
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   64  /* Low-level accessors */
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   65  
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   66  static inline void gic_write_eoir(u32 irq)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   67  {
4f2546384150e78 Vladimir Murzin       2016-09-12   68  	write_sysreg(irq, ICC_EOIR1);
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   69  	isb();
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   70  }
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   71  
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   72  static inline void gic_write_dir(u32 val)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   73  {
4f2546384150e78 Vladimir Murzin       2016-09-12   74  	write_sysreg(val, ICC_DIR);
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   75  	isb();
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   76  }
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   77  
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   78  static inline u32 gic_read_iar(void)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   79  {
4f2546384150e78 Vladimir Murzin       2016-09-12   80  	u32 irqstat = read_sysreg(ICC_IAR1);
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   81  
8f318526a292c5e Marc Zyngier          2016-02-18   82  	dsb(sy);
4f2546384150e78 Vladimir Murzin       2016-09-12   83  
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   84  	return irqstat;
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   85  }
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   86  
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   87  static inline void gic_write_ctlr(u32 val)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   88  {
4f2546384150e78 Vladimir Murzin       2016-09-12   89  	write_sysreg(val, ICC_CTLR);
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   90  	isb();
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   91  }
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   92  
eda0d04acc5e317 Shanker Donthineni    2017-10-06   93  static inline u32 gic_read_ctlr(void)
eda0d04acc5e317 Shanker Donthineni    2017-10-06   94  {
eda0d04acc5e317 Shanker Donthineni    2017-10-06   95  	return read_sysreg(ICC_CTLR);
eda0d04acc5e317 Shanker Donthineni    2017-10-06   96  }
eda0d04acc5e317 Shanker Donthineni    2017-10-06   97  
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   98  static inline void gic_write_grpen1(u32 val)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01   99  {
4f2546384150e78 Vladimir Murzin       2016-09-12  100  	write_sysreg(val, ICC_IGRPEN1);
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  101  	isb();
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  102  }
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  103  
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  104  static inline void gic_write_sgi1r(u64 val)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  105  {
4f2546384150e78 Vladimir Murzin       2016-09-12  106  	write_sysreg(val, ICC_SGI1R);
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  107  }
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  108  
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  109  static inline u32 gic_read_sre(void)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  110  {
4f2546384150e78 Vladimir Murzin       2016-09-12  111  	return read_sysreg(ICC_SRE);
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  112  }
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  113  
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  114  static inline void gic_write_sre(u32 val)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  115  {
4f2546384150e78 Vladimir Murzin       2016-09-12  116  	write_sysreg(val, ICC_SRE);
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  117  	isb();
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  118  }
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  119  
91ef84428a86b75 Daniel Thompson       2016-08-19  120  static inline void gic_write_bpr1(u32 val)
91ef84428a86b75 Daniel Thompson       2016-08-19  121  {
3d9cd95f90b2987 Marc Zyngier          2016-09-23  122  	write_sysreg(val, ICC_BPR1);
91ef84428a86b75 Daniel Thompson       2016-08-19  123  }
91ef84428a86b75 Daniel Thompson       2016-08-19  124  
e99da7c6f51b487 Julien Thierry        2019-01-31  125  static inline u32 gic_read_pmr(void)
e99da7c6f51b487 Julien Thierry        2019-01-31  126  {
e99da7c6f51b487 Julien Thierry        2019-01-31  127  	return read_sysreg(ICC_PMR);
e99da7c6f51b487 Julien Thierry        2019-01-31  128  }
e99da7c6f51b487 Julien Thierry        2019-01-31  129  
e99da7c6f51b487 Julien Thierry        2019-01-31  130  static inline void gic_write_pmr(u32 val)
e99da7c6f51b487 Julien Thierry        2019-01-31  131  {
e99da7c6f51b487 Julien Thierry        2019-01-31  132  	write_sysreg(val, ICC_PMR);
e99da7c6f51b487 Julien Thierry        2019-01-31  133  }
e99da7c6f51b487 Julien Thierry        2019-01-31  134  
e99da7c6f51b487 Julien Thierry        2019-01-31  135  static inline u32 gic_read_rpr(void)
e99da7c6f51b487 Julien Thierry        2019-01-31  136  {
e99da7c6f51b487 Julien Thierry        2019-01-31  137  	return read_sysreg(ICC_RPR);
e99da7c6f51b487 Julien Thierry        2019-01-31 @138  }
e99da7c6f51b487 Julien Thierry        2019-01-31  139  

:::::: The code at line 44 was first introduced by commit
:::::: a078bedf17c2e43819fea54bdfd5793845142e3a ARM: gic-v3: Introduce 32-to-64-bit mappings for GICv3 cpu registers

:::::: TO: Vladimir Murzin <vladimir.murzin@arm.com>
:::::: CC: Christoffer Dall <christoffer.dall@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--5mCyUwZo2JvN/JJP
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICNcueF8AAy5jb25maWcAlFzdc9u2sn/vX8FJZ+6c85BWlmMnnjt+AEFQQkUSCAHKsl84
is2kmmPLOZLcNv/93QW/ABJUeztz5li7i+/F7m8Xy/z8088BeTu9vmxPu8ft8/OP4Fu1rw7b
U/UUfN09V/8bRCLIhA5YxPUvIJzs9m9//bo9vARXv3z6Zfb+8HgRrKrDvnoO6Ov+6+7bGzTe
ve5/+vknKrKYL0pKyzXLFRdZqdlG376Dxu+fsZv33/Zv1fbL7v23x8fgXwtK/x3c/HL5y+yd
1ZSrEhi3P1rSou/u9mZ2OZu1jCTq6PPLDzPzX9dPQrJFx55Z3S+JKolKy4XQoh/EYvAs4Rnr
WTz/XN6JfAUUWOLPwcJs13NwrE5v3/tFh7lYsayENatUWq0zrkuWrUuSw4x5yvXt5Rx6accV
qeQJg31SOtgdg/3rCTvuligoSdpVvHvnI5eksBcSFhz2RZFEW/JLsmbliuUZS8rFA7emZ3OS
h5T4OZuHqRZiivGhZ7gDd0u3RrVXPuRvHs5xYQbn2R88uxqxmBSJNmdj7VJLXgqlM5Ky23f/
2r/uq393Auperbm0VLMh4P9TndiLk0LxTZl+LljBPDO4I5ouS8O1WxWKJTz0LogUcB09PZld
Jzn0ZiRwJiRJWl0F3Q2Ob1+OP46n6qXX1QXLWM6pUW2Zi9DSdpulluJumlMmbM0SP5/FMaOa
49TiuEyJWvnlePYbyoFyW2qUR8BSpborc6ZYFvmb0qWtx0iJREp45tIUT31C5ZKzHHftftx5
qjhKTjJG4yxJFsEVbnp2mqJ4LHLKolIvc0Yini0s9ZEkV8w/mBmIhcUiVkZDqv1T8Pp1cKC+
RimoMG/mlI/7pWA7VnBwmVatkujdS3U4+vRk+VBKaCUiTm01zQRyOAzgUUjDtKWXfLHEkyw1
T8FkudrdLGs0Besm5YylUkO/GfPejFZgLZIi0yS/90yqkem3o21EBbQZkWuFNJtDZfGr3h7/
E5xgisEWpns8bU/HYPv4+Pq2P+323/rt0pyuSmhQEmr6rQ+7m+ia53rAxmPxLgpPEvfLkvUs
K1QR3l/KlEJBbY825JXrS+9IGi6n0kQr37Ypbu0NqH9rIiOuSJiwyFbNf7BTZkdzWgRqrGsa
tr4E3viMHCL8KNkGtNI6NeVImI4GJFyjadpcAw9rRCoi5qPrnFA2nhNsYZKgO09tY4acjMHt
V2xBw4Qr7fJikonCIIIREcwriW8vrvuTQl4ohAsUHG4maIga5jnKweRLNEZlGtoH6B5MZ8JW
9R+WUVt1BySoTV5Cn3DDe1IiEJDE4C54rG/ns/5keaZXgFJiNpC5uBwaLEWXsH/GbLV3Uj3+
Xj29PVeH4Gu1Pb0dqqMhN8vwcDuUt8hFIZV9TVKW0oV3Q8Nk1TTwbGfNqCfXrzcmPC9dTo/0
YlWGYJXveKSXnh7BNnj7bEaSPHLm3ZDzaAI9NfwYLsMDy6dXELE1p2w0HChRY1AG02B5PCIa
P9VTETuBawPL42AbrcrMZ2QQQGWuqGK5XxZ2oZZth2La+Q1bR1dSgHahx9Eid+BVrUqIl0fH
2svcKzioiIHxoUSzyHdSLCEWbkA9gV00aDK3Ds78Jin0pkQBEMBCmnk0QsNACoE099/taAST
e87mYdDPFCY2LB8eBqOCntC95RARCfCEKX9gCGHMyYs8JRl19nQopuAPzxAdQrZha8Gji2tr
I6WlWp2N77UCpT1dG8CDKuMc9YJphJ1lA4jPnLVHor3ONYoa4/oxknEMm+3CjKHLUsuPOneF
JTHsfG5dwJAAJIyLxNqsuIAwevATroLVixS2vOKLjCSxpYtmwrFjjwwGjH36TbiwBbkoi9yP
P0i05jDbZgetewhWNSR5zm0EukKR+1SNKSWxZ99RzU7gZcNAwoE2Mj5zaiYYwmC+nwRIZ7Td
5/4+KPbZ0x5asSiyTbBRVtT/sgPO7fkiEXSvXKcwGeGgZEkvZs5tM06qyZzI6vD19fCy3T9W
Afuj2gNOIuC+KCIlQMI9LPIOawyuf/DGCf7DYSxwmtaj1IjYr90qKcKhsccEBtFlaPIj/c1K
SDjRgSsm/NEutofzyxeshZzTYujiEFmVOdxWkXqHtcUwwARs4VwGtSziGGI4SWBEs5kEnId3
zDQl0ojclUWGNp6TBGxe5BUGhBTzZHB5ukNyM0m9/lohK6h5qQopRQ7uk0g4JDB3xI2YIeLi
AiUg0LZCYkCkdFUDvqYHG5jRFfi4MaNFXcs7BmGbhwGXjoc5eEY4GMcNmmvXTbUwaQX7pixh
JSKOFdO3s79ms09Ouq7t3VEtudAYZNR5BnU7b8CfgaeB/vG9qgO09lh8qNdMypxYnoGD5TCz
FEL3T+f4ZIOouz8MMKfZIsEkS7r+mNpaY1qzUJGLi5k/aWME5M3lZjPNj8H7hjmPFv7w1shE
Yn2GayZwZgbqks4/nJsC0TcXk7u3oS3ujqo/dmBIToeqCl73z7ATTYz8ejhVf70nvzZ/pMH2
+OPlpToddo/By9vzaff98PpYHY8QAwbfn7cntEmWjVOCljzdfASYn1p5w47s3NSGWCQ+WI7c
dXx9Met7Wdc2UnJde8Ghxur0cm45LtLS4g/zGydQsDjXNz4c0gt8/HDt7fLj9Y2Pvvz44XIw
LRY70zK0BDzKp81mpIGpVPORn5H1jr8e2pvS2mtZlLUaWwS9LNJQZMm9hww3XuI1dFmX8z+G
nZAwxywNXESXLg0jYQtCB/1T2AEGTaSPPJokEMqsSE267GY2XGXcR4LW1TUrcOAqdBSik88i
TvypFxTh9RyaNMekWDQpZg8HoUTEaZc0sU81LZOLZr11/Htl8yC2QxCD4XHM8mFb29z2S7Ku
D8RG2FoSiEIs7AC/DLTymGHDQwTv4eUMzeSaUXCMqtSidHrF6aaysCGIbajNYYVvmOH7/h2M
hB2v22QbIo1P1HjnSR9idiSD+FsCfu2oy4cy5hvw9jMrI/lQTtlLYM3PsK4mWZfTra5cljMJ
y1AtH24vrOUY1Z03DxkWkq/JZC0gFM4bJU/L34pUXlxY58FIaAUI/SuBjLNyDT7chrd3fpRp
5O8IYELjnklSLgsIq5JwcOwiKhA6JXZbk/RGX1o+iIwJQFz57Y1lxRlF4OiLoEBbMVFqwYCG
MsyHeuBupzK1vr1C16/f8W3SUiJ0BsIKNIkmCwdat5F/fXHAQueFnQh5MNFyLtL6bRP0cMwJ
lbIZuEtESrig0GukQ9eCp2YKSG/AtM+OpJF5lHz3rm+54bLRDr99yokC4FB4dxlzIOUDxlZR
lNsb6exZmwAP5Ouf1SFIt/vtt+oFoojO8QMvPlT/fav2jz+C4+P22cmHo/UD2P3ZteNIKRdi
DcvWOVqpCXaXS3VMrmFjvnrC2hp+m6bGbqbyFl5ZcQeRD5nAWt4mmHgwya5/3kSAHsB8/BGD
twXwYJi1CYTPrXu8Xq9Eu8rbF8+4k4vyCbZLmTzCft63L73OfB3qTPB02P3hxL0gVm+Dqx4N
DawN0RFbu5ZIUclbIRjO4gBi9PZYt0rtVvZ7hke5uzXwp2cnADGwIRqCBauvuoFNGV0r01/8
/Lo9GaT8utufggoAdFtfYfjkFDxX2yNc033VcwFnA+lLBeM+V4+n6sl2sZNd1iDKTOOlm4Zl
M3uDXSi0X/4g1xdzu7Hqi+NTms4wmaZ42CTYmqlOTqbem93h5c/toQqiob50JwmBpxZUJEMj
WzNR9ZuXWm/A0yiR1cmIZXVh+Tuep3ckZ4i46ii8G3whBIaPrYT/uQ/0M1L+jDTyFC1GCF9X
3w7b4Gu7I/UNsk99QqBTiuFeuvtF83upxWjUNmexPTz+vjuBpoG/ff9UfYdOXdWxkYeo8yBD
+IquGOtVwJuDy7wjw7oUJ23aQxiT01gK4akpUKk0l7B5bR8LGCZmS9HxFHIwIcwagvHUPL5v
k/ZjgRVjcpjr75gN6Bb5vXfmZlYNpCjvllwz903QSF3OQwhWAeeWetBJzhaqBHNb53YQC5nX
XTncJsxs+tKX2N5HNw8udZ8IGHwQEF9p6nKFthzJs74G1oGuJ9qOtI2E6R8vlgkhnIcGs3MO
2zz3O3G/w54qhIG/EZUZFVk5tRaGPfECP5DyvL0PJADyNguWjPLYfk+u0bAyuo3J/ZwlHjUx
HJOuxGDL7ZxtMFUx0N9mdfK+1SFtp9tpArsFQR1dgYWJLIbAWjC+aAzu5YhBBsU3TTa31kDc
A8/cTSYP4GNkV4thQtFOIHfFJQsq1u+/bI/VU/CfGqR/P7x+3TVAsTeSIOZBs8OxjVhjTJpX
gz6bemYkZxuxoFAmxYK7r44W+Wy29m8sXxcvgyHAhxo7CWpeNBRm6/sAtVGYoQY1EVQiiJP+
aphFhgx/flpEzQ1VU3zsQeW0KyCceB5rJbn/fbxho8rkYIbOydTp8pQrTKX278Pg2kz6wnPi
RQYXCFT0Pg1FMtocVRd5JOADbBseNkUC3c8VOE7F4Q5+LphtZtsn21AtvMSEh2M6B9OyyLn2
Pv02rFKb1KNTQ4ACGAT7j8tUGdTRXW1f/a8OKHYX+l9B6kHwRSj2n4LZCNhNIYn/pFGgLnst
WWYcP+jFOKW4PZx2BmtiTseBhzBzzbVRpmiNoYfvXTFVkVC9aL+NLOYOuQeDgxHtfU8/G3Nu
3irrWkfRl35YAATkuKhf/iMwnCaMtuIei726D72VEi0/jJ34wB2vM1Uqs9Iw+EJktlUBZDC3
1lZQN4dHNHgDWgJK9BhdcIelgAubECnxDmHcjr7f3KN2B9hf1ePbafvluTKV3IF5+js5BxXy
LE618T9xJDn1VQPUIormXA6hCU6l4ccA7a2b8DdELH9eSyyElqZEGr25XxA804jx4O1XLQFO
R/4xwdbQPurAl98G2HTHN7VZZrfS6uX18MMKzcbAFocFpGeFADj7TEQmBnCf4szeIW40b9Ku
EiiZgK+V2nhQwCbq9sb85yQ9c4Y64gARk2kvmwdIsIcc4q0N4sHbi04EK88A4BnIs3KermjC
4Jpi4tmjAQ9S2KHPQ1g4PujhMoZD8rRrQTYjeXIP18akjK0NysHwNxlkuz+YIU5wqghxUcgy
BLO0TEnzyNyc4PQh9Rug27uRVac/Xw//wSDYE97CLVoxX0oJLvDGuc4Yizk7aWgRJ34nCTDN
S9/EEGIVU9Yey5pWzFfIyusl9cGhrOtfKJkoCwSB1iSXuQBA4rVwspSZXU1tfpfRksrBYEjG
NOdEqFoL5CT383FdXPJzzEWOL8tpsfFMs5YodZHVKXGrkCeDOy5WnPl3u2641nySG4viHK8f
1j8AHktJltM8NhXc11ObSIYbbrdcm4gKNyBpKluy230RyWkFNRI5ufsbCeTCuUDkKu79ig6j
w5+LcwCgk6FFaMdMbaqz5d++e3z7snt85/aeRlcDKNpp3fraVdP1daPrWEMcT6gqCNWVawqu
TxlNwGlc/fW5o70+e7bXnsN155ByeT3NHeiszVJcj1YNtPI69+29YWcRuEXjo/S9ZKPWtaad
mSpaGonZFXyLnLgJRtDs/jRfscV1mdz93XhGDMw+nRbJZXK+o1SC7kxdbfysC5MW6FnOykDM
a8Jh8FGpHJXz9MJ14sOPseUZJpiXiE7Mk2NJ8ITBhWDffxtB6/zlHjr10pP5xAjjyhRqhdLG
NChia1JD8na2TkhWfprNLz572RGjGfO7sSSh/tJYokniP7vN/MrfFZH+ojO5FFPDX0P8Kifq
BThjDNd09WFKK+rCY/+Sqa9OLsoU1i8L/MbPDlZCOD5iYixvZ0ICvlZ3XFO/uVor/PZHT/pI
iFRW034glRPOry7C9g+5VNMIp54phMeTEsklfjuGdnxK6nOupwfIIPj3P7LVdesoI3Pur5a2
ZGhClOI+q2qc56YMC3VfujW44WcHoWDJ6m/uB3w2LA1O1fE0SImZ2a306AuhBv2OWg4YNtK1
zoOkOYmmljyh4RN5BxLD2vMpQxOXK+p7GLrjOUswTHG+jVjgDboYbU/H2FfV0zE4veILV7XH
qO0JI7YAnIMRsOL9hoLxBMarS1OFUBe19CPecaD6TWq84t66YjyPGwsk17/7JIRzcDfNVxET
+8z9oIQyuSynvgDNYv9OSwU+aaJIyaDL2M/zuc3W/ihdVyVZDyi5gOnVRd5dFzHhCWYlPF0w
vdQQRbZmZZjjbu7DrVtZ6H3VI2loJZolpcR+eZE0pZz0oX792+RNS8q7NLSk7x+3h6fgy2H3
9M3krvrXrN1jM3AgRsUidUp7yRJpv2c4ZAge9dL5jHitUxk7NSU1pUzdrw1BQ7OIJML+2hwA
q+m7e1A0H3S3y+je7J5ft0/mta89iTuzZHuSHcmkECKsIrNSbhudk24Qa/Z9K/Mo1K28P3Of
AGhCkuD7g1fT+ib+ZPHwQbJZXGcx8P0Js6hOGqfVEJNatrkT0ALzo1HO/drasNk6dz9aqun4
cX7TFsvghLcIQ6blZ6HKVYEf/Gsn3WzaE/MNQtNL/dF1p7R1o5bHBs270mt8uCq0GHyxjTWv
4IB6Qs4WTt6l/l3yOR3RVMJTbPsyoKcpF+MO7O+UsTaxScDV5YnOtgEzZhAF1m+1088p46vX
VQo+GZPgJi9zmiodlguuQjANPuSEj+V3zP7oe802RuXaD5zs3O+S4855p2dPwTLQAizmxAPk
IlPWRuIvCC1yTpIBMcUvH30MxfPYzynCTc/op699kCTS1jGbQrceH8aYrdIT/9YEcDGFiS8r
dgdNNs/LWonwN4cQ3Wck5c4E2lS1Q3NUCX5ndhUY/E4jW/9EbP4lgHwNyuakXGsGwmSHVifK
h98mpPhBQ/Pobd6y3S8fWsLLgADCPhrYztjx+hZLFeareb+37sVqV+UzJY0M2Xz69PHm2j7z
lnUx/+T7kq9lZ8LMe/hQ5XuayookwR9Ts+WRHz607RMhJiLHRiDKw+mnLzODv+HnxB+z0ghr
LQEi02jt7wGCQ6MMiEb8EZEBb5PL72bgzrBG7uuUBaorZ24BF1AHH/QZUp06QaDg0pd3zvfi
hhYTCLqpGlLpgKBJvmCWvlpEcyh+TkxtdXI5k0dpi43SKW3YYe9H/YiyOz5aZrw9k+hqfrUp
Iymc9JVFRk/lM2xFmt4P/nkNqm4u5+rD7KJfLLidRKgCkBNaDD74CpnISN1AfECmErkqmd/M
Zpc+12JY85m9f4plypTDA+/qylfm3UqEy4uPH5234ZZjpnQz8yW8lym9vrya2yNG6uL609w3
kFOPj78A5DHni8QNfooGniSK2UQosZYk477Np/PGWtYPjQwwSOoU87e7bzhw8eb+bEjDr78G
OScB4dn1p4/+DE4jcnNJN74Pghs2j3T56WYpmdpY2lHzGLuYzT44z4HukpoKu7+2x4Dvj6fD
24v5ePL4O+DTp+B02O6PKBc87/ZV8ASKvvuOf9pboXk5fJPpCvP+3/2O1Sbh6nLiphDMMxIM
L2TSlt3y/al6DsA3B/8THKpn8899HYfWay1k6cDBtTEj/ZP3mU6s46FL4V23YxCceBCcjHWr
o+5FW2KlK9a0Qmz4+mg2yxSu/rp7qvB//0fZk2y5jeu6f19Ry+5zbm40WJa8uAuZkm2lNJUo
26psfKor1Z06XUnlJNXvdv/9A0gNJAXKeYsMBkASpDgAIAD++/uPN2EH+Pz08u3989ffX29e
v97gkSW8HZVtZ3TVSGBjgHNBa+6yT9Q1JiF4etB7xIiuKeO80hLjmvVOQSyfeEABlVNaBraN
qTwuWWVknEIMJuQwnEDkx4cBefz8/A0Aw/d6/9tff/z+/LchYPfto3c1OpHPKkJ3mv4LzmeP
8LUpKkU5b+IsEW7+ypRCKmWfwjLSk2ya4QizdUVw0Dd98/bPt6ebX2CZ/Pmvm7eHb0//umHJ
O1jGv86/O08Ud4BDI2Et9Xk4mS1jKKIpECOUURk9RD/G42jWQ/g/GgAs5lhBklf7PR15L9Cc
oTEY9cphvYjRaYddRPfgFiXqTH4Pe5s7do0iE3/PiLR2MJee+O7/zOB5toV/CATmXeuT5xlc
NzXF0xBnZvT5f/QRPA9pypQzHjGGHKPhRCCPyA6hHfaIOu74gVF6l5y1dazPdFBIi1kd2ces
vqR17dIXfxMNR9sGs1i45dIxjYwqsjdNms0PY2JXQGTVB3OZHi5NEjOjgwA9AKfnOTgtCNo4
P8bquUvtKOM51qqjicI8ThFFrQMISPfbCn1tm0Z1KkaU8KBU+oCwWkyvPmr569v31xf03rr5
7/PbZxiEr+/4bnfzFY6Y/326ecYUCb8/PCrBs6KK+MCycYdUIhsQnBWdAWHpKTZAd1WTqfEp
UCc0Oy5h4ODRZO3xrx9vr19uRLIfhS1N0dkWRi4geYJm1TuM1TbrVaMqcVwGM6qi+iHYdhAM
1pvfH15efnt4/PPm/c3L0x8Pj//MI3kKzXlo2GULywk480ma65PUrUKvnOiaV8tAChzcrSa5
DKDoP2xR0BFdc9vNEapIaOfsG7ToEGJ/mREMylTayqRLRh4jMz3JtioT21Wz0IVIDF6v7I9x
Qw9vencU2Srsd2ZtatG2i5jh9a3litqKOnU2DJo1LZF227hJjwmti+4tF9XAH7eoNdAvPGwr
yyVJe6QZBPjlJL5MU3E4t+jSpyu2BduVcpkXFd1u3JjX4PKO5Bn0heff/kKhm8Ou8Pj5JlZc
0ZWFN26uP1tEubRBF/xWn5intEyq5uKzSnN8629afBaEtK43EURUvgSl6jiPWZO1oDjopn2h
xrScTDOplC7ij5oRRUUlBMtlwYxJSZSElVK2WUxX2zAafoRDSJNlJeRSbqOIjAJXCm+bKk6M
Md6u6KHdsgKXjyUrzj1vU+FZv9wgi5PUiIqFRURZ1bVCp+xYkL1nWdMc9XtdHm3+vtJtJhxb
tUHbp0VWZuNspHfAYuNYQu6T0rbvDm2mH/vssdPGKCCXssYEMGUMHOAlnDnE85p2cRMnwtQ8
3Xa1MIq2/AK7dj/HEtU2aYr5rZTDbKfbcnYc5Lc7YSinGwJ8h23ZSfZZXAL/Vzg5fshafiRW
0a44fXAjm59mX1wGP5LT5ZDxLM+YHuJ9yLrgkHiXvc3rC0vBWNjRtbOymnsPJUffJPryHZHX
P/jhGJ/TjOxQFnlB19GoslVdOBVMETcgimv6SXEyPxlRDMrEZaUlgynyjp+FGEEfkHm3O1+p
NWONrivd8igKXChr84hQSlZ6SmYTy9OCHrcybu24tG2qsiroKVRmmt9FBjM+/f+t38jfOMTc
jjvbvtPfySwdeLXViw3mZUUZ7BSG6rTkGBhI9helN0yLoHJ8x+IQdsILyHx0o3cMDZ62BdMU
V8eogWHUNHYVhx5lDYniccGPegZk3u23qbk6iZKpGr6qIqo8bnbwh54OvODaHskLtnFpL5/+
UwkKtqFdCwXSUh6bMpEUvyyrSkwTQrLbinWhcdwWuGVfH6H7sqrhnNcu3c/s0uXmxjkve8q0
wxZ+AgaUpKylAg6UgufsoxF9ICGXc2A77kYC/9qJJ+8miNuKuMvss7enyXPQW652vMsaWoRF
hFdTxizciGcpcgVwq0s6Egaq47HMbMxKmqzdxhatbqj4Uhw7kcboOhU6aoDC9xOEve92Z9H9
BPGVw1XQZPXdynE3iwSRs6blVkEASwekkiyz6JlI0tWMTK96uNdCM/m5Fhn85XVjlt3Az8GY
pKpDw94N+jTWQW/sRWLH9cqAnUCeClsrAUyNsOu6JXwULuF75WCpgmDlrpzFFlZR5FoJWAYK
gb2LvZxuxSegGCwxmNSRH3neIr5lkWtnUNSwipbx6/AKfmPiB4EZs4Rd5HyaDBuszo/cWqMQ
6y7dOb63kuR4B9C6jusyO03XWnG9fHgV7zp7O40Q6xbRQnb7CYrW/nlGIc9KUYpkMLGdk7KD
Fj7EcK7aV0LcRo5vR98tctCkaFS4XcALUceOB3FncaRQLrAj29R1Otp8haYOOKsyZm/8lLUp
x1SWFnx/GO5hI/Qa/JuWfHJL/F1dWzKiGwXEjnp4/fH27sfzp6ebI9+O93FI9fT0qffNRszg
pR5/evj29vR9fml4zuNSFymke/jlnFAnAJKP1pakgG85nQYartVNSe3BelWiFytUPU1FKeYZ
AssyzioaZeh+JqoBLVjTgCu8t7/C56Q1Usg0yWLryDSx7o+t4eTysCDVe1sVoV7JqPDWQv/x
PlG1CRUlztm01M1BvZTWxPdsfh+cimCAm/Mz+vP/Mo99+BWDBtB/4O3zQEVIBmeLjVra6rlF
VBHBoYQL/HQ+8IQ0M540KRR+XmrDBa332fj215v1uj0r66My8uLnJU8T7c5SQvENprTIbVk6
JBHGr9jCbCSFfK/otoht8Y5IVMRtk3UmkejP8cfT9xd8GGa8w9I+Ql++wswfi3x8qO6XCdLT
NbwtNEPi47oQab4sX8QWrSAL36b320rGKExmlB4Ge1YdBB6tLOlEUfQzRJRhfSJpb7c0G3cg
kVhymWo04VUaz11foUn6sLJmHdHuXCNlfntrcQUdSaxakUYh5rIl4m4kbFm8Xlmu4FWiaOVe
+RRyyl/pWxH5Hv0Ck0bjX6GBDSz0A1r9mogYvdAngrpxPXeZhpcnkEXOjZGIYE6YFVf6Xqbn
1nLXNdJg7CKaLq8wXoOUGXWWXOYT69L0dIWorc4xiO5XqI7l1UlZwWZH67vKPPJhsV5huy28
S1sd2eHqkHftVaZQGL9YLkQnorhGYXuZaMvo42+aTe2t+DDEXqTs6YoBpRIZ2blHgC5xXnMK
vr1PKHBe7TP4t64pJL8v47rVfKkJJAjtWvzMRMLuaz10YUKJDHPipSHNDDTi0xwlGUsgrsJE
itJhZrG3TK2JWUE+ADkR7fBV0P4Sdd5QYVqsBEpGlSy0Htd1normF4jQ+LCx3AJLCnYf17Q3
pcTjcJnerAbJicO6j5cqsZvMZF/HD77c0ESHGsyiGIKpI+jQAUkiEiVYvEQkAY4sB/Xc9g6g
XD+gXdD6aJGtZjc+UkF7+P5JBNNl76ubwRlw0OgwOkWxouFP/FsPiJFgEPlQiPiiQzEm81a9
spHgPNvKVT0pjwLexGeS/b4yec9vvGKgc8E9NGDqrveibMMWC8a14MhgX8oIKvwox2QKu4qL
tB+OscUBdik5SF5EkyNBrrmWU59i8qgmRHwpFH9++P7wiDrzLISibTUj1cmWuGgTXer2Xn2P
T7jdW4H9a5heoDw6mIuUIRh2aGYclN5qT9+fH17mTl9yX5GxY6wq9YkCiMgLHHOe9GA1BXsl
MtGRbqZKAXcdBE58OcUA0jLYq0Q7VLZvaRyT3kE2hkhbtEpQNuL6jf9nRWEbzCFapEskadeK
7PA0e0VcYnqBxta1mNeY6euEDehTfaAQkZp97IxlzDGxKlJYF+rYHU66jKpDzXNrO9QNtDYS
Bd3HpvWiqKNxw8MoZter3eSnOaQBe/36DstA82LiCrPV3JNdlsddDmpwXGdW9YhyZyxNKGVe
0ctCZpVOi6z3azWHzCZZ92j83nnWku/tSQrdH1IBWlnj2U4ma9fBd6m59yItY2VHmapGvLvO
OF5rCD7MOke0HaMHLfdYkDbWfjefCz3c2rX+nPnQxntypfR4gbOURRyqYHIxmktZJdrGxwSf
yfqP64K+7yxQ2tjtzbk1Hzgyh18nGOqxfw7xptCF7nrDKBhubLKrroFE96K8JusSqKzc5WlH
DqWBt/af4c25CP3P9hmD46chxmBORI3DbOJiOD6lrgz4WjffKOCfqx4GWicYvN3149JotmBt
k8v3a+aNlzJcJLG59paXPbeYKTHCt21plbJ/EdiWGbB/P07P4HEa8hgYMDZfqyKhrhpRBnzM
XsmcYP2b8uPzawKq50DK64WZXtcY5TyFr0kX3GGGjfAMtNXxiXQdigfGJZEBYpMULjAYGilz
XFOKLpJITwFp1t9hYla9bp6ZANhtDdA5xpxIlRZmJJtHg2S129Ftb+dtT9/m3Ocan5oaQfJN
tKzCsHoCO0aQzDDy3TQCwWASl/sh7LAPMXm0C7MYviQshHqwHGZ5wVxXK4f0HJnQK/VwZo23
6vShGy6UyPVoZW+qAcYVBodgARC3MhvBpI5hHkVbjpGWwZ9aEW8EIOPG4dhDZwA8Cvv7KRIF
O2pWpqqorWLL46lqTeQJ2MFAu+5eHbKhGG99/2PtrSxBpnD65Pfa0h4gmHVCfUdlPrjjcMkp
2BxhQ8aYqzGFjTS2Q7vzWw9VIMCeCRMUdF5/s9Zj9seUBFK8AnrSpgqA6byjiOnz3KAipLfP
9QQq4ivl+2qbtXNgzeIxHhc6NyqG+stoU+flC2q/YSoSeWLc/PLl9cfbyz83T19+e/qEF63v
e6p3INhiiOev2o0K9hS/iGkZUfBJis8Fi1RD+kQ0kDyP1TQbBlaJh9JaFzKHpeW0SE+eXqM4
+4wqhLIuE4Rm5YdZ9hWN1hCYdQwcHXL2aEVu06LOLbk/AQ26hWex8OCyqoo4yW4tbVbCoK33
EKYAETyGmObW78y+86xoU9Kuikj5GKVeS//QpN5o71z3ZUgTDovxK4ghgHoP0xem10N/PT/T
4wXLZmYUBLYxmpdPo2JVvX2G8lONyqSdzUhpmSbSjSpEO3FYTnYS23LR+37cGqPRT1p9UHOR
gkwG/Nu+rMz8ZHWmnkhwXV8hseUYUje4kWtf2d8YJoIESJ8FUff2VBC0MEpGp/O60JymD5yi
qmvNVgw/F9LZlW2NFDPbEMIeX55lgoN5qgisFE5+9NO+FVKIxStlpBKmKJrZgWSexGfC9XvL
yNof4j2Pt9fvs723bmtg/PXxT5Jt6K0bRBE+usLmd/a9P4L0VLzBy25rDlnFMeHh0yfxzgEs
StHwj3+rYVxzfsbuZSXqDNOMGXKF9YiLSGKpPsOclXDGkfToJbo7luJFGL0E/o9uQiIUWUm8
Sy7bpj9nz1fM/dCjDoaRoKs9Z6MFpPaY3tqzULZgtedzJ9KFBROrTfAeJ596XuScd25AJmsZ
Cdpi11GV49VtuPYocXYgqeMcVjTV64qleUVJMwMBhh7P+jp7PllBRAW9+2kklPuKRlCTjUbF
3RxuPMysjJf61LEG7h9hJlHaI8sGam0rpT+1PH0ZEDvVJJI9nPFVmEfBvIBAbJTO9K9j4CNN
IMyCUCukFuUmDn9rvss9ACQb3mJiqEueFSAzBq43UFS7wRZgFMmaOzN+Ta48i5gneJHpDLS6
hqVsQIWLgTOKC/0zC18evn0DeVM0MRMTRLlw1XVG5kABl8Yu5W4FgVPwoQpNznG9Vae/FP5a
/MdxqZWj9oMQrCS6MeVK+XXyM/mKBeLwWpmd2KyMffORQ7eN1jzszAGthc+CCe00WVTeSeXO
mnbLkN8wLuIg8WAaVlvquXtJJC24/xjAqjNGBSYEU59mFEBjjQrYmSUbX1erBVxKlTY2Pqan
+UwoksuuD/LVH/GgZteoBwno09/f4DSdz7reWWo2lD3ceqXRE5WWKHMxb86Xmn7oZFomjjGA
AurNBwvk/k3g0+b8nmAXBeECQVtnzItcxypKGsMkF+8umQ8fMVAWlzRJ0GQfq5K+eBcE2yR0
I492kpLLOt44AR1kdWhBEVzat6R+ZoxyXkehb05oBAbrYLabJfPdZziKiZ0vXAcmuD+VzRnW
sKANItpfS36xudOP/kH5OvDcaDZXBCJaL84FoNi4lAAl8XdwBq/nFZ/ztbOybqPnItpsVqra
RUwfffHt9026j/FBH2OAQTZWn2Y7u4Oi6L7773OvwxUPP960BX12x3zv3FtFnlp+wMhtkyjg
ngsK0W/9MzjfZ+o+RLClsstfHrR0YlCPVCMxRl2zeowYTpsNRzx20Qk0lhVERNYpUeinnZjZ
lilS11cnrV4L7fio0Vj8FVWayKF9OrV6fGrG6RSulVGLQ6ROQ3ljqBQgsdMDHUaODWFlKUod
2tVJJ3JDcqfWJ9QoWIpXheOTIqGJuF1W609lCTJMhkuqAgKLD8rl9/NSEr6gx2tkIjEpTYZB
YqZ39CAGo0EZcdOKgz012njBCJ7szJgVe1bRiN7GLSzT+0sU1UW0dujNEM24exw4OMMMycmo
hp09x1VW2wDHT712aHikHO4aXJsaGobakQcCvlWfbO05l8BZZds7L7S5uY4Nzk5VgwCG3g3x
gmTWux6jZRbVcJ4l7nlgW3xVMk3qQIGnsReqSfckXN+Pp/owaF+bH2NFrb8OaKF4IJHeKyIu
pnNX64De2xTexSm/wLwk2fjz7wUfZuUGHcWoQG2WqkUKLwjVD66iQp/eTBUakCeWGuDF1l+F
FHO9sBEuTJd9fNynMNzM26zc+cxv2sDxfarupt2sgmCBrSPjruN4xGgmm80mUEzYRj5k8fNy
yjQbhgT2BtoDEZxWygRuhPl5zLmbhCuXSqCtEUTqdfYAL1zHc22IQPWGUBGaLKajaF9+jcan
p79K44bhNZqNt6Kl/ImmhV7/DM01foBmbUmqoNKE1FzWKagR5X7oUGAGIj31abrssotL8Th4
U+VESfTCYrpdXMfRpvSxYXS/I6ptu5pgR1wQY4KmeYmEazrJBHaxY3NycQDAQLF5mR2oZE6w
mxdCROTt9hQm8MOAU6NQMNcPIx+bWhiIXQuS9bGN4WSf177PAzfiBbUOAOU5nBKWRwo4o2OK
MUDQzr89Wt4dlnN2Dtlh7frENMq2Raw6QyjwOu0o9rM2orbVAf2Brbz59wHBp3E9j8wIji8G
x3ubi1FPI7ZpatPVKcJ50z3C9K1TkBtiXAABBx8xCxHhCdGKYnLlkWZ+jWIVkHysvDWxGCSC
4APP/rWzJuoSGHdjKbImtnlEbEKygO+GPsEW5iuXi3S+eBDlU5F6GoUujWmoxczygmJDfGfJ
7IZiltU+eYq1bK2exiN9Wu48d1uw/nwm+MyLNSUNTujQJ6ZOEVKfvgipWVuEETnHimj5xMKo
umsEtNylECwt8LygxhigxLIHKDkOm8DzV/S4Amq1fN5KmqW9oGZR6K/JpwsQtfKWhYeyZdLQ
kXH67ZuRkLWwnogeIiKkPjYgQM/yqC+LqI1F1R5papFYZYGlirFLHdGbXcUY1bAwxW4obbLW
I8XGAjQY5TKP6vQWs3Hs0jkCDpkL2+1qTp4zJa+PzSWreW3Jzj0QNn7gWcI7FRprlp6JpubB
yqEGYiTh+ToC2YCa0x6o5GvyvPA2YWRF4HNTxzxuTX/fkciP3OX12p8ES/K93Pkd+hjxnJCS
DCSGOgLlThsRsipiVqsVfWBE64jc0uouhfNqac8HbW4F6rs3bxAwgb8OicPuyBJMmTnnBBGe
Q3S4S+oUZJR5iY85sEcUqM+FkLZmBfihdYnRATAl1wLY/5saGECwpdmYFCmczsThkYIAu3J8
qk5AeS5pyVAo1mg9IrpVcLYKC6oLPYY6AyRu61NnNmeHYC1iGIqiogYS8Z6toL8mEG3LcdIS
bBRrSloCGd/1oiRyybkZJzw07npMChiuiBIusjJGlw4SrgeBjHDfo6WUcEVADwUzg8p6TFGD
nr24ZQiSZTFBkCx1HAjkS0RU0ZW3NHGBIHCJY3N4vI7AtK7nEmNzjvww9PcUF4iKXPLtAoVi
4xKqrEB4ia3WzdLyEQSBtWiAO4bVX0ghzWGDtT2WoVGt6RczJhpYQIcdOXSASQ+K0iyEnliL
ZutB+LpOK56Op4IDB6K0SJt9WmJ4Ze++f0nSPL6/FFx9jXYgtxvdB4qKzl07oM9NJkKOL22T
kQkNB8IklR61+wqfQUnryznjKdVNlXAXZ40MJVxkQi0i3gjltfEIpFFAr3v6MCp+kUkkwKyK
F2tqRZWS5mmyaqJf31CA4DpJT7smvVuaG2mBAkxWUd5TA41wlJmcVYtOqXACRkUxwtWnH/v7
a4pNGZfbFs+P31+fXp4e376/fn3+P8aupDluXEn/lTq91y9mXjT35dAHFMmqosXNJKtE+VKh
kcttxWjpkOWJ9vz6yQQ3LInSHGRL+SWxJoAEkJl4+IF2hm/PpK9uT9VlpXJLkR3drgJXmZVa
ZKDZ7enj0syFWfxffqkU7YGEBajqW3ZXH6krsYVn9PYZX3bJKhwjKZEFRiHhRpqQ2h+WBs82
VLyJb+/fH75/ff1z07xd3h+fL68/3zf7V6jMy6t0pz1/DBP5lDJKIZG5zADTktTlJrZKebTv
A/YGvZiE+3CCTRy/I7taYy0A0ioP9a5fEqUGz3hkKfTyasIGUOCSH8tWDFeSXw8qdDma3CUp
B6sved7ive2VlPk5cBNZPpnAZM12vfC7/jbtLdu62j63RMnbyu8DOxJzXucB7vJKtecyR1zJ
DmYY6IxU8i5Fm9Fj0SCZrAYIyvFampOJHFEPboFJ0jF6jE3UbzT+4SV8Fvr4zBx7KvacRLeF
Jbbr8q3kSdoJ/gCchft78YemBO5VeiUWSokAhumZZtk0c5uUjCgAkhWm8ZWrOlHI3a5gnRSz
kJPnzDAqdEJa40psepn4Ndk8gMufT++P336+PKCtuR4od27gXarNtUhjSR/Fnm+IwIIMnRva
lJo7g+KGFbt8tj1by8w5We9EoaU4r3ME3d/O6DksBWJcoUORpMLshgCPTWMN0sk9p6exH9rl
7clUXjRAH+S0Rho/S5Los0fL+MSuACzGZ1LWI9UchQZTRANjwzHHgrvUkd+CinbLC1GOdr+S
6d3R2G95Qm+MeA/irO2S5vAz6jtyOaYlQHHFWhBznfkCQV0mLKCrtjRQbUOcO4T3rM/QN6M7
70nPEt5Zie1KxrsCUT5V5EDjBE6sFuOQB7D/M8XIQhPIhjezcA8ONEgcLR+VRso/d4FDNTiC
qrEk0rgBjaWMsZHoE8TAGtQsuVWFH1Jn4BOsGFOuVF+Tt5EeUQ+3rnDskp9FHi2JE0MUW1fK
iFZIWhGjOA6JrIBM7fQ52gduoNYVaOJ1EafNqojMiqunmmGT7HwQXrpux2Rre5aluaKJ35fc
vFzKfrLWkPMeDVbV7NubiDzX4NioeqifdFlyrUBd7oXBQEzgXemL52gLSQt6wJGbuwjkzjw1
4UEaCbLt4BNNJn/cl+QLqxwbTeOV8vT5mZWu68NOrUuUm3CJsWjc2KOOREYwCqNIbgNIuSiP
Mk03OkYTHtvyacMsbt9Du0iMUKgN65Ee0cZSKwNpcLTAjh3qdVGsswWyZJ8tJBIp3JMFNFnk
mKylADtEFkCllhzAYG402Nf0t4VnucahN1lTE2J+W9hO6JJKVFG6vmuSjclgXCm+5FHDKWER
BMNWq0sSuFE4UA94zXDsDlslLc1SnJeyTg4V25OPQ3GlYHQJUFSwkTipR7qSYXgSnDdY6Ssn
tApoa+sIN1anry0XmHZJmGDP8GbJBLv2cFVDQxbfMgRHWErgKbNyfShHd4lBk+0ZA+XIOBsv
nzvKDDJurYqGO9JSEAc6FeH7LrmIs/uiWJPFAUggzkfTOFm2mbQb5nvpriHm39mt4No+ZNn1
UteAC9EYzn3lGF90ONVFz/ZCXIOVAaObHMcgQt1RareVBw8L+VnhyvVMFQd0p73iskHxTJoY
nQAqX5QCszLhFiwKfKoyLPXdOKLTZhX8R50SCSzjpouunO6tSzHxzdEHTPNu7GpZNAlXIFHX
EQRC2WvISOAavnFsQ4dwjF4YBBljle/6hk3LymZwcFoZ8q6IXYvsWLxid0KbURisJoE7UHVG
HSS0yW8QceiO5kbb1ztHXdxlxPfpwowrvzHPiJrxBJZxYSQzBSgIAypX3LaAEkH3LuWMbWQz
bCEltijwKBMvhScwjLBpf/JhArFv6LlpL/NRAopVu4JFTkC18bzblePDyHgYuYaCARjF1Nou
8jQ2NLJDJt74nk33bxNFPikUiMjKo4h9DmPSCV/ggf2cbRvqA5jBMUpm+qAzFv1eR3bHL5kt
7tgF7BRFVmCGIjMU09BtSbUgdz7isUIIcN1H6tCyX9QhUF5IuuZXsGJdsce35a731qjgbOu6
602r88hyarPd9kjfoKq8zS2l+4pciu4kQLBttQJG1RWgCCOUERAa7tiBSy5guINxRvs9EoOh
Qy5vws6PxmxzfvLOTsMiuqEp11WaCbdpZBIn1RhA59CsIlZM8GGdMeNRRTKdYgjuSBnGdOrz
XS5H2+FP6nAU3ePol5VHngkXrysEMj4831NJd8dt2p54eLEuK7JEf/67vHx9vJ915fdff8lv
p0wFZCUeLH9URlAHixr2r6eltL9kBgym2YNiLHEoebUMH+ojslJrlrYfFmiO22DOjTsLkpkt
cQS05pnzOOVpxl9xVDsF/kCHkELU/NPTdpYJ3r6nx6+XV694fPn59/yk0HpTMqZ88gph5Vpp
8umwQMfOzqCzm1yFWXpabmyWFhihcTdT5hV/w6naZ5R5B0++zEoHfs5KfDuO8VsmfCXonMBv
xiR2t1WdjiF/p/al2kGQy4fXl/e316eny5vQSqp0Ls2NrXylF4nEeGrp45+P7/dPm/6kdwX2
G9ofyD0pvWXPWdgAjcwafHfrDzsQofSuYnhnwZu4kz9LM4yO1GU8ONK5qGHbW4g3mMhzLDKh
76YKEUUWR/Ny9TbWbwry9+3x6f3ydvm6uf8BzYNGE/j7++afOw5snsWP/6mIIyxwjjKrrXRC
VDkdxKVuOgpJy7Hj8j2ZXsmKohZuwyCDdTSPt5KdKuRa6BeJfE663Gml6zod7+l95jSIuD8W
JdocxvhXymgdl/w0KXM9W2OUE6zqMtSWmqqFrlMqWvoIotFPMzR6nusI5uFcC5OpEoqd2trX
ZkcxsMpIun95eHx6un/7RVwDj2tF3zMesYV/xH5+fXyFWfbhFWNB/Ofmr7fXh8uPHxhDDUOd
PT/+LSUx1qY/sWMqx9+ZgJSFnhopWeWII4PX4sSR4StOPnUIJzA4FtHIXeOazgCnzutc16LP
EGcG3yX9Lla4cB2miltfnFzHYnniuFsVO6bMdmVXoBEAxSYMzXkh7Mb6Z6fGCbuyIQV4lP26
ujtv+x1sjAZxwv//dTWXijbtFka18zvGAgzPI6Qssa+LrDEJWBTRmVGv2whQh+kr7kXaaEdy
YHl0egCgnndtegGuyKM2tCO+7SOb6AggG/zSFzy4ht90lu1QW8pJmosogNIHoZ4zdEFoG9x6
RY5rcyo/gAnJS615kDe+7Wltzcm+RZBDyyKkvL91Ioty3JjhOLZcLTWkBhTV1nI+NYPr8OlA
kDwU6HtJ3kXtRWij0DyOksHxI8/SdCZS1C8vxtES2mLUBIEsupcI8h9qVRzJPi3f7pU+5His
NS9LYzeKtZmK3USRrXf4oYtGZxKlGZYqC83w+Ayzyv9cni8v7xsMXkw0+7FJA89ybfMqOnJM
x09Slnry6yL2+8jy8Ao8MK3hPcRcAm3+Cn3n0GlzozGF0QA3bTfvP19AW1srNlvDKtC4HD/+
eLjASvxyef35Y/P98vSX8KnawqGrD4LSd8JYkwXlLm5Wd0DJbfJU9YmYlQVzUcaqNblawLVu
KiZrE/2x4kc0Yz///PH++vz4vxfUjnmDEJsG/gXGQW7IgP8iEygLNn9X6JlOBPDIoW+zVa5Q
vOzSshDP1RU0jqLQmH/G/JAMUqNzGRMpe4e+PlGZxNMiDXONmCO67CmY7dqmYuFjoYYlRmQb
EscyBIqT2Xz60E9mwrcBDIUdCkjB766hoXZIM6GJ53WRZWoiNji2eAOni4d8Nibiu8SyaANJ
lcm5moTBCkovCXmlLrBl5ibcJbCemZo3itougE97o6wfWWyRnqPysHZsP6TzyPvYdg3DsIUl
xtR7Q+Fadruj0c+lndrQgp6xfTnHFqrmkXMjNWeJk9mPywbPNnZvry/v8Mmytec33j/eQdG4
f/u6+e3H/TvMsI/vl39tvgmswrau67dWFAu3GxNxcryUtoBdf7Ji62+isRdUVIQmYgA64d8U
1ZaJOFqGNRqsXJEHHu36PzbvlzdYBN/xdRu5SlJB03agYtYhNM+siZOmSqHyacBJSZVVFHkh
Jd8r6s6FBtK/O2OrS+mCGufZpIHRgopn7Tyz3pXHKxK/FNBRLq3Qrzh1Y8jr7B/scdOqdKQT
RbpISGN44dSFh3c5LTymCuNqaEVKhbGvLCsKNGokBeZA4inr7CFWv58GeGprJR+hsRP0XCH9
QS0/zDQ4Jq51mK2UdCSGBFFrcpA90dqAZ9jBGqbwpZ2rVQVjATM167HpuAKxSGa/+c04fMSy
NJFioLFQKX1gqpMTquUaiY5SURQ4VyHCcFXGYhF4GP2OqJKndUw19AG9ik+DxleywyHh+kqv
p/kWm7bc0uREI4dIJqmNRo0tfTKdqkMrKciQJWZxw8HkBppkpQ4sWC1B9exMIX9JbVi/8MC5
TkUhSaa51igeONIiVS7HyshhaQQ6tRVc549wzp/1HWRfvb69f9+w58vb48P9y+83r2+X+5dN
v0ru7wlfDNL+ZCwkyARsDjVRqVvfdkjFaEZtVTa3Sen66qpW7NPeda2BpPoqFZ+u14YTjgPL
NC2zY+Q7SkFG2hlqTdJPXkHmIdd2DHXdpdcnAzmVmPQonyQ7oqcjx+rmTuW5yYviPz4ugihD
CdpbKa3BF17PXdSF+f5DSHDz+vL0a9Kdfm+KQk4VCNSKAFWCaZNcLDgULyc6XZbMF0jzg1Ob
b69vow4g5wXzmxsPd5/UDiqq7cGhTboWmI7aN8GNIfjKApv0FrT18lRJ5UR9DI9k0xDGra6r
SnwX7QttGABx0EYk67eg5Lv0jm6aQYLA/9uI5wPsxP2TEedbCMe8PrBdPFqFCLRD3R47lynj
rEvq3skUzqzIquUON3l9fn592eQgxW/f7h8um9+yyrccx/6XeNWoXYDMs7QVx9oQbuijE+Mu
QL6I0W9deDn3b/d/fUfnaO3Vs1R80wD+4Oc3oHUIF8hITRuYdoblcTMZ4/Eyu6zY4V26nNpN
2U0PnOn03XaGRF/dJUHIskQn8Lqpi3p/d26zHXWrjB/s+K334hsvF28E61PWjjeK9vpm6goX
GePv6HQ8uLZaIHw97gxbufS8y9sSnyUzFATKnGSJnP8+K8/cPXOuq9IMEra8TDAdam5gfqGP
7PDz8b050EACuXXHB74KO/B0ejU0/DgpFq8vNNCXzlmvFWhcx9tSeH9RartDWiTUlSmXNVaA
rOVdU7A7RT5q2Doz6WRUyELkPO0zRYJP0KrSsAKa4MRpKEubsBadpA+pfFe7YMUpNclfn0/e
odJX+BxtmlCvaSDa9UqxgcDHnURsWJUVs1ykjz/+err/tWnuXy5PWkNzVu5Njpe1MBDIY02B
szt25y+WBUOs9Bv/XIHe7MeBWouReVtn50OOpqBOGJu6c2XtT7Zl3x7Lc1UERIV4W1L08TSW
QrIiT9n5JnX93pZm74Vjl+VDXp1vIOdzXjpbJu1ERLY7DOixu4NV3/HS3AmYa6UUa45PYN/g
f3EU2Vr/TkxVVRcwNTZWGH9JqMuElfdTmp+LHvItM8uX9aiF5yav9tOQgOpacZhaHtmEGUux
dEV/A2kdXNsLbukSCpyQ6SEFZZ5UQ5cPqvrE8AMuETZZyrrIy2w4g9jjr9URWr6mc6/bvMMg
2odz3aOPQny9ieouxR/oxN7xo/Dsuz0pKfAv62p8N/d0GmxrZ7leRTdoy7pmm7XtHaxrfX1M
Dl3SZllFl7Zld2kOctuWQWjHBl2L4sarqY+46+SGN8Sng+WHlWU6HBE+qLb1ud2CwKSuRRe4
Y2V3BHHugtQO0o+KsHJn7oGRuiLFG7ifrMEiR53AFUXMOsOfnu9kOzEAHs3NGNldXZbf1GfP
vT3t7L2hzqCFNOfiMwhJa3eD9VE3Tfyd5YanML0lD48Jbs/t7SKT426JU1UP/ZMPMG+H4cdF
QFsIlgye47Ebyl9mZe3bY3E3zcbh+fbzsGdUO53yDlSdekDhix1FkVy4YFw2GTT40DSW7ydO
SGuXysoi5rZt83SfyWrLNNHPiLQ4rbrw9u3x658XRWXhD09qy1xygLbsIU3UZmSTba5WTfMh
kCrtmVZRT4NlBQ2jskROvsz2DOO5Y8y6tBnQ42CfnbeRb53c806bNqvbYlGDDTmhotT0lesF
mhC3LM3OTRcFjqP3yQIaTI+4IpCjdOWRyYdk5Mlji/SnmdEx6qtExLV17jUJ6g95hQ/OJIEL
TWjDsqiWvK+7Q75lk7UGGQCTYAuVbGQ0UlCYnneNp643QO6qwIeuiAL9gya1nc6yfbW8oyEy
jE5WDYFiSWVkDOn312blGI0YfFubDgRIte8RRZjWLCfymR3wXCfN6QdfRc6rWSybt2d9bOsD
U/yYtUmzP6rFK4duR3n9cmEu5Asd3iNpp6zW2TBap6NxPuwOO2oiARUhq3q+dTt/PubtjZIG
vkw4vTM/TTa7t/vny+a/fn77BvuQVH34HTaWSZlirPM1N6Bx8/s7kSRWd97Z8X0eUWVMFH52
eVG0MAetJZyApG7u4HOmAaA177NtkcufdLDVJNNCgEwLATqtpq3R/ALmtB7/PFYla5oM3aYz
KbQ9Fr9us3xfnbMqzRkV9GcummS0u0M75R3oUJCo6DIO9BJm22n72kkA7j+wpD3os2S3fZ8f
XSZe04DvYSOT0DtH3qaDVDqMrjY+iS21mJ2OEVZEYi9Fx5sIsDQnWVEojcUDSBgKsIWN/dB7
vnzMD8jk+kuOY2yvDNUG2N2aGLoOz+npF55Isefttr1/+O+nxz+/v2/+scFWm9wVtOMeVNi5
fT7a8OeJsA4gor9yiW+BFfn+0Bu+WvH5xU/p3Z8ZbG6pNxhWfPKwJZKdw6sQEPckuy3EBzJW
cI7/RENRFJihkISWEDZkBScnZ7JTVy7uVGvRYa4ULmqHJrA0ke8bimL0el1ZFi8sqh+VB02F
hE/QoGFBaa8r0zYNbCs0NFKbDElFhhpbM8lScfH6QK7n77n1GT0V8VVXGNew2tfk4NLOSOcU
uvpYiZFrlT/GAAgyqUlKmdBln7Wxg/SW3ZZ5KqkFSK67Dk8ziZaaUj/P4Rikz2RHE1LMeGEm
l7G6SNFVyJQL7FfPu07N45S127rLOLwz57Gy5VV/Y2QzxVrgSSxv08sNeURnjZZo32NZ3ulk
bN9zdgINg8ZkatkcPcs+H1mrsLMEdmPK3oLXQHfQ4GQsjKFioHHWjdrlsG5gaYwtVfYNoyLK
jVgnHvWOtWtzVpyPduCLRtJrFdX8USJKVjmDIXL/3ATTW37sJK1gfBE6pP/m9qui2eZCE0tw
wIf+QDnB83jYl3zJ/gg8qYHaUu51IDCWaMNkjKholvOaUpV5LfBVhekO5wDqnrZOHpSHwfJ0
fWyvb2FH3R/IbIERhjQJHQ+kXolJr69ljxeNf10e8DoTPyCUI/yCeXiSZCoC1LE90kb3HG0a
w1P0HD1izxjhbVbc5HQoaYSTAx61XYFz+OsKXh+V2EASXLIEhMb8OUxKaX6T3dHzEs+Am+SZ
4Tvu/2vEoXf3dYVHmkaWDK+2aFdwDhcZ6C1m+AsU34jus3Kbt6kZ37XmpPcFbLTqo7lykDM/
IDUz3JmrfcsKJRKMBJ/y7Jaf15qLd9dqka0lhhz99Mxob8Y+sW1r7vP+Nq8OzJzvTVZ1sInp
rxStSMzPjXI8M/dZkVX1id73c7je51fHOmwJ86SEfjXXv4S+aa8Uv2R33H3XyAAbPy745hRy
jFRa72h/bc6BB3ztFdkGfafPr8tf1dPrI2KwfGW0nsEnBlZhNHEYAeaOaLKeFXeVed5sYO5S
tqQyXrCKHwon5jEG+hBsaYxwx/Jr1ZjOz804+qcWeXUlhT5j5ikC0KxA1SEz1wAK0BRXZhFQ
Y8xjHG9eWHdlAu5K0Lw+1XdXs+jzKwMGZqEuuzLe8LBzb26C/tAeu35UPY1MR1zlz01Hm8vz
6TDPy/r/GHuS5rZxpf+KK6c3VTNfrNXyIQcQpCRE3EyQkuwLy7E1iSq2lJLseuP36z80wAVL
Q5lLHHU3VgKNRqOXCyxpy9LEP4aHqMguzsDDfSjO+AsbUqWeqJdV4CUhsZ3tqXW1QeSPzjDB
FJe6CkELagk4hvmAUawTDjVgKw9VPKizJWU16I7iqNFU9eIg4JFgDgCu4pyBZIeLXzyQ7we+
iFmAFxfUZb0kvF7S0KrcEXYBBh23Xe0Bnv/4OO+fxAzGjx+G/U9XY5rlssUtjRhuygRYGZR+
7RtRSZbrzO6bUT7ZcjBq8eJhwtAvdmEQVg9JuIhwpl/e5x5vVyhYZOLb8g0rPew+SdDoh0K4
Khld6ReBFubeJRtv9Nfj6YO/7Z9+Yh+iK12lnMwjyIBeJag/GBfCZR1ACg+jda5gF9tdHs9v
V7Q3CAttg7A02oCMoKkt4JfSuWkqug6mom3o/ZC4oAAdSgqxE5cbMNZKFyYjlD0DYcQxSZPl
NR2XDiakHAx1D0AFTUfXw8ktscF8NB1PHCikuRpZwIAm09Fw5g4D4BNMhSXRMtDptVNKgrEn
7RZr5cHswLfoO1qHvh7Y86ECdTl15ZTcXuiBmZ5cVQ/hfMdupwQYTb/eYCeTPo+XW3YyQc13
e6z9GQA4RaYmn+Hq7xZ7M3M/XSxVq75CcoYm9nQ2UCdSc4ecjnCBSRJ4c9Wr4pvE6WMX0slX
KAiHs2tkQsrRBM1HpVZ4p3A2SzUh7HzFSkogkJY1JWVMJ7eGf4iqq4187jTSxN/zT5M/il+3
eSb/2M11gcbt9lZlOJyiofckmvHRYB6PBrdbp2SDGpovrRZfkmbV3172h5//GfwhD6NiEVw1
l6j3A5ghIjLK1X968e4Pi7MFIBQn9sKDQPXuGk7irVgi/qmEwK3ezynjbfeb0+E19pcG4PBm
bEH5IhkNxp3lOYy8PO2/f7cOL9WkYPoLJzxLQwHvWpA6BEzZcDmAiX9TFpAUU05FQsqsxVYB
pTKnRaWFeJYoJ8pXUVJ4rjUCJAqQExKqw4aQsgL04txZDwIFMfWcgEz8PqXwdqqnY9lIqGG3
K0uLa+c6al5+fe0DWWu97O0kEC0j4pGYra52qsZq21q3au8R4/GN7v4K4TeuZ/ZvqY/9cv2P
4B0WQqZ5+zJsoSxZgKU6Y/CCZ+gsy8F05Qn9n5NCvgDk8P7uoUilOQ6IEIIRcG6lDW/IwCAc
Xg4DSCA315vXMfg1RaPwax+cHpqF+2mDd1csLlRRmqeKggBvq9AG12GORoSQ2XVYVsZ6uAoJ
LOCF24JB9UarEgo6Et7caMTmXRB676x6mc/sfPz77Wr58Wt3+mt99f19J8RH/c7VhVO4TNp2
Sdy675XCu90uJVmoZ/l2NsHcmtm/u6BjNlRl8ZL7hj1E9Sr4Mrwezy6QidNHp9QSFDbECeMU
izNlUjFO3E/c4HIa38i0lXbVgBhiBks6XjMt0sB6OvYePBsMMeqZHktWB88QcDISfXLgJMlj
MQ0sG15fw2A9BDkdjqaX8dORxNvdFEvfChOuI/B4We3nJBSNo9+h+WCaDNzFQrjgWaqvbpWi
zOU2IYfC5UaNBDQ9fDo2JbgWUwrRDhNqNbxp4qUj8KcxnQILo6Xjb9y+CvBw63ypMElGQ1I6
5PN4Mhgic0nAiIVlg2GN3Zs0IsbENRZZqgyWJRter6jTFzrdQtzOzCmT5HSKLePwbjAMkE6m
AldCirXJhY/aEGVONyTCsN6xEINp6PRF4GIS5LTZDi5zEPLHJd6QhGSALSSBSVA9Uo+vsBkD
JffdCKmQT4ZY5qK+Osp65ud8oUBtppq6OLUDEUQKuLv6BvLZeLHAjMYevJpYHAdGVQjmriLS
BF5UnWP42XDiricBnKDAGv2mK/VXiKEXdoLGaS9xWZyfeVcZNhMlvmKLrCqV4KBJyrHV6fY5
+PHn+y/wKDwfX3ZX51+73dMPIzYSTtHX3Bz4tfP4qby3Ds+n4/5Zr7EFWRJDHWSk0DbZgtfz
fEEg96mhL00Zv+c897zkqtuRuBSs6m2cbuE/m4cC24aJlJqyJM/SKC0NIwuFEncHXH0I2NSj
mUxUosQqxR8JJFpaFPnRIUvQCDhSSDSTATXSl2vea+FhEovMUFe0KNxyoMVKw6l+iXVgPd1l
D8xyMLZyMfIB0wUXZOMC1ywoZP4UB6Osy0PQOmMD8ejeW7QVU6zrGmo92GIbUx3l5/p4/rl7
M1wRW+suE9NWsmVxTbYMbHHnulkoi+IQKjdiOy8T0HpCo7w25GkwbGsweuhnbShQNC8ycdX2
rMlFFodzZl6C2kXV54HUGM9SrJWos9jU5WGHtMkhaQSNboGiU2XmgltH31cbIRdbQIzBtbh1
gOns+xSW4jIx526V6qlqWQUISqZFtpuqeJCHly71SRTHBHxj2ulBurWEVEKC82hjj1fSFTjL
VpUW7bklBIslwdEig/k3fMyopF7ycGVJPy2/w3IUeuhuxzOPNNkScapnUTAQuQfBJqOxLd7q
yAnuyGRSDTy3KY1kPPZMgMDdeIS/loSGNLq5nqIDAJxhDqzjpNd/TXPzazTJ1Iz+CPBdVrC7
yx1Jt7lnFCrFxu+myuJbGMma/u4bQwDpObbmFGp54+lik8/ocu1N6HczD9yWNkvamC+VMh6r
rkWm5rxLWI5Wg837csNzlsrntcYMjr4cn35e8eP7CcslLA1g60ybGgURDC2IjJ7wglpDbIDR
PNGzVDTQOKegnnbgcrp7KCmS9U0CHEo+SPYap3mds7K20qU1dUBc7kVuZiEAyxlwToNi0zEe
vR6diu6DERYHmZGUBrzAkyXmeg49SCzqLtC3VUQjGA2vZTFcyQyZJ4iDN7sn3X/aT1vsXo9v
Owj87H7YIgLDCTAv7qcPeq3BdTNQGWC9ADA6c0hLqge/Xs/fsQfhIk/4QvkWLODRAADoqBWh
UifiTRtNdJI0yJ0bVnSOk+KrHp43+9NOc2RSCDGk//CP89vu9So7XNEf+19/gGj/tP97/6S9
ISsZ/vXl+F2A+ZEao2rleQStysFd4dlbzMUqd5PT8fH56fhqleuGSIUgSBNeBnrGArSQrE4w
2s/z0253fnoUt5e740lwZrTmu4pRsW/TheHbVQkYj7ONAdFb/l39shP7/0u2/vFIvqXX6ZDL
Su7eH1/EEO2J6UqheL2dkrXrYrt/2R/+wXukUgeI06PSu4SV6K6I/2oxtfXnMsfHvIjuOvde
9fNqcRSEh6MRzUahhAi7bp1MszSMEpJqN0WdKI8KYDfESNVgEMBdBEzM+3NeR3eZEz2lCeds
3cXoaXseunsd2CSwlkbSl2QuA+sno3Ej6N/AtiWV4WZkpdE/b+IC3uxirDlFXs85EbIdJgQ1
BKalQAMUEuFoJPUgdn0XH397Gs/zb0NgJw1rwWUqo6y7rRbl7PZmhD2VNAQ8mUDiNbvG1q4J
Q1D38gL5Q4p749gFz9ObYZ3kCTVPsdFkJFrFbY4YevEE84AP7Udz4dBr3SSuYZGB1ULLeCU+
oGuGhvdCBouZl4ndtFidmLa6QQ0NR6sGWJeeAwvwQrgBqVDcELCcSUAhDS5mE2taTNmnA4n6
2tXPijsZEcj1pRAYkG/Mb7iAyB0jDFYz3UsY4OmaGV+aiKliqHkYCUEQEQ3220dc2UomXYsF
26G5lgtbjUCsPu3hC+ZPFAc72MKCpiXkd9HYrTNibbUJ7rSyTRG7ETVGhkXEoxJNFYVgerFD
4prjFX5Rguc0AzLR8Ru3MJOhFhYbb7Fmlbgl4cbpLdUE73EKgQe/THvuKB7BNpG/fzvLY6lf
MI07jFQifSDAxs1dofvlLRDt8pZGpCXmWBZQCC6VEiAZmi1ABW0qoDIrCsNjTEdiLbc4zqKi
wLiiQUTidWbXABxA3Y5sm06NKBEXttgYv4bMt6QeztKkXnJGPSgYtsE0oFKS58ssjeokTKZT
9MENyDIaxVkJnmWh7mgNKLWVQC+zvKe6/6b5hbVm4YSnBPcXSairBM93p7+Pp9fHgzhaX4+H
/dvx5HIaYBaUptZpkWh7vp3kOgyLBtP39UIT2pomrqVKr0Bv203DImtcyGyNem9V4vEDSNfi
0HPaWG6u3k6PT/vDd3fc3Dw4IJKY1OvVAeEMPw97GnD3xw4DGY/McqkUIHF/KZqc1ZkeqkvD
LSPBc4OIGDHcFdOx3eZaQ3B3cN0XyxfGI09z2cwLwWR96RehTB/oxC4qJLnooQ2EgpRuhOsc
MoHTrMpjXS8uqy6iBdPNu7I5DpfAcB67kHqeRDi0ThaGctXAeftsUPm6UZN5pUH1IDzihzRC
BgWoTNCnR0IQOOUP4dPfaxRKjYuVdZOnGVTc8orTUUHUqOeNEhlFZQB4YRXfbNunA5GR5X+9
7P7BYnFC+j0SLm5u9WxaADSlcIAkSeMaryebt+rVLg1Zrsk8nGVb81fdPoho4Jgl6mGh36cC
pLQRdvJSY2cVVIVGQtV9VWq6UUtmrbRlNDWUUUIChSfaMETlVHjd0lmaddNRIT728P4o2b2e
X4ZA+L4yEt8NBDKud0eAWGbkVxQi2VB5npuAekvK0hCGWkSecQjhQzFJqKXhEa0KVt5b5Uc1
GlZUYMaW93sD+l1jY6sxHWMZVEnYqkpBX2gGx/kahIaVB/z2OsuL9pKAErq0hC8m5lng0PF9
lQh9pX39zdC+euYQ4L6eyTIQ2QeUpMZkbp2O9U9hcz704SDmgBcZlN7hpixWBTWWN3SmQIKg
v3glTQl3GbYIdPocqnYSfS2I7yguD+baU2WlPR1Lv6psoRd6CE/m4MdsBMNtkfFDhnU+fsCe
dVrsAy9DtKpCt8NV0Z7MrasgykumhrBCfS0sjmoAG7aIoDeCx+V7D34OFpS0uM/NUL8GWBz1
C27g1pG5HTuQmxW3RwUVE4dJKtj1IiVlVaCZcefcDiwV2gCmAFJxpXWBdHRd23dVVmK3B0jf
POdjgysqmL1QRBvezbOGjJ/3FlppqB6ffhghtHjLT0yA3B3cBS/FDs8WBUnMiVRIP99S+CyA
FV3HjBuHkUTCGsBtrpsuq+6HfxVZ8jlch/IA6s+f/pDk2a242/impgrnDqptB69b6RYz/nlO
ys/RFv5NS6v17kOXxodLuChnQNY2CfxuDWgh6EhOhCg7Ht1geJbBa724aX/5tD8fZ7PJ7V+D
TxhhVc5n+s60G1UQpNr3t79nXY1pOTc7LwHOLpLQYoNO6cVpU9e98+79+Qj5it3p7APT6ABQ
MZSxBaRLFofiIt+DV1GR6mVbhV8nLMGffle1V0O3O/oLHlf+CPAWGCXo8ROVm6xY6VTa/Nnz
CQxoaP0eGXMrIZ5zWiINpzIFqfGn/SITd/rUsy1U1+RG9OKB4ShbdsH40ME3RDD14gooiMyx
hYyTQHD6Kswxz15Bgls/EXHVzAWjzrSDCU4L+yfMhtFg453Tr4EqLXJq/64Xuu+lAIhzG2D1
qgiMeJMNeTsMlsoDHjyXKfjAemIkNYW8qmUa5UtcDKHMsolhjdTCUftswEKknU3fM/W5DF4L
VBsZBH8DykncGUNSVTnEYPHjpXTk64jDJnqox/q8w4MyIq+9wV0U4b/o36X1DEm1fUcE8Uus
t7lH6oz1pR7zlrcajLpf6DHveH0teD1eYU9yMzLU/yYOTehskMzMZx0Lhy0li0SzwrEwN/6K
UedQi2RgTpqGGXoHPJvi718WESbiWiSTC21gFtoWya137LeepG0mEWoab9Xjn4bbMZ4+xuzk
jW8ahJQEy7KeeRsYDH/fQUEzMNeGdFAzv2rblEXZgoc4eISDxzh4gjc5xcE3eCW39lx0Pcec
eg2Csbeob3euMjarC7N/ElaZsIRQcXInMjCG0QIgaCRuLZgCpydIy6gqMrdOWmTitk5Scyok
5r5gcay/K7SYBYliM/BnhykiTzCbloKJvuKupx1FWrESG6UcPh7EtiURV7YVk3ESNISUgvU4
xzGmd6xSRpUe1ATUKVguxOxBhSvWst70UVp1FZiy5Nk9vZ/2bx+uLyscZ7pweg/PgndVBLbt
tkIH4lqKK5L4dkAIXofYmVNC+JooVDX3RgTqauzAxa86XEL8XBV8y+yMsrFltEP14kujw6jD
JOLyoa8sGMVNmy/oO1qULv5Ke1tpfpyK7sKVGcIhSxGGSqNz3cfVJsNumUKehMu3epzQ1aBi
WFSWhMihdnoeFF3npFx++fT5/G1/+Px+3p1ej8+7v1Q+nO6C1F6g+jki2q6JefLlE5jzPR//
e/jz4/H18c+X4+Pzr/3hz/Pj3zvR8f3zn/vD2+47rJg/v/36+5NaRKvd6bB7kWGTdwd4KekX
kxZw5Gp/2L/tH1/2/3sErPYKD1pGMSi6El9Vt56SCKkygWiMbeczg7O0NPB0opGglztPP1q0
fxidqZK9WzoJEpZw1hoc0NPHrzfIkn7a9UmJ+vEqYlAEkVz3bNXBQxcekRAFuqR8RVm+NIw8
TYRbBARrFOiSFoZ7bgdDCTux0um4tyfE1/lVnrvUK/0lo60BdIwuqeDJQgRw623gpuuiQnni
KZgFu+uVpShvqBbzwXCWVLGDSKsYB2I9kX9Qd8BmzFW5jMwwAw0GeuW+Wb9/e9k//fVz93H1
JBfrdwgx/OGs0cLw5FWw0F0oEaUITBLa3YloEXI8yFo71KpYR8PJZHDrdJu8v/3YHd72T49v
u+er6CD7Ljbi1X/3kKbzfD4+7SUqfHx7dAZD9dDH7dehidNzuhTnGxle51l8P1A5NO0+kmjB
+GCIOrQ2Wy26Y2t0/EsieNbaGVsgDamBa5/dngfu/NJ54MJKd3lTZE1G1C0bFxtndrJ5gAwh
px5vGondIu2JA3tTkNypP112c+xsYohEUFbu14G3g3XLaZeP5x++OUuIO2lLBbRHtLVGZOPX
opjzwcL99935zW23oKMh8rkA7EC3W5TxBjFZRcPAmS8Fd+dXVF4OrkM2d7kPWr+2si2WFo4R
mPt1EiaWsTT3waazSMKLewPwepT7HjycTJ22BHg0vHbAfEkGGBCrQoCVb7oDHiGbmyfY9alF
lkLQCDL3CCwXxeDWbWOTq5aVYLD/9cN44u/YiftNBawuEfEgrQKGUBd0jHyJIM42tu+ew28J
OKUx7G2no1C+rlZULw2Lugr16KnzrZWdll3VXP691NnVkjzgbvHN5yExJ0N3bbU83V0DkZ6l
oQMWuWFO3a0Md3uUejKUFrbJYNbdNaLgvZq3TdX667Q7n5VQbI9YSFAxKdEINw3jfsichmZj
dyXGD2NkygV0eYGbN4+ryjHl8fB8fL1K31+/7U5Xi91hd7Ik+W6NclbTHBMUwyJYtCFoEIyH
PyscQX1QdRLs/AOEA/zKIGJ6BFas+T3SIAh+kIDggsLZImxF639FXHgC5dp0IN77hwx9gyBZ
9r3jZf/tBHl2T8f3t/0BORohaxHGciRcMRIX0Zw9WkR4L42zHwCndqBW3FmJHdGFtQ40nXx4
sS89GYo2DEU1eHs0CtEXov/fXiK51Lwm2PgH2suYl4fcHWt2VUvMUprw+wSS+TAqNSXw0tN3
UUPmVRA3NLwKvGRlnhg03axtJ9e3NY2KRhETOfZT+YryGcSVhqSdso6GoquirduGQ8mbNrhX
X69a5bvTG7gGCUFfZTk/778fHt/exWX76cfu6ae4uesR2eBJU1c9FYbJhovnXz5pLx8NPtqW
BdHH6lMnZWlIinu7PZxaVS32DGSY4SVO3D71/4tBq4B83s0PWcdIAenKFvreB38AY0oCJkQc
iOWiLQep+ZLuARi2NYAXslFK8/t6XmSJZVGik8RR6sGmEZgCsNh49i5Cw2S8YEkkrslJYESb
UTpCErt15pTZVnxyIPDuS5N8S5fqMbaIDOmZiuuiOCR0HkGN2ESCwpW5ac3KqjYEB0vsFz97
1ayxoSVGbMgouJ95TgeNxBPwSZGQYuMTGQAfMLOHU0OqMfk/1cNCsqC53ejkmuGGfZ1RqfHM
ETcoIaF0tmAmFEybbfgDcEFx1IEkpCksHzKkDoBidQhJp6d+1aEadQcHwQepXIKx2rcPANa/
qILUW09IhQYt3Q1y/PbZkDCCPg42WJWRxi4joOVSbJJL9UIUHEz0a9AB/WoPr24eFBpgPw/1
4kF3o9IQ2wd3S+oK8+684RllYhNLPlMYYSmJNMONEhMUJppqKhVSPEDAYUTqx3UHTAEWHYpJ
Ab4BSyn2WbwA6uNRWeWSWFkC9q8wAgTCmDch1CJWI9KavNMZUZwZWhT43W0I9ImoMeK0Z00G
O53quzN+qEuiqXJYcQeCh9Z4kjMV9LTfwvNQG34mU2gsxPGjuzJycIPJYmuW0gwQUn/1/5Vd
WY/aSBD+KyhPG2lDQjbSbh54ANtkEMb22O5h8oRYBhE0CzPikJJ/n/qq2qYvk+xDpEl3uemr
jq7TAIXePk6K3Bi0IgJjEVyYYFBbOWCS8viVbVFo2Dm3vh53h/Nzj54hvaf95rT1jVZS04s9
yM0t183wvggrdCVkBImJUmJuaau2/rsT4l5Nk3r4qd1nLap4I3y6zgJplJqpcKrUIHI2ldK6
rpvVz2EmpjQzH+eQ6ZKyJCgrChnQ9E9XPxsaLmSd29q+Tnf/bd6dd3sta5wYdC3tR/8Q5Lf0
w8RrQ8UWFSVWQlijtyEcHfEYBmRVpNOwrsAAihejchLmlV/iMTIHT4s66GWfsU5/rqD6gNvz
dS2TkrZ2SQNnw38Gnz+al7wgQoZQ3blFQUp6xvFo1Bn4qbsEwaEVnKDqkYm8so5KfKrhzDcf
1ZHBXt0entMyz9Kv/uZOcsQ/iR8VoisKFZYzf/e0JakVdAC7dYOu8ebfy3YLy9n0cDofL/vN
4WzGs6AcEMTe8t4gUNfG1nwnez/88H1guDIacFJBLoQbslSDLatxZZXowH9JOjeJk7SNkfzC
OjVphwtlyJYNO7gMbhCz39oPe7Lieuifl/u7piG1HdcgfCA+9EpBQSjbQCrDoZ+ZVGAt/G2+
yKynG7+78ikKY5mPA7udWcIoc8IuHBhUjLmBpuJi3eGKmKpxAxbO1MwQ7GEYQiy8WvQ2k/yQ
0uX3d6bp6bxOYplWIO/m1xVRhVh3JlksROLGOh/Coe/SmeXzudLRcaGV6DvBGQfY5G0IARGL
L7MRbqunkZBmnuVw4FnCrxfJnVB1hxhyz+QB+F7+8nr6s5e+rJ8vr0Id7laHreXTXtCliGCW
z/MitB6rHzFYitDd7gQPz1U9NDIyo4oXnmqQ05Kabk0eVrdJ5/JOZShFU4WOdnFPxJJIZmxq
8hmp5QdMrL69anGjIVL5dOECKj5uyk1xAqyk0WaS3NaEMVydDgJj2/cCWzVLksKoZ415GvTn
j9Pr7gADIy1hfzlvvm/oj8153e/337qMu6yJ69XJY1L5yNIkwrpxlfW3nZe4XFSWj7m0Npn8
U1qG26fjbETN2mTDN+fG8Tt0GRAH49m7mwNfyMzCQuj/2C1L8K1LyfXSToU5MBFaFO2hN0kS
6zfwjQ2bCQXsQLZnYSVPq/OqBx6yhs7HE7Z0gIpN8t2oFX2EQaFSUyGot6wU5kJ6l/GoHkHW
LFUT2+RgR8c07fEjEv3o8UW8u2ptCpEKoYx5mJYkFSnO0dN1yuh3vjV6SOhZsojVEpePA+vL
0srcg6bk3vQMb9JnWZN2N5hIiwhbZUDMssVxvrjEtRHcHFoO1B1Z9LXO3aSPE5WJ6MdTLt1e
bl3OOb6WuAp0aA4IYlJ4IwBJvDqrXT+3SH8ooxhEkseOdDq8K21GauIg2rcvbFokcbDlVDv9
J61haXXchy6ByhbTLIYpxCy6i8QJ0uNeeK1TdDY57RYUHyacolUKWgwcjEqJOEepipPhm/1q
/e39Eyb4jv48vvSrN9c5tpqOFpwh318Oa23X639rwfFcqzgp7g+vCQraGdK4klSBvyztoAXU
wizrYC2yK7QAFVMVHoy7k3r8MAgnvmzhJHtCUs//egzNXLI8eM3AN69QQ9tpGbfNZg4b/yIa
XchEFje074qpLKg3pzOoN1hzhFxgq+3GcGdVltQkoc1N4len2aYc0pY88gX3KJL0Mip1Fmlp
6Cqe5XkZDpNtgX8dStsi1CzKHzxBkOQ9atZoWlgaScCHI60Iw6FWxxIkGXdHCRLCX5fyuu6T
4WPwfCxFsfMTLneI+JmHAQA=

--5mCyUwZo2JvN/JJP--
