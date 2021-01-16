Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942052F8EE3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 20:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbhAPTab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 14:30:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:64740 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbhAPTaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 14:30:30 -0500
IronPort-SDR: 5WcBp/WVS+ux2e+xgLIvNnh7/9SeZDeHIpIjIBAXd5TI1QRuqvD0+Qtu3UcvLiFythjG/frO7Z
 tlCcnP8vOZMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9866"; a="166351170"
X-IronPort-AV: E=Sophos;i="5.79,352,1602572400"; 
   d="gz'50?scan'50,208,50";a="166351170"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2021 11:29:47 -0800
IronPort-SDR: z42dwTQECXOe91JIebDGu6h+BPLXgDYzPE19aJC0vwLDdaBAUbWfUTP1wLvWF7bTidA4dniMmJ
 ExnnYWholqNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,352,1602572400"; 
   d="gz'50?scan'50,208,50";a="425679396"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 16 Jan 2021 11:29:44 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l0rGZ-00015b-SV; Sat, 16 Jan 2021 19:29:43 +0000
Date:   Sun, 17 Jan 2021 03:29:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/include/asm/mmu_context.h:151:9: sparse: sparse: incorrect
 type in argument 1 (different base types)
Message-ID: <202101170317.WDtLz130-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1d94330a437a573cfdf848f6743b1ed169242c8a
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   5 months ago
config: sh-randconfig-s032-20210117 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-208-g46a52ca4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   arch/sh/kernel/setup.c: note: in included file:
>> arch/sh/include/asm/mmu_context.h:151:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/mmu_context.h:151:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/mmu_context.h:151:9: sparse:     got unsigned int
--
   arch/sh/kernel/traps_32.c:493:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned short [usertype] * @@
   arch/sh/kernel/traps_32.c:493:51: sparse:     expected void const [noderef] __user *from
   arch/sh/kernel/traps_32.c:493:51: sparse:     got unsigned short [usertype] *
>> arch/sh/kernel/traps_32.c:617:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   arch/sh/kernel/traps_32.c:617:9: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/kernel/traps_32.c:617:9: sparse:     got unsigned short const *__gu_addr
   arch/sh/kernel/traps_32.c:702:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   arch/sh/kernel/traps_32.c:702:9: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/kernel/traps_32.c:702:9: sparse:     got unsigned short const *__gu_addr
   arch/sh/kernel/traps_32.c:704:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   arch/sh/kernel/traps_32.c:704:17: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/kernel/traps_32.c:704:17: sparse:     got unsigned short const *__gu_addr
--
>> arch/sh/kernel/ftrace.c:50:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned char * @@
   arch/sh/kernel/ftrace.c:50:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/ftrace.c:50:9: sparse:     got unsigned char *
   arch/sh/kernel/ftrace.c:57:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned char * @@
   arch/sh/kernel/ftrace.c:57:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/ftrace.c:57:9: sparse:     got unsigned char *
--
>> arch/sh/mm/cache-sh3.c:50:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr @@
   arch/sh/mm/cache-sh3.c:50:32: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh3.c:50:32: sparse:     got unsigned long [assigned] addr
   arch/sh/mm/cache-sh3.c:55:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr @@
   arch/sh/mm/cache-sh3.c:55:33: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh3.c:55:33: sparse:     got unsigned long [assigned] addr
   arch/sh/mm/cache-sh3.c:86:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr @@
   arch/sh/mm/cache-sh3.c:86:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh3.c:86:17: sparse:     got unsigned long [assigned] addr
--
>> arch/sh/kernel/cpu/sh3/probe.c:30:18: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:30:18: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:30:18: sparse:     got unsigned long [assigned] addr0
   arch/sh/kernel/cpu/sh3/probe.c:31:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:31:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:31:9: sparse:     got unsigned long [assigned] addr0
>> arch/sh/kernel/cpu/sh3/probe.c:32:18: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr1 @@
   arch/sh/kernel/cpu/sh3/probe.c:32:18: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:32:18: sparse:     got unsigned long [assigned] addr1
   arch/sh/kernel/cpu/sh3/probe.c:33:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr1 @@
   arch/sh/kernel/cpu/sh3/probe.c:33:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:33:9: sparse:     got unsigned long [assigned] addr1
   arch/sh/kernel/cpu/sh3/probe.c:36:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:36:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:36:17: sparse:     got unsigned long [assigned] addr0
   arch/sh/kernel/cpu/sh3/probe.c:38:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:38:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:38:9: sparse:     got unsigned long [assigned] addr0
   arch/sh/kernel/cpu/sh3/probe.c:39:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr1 @@
   arch/sh/kernel/cpu/sh3/probe.c:39:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:39:17: sparse:     got unsigned long [assigned] addr1
   arch/sh/kernel/cpu/sh3/probe.c:41:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr1 @@
   arch/sh/kernel/cpu/sh3/probe.c:41:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:41:9: sparse:     got unsigned long [assigned] addr1
   arch/sh/kernel/cpu/sh3/probe.c:42:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:42:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:42:17: sparse:     got unsigned long [assigned] addr0
   arch/sh/kernel/cpu/sh3/probe.c:45:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:45:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:45:9: sparse:     got unsigned long [assigned] addr0
   arch/sh/kernel/cpu/sh3/probe.c:46:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr1 @@
   arch/sh/kernel/cpu/sh3/probe.c:46:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:46:9: sparse:     got unsigned long [assigned] addr1
--
>> arch/sh/kernel/cpu/sh3/setup-sh3.c:59:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/kernel/cpu/sh3/setup-sh3.c:59:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/setup-sh3.c:59:17: sparse:     got unsigned long
>> arch/sh/kernel/cpu/sh3/setup-sh3.c:59:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/kernel/cpu/sh3/setup-sh3.c:59:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/setup-sh3.c:59:17: sparse:     got unsigned long
--
>> arch/sh/kernel/cpu/sh3/clock-sh7710.c:26:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7710.c:26:31: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7710.c:26:31: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7710.c:35:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7710.c:35:20: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7710.c:35:20: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7710.c:45:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7710.c:45:20: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7710.c:45:20: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7710.c:55:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7710.c:55:20: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7710.c:55:20: sparse:     got unsigned int
--
>> arch/sh/kernel/cpu/sh3/serial-sh7710.c:13:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:13:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:13:17: sparse:     got unsigned int
>> arch/sh/kernel/cpu/sh3/serial-sh7710.c:13:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:13:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:13:17: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:14:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:14:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:14:17: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:14:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:14:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:14:17: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:16:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:16:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:16:17: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:16:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:16:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:16:17: sparse:     got unsigned int
--
>> arch/sh/kernel/cpu/irq/ipr.c:35:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long addr @@
   arch/sh/kernel/cpu/irq/ipr.c:35:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/irq/ipr.c:35:9: sparse:     got unsigned long addr
>> arch/sh/kernel/cpu/irq/ipr.c:35:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long addr @@
   arch/sh/kernel/cpu/irq/ipr.c:35:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/irq/ipr.c:35:9: sparse:     got unsigned long addr
   arch/sh/kernel/cpu/irq/ipr.c:36:15: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long addr @@
   arch/sh/kernel/cpu/irq/ipr.c:36:15: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/irq/ipr.c:36:15: sparse:     got unsigned long addr
   arch/sh/kernel/cpu/irq/ipr.c:44:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long addr @@
   arch/sh/kernel/cpu/irq/ipr.c:44:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/irq/ipr.c:44:9: sparse:     got unsigned long addr
   arch/sh/kernel/cpu/irq/ipr.c:44:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long addr @@
   arch/sh/kernel/cpu/irq/ipr.c:44:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/irq/ipr.c:44:9: sparse:     got unsigned long addr
--
   arch/sh/math-emu/math.c: note: in included file:
   include/math-emu/single.h:50:5: sparse: sparse: undefined preprocessor identifier '__LITTLE_ENDIAN'
   arch/sh/math-emu/math.c: note: in included file:
   include/math-emu/double.h:59:5: sparse: sparse: undefined preprocessor identifier '__LITTLE_ENDIAN'
   arch/sh/math-emu/math.c:54:9: sparse: sparse: preprocessor token WRITE redefined
   arch/sh/math-emu/math.c: note: in included file:
   include/linux/kernel.h:41:9: sparse: this was the original definition
   arch/sh/math-emu/math.c:55:9: sparse: sparse: preprocessor token READ redefined
   include/linux/kernel.h:40:9: sparse: this was the original definition
   arch/sh/math-emu/math.c:122:9: sparse: sparse: asm output is not an lvalue
   arch/sh/math-emu/math.c:122:9: sparse: sparse: asm output is not an lvalue
   arch/sh/math-emu/math.c:122:9: sparse: sparse: asm output is not an lvalue
   arch/sh/math-emu/math.c:122:9: sparse: sparse: asm output is not an lvalue
   arch/sh/math-emu/math.c:122:9: sparse: sparse: asm output is not an lvalue
   arch/sh/math-emu/math.c:122:9: sparse: sparse: asm output is not an lvalue
   arch/sh/math-emu/math.c:122:9: sparse: sparse: asm output is not an lvalue
   arch/sh/math-emu/math.c:122:9: sparse: sparse: asm output is not an lvalue
   arch/sh/math-emu/math.c:122:9: sparse: sparse: asm output is not an lvalue
   arch/sh/math-emu/math.c:122:9: sparse: sparse: asm output is not an lvalue
   arch/sh/math-emu/math.c:129:9: sparse: sparse: asm output is not an lvalue
   arch/sh/math-emu/math.c:129:9: sparse: sparse: asm output is not an lvalue
   arch/sh/math-emu/math.c:129:9: sparse: sparse: asm output is not an lvalue
   arch/sh/math-emu/math.c:129:9: sparse: sparse: asm output is not an lvalue
   arch/sh/math-emu/math.c:145:9: sparse: sparse: asm output is not an lvalue
   arch/sh/math-emu/math.c:145:9: sparse: sparse: asm output is not an lvalue
>> arch/sh/math-emu/math.c:160:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   arch/sh/math-emu/math.c:160:17: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/math-emu/math.c:160:17: sparse:     got unsigned long const *__gu_addr
   arch/sh/math-emu/math.c:162:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   arch/sh/math-emu/math.c:162:17: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/math-emu/math.c:162:17: sparse:     got unsigned long const *__gu_addr
   arch/sh/math-emu/math.c:164:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   arch/sh/math-emu/math.c:164:17: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/math-emu/math.c:164:17: sparse:     got unsigned long const *__gu_addr
   arch/sh/math-emu/math.c:176:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   arch/sh/math-emu/math.c:176:17: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/math-emu/math.c:176:17: sparse:     got unsigned long const *__gu_addr
   arch/sh/math-emu/math.c:178:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   arch/sh/math-emu/math.c:178:17: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/math-emu/math.c:178:17: sparse:     got unsigned long const *__gu_addr
   arch/sh/math-emu/math.c:180:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   arch/sh/math-emu/math.c:180:17: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/math-emu/math.c:180:17: sparse:     got unsigned long const *__gu_addr
   arch/sh/math-emu/math.c:192:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   arch/sh/math-emu/math.c:192:17: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/math-emu/math.c:192:17: sparse:     got unsigned long const *__gu_addr
   arch/sh/math-emu/math.c:194:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   arch/sh/math-emu/math.c:194:17: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/math-emu/math.c:194:17: sparse:     got unsigned long const *__gu_addr
   arch/sh/math-emu/math.c:197:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   arch/sh/math-emu/math.c:197:17: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/math-emu/math.c:197:17: sparse:     got unsigned long const *__gu_addr
   arch/sh/math-emu/math.c:210:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__pu_addr @@     got unsigned long * @@
   arch/sh/math-emu/math.c:210:17: sparse:     expected unsigned long [noderef] __user *__pu_addr
   arch/sh/math-emu/math.c:210:17: sparse:     got unsigned long *
   arch/sh/math-emu/math.c:212:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__pu_addr @@     got unsigned long * @@
   arch/sh/math-emu/math.c:212:17: sparse:     expected unsigned long [noderef] __user *__pu_addr
   arch/sh/math-emu/math.c:212:17: sparse:     got unsigned long *
   arch/sh/math-emu/math.c:214:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__pu_addr @@     got unsigned long * @@
   arch/sh/math-emu/math.c:214:17: sparse:     expected unsigned long [noderef] __user *__pu_addr
   arch/sh/math-emu/math.c:214:17: sparse:     got unsigned long *
   arch/sh/math-emu/math.c:226:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__pu_addr @@     got unsigned long * @@
   arch/sh/math-emu/math.c:226:17: sparse:     expected unsigned long [noderef] __user *__pu_addr
   arch/sh/math-emu/math.c:226:17: sparse:     got unsigned long *
   arch/sh/math-emu/math.c:228:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__pu_addr @@     got unsigned long * @@
   arch/sh/math-emu/math.c:228:17: sparse:     expected unsigned long [noderef] __user *__pu_addr
   arch/sh/math-emu/math.c:228:17: sparse:     got unsigned long *
   arch/sh/math-emu/math.c:230:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__pu_addr @@     got unsigned long * @@
   arch/sh/math-emu/math.c:230:17: sparse:     expected unsigned long [noderef] __user *__pu_addr
   arch/sh/math-emu/math.c:230:17: sparse:     got unsigned long *
   arch/sh/math-emu/math.c:243:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__pu_addr @@     got unsigned long * @@
   arch/sh/math-emu/math.c:243:17: sparse:     expected unsigned long [noderef] __user *__pu_addr
   arch/sh/math-emu/math.c:243:17: sparse:     got unsigned long *
   arch/sh/math-emu/math.c:245:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__pu_addr @@     got unsigned long * @@
   arch/sh/math-emu/math.c:245:17: sparse:     expected unsigned long [noderef] __user *__pu_addr
   arch/sh/math-emu/math.c:245:17: sparse:     got unsigned long *
   arch/sh/math-emu/math.c:248:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__pu_addr @@     got unsigned long * @@
   arch/sh/math-emu/math.c:248:17: sparse:     expected unsigned long [noderef] __user *__pu_addr
   arch/sh/math-emu/math.c:248:17: sparse:     got unsigned long *
   arch/sh/math-emu/math.c:448:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__pu_addr @@     got unsigned long * @@
   arch/sh/math-emu/math.c:448:17: sparse:     expected unsigned long [noderef] __user *__pu_addr
   arch/sh/math-emu/math.c:448:17: sparse:     got unsigned long *
   arch/sh/math-emu/math.c:452:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   arch/sh/math-emu/math.c:452:17: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/math-emu/math.c:452:17: sparse:     got unsigned long const *__gu_addr
   arch/sh/math-emu/math.c:122:9: sparse: sparse: generating address of non-lvalue (11)
   arch/sh/math-emu/math.c:122:9: sparse: sparse: generating address of non-lvalue (11)
   arch/sh/math-emu/math.c:122:9: sparse: sparse: generating address of non-lvalue (1)
   arch/sh/math-emu/math.c:122:9: sparse: sparse: generating address of non-lvalue (1)
   arch/sh/math-emu/math.c:122:9: sparse: sparse: generating address of non-lvalue (1)
   arch/sh/math-emu/math.c:122:9: sparse: sparse: generating address of non-lvalue (1)
   arch/sh/math-emu/math.c:122:9: sparse: sparse: generating address of non-lvalue (11)
   arch/sh/math-emu/math.c:122:9: sparse: sparse: generating address of non-lvalue (11)
   arch/sh/math-emu/math.c:122:9: sparse: sparse: generating address of non-lvalue (11)
   arch/sh/math-emu/math.c:122:9: sparse: sparse: generating address of non-lvalue (11)
   arch/sh/math-emu/math.c:129:9: sparse: sparse: generating address of non-lvalue (11)
   arch/sh/math-emu/math.c:129:9: sparse: sparse: generating address of non-lvalue (11)
   arch/sh/math-emu/math.c:129:9: sparse: sparse: generating address of non-lvalue (11)
   arch/sh/math-emu/math.c:129:9: sparse: sparse: generating address of non-lvalue (11)
   arch/sh/math-emu/math.c:145:9: sparse: sparse: generating address of non-lvalue (11)
   arch/sh/math-emu/math.c:145:9: sparse: sparse: generating address of non-lvalue (11)
--
   arch/sh/boards/mach-se/770x/setup.c: note: in included file (through include/linux/scatterlist.h, include/linux/dma-mapping.h, include/linux/skbuff.h, ...):
   arch/sh/include/asm/io.h:184:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char volatile [usertype] *__addr @@     got void [noderef] __iomem * @@
   arch/sh/include/asm/io.h:184:1: sparse:     expected unsigned char volatile [usertype] *__addr
   arch/sh/include/asm/io.h:184:1: sparse:     got void [noderef] __iomem *
   arch/sh/include/asm/io.h:184:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char volatile [usertype] *__addr @@     got void [noderef] __iomem * @@
   arch/sh/include/asm/io.h:184:1: sparse:     expected unsigned char volatile [usertype] *__addr
   arch/sh/include/asm/io.h:184:1: sparse:     got void [noderef] __iomem *
   arch/sh/include/asm/io.h:184:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char volatile [usertype] *__addr @@     got void [noderef] __iomem * @@
   arch/sh/include/asm/io.h:184:1: sparse:     expected unsigned char volatile [usertype] *__addr
   arch/sh/include/asm/io.h:184:1: sparse:     got void [noderef] __iomem *
   arch/sh/include/asm/io.h:184:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char volatile [usertype] *__addr @@     got void [noderef] __iomem * @@
   arch/sh/include/asm/io.h:184:1: sparse:     expected unsigned char volatile [usertype] *__addr
   arch/sh/include/asm/io.h:184:1: sparse:     got void [noderef] __iomem *
   arch/sh/include/asm/io.h:184:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char volatile [usertype] *__addr @@     got void [noderef] __iomem * @@
   arch/sh/include/asm/io.h:184:1: sparse:     expected unsigned char volatile [usertype] *__addr
   arch/sh/include/asm/io.h:184:1: sparse:     got void [noderef] __iomem *
   arch/sh/boards/mach-se/770x/setup.c: note: in included file:
>> arch/sh/include/mach-se/mach/mrshpc.h:9:14: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:9:14: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:9:14: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:12:14: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:12:14: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:12:14: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:13:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:13:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:13:17: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:15:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:15:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:15:17: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:23:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:23:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:23:9: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:24:13: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:24:13: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:24:13: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:26:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:26:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:26:17: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:29:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:29:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:29:17: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:32:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:32:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:32:9: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:33:14: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:33:14: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:33:14: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:35:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:35:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:35:17: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:38:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:38:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:38:17: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:41:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:41:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:41:9: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:42:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:42:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:42:9: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:43:14: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:43:14: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:43:14: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:44:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:44:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:44:17: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:46:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:46:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:46:17: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:48:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:48:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:48:9: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:49:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:49:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:49:9: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:50:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:50:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:50:9: sparse:     got unsigned int
--
>> arch/sh/boards/mach-se/770x/irq.c:100:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-se/770x/irq.c:100:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-se/770x/irq.c:100:9: sparse:     got unsigned int
   arch/sh/boards/mach-se/770x/irq.c:101:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-se/770x/irq.c:101:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-se/770x/irq.c:101:9: sparse:     got unsigned int
   arch/sh/boards/mach-se/770x/irq.c:102:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-se/770x/irq.c:102:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-se/770x/irq.c:102:9: sparse:     got unsigned int
   arch/sh/boards/mach-se/770x/irq.c:103:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-se/770x/irq.c:103:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-se/770x/irq.c:103:9: sparse:     got unsigned int
   arch/sh/boards/mach-se/770x/irq.c:104:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-se/770x/irq.c:104:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-se/770x/irq.c:104:9: sparse:     got unsigned int
   arch/sh/boards/mach-se/770x/irq.c:105:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-se/770x/irq.c:105:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-se/770x/irq.c:105:9: sparse:     got unsigned int
   arch/sh/boards/mach-se/770x/irq.c:106:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-se/770x/irq.c:106:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-se/770x/irq.c:106:9: sparse:     got unsigned int
--
   fs/binfmt_flat.c:402:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const *__gu_addr @@     got unsigned long [noderef] __user *[assigned] ptr @@
   fs/binfmt_flat.c:402:9: sparse:     expected unsigned long const *__gu_addr
   fs/binfmt_flat.c:402:9: sparse:     got unsigned long [noderef] __user *[assigned] ptr
>> fs/binfmt_flat.c:402:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   fs/binfmt_flat.c:402:9: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_flat.c:402:9: sparse:     got unsigned long const *__gu_addr
   fs/binfmt_flat.c:775:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *[assigned] rp @@
   fs/binfmt_flat.c:775:29: sparse:     expected unsigned int const *__gu_addr
   fs/binfmt_flat.c:775:29: sparse:     got unsigned int [noderef] [usertype] __user *[assigned] rp
   fs/binfmt_flat.c:775:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   fs/binfmt_flat.c:775:29: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_flat.c:775:29: sparse:     got unsigned int const *__gu_addr
   fs/binfmt_flat.c:812:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected restricted __be32 const *__gu_addr @@     got restricted __be32 [noderef] [usertype] __user * @@
   fs/binfmt_flat.c:812:29: sparse:     expected restricted __be32 const *__gu_addr
   fs/binfmt_flat.c:812:29: sparse:     got restricted __be32 [noderef] [usertype] __user *
   fs/binfmt_flat.c:812:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got restricted __be32 const *__gu_addr @@
   fs/binfmt_flat.c:812:29: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_flat.c:812:29: sparse:     got restricted __be32 const *__gu_addr
   fs/binfmt_flat.c:855:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected restricted __be32 const *__gu_addr @@     got restricted __be32 [noderef] [usertype] __user * @@
   fs/binfmt_flat.c:855:29: sparse:     expected restricted __be32 const *__gu_addr
   fs/binfmt_flat.c:855:29: sparse:     got restricted __be32 [noderef] [usertype] __user *
   fs/binfmt_flat.c:855:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got restricted __be32 const *__gu_addr @@
   fs/binfmt_flat.c:855:29: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_flat.c:855:29: sparse:     got restricted __be32 const *__gu_addr
   fs/binfmt_flat.c:865:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __user *__cl_addr @@
   fs/binfmt_flat.c:865:13: sparse:     expected void *addr
   fs/binfmt_flat.c:865:13: sparse:     got void [noderef] __user *__cl_addr
--
   sound/core/hwdep.c:265:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/hwdep.c:265:29: sparse:     expected int const *__gu_addr
   sound/core/hwdep.c:265:29: sparse:     got int [noderef] __user *
>> sound/core/hwdep.c:265:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/hwdep.c:265:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/hwdep.c:265:29: sparse:     got int const *__gu_addr
   sound/core/hwdep.c:294:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/hwdep.c:294:29: sparse:     expected unsigned int const *__gu_addr
   sound/core/hwdep.c:294:29: sparse:     got unsigned int [noderef] __user *
>> sound/core/hwdep.c:294:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/hwdep.c:294:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/hwdep.c:294:29: sparse:     got unsigned int const *__gu_addr
--
   sound/core/timer.c:2045:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/timer.c:2045:13: sparse:     expected int const *__gu_addr
   sound/core/timer.c:2045:13: sparse:     got int [noderef] __user *p
>> sound/core/timer.c:2045:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/timer.c:2045:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/timer.c:2045:13: sparse:     got int const *__gu_addr
   sound/core/timer.c:790:25: sparse: sparse: context imbalance in 'snd_timer_process_callbacks' - unexpected unlock
--
   sound/core/oss/pcm_oss.c:2592:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/oss/pcm_oss.c:2592:21: sparse:     expected int const *__gu_addr
   sound/core/oss/pcm_oss.c:2592:21: sparse:     got int [noderef] __user *p
>> sound/core/oss/pcm_oss.c:2592:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/oss/pcm_oss.c:2592:21: sparse:     expected void const volatile [noderef] __user *ptr
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
   sound/sh/sh_dac_audio.c:167:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *dst @@     got char * @@
   sound/sh/sh_dac_audio.c:167:51: sparse:     expected void volatile [noderef] __iomem *dst
   sound/sh/sh_dac_audio.c:167:51: sparse:     got char *
   sound/sh/sh_dac_audio.c:186:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem * @@     got char * @@
   sound/sh/sh_dac_audio.c:186:39: sparse:     expected void volatile [noderef] __iomem *
   sound/sh/sh_dac_audio.c:186:39: sparse:     got char *
   sound/sh/sh_dac_audio.c:204:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem * @@     got char * @@
   sound/sh/sh_dac_audio.c:204:37: sparse:     expected void volatile [noderef] __iomem *
   sound/sh/sh_dac_audio.c:204:37: sparse:     got char *
   sound/sh/sh_dac_audio.c: note: in included file:
>> arch/sh/include/cpu-sh3/cpu/dac.h:38:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/cpu-sh3/cpu/dac.h:38:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/cpu-sh3/cpu/dac.h:38:21: sparse:     got unsigned int
   arch/sh/include/cpu-sh3/cpu/dac.h:39:14: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/cpu-sh3/cpu/dac.h:39:14: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/cpu-sh3/cpu/dac.h:39:14: sparse:     got unsigned int
--
   sound/core/seq/oss/seq_oss_timer.c:224:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *arg @@
   sound/core/seq/oss/seq_oss_timer.c:224:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_timer.c:224:21: sparse:     got int [noderef] __user *arg
>> sound/core/seq/oss/seq_oss_timer.c:224:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_timer.c:224:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_timer.c:224:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *arg @@
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse:     got int [noderef] __user *arg
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *arg @@
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse:     got int [noderef] __user *arg
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse:     got int const *__gu_addr
--
   sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse:     got int [noderef] __user *p
>> sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse:     got int [noderef] __user *p
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse:     got int [noderef] __user *p
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse:     got int [noderef] __user *p
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse:     got int [noderef] __user *p
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse:     got int [noderef] __user *p
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse:     got int const *__gu_addr

vim +151 arch/sh/include/asm/mmu_context.h

^1da177e4c3f4152 include/asm-sh/mmu_context.h      Linus Torvalds 2005-04-16  139  
^1da177e4c3f4152 include/asm-sh/mmu_context.h      Linus Torvalds 2005-04-16  140  #if defined(CONFIG_CPU_SH3) || defined(CONFIG_CPU_SH4)
^1da177e4c3f4152 include/asm-sh/mmu_context.h      Linus Torvalds 2005-04-16  141  /*
^1da177e4c3f4152 include/asm-sh/mmu_context.h      Linus Torvalds 2005-04-16  142   * If this processor has an MMU, we need methods to turn it off/on ..
^1da177e4c3f4152 include/asm-sh/mmu_context.h      Linus Torvalds 2005-04-16  143   * paging_init() will also have to be updated for the processor in
^1da177e4c3f4152 include/asm-sh/mmu_context.h      Linus Torvalds 2005-04-16  144   * question.
^1da177e4c3f4152 include/asm-sh/mmu_context.h      Linus Torvalds 2005-04-16  145   */
^1da177e4c3f4152 include/asm-sh/mmu_context.h      Linus Torvalds 2005-04-16  146  static inline void enable_mmu(void)
^1da177e4c3f4152 include/asm-sh/mmu_context.h      Linus Torvalds 2005-04-16  147  {
aec5e0e1c179fac4 include/asm-sh/mmu_context.h      Paul Mundt     2006-12-25  148  	unsigned int cpu = smp_processor_id();
aec5e0e1c179fac4 include/asm-sh/mmu_context.h      Paul Mundt     2006-12-25  149  
^1da177e4c3f4152 include/asm-sh/mmu_context.h      Linus Torvalds 2005-04-16  150  	/* Enable MMU */
9d56dd3b083a3bec arch/sh/include/asm/mmu_context.h Paul Mundt     2010-01-26 @151  	__raw_writel(MMU_CONTROL_INIT, MMUCR);
298476220d1f793c include/asm-sh/mmu_context.h      Paul Mundt     2006-09-27  152  	ctrl_barrier();
^1da177e4c3f4152 include/asm-sh/mmu_context.h      Linus Torvalds 2005-04-16  153  
aec5e0e1c179fac4 include/asm-sh/mmu_context.h      Paul Mundt     2006-12-25  154  	if (asid_cache(cpu) == NO_CONTEXT)
aec5e0e1c179fac4 include/asm-sh/mmu_context.h      Paul Mundt     2006-12-25  155  		asid_cache(cpu) = MMU_CONTEXT_FIRST_VERSION;
^1da177e4c3f4152 include/asm-sh/mmu_context.h      Linus Torvalds 2005-04-16  156  
aec5e0e1c179fac4 include/asm-sh/mmu_context.h      Paul Mundt     2006-12-25  157  	set_asid(asid_cache(cpu) & MMU_CONTEXT_ASID_MASK);
^1da177e4c3f4152 include/asm-sh/mmu_context.h      Linus Torvalds 2005-04-16  158  }
^1da177e4c3f4152 include/asm-sh/mmu_context.h      Linus Torvalds 2005-04-16  159  

:::::: The code at line 151 was first introduced by commit
:::::: 9d56dd3b083a3bec56e9da35ce07baca81030b03 sh: Mass ctrl_in/outX to __raw_read/writeX conversion.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--dDRMvlgZJXvWKvBx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
2krP7f8ALWFqo2j1AAA=

--dDRMvlgZJXvWKvBx--
