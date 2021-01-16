Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536EE2F8CD6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 11:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbhAPKh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 05:37:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:34617 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbhAPKh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 05:37:57 -0500
IronPort-SDR: qrYysdTZ2s/l/nKHHCDoSfIw2iSROPul2YkB62WBxw1SYex5fxyCoyLPDSdz8qP/y6rFsgceYC
 IGDX4hZWwISg==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="175152646"
X-IronPort-AV: E=Sophos;i="5.79,352,1602572400"; 
   d="gz'50?scan'50,208,50";a="175152646"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2021 02:37:15 -0800
IronPort-SDR: aNNb2jjiV2vjTGragb9UcE7pxKWAK9FqJ508/3eneIQjBggU+3QI9MuxD/W6sqJmTn3Wp1PZRf
 LXl2CBk6M64A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,352,1602572400"; 
   d="gz'50?scan'50,208,50";a="382963990"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 16 Jan 2021 02:37:12 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l0ixE-0000rN-66; Sat, 16 Jan 2021 10:37:12 +0000
Date:   Sat, 16 Jan 2021 18:36:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/loongson2ef/common/reset.c:20:11: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <202101161842.2iRBZKeR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jiaxun,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1d94330a437a573cfdf848f6743b1ed169242c8a
commit: b13812ddea615b6507beef24f76540c0c1143c5c MIPS: Loongson2ef: Disable Loongson MMI instructions
date:   4 months ago
config: mips-randconfig-s032-20210116 (attached as .config)
compiler: mips64el-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-208-g46a52ca4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b13812ddea615b6507beef24f76540c0c1143c5c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b13812ddea615b6507beef24f76540c0c1143c5c
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
>> arch/mips/loongson2ef/common/reset.c:20:11: sparse: sparse: cast removes address space '__iomem' of expression
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
>> sound/pci/mixart/mixart_core.c:41:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:41:19: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:41:19: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:41:19: sparse: sparse: cast to restricted __be32
>> sound/pci/mixart/mixart_core.c:41:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:41:19: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:41:19: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:41:19: sparse: sparse: cast to restricted __be32
>> sound/pci/mixart/mixart_core.c:41:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:41:19: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:41:19: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:41:19: sparse: sparse: cast to restricted __be32
>> sound/pci/mixart/mixart_core.c:41:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:41:19: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:41:19: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:41:19: sparse: sparse: cast to restricted __be32
>> sound/pci/mixart/mixart_core.c:41:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:41:19: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:41:19: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:41:19: sparse: sparse: cast to restricted __be32
>> sound/pci/mixart/mixart_core.c:41:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:41:19: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:41:19: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:41:19: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:42:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:42:19: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:42:19: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:42:19: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:42:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:42:19: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:42:19: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:42:19: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:42:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:42:19: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:42:19: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:42:19: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:42:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:42:19: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:42:19: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:42:19: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:42:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:42:19: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:42:19: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:42:19: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:42:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:42:19: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:42:19: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:42:19: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:52:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:52:22: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:52:22: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:52:22: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:52:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:52:22: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:52:22: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:52:22: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:52:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:52:22: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:52:22: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:52:22: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:52:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:52:22: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:52:22: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:52:22: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:52:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:52:22: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:52:22: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:52:22: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:52:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:52:22: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:52:22: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:52:22: sparse: sparse: cast to restricted __be32
>> sound/pci/mixart/mixart_core.c:58:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_core.c:58:9: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_core.c:58:9: sparse:     got restricted __be32 [usertype]
>> sound/pci/mixart/mixart_core.c:58:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:58:9: sparse:     expected void volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:58:9: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:77:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:77:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:77:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:77:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:77:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:77:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:77:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:77:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:77:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:77:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:77:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:77:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:77:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:77:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:77:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:77:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:77:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:77:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:77:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:77:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:77:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:77:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:77:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:77:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:78:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:78:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:78:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:78:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:78:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:78:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:78:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:78:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:78:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:78:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:78:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:78:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:78:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:78:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:78:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:78:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:78:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:78:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:78:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:78:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:78:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:78:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:78:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:78:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:79:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:79:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:79:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:79:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:79:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:79:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:79:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:79:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:79:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:79:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:79:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:79:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:79:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:79:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:79:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:79:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:79:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:79:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:79:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:79:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:79:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:79:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:79:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:79:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:80:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:80:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:80:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:80:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:80:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:80:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:80:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:80:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:80:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:80:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:80:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:80:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:80:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:80:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:80:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:80:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:80:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:80:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:80:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:80:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:80:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:80:32: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_core.c:80:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:80:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:104:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:104:19: sparse:     expected void const volatile [noderef] __iomem *mem
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
>> sound/pci/mixart/mixart_hwdep.c:45:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:45:24: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:45:24: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:45:24: sparse: sparse: cast to restricted __be32
>> sound/pci/mixart/mixart_hwdep.c:45:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:45:24: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:45:24: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:45:24: sparse: sparse: cast to restricted __be32
>> sound/pci/mixart/mixart_hwdep.c:45:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:45:24: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:45:24: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:45:24: sparse: sparse: cast to restricted __be32
>> sound/pci/mixart/mixart_hwdep.c:45:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:45:24: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:45:24: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:45:24: sparse: sparse: cast to restricted __be32
>> sound/pci/mixart/mixart_hwdep.c:45:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:45:24: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:45:24: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:45:24: sparse: sparse: cast to restricted __be32
>> sound/pci/mixart/mixart_hwdep.c:45:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:45:24: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:45:24: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:45:24: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:339:25: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:341:22: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:343:25: sparse: sparse: cast to restricted __be32
>> sound/pci/mixart/mixart_hwdep.c:374:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:374:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:374:17: sparse:     got restricted __be32 [usertype]
>> sound/pci/mixart/mixart_hwdep.c:374:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:374:17: sparse:     expected void volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:374:17: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:377:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:377:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:377:17: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_hwdep.c:377:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:377:17: sparse:     expected void volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:377:17: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:379:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:379:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:379:17: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_hwdep.c:379:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:379:17: sparse:     expected void volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:379:17: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:385:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:385:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:385:17: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_hwdep.c:385:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:385:17: sparse:     expected void volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:385:17: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:414:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:414:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:414:17: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_hwdep.c:414:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:414:17: sparse:     expected void volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:414:17: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:415:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:415:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:415:17: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_hwdep.c:415:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:415:17: sparse:     expected void volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:415:17: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:418:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:418:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:418:17: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_hwdep.c:418:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:418:17: sparse:     expected void volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:418:17: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:425:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:425:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:425:17: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_hwdep.c:425:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:425:17: sparse:     expected void volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:425:17: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:435:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:435:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:435:17: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_hwdep.c:435:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:435:17: sparse:     expected void volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:435:17: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:457:57: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:481:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:481:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:481:17: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_hwdep.c:481:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:481:17: sparse:     expected void volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:481:17: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:484:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:484:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:484:17: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_hwdep.c:484:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:484:17: sparse:     expected void volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:484:17: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:494:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:494:23: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:494:23: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:494:23: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:494:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:494:23: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:494:23: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:494:23: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:494:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:494:23: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart_hwdep.c:494:23: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:494:23: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:494:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:494:23: sparse:     expected void const volatile [noderef] __iomem *mem
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
>> sound/pci/mixart/mixart.c:1187:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1187:23: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1187:23: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1187:23: sparse: sparse: cast to restricted __be32
>> sound/pci/mixart/mixart.c:1187:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1187:23: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1187:23: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1187:23: sparse: sparse: cast to restricted __be32
>> sound/pci/mixart/mixart.c:1187:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1187:23: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1187:23: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1187:23: sparse: sparse: cast to restricted __be32
>> sound/pci/mixart/mixart.c:1187:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1187:23: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1187:23: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1187:23: sparse: sparse: cast to restricted __be32
>> sound/pci/mixart/mixart.c:1187:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1187:23: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1187:23: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1187:23: sparse: sparse: cast to restricted __be32
>> sound/pci/mixart/mixart.c:1187:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1187:23: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1187:23: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1187:23: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart.c:1190:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1190:47: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1190:47: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1190:47: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart.c:1190:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1190:47: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1190:47: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1190:47: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart.c:1190:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1190:47: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1190:47: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1190:47: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart.c:1190:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1190:47: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1190:47: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1190:47: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart.c:1190:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1190:47: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1190:47: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1190:47: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart.c:1190:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1190:47: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1190:47: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1190:47: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart.c:1191:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1191:47: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1191:47: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1191:47: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart.c:1191:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1191:47: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1191:47: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1191:47: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart.c:1191:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1191:47: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1191:47: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1191:47: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart.c:1191:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1191:47: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1191:47: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1191:47: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart.c:1191:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1191:47: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1191:47: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1191:47: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart.c:1191:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1191:47: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1191:47: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1191:47: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart.c:1192:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1192:47: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1192:47: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1192:47: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart.c:1192:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1192:47: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1192:47: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1192:47: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart.c:1192:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1192:47: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1192:47: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1192:47: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart.c:1192:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1192:47: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1192:47: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1192:47: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart.c:1192:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1192:47: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1192:47: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1192:47: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart.c:1192:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1192:47: sparse:     expected void const volatile [noderef] __iomem *mem
   sound/pci/mixart/mixart.c:1192:47: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1192:47: sparse: sparse: cast to restricted __be32
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
>> arch/mips/pci/ops-loongson2.c:93:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   arch/mips/pci/ops-loongson2.c:93:24: sparse:     expected unsigned int [usertype] val
   arch/mips/pci/ops-loongson2.c:93:24: sparse:     got restricted __le32 [usertype]
>> arch/mips/pci/ops-loongson2.c:93:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *[assigned] addrp @@
   arch/mips/pci/ops-loongson2.c:93:44: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/pci/ops-loongson2.c:93:44: sparse:     got void *[assigned] addrp
>> arch/mips/pci/ops-loongson2.c:95:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void *[assigned] addrp @@
   arch/mips/pci/ops-loongson2.c:95:25: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/pci/ops-loongson2.c:95:25: sparse:     got void *[assigned] addrp
>> arch/mips/pci/ops-loongson2.c:95:25: sparse: sparse: cast to restricted __le32

vim +/__iomem +20 arch/mips/loongson2ef/common/reset.c

71e2f4dd5a65bd8d Jiaxun Yang       2019-10-20  16  
71e2f4dd5a65bd8d Jiaxun Yang       2019-10-20  17  static inline void loongson_reboot(void)
71e2f4dd5a65bd8d Jiaxun Yang       2019-10-20  18  {
71e2f4dd5a65bd8d Jiaxun Yang       2019-10-20  19  #ifndef CONFIG_CPU_JUMP_WORKAROUNDS
4bdc0d676a643140 Christoph Hellwig 2020-01-06 @20  	((void (*)(void))ioremap(LOONGSON_BOOT_BASE, 4)) ();
71e2f4dd5a65bd8d Jiaxun Yang       2019-10-20  21  #else
71e2f4dd5a65bd8d Jiaxun Yang       2019-10-20  22  	void (*func)(void);
71e2f4dd5a65bd8d Jiaxun Yang       2019-10-20  23  
4bdc0d676a643140 Christoph Hellwig 2020-01-06  24  	func = (void *)ioremap(LOONGSON_BOOT_BASE, 4);
71e2f4dd5a65bd8d Jiaxun Yang       2019-10-20  25  
71e2f4dd5a65bd8d Jiaxun Yang       2019-10-20  26  	__asm__ __volatile__(
71e2f4dd5a65bd8d Jiaxun Yang       2019-10-20  27  	"	.set	noat						\n"
71e2f4dd5a65bd8d Jiaxun Yang       2019-10-20  28  	"	jr	%[func]						\n"
71e2f4dd5a65bd8d Jiaxun Yang       2019-10-20  29  	"	.set	at						\n"
71e2f4dd5a65bd8d Jiaxun Yang       2019-10-20  30  	: /* No outputs */
71e2f4dd5a65bd8d Jiaxun Yang       2019-10-20  31  	: [func] "r" (func));
71e2f4dd5a65bd8d Jiaxun Yang       2019-10-20  32  #endif
71e2f4dd5a65bd8d Jiaxun Yang       2019-10-20  33  }
71e2f4dd5a65bd8d Jiaxun Yang       2019-10-20  34  

:::::: The code at line 20 was first introduced by commit
:::::: 4bdc0d676a643140bdf17dbf7eafedee3d496a3c remove ioremap_nocache and devm_ioremap_nocache

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Christoph Hellwig <hch@lst.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--envbJBWh7q8WU6mo
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
tAEA

--envbJBWh7q8WU6mo--
