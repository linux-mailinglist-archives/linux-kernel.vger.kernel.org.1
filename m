Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009312A23D5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 05:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgKBExi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 23:53:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:55756 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbgKBExh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 23:53:37 -0500
IronPort-SDR: +5Mz9juVx5Wohoh9eonqMmSJAtOmeeAXiFBxA2aM4PbNyddbgvHAbQJCurTqPXwnFnwgcXyCOM
 qvmIBX76SDHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9792"; a="148117626"
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="gz'50?scan'50,208,50";a="148117626"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2020 20:53:35 -0800
IronPort-SDR: FB3Trso5uxWwDd5KYajBOfdTP39XKiOZai38OEhjknqVvAF162O5WKi0lZ0WSS/+v+P995kp0Q
 8ADbEdxRUYmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="gz'50?scan'50,208,50";a="319948528"
Received: from lkp-server02.sh.intel.com (HELO 5575c2e0dde6) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 01 Nov 2020 20:53:33 -0800
Received: from kbuild by 5575c2e0dde6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kZRqW-00007u-Rt; Mon, 02 Nov 2020 04:53:32 +0000
Date:   Mon, 2 Nov 2020 12:52:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/kernel/cpu/sh3/clock-sh7710.c:26:31: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202011021226.HaDjrM3B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3cea11cd5e3b00d91caf0b4730194039b45c5891
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   9 weeks ago
config: sh-randconfig-s031-20201030 (attached as .config)
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
>> arch/sh/kernel/cpu/sh3/clock-sh7710.c:26:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
>> arch/sh/kernel/cpu/sh3/clock-sh7710.c:26:31: sparse:     expected void const volatile [noderef] __iomem *ptr
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
>> arch/sh/kernel/cpu/sh3/serial-sh7710.c:13:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:13:17: sparse:     got unsigned int
>> arch/sh/kernel/cpu/sh3/serial-sh7710.c:13:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
>> arch/sh/kernel/cpu/sh3/serial-sh7710.c:13:17: sparse:     expected void const volatile [noderef] __iomem *ptr
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
>> drivers/usb/cdns3/drd.c:42:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
>> drivers/usb/cdns3/drd.c:42:31: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:42:31: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:44:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:44:25: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:44:25: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:46:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:46:31: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:46:31: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:48:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:48:25: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:48:25: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:70:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:70:14: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:70:14: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:80:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:80:19: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:80:19: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:113:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:113:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:113:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:122:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:122:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:122:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:138:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:138:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:138:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:142:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:142:15: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:142:15: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:142:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:142:15: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:142:15: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:159:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:159:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:159:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:164:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:164:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:164:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:164:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:164:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:164:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:181:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:181:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:181:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:185:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:185:15: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:185:15: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:185:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:185:15: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:185:15: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:209:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:209:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:209:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:213:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:213:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:213:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:213:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:213:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:213:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:230:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:230:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:230:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:296:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:296:15: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:296:15: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:315:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:315:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:315:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:338:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cdns3_otg_legacy_regs *otg_v0_regs @@     got void [noderef] __iomem *[assigned] regs @@
   drivers/usb/cdns3/drd.c:338:27: sparse:     expected struct cdns3_otg_legacy_regs *otg_v0_regs
   drivers/usb/cdns3/drd.c:338:27: sparse:     got void [noderef] __iomem *[assigned] regs
   drivers/usb/cdns3/drd.c:339:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:339:14: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:339:14: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:342:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cdns3_otg_common_regs *otg_regs @@     got void [noderef] __iomem *[assigned] regs @@
   drivers/usb/cdns3/drd.c:342:32: sparse:     expected struct cdns3_otg_common_regs *otg_regs
   drivers/usb/cdns3/drd.c:342:32: sparse:     got void [noderef] __iomem *[assigned] regs
   drivers/usb/cdns3/drd.c:343:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:343:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:343:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:344:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:344:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:344:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:348:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cdns3_otg_regs *otg_v1_regs @@     got void [noderef] __iomem *[assigned] regs @@
   drivers/usb/cdns3/drd.c:348:35: sparse:     expected struct cdns3_otg_regs *otg_v1_regs
   drivers/usb/cdns3/drd.c:348:35: sparse:     got void [noderef] __iomem *[assigned] regs
   drivers/usb/cdns3/drd.c:351:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:351:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:351:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:352:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:352:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:352:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:352:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:352:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:352:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:357:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:357:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:357:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:379:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:379:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:379:17: sparse:     got restricted __le32 *
--
   drivers/usb/gadget/udc/mv_udc_core.c:66:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] wMaxPacketSize @@     got int @@
   drivers/usb/gadget/udc/mv_udc_core.c:66:33: sparse:     expected restricted __le16 [usertype] wMaxPacketSize
   drivers/usb/gadget/udc/mv_udc_core.c:66:33: sparse:     got int
   drivers/usb/gadget/udc/mv_udc_core.c:366:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buff_ptr0 @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:366:24: sparse:     expected unsigned int [usertype] buff_ptr0
   drivers/usb/gadget/udc/mv_udc_core.c:366:24: sparse:     got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:368:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buff_ptr1 @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:368:24: sparse:     expected unsigned int [usertype] buff_ptr1
   drivers/usb/gadget/udc/mv_udc_core.c:368:24: sparse:     got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:369:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buff_ptr2 @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:369:24: sparse:     expected unsigned int [usertype] buff_ptr2
   drivers/usb/gadget/udc/mv_udc_core.c:369:24: sparse:     got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:370:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buff_ptr3 @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:370:24: sparse:     expected unsigned int [usertype] buff_ptr3
   drivers/usb/gadget/udc/mv_udc_core.c:370:24: sparse:     got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:371:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buff_ptr4 @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:371:24: sparse:     expected unsigned int [usertype] buff_ptr4
   drivers/usb/gadget/udc/mv_udc_core.c:371:24: sparse:     got restricted __le32 [usertype]
>> drivers/usb/gadget/udc/mv_udc_core.c:832:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
>> drivers/usb/gadget/udc/mv_udc_core.c:832:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/gadget/udc/mv_udc_core.c:832:17: sparse:     got unsigned int *
>> drivers/usb/gadget/udc/mv_udc_core.c:832:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
>> drivers/usb/gadget/udc/mv_udc_core.c:832:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/gadget/udc/mv_udc_core.c:832:17: sparse:     got unsigned int *
   drivers/usb/gadget/udc/mv_udc_core.c:1455:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:1455:41: sparse:     expected unsigned short [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:1455:41: sparse:     got restricted __le16 [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:1515:26: sparse: sparse: cast from restricted __le16
   drivers/usb/gadget/udc/mv_udc_core.c:1545:31: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1546:35: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1567:30: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1578:39: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1579:43: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1615:34: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1624:52: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1610:30: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1610:30: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1633:39: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1634:43: sparse: sparse: restricted __le16 degrades to integer

vim +26 arch/sh/kernel/cpu/sh3/clock-sh7710.c

36ddf31b689a8c1 arch/sh/kernel/cpu/sh3/clock-sh7300.c Paul Mundt 2006-01-16  23  
36ddf31b689a8c1 arch/sh/kernel/cpu/sh3/clock-sh7300.c Paul Mundt 2006-01-16  24  static void master_clk_init(struct clk *clk)
36ddf31b689a8c1 arch/sh/kernel/cpu/sh3/clock-sh7300.c Paul Mundt 2006-01-16  25  {
9d56dd3b083a3be arch/sh/kernel/cpu/sh3/clock-sh7710.c Paul Mundt 2010-01-26 @26  	clk->rate *= md_table[__raw_readw(FRQCR) & 0x0007];
36ddf31b689a8c1 arch/sh/kernel/cpu/sh3/clock-sh7300.c Paul Mundt 2006-01-16  27  }
36ddf31b689a8c1 arch/sh/kernel/cpu/sh3/clock-sh7300.c Paul Mundt 2006-01-16  28  

:::::: The code at line 26 was first introduced by commit
:::::: 9d56dd3b083a3bec56e9da35ce07baca81030b03 sh: Mass ctrl_in/outX to __raw_read/writeX conversion.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--mP3DRpeJDSE+ciuQ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--mP3DRpeJDSE+ciuQ--
