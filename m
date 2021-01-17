Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44272F94D8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 20:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbhAQTW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 14:22:59 -0500
Received: from mga12.intel.com ([192.55.52.136]:14477 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730092AbhAQTTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 14:19:02 -0500
IronPort-SDR: I1JDQ1dZdrbrQ65ulgkK8iwPsqmaZkjcaBg198zKjiMPNyJssN4QGLOCad48jg9RmzwA577nkH
 XZrYUNDI19ng==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="157911348"
X-IronPort-AV: E=Sophos;i="5.79,354,1602572400"; 
   d="gz'50?scan'50,208,50";a="157911348"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2021 11:17:51 -0800
IronPort-SDR: bzz8opHgTx0HD8TYR5ezvhyjLSRTxfcUc8K9acY2V+zndhW7b7s2brrSlevCWgmLY+S1PwmT2u
 g3xYb3Wi+gvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,354,1602572400"; 
   d="gz'50?scan'50,208,50";a="466149097"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jan 2021 11:17:50 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l1DYb-0003lD-G4; Sun, 17 Jan 2021 19:17:49 +0000
Date:   Mon, 18 Jan 2021 03:17:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/kernel/cpu/sh2a/setup-sh7201.c:414:9: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202101180326.cl0xWbfo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0da0a8a0a0e1845f495431c3d8d733d2bbf9e9e5
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   5 months ago
config: sh-randconfig-s031-20210118 (attached as .config)
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
>> arch/sh/kernel/cpu/sh2a/setup-sh7201.c:414:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/setup-sh7201.c:414:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/setup-sh7201.c:414:9: sparse:     got unsigned int
>> arch/sh/kernel/cpu/sh2a/setup-sh7201.c:414:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/setup-sh7201.c:414:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/setup-sh7201.c:414:9: sparse:     got unsigned int
--
>> arch/sh/kernel/cpu/sh2a/clock-sh7201.c:27:26: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/clock-sh7201.c:27:26: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/clock-sh7201.c:27:26: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh2a/clock-sh7201.c:36:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/clock-sh7201.c:36:20: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/clock-sh7201.c:36:20: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh2a/clock-sh7201.c:46:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/clock-sh7201.c:46:20: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/clock-sh7201.c:46:20: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh2a/clock-sh7201.c:56:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/clock-sh7201.c:56:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/clock-sh7201.c:56:21: sparse:     got unsigned int
--
   fs/gfs2/file.c:306:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *ptr @@
   fs/gfs2/file.c:306:13: sparse:     expected unsigned int const *__gu_addr
   fs/gfs2/file.c:306:13: sparse:     got unsigned int [noderef] [usertype] __user *ptr
>> fs/gfs2/file.c:306:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   fs/gfs2/file.c:306:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/gfs2/file.c:306:13: sparse:     got unsigned int const *__gu_addr
--
   fs/udf/file.c:207:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long const *__gu_addr @@     got long [noderef] __user * @@
   fs/udf/file.c:207:21: sparse:     expected long const *__gu_addr
   fs/udf/file.c:207:21: sparse:     got long [noderef] __user *
>> fs/udf/file.c:207:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long const *__gu_addr @@
   fs/udf/file.c:207:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/udf/file.c:207:21: sparse:     got long const *__gu_addr
--
   block/bsg.c:336:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *uarg @@
   block/bsg.c:336:13: sparse:     expected int const *__gu_addr
   block/bsg.c:336:13: sparse:     got int [noderef] __user *uarg
>> block/bsg.c:336:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   block/bsg.c:336:13: sparse:     expected void const volatile [noderef] __user *ptr
   block/bsg.c:336:13: sparse:     got int const *__gu_addr
--
>> drivers/mmc/host/dw_mmc.c:602:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/mmc/host/dw_mmc.c:602:29: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/mmc/host/dw_mmc.c:602:29: sparse:     got unsigned int *
>> drivers/mmc/host/dw_mmc.c:602:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/mmc/host/dw_mmc.c:602:29: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/mmc/host/dw_mmc.c:602:29: sparse:     got unsigned int *
   drivers/mmc/host/dw_mmc.c:615:25: sparse: sparse: restricted __le32 degrades to integer
   drivers/mmc/host/dw_mmc.c:615:25: sparse: sparse: restricted __le32 degrades to integer
>> drivers/mmc/host/dw_mmc.c:674:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/mmc/host/dw_mmc.c:674:29: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/mmc/host/dw_mmc.c:674:29: sparse:     got restricted __le32 *
   drivers/mmc/host/dw_mmc.c:674:29: sparse: sparse: restricted __le32 degrades to integer
>> drivers/mmc/host/dw_mmc.c:674:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/mmc/host/dw_mmc.c:674:29: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/mmc/host/dw_mmc.c:674:29: sparse:     got restricted __le32 *
   drivers/mmc/host/dw_mmc.c:674:29: sparse: sparse: restricted __le32 degrades to integer
--
   drivers/scsi/sg.c:415:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/scsi/sg.c:415:21: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:415:21: sparse:     got int [noderef] __user *
>> drivers/scsi/sg.c:415:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:415:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:415:21: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:419:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/scsi/sg.c:419:32: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:419:32: sparse:     got int [noderef] __user *
   drivers/scsi/sg.c:419:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:419:32: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:419:32: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:425:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] __user * @@
   drivers/scsi/sg.c:425:32: sparse:     expected signed int const *__gu_addr
   drivers/scsi/sg.c:425:32: sparse:     got signed int [noderef] __user *
>> drivers/scsi/sg.c:425:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int const *__gu_addr @@
   drivers/scsi/sg.c:425:32: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:425:32: sparse:     got signed int const *__gu_addr
   drivers/scsi/sg.c:431:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/scsi/sg.c:431:32: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:431:32: sparse:     got int [noderef] __user *
   drivers/scsi/sg.c:431:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:431:32: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:431:32: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:638:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user *[assigned] buf @@
   drivers/scsi/sg.c:638:13: sparse:     expected char const *__gu_addr
   drivers/scsi/sg.c:638:13: sparse:     got char const [noderef] __user *[assigned] buf
>> drivers/scsi/sg.c:638:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   drivers/scsi/sg.c:638:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:638:13: sparse:     got char const *__gu_addr
   drivers/scsi/sg.c:955:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ip @@
   drivers/scsi/sg.c:955:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:955:26: sparse:     got int [noderef] __user *ip
   drivers/scsi/sg.c:955:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:955:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:955:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:998:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ip @@
   drivers/scsi/sg.c:998:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:998:26: sparse:     got int [noderef] __user *ip
   drivers/scsi/sg.c:998:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:998:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:998:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:1026:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ip @@
   drivers/scsi/sg.c:1026:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:1026:26: sparse:     got int [noderef] __user *ip
   drivers/scsi/sg.c:1026:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:1026:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:1026:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:1051:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ip @@
   drivers/scsi/sg.c:1051:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:1051:26: sparse:     got int [noderef] __user *ip
   drivers/scsi/sg.c:1051:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:1051:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:1051:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:1059:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ip @@
   drivers/scsi/sg.c:1059:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:1059:26: sparse:     got int [noderef] __user *ip
   drivers/scsi/sg.c:1059:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:1059:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:1059:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:1067:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ip @@
   drivers/scsi/sg.c:1067:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:1067:26: sparse:     got int [noderef] __user *ip
   drivers/scsi/sg.c:1067:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:1067:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:1067:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:1111:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ip @@
   drivers/scsi/sg.c:1111:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:1111:26: sparse:     got int [noderef] __user *ip
   drivers/scsi/sg.c:1111:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:1111:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:1111:26: sparse:     got int const *__gu_addr
--
   drivers/watchdog/kempld_wdt.c:349:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/kempld_wdt.c:349:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/kempld_wdt.c:349:21: sparse:     got int [noderef] __user *p
>> drivers/watchdog/kempld_wdt.c:349:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/kempld_wdt.c:349:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/kempld_wdt.c:349:21: sparse:     got int const *__gu_addr
--
   drivers/watchdog/mv64x60_wdt.c:163:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   drivers/watchdog/mv64x60_wdt.c:163:37: sparse:     expected char const *__gu_addr
   drivers/watchdog/mv64x60_wdt.c:163:37: sparse:     got char const [noderef] __user *
>> drivers/watchdog/mv64x60_wdt.c:163:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   drivers/watchdog/mv64x60_wdt.c:163:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/mv64x60_wdt.c:163:37: sparse:     got char const *__gu_addr
   drivers/watchdog/mv64x60_wdt.c:206:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/watchdog/mv64x60_wdt.c:206:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/mv64x60_wdt.c:206:21: sparse:     got int [noderef] __user *
>> drivers/watchdog/mv64x60_wdt.c:206:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/mv64x60_wdt.c:206:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/mv64x60_wdt.c:206:21: sparse:     got int const *__gu_addr
   drivers/watchdog/mv64x60_wdt.c:222:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/watchdog/mv64x60_wdt.c:222:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/mv64x60_wdt.c:222:21: sparse:     got int [noderef] __user *
   drivers/watchdog/mv64x60_wdt.c:222:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/mv64x60_wdt.c:222:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/mv64x60_wdt.c:222:21: sparse:     got int const *__gu_addr

vim +414 arch/sh/kernel/cpu/sh2a/setup-sh7201.c

da107c6ef919b3af Magnus Damm 2009-04-30  410  
da107c6ef919b3af Magnus Damm 2009-04-30  411  void __init plat_early_device_setup(void)
da107c6ef919b3af Magnus Damm 2009-04-30  412  {
da107c6ef919b3af Magnus Damm 2009-04-30  413  	/* enable MTU2 clock */
da107c6ef919b3af Magnus Damm 2009-04-30 @414  	__raw_writeb(__raw_readb(STBCR3) & ~0x20, STBCR3);

:::::: The code at line 414 was first introduced by commit
:::::: da107c6ef919b3afd9c9b405a4f71e03b5725b04 sh: sh2a MTU2 platform data

:::::: TO: Magnus Damm <damm@igel.co.jp>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--liOOAslEiF7prFVr
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--liOOAslEiF7prFVr--
