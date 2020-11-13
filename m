Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F332B192C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 11:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgKMKi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 05:38:28 -0500
Received: from mga05.intel.com ([192.55.52.43]:35372 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbgKMKi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:38:27 -0500
IronPort-SDR: OV5U5mf4TNcjf5NsqOO+Z8k2fnqclAV/6pewCGzi68yHkfh+XRZqSSHsKQSh3e7M7QvbnQD2a2
 8BL0ptP8gung==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="255164547"
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; 
   d="gz'50?scan'50,208,50";a="255164547"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 02:38:22 -0800
IronPort-SDR: vjOCycYisyV3s9RcppBS1R+iLIM2AitwthD/jRASwTHxKWfiv7gRGp0bpHvSJ2ZwmwocnsAfWS
 HAXv2bPX9iLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; 
   d="gz'50?scan'50,208,50";a="399705599"
Received: from lkp-server02.sh.intel.com (HELO 697932c29306) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 13 Nov 2020 02:38:20 -0800
Received: from kbuild by 697932c29306 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kdWTD-0000E9-JD; Fri, 13 Nov 2020 10:38:19 +0000
Date:   Fri, 13 Nov 2020 18:38:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>
Subject: arch/arm/include/asm/arch_gicv3.h:44:2: error: implicit declaration
 of function 'write_sysreg'
Message-ID: <202011131805.CtXQFeJs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peng,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   585e5b17b92dead8a3aca4e3c9876fbca5f7e0ba
commit: d82bcef5157de1368c08244a846ab968b3e5cb7e soc: imx: select ARM_GIC_V3 for i.MX8M
date:   4 months ago
config: arm-randconfig-r005-20201113 (attached as .config)
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

All errors (new ones prefixed by >>):

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

d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  17  
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  18  #define ICC_EOIR1			__ACCESS_CP15(c12, 0, c12, 1)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01 @19  #define ICC_DIR				__ACCESS_CP15(c12, 0, c11, 1)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  20  #define ICC_IAR1			__ACCESS_CP15(c12, 0, c12, 0)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01 @21  #define ICC_SGI1R			__ACCESS_CP15_64(0, c12)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01 @22  #define ICC_PMR				__ACCESS_CP15(c4, 0, c6, 0)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  23  #define ICC_CTLR			__ACCESS_CP15(c12, 0, c12, 4)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  24  #define ICC_SRE				__ACCESS_CP15(c12, 0, c12, 5)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  25  #define ICC_IGRPEN1			__ACCESS_CP15(c12, 0, c12, 7)
91ef84428a86b75 Daniel Thompson       2016-08-19  26  #define ICC_BPR1			__ACCESS_CP15(c12, 0, c12, 3)
e99da7c6f51b487 Julien Thierry        2019-01-31  27  #define ICC_RPR				__ACCESS_CP15(c12, 0, c11, 3)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  28  
d6062a6d62c643a Marc Zyngier          2018-03-09 @29  #define __ICC_AP0Rx(x)			__ACCESS_CP15(c12, 0, c8, 4 | x)
d6062a6d62c643a Marc Zyngier          2018-03-09  30  #define ICC_AP0R0			__ICC_AP0Rx(0)
d6062a6d62c643a Marc Zyngier          2018-03-09  31  #define ICC_AP0R1			__ICC_AP0Rx(1)
d6062a6d62c643a Marc Zyngier          2018-03-09  32  #define ICC_AP0R2			__ICC_AP0Rx(2)
d6062a6d62c643a Marc Zyngier          2018-03-09  33  #define ICC_AP0R3			__ICC_AP0Rx(3)
d6062a6d62c643a Marc Zyngier          2018-03-09  34  
d6062a6d62c643a Marc Zyngier          2018-03-09 @35  #define __ICC_AP1Rx(x)			__ACCESS_CP15(c12, 0, c9, x)
d6062a6d62c643a Marc Zyngier          2018-03-09  36  #define ICC_AP1R0			__ICC_AP1Rx(0)
d6062a6d62c643a Marc Zyngier          2018-03-09  37  #define ICC_AP1R1			__ICC_AP1Rx(1)
d6062a6d62c643a Marc Zyngier          2018-03-09  38  #define ICC_AP1R2			__ICC_AP1Rx(2)
d6062a6d62c643a Marc Zyngier          2018-03-09  39  #define ICC_AP1R3			__ICC_AP1Rx(3)
d6062a6d62c643a Marc Zyngier          2018-03-09  40  
a078bedf17c2e43 Vladimir Murzin       2016-09-12  41  #define CPUIF_MAP(a32, a64)			\
a078bedf17c2e43 Vladimir Murzin       2016-09-12  42  static inline void write_ ## a64(u32 val)	\
a078bedf17c2e43 Vladimir Murzin       2016-09-12  43  {						\
a078bedf17c2e43 Vladimir Murzin       2016-09-12 @44  	write_sysreg(val, a32);			\
a078bedf17c2e43 Vladimir Murzin       2016-09-12  45  }						\
a078bedf17c2e43 Vladimir Murzin       2016-09-12  46  static inline u32 read_ ## a64(void)		\
a078bedf17c2e43 Vladimir Murzin       2016-09-12  47  {						\
a078bedf17c2e43 Vladimir Murzin       2016-09-12 @48  	return read_sysreg(a32); 		\
a078bedf17c2e43 Vladimir Murzin       2016-09-12  49  }						\
a078bedf17c2e43 Vladimir Murzin       2016-09-12  50  

:::::: The code at line 44 was first introduced by commit
:::::: a078bedf17c2e43819fea54bdfd5793845142e3a ARM: gic-v3: Introduce 32-to-64-bit mappings for GICv3 cpu registers

:::::: TO: Vladimir Murzin <vladimir.murzin@arm.com>
:::::: CC: Christoffer Dall <christoffer.dall@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--WIyZ46R2i8wDzkSu
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--WIyZ46R2i8wDzkSu--
