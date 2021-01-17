Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB092F8FED
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 01:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbhAQAOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 19:14:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:36738 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbhAQAOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 19:14:47 -0500
IronPort-SDR: wmTU48QK0ryDOxA/FOZ5eab42S0tFZiXAQsAyyIUBAQ+412thjGql5IjjmBW3a0rUAGYJP/6rA
 sE8v3tmzVLuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9866"; a="240234717"
X-IronPort-AV: E=Sophos;i="5.79,352,1602572400"; 
   d="gz'50?scan'50,208,50";a="240234717"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2021 16:14:04 -0800
IronPort-SDR: GTnNcn2FPujzgH69fYN8xy8yT4lA/XKGFYC0VLse0EvSF24O4Nbdaj13JuSNdar1wK2mKhSLpw
 Xb1Y29Tf0XBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,352,1602572400"; 
   d="gz'50?scan'50,208,50";a="568845507"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Jan 2021 16:14:02 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l0vhh-0001DC-KA; Sun, 17 Jan 2021 00:14:01 +0000
Date:   Sun, 17 Jan 2021 08:13:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: drivers/dma/ppc4xx/adma.c:688:38: sparse: sparse: incorrect type in
 argument 2 (different address spaces)
Message-ID: <202101170808.3GkuRQY0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0da0a8a0a0e1845f495431c3d8d733d2bbf9e9e5
commit: 894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e powerpc: inline iomap accessors
date:   6 weeks ago
config: powerpc-randconfig-s031-20210117 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-208-g46a52ca4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   drivers/dma/ppc4xx/adma.c:73:1: sparse: sparse: symbol 'ppc440spe_adma_chan_list' was not declared. Should it be static?
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:543:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sg1l @@     got restricted __le32 [usertype] @@
   drivers/dma/ppc4xx/adma.c:543:35: sparse:     expected unsigned int [usertype] sg1l
   drivers/dma/ppc4xx/adma.c:543:35: sparse:     got restricted __le32 [usertype]
   drivers/dma/ppc4xx/adma.c:544:35: sparse: sparse: invalid assignment: |=
   drivers/dma/ppc4xx/adma.c:544:35: sparse:    left side has type unsigned int
   drivers/dma/ppc4xx/adma.c:544:35: sparse:    right side has type restricted __le32
   drivers/dma/ppc4xx/adma.c:590:23: sparse: sparse: invalid assignment: |=
   drivers/dma/ppc4xx/adma.c:590:23: sparse:    left side has type unsigned int
   drivers/dma/ppc4xx/adma.c:590:23: sparse:    right side has type restricted __le32
   drivers/dma/ppc4xx/adma.c:629:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/dma/ppc4xx/adma.c:629:23: sparse:     expected unsigned int [usertype]
   drivers/dma/ppc4xx/adma.c:629:23: sparse:     got restricted __le32 [usertype]
   drivers/dma/ppc4xx/adma.c:630:23: sparse: sparse: invalid assignment: |=
   drivers/dma/ppc4xx/adma.c:630:23: sparse:    left side has type unsigned int
   drivers/dma/ppc4xx/adma.c:630:23: sparse:    right side has type restricted __le32
   drivers/dma/ppc4xx/adma.c:655:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cnt @@     got restricted __le32 [usertype] @@
   drivers/dma/ppc4xx/adma.c:655:34: sparse:     expected unsigned int [usertype] cnt
   drivers/dma/ppc4xx/adma.c:655:34: sparse:     got restricted __le32 [usertype]
>> drivers/dma/ppc4xx/adma.c:688:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:688:38: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:688:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:689:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:689:38: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:689:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:690:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:690:38: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:690:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:691:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:691:39: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:691:39: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:738:69: sparse: sparse: Using plain integer as NULL pointer
   drivers/dma/ppc4xx/adma.c:1187:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1187:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1187:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
>> drivers/dma/ppc4xx/adma.c:1188:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1188:34: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1188:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1190:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1190:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1190:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
>> drivers/dma/ppc4xx/adma.c:1191:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1191:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1191:36: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1138:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1138:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1138:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1147:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1147:35: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1147:35: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1157:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1157:49: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1157:49: sparse:     got unsigned int *
>> drivers/dma/ppc4xx/adma.c:1159:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1159:38: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1159:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:911:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:911:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:911:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:912:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:912:40: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:912:40: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:974:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:974:32: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:974:32: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:979:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:979:40: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:979:40: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:984:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:984:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:984:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:985:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:985:34: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:985:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:986:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:986:34: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:986:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:993:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:993:55: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:993:55: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:995:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:995:51: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:995:51: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:997:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:997:51: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:997:51: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:999:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:999:46: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:999:46: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1008:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1008:35: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1008:35: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1027:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1027:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1027:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
>> drivers/dma/ppc4xx/adma.c:1031:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1031:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1031:31: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1031:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1031:60: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1031:60: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1032:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1032:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1032:31: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1032:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1032:60: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1032:60: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1038:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1038:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1038:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1039:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1039:37: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1039:37: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1053:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1053:48: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1053:48: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1055:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1055:25: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1055:25: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1062:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1062:41: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1062:41: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1064:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1064:39: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1064:39: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1065:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1065:25: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1065:25: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1066:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1066:33: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1066:33: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1067:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1067:22: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1067:22: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1080:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1080:48: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1080:48: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:1090:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1090:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1090:26: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1210:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1210:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1210:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1214:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1214:30: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1214:30: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:2777:62: sparse: sparse: Using plain integer as NULL pointer
   drivers/dma/ppc4xx/adma.c:4094:14: sparse: sparse: too many warnings

vim +688 drivers/dma/ppc4xx/adma.c

12458ea06efd7b Anatolij Gustschin 2009-12-11  675  
12458ea06efd7b Anatolij Gustschin 2009-12-11  676  /**
12458ea06efd7b Anatolij Gustschin 2009-12-11  677   * ppc440spe_desc_set_dcheck - set CHECK pattern
12458ea06efd7b Anatolij Gustschin 2009-12-11  678   */
12458ea06efd7b Anatolij Gustschin 2009-12-11  679  static void ppc440spe_desc_set_dcheck(struct ppc440spe_adma_desc_slot *desc,
12458ea06efd7b Anatolij Gustschin 2009-12-11  680  				struct ppc440spe_adma_chan *chan, u8 *qword)
12458ea06efd7b Anatolij Gustschin 2009-12-11  681  {
12458ea06efd7b Anatolij Gustschin 2009-12-11  682  	struct dma_cdb *dma_hw_desc;
12458ea06efd7b Anatolij Gustschin 2009-12-11  683  
12458ea06efd7b Anatolij Gustschin 2009-12-11  684  	switch (chan->device->id) {
12458ea06efd7b Anatolij Gustschin 2009-12-11  685  	case PPC440SPE_DMA0_ID:
12458ea06efd7b Anatolij Gustschin 2009-12-11  686  	case PPC440SPE_DMA1_ID:
12458ea06efd7b Anatolij Gustschin 2009-12-11  687  		dma_hw_desc = desc->hw_desc;
12458ea06efd7b Anatolij Gustschin 2009-12-11 @688  		iowrite32(qword[0], &dma_hw_desc->sg3l);
12458ea06efd7b Anatolij Gustschin 2009-12-11  689  		iowrite32(qword[4], &dma_hw_desc->sg3u);
12458ea06efd7b Anatolij Gustschin 2009-12-11  690  		iowrite32(qword[8], &dma_hw_desc->sg2l);
12458ea06efd7b Anatolij Gustschin 2009-12-11  691  		iowrite32(qword[12], &dma_hw_desc->sg2u);
12458ea06efd7b Anatolij Gustschin 2009-12-11  692  		break;
12458ea06efd7b Anatolij Gustschin 2009-12-11  693  	default:
12458ea06efd7b Anatolij Gustschin 2009-12-11  694  		BUG();
12458ea06efd7b Anatolij Gustschin 2009-12-11  695  	}
12458ea06efd7b Anatolij Gustschin 2009-12-11  696  }
12458ea06efd7b Anatolij Gustschin 2009-12-11  697  

:::::: The code at line 688 was first introduced by commit
:::::: 12458ea06efd7b44281e68fe59c950ec7d59c649 ppc440spe-adma: adds updated ppc440spe adma driver

:::::: TO: Anatolij Gustschin <agust@denx.de>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--AhhlLboLdkugWU4S
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--AhhlLboLdkugWU4S--
