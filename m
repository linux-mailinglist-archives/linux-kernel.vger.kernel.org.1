Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC3B29D63E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbgJ1WND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:13:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:56020 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730811AbgJ1WMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:12:23 -0400
IronPort-SDR: lFw6YXd0vrTXuBJQEwAOG298V8YAsWBLhsaK6PM+U/c9yIfRn9GS7N6OFnz/8PyAh2GrMjl+4K
 0YChUJsWKgTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="229984643"
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="gz'50?scan'50,208,50";a="229984643"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 15:12:15 -0700
IronPort-SDR: WmsuxYV0N4JsdwDCncbegnXEp5/Tqc1syt+Z5v1pDFjKSaxnAZX1RjRRc86nxzz2fKYH9dFC4Z
 4c0e2BPL0ZLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="gz'50?scan'50,208,50";a="526497224"
Received: from lkp-server02.sh.intel.com (HELO 0471ce7c9af6) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 28 Oct 2020 15:12:13 -0700
Received: from kbuild by 0471ce7c9af6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kXtfx-0000Cw-22; Wed, 28 Oct 2020 22:12:13 +0000
Date:   Thu, 29 Oct 2020 06:11:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/kernel/cpu/sh2a/setup-sh7201.c:414:9: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202010290623.AdkYeaxA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ed8780e3f2ecc82645342d070c6b4e530532e680
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   9 weeks ago
config: sh-randconfig-s031-20201028 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-56-gc09e8239-dirty
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
>> arch/sh/kernel/cpu/sh2a/setup-sh7201.c:414:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/setup-sh7201.c:414:9: sparse:     got unsigned int
>> arch/sh/kernel/cpu/sh2a/setup-sh7201.c:414:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
>> arch/sh/kernel/cpu/sh2a/setup-sh7201.c:414:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/setup-sh7201.c:414:9: sparse:     got unsigned int
--
>> arch/sh/kernel/cpu/sh2a/clock-sh7201.c:27:26: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
>> arch/sh/kernel/cpu/sh2a/clock-sh7201.c:27:26: sparse:     expected void const volatile [noderef] __iomem *ptr
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
   fs/f2fs/file.c:48:54: sparse: sparse: cast from restricted vm_fault_t
   fs/f2fs/file.c:1975:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/f2fs/file.c:1975:13: sparse:     expected int const *__gu_addr
   fs/f2fs/file.c:1975:13: sparse:     got int [noderef] __user *
>> fs/f2fs/file.c:1975:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> fs/f2fs/file.c:1975:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:1975:13: sparse:     got int const *__gu_addr
   fs/f2fs/file.c:2229:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   fs/f2fs/file.c:2229:13: sparse:     expected unsigned int const *__gu_addr
   fs/f2fs/file.c:2229:13: sparse:     got unsigned int [noderef] [usertype] __user *
>> fs/f2fs/file.c:2229:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   fs/f2fs/file.c:2229:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:2229:13: sparse:     got unsigned int const *__gu_addr
   fs/f2fs/file.c:2466:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   fs/f2fs/file.c:2466:13: sparse:     expected unsigned int const *__gu_addr
   fs/f2fs/file.c:2466:13: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/f2fs/file.c:2466:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   fs/f2fs/file.c:2466:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:2466:13: sparse:     got unsigned int const *__gu_addr
   fs/f2fs/file.c:3226:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   fs/f2fs/file.c:3226:13: sparse:     expected unsigned int const *__gu_addr
   fs/f2fs/file.c:3226:13: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/f2fs/file.c:3226:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   fs/f2fs/file.c:3226:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:3226:13: sparse:     got unsigned int const *__gu_addr
   fs/f2fs/file.c:3379:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const [usertype] *pwcs @@     got restricted __le16 * @@
   fs/f2fs/file.c:3379:36: sparse:     expected unsigned short const [usertype] *pwcs
   fs/f2fs/file.c:3379:36: sparse:     got restricted __le16 *
   fs/f2fs/file.c:3415:28: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned short [usertype] *pwcs @@     got restricted __le16 * @@
   fs/f2fs/file.c:3415:28: sparse:     expected unsigned short [usertype] *pwcs
   fs/f2fs/file.c:3415:28: sparse:     got restricted __le16 *
--
   fs/jfs/jfs_debug.c:36:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user *buffer @@
   fs/jfs/jfs_debug.c:36:13: sparse:     expected char const *__gu_addr
   fs/jfs/jfs_debug.c:36:13: sparse:     got char const [noderef] __user *buffer
>> fs/jfs/jfs_debug.c:36:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
>> fs/jfs/jfs_debug.c:36:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/jfs/jfs_debug.c:36:13: sparse:     got char const *__gu_addr
--
   fs/nilfs2/ioctl.c:138:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/nilfs2/ioctl.c:138:13: sparse:     expected int const *__gu_addr
   fs/nilfs2/ioctl.c:138:13: sparse:     got int [noderef] __user *
>> fs/nilfs2/ioctl.c:138:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> fs/nilfs2/ioctl.c:138:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/nilfs2/ioctl.c:138:13: sparse:     got int const *__gu_addr
--
   block/bsg.c:336:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *uarg @@
   block/bsg.c:336:13: sparse:     expected int const *__gu_addr
   block/bsg.c:336:13: sparse:     got int [noderef] __user *uarg
>> block/bsg.c:336:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> block/bsg.c:336:13: sparse:     expected void const volatile [noderef] __user *ptr
   block/bsg.c:336:13: sparse:     got int const *__gu_addr
--
   drivers/net/ppp/ppp_generic.c:925:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     got int [noderef] __user *p
>> drivers/net/ppp/ppp_generic.c:925:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> drivers/net/ppp/ppp_generic.c:925:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:939:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:939:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:954:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:954:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:651:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:651:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:681:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:681:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:688:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:688:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:726:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:726:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:755:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:755:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:823:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:823:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     got int const *__gu_addr
--
   drivers/net/ppp/pppoe.c:765:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/net/ppp/pppoe.c:765:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/pppoe.c:765:21: sparse:     got int [noderef] __user *
>> drivers/net/ppp/pppoe.c:765:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> drivers/net/ppp/pppoe.c:765:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/pppoe.c:765:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/pppoe.c:778:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/net/ppp/pppoe.c:778:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/pppoe.c:778:21: sparse:     got int [noderef] __user *
   drivers/net/ppp/pppoe.c:778:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/pppoe.c:778:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/pppoe.c:778:21: sparse:     got int const *__gu_addr
--
   drivers/scsi/scsi_ioctl.c:48:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/scsi/scsi_ioctl.c:48:21: sparse:     expected unsigned int const *__gu_addr
   drivers/scsi/scsi_ioctl.c:48:21: sparse:     got unsigned int [noderef] __user *
>> drivers/scsi/scsi_ioctl.c:48:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
>> drivers/scsi/scsi_ioctl.c:48:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_ioctl.c:48:21: sparse:     got unsigned int const *__gu_addr
--
   drivers/scsi/scsi_error.c:2341:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *arg @@
   drivers/scsi/scsi_error.c:2341:17: sparse:     expected int const *__gu_addr
   drivers/scsi/scsi_error.c:2341:17: sparse:     got int [noderef] __user *arg
>> drivers/scsi/scsi_error.c:2341:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> drivers/scsi/scsi_error.c:2341:17: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_error.c:2341:17: sparse:     got int const *__gu_addr
--
   drivers/scsi/sg.c:415:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/scsi/sg.c:415:21: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:415:21: sparse:     got int [noderef] __user *
>> drivers/scsi/sg.c:415:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> drivers/scsi/sg.c:415:21: sparse:     expected void const volatile [noderef] __user *ptr
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
   net/ax25/af_ax25.c:695:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ax25/af_ax25.c:695:13: sparse:     expected int const *__gu_addr
   net/ax25/af_ax25.c:695:13: sparse:     got int [noderef] __user *optlen
>> net/ax25/af_ax25.c:695:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> net/ax25/af_ax25.c:695:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ax25/af_ax25.c:695:13: sparse:     got int const *__gu_addr
   net/ax25/af_ax25.c:1742:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long const *__gu_addr @@     got long [noderef] __user * @@
   net/ax25/af_ax25.c:1742:21: sparse:     expected long const *__gu_addr
   net/ax25/af_ax25.c:1742:21: sparse:     got long [noderef] __user *
>> net/ax25/af_ax25.c:1742:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long const *__gu_addr @@
   net/ax25/af_ax25.c:1742:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ax25/af_ax25.c:1742:21: sparse:     got long const *__gu_addr
--
   net/can/raw.c:659:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/can/raw.c:659:13: sparse:     expected int const *__gu_addr
   net/can/raw.c:659:13: sparse:     got int [noderef] __user *optlen
>> net/can/raw.c:659:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> net/can/raw.c:659:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/can/raw.c:659:13: sparse:     got int const *__gu_addr
--
   net/can/j1939/socket.c:748:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/can/j1939/socket.c:748:13: sparse:     expected int const *__gu_addr
   net/can/j1939/socket.c:748:13: sparse:     got int [noderef] __user *optlen
>> net/can/j1939/socket.c:748:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> net/can/j1939/socket.c:748:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/can/j1939/socket.c:748:13: sparse:     got int const *__gu_addr
--
   net/rose/af_rose.c:438:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/rose/af_rose.c:438:13: sparse:     expected int const *__gu_addr
   net/rose/af_rose.c:438:13: sparse:     got int [noderef] __user *optlen
>> net/rose/af_rose.c:438:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> net/rose/af_rose.c:438:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/rose/af_rose.c:438:13: sparse:     got int const *__gu_addr
--
   drivers/staging/greybus/fw-management.c:493:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/staging/greybus/fw-management.c:493:21: sparse:     expected unsigned int const *__gu_addr
   drivers/staging/greybus/fw-management.c:493:21: sparse:     got unsigned int [noderef] __user *
>> drivers/staging/greybus/fw-management.c:493:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
>> drivers/staging/greybus/fw-management.c:493:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/staging/greybus/fw-management.c:493:21: sparse:     got unsigned int const *__gu_addr
--
   drivers/vhost/vdpa.c:361:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/vhost/vdpa.c:361:13: sparse:     expected unsigned int const *__gu_addr
   drivers/vhost/vdpa.c:361:13: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/vhost/vdpa.c:361:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
>> drivers/vhost/vdpa.c:361:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vhost/vdpa.c:361:13: sparse:     got unsigned int const *__gu_addr
--
   drivers/vhost/vhost.c:1571:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *idxp @@
   drivers/vhost/vhost.c:1571:13: sparse:     expected unsigned int const *__gu_addr
   drivers/vhost/vhost.c:1571:13: sparse:     got unsigned int [noderef] [usertype] __user *idxp
>> drivers/vhost/vhost.c:1571:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
>> drivers/vhost/vhost.c:1571:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vhost/vhost.c:1571:13: sparse:     got unsigned int const *__gu_addr
   drivers/vhost/vhost.c:1771:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/vhost/vhost.c:1771:21: sparse:     expected int const *__gu_addr
   drivers/vhost/vhost.c:1771:21: sparse:     got int [noderef] __user *
>> drivers/vhost/vhost.c:1771:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/vhost/vhost.c:1771:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vhost/vhost.c:1771:21: sparse:     got int const *__gu_addr

vim +414 arch/sh/kernel/cpu/sh2a/setup-sh7201.c

da107c6ef919b3 Magnus Damm 2009-04-30  410  
da107c6ef919b3 Magnus Damm 2009-04-30  411  void __init plat_early_device_setup(void)
da107c6ef919b3 Magnus Damm 2009-04-30  412  {
da107c6ef919b3 Magnus Damm 2009-04-30  413  	/* enable MTU2 clock */
da107c6ef919b3 Magnus Damm 2009-04-30 @414  	__raw_writeb(__raw_readb(STBCR3) & ~0x20, STBCR3);

:::::: The code at line 414 was first introduced by commit
:::::: da107c6ef919b3afd9c9b405a4f71e03b5725b04 sh: sh2a MTU2 platform data

:::::: TO: Magnus Damm <damm@igel.co.jp>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Dxnq1zWXvFF0Q93v
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--Dxnq1zWXvFF0Q93v--
