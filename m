Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5042B2E8609
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 02:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbhABBub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 20:50:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:43073 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbhABBua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 20:50:30 -0500
IronPort-SDR: J70MPLXFGhRwmA0FlyGVXTYVXIPMAX9kKYjcrlf9TmYBCKvvntS78egzjZ86XUnhpOOrKJP9SF
 8yuLDl1CWh2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9851"; a="163868213"
X-IronPort-AV: E=Sophos;i="5.78,468,1599548400"; 
   d="gz'50?scan'50,208,50";a="163868213"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2021 17:49:47 -0800
IronPort-SDR: Tze9HIIcnHf+WkkM+Xr+0EU17Bm39jl+LFwxOpVUZy0xYzQJLxp0yeMFj/Tu56HGaTDC0W4KFi
 KPyyt+AucCzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,468,1599548400"; 
   d="gz'50?scan'50,208,50";a="360061257"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 01 Jan 2021 17:49:45 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kvW36-0006FC-Ma; Sat, 02 Jan 2021 01:49:44 +0000
Date:   Sat, 2 Jan 2021 09:49:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: drivers/accessibility/speakup/speakup_acntpc.c:262:28: sparse:
 sparse: cast removes address space '__iomem' of expression
Message-ID: <202101020915.w360QYsI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Samuel,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   eda809aef53426d044b519405d25d9da55319b76
commit: 2067fd92d75b6d9085a43caf050bca5d88c491b8 staging/speakup: Move out of staging
date:   5 months ago
config: riscv-randconfig-s031-20210102 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-184-g1b896707-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2067fd92d75b6d9085a43caf050bca5d88c491b8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2067fd92d75b6d9085a43caf050bca5d88c491b8
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> drivers/accessibility/speakup/speakup_acntpc.c:262:28: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/accessibility/speakup/speakup_acntpc.c:262:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/speakup_acntpc.c:262:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/speakup_acntpc.c:262:28: sparse:     got void *
   drivers/accessibility/speakup/speakup_acntpc.c:273:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/speakup_acntpc.c:273:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/speakup_acntpc.c:273:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/speakup_acntpc.c:273:36: sparse:     got void *
   drivers/accessibility/speakup/speakup_acntpc.c: note: in included file (through arch/riscv/include/asm/io.h, include/linux/io.h, drivers/accessibility/speakup/spk_types.h, ...):
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
--
>> drivers/accessibility/speakup/speakup_keypc.c:268:28: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/accessibility/speakup/speakup_keypc.c:268:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/speakup_keypc.c:268:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/speakup_keypc.c:268:28: sparse:     got void *
   drivers/accessibility/speakup/speakup_keypc.c:278:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/speakup_keypc.c:278:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/speakup_keypc.c:278:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/speakup_keypc.c:278:36: sparse:     got void *
   drivers/accessibility/speakup/speakup_keypc.c: note: in included file (through arch/riscv/include/asm/io.h, include/linux/io.h, drivers/accessibility/speakup/spk_types.h, ...):
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
--
>> drivers/accessibility/speakup/serialio.c:139:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/accessibility/speakup/serialio.c:139:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:139:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:139:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:142:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:142:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:142:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:142:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:144:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/accessibility/speakup/serialio.c:144:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:144:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:144:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:145:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:145:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:145:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:145:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:146:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:146:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:146:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:146:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:147:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:147:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:147:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:147:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:148:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:148:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:148:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:148:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:155:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:155:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:155:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:155:16: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:160:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:160:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:160:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:160:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:165:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:165:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:165:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:165:19: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:167:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:167:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:167:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:167:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:87:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:87:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:87:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:87:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:88:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:88:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:88:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:89:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:89:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:89:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:89:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:90:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:90:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:90:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:90:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:93:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:93:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:93:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:93:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:94:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:94:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:94:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:94:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:97:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:97:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:97:13: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:97:13: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:208:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:208:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:208:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:208:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:230:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:230:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:230:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:230:16: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:299:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:299:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:299:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:299:25: sparse:     got void *
   drivers/accessibility/speakup/serialio.c: note: in included file (through arch/riscv/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression

vim +/__iomem +262 drivers/accessibility/speakup/speakup_acntpc.c

c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  246  
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  247  static int synth_probe(struct spk_synth *synth)
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  248  {
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  249  	unsigned int port_val = 0;
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  250  	int i = 0;
8e69a8110686572 drivers/staging/speakup/speakup_acntpc.c Domagoj Trsan       2014-09-09  251  
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  252  	pr_info("Probing for %s.\n", synth->long_name);
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  253  	if (port_forced) {
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  254  		speakup_info.port_tts = port_forced;
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  255  		pr_info("probe forced to %x by kernel command line\n",
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  256  			speakup_info.port_tts);
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  257  		if (synth_request_region(speakup_info.port_tts - 1,
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  258  					 SYNTH_IO_EXTENT)) {
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  259  			pr_warn("sorry, port already reserved\n");
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  260  			return -EBUSY;
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  261  		}
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07 @262  		port_val = inw(speakup_info.port_tts - 1);
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  263  		synth_port_control = speakup_info.port_tts - 1;
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  264  	} else {
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  265  		for (i = 0; synth_portlist[i]; i++) {
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  266  			if (synth_request_region(synth_portlist[i],
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  267  						 SYNTH_IO_EXTENT)) {
bf4a4bacb051c27 drivers/staging/speakup/speakup_acntpc.c Christopher Brannon 2010-10-14  268  				pr_warn
bf4a4bacb051c27 drivers/staging/speakup/speakup_acntpc.c Christopher Brannon 2010-10-14  269  				    ("request_region: failed with 0x%x, %d\n",
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  270  				     synth_portlist[i], SYNTH_IO_EXTENT);
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  271  				continue;
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  272  			}
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  273  			port_val = inw(synth_portlist[i]) & 0xfffc;
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  274  			if (port_val == 0x53fc) {
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  275  				/* 'S' and out&input bits */
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  276  				synth_port_control = synth_portlist[i];
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  277  				speakup_info.port_tts = synth_port_control + 1;
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  278  				break;
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  279  			}
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  280  		}
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  281  	}
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  282  	port_val &= 0xfffc;
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  283  	if (port_val != 0x53fc) {
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  284  		/* 'S' and out&input bits */
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  285  		pr_info("%s: not found\n", synth->long_name);
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  286  		synth_release_region(synth_port_control, SYNTH_IO_EXTENT);
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  287  		synth_port_control = 0;
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  288  		return -ENODEV;
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  289  	}
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  290  	pr_info("%s: %03x-%03x, driver version %s,\n", synth->long_name,
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  291  		synth_port_control, synth_port_control + SYNTH_IO_EXTENT - 1,
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  292  		synth->version);
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  293  	synth->alive = 1;
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  294  	return 0;
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  295  }
c6e3fd22cd53836 drivers/staging/speakup/speakup_acntpc.c William Hubbs       2010-10-07  296  

:::::: The code at line 262 was first introduced by commit
:::::: c6e3fd22cd538365bfeb82997d5b89562e077d42 Staging: add speakup to the staging directory

:::::: TO: William Hubbs <w.d.hubbs@gmail.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--7AUc2qLy4jB3hD7Z
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--7AUc2qLy4jB3hD7Z--
