Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27152F6023
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbhANLf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 06:35:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:12681 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbhANLf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:35:57 -0500
IronPort-SDR: DZVrP0fNB8kLBh/6KrBPArPzrphCj6/Ayi51kOzQdpfnxzLa6lriveesn7YP1zziDGhnNQ6ejd
 rOpd7Cbzlzmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="174841967"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="gz'50?scan'50,208,50";a="174841967"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 03:35:16 -0800
IronPort-SDR: 1DJPSbtQnK4aL1pnQJF+cjlr7U0ic6QXzxFxch1s102UQK/FXhxbh2qyFWEQ0P2C4cyfABmGed
 AkH1YwZmu4OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="gz'50?scan'50,208,50";a="568145813"
Received: from lkp-server01.sh.intel.com (HELO d5d1a9a2c6bb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2021 03:35:14 -0800
Received: from kbuild by d5d1a9a2c6bb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l00uH-0000nx-Pz; Thu, 14 Jan 2021 11:35:13 +0000
Date:   Thu, 14 Jan 2021 19:34:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paul Burton <paulburton@kernel.org>
Subject: drivers/mmc/host/dw_mmc.c:602:29: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202101141924.GIssKfzk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mike,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   65f0d2414b7079556fbbcc070b3d1c9f9587606d
commit: 3ed6751bb8fa89c3014399bb0414348499ee202a mips: fix build when "48 bits virtual memory" is enabled
date:   1 year, 2 months ago
config: mips-randconfig-s032-20210114 (attached as .config)
compiler: mips64el-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-208-g46a52ca4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3ed6751bb8fa89c3014399bb0414348499ee202a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3ed6751bb8fa89c3014399bb0414348499ee202a
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> drivers/mmc/host/dw_mmc.c:602:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   drivers/mmc/host/dw_mmc.c:602:29: sparse:     expected void const volatile [noderef] <asn:2> *mem
   drivers/mmc/host/dw_mmc.c:602:29: sparse:     got unsigned int *
>> drivers/mmc/host/dw_mmc.c:602:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   drivers/mmc/host/dw_mmc.c:602:29: sparse:     expected void const volatile [noderef] <asn:2> *mem
   drivers/mmc/host/dw_mmc.c:602:29: sparse:     got unsigned int *
   drivers/mmc/host/dw_mmc.c:615:25: sparse: sparse: restricted __le32 degrades to integer
   drivers/mmc/host/dw_mmc.c:615:25: sparse: sparse: restricted __le32 degrades to integer
>> drivers/mmc/host/dw_mmc.c:674:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got restricted __le32 * @@
   drivers/mmc/host/dw_mmc.c:674:29: sparse:     expected void const volatile [noderef] <asn:2> *mem
   drivers/mmc/host/dw_mmc.c:674:29: sparse:     got restricted __le32 *
   drivers/mmc/host/dw_mmc.c:674:29: sparse: sparse: restricted __le32 degrades to integer
>> drivers/mmc/host/dw_mmc.c:674:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got restricted __le32 * @@
   drivers/mmc/host/dw_mmc.c:674:29: sparse:     expected void const volatile [noderef] <asn:2> *mem
   drivers/mmc/host/dw_mmc.c:674:29: sparse:     got restricted __le32 *
   drivers/mmc/host/dw_mmc.c:674:29: sparse: sparse: restricted __le32 degrades to integer
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> drivers/tty/serial/zs.c:988:26: sparse: sparse: Using plain integer as NULL pointer
>> drivers/tty/serial/zs.c:218:9: sparse: sparse: context imbalance in 'zs_spin_lock_cond_irq' - wrong count at exit
   drivers/tty/serial/zs.c:227:32: sparse: sparse: context imbalance in 'zs_spin_unlock_cond_irq' - unexpected unlock
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> drivers/watchdog/mtx-1_wdt.c:185:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected long ( *write )( ... ) @@     got long ( * )( ... ) @@
   drivers/watchdog/mtx-1_wdt.c:185:27: sparse:     expected long ( *write )( ... )
   drivers/watchdog/mtx-1_wdt.c:185:27: sparse:     got long ( * )( ... )
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/watchdog/ar7_wdt.c:193:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] <asn:1> *__gu_ptr @@     got char const * @@
   drivers/watchdog/ar7_wdt.c:193:29: sparse:     expected char const [noderef] <asn:1> *__gu_ptr
   drivers/watchdog/ar7_wdt.c:193:29: sparse:     got char const *
   drivers/watchdog/ar7_wdt.c:216:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] <asn:1> *to @@     got struct watchdog_info * @@
   drivers/watchdog/ar7_wdt.c:216:35: sparse:     expected void [noderef] <asn:1> *to
   drivers/watchdog/ar7_wdt.c:216:35: sparse:     got struct watchdog_info *
   drivers/watchdog/ar7_wdt.c:222:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] <asn:1> *__pu_addr @@     got int * @@
   drivers/watchdog/ar7_wdt.c:222:21: sparse:     expected int [noderef] <asn:1> *__pu_addr
   drivers/watchdog/ar7_wdt.c:222:21: sparse:     got int *
   drivers/watchdog/ar7_wdt.c:229:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const [noderef] <asn:1> *__gu_ptr @@     got int * @@
   drivers/watchdog/ar7_wdt.c:229:21: sparse:     expected int const [noderef] <asn:1> *__gu_ptr
   drivers/watchdog/ar7_wdt.c:229:21: sparse:     got int *
   drivers/watchdog/ar7_wdt.c:241:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] <asn:1> *__pu_addr @@     got int * @@
   drivers/watchdog/ar7_wdt.c:241:21: sparse:     expected int [noderef] <asn:1> *__pu_addr
   drivers/watchdog/ar7_wdt.c:241:21: sparse:     got int *
>> drivers/watchdog/ar7_wdt.c:251:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected long ( *write )( ... ) @@     got long ( * )( ... ) @@
   drivers/watchdog/ar7_wdt.c:251:27: sparse:     expected long ( *write )( ... )
   drivers/watchdog/ar7_wdt.c:251:27: sparse:     got long ( * )( ... )
   drivers/watchdog/ar7_wdt.c:270:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ar7_wdt *static [toplevel] ar7_wdt @@     got void [noderef] <asn:2> * @@
   drivers/watchdog/ar7_wdt.c:270:17: sparse:     expected struct ar7_wdt *static [toplevel] ar7_wdt
   drivers/watchdog/ar7_wdt.c:270:17: sparse:     got void [noderef] <asn:2> *
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> drivers/video/fbdev/pmag-aa-fb.c:110:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bt431_regs *regs @@     got struct bt431_regs [noderef] <asn:2> *bt431 @@
   drivers/video/fbdev/pmag-aa-fb.c:110:39: sparse:     expected struct bt431_regs *regs
   drivers/video/fbdev/pmag-aa-fb.c:110:39: sparse:     got struct bt431_regs [noderef] <asn:2> *bt431
   drivers/video/fbdev/pmag-aa-fb.c:115:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bt431_regs *regs @@     got struct bt431_regs [noderef] <asn:2> *bt431 @@
   drivers/video/fbdev/pmag-aa-fb.c:115:39: sparse:     expected struct bt431_regs *regs
   drivers/video/fbdev/pmag-aa-fb.c:115:39: sparse:     got struct bt431_regs [noderef] <asn:2> *bt431
   drivers/video/fbdev/pmag-aa-fb.c:118:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bt431_regs *regs @@     got struct bt431_regs [noderef] <asn:2> *bt431 @@
   drivers/video/fbdev/pmag-aa-fb.c:118:42: sparse:     expected struct bt431_regs *regs
   drivers/video/fbdev/pmag-aa-fb.c:118:42: sparse:     got struct bt431_regs [noderef] <asn:2> *bt431
>> drivers/video/fbdev/pmag-aa-fb.c:124:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bt455_regs *regs @@     got struct bt455_regs [noderef] <asn:2> *bt455 @@
   drivers/video/fbdev/pmag-aa-fb.c:124:43: sparse:     expected struct bt455_regs *regs
   drivers/video/fbdev/pmag-aa-fb.c:124:43: sparse:     got struct bt455_regs [noderef] <asn:2> *bt455
   drivers/video/fbdev/pmag-aa-fb.c:125:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bt455_regs *regs @@     got struct bt455_regs [noderef] <asn:2> *bt455 @@
   drivers/video/fbdev/pmag-aa-fb.c:125:42: sparse:     expected struct bt455_regs *regs
   drivers/video/fbdev/pmag-aa-fb.c:125:42: sparse:     got struct bt455_regs [noderef] <asn:2> *bt455
   drivers/video/fbdev/pmag-aa-fb.c:126:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bt455_regs *regs @@     got struct bt455_regs [noderef] <asn:2> *bt455 @@
   drivers/video/fbdev/pmag-aa-fb.c:126:42: sparse:     expected struct bt455_regs *regs
   drivers/video/fbdev/pmag-aa-fb.c:126:42: sparse:     got struct bt455_regs [noderef] <asn:2> *bt455
   drivers/video/fbdev/pmag-aa-fb.c:129:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bt431_regs *regs @@     got struct bt431_regs [noderef] <asn:2> *bt431 @@
   drivers/video/fbdev/pmag-aa-fb.c:129:37: sparse:     expected struct bt431_regs *regs
   drivers/video/fbdev/pmag-aa-fb.c:129:37: sparse:     got struct bt431_regs [noderef] <asn:2> *bt431
   drivers/video/fbdev/pmag-aa-fb.c:134:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bt431_regs *regs @@     got struct bt431_regs [noderef] <asn:2> *bt431 @@
   drivers/video/fbdev/pmag-aa-fb.c:134:40: sparse:     expected struct bt431_regs *regs
   drivers/video/fbdev/pmag-aa-fb.c:134:40: sparse:     got struct bt431_regs [noderef] <asn:2> *bt431
   drivers/video/fbdev/pmag-aa-fb.c:146:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bt455_regs *regs @@     got struct bt455_regs [noderef] <asn:2> *bt455 @@
   drivers/video/fbdev/pmag-aa-fb.c:146:35: sparse:     expected struct bt455_regs *regs
   drivers/video/fbdev/pmag-aa-fb.c:146:35: sparse:     got struct bt455_regs [noderef] <asn:2> *bt455
   drivers/video/fbdev/pmag-aa-fb.c:212:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bt455_regs *regs @@     got struct bt455_regs [noderef] <asn:2> *bt455 @@
   drivers/video/fbdev/pmag-aa-fb.c:212:35: sparse:     expected struct bt455_regs *regs
   drivers/video/fbdev/pmag-aa-fb.c:212:35: sparse:     got struct bt455_regs [noderef] <asn:2> *bt455
   drivers/video/fbdev/pmag-aa-fb.c:213:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bt455_regs *regs @@     got struct bt455_regs [noderef] <asn:2> *bt455 @@
   drivers/video/fbdev/pmag-aa-fb.c:213:34: sparse:     expected struct bt455_regs *regs
   drivers/video/fbdev/pmag-aa-fb.c:213:34: sparse:     got struct bt455_regs [noderef] <asn:2> *bt455
   drivers/video/fbdev/pmag-aa-fb.c:216:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bt431_regs *regs @@     got struct bt431_regs [noderef] <asn:2> *bt431 @@
   drivers/video/fbdev/pmag-aa-fb.c:216:31: sparse:     expected struct bt431_regs *regs
   drivers/video/fbdev/pmag-aa-fb.c:216:31: sparse:     got struct bt431_regs [noderef] <asn:2> *bt431
   drivers/video/fbdev/pmag-aa-fb.c:217:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bt431_regs *regs @@     got struct bt431_regs [noderef] <asn:2> *bt431 @@
   drivers/video/fbdev/pmag-aa-fb.c:217:30: sparse:     expected struct bt431_regs *regs
   drivers/video/fbdev/pmag-aa-fb.c:217:30: sparse:     got struct bt431_regs [noderef] <asn:2> *bt431
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> arch/mips/dec/kn01-berr.c:104:34: sparse: sparse: cast removes address space '<asn:1>' of expression
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> arch/mips/dec/tc.c:32:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>> arch/mips/dec/tc.c:32:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>> arch/mips/dec/tc.c:32:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>> arch/mips/dec/tc.c:32:16: sparse: sparse: cast removes address space '<asn:2>' of expression
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   arch/mips/kernel/kgdb.c:147:56: sparse: sparse: no member 'fpu' in struct thread_struct
>> arch/mips/kernel/kgdb.c:147:33: sparse: sparse: cast from unknown type
   arch/mips/kernel/kgdb.c:155:48: sparse: sparse: no member 'fpu' in struct thread_struct
   arch/mips/kernel/kgdb.c:155:25: sparse: sparse: cast from unknown type
   arch/mips/kernel/kgdb.c:182:61: sparse: sparse: no member 'fpu' in struct thread_struct
   arch/mips/kernel/kgdb.c:182:38: sparse: sparse: cast from unknown type
   arch/mips/kernel/kgdb.c:191:53: sparse: sparse: no member 'fpu' in struct thread_struct
   arch/mips/kernel/kgdb.c:191:30: sparse: sparse: cast from unknown type

vim +602 drivers/mmc/host/dw_mmc.c

3b2a067b98b45f7a Shawn Lin         2016-09-02  573  
3b2a067b98b45f7a Shawn Lin         2016-09-02  574  static inline int dw_mci_prepare_desc64(struct dw_mci *host,
ec0baaa6b33932a2 Shawn Lin         2016-09-02  575  					 struct mmc_data *data,
f95f3850f7a9e1d4 Will Newton       2011-01-02  576  					 unsigned int sg_len)
f95f3850f7a9e1d4 Will Newton       2011-01-02  577  {
5959b32e3636f9bf Alexey Brodkin    2015-06-25  578  	unsigned int desc_len;
5959b32e3636f9bf Alexey Brodkin    2015-06-25  579  	struct idmac_desc_64addr *desc_first, *desc_last, *desc;
b6d2d81c5c2de6b3 Shawn Lin         2017-02-17  580  	u32 val;
ec0baaa6b33932a2 Shawn Lin         2016-09-02  581  	int i;
5959b32e3636f9bf Alexey Brodkin    2015-06-25  582  
5959b32e3636f9bf Alexey Brodkin    2015-06-25  583  	desc_first = desc_last = desc = host->sg_cpu;
69d99fdcfd7815df Prabu Thangamuthu 2014-10-20  584  
5959b32e3636f9bf Alexey Brodkin    2015-06-25  585  	for (i = 0; i < sg_len; i++) {
69d99fdcfd7815df Prabu Thangamuthu 2014-10-20  586  		unsigned int length = sg_dma_len(&data->sg[i]);
0e3a22c044478b61 Shawn Lin         2015-08-03  587  
69d99fdcfd7815df Prabu Thangamuthu 2014-10-20  588  		u64 mem_addr = sg_dma_address(&data->sg[i]);
69d99fdcfd7815df Prabu Thangamuthu 2014-10-20  589  
5959b32e3636f9bf Alexey Brodkin    2015-06-25  590  		for ( ; length ; desc++) {
5959b32e3636f9bf Alexey Brodkin    2015-06-25  591  			desc_len = (length <= DW_MCI_DESC_DATA_LENGTH) ?
5959b32e3636f9bf Alexey Brodkin    2015-06-25  592  				   length : DW_MCI_DESC_DATA_LENGTH;
5959b32e3636f9bf Alexey Brodkin    2015-06-25  593  
5959b32e3636f9bf Alexey Brodkin    2015-06-25  594  			length -= desc_len;
5959b32e3636f9bf Alexey Brodkin    2015-06-25  595  
3b2a067b98b45f7a Shawn Lin         2016-09-02  596  			/*
3b2a067b98b45f7a Shawn Lin         2016-09-02  597  			 * Wait for the former clear OWN bit operation
3b2a067b98b45f7a Shawn Lin         2016-09-02  598  			 * of IDMAC to make sure that this descriptor
3b2a067b98b45f7a Shawn Lin         2016-09-02  599  			 * isn't still owned by IDMAC as IDMAC's write
3b2a067b98b45f7a Shawn Lin         2016-09-02  600  			 * ops and CPU's read ops are asynchronous.
3b2a067b98b45f7a Shawn Lin         2016-09-02  601  			 */
b6d2d81c5c2de6b3 Shawn Lin         2017-02-17 @602  			if (readl_poll_timeout_atomic(&desc->des0, val,
b6d2d81c5c2de6b3 Shawn Lin         2017-02-17  603  						!(val & IDMAC_DES0_OWN),
b6d2d81c5c2de6b3 Shawn Lin         2017-02-17  604  						10, 100 * USEC_PER_MSEC))
3b2a067b98b45f7a Shawn Lin         2016-09-02  605  				goto err_own_bit;
3b2a067b98b45f7a Shawn Lin         2016-09-02  606  
69d99fdcfd7815df Prabu Thangamuthu 2014-10-20  607  			/*
5959b32e3636f9bf Alexey Brodkin    2015-06-25  608  			 * Set the OWN bit and disable interrupts
5959b32e3636f9bf Alexey Brodkin    2015-06-25  609  			 * for this descriptor
69d99fdcfd7815df Prabu Thangamuthu 2014-10-20  610  			 */
69d99fdcfd7815df Prabu Thangamuthu 2014-10-20  611  			desc->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC |
69d99fdcfd7815df Prabu Thangamuthu 2014-10-20  612  						IDMAC_DES0_CH;
5959b32e3636f9bf Alexey Brodkin    2015-06-25  613  
69d99fdcfd7815df Prabu Thangamuthu 2014-10-20  614  			/* Buffer length */
5959b32e3636f9bf Alexey Brodkin    2015-06-25  615  			IDMAC_64ADDR_SET_BUFFER1_SIZE(desc, desc_len);
69d99fdcfd7815df Prabu Thangamuthu 2014-10-20  616  
69d99fdcfd7815df Prabu Thangamuthu 2014-10-20  617  			/* Physical address to DMA to/from */
69d99fdcfd7815df Prabu Thangamuthu 2014-10-20  618  			desc->des4 = mem_addr & 0xffffffff;
69d99fdcfd7815df Prabu Thangamuthu 2014-10-20  619  			desc->des5 = mem_addr >> 32;
5959b32e3636f9bf Alexey Brodkin    2015-06-25  620  
5959b32e3636f9bf Alexey Brodkin    2015-06-25  621  			/* Update physical address for the next desc */
5959b32e3636f9bf Alexey Brodkin    2015-06-25  622  			mem_addr += desc_len;
5959b32e3636f9bf Alexey Brodkin    2015-06-25  623  
5959b32e3636f9bf Alexey Brodkin    2015-06-25  624  			/* Save pointer to the last descriptor */
5959b32e3636f9bf Alexey Brodkin    2015-06-25  625  			desc_last = desc;
5959b32e3636f9bf Alexey Brodkin    2015-06-25  626  		}
69d99fdcfd7815df Prabu Thangamuthu 2014-10-20  627  	}
69d99fdcfd7815df Prabu Thangamuthu 2014-10-20  628  
69d99fdcfd7815df Prabu Thangamuthu 2014-10-20  629  	/* Set first descriptor */
5959b32e3636f9bf Alexey Brodkin    2015-06-25  630  	desc_first->des0 |= IDMAC_DES0_FD;
69d99fdcfd7815df Prabu Thangamuthu 2014-10-20  631  
69d99fdcfd7815df Prabu Thangamuthu 2014-10-20  632  	/* Set last descriptor */
5959b32e3636f9bf Alexey Brodkin    2015-06-25  633  	desc_last->des0 &= ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
5959b32e3636f9bf Alexey Brodkin    2015-06-25  634  	desc_last->des0 |= IDMAC_DES0_LD;
3b2a067b98b45f7a Shawn Lin         2016-09-02  635  
3b2a067b98b45f7a Shawn Lin         2016-09-02  636  	return 0;
3b2a067b98b45f7a Shawn Lin         2016-09-02  637  err_own_bit:
3b2a067b98b45f7a Shawn Lin         2016-09-02  638  	/* restore the descriptor chain as it's polluted */
26be9d705f44521d Colin Ian King    2016-11-16  639  	dev_dbg(host->dev, "descriptor is still owned by IDMAC.\n");
cc190d4c6499b1b3 Shawn Lin         2016-09-02  640  	memset(host->sg_cpu, 0, DESC_RING_BUF_SZ);
3b2a067b98b45f7a Shawn Lin         2016-09-02  641  	dw_mci_idmac_init(host);
3b2a067b98b45f7a Shawn Lin         2016-09-02  642  	return -EINVAL;
ec0baaa6b33932a2 Shawn Lin         2016-09-02  643  }
69d99fdcfd7815df Prabu Thangamuthu 2014-10-20  644  
ec0baaa6b33932a2 Shawn Lin         2016-09-02  645  
3b2a067b98b45f7a Shawn Lin         2016-09-02  646  static inline int dw_mci_prepare_desc32(struct dw_mci *host,
ec0baaa6b33932a2 Shawn Lin         2016-09-02  647  					 struct mmc_data *data,
ec0baaa6b33932a2 Shawn Lin         2016-09-02  648  					 unsigned int sg_len)
ec0baaa6b33932a2 Shawn Lin         2016-09-02  649  {
ec0baaa6b33932a2 Shawn Lin         2016-09-02  650  	unsigned int desc_len;
5959b32e3636f9bf Alexey Brodkin    2015-06-25  651  	struct idmac_desc *desc_first, *desc_last, *desc;
b6d2d81c5c2de6b3 Shawn Lin         2017-02-17  652  	u32 val;
ec0baaa6b33932a2 Shawn Lin         2016-09-02  653  	int i;
f95f3850f7a9e1d4 Will Newton       2011-01-02  654  
5959b32e3636f9bf Alexey Brodkin    2015-06-25  655  	desc_first = desc_last = desc = host->sg_cpu;
5959b32e3636f9bf Alexey Brodkin    2015-06-25  656  
5959b32e3636f9bf Alexey Brodkin    2015-06-25  657  	for (i = 0; i < sg_len; i++) {
f95f3850f7a9e1d4 Will Newton       2011-01-02  658  		unsigned int length = sg_dma_len(&data->sg[i]);
0e3a22c044478b61 Shawn Lin         2015-08-03  659  
f95f3850f7a9e1d4 Will Newton       2011-01-02  660  		u32 mem_addr = sg_dma_address(&data->sg[i]);
f95f3850f7a9e1d4 Will Newton       2011-01-02  661  
5959b32e3636f9bf Alexey Brodkin    2015-06-25  662  		for ( ; length ; desc++) {
5959b32e3636f9bf Alexey Brodkin    2015-06-25  663  			desc_len = (length <= DW_MCI_DESC_DATA_LENGTH) ?
5959b32e3636f9bf Alexey Brodkin    2015-06-25  664  				   length : DW_MCI_DESC_DATA_LENGTH;
5959b32e3636f9bf Alexey Brodkin    2015-06-25  665  
5959b32e3636f9bf Alexey Brodkin    2015-06-25  666  			length -= desc_len;
5959b32e3636f9bf Alexey Brodkin    2015-06-25  667  
3b2a067b98b45f7a Shawn Lin         2016-09-02  668  			/*
3b2a067b98b45f7a Shawn Lin         2016-09-02  669  			 * Wait for the former clear OWN bit operation
3b2a067b98b45f7a Shawn Lin         2016-09-02  670  			 * of IDMAC to make sure that this descriptor
3b2a067b98b45f7a Shawn Lin         2016-09-02  671  			 * isn't still owned by IDMAC as IDMAC's write
3b2a067b98b45f7a Shawn Lin         2016-09-02  672  			 * ops and CPU's read ops are asynchronous.
3b2a067b98b45f7a Shawn Lin         2016-09-02  673  			 */
b6d2d81c5c2de6b3 Shawn Lin         2017-02-17 @674  			if (readl_poll_timeout_atomic(&desc->des0, val,
b6d2d81c5c2de6b3 Shawn Lin         2017-02-17  675  						      IDMAC_OWN_CLR64(val),
b6d2d81c5c2de6b3 Shawn Lin         2017-02-17  676  						      10,
b6d2d81c5c2de6b3 Shawn Lin         2017-02-17  677  						      100 * USEC_PER_MSEC))
3b2a067b98b45f7a Shawn Lin         2016-09-02  678  				goto err_own_bit;
3b2a067b98b45f7a Shawn Lin         2016-09-02  679  
69d99fdcfd7815df Prabu Thangamuthu 2014-10-20  680  			/*
5959b32e3636f9bf Alexey Brodkin    2015-06-25  681  			 * Set the OWN bit and disable interrupts
5959b32e3636f9bf Alexey Brodkin    2015-06-25  682  			 * for this descriptor
69d99fdcfd7815df Prabu Thangamuthu 2014-10-20  683  			 */
6687c42fa71acd6a Ben Dooks         2015-03-25  684  			desc->des0 = cpu_to_le32(IDMAC_DES0_OWN |
5959b32e3636f9bf Alexey Brodkin    2015-06-25  685  						 IDMAC_DES0_DIC |
5959b32e3636f9bf Alexey Brodkin    2015-06-25  686  						 IDMAC_DES0_CH);
5959b32e3636f9bf Alexey Brodkin    2015-06-25  687  
f95f3850f7a9e1d4 Will Newton       2011-01-02  688  			/* Buffer length */
5959b32e3636f9bf Alexey Brodkin    2015-06-25  689  			IDMAC_SET_BUFFER1_SIZE(desc, desc_len);
f95f3850f7a9e1d4 Will Newton       2011-01-02  690  
f95f3850f7a9e1d4 Will Newton       2011-01-02  691  			/* Physical address to DMA to/from */
6687c42fa71acd6a Ben Dooks         2015-03-25  692  			desc->des2 = cpu_to_le32(mem_addr);
5959b32e3636f9bf Alexey Brodkin    2015-06-25  693  
5959b32e3636f9bf Alexey Brodkin    2015-06-25  694  			/* Update physical address for the next desc */
5959b32e3636f9bf Alexey Brodkin    2015-06-25  695  			mem_addr += desc_len;
5959b32e3636f9bf Alexey Brodkin    2015-06-25  696  
5959b32e3636f9bf Alexey Brodkin    2015-06-25  697  			/* Save pointer to the last descriptor */
5959b32e3636f9bf Alexey Brodkin    2015-06-25  698  			desc_last = desc;
5959b32e3636f9bf Alexey Brodkin    2015-06-25  699  		}
f95f3850f7a9e1d4 Will Newton       2011-01-02  700  	}
f95f3850f7a9e1d4 Will Newton       2011-01-02  701  
f95f3850f7a9e1d4 Will Newton       2011-01-02  702  	/* Set first descriptor */
5959b32e3636f9bf Alexey Brodkin    2015-06-25  703  	desc_first->des0 |= cpu_to_le32(IDMAC_DES0_FD);
f95f3850f7a9e1d4 Will Newton       2011-01-02  704  
f95f3850f7a9e1d4 Will Newton       2011-01-02  705  	/* Set last descriptor */
5959b32e3636f9bf Alexey Brodkin    2015-06-25  706  	desc_last->des0 &= cpu_to_le32(~(IDMAC_DES0_CH |
5959b32e3636f9bf Alexey Brodkin    2015-06-25  707  				       IDMAC_DES0_DIC));
5959b32e3636f9bf Alexey Brodkin    2015-06-25  708  	desc_last->des0 |= cpu_to_le32(IDMAC_DES0_LD);
3b2a067b98b45f7a Shawn Lin         2016-09-02  709  
3b2a067b98b45f7a Shawn Lin         2016-09-02  710  	return 0;
3b2a067b98b45f7a Shawn Lin         2016-09-02  711  err_own_bit:
3b2a067b98b45f7a Shawn Lin         2016-09-02  712  	/* restore the descriptor chain as it's polluted */
26be9d705f44521d Colin Ian King    2016-11-16  713  	dev_dbg(host->dev, "descriptor is still owned by IDMAC.\n");
cc190d4c6499b1b3 Shawn Lin         2016-09-02  714  	memset(host->sg_cpu, 0, DESC_RING_BUF_SZ);
3b2a067b98b45f7a Shawn Lin         2016-09-02  715  	dw_mci_idmac_init(host);
3b2a067b98b45f7a Shawn Lin         2016-09-02  716  	return -EINVAL;
69d99fdcfd7815df Prabu Thangamuthu 2014-10-20  717  }
f95f3850f7a9e1d4 Will Newton       2011-01-02  718  

:::::: The code at line 602 was first introduced by commit
:::::: b6d2d81c5c2de6b3c69da3be9b2044dd008dbe45 mmc: dw_mmc: improve the timeout polling code

:::::: TO: Shawn Lin <shawn.lin@rock-chips.com>
:::::: CC: Ulf Hansson <ulf.hansson@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--cWoXeonUoKmBZSoM
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
8uCS1zVuG0kZS5XOGuz/AT0R4OPgwAEA

--cWoXeonUoKmBZSoM--
