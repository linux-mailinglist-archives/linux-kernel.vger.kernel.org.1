Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9642BA17F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 05:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgKTEpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 23:45:47 -0500
Received: from mga18.intel.com ([134.134.136.126]:44775 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgKTEpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 23:45:47 -0500
IronPort-SDR: lKix/5eYO/Lbj+w3EgE0pasn+t4DicwDySqpSPMJoWEirbGn6prRGe9RJRzBeHjU+gxwHB2DmL
 Mdg2eK5if+NQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="159184517"
X-IronPort-AV: E=Sophos;i="5.78,355,1599548400"; 
   d="gz'50?scan'50,208,50";a="159184517"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 20:45:45 -0800
IronPort-SDR: O5jNXi4bpc4fr1iGa6myLo+oxEJ7LM7vgVglVoY7v5s8OeMIW8j1yPo2/sxMlvug4PwdmFVOJX
 lxzhSopHmDxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,355,1599548400"; 
   d="gz'50?scan'50,208,50";a="545298571"
Received: from lkp-server01.sh.intel.com (HELO f63bb96ba247) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 19 Nov 2020 20:45:43 -0800
Received: from kbuild by f63bb96ba247 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kfyIo-00000h-BK; Fri, 20 Nov 2020 04:45:42 +0000
Date:   Fri, 20 Nov 2020 12:44:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>
Subject: arch/arm/include/asm/arch_gicv3.h:44:2: error: implicit declaration
 of function 'write_sysreg'
Message-ID: <202011201254.P1XqOnp7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peng,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4d02da974ea85a62074efedf354e82778f910d82
commit: d82bcef5157de1368c08244a846ab968b3e5cb7e soc: imx: select ARM_GIC_V3 for i.MX8M
date:   4 months ago
config: arm-randconfig-r024-20201120 (attached as .config)
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

--45Z9DzgjV8m4Oswq
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--45Z9DzgjV8m4Oswq--
