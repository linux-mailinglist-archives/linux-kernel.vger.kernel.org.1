Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80E9290F7D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 07:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436581AbgJQFjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 01:39:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:42962 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436542AbgJQFjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:39:44 -0400
IronPort-SDR: /je43qd+7R6IAmoAR95Oa5r8U19DG26m8fInDByW6ncsFNUF0bsR2zUN/WvP3g11wgZngNRQMA
 c3vqwOWcQ2Yg==
X-IronPort-AV: E=McAfee;i="6000,8403,9776"; a="146603441"
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400"; 
   d="gz'50?scan'50,208,50";a="146603441"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 20:36:27 -0700
IronPort-SDR: z2oKMdzwd14gIQANQ4f7SBxdYJOgYpd5fnVmhx96Lkr+6JpMVZWXlzZFevZcgcoI3jTlQbeXTZ
 +tMiPnnzRB5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400"; 
   d="gz'50?scan'50,208,50";a="300868096"
Received: from lkp-server02.sh.intel.com (HELO 262a2cdd3070) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 16 Oct 2020 20:36:24 -0700
Received: from kbuild by 262a2cdd3070 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kTd15-0000F1-K8; Sat, 17 Oct 2020 03:36:23 +0000
Date:   Sat, 17 Oct 2020 11:35:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>
Subject: drivers/dma/ppc4xx/adma.c:1188:34: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202010171124.Kz8dzhAM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   071a0578b0ce0b0e543d1e38ee6926b9cc21c198
commit: 8f28ca6bd8211214faf717677bbffe375c2a6072 iomap: constify ioreadX() iomem argument (as in generic implementation)
date:   9 weeks ago
config: powerpc-randconfig-s032-20201017 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-rc1-2-g368fd9ce-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8f28ca6bd8211214faf717677bbffe375c2a6072
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8f28ca6bd8211214faf717677bbffe375c2a6072
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
   drivers/dma/ppc4xx/adma.c:688:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:688:38: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:688:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:689:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:689:38: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:689:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:690:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:690:38: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:690:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:691:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:691:39: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:691:39: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:738:69: sparse: sparse: Using plain integer as NULL pointer
   drivers/dma/ppc4xx/adma.c:1187:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1187:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1187:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
>> drivers/dma/ppc4xx/adma.c:1188:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
>> drivers/dma/ppc4xx/adma.c:1188:34: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1188:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1190:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1190:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1190:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1191:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1191:36: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1191:36: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1138:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1138:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1138:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1147:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1147:35: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1147:35: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1157:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1157:49: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1157:49: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1159:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1159:38: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1159:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:911:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:911:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:911:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:912:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:912:40: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:912:40: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:974:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:974:32: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:974:32: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:979:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:979:40: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:979:40: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:984:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:984:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:984:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:985:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:985:34: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:985:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:986:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:986:34: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:986:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:993:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:993:55: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:993:55: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:995:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:995:51: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:995:51: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:997:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:997:51: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:997:51: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:999:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:999:46: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:999:46: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1008:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1008:35: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1008:35: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1027:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1027:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1027:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
>> drivers/dma/ppc4xx/adma.c:1031:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1031:31: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1031:31: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1031:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1031:60: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1031:60: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1032:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1032:31: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1032:31: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1032:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1032:60: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1032:60: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1038:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1038:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1038:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1039:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1039:37: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1039:37: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1053:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1053:48: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1053:48: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1055:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1055:25: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1055:25: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1062:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1062:41: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1062:41: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1064:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1064:39: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1064:39: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1065:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1065:25: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1065:25: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1066:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1066:33: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1066:33: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1067:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1067:22: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1067:22: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1080:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1080:48: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1080:48: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:1090:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1090:26: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1090:26: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1210:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1210:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1210:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1214:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1214:30: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1214:30: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:2777:62: sparse: sparse: Using plain integer as NULL pointer
   drivers/dma/ppc4xx/adma.c:4094:14: sparse: sparse: too many warnings

vim +1188 drivers/dma/ppc4xx/adma.c

12458ea06efd7b Anatolij Gustschin 2009-12-11  1014  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1015  /**
12458ea06efd7b Anatolij Gustschin 2009-12-11  1016   * ppc440spe_chan_is_busy - get the channel status
12458ea06efd7b Anatolij Gustschin 2009-12-11  1017   */
12458ea06efd7b Anatolij Gustschin 2009-12-11  1018  static int ppc440spe_chan_is_busy(struct ppc440spe_adma_chan *chan)
12458ea06efd7b Anatolij Gustschin 2009-12-11  1019  {
12458ea06efd7b Anatolij Gustschin 2009-12-11  1020  	struct dma_regs *dma_reg;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1021  	struct xor_regs *xor_reg;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1022  	int busy = 0;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1023  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1024  	switch (chan->device->id) {
12458ea06efd7b Anatolij Gustschin 2009-12-11  1025  	case PPC440SPE_DMA0_ID:
12458ea06efd7b Anatolij Gustschin 2009-12-11  1026  	case PPC440SPE_DMA1_ID:
12458ea06efd7b Anatolij Gustschin 2009-12-11  1027  		dma_reg = chan->device->dma_reg;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1028  		/*  if command FIFO's head and tail pointers are equal and
12458ea06efd7b Anatolij Gustschin 2009-12-11  1029  		 * status tail is the same as command, then channel is free
12458ea06efd7b Anatolij Gustschin 2009-12-11  1030  		 */
12458ea06efd7b Anatolij Gustschin 2009-12-11 @1031  		if (ioread16(&dma_reg->cpfhp) != ioread16(&dma_reg->cpftp) ||
12458ea06efd7b Anatolij Gustschin 2009-12-11  1032  		    ioread16(&dma_reg->cpftp) != ioread16(&dma_reg->csftp))
12458ea06efd7b Anatolij Gustschin 2009-12-11  1033  			busy = 1;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1034  		break;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1035  	case PPC440SPE_XOR_ID:
12458ea06efd7b Anatolij Gustschin 2009-12-11  1036  		/* use the special status bit for the XORcore
12458ea06efd7b Anatolij Gustschin 2009-12-11  1037  		 */
12458ea06efd7b Anatolij Gustschin 2009-12-11  1038  		xor_reg = chan->device->xor_reg;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1039  		busy = (ioread32be(&xor_reg->sr) & XOR_SR_XCP_BIT) ? 1 : 0;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1040  		break;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1041  	}
12458ea06efd7b Anatolij Gustschin 2009-12-11  1042  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1043  	return busy;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1044  }
12458ea06efd7b Anatolij Gustschin 2009-12-11  1045  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1046  /**
12458ea06efd7b Anatolij Gustschin 2009-12-11  1047   * ppc440spe_chan_set_first_xor_descriptor -  init XORcore chain
12458ea06efd7b Anatolij Gustschin 2009-12-11  1048   */
12458ea06efd7b Anatolij Gustschin 2009-12-11  1049  static void ppc440spe_chan_set_first_xor_descriptor(
12458ea06efd7b Anatolij Gustschin 2009-12-11  1050  				struct ppc440spe_adma_chan *chan,
12458ea06efd7b Anatolij Gustschin 2009-12-11  1051  				struct ppc440spe_adma_desc_slot *next_desc)
12458ea06efd7b Anatolij Gustschin 2009-12-11  1052  {
12458ea06efd7b Anatolij Gustschin 2009-12-11  1053  	struct xor_regs *xor_reg = chan->device->xor_reg;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1054  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1055  	if (ioread32be(&xor_reg->sr) & XOR_SR_XCP_BIT)
12458ea06efd7b Anatolij Gustschin 2009-12-11  1056  		printk(KERN_INFO "%s: Warn: XORcore is running "
12458ea06efd7b Anatolij Gustschin 2009-12-11  1057  			"when try to set the first CDB!\n",
12458ea06efd7b Anatolij Gustschin 2009-12-11  1058  			__func__);
12458ea06efd7b Anatolij Gustschin 2009-12-11  1059  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1060  	xor_last_submit = xor_last_linked = next_desc;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1061  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1062  	iowrite32be(XOR_CRSR_64BA_BIT, &xor_reg->crsr);
12458ea06efd7b Anatolij Gustschin 2009-12-11  1063  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1064  	iowrite32be(next_desc->phys, &xor_reg->cblalr);
12458ea06efd7b Anatolij Gustschin 2009-12-11  1065  	iowrite32be(0, &xor_reg->cblahr);
12458ea06efd7b Anatolij Gustschin 2009-12-11  1066  	iowrite32be(ioread32be(&xor_reg->cbcr) | XOR_CBCR_LNK_BIT,
12458ea06efd7b Anatolij Gustschin 2009-12-11  1067  		    &xor_reg->cbcr);
12458ea06efd7b Anatolij Gustschin 2009-12-11  1068  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1069  	chan->hw_chain_inited = 1;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1070  }
12458ea06efd7b Anatolij Gustschin 2009-12-11  1071  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1072  /**
12458ea06efd7b Anatolij Gustschin 2009-12-11  1073   * ppc440spe_dma_put_desc - put DMA0,1 descriptor to FIFO.
12458ea06efd7b Anatolij Gustschin 2009-12-11  1074   * called with irqs disabled
12458ea06efd7b Anatolij Gustschin 2009-12-11  1075   */
12458ea06efd7b Anatolij Gustschin 2009-12-11  1076  static void ppc440spe_dma_put_desc(struct ppc440spe_adma_chan *chan,
12458ea06efd7b Anatolij Gustschin 2009-12-11  1077  		struct ppc440spe_adma_desc_slot *desc)
12458ea06efd7b Anatolij Gustschin 2009-12-11  1078  {
12458ea06efd7b Anatolij Gustschin 2009-12-11  1079  	u32 pcdb;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1080  	struct dma_regs *dma_reg = chan->device->dma_reg;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1081  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1082  	pcdb = desc->phys;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1083  	if (!test_bit(PPC440SPE_DESC_INT, &desc->flags))
12458ea06efd7b Anatolij Gustschin 2009-12-11  1084  		pcdb |= DMA_CDB_NO_INT;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1085  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1086  	chan_last_sub[chan->device->id] = desc;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1087  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1088  	ADMA_LL_DBG(print_cb(chan, desc->hw_desc));
12458ea06efd7b Anatolij Gustschin 2009-12-11  1089  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1090  	iowrite32(pcdb, &dma_reg->cpfpl);
12458ea06efd7b Anatolij Gustschin 2009-12-11  1091  }
12458ea06efd7b Anatolij Gustschin 2009-12-11  1092  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1093  /**
12458ea06efd7b Anatolij Gustschin 2009-12-11  1094   * ppc440spe_chan_append - update the h/w chain in the channel
12458ea06efd7b Anatolij Gustschin 2009-12-11  1095   */
12458ea06efd7b Anatolij Gustschin 2009-12-11  1096  static void ppc440spe_chan_append(struct ppc440spe_adma_chan *chan)
12458ea06efd7b Anatolij Gustschin 2009-12-11  1097  {
12458ea06efd7b Anatolij Gustschin 2009-12-11  1098  	struct xor_regs *xor_reg;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1099  	struct ppc440spe_adma_desc_slot *iter;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1100  	struct xor_cb *xcb;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1101  	u32 cur_desc;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1102  	unsigned long flags;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1103  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1104  	local_irq_save(flags);
12458ea06efd7b Anatolij Gustschin 2009-12-11  1105  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1106  	switch (chan->device->id) {
12458ea06efd7b Anatolij Gustschin 2009-12-11  1107  	case PPC440SPE_DMA0_ID:
12458ea06efd7b Anatolij Gustschin 2009-12-11  1108  	case PPC440SPE_DMA1_ID:
12458ea06efd7b Anatolij Gustschin 2009-12-11  1109  		cur_desc = ppc440spe_chan_get_current_descriptor(chan);
12458ea06efd7b Anatolij Gustschin 2009-12-11  1110  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1111  		if (likely(cur_desc)) {
12458ea06efd7b Anatolij Gustschin 2009-12-11  1112  			iter = chan_last_sub[chan->device->id];
12458ea06efd7b Anatolij Gustschin 2009-12-11  1113  			BUG_ON(!iter);
12458ea06efd7b Anatolij Gustschin 2009-12-11  1114  		} else {
12458ea06efd7b Anatolij Gustschin 2009-12-11  1115  			/* first peer */
12458ea06efd7b Anatolij Gustschin 2009-12-11  1116  			iter = chan_first_cdb[chan->device->id];
12458ea06efd7b Anatolij Gustschin 2009-12-11  1117  			BUG_ON(!iter);
12458ea06efd7b Anatolij Gustschin 2009-12-11  1118  			ppc440spe_dma_put_desc(chan, iter);
12458ea06efd7b Anatolij Gustschin 2009-12-11  1119  			chan->hw_chain_inited = 1;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1120  		}
12458ea06efd7b Anatolij Gustschin 2009-12-11  1121  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1122  		/* is there something new to append */
12458ea06efd7b Anatolij Gustschin 2009-12-11  1123  		if (!iter->hw_next)
12458ea06efd7b Anatolij Gustschin 2009-12-11  1124  			break;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1125  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1126  		/* flush descriptors from the s/w queue to fifo */
12458ea06efd7b Anatolij Gustschin 2009-12-11  1127  		list_for_each_entry_continue(iter, &chan->chain, chain_node) {
12458ea06efd7b Anatolij Gustschin 2009-12-11  1128  			ppc440spe_dma_put_desc(chan, iter);
12458ea06efd7b Anatolij Gustschin 2009-12-11  1129  			if (!iter->hw_next)
12458ea06efd7b Anatolij Gustschin 2009-12-11  1130  				break;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1131  		}
12458ea06efd7b Anatolij Gustschin 2009-12-11  1132  		break;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1133  	case PPC440SPE_XOR_ID:
12458ea06efd7b Anatolij Gustschin 2009-12-11  1134  		/* update h/w links and refetch */
12458ea06efd7b Anatolij Gustschin 2009-12-11  1135  		if (!xor_last_submit->hw_next)
12458ea06efd7b Anatolij Gustschin 2009-12-11  1136  			break;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1137  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1138  		xor_reg = chan->device->xor_reg;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1139  		/* the last linked CDB has to generate an interrupt
12458ea06efd7b Anatolij Gustschin 2009-12-11  1140  		 * that we'd be able to append the next lists to h/w
12458ea06efd7b Anatolij Gustschin 2009-12-11  1141  		 * regardless of the XOR engine state at the moment of
12458ea06efd7b Anatolij Gustschin 2009-12-11  1142  		 * appending of these next lists
12458ea06efd7b Anatolij Gustschin 2009-12-11  1143  		 */
12458ea06efd7b Anatolij Gustschin 2009-12-11  1144  		xcb = xor_last_linked->hw_desc;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1145  		xcb->cbc |= XOR_CBCR_CBCE_BIT;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1146  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1147  		if (!(ioread32be(&xor_reg->sr) & XOR_SR_XCP_BIT)) {
12458ea06efd7b Anatolij Gustschin 2009-12-11  1148  			/* XORcore is idle. Refetch now */
12458ea06efd7b Anatolij Gustschin 2009-12-11  1149  			do_xor_refetch = 0;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1150  			ppc440spe_xor_set_link(xor_last_submit,
12458ea06efd7b Anatolij Gustschin 2009-12-11  1151  				xor_last_submit->hw_next);
12458ea06efd7b Anatolij Gustschin 2009-12-11  1152  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1153  			ADMA_LL_DBG(print_cb_list(chan,
12458ea06efd7b Anatolij Gustschin 2009-12-11  1154  				xor_last_submit->hw_next));
12458ea06efd7b Anatolij Gustschin 2009-12-11  1155  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1156  			xor_last_submit = xor_last_linked;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1157  			iowrite32be(ioread32be(&xor_reg->crsr) |
12458ea06efd7b Anatolij Gustschin 2009-12-11  1158  				    XOR_CRSR_RCBE_BIT | XOR_CRSR_64BA_BIT,
12458ea06efd7b Anatolij Gustschin 2009-12-11  1159  				    &xor_reg->crsr);
12458ea06efd7b Anatolij Gustschin 2009-12-11  1160  		} else {
12458ea06efd7b Anatolij Gustschin 2009-12-11  1161  			/* XORcore is running. Refetch later in the handler */
12458ea06efd7b Anatolij Gustschin 2009-12-11  1162  			do_xor_refetch = 1;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1163  		}
12458ea06efd7b Anatolij Gustschin 2009-12-11  1164  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1165  		break;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1166  	}
12458ea06efd7b Anatolij Gustschin 2009-12-11  1167  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1168  	local_irq_restore(flags);
12458ea06efd7b Anatolij Gustschin 2009-12-11  1169  }
12458ea06efd7b Anatolij Gustschin 2009-12-11  1170  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1171  /**
12458ea06efd7b Anatolij Gustschin 2009-12-11  1172   * ppc440spe_chan_get_current_descriptor - get the currently executed descriptor
12458ea06efd7b Anatolij Gustschin 2009-12-11  1173   */
12458ea06efd7b Anatolij Gustschin 2009-12-11  1174  static u32
12458ea06efd7b Anatolij Gustschin 2009-12-11  1175  ppc440spe_chan_get_current_descriptor(struct ppc440spe_adma_chan *chan)
12458ea06efd7b Anatolij Gustschin 2009-12-11  1176  {
12458ea06efd7b Anatolij Gustschin 2009-12-11  1177  	struct dma_regs *dma_reg;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1178  	struct xor_regs *xor_reg;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1179  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1180  	if (unlikely(!chan->hw_chain_inited))
12458ea06efd7b Anatolij Gustschin 2009-12-11  1181  		/* h/w descriptor chain is not initialized yet */
12458ea06efd7b Anatolij Gustschin 2009-12-11  1182  		return 0;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1183  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1184  	switch (chan->device->id) {
12458ea06efd7b Anatolij Gustschin 2009-12-11  1185  	case PPC440SPE_DMA0_ID:
12458ea06efd7b Anatolij Gustschin 2009-12-11  1186  	case PPC440SPE_DMA1_ID:
12458ea06efd7b Anatolij Gustschin 2009-12-11  1187  		dma_reg = chan->device->dma_reg;
12458ea06efd7b Anatolij Gustschin 2009-12-11 @1188  		return ioread32(&dma_reg->acpl) & (~DMA_CDB_MSK);
12458ea06efd7b Anatolij Gustschin 2009-12-11  1189  	case PPC440SPE_XOR_ID:
12458ea06efd7b Anatolij Gustschin 2009-12-11  1190  		xor_reg = chan->device->xor_reg;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1191  		return ioread32be(&xor_reg->ccbalr);
12458ea06efd7b Anatolij Gustschin 2009-12-11  1192  	}
12458ea06efd7b Anatolij Gustschin 2009-12-11  1193  	return 0;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1194  }
12458ea06efd7b Anatolij Gustschin 2009-12-11  1195  

:::::: The code at line 1188 was first introduced by commit
:::::: 12458ea06efd7b44281e68fe59c950ec7d59c649 ppc440spe-adma: adds updated ppc440spe adma driver

:::::: TO: Anatolij Gustschin <agust@denx.de>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--k1lZvvs/B4yU6o8G
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICJVkil8AAy5jb25maWcAlFxLc9y2st7nV0w5m2QRn9HDPnbd0gIEQQ4yJEEB4IxGG5Qi
jXNUkSVfaZQj//vbDb4AEJz4ZuEMuxsgHo3urxtN/fzTzwvyenj6enO4v715ePi++HP/uH++
OezvFl/uH/b/s0jFohJ6wVKu34Nwcf/4+vavb0//3T9/u118eP/p/XKx3j8/7h8W9Onxy/2f
r9D4/unxp59/oqLKeG4oNRsmFReV0exKX7zrGv/2gF399uft7eKXnNJfF5/fn71fvnOacWWA
cfG9J+VjVxefl2fLZc8o0oF+ena+tP8N/RSkygf20ul+RZQhqjS50GJ8icPgVcEr5rBEpbRs
qBZSjVQuL81WyPVISRpepJqXzGiSFMwoIfXI1SvJSAqdZwL+ARGFTWG9fl7kdu0fFi/7w+u3
cQUTKdasMrCAqqydF1dcG1ZtDJGwBLzk+uLsFHoZRlvWHN6umdKL+5fF49MBOx7WTFBS9Mvy
7l2MbEjjroydllGk0I78imyYWTNZscLk19wZnsu5uh7pvvAw3EEyMtaUZaQptJ2x8+6evBJK
V6RkF+9+eXx63P86CKgtcQakdmrDazoh4P+pLkZ6LRS/MuVlwxoWp06abImmK9O3GPdACqVM
yUohd4ZoTejKnd4g1yhW8CQyc9LAuQvWlEh4lWXgKEjhDCOgWqUC/Vy8vP7x8v3lsP86KlXO
KiY5teqrVmLrHLOAYwq2YUWcz6vfGdWoQlE2XbkagZRUlIRXPk3xMiZkVpxJnOxu2nmpOErO
MqLvyYSkLO0OIK9yRxNqIhWL92h7Y0mTZ8pu7f7xbvH0JVjWsJE9/ZvJ/vRsCsdsDataaRVh
lkKZpk6JZv0e6vuv++eX2DZqTtdgGRhslKMnlTCra7QApd2ZQc+AWMM7RMppRNnaVjwtPB22
1Ij0iucrI5myc5Xe2kyGO/ZWS8bKWkOvFYt02rM3omgqTeTOHUnHPNKMCmjVLxqtm3/pm5e/
FgcYzuIGhvZyuDm8LG5ub59eHw/3j38GywgNDKG2j1Y7hjdvuNQB21RE801sDqgwdv+9vnoj
qlIYraAM7ALwtfuWkGc2Z1FrgS5DaaJVlFsr7tO7TfmB5bDLJmmzUDFFq3YGeO6A4dGwK9Co
2J6oVthtHpBwGraPTvMjrAmpSVmMriWhbBheN2N/JsP2rNsfjm1YD2okqDs/vl6BpQDljvpP
9IgZWEie6YvT5aiKvNJrcJMZC2ROztoFVrf/2d+9PuyfF1/2N4fX5/2LJXeDjnAH/JFL0dTK
HSG4FppH1SAp1l2DKLtlGUVXLD0mUPM0rmYdX6YlOcbP4GReM3lMJGUbTtkxCVBdPA9Hx8lk
dvwlYMGjAogcwP7DqYu3XzG6rgVsKho7gH7xkdqFtIBpfs3BHWQKRgLWioJxTyNaJVlBHHeH
mwjLY4GPTH3oJ0kJvSnRgFNzQJFMJ9AKSAmQTqODAmZx7e/hyLG4zRcV872cxzu5VtoZeiIE
2unuBI7LTI2owWrya4Z+2u6nkCWpaMzEhtIKfgQoCaBqijibCrAY4EuJYYiR0Wr7PvGoYMyu
BdCvfQY7SFmtbZSDtsiZcJ2ND621HJ9LwK8c0J90+suZLsGomRE9BBrUMSJjy1akat23B1oH
D+3ZqPDZVCV30b7rtQigo6xxoUzWQDQXPIK1cKZaC1de8bwiRZa6LgFG5RIsIHIJagX2zUG3
XHjWWZgGBh4/1STdcMX6pYoZcOg6IVJyd+3XKLsr1ZRiPBw3UO3C4KFFLOD58jqL7ZOL+KWN
XrKYGbAQH8PQcZAGu0oIXTuDi4mpXQUQEsyUd3IVu4wOA9qxNI2aInuK8BiaEKjW9GR53qOs
Lviv989fnp6/3jze7hfs7/0jAAsCDo0itAAsOOIIv8fB7f1gN30vm7Lto0V8PfzsrQNEvkRD
2LyOm+GCJDOMJhaDqUIk3iGE9rDiMmd9BBrvbdVkGcTfNQFB2DsIrMF7xA2KZmVreiDy5hmn
xA+pAJdkvPBwpDUy1i15y+hnEIb2NT079ZB0TT961tpuZf38dLt/eXl6BuT+7dvT86GF0UMT
tN3rM2U+vr3FkacjsjyZFfn04Uj7TzO88+VbZOnOz9/cabHT5TIiNQRWtYMb8WWZSzh/e/O8
1No1o5qZj+eJG4rXq52a0KDPsmwguIFDuZqjG7sXPQvI1qq7wRuq9YpJq98EgIW7w9NNGs5E
qoTbNcYrCa5KlXLiaNPZqTdoGFhgUcqSALCrADVwDbaFXF2cfDgmAHH25zi/P4n/1I8n53ZX
SQyn1MWHk9PhuGgwgi3eV01d+7k1S4YWWUFyNeVj2A34a8roVWS1ZRDW+lvqOCgii93Ue5Kq
i/hFAyj/0xAKtJhQlFwDDAaUaex5df1Nuwpk1xlb0MiU+mrTpEluTj5++LAMsjy27XQCnttu
/QNPmGzRDMIBxRMXIFgR1agatCTCxiGkVHbB7oQ+6ccuq2rRtrV81vDNiTVg2BKm/G7Bc3ft
JctneZxQdXEe56XIO53hbY7wCDWSVLk7z7xN4doUmN8Q7AXsGEdIB4GBP1DklYoHFkBx1PDS
5iRbg/twc0B3F7O3Cs5En3eatZbn/45ZxYSUYL/cKKLByKXyIAFLRLWLOy5Snp8v2UwMwy4b
wWPhgiZcrYgHrdcEZsvjAQOBGIbF3OGWyNpXGFdDKKl2oioA5rqZs4LQFseN/bN0K0Q8tIUj
PhOR7oRicFzjIR5X6vwttt6ces4atv/8DZOadXCSUCvymjs7Y9fZe8yvvEdV753nj0sXcpO6
/HR64notnrQ7Z5iU544nWANcylEHXHROaoiyiCSY23JSZovsef+/r/vH2++Ll9ubBy9Lhh4F
AnonSdpTTC42mOAG/Mn0DHuajhzYmM2KR9+9RJ/rx45mYsN/aCS2ABPJ5v/RBDG6zQz8eBNR
pQwGFsPTUXngwUs2gXX1ls2Z7ZxEP7Xo2s7OJCbYj392C73hDjrzJdSZxd3z/d8t7ncTkBHl
6vvgdw/7rhWQhp6R7JpFHA5mqOdSnF0Dh+J2PPZzyexRjO4s+FIjNY2+YmKy3SDo6Rtefb64
48UsOURn0fesrs2JD1hd1umHGJYFxtlyGeT0oZe47IVzSdqikZXEVLeD/oheQRTYFJO8iM+x
0X8sivalVlvTVNbylYBeWeobcoCi1pt2F2IroetiglcmMhJ+uadjza6YAykg+sbQini4hUoE
2mlTBq7EADDU0HX3Fsd0FgXLSdFDNLMh4DTH62Kl04RXjeaFF2laH7y2QCeWYkD2yceOH7b7
+A8NbdzYZY4HoNNdHg8J5Y5sY8dQ1l53Iew21+D7hUzBQw7AmpapvdweE4fsCtAzeHGIayGm
HOkdOHSyMh1a7FK7U4Za89rmIZyUXAdCWSyN4SDUKNGoitR4wYW5UDd0wm1BH6a59m+xkVUw
5mVBgYbpWUuPLXkJyGONuuQOzaV2d+wn45HyuLmL3MvgzfPp5+1la78NyyDw5xjzRbIKA/qi
GCpFEie96Rn0WRGTlgRAAu8NdfL64lioIG7o5H3EyiFylIxqxLkTJENrJzWHBOVfnmSqMEUS
t6LuUMawt0IYAGNpSwH6YZO7vzEddDdURbg5PvSKqc0FQ+tJQiPdf7l5fbAEvN96WYDlXtz0
/d269Sr9cBY3z/vF68v+blyiQmzRYtgc8/LtbOnXl9hjKrIMcc/y7TbgdlUNMDEZY2MSgcOJ
GASWgYC2ieD2zUPjYRmDpRkSAYDoGlLw6/5IecUlN8+3/7k/7G/xbum3u/036Gv/eJhqRmtC
u0yia3oDmmizU2H+3SGP8UAb70UU+3ew1KYgiVtnMGjDDiJ5VmTaA7D2JeOZaSqYcF7hHQyl
XjhmzT4AIFu/onllEr8sxHbEYUqYjIABhu9Yh0FqS5VMxxktFat1suAmwPKzprIFE4jRhYwV
UFgxLxc/ln3YHldCOB68P8EKVhCRUecjIllicAiaZ7v+zsgXsFkhVGQzqTdRpSlF2hUFhfPF
IN0QtPqYl+lWvzM7npxy44YxuewH+SMdIWvXp+/Gx8WIKQ2m2XLAJNC4jdzRS0XZePH8DyKt
C/bulrrFbHeoveWlZX1FVyGM2TKyRmzC8IaA0MuGy7CbLQHF5dbVY/VJX4wVmWln9w0cKC9/
NEe3Le3ioUIzrFhzz6HPmcv9R4oewlNzrNLBSoDedDOoGcXMtrPOIm0KOCh4NOF021uUSP/s
CtWyaguFcNwRxbbNQQdFOb0HnCYsj2U7R4A0Nq42kpRgz9wsRAGIyiCM2RLpZiIEVsjxfIKZ
OjoJjnqX92zPHq5kZHI20axF553Ha0sAHe4dyNT75VRsfvvjBnzZ4q8WJHx7fvpy74f0KDQ6
3PDdltsZchPcRYa8qKM/NgZvpbG2E4MBXin/JQM53v+PObUhVtCmxItK12rbKzxV4uyWgW56
4ZAldaC6ECSeWuqkmuqYRG9Jj/WgJB2qMGeuEHtJHgeWHRtVDPOTx2QwSbs1JVeqLWzqCiIM
BHKYp41fYFZwcEGpd2UiiriIlrzs5dZ4XRqLHzsrAFEeLqtYN46pT1DJ3UfAQlRxMBWXXTbL
K3fBSolEzZfDdPx4peVYaqFZLrmOVmF0LKNPllM2RlmpT+6irNbAy3C82ySG8dvuMB/tXgq5
1OFNXm/KAmESC9KR3RYzQ9xL5a4OY/2ogMm6UG16UXjzfLi3qFl//7b38h1DNDag89imq1Qo
J3Abs5IZ98hj2iV4ozuz8tKPTzoaui8ufLINWdqqWDFWWjmgF9px0WZKsCjEr/92mOtd4vrb
npxkl+6o/ZcM1lVVJ2PTpuoWXtWATdFwTFzccF9CNHg4amS5jdhqiJ+MAJtRkLrGY0zSFM+9
sUd5lB+jdrsO7G1/+3q4+eNhb+v9F/b2/eCsSMKrrNToYp1tKjI/BuiEFJW81hMyGBYvMsS2
iOmiFn1uQHa05f7r0/P3RXnzePPn/ms0bOkSPM6EgQCLk9qUkikn0D8jSpu8CRNFa8ZqW1fh
b0iXluJKFEHCQtUFOPFaW8cMsAmvp/ySBBpWFDmnJkckjbscFLT0r+W5JCF2AMCVm+CCzaIF
3Hqjw9tpi+cASCSN59jWqoy8sE9SW3RU8sr2eXG+/PxxiNcZKHyNhSkAEdfOglPAvNV4bz3o
HYwXI69YCtqHNvA4TZiEPNc4IpFA0KMu/j32cl0LETOG10njWOlr6/ndFewpw91f2R4od4SD
THhxEcRk7YVxF1y6HdhAze46RnTr+Ka3l8abCXyHRcc1ny8BBm02CRjyVUn8GpgJttSsReak
cO3W/DEbN99RLLVOMHvIqj4+tGe12h/++/T8F14GTA4pnIW120P7bFJOcs8yXvlPYGDKgNI1
GTFHtNbrKpNOQ3yCc5OLgOTX4VmSahJTi4JTrxDdstojGb8batti/kJpTudGZMgqeB0Eg316
b1xozIDEbh29PeB1W0tIiY+LgD6kyaQA7BsL90CormqvM3g26YrWQV9IxgrO+OVwJyCJjJ1y
nAqv3Q9CWkousZCqbK5ChtFN1cYl3nLYFnPvL+0ko1VWFZhMseYu9m+722juk5rUebdDz0Qz
IYzjdL8JQ6bd3XFsSAJcPbOT49a7RKsU4UgsJ0r0z08rR+sYGWcYIUuyjZGRBFuktBQOLMau
4eeYh42wEq+qv6fSJk7fwivw1j7CWmlax8hqhr5L3GzCQN+wnHjeb+BUm1hNQ8/FQs7uwmja
tIhtqvPKSkRGsmO+fgwMXgAcFDxmNAaZlManTdM8tgmJ5z561w57ED1FPd/u0lEJ3JTjArgN
RyXshvyDRBW/pu0Feq05KmRX7AjOaVduukZJvFCk58tgcAG734KLd7d3f75zN6ZMPyi/Ah7s
0McY8qu9rbbn0dImrq+lht24phM/U8Wc4QwswK5rXeMns0rxbOfZOtsW0KVNU4FrK0NMBDJt
GjIef9dT5mi1UzqZI5L6KbaXOUBYUMrTl7kvjbuODAqdtigxcF8DO/iwqsM9s68YB9Bdt61u
bv9q82iT7iNXfW73QQfO2BXVnrvFZ4PlfyL5nVYzRcZWptdh694MoD6K+hVzgnPiakVOpu+O
CIbf7fktfnAEkTe7W9++PNBuOfMdkgbHGYO42ruChUdQax63VsgsyMy8kJnI04+fYl+3FKfa
0Vt88j4Vden+t3z9arjNE8lTt/awfTY8L0E3KiHCA9fxyyjYaq8o8BwpEpxSJEWnuoFFMJ+W
pyeXUZNGPcDZPneY0lmDwgv14fE0ujukWPv2dmMgzCoYMmJw+fSD1y2pYzm8eiV8UMwYw/l8
OI/RTFV0P+xXORwrVkgRlVTCj1dAcYd+vaWdfE/Xz48mztJVCr8lE/idvZuH1iWxaTNvkwdq
/zOGU1ypgsy0T6OhqiPgFmw45DKMKdw+pwWqM0IzHdja9+PNMUL2bpZEzaqN2nLtFkA7RLO5
KvxC1E27gXELAvsGiGttLU7UARdBxIAUkyvvYyRLw8MQD+WxWaU8wLdScU9p1cjOAw7FrERx
BkqosFIpkOpkLqV2dAufjCrTgAJBRKjAFQ0/H+6Y3XeUFiPImcI5R6bFELGjYK3GFWahdsb/
RCy59GI9/ITqd+7prJtYWBz2L4fAB9vRrXXOYh/uWdMnBWAvUfE+pdK55kmfAcPNYowmtpQk
tSnmLit++9f+sJA3d/dPeM11eLp9enCSHqQ1Ys4THMmS4PdEbnkbDFMKJ1shhRpqLcnV+9MP
i8dusHf7v+9v906pZa+La648B/SxDrL4zhpfMrzqjp7AHZag4zV8ll75x3fgrNKr+aY1kZFm
rI574R0JqiT7Ipdjcx4ygO4HLvCAkayXUgRSQmOJTuTkW7/x7yefzz73aw6ERdq+NXWKWh3x
DYpEzwMyrwKuw1MF9e0UEudOfcuz3ynYD6bjF6KR0To7EHMAJIPjKN3PXHpKV5xiCuHV0/Tc
iVmXV+uZS09os46ufsYTI7ur1o605Vg1oSIUTDI6VHgKSpEsqfuI3yWpejcR4k4lIc1ydOcO
Dm2hwYn94zmlSP3K6k4a94EVAlPgWyIrMPwxRzZIU4bVN923fUZUjZoOwN5swmzt17KYsWN5
mkTEsGaiKy2zIrZIKiLX1nQOIimXTpGk81J4YEXRFARONPe+9fSEsETjCv8gCJczC9IGDPXM
p/Sj3PxnLeN6yZT0V1/H1nXraYVHRmDnf//Fk2Cje4qxt57Qqp7lUVrOM/Xa/+Z+YM9dZHQQ
0hlKT7GZeUkjDEnxKkZp6VU8Odzh1uZHpC7efb1/fDk87x/Mfw7vHCjTi0KcvzoyclMwt/Rl
IEciILdL1d96zH267XcETarm2CiUJsZ+VomVzm2p5NjXlgM1+haZrXm0oh1hwucgSf25Hq+T
PbDx+dhflqCEZzHNZfUK9cNR2o6Cf8dG611vWEMunvp47FBl1HsALJtzTfzUOZArymMzBs7K
3qB7wmqVFjSCvm6eF9n9/gG/yv769fXx/rYtoP0F2vza+WcHjNieeBl2Xlcfzs4MP43XB//g
S4a4TxH/YyubUM88q11s25R5LDhT43e2HQmArDWJAfIHi4+hwkjMCC/Exi/tAEClhSj6uGIu
OKcdvh3yWyHGcIW9Aoe2BsmvyQ4eur9/pXxi5C9KANleOwMcjwXUwCXKLfTuKYMRCfr6P8qe
ZLlxZMdf8WnivUNPidRi6ZjiIrHErUhKourCcJfd3Ypxuyrs6ug3fz9AZpJMJJFSz8FVIoDc
NwAJICXutq8VJcMt/h8R33H6QsKubDgmA5tOvTEVgA0Uhjg8gw+11bQbCx2xlXJ17d1X0NXA
SVs3Rz4CASIxcETDBiJArGisMY0CQYenS4oTBQCzYwEEiGZEFlWeOIicGvsA7Nv3t5/v318x
KtHzlAfGLOMG/vVYNyREY4i+0QHQRkziP8nBbDHkQTsuj4/r729nNM/HGgXf4Uc9uM2a6cKz
lVF4lsVMoeZh38PKVDCUCHVkIlFWTnjOUQOmW9VXpi3ff4WOvb4i+sVu3ngz76ZSI/L0/IKx
MyR6HLUPw8PYrH4gwoj4FZrQvr10ifXIoUfcq5GQ8k430FWfH32P1kCBuOI1xvZN7mWfu40f
zMn4OT3M9+jt+cf36xvtLgykIN3DrAWooTqoUTzZNyJY0XYQTlKTobSh/I+/rz+//cEvO3Mf
OWtNURMF5mS7ncWYQyCqkNY2CxJHOC8gtc4IXdtfvj29Pz/8+n59/t089y+oTR17Sn52BYlC
omCw8As+KqbCN7w+SiOLep9s2ehVokxC0/5PA4A1qsdoDfOZjdb7d9V2TdtJszsmi0wA3S6h
HvUD1sHxjyUcM7Q6Nje8HocmOzmXqbTE7QJLOaAC9j39uD6jqaEacWaD7jNp6mT56GCH+wqU
dddyOh0zj9WaqTkkhH3cn2KqVmLm5gx11Hl0VLp+05zQQzF1qj0qu/d9lJas6gp6qclK00Ks
h3SZjhA53ls1Ig9F6gxHKUuKkyoDGV/5EIX9kRRf3//8G3f01++w87wbNohnaSFucugDSFp9
hRgWcEQqMb0vxBDRx1TSHUY1mMvUQA9mu2YrR0rOHnwkmoSbsds4aFGEdFQ8DcacZmnKntzE
Oi7RpTarSk6OUdTKropa4is47qg6bac8hPnrQSQTMiiWJpb+WTds9qTHC3Bvkm7s67oItOVk
P72jHTEmVd8o0kxgwL8mE2CWkd1JpzYj0PapA3J5hBrjPUwTOYdiKnogMpZnrnQUY08cx/Ia
XERHCW5cI9KjG/1YrSNglNn3yRRnOHvaEhv8l0/tGivkn2VoMN6sMWenbdaQQww+5agzZ9Vg
RP7j6f2Dqswb9FN6lMbntZ2bYcXfOCrQFTGfFsZJRjycpGVM2/taycoe4Sewe2g7rmKgNe9P
bx+vSgxOn/53Uv1teoC1YipkJLCwNoKG1XnEjaUraNKuOrO2ahZpFYeOTOuaRDOqs85KKvut
KF1dqt00CfngHADTX91/TY9DkX2qiuxT/Pr0AfzPH9cfzA0Jjmqc0L76HIVRYK16hGM4iB5M
50WcyAtKxv3YoMIlvBX5oTsnYbPvPJq5hfVvYhcUi+UnHgPzuZqi90oKJ42jmrIxWUhidfZw
OCPFFIrRECi0MkVRCSgyuypiW0e2MUvPFLhHTolITz9+GLFFpDe3pHr6hiHRrOEtcM9qe+tt
a12gmTzZvQ2g9srjcb2j9pr6aZskaWS8M2AicCTlQI5xpEx0EU9mu8agJ5iA3uaPOJNyF2VJ
zun4CFEJXJm056dNDKwFIWdMd6q6nO7TkhhkuspxY3dvnFQU5JfX335B6eTp+vby/AB5uu8z
sbwsWC6tua5gGPIsTtpJBRXSqX7HDSadTNhyPwHBnw1Df9CmaNBvH/XNpleExkaV9CpErOev
Jzuyr84spdi4fvzPL8XbLwH2kEsJiCnDItjNx3psg716kaLLjKAfI7SR/id9VOm7va2Uu8AL
00IRMgknKjfuPMr5QEdDsigIUETdC2B1TPsNBwGcEIG9n5wloV22mXhLn1TQEtHfn+AwfQKx
91W26eE3taWMOgGTvRmyDCOMImBrwaZ0eRjzhrFjj4nYvVglRdYmnN3agNeBwqYJceWhJvRW
4oleZ8AImJhiiAmRXT++0fGGU9pW043NxqhrScZgpAzP1hak7UOR4zsQvKIfJ5ysSlrChvTw
X+p//6EMsoc/lRsKux9IMlqTL/JJlfGk1kXcz9jM5Li1NkEAdOdUBlWo9wUIf9ZqlwTbaKuj
w/gzG4f+ZdmUk0HULj1GW/dckznjduEY6v0FxD0ik4SNsYLoeQIM6jFPGsdrMIBFP7mGREIA
oHJgYlGHYvuZAMJLLrKEVKB3QiQwIuPANzHZg++MqG0KjAyAQceQ4zP9+hQCL8IITLlAGvf9
yskfo3oOUTaBi6T3wiNgFEYUqGOtS3ukaNfrx81qklEHm/5iCsXIrqahhfYcNovtnYnzY5ri
B2+1o4li3tqiR6MStq7xBEvKud/yip+vk1PcyuXoCl/WE6TAw98kCKvt7Yrmd/B1u76JdzUh
CCs0Qzo0QXhyGKagUhK1AlHD6yDVJQTenLniAKqL4btjda8PqpoOkDqPT1k0veVA6ORMHvoS
kzASHqaRHmLA2pKtWmL254wNdi+RsdjCBm9ehUpoYAFU6DAWiDdONWyhRx6LM2hSJY1znLQm
ycQLpT9czN4bzrvpFTUIJHVRYXyvep6eZr4ZOydc+su2C8uCbA4G2L7D7nfiY5Zd9FY37il7
kTcFd3I3SZxZxkwS9Ni2pnV8UG/mfr2YEVt9OOnToj6i1RBsk7ZlmCbal12SEoZClGG9Wc98
wXpMJnXqb2Yzg99UEN8IfND3WwMYEqC4R2z33uMjCVbYY2Thmxm/Je2zYDVfcnbjYe2t1oaM
XFf25edwG9NYASL6hRzGEct34a1A1dSGE2J5KjGy8wgIfH1IKM/5CFiNjAvdqzCwt/gLtn0a
jwEHA86zU+Mz0a7Wj4bJqIZv5kG7mkBBruzWm30Z1UQU0tgo8mazBbtKrHYMjd0+ejNrSiqY
bZ4yAjtY5cdMaUP6bmpe/vP08ZCgodFff8qA/h9/PL2DDPIT9VlY5MMryCQPz7A0rz/wp/nm
UKcHsX9Y6v+fGbfIqZJWoF+SQMm+HB9Ne/sJogNwM8A4vr+8yvcQJ1eop6KkKuFTQULz3cpk
GL1gT9l8nIciDfAJFNZYZ5ioVF7fi63IRScMEL6ZQzhhsvuNCTHQUmiGwgwHe+Py9eXp4wWK
B5H0+zfZ5VIB+en6/IJ///3+8VOK93+8vP74dH377fvD97cHyEDx1sYeC7CujeGg1daUBhjf
cSEKGgTCwVxaMT1kCBZA1cK8WETIjkiICoI5sKtvRJc8622UFXDyrYGHPOzGYMC+pCAvxCBc
6rbjYVVgF6FKBLLtp8SnX//6/bfrf6jmfWDl3EKfUR15NxDHw+jBBDIKYowAjLRkNqlvnGEw
vzsVOnQyFkUcbwtRhVPMaM8xaQjqSle+d78dJTVI67EiClYuVnagSRNv2XL+VgNFFj4u2nZa
8yALVwsG3lRJnEYtV6N92cxXnOdmT/AZdoDKFKiHQU0SNsekWXuP/GtNBonv3WqhJGAaktfr
x4W3ZCoTBv4MehZDld3A5tF5iq1PZzNo6gBOkkzsWC61Ttd+4M2WNxtZp8FmFq14d9ZxZDJg
S26SnBIBpbXstfaQTbBeBbOZx245KvSaUluif4xWnU2WkwxOlRVkN6pEEsrI6PydVj3xt+k1
dkxBRG7h1QbchqXZZIu9DIBnsILbIAzDuVHNE0LxfpljyBLZZJvzr7flBBYfaXBD9a2MdndK
SzpeUilcWux2lpGw2jyjKHrw5pvFw7/i6/vLGf7+PR2MOKmic0KFpB7WFXv2cB3wSicxTZcX
9YUdrpt1Gs5uNHpGkxV9F23bSGMg7ayAvt42vEPJOcnDWLDHANRY+4UY+qvECmxhRW0qcvoM
qhRaxk9s8e5o2QgNQKdqPfoig88S+2SU0iJBrYA1THIE+MaxCNHR0GGRPVJWxTEHuX6bTHzX
DBoZDPJuVhiR6RShrcSxnFZW0aDZxFakOvy+OVroLstzGKWN6vlD2y8RD0r2DdGtqKJjSITi
XcNZ0EE96iiwegJ+1YXjtqjCy1PeaK85cpUGaHeSk0c+ZkxjYJwsvUkPVjoRotnLU6JVro/5
LsrwToqo6qyFpyCd5884lqHHzsybIQ20HMA0NGDjT/XIItvMzPc0KNzUSvaFJLCJcvT+TEnK
k/I1ynnHgO7menOY7HvhFeSe669/oRyhDaeEEfeSe3PhnyYZ1i46A5Jh09pYstBOIGWDgDIP
nGtMU4hQlI0ZrF8D5DVqTCLimql2kYmJGm/utY46wMoMqgSy5NV3hLKJHOHXtATY1KzmzMgi
E1+LybYzIHkFn0kCO2PesK/nmFSVvZ4HDI5O4fRiHsiOVVHx/IFBpXbcgtecUjq8Trpd58mF
E8GdkuNk6++R+yitEy6GikkEbAaZhFGeONSCRiIZTI/r65DuS2OScLKTwu5nRY1gUlGXkDD1
D2SbC+2zo4dJE7DbeePLGuabP9vIJ5VX30p9O4HCf4T37qH8q9IaLU861h9Y4evDZS/OB7b/
oq/0wXf13eUlvv6Ww7LGEAsweHSPNzLA4JToosIfXQbhrih296n2R3GO+H3WoErW/pKVDUya
rflE/TaDgRHBFNJV7da88B/gDcBXiwkY/d87/eTc3Gdyg1lcXozLR3+5mlBZ+rgB/pWwf2Om
Ox7emNHoBij+s2AHW1qHkEXJu38g2NANy09TabLbkg97LgPoRC4yk3bHOccg2MwWP4e8SOII
o3G4cjgZZrnJglQUvnQcjzE7gJ04H7+Ervg482bcLW5iPhryOeP3z0xUp4h6bWWn1WIO0jjP
fWUn+9CuDzs2Jt7h4lOyi+9k680aQXVEXhj7Upa2C1jYEwANfCKBE2MSBLp9q4Y00rqca23a
LrlMl11c7hxScp+kYwNFALo+c1lq6PS2jCPCszoTjtDdksxpZyKx/L0S4OIzP02SgHj8Hur1
mjwCB99LDzIgM+lQfwWy1lkXq4DCtuRwkOEzeo49PrtUfFFxJNKc1+wZyXPRYOa36wA/o4pG
5/VN9v3UmoGW8Ku3KpcPiFo+kjTjqsgL/orVIDPl7qTD/KcHIJPslISJoduWjp5hZN3XjvTF
gesHoDcjIBj0Osyqcl0hyoc9sLYwtExulwiN+eOptN3nGeU1Stv3xu1LWuzuM22oOkD7o9vd
W5l2xdVqtpixzUWXzCYyWJW1N9+YgebwuzFfytSAjjzS2ANBEIZVfU5qEvCqx649f2N2EcLl
sw9wiKMBC6fYqNbeauOoOgyQqHkcxjKqHMNRiwwl69v9V0fmWywmokhBLoM/yq/G3E4EUHQ1
CegBO0LRROnecNcJryghJGSiwueGZTMA4W34eVBntfmIb5kEHn1CDwk2nsfxgBK1oLI86bAA
9Sktr1AxCRu5L95p65G8/lKWlywyI5Ipncn4HWCMJbrXHF0VveRFWV/uyo5NtD86PO5Mqjv7
78ncxeCjq/aWs9wAdAlBSIDhVQLyFINRxjn5agkSCtKdlzwjOqCtBxQ1HG+61HNn7rRI0z+K
5shC5NyVvlHvwa1Zo7RhAjLaadJEE4Rok17asI0ZQHhoEMUfp2HIjRKc3yU5mlENUGFoBE7o
y5RD4ykhxqQIJBffPVkV2cAtXh7kCZGWFCJptoJYBetcOxIJ2oRaj+cSFM6iKnJkpw2fQJKm
+6aksZ8BNXH7pE6AL5nWXhkQ0IyS8sti5m1ceQF6PVstrIxge8GgLjRAhsS0JRs4vNxfqL5B
Agwmuz4TnWoahXh7uduh65tEKEuoJHmAT6fNfR1Tj74wyTE5rz7LQhvXY7TCS5c8plB2k1tH
Mpg0jy2IN6QhAFw/MkAV9M3qhF65ZRcM9MuFt5g524KlLNZrz1GzIAlEKGgdtKKJAkMBa2Za
fliu52vfdxaP+CZYe67yZfrFms129Xgr0WpDKxgnbRRSUBKU6bG2YNIHpD2LC4WnsDCixpt5
XmAh2oYCtPjKA73ZzkJIKcZu3yB6ODtupGhcfTcIJrRE9caosCqYt5DTZwFMgTXjRLOezS3Y
l2mumve0gZKrs1uHDB3XOIMFofkAB+rNWjMAeFQJWAZJYI3eCQ6Uuo4oUB8eqAbyLWVQmZrq
u7KkH922DmmQegSGEZqHRxQ4PEg3NBKhWVk6greU+vkCO2COSVEIProLYCJaEntThnQ0Xi+W
Kug7tQiSzsKNyXXUpFvqdE82f8QObtVs9FdJUWeCWphLqLxjxF/EykFu0fvvHz9/+bg+vzwc
621/lyypXl6eX56l3RVi+tiV4vnpx8+X9+lN+Nm6dRzi6Z0dMZUxwXiFk8E8vk/GaqIoRUb1
hRJwN+Ob1xQmobwkuFOHic4yKc8+zy0ixjcVlxpgRA+1EDIYaGM6FfYYNLCE2h0Lk2fqkV+K
2q4Rgl1qODjmgMRMoSDOBMlZGZoaJZ/TxWa1JID5ZrHseYPr36/4+fAJfyHlQ/jy61+//44+
fYX9lEuf/UQNTeA6Koq+lfwnBRj5nBPTVVcDrOhzAA1PhIkCSHbKJqvqdlNkztOWjOC45hDI
Hxtxio2oP5NmsXNXvjkOwvDdSa7Pzft0UZiIf7Jubyn1TLpKaK5zPLUav3W8Xk8SqoPwPp0j
7rBJw1qHmATmQy7n1PNNuwD13dXEuwiBLblbBsiavQ06p7ZGWEFkjg5rHRlXurfdlK+032nA
10tI3ycxkZKZjvLcodQewkee64Q7KOX7X3otKQv2N/nM2vmKMRL/NY10/O+Hn98f0Pb35x89
1UROONOjBWorpx4neIY0NDx+o5WGg1Q6fyrVpwntr4JNWFxN8i1pkGHZXIwj/ElGjjfO0ufr
B3aC8dx3GSSw/wITYMwSkbeGGqYM5rMZ0RvGotJ8xCh+12l3BNnODqI48uwpa4JmRJ0fjcSm
uBjfnad3USPSOQOyFrhEw6dDGY0Rn06UpriohkkdOhyEiMbpBCKP5QqlDep//PXTaTiZ5OXR
jNuPn/YGL2FxjE6ANDywwuBVqvKlI+BaPr15IL7+CpMJEItbjRlCbrw+wc59fQM+6rcnKwqK
Tob2eXzMdUXwubgw9YhOlqNfD7YObaOzXL7gKuUhuvTW1+NljoYB08bPOYOgXC59fvemRGve
9c4i4rQeI0lz2PL1/AIS5PJOLZDm8S6N763u0IQ6yH+1WvNmxwNlejg4nPUGEltpxFPISRnd
yaoJxGrh8UbOJtF64d0ZCjWj77QtW8993gCE0Mzv0MBh8Dhfbu4QBbx8MRKUlUedAaY0eXRu
HLetAw0+/oBn8Z3idkUaxkm9vxVkaCCum+IszoJXN4xUx/zuZKmbzCH3jg2AbYh3FjOmwBzW
2Z3hbTK/a4pjsLfeDJxSts3degeiRP2Hc6eTW6GhusHPrqx9BtSJtLSe0+4x24vroeyeAm8O
4X/HuwEjHRzBonS8t8hQgUROldgDSXApqdf6iJLPdfZRIJk6RCnyaA5rRKMSEUqiCXvDP5Yl
BzJxlBQXAXLWAWsBMhaUWc+9KlQdVYnLNkESqMd4sAI3iFCbunnkHkZS+OAiSmH3IvYQdcCj
8IlunWJlg5wlnuq2bcWkTOviQHXBMA/YAkc06li4PhiOe3zjk7XukQTyEVkyhgqC+XYiiALH
mwkmVVK6RCiDai9yYFR5KxqD7LCFj3tEJT7Lx/azJlITCDjjoMgWU75Gzpw6qCLWwEZvH4l5
LatgInz0TP8rE2qPk8ahFgm3qslkJWTbTHimi7Jmv+btrNsem8ayEtMMYrve+MuuyF2bqaYL
vPnjet6V50pl5W5xBqf4tBaSVdhGEYntaKDCKChCixsfsadk6zD27TsokQESm4h3KRvYSWCV
c015i7BtPvPHfs+Hn9Hu6WYel0g4Fb2KIsi82a1S0AcFxGq08ZSr1L36ynq19L31ODrMZD2n
aEMy7UlCdWSFlFKkGWr03bmXQbxespukbsphPVtiBjAE7PBXRSOqC7r5F+F0hoRiM1vN1SS1
cWdg5Ly2I+aUekG16ZxbZxJMd2eFSr7U/mojps0LMgHSMKtBVQnDCA4BDLYFv7aCmcVhdfJX
s1aPJM+VGZSrJUfJ0D32dBOZsCmzJPDsPquyZGqdKIG8KZ5EwXFk5RCbQRN6iNwvCwvuh9or
3aY3XwXREN+GzGcTyGJS8XjJM5UaSeQgdefw9P4sw70mn4oHlNFJmIzKcoGx4+pYFPKzS9Yz
0wxRAeFfGoFHgUFYt0RFDQ+QAeRuViQ6TbaE7VRQ5QFEQPrqqy3rjkmg3UAUxq5B7eMFFdub
OnUVdLcqKUqukkpMNOFHqxd3IotoX/WQLq9B9GbgKZkJAzjKjt7swDlSDSRxttbBRbQGm5sQ
Y3wDRqejNCZ/PL0/fcPLqEmwFXWxNlTuxKl08WX3DWzZzYW+o6kuFBDMjkMqQ3tj7F502pvM
7frl/fr0ypg6KFZGhroKiM2oQqz95cyeEBoMRzNICgGcduGNKKBmAm+1XM5EdxIAIg8tmUQx
3gcceFygfPt4pHJUZmvKR5MwKfKqO8oQtgsOWx1zDJo+kLCFRG3zf4xdWXekuJL+K37se2b6
NGIVD/1AAplJGzIxkEvVSx5fV97bPuOlxnbNVM+vH4UkQEsI90O57PgC7UtIiqXcFfgbqMKW
9W3JWux4yMwlYKrISddpURunr13f4PRu8Ck9Wxh47JU38+MF4O715Vf4hJWbDxV+SYw4eJEp
VM15GjXOhYHxQTVBtcvdKrpdrkJUuttM9Y8eu+KVYF+tqyP2lQDGZN0J3KEf5/nujJ/CJw4S
V32CXhpIFrnK/jFkG7T/DXyhBRycl9UXcDe1VEz5JXy1xCa3C7ZbmJxGcrrF3kz9vJ2BiU08
EWiAGGDX+lbzMNo8U2ebIYnCq0Pdou06QwtNypmqHfi6WK5yDlqv3Ad8talytuB2yPg1WbSM
J8+k2qpspNHkQ1dbvjAluAM/p+C9v8NP0C0TSco2a9kh4cgGBdyVoNrG07WgpvShUqUfRKTd
dpcNOg93+6971ek79+dn7H3C2EBEUMZO2hzuNWW/7XH0Y6/TDsVqg7QQ+K/Ar0ugUm3H9hnV
/cNEY1vtsax/j5W27PgbtaOd8fcQaQVu7VgVE7/htqKoteMMUHmomEI4+FFUIgABX1zi4hY/
IQCTfInnRV0bDvtUPjUYlCCwddHK8pRBEN49qlTBiwRH3f16raW1sgqh9NRJeiZASDwkCRP8
NB+XM7rKwkDz+jZDopnRRpmZcjaRULMAuOgDTcU5U1Z+UYj5qbI83hpeIMdhfex0rw7wamtH
dFBTcsRzHHL2r23wKjIAv7GCjypHYHiB8UtDS9UI4WGrXrUrVflPRXeH434wwVGlSSEdB4hV
1u3PX+x0+iEIvrZ+6Eb0kzfbfuov2hX1SOGuPRGydPk6xkOypHC1n0TDdod+uECEAhEexH6K
ZEdf+7lWux9grcPfC8D9rjaH/Fy6UscmEIBb9pX2VMqIQvtb6Cj/ePp4/P50/clqAOXgHrKx
wrBddCVOUizJui53qnWXTNTaRGY6+4kvKZKjHvIw8PAXupGnzbM0CvGnLJ3n5yJPV6LLjUSb
+py3daF28mIjqd/L6DBwPNIbx3gG4e1Zb/ararCJrApj70Bm0+kQYnzMPSO9j92wlBn9z9f3
j08iyInkKxIFkaP2HI0DswPdrr442hRJFBu1aApKCDETqqjn7jx2rERvlhkEPrxCPYcdN9vz
zRyEcR8bbgdnPn3FDvSpqwkYGgeemSwYRMXoGx0DNTscSWCLk9qF73+9f1yfb/4JQVqkv/5f
nlmPPf11c33+5/UbaJr+Jrl+ZecjcCb3D3325bD06E8sQC5KiGLMwybp5xsDNOKfG6hyRnMw
6I7iAHWYdPCuXDWXSndNxycX6uYZkD1/V9ZzZ7NALZfRH82AehgFUA9pWP5ka/MLE34Z9JuY
K/dSh9e6pODZ2l6qgTxk+54JRraq4/7jT7EoyMSVPjYn39rhhcw5yY1K4wErOWT3LidJz6Rm
ZYQZLrS5c5ZIV6NsNfqExRWQSN3TpnIFqqNXiLLLKDLEjCYKnRQAPzu26EVLqxtEb3uMq9Uf
ydmftlqvWFzb/ubh6VG4QLVCO7LP8roCU+NbLlXONVMgfltm5iYxOdLwEo5McsZP5fk3BJa6
/3h9s7eCoWWlfX34L6SsQ3shEaUsUc0VHdisxMJORyujxn4BM2askAZXMVC/DZRreZshb9RN
1S6wUoRqB4dS7BzJGkS7tpIEHgIA3G7LGAERmY7t+7WxcI6fVN2d7ktFDGmbGVyTq0rJnGYF
VOVUrrPjzeKViILwfP/9O1vj+ZqJrA78S3CW6TLUFNFk+IWKkZ/lFEi8Zp6yVlNc5NT1AP95
BFfiUiu15AtV8HVIK23rU2GQuEH60WqkFY375Gw2ctZkUeGDYfjqYGLWXZsk77FteeyzXH8r
5GSxPTjbuCku63yrCX/uLpw2eE69/vx+//JN21FkFCCu4mfUSFJN9+US2+E3gKLtIR4udv2r
DEDPSpPTfVwIFw8kIDkHzpbhcOIZtRAPr2crt6Gtcp+aI03ZG4wWE5NlXfyNlvTNMmRd9XW/
y6wyrIqEUJ+6KrQqWH1IczqaQ7alSWCOTSBG3JzDaDT+NO0cgqCUZqQkVcxMKjyhezTGyD4x
xw4np8RsCPnGblDFAzVCjBDONA21sW/3yOT1eLGnVgM926OCR84Gu1uC+fIdWUrBo57hxRt9
kQe+dFKnBOE1y6cNjc2GHfYyzZRIzIa97o/ypB1WTgQu1CyBgPz6v49SRGvumayu6egTKa9w
DdH92UhOYkXvhxR7vlRZyKlRCzYC+oI70/tNpTYJUki18P3TveYznKUjREXuSkdLX9B77bJs
IkNNvMgFUCcAtiqFjJyKcZDA9WnsAPzAaOsJoh52zNM+Vl/4dYC4AFcBg+CSd7kLdLRI5J1x
IKGOkiXUUTJaeqGzJUqSoEuxPioUAQyuXS/ZEZX8OMb9rSjS3ky8ZH2Q+D6O6aPYRODXwTDh
VHnqIffTCNexUvlkMp/yCRnhb7JNd9GYnkrJI5BKx/vzOUV8qKDo/S6bYkYKWiH6Q9vWX+w2
EfQFv14am9uhVgvW9sCKLcpSIMyK/LLKBrbg6EbjUn/P9bnUjjLd/0oy/0qnwiu6pM63zBBf
2JUDXHCC3wWQDbxYW8ZleS/5yfeIww26ZIGJFWMKViqDOiU1OnHQfZtel5v9pTwGNtKvtHPp
WC9GxjRxuaerTn5kpLS688G1gxPQ75ZNcFvcucFiuBzYcGE9Iq2SzGpnqaeuqWMtGF1TDVX4
UTobVyTRZBkD8bGO5phPcCF3LAofsh52nTlygLDnJ3Yl9LVrTo93hQ3UQxCrxpFKAUgYJUgG
RTnwgM2CJVavVbXSpwk2UlgfhSRarjznSbGBrnL4EVI4AJIgcuQcGTkjHDRFBkbfrIIwsbt5
kx02pVjvQ3RSj0/Hi9O6GyLPYWUzFqAb0jDCF4eR5ZD3xPPwXWeqYJGmaYRpoBq+Nvmfl2NV
mCR5KycuJISqzP0HO2diFwZTiKciCQmWqcagyB4zvSGeT1xA5AJiF5A6AP1BVYVIkqAtqvCk
TOz7hGdg9UNdlWkcjkIwKMa7VeNJPs0gidAMmBy0+GmfJzHaCWcIabmDQwg7S9QIA1fuQujD
uUXrmrMfWdVdIPb2YoWLPnaYLM4cJHbYk40sVXR7yRrcAGLkWSdRkES4Kp/g2KimCyNxNATI
CgTc1BGhfYMCvocCbNfPULKPNaO4RkMVXEaWbbWNiboFTo2yajL9yV9B2hJftycWuF5zCnAj
1x95uDycmRDVEd9fGpR1tSuzTWmXv97nW7bT6drlE8gXanwZ1XkSh6a3xpUi7QcvxCRCRzdA
PsEOexqH7+Op+iGy3nEgdpTDj5FZC5t27MXoUsAx1G+ZxhEjSzUA+oavIAFJgqXehPh26BLD
gQBZtTkQIi3FAVNLV4HS5eVcFBYVPea53QbopjTkcRSiGZe7tU9WTe4Mrjn1WhMHSF82CU7F
BkSjimwKFemzuqHYyGHnG5SK5kbRPq+bxSZkMDbImxTNmB2lA7RdORRiWuw6B1Lw3ZCLu6Sq
H/boWrHLB3aUwpX4JUfLndPZifPr5lRbA1qHreL4Sb8dCFJMRsZGGiMHP7FCMyBfag+pVmCn
WLIdK/QCLE0G+QQ9iSgcMRxe0RI1fR4mDUmXWrIfhj6JsIo2TYwvVWxnJT4tKMFuzmemnh1v
Kfo9KzNFo89Nm9ku8z1k6QG6fmusIIH/idAx5AluiDMxbJvc4QhhYmlasjgyOQPamRxZajLG
EOI9CchigzGGiCAz+FhlMY0zLM3jQP1gKc0TDZIk2GDfAkQJru+r8qQEN0JQOPzClUG6NO45
Azo6BQIymOOBWGGsExrp5h8qFKuOUSdofCyxM+aXU5h+o/BBP6clCeDlRfciOgL9kA1Vr1vN
jVjZlOw8uQMTHHnbyA6Gdfbl0vS/eyazcbQcyfu1TTt1FbcqBj+lLZJvUa6zQz2wY/URXB+2
l1PVa1eZGOMajhQ9OwHjiiTYJ2B5BQ5jHIG+x0/cqSOMi+UFBnCCy398ktBcOOWioj0oXTyf
+xl53ZV3iyEIivLo4rG6HUxtK/29egRNpYD5UU25nF0qx4KSdQ+G6Pu+r1aavVO/0v5gjdKp
6sv8q7za7vnFLPL1iBqpFNXe/GaeaAqDo6BC6RnS5nY7rlR0tuW09Du9VQ5RUZFkAbDeA7la
6L9+vDyAJy+nl99mXdhxLhgtywfKjkyYMTSH+yBRbVRHmvaw0vDONx7FOWc2+DTx8Iy5NT+Y
n+CxxWaebZ2rx2wAuDsKT5XNOFV5S9fzOre+dzaPfBpLAzrRWCvw2vEL5bOZLFAjfzFZzoIf
SEc4RkOdjGCgV9G8qQbaJhvK0767Ne4qeK1yEpzNZpJEwzMHAK0fq1doQNtW7BhGeCsoV4UD
qCj2Va7JIEBlaeJaIXXLwFzx8QaEPt+abVrd9bFDPwTgP7Ld10ve7F2O+IDntmyMMmgwpS07
F2F76IxGZrE4Ofawy2UxeqbLdGNUnZPEdZU1M6A7+gxzhQzksxS/U54YaIhJNxKmqZcY3S9e
0RBiilWMkTFBk6NDHMSe9Q2j6sdzFRzP0OZXXTngatQAspNYxOaIq5qzroZK5LfxVjZ5NETU
mdAtVbUJOGkXDTGhZjp9mVs6rSpchUl8NrSkOdBEulg+EZ1u64Hh9gtlA8+3P+zxNSlbnSPP
Wyyh1BYShtRD8/jw9np9uj58vL2+PD683wgXV9XoN892WscZJg8uo+3f309IK8yoPafQhood
7oIgOl+GPhcXsFrd6zZIQ/fMgGc16hq4LO26Oej5CeUqRVZt+5h4kbYbCMUp9AlAQIkxCBVN
K610gu6Icj0x+MQ1jaAChuaYQo7iCCmGb49iTqeoscEEC80v+7OULG+JjIktvwF+jB5OdegF
zgE6+m+x5w+4d00CVNKomyByLhGzIpxeyLvmTDH1MACPZxoZDaleS6uCx6QUaBPt/Tfvw6T2
Q7MspyYijne/EUZHngDl6m3SqEULPc+iBebiKVUmrKKbmnwzDeUVCn7qarrfNkJV8mz1xYgx
Wcs1b+fPfaNi0gOMSWzWmgbfogw9fjl5IlILOLsncnnlnjlEIIbjvh60p42ZAew7D8Keuj9o
2vwzD5wO+eFwkYvJKxs2fzEIJH6qX7opYBEF6LausAihHk16PC1gKfNTw2LKtlSvYFPnImnL
gbOcuK1oq/TdKN+jiCqEa4ivL4EGht17KYMh20VBFDn6gaOU4vvAzOYQDRSfWVx8x/MQ2DFC
n25mtqqv00BVstSg2E9IhmFs1Y3xJkWf8BSY7d/JcttxFh9NG5Rm8FyNbVFHIrR+1p6pQGLj
cEFxEmOQrXSjYxF1fUbjEM2MQzE6Gy0h34B8x9jjYLQ8VTlPgs4L5MSggfxA81niCbzNLCRB
/U+SkGdcXVDQ8YQGjhwYSNEHDZWnJUxSQwdh00YhiR1pt5Q6nOnqTDF+CFaZ7pIUfURXeNiR
S3MxNiGTVIukDEYWIXomVXjWh68l8dCB1x7ZyhU7lkYOfrqwcS70jXHmuYOoS9LaDgfBv+XR
8Io6s/BD3SflkKe8xXKA8OHIwVL8sliUE5yN1ZtID6msYKZco0AsRS9GF2UGUT9EV0EOJTsM
YhJ7ROLAMR/H89AnLQlsfuBw3a2zsWm13GjKmcqZBMWt+A02EuCCtcHmfzIEbFMYRaiDJyK8
pEKa/qQA9pMPzhQ6QnRoTEzw/oSJT5w6W1UrXHOqc95v5PLqQ5G1IUAEp4P2t2HQzNm3SeDj
PcB90x7qvqTA6WTpsmrXb7NifzLZtDIg+WuADGOFH7Ik46rojtypQl/WRuxIaWX57fF+PDx8
/PVdNXCRLZE14IxqLoyGZrus3rMz7tHFAN6VBnY8cHPwwEQusC86FzQFLnHgXPddbcPJKtGq
stIUD69vSASIY1WUPISkNU72XM9QcxVUHFfzmV7LVEucZ3p8/HZ9DevHlx8/x7gmZq7HsFZW
2pmmH1IVOvR6yXq9rUw4K45T+KBpqAhInPOaasej6ew2qOUyT74pGx/MLrTW4Mj6tButOGS1
seppjT253bAqb7YvNKu79dlicHeADhe1FqZ2T9f79yvUgff0n/cfPFTMlceV+WYXobv+94/r
+8dNJkzky3NbdhWExM5qnp7RlVbRRQCnx38/ftw/3QxHu0owMBoR0WN+6GS0HRp+mXNnZ9Zp
WQvxl34nsf5Z8WWXwUMP7zSsuzhTCZ5Zejb3q/2OHWN6UEfc6IP1UJfKsBiDQ9kVUVcMW7Na
zsq8GicdvhTz2T7Wybn2QZRtVl7ptXLs0YfX52e46+CZO+bL6rD2jSV9piNzidPZeN6rb/sz
UjRimFUbNL0mq2s1nHnfgEJTtttfmmI4otNzaDfavFEiME0RdYzJKU3VsRkp5vWo1Gx853Id
JFCnPTcUaprlrjLNywB3JVa79BJggJk1xPVj2FK/xChGX5P/xiNasWRHdyTqPT40P4/22+mL
k9gNrJBFsluqxl5JK1Y9u9bHCtxc51a51o9v1xPYA/4CgY5uSJCG/xhDHhorwLrqSm1sKMQp
1JC5W6lm84J0//Lw+PR0//YX8m4utuZhyPhbJf8o+/Ht8ZXteg+vYOv7nzff314fru/v4A4D
Ygo9P/7UkhC1HY7ZodD9UkmgyJIwwE6bE57S0EM+LCGcTIQJPQqD+iYvR1vfBtplr5wYfRCo
j1wjNQrCCJlGjF4HPvZiLjOvj4HvZVXuByv780ORkSB0V5qJqomq/jpTVW1hOY5aP+mb9mzS
+/3uy2U1rC8Cm4bB3+s+3tNd0U+MZof2WRYLhwpTyhr7LJOoSRjtwKSIhFDsnKvigVk1IIf0
bLcrALGH2eLMOA0tGUiSQYQ2odVAidXkjBjFdu6MHGP3MgK97T2iGrTJ0VjTmJU5TuzkWAsn
+NOGilv9zm/m2JRCZoxEHEeFcaK2kYhMYX4NAHotMuGJ51ltO5x8qttEj/QUNwBU4NhOLNWO
meMMOLNjlD3Rs3Pq8xtFZSzCEL/XZgAysBOSWM2an/1oXIdUkRQd8dcX14jnqfvY+6WCU2vq
84mQIKugADCrixkPQnQGBSlKjtQbM42MzY+sSAOarizyLaXI0Nz21PeQNpzaS2nDx2e2Mv3P
9fn68nEDvtisjjq0RRx6AcnsVhEQNZ7BtSzt5OfN7TfBwmTE729saYRHMbQEsAYmkb/trfXV
mYLQKyi6m48fL0zwNJIFwYUNW59IW7ZRfcDgF3v34/vDlW3bL9dX8D14ffqupGdOtm2fBAuz
rYn8JEVGF24lJCsPgW3aqpAX1aOQ4S6VKNb98/XtnqX2wnYc22m+SHpbRdj6WjWsZdyLO4et
tRqokbWvAzUJMWpqrSOMGqDpBpE1T/dHPw6tFIAaWSkAlSKNzunuGb0/RmgWjIoIKpzuXm72
R9OcaP4MNZtUYKTyUZyiZUj8CHvSmmDt0WqiotVM4gSjJhgvpZG1heyPaYyJk0B33DOODCSg
EXYRKnehPo59ZKNrhrTxHD43FQ7HTezMQcgnabQeamsw4YOnq1jNACFuUZThR8/eEjg5sHZ7
IBObu++8wINosnb+u/1+5xEOLlUvavY1eo/E4a7I8saWALo/onBnFya6jdXIaQrV2hAZNSzz
DSIOMSRaZZgbEoGXAy1vNfEYX/r4qlgzmn34GnfYiNpVy26TwJ6BxSlNiLWsATWmdhUYnXrJ
5Zg36D6pFUocTZ/u3/90LdpZAU+CiNgJCkiOh4+JIQ5jtAx6jmLzbCt7txs3ShMz7nEPO367
KnaiH+8fr8+P/3eFeym+uyJ3UPwLcHXaorENVCZ2UCUyggqOUm1vsUBNR85KNyFONKW6laIG
l1mUxPjCYfPhxqMqXzP43tmhn2ywObrcYnPoKupsfoy/ZxlsBF0BVSYIsksc3XDOfU/XsdHR
CA//pTOF2oulVr5zzVKI+iU0sd8eBJqHYU91ozcNB6ExdmjaW4MJfc5T2da55+maTBbq0Mgz
2VDFQ7tAviuvMvy80dc5k/BcjU5p18csDUfDDocsFfsiOu99onphUbFqSEngmLIdW7BdHXmu
A490axy9a0hBWLOFzvbgHCtWnxBdL7FFTV3t3q/8unP99vrywT55Hx3Xcg3A9w92Or5/+3bz
y/v9BxPiHz+u/7j5l8IqywO3jP2w8miqyLSSGBPd7aUgH73U+4n04oSqU1ISY0K8nxiV6ESY
OKrSHKdRWvSBMBLF6vcA7zY3/3HzcX1jx7MPCMzirGnRnW/NGo1rcu4XmLUHL2sFE9Io1o7S
UNXcmolTSRnp1/7v9EB+9kNithsn6s74eB5DgIp4gH2tWZcF8f9T9iRLbuQ6/opOL+yIedOp
1H7oA3ORRCu3SqY2XzKqbblc0eWSo6p6Xnu+fgDmxgVU9Ry8CACRXEEQBAGzSAOmgiXI1s22
Y8222o2kv1zawx/M6UXcF7Inkhx+m/3KM4C4dXpLq8E4QJ5HOlp1pbTwEQg8xGJ8Um0ikrJd
7JHuiTKgmmEwS0n+J5OeUaujYUBvbwOeOsINA24vOZh9pEeorIiAfc5oDCwXq4EYIZiNrZnR
9K3uo9hP3Wr04Z8sKlEsNSfaHnYiusdfOGdPgzVWlJycur9Ou5DpZ1GITOCUvKSUh6HFU2M8
s1M19+zxhLVGeg92i2oyMyZLxAPsezW/pgoOLfACwSTUug8G+Mq99tp2LXVebL3yxtaKisPx
zTU80U3YzeBEPuyEVMDAHj0dm/4OZZX4y4lHAa0hlUKWUmZkZ0dj2Grx2jqPVOkatvLfOTlR
ECzNBdL0le5MrMBpLXYQcAtrtbBKQE2y68vb9xGDk+Hjl/vn33bXl8v986galtBvodyrouqg
11e/9j+BJu3Rejni83I29h32gw4/Ji/hEBuEcIIbWxM92UTVZEI+ClTQxhbYQlX/vAYMA2lL
MVzInmsPYvvlzDeWfgOrrUvRFn6YJoSokBpFE0ZcRLdFmF69FRkwol13S1qe+p7Qvqbv9f/6
f1ahCvENrmvgpGoxnfSB8DtHDIX36Pr89KvVFH8rkkRfCQCg9jxoHWwA5HYoUfKc2xzW47Dz
b+lO8aNv15dGy7H0rMnqdP5kTbMs2PqUObRHrogihSNQSY929Rk69U/NWSuB9tpvwO6lj0d+
6gDUzHix3CTW6gCgqcyyKgB91pSIIHfm89nfVpVO/sybHZxVkuch33M4S3bin/TaReQ2L/di
wsyvMhHmlU9ZSGShOImz/lFl2HjeDC8fP8TZzPP98cd3cid1e4a3cmqlhXYX4TrzSKbV9fr0
OnrD+7v/uTxdf46eL/9xr7Non6bnem34pWiOFbYXhWSyebn/+R0ffFqegGyjbdeHDcP0XlTT
1Jjg8EPeu4DGpuVZQXhUgKA7denGaE5tiMvUYNlARZys0b1Fx+1S0SbVosrAR1NR1VVe5Em+
OddlvBZmxdbSjbCPr0HPPaDD3Gw1nHYj9GJJMeuRqxGFfhmJsKoy2oQp+8iKAyUJ38Qppnkn
cdgJLhyWE1t0YaKwB6NaItzGvUKCN2zt7ecI5KJh2FRKNXnkQMmb69yaVEzJeD614dmpkAbC
le4rYaHNew8lRYSrbo0KU6aKNXi4AVXAapVKFsV6cJUBKh/2FRWpKwIRS6NNsddb2MC0FJcK
OOQ780sthvgSRbbBBLJyiq9t5zEWFqMPjSdNeC06D5qP8OP52+PDXy/36E+oCZGGcY0Fqb7+
ZwzbXfz159P9r1H8/PD4fHn/k1FIfvEmG7VDs3x/iJnS+S2gS1MeVifbcbqjaZxBZyS4i0n0
+4RGp/Itet8eHVnsHWGHlSrLkOcJ32xJp1hcmpvYlBmwzo35JCpzIqUbtvHp0xBO6JCVmD5r
G6XG1JSY5BBZ8vHuRMUlQkyQh1uLvM03a2TYUwgKlsl8ndp8Ke6fL0+GVJGEsO0Az7gUIJzV
EEIKgdiL+rPngZhPZ8WszuCMO1vNKdIgj+stx1dw/mIVuSiqw9gbH/cwUgnJpe0kC97cxFCY
OOERq3fRZFaN1fQQA8U65iee1Tv4cs1TP2Ca3UAlO2OoqvUZVFx/GnF/ziZeZI5BQ8wx3fkO
/1ktl2PKWUKhzbI8weyY3mL1OWQ0w08Rr5MKvpzGnuO+YSDe8WwTcVFgaLJd5K0Wke5ppfRn
zCKsaFLtgO12Mp7OjzdZKwWgGtsIDsQrqrey/MCQTs4IzWLXk+QJT+NTnYQR/jfbwyDkJF3J
BcZe39Z5hSFqVoykEhH+gUGs/NlyUc8mlbU+Gkr4m4kckykfDqext/Ym0+ydDi2ZKIK4LM+g
X1X5HpZeWMZxRtWjZOeIwwQu0/livBq/Q9K6PdkkeRbkdRnAgEcTkkKwVOxhOop5NJ5H75DE
ky3z6d5QiOaTT97JcxxbqALLJfNgKxHTmR+vHa4MdEHGHAeNgTrmu7yeTo6H9ZhOoKHQgmJb
1MkdDH45FiePPH2b1MKbLA6L6Kg7PxBk00k1TuL3m8crGDUOe161WLxXBY2WlErSTZeFp6k/
ZbuCoqjKfXJuRe6iPt6dNg7ZceAClOv8hBNu5a/oZ7YDOazDIoZxOhWFN5uF/sK/qSe024e2
OZU82pDSuMdoO9Bw5gteHr8+XF5NdUXmo4zIjJESvYXerIA9KsKmkO8EIYAymcDB7CTcU2rL
517d1lGf2fICI7ZGxQkfUG/iOljOvMOkXh/1z6HyXFTZZDq31iRqtHUhlnPf2mB6lO6CJI8F
HOcLX7riZTU0fOX5pMWtxTaxhDUg7pjkUFVbnmHOqXA+gb4Ze761eVS52PKAtZ7Dc/rxJEFI
OxIQhKTtFslA/q6LqbmhAFhk8xnMkOXcwlRFNPaFpwYalvqbfFcIa5Blp7nhzG/iF3QYDY0s
KkwOMtty4yLrOq722qB+Xm/ANduihdIV1E2ltN6CGovUXmFqNeIqYwd+MKvRgm9EyJQdUIbF
xjiChbwsQTO8i1MD0RwNrOkUrV3dW451z4tWzb6xEshnalI5NvQGwQ7MnPrxqXn2io+XY1GR
uiboI/hiT752u9vzcmdQYfbSJrt8J+fWL/c/LqM//vr2Dc7JkekmtQ7qMI0wtL/a0HVADijJ
Sn4kuP/y59Pjw/e30b9GoFN1z08H81LPGjWuMGECc+seOPnoqz8gaYRq/QaKJkrMTSZWDL0B
JR9WHxM1YcaANGMtDRgrsKaGWi7nbtSCRvXxe4gmyqgt9L45EHUxC272hBk5dMAYwU6Hbx+g
nYukoHBBNB97C7I5ZXgKs8zRnDgiJ9c7U6j7ivTOw1xorVlLmf+9NGs5WlbOjlDk+0zNkWL8
qI20zQgqwlQHiPhumJgKvGTHlEeaVEVwLgRaGslRbPk3nyUGEPHbsquUVsz9RlYj617U50lU
MzpDNtahzDEXud4eOIIHuYglUreh6lieVTvn911xuNqO3OPrz5LoXzRw2+C2L3pLjUWAA1DH
BxCUNM6GHnhpI9JiP4Vj+Z6VBh/rnaUE2pWFzTkvjO4kP1QV7GB2bVoJh27TVLrkLKn34/mM
fP401N/kixMhZZl/cjPH5KmmcXEb/VtaAlWbag/TZirmDCxj+XAYdsTP8e/zqcG+oGNHIA4f
ih65I2y4bHhuv07d8si+ydhyzTwCP4eEelUJZ4xqS/QbkMEKVgvukTtVG+TYxtm2aiR+Xr7g
RSaWJW6NsCibolmBrgKcvcr9yay+BNZ6lkmdoKA9giVuj2OiCEvsjzjZ8cz8TLhFY4ODDRxF
4NfZKpPvN4ySXYhMWQiz4ax/G+RJxHfxWVispGeh6/NnmFpC6KxgxDZ5Vhph3gdoTSbmxJJx
KgBp1gBDiZDxryXyM1Ra//4mTgNeRgZwrV6QSUgCylu+txoM/KRZxzmsuzO9HBB3ZEmV0ynB
EX3g8VGamxyt2ZxLK7g8wjk+yXeU4VWsN+wTC9Ts8wiqjjzbMovtLs4Eh5VHJuRBgiQ0Mn9K
YGyt5CTO8gMVZk8i4UiEa8vg0kLxR6FI5R6uTwQEl/s0SOKCRb5r1SHVZjX1buGP2zhOxK11
m7IND1OYGu5xhiMQWm2cK+y8BlV5a3ZTGTerwFWMh2Uu8nWl91SK9owythY56C8Vvz1Vs4pS
LhADu068MznCmQbPd7Aw3CK2iCuWnDPaj0gSgERChZH+bpGwTNq7QmEKILwQMGskGNrOnd9q
zYiOb8kwFXpmDwmuYpZaIJgTsHXERq2Ae5HsDWCpn9LlwkUTMBNOQSlS0Fo+5eeW2bCFKnC3
XKz4ITcWdF6I2F6HaK3ZuERltYVzeNUkI1cLqnB3Hfa4EdeFmOgVOXKe5lVsVuTEs9QlDz7H
Za53agchhP/ncwT7rHPJNElf6u0+MMatgYfQMIyAJ3/pFCwptCe5lIrQ376TGg2adDqtRrkN
12h71UwBduUxNle+DXmd8KpK4jrOYKNV7hEQTwTlQjCIYMwPQ9vCkWCfFLw28m1pBPDfzBUb
FfFwZgTRzES9DSPj644SoKV2Ng4kwqYqulYPL77/en38Ah2d3P+ifXiyvJAMT2HMaSclxMoM
jweriW1/3/iSwYZFm5iOHVSdi1tR1XIYMnHkFak0pqpLbnEs8VATU0DzshJo6gBU9R0Bao+V
vy97/R5jz+jnISRuvXOUCDZNEJvt9fUN7/A7/ykrLj0W7iIzKSARbUNOgGoMrRSGoADm6ulr
wAfwq5nV9cQPeFUH5wo7DRRjVakYChTmd0CZz7d6byrUSbXWguYMqHzdRimix2agivF/FHPA
bZNjRKHa+EgUao3/qpd0AyrlSRCzfWVW+BgIVy0rvgbhFZklbmZURoIwWNDhzgF3kGHurB7d
QyX5HCa1UXc8peDdrTUy4Z01KbbizqxqZ8o3jrAKRVrt6CE8gU5Je4Epg5Sy4uYIs9RISJnC
GaPi4Y4olcVHFKzKTMZfjdFTU0V7aC21PFrTHIikngY6UU67E0nKoERjXAZLqd4e0Tkv2+hz
t3kCHEf2C2BZnmUTz5+pt+ENGHMSTgxgEKbziRoEfoDOTKhMDOBRQN8GatlIe+BKfbcvoRg8
12bQQg3bp0S1IL3LZBILKtJDj51Z1SlmMxnxOE31M1aPJZ21B6zZlQic219ZztTXgh1Qs0MP
TdbTZKhw1/7c02jRwyW0TT6Aiev29qR1psaTWDuDkwT3cU9d5YLIX3pWJ1ST2crsLstQL6FD
oGkVWoUMA9ha1amScLai3y013PrY2uaU1R2hG+IupY6LGxeT8TqZjFdmR7eIJg2msTil9/of
T4/Pf34Yf5SqSLkJRq2h/a9ndJUktM3Rh0GD/2gs7wBPMalV/Sb3i1uqpMkJRs/VNvRxNDtd
JndxLhBczdQjsx6rxUtpOA6pYPpeql4eHx5sGYYK7Uaz46rg2jK4a9gcZOc2p3z4NLK0ipws
tjFoUrBF09qgRkr6DNKkYUHnZtKIWAhHPF6d36c0RQJN1SVy1CeHHIDHn2/4WOh19NaMwjAn
s8vbt8enN3TflX6eow84WG/3Lw+Xt4/anaE2LCXLBF6Cvtf1TWRfZ+8XjDaLaURZXGlxYA0O
aE62p23fyc7b80aJ5QF66tFjwOHvDBSZjFLVYjii1iAh8eZHhKV6FpUoy/EVoWo1JVXrKQtr
ek1dW0saK5quhBZFOKVTe1Qh3kCrBRAk1RLqZhwz/OEVmu4s10Pte6PGcydl9kU2E+cM1L8T
6P8ymymqNNKVSZ6Yhq7oz5l9AejoqCMf6DAwapxtmotxBdbng2kKCB2rJlhFPbZkdSo2gFHA
adj04NSDAwNsUSoyOtbsxJGVNl5rkUDPp5Sxh0vfIw5I1dm+SE61xrgJhlp/Pmd3aVFHhYaU
1+Bb5FGnm1Q7MAwoavyOsqZWhqcWfqOEpt0DMDZ7AQFIpafwXNdFRKTbRFj49Hh5ftPO9f0I
O2qfMuNZST/kGMJ8eJ6ZsmC/tsPxSu5rzTlZHCVUMak0hY3pDZA6zQ9xneVw4qIFQEvWPX6h
DSstEWwkBW2WMOqu9M3+1PqmkYylswlld9H1YvhZh5yy4CGmwODsmzjj5Z1ZKMJ3KQ3KUZip
L2kQAMpDmKvWQPkJOHK1d3A6AgT3ySAt9/qxCoHpeu7T96CHNakK4/K3738b33fzN2p7ewuo
Tf0BRngntcgAr1IdWldLIsPqOmqL9UjNILc9uPP+aX0Z6Gl2iAoyqKzM2MvzKlFDLUpgydUc
2gc94W9DYnSOhMGomSAR6k/KGijeW4jO1NP0nCUVZHbD1+u3t9H218/Ly78PowcZ/1x1SuoD
BN4m7aq0KeNzoBqS4dyz0ZoK4jLWvT8aiNMFokc3CpRc8/xzXO+C331vurxBBgcPldKzPply
Eda3QlK3dFwwikwnwilKBMtusUt/NnPYXFoKFsFfXbpps78aLMNvjD39Rb1NMHO8EyUox1Ss
DYJO3Tpt9FzPf2cR+B75St2m8/XADBbBZOxws7UpZ6STt02nZRru0QmO1dxXQ0vruMVp4iy3
HJPdJXErLRKOhVuSzT8gdkxbEE0i9TBv4Sa32PuU6cYkmjvZ15Eq4DtcWiQhYmBkdcGuERSh
P5m3eKt+HcV88s4Cagm5r7tEW2gyd1xLFeLVbuhsT8SEtyQbElV6KJYOfM6kmjb2iHm2AfGz
LSKbGey6J6oNPCwa4+UNOcnugpyVke+Ra+lT+U4v7jBH4z4zbiS73pGXStAJ8xtzpSeymtVi
IuZknUKx9zinDQOjx+Ip3eA0xi5x88x4PZ/5C6KkxJCnOIVg7lGiDzELMsbGQJCwoAgdcz6T
24nrcKwRpaQW1pKUVTQjBIKY+3O7BzW3leEboAiBCmRhYEOzhRzuciSwFtSY75p/4UD83qpu
JMgt6UEvVapBsuMdLaXAZb6vGhVGObMnRqVV1BIEbeBQFKv5fDazNDEOg/j6dv/w+Pxg3tCy
L18uT5eX64/LW3cr2z0+1jEN9fP90/VBBkhoo4Z8uT4DO6vsLTqVU4f+4/HfXx9fLk2uWY1n
d16KqsVkrAxDCzCTav9Dvm3Y6Z/3X4DsGdP3OJvUf29BB7oHxGI6V+vwPt/2ARRWrI+/In49
v32/vD5qHemkkUTZ5e0/15c/ZaN//e/l5b9G/MfPy1f54dDRitlqQkdA/4fM2lnzBrMISl5e
Hn6N5AzBucVDdcDixVJdwy3AGjAnqybbxOX1+oQm9nfn3HuUvcsGsRiM40QTXLGzP7Dnry/X
x6+6ZQMDO9CGQ/Ok2E/MhotiVGpdbVtfYmJqdfe+tZUmZSPqdbFhQU5awPcZF2chCjX19k4s
tBin7VGqRhZlrl01dCjD8dbASnM4VSzJaTeVAZ8XaE+/wbtzQrTKlox6odxhDzwozWTUfTvl
W7eoLrb2SXVz//rn5Y2KWmFgFGse2glhEPhaEeprHicRfkyzWW9TvK7FSojaSLyJDzVanJJs
jHJ9Ah5Fma95c0LvGexgc3LF7blLNpQL6XGtaIrdDNN6rJt1BS9oh8g2e1aYOBz1jqLgGTqw
WD0dPl2//DkS179elGTivcxonhWoNtwGAi0PVOUh2Yky7KwqLVD6UuJDTah2NZ8GmkCmvqq4
CDCeBDmlTnFo6L7N+aascAQSSchagfXj+nbB/DmUq1MZo/McvuUghQRRuGH688frg91fZZEK
5Swvf8pAPyast48NX9I49vIPH+agTOpkH/TZ81eZeGow+DcIaMEH8ev17fJjlD+Pwu+PPz+O
XvGS89vjF8XRqJGgP2BPBrC4hlqndKKRQDflgOHlq7OYjW3ewr1c779+uf5wlSPxzX56Kn5b
v1wur1/uny6ju+sLvzOYdEtrz8PQup7YA0wk+VGDKNJBJPVmX2lOiO99sbnB++/05GqMhZPI
u7/unzCZnasUiVfs/Dm6IllT+/T49Pj8t8VzkIl4w3EI9+TUpgr3rpj/aDL1dysyN+S6jO/6
G4Lm52hzBcLnq5YRrUGBUDt0r57zLIpTpr45U4mKuMQMcUzz99IIcG8S7OBA4yU77LzO0kwI
fojNmlueeUMjzYdU8akK5V29ZBD//QZKTrs6FTbDhaEkB+0rrD8Zm65JsxZsNSUTb7UEuqdO
C7Tztw+ISZMNxfxQ67Lh/pCdibtDVJkj31RLUFaYg51ZlRHpTMtM3oI7x1L1U5iskXx/w9XW
c7wZ2K/XqkvFAKvDgARr12w63JQmChY9xPJM7FPzYzvUP+rmgksBtxfgoO1QNWz+q74zVMpY
pPKrApdFT+KrJOJIvA9uEW0BS5BYh87+iHBKJmoo7BbQnxlacJAyV2bnIA1hfsgLfvLNOvPV
oPARm+gR7WEcyshzxF2WODLMIGJU5VrxSJc1qSeaF8ruJCL6QfHuFH7CWERkhPxw4uuepmwx
VQ0iLUBP3IvA+VwvttSSqwNgNZv9H2tP0t04zuN9fkVenebQPW3JS+xDHWhJtlXWVqLsOLno
pRJXlV8ncV6W93V9v34AUgtBQun+5s2hOyUApiguIABi8ew61RpqA4z7v1TVNZgSwMynG15W
2/l4oCwA4pZiIM3c/8H60Ovjo4VXkm4AzF9wBntAzEbEqoDPdbwCBq4yc4A8nhD0wvQME2gk
OqCN2kw7KBa4BNcFgUbZPkryAi/6qjYTSbtaDiQqPKkCf3JpA8zybwpgurwhDx7PxgSwmFnF
GoJiPBkoLJ4W/sxf4GdwbrJidzkfkUshzZ/1JzK/UE4LezxyOscyEyOLNK5jMjo9fD8ABzCZ
0jKbVjNvPtBnGaoTL81D7crYtyirVHl9GC+pVOujuWfDpEcShyAshSPtQH++X828EQU1stBB
A/9zs5hKS3oRkSTUyFPLSAYiiZg2jV80IvfzA0hPdtxrGkz8Kb/h+h/oX/w8PqpgCqlKE1Er
UpXA7Bebhsdx+0pRRDd5H4pjsOhoxkoZQSDndM3G4ityJW6Cg3A8sliWhhHuh2+PS0zWIdeF
yTxlIc3H/c18QQqiOp+vA51P9w1AmZF01loS8tyyfX160sVvofsTt48aYts3VwAWIFZNyOZD
tTYmi/Z3XZ966dpBkvO7shrkcc1I04zRWDlTrT6eD09HM3LLBJDxnD+2ATWZcJfFgJgufHTA
lMZMK+i4tBqfLWZ2ccL+8C5yTFbC+kTJycQ3DJXpzB+bzurAS6ceZbbTuW+ejEExufQJd6rw
giCYTi/Z4muKYbQugVY9dHZQOyv+/fvjY5tLmLIGnYw42q/NzHRqErXWY6VHsDFayyAit0Oi
hUmWezh9a1LfYMn7p7tfneH63+j3HIayySpu2ITWaAG+fTu//BGeMAv5t/cudSmx4gzQKcLi
5+3r8fcEyI73F8n5/Hzx3/AezJTe9uPV6IfZ9n/6yz4jz4dfSLbLj18v59e78/Px4tVlqct0
7c04prg6COljMQHTktDB6J41GMz6uswtqTMtduPRdDRQv7PZ7/p3aNt0WIFCYQxki+5XSrUe
+7ZAbq1r9+s1Rz3ePrz9NA6ZFvrydlHevh0v0vPT6Y2o9GIVTSY0pyWqmiO+FEWDIjnA2eYN
pNkj3Z/3x9P96e2XMXNtZ1J/7NH0YZuKTfm1CbFYhhvw3Aa0YlqSAWfkTSX9gdT1m2rHhrDI
+FLL5r24DRDbvaX9ZPvzNL+BjfaGMQuPx9vX9xddFfcdhsv4/GUaeyTbknqmq3J1yOX80rxe
bSGUbpseZvT0z/Z1HKQTfzYaXLVAAut6ptY1Uc9NBNUem+WcyHQWygPPzoY/XQc1qDxJzDYW
4ReY0jG7AES4O3gjWpZHYOEv9lYxGWOpeOPIK0K5GJujqCALMvob75IWbkUIL2ulY9+bm75C
ADBPPXgem+FP8DwzlT18nk3JfK0LXxTAlfjbH4WETxqN+EQMnRQiE38xYqvRURIzok1BPDPJ
mKmCJ07OjwZTlKzZ/4sUni4/1yobRTma+kQlK2nI1x6mcWKmOAC+M7HK/mkIKUyR5cIDpsz0
IS/Q48d4RQF98kdjq16rjD3PvtA1UBOuaVC8x2PTXAG7YbePpTl8HYju0SqQ44lZTFQBTJNN
O0cVzMjUVEkVYG4BLs2fAmAyHRufvJNTb+6TQ2wfZMlA9T+NGtNaw1GazEasR5ZGWeXTE1Ap
OeIbmA4Yfc88RSgT0C6vtz+ejm/aaMGyh+18ccn5NimEMfxiO1osqC7UWLZSsc4GmCGgxh4t
yWOsdfxhVOVphFkfxny+jzQNxlN/wo1AwzXV63n5oO2ZjW5XBCif07lZdd5CuJobIst07Jm7
iMJtbwJ2Av6rK/b3/HD8iygpSqXaEc2PEDYH4d3D6cmZVUarywLQ+7shZpmRNpbWZV71iX+6
U4d5j+pBG0B38fuFrlf4cH460q/AOJSy3BUVb8lVUUacysk33ZxyTyAogTpyD//9eH+Afz+f
X0/Kl8Zc3N1++HtyIhA/n9/gXD2Zvke9MudkHu60NdihrHkU1LIJ0dtALRt5cwrQ/KXX04oE
hcMPJVerm+wnwNCZYlGSFguvdRgcaE7/ROstL8dXFDNYlrEsRrNRyrmuL9OCWLP1sy3uhMkG
+NxAkbsCC2Jywqp5RtKEXwUtOBsHhTckeheJZ9rP9LNlni6SsUcF6FROZ6wAhYjxpcN3rA6a
UOvwmk7MdNubwh/NDPRNIUACmjkAm8c4s9WLhE/oVMRuDRvZzPv5r9MjCt64ae5VLdI7dhUo
+Yb3OccSByWmlInqvbn6lx6R5woSJlGu0GvNvBCT5YrqVPKwsNaGiZqyM46N0JricCaPLbWj
O2un42R0cEf3wzH5/3UK08z1+PiMJoWBDWhshSpK+VRvaXJYjGYeH8mkkWyIQpUWpHaPejZW
eAVs25QB1bNPMhBxvTfky4rzfd2nUeOJpD4UHpvM0O49NJIGYuFhLnrDXArQCuTLCZ1sgK7E
lphr+xecscgu036MPwMlZWp2Z/g+G6nxjp0d6uIqdV6OIW5YnojJ51R+RYchqo/Vq5j3zXHa
6ZopRLCtSViScpGHwyWIrZCTJm1oXORBxbr8AdeKKsMXzNiyCrMsg1RWy+YmwGxa43U46prz
ktMEmC1dZRFohxsd4uT7t1flftEPThPVh/5yRAoN0nqbZwJvzn3bma6dhc11mzKnrvKy1O4L
/SQZ6PDvW5AxyDWGIkxwIjETpSEKvWzi9DBPv2IX7fem8QGGR5dKG351cRC1P8/SeiPjwG6i
Q+II8KsQe1gEorCTZ9GuiKLY5FlUp2E6mw1cZyNhHkRJjpb4MrTjA1ueSaaw+xJ0VIFekLM1
WDobpDi+fD+/PCo2+6jNYVyM3kdk3RKjThvw+RPndb07bbvnsrDMabLYBlQv4yzESst2wtpB
n9okXmb7ME65lHghzTaY7S0XXm3pu7p4e7m9U0e1zS9kRdxk4RENCBVGiMqYvYXsKGDL1WYS
Y0DY+YoBJPNdGUTK6yJPIvtdDZbNWtGyIrX7KyPcvoXYkSAdnE/D26FltWF/lkquzFT/top/
mxOF2dsg3YHvf4++zpxtnIamwqPK6YRlBbOczZ+KJE3iQ+rMZCBIbkEDrvOLURQw0tTuglxG
6JbDCbAYW1Uk0UHxdVstdd0MQTMFVWh9ufBJeAuCBzIFIaqLNnYVWsfhs0jr3EzGKuP8QJ/w
YHNcpGQSp1YmPmOmy0BXWzGMhW7I1wpW9NedCPnKK703bxUsgd0X1Y6mOEhzWbHryJIc9D3U
6QGEI8UdTdFDoOgMYjMoxoUoSXIcAMWYa6yHRIfKr1e2TxqC6oOo2BqFgB+TfO4NADizxNIi
QeKiZBTsyri6JpiJ3cpkuJWJ1YrZ28lgFPSXZWiId/hk5wWEVtNlIIKNcQ1bRjGMGmDM7nVA
IA1IqrcOoxLdx9mKjz8zWnWHtqP6oghY1GEYtV5Jv2bTrWB2fZ98SAupc9/05uvAnadnHSS7
JseqTYN5ucia0ZimlKGQWytYgqEyu7Ss7NFuIWQ19NJai1VzoTbnuhy6ZeqIy10GklUGdPVw
6gtNzfBzghcSBok7qfqXRSusYhCvyGLN4mRwpla+NQYKgCNt7c+GcHB/KrweGe6HKtA/zr4A
JxsqT9u+AU4BZW8YorsBOc9ZlP3G0pJJ/8zubIw2oGxAQ5pUoXlhjkicRDWCidKPTs/oDHVt
443jqwa5urwu7C/u8ThXJnvqQG6uoh613MVw8sGqiteZQFbOD4ROx0KMV26Glu6gURgrqdlK
dG00kK+7vBLWI+a5wARr+rRaCeq8qmppNIRXoszijF/hmmKIo2psVUYGv/y6Sqt679kA3+pe
UJkuh7sqX0l6AmiYvWh3mGmfZW0wC1gEjTC3DoZJyuMSFnkNfz4mEMmVAEF2BZqpGeVgkKK8
fmAxGa6tg53b2CBII/jyvHCjs4Lbu5+kZJJsjyFjpSmQZrf8Tm0oNrGs8nUp+OC9lmqYrbUU
+RL5AugbkuNuigY3Gc3V0UE/eIFBNNDXLspUDYseovD3Mk//CPehknUcUSeW+QJ0TGvFfMmT
OOK6fwP0lHQXrpwjte0H/25tJs/lHytR/REd8P9Zxfdu1XLulk9J+B2B7G0SfG5zsWD1vgKL
eU3Glxw+zjEkSkbV50+n1/N8Pl387n3iCHfVam7yV/ulGsI0+/72fd61mFXO1lSg4SlX6PKK
Hd0PR1Cr76/H9/vzxXduZPuKQgZ3A9B2wKtSIfepnU/MALf3V6C9col4FSXal0wWpoA4Q1jZ
ILbiMxUSJP0kLCPuyNlGZUZqIuFFFrGY0u9TgP4EZQdc0wyJBWmUrsI6KEHFJhkL8E8/ta1V
xB19Q0nBBEBqL1+DfJhyvBlOoqu83JpU/TszS9DBZ/O0UM/kNkZD7A83kRObHLNzDxLXnvW2
SW3eKagOKllCXOe7ysaApmtiH+22a+VdmHYF9bCWDGhdcfb505/Hl6fjw/+cX358cn6Vxmu3
akqZ5xWS8DtMDaRirQOfiodnk5AxzKQ9RmEsVVLDXVhwgZ89ZWj9MoTZGOoR4DhXAPg2jD0A
wSk3jA0orNmPejKNbtoOx3KXlWYuCv1cr83rsgaGAdl9DsZe0dfYweRZUbEhK7QBOAd0A+f3
ZUsTk5biVn3yLSCmY7sCSUMpuVGft82kuYrEti6uMNHkxkLtCqyGRDoXf6hpKvQHB7ZCdw0P
fBg7KAgv+RB+ONQElfksXiDaThG7Kb/OCV5rlTB0ciA/+aLgxcjMTLYJD139N+ZYRXR7LteT
Mcl/Q3CXYy4MkJKYjjEEM5+OBjH+4Cvn0ym/JSnR3/ZLp/ce+PmMu6q1SD7o4myAa1Aijn1Y
JINDN5sNYhYDmMV4NtjjhR3HxTfAXYJSksnQ2+dmqmnEgJCKq66eD3bK8/9Jr4BqaLKEDOLY
br5979CPWrzPd3c81B5/e2xScM58Jt6ZnhbBl142KfhwRPK5w0uyIxlakB3B1O7hNo/nNSeF
dcgdHUbMXgv6hlk3pwUHEdZdsN+gMaDo70re3tgRlTlIFYITQjuS6zJOEjPXaYtZiyjh342V
oviw65YC5OmETzTdUWS7uOIaVyPxcZ+rXbmNzVMQEVTVCRNyiQGPgyf+Lotx4xDdUIPqDMPm
k/hGy3Jt4lxWqyEGeR3BdLx7f0GvDyfNb1Oj0HiqSyxZillI7RMV69GC0gyzjYSYBHXAeNm0
xLlkYG2sKLRe21jFHDg81eGmzuHF6rMtlDJGxYGNas3zmIZXqov5qowDMsEtCe9/0yB5eyII
p2gY09eFpE0UswNlMcMCvrp+L3dR2mi4fTeFseITmX7+hKE49+d/Pf326/bx9reH8+398+np
t9fb70do53T/2+np7fgD5/O3b8/fP+kp3iqR/uLn7cv9UflC9VOtr8KOj+eXXxenpxO63p/+
fdsEADXvjUF1xE8ItjCstFy2QmGSA1XzlM+Fb5GuYFcalKZKN9CPFj38GV3Anb2W25cf8lJb
a005F9cVXq5pQ87Lr+e388Xd+eV4cX65+Hl8eDYDvTQxfOda56ThwL4Lj0TIAl1SuQ3iYmNa
VC2E+xNLxO6BLmlJMvV2MJbQrS7cdnywJ2Ko89uicKm35r1n2wIa8l1S4LFizbTbwGm+XI2y
XZTYH3Z6pVVuvqFarzx/nu4SB5HtEh7I9UT94Q6X9pt31SbKAuaXNvvW5qb3bw+nu9//PP66
uFOL9QdW+f7lrNFSCqeLobtQIjNDTgdjCcuQaRI41D7yp1Nv0W4h8f72Ex1s727fjvcX0ZPq
Jfog/+v09vNCvL6e704KFd6+3TrdDsw64+08BCk3rhs4fYQ/KvLk2o7hsGlFtI4lTObwLMjo
a7xn3hLBO4Bn7Z15WKpoyMfzvWkab7u2dAc1WC1dWFVyH1axOVLb/rjNJOWVA8tXS6bpAno2
3PaBXpW2+zS6vipZE1W78DftFLj7GfOTVzt3SvGubt+umM3t68+hkUyFO5QbDnjgBn2vKVuX
8ePrm/uGMhj7zHQh2H3JgeW2y0RsI58bcI35YD7hPZU3CuOVu+rZVw0OdRpOGBhHN8XqGy48
hpWufPNcXJmGnhntZYCpDt4j/CmberzDj0ne2mYPboTHAtkOAwJewoGnHnOwbsTYBaYMDK8M
l7l7UFbr0lu4DV8V+nVafDg9/yQeRB3/cU8XgNXUS6tFZLtl/MGSEWUwYZdafmUXKbTWmkgj
0J4YJi5QmHdqUBlYTvM10DPmZyF7ydwgV+ovx2024kZ8cFpKkUjBrJ32NGCalFZVShdfFlY5
JYck5Y0D3UEtPkRf5fbE6NVyfnzGWAYiZnejt0oELfPbcvsbNiO0Rs4nnAiS3LD5vDvkhpM+
bmTlFkQsb5/uz48X2fvjt+NLmwuA6z/WqKqDgpM4w3K5tqpfmBiWu2uMVeHbxAXsVZJB4TT5
JcbqVRE6ehfXDhblRzvxpIVS/Rl+aUdmyPSDTZVsTW2bilUksBfKmcvSYR5O315uQY96Ob+/
nZ6YszWJlyxjUnDNY1xEc6C5RWdcGhan9+mHP9ckPKqTNj9uwRRKXXQ48NHt2Qqyc3wTffY+
Ivno9YNndP91vdjKEnVnm71gNlxggZDXaRqhCUMZPbCMct+qgSx2y6ShkbvlIFlVpDzNYTpa
1EFUNjaVqPfa7A1A20DO0YNnj3hsRdPw18DNi1wSo7VLYBVSop2Yf9ulUpOwHaYB9HfCnMOR
viVVfm6NOajbLZhp4LvSVl5VHcnX048nHc5z9/N49+fp6Yfhga5uiE0bFS304+Ll50+fDAuQ
xkeHqhTmSHJdj+AfoSiv//ZtsN2wOKKs/gGFYhb4L92t1oXkH4xB2+QyzrBTyklr1Q5iMshr
sJDYrC5IAawWVi9B7wV2X3KpqLEokyiBNltTLx6M9olZdrmMQXbDAj3Gmm3DaECsy4Liul6V
eWr5rJkkSZQNYLMIHVRi8w4uyMvQZAEwJmlUZ7t0SYpjacukSNw2C1XSm7g5gz4AOjAcTQTk
zSiFqzIEdVztavorqsDAY2cUppxFYYAzRMvr+YAcY5AMSUKKRJRX/HLW+GVMe0gK6VhHTmCW
lI2Xrp4WGBpJp5gZiywL89T4ZqZTIC11rqN9WwgNIxd+g5wZDtqE+KXc6BPFgoKQxrSMUK5l
JYKx9BO+JyCaMeQKzNEfbhBsjo6G1Ic5p6U1SBW/VHA/i8WMXwUNXpS8e1+PrjawSz6iweT5
nKmiQS+DL/bn1VYxw24c6vVNXLCIww0LxnF0N6sybtNchkuzsCY8qMihSuWtNN2IlJfrXiSW
N6qQMg9iYA77CIakFIYQivU5gTFEqQ1Cz5eaMAyE0+KRWIbTdEbOQP+ppUYAf1ub4UkKp+pe
ikLdT5j9w0qhiBNhWNZVPZuQ7YsYGLRElBgxtYlKkiW5KzOqqkQi7apLvvB3VEGxY0hUQcwy
KpiXISrLsxaBqVILiu1QRZ5bRU7LyKFu3G1bTH8xh4NRDNeyk+tELxOjua8m30/yJX0yOXI7
JQl6wjDrT9W7JRwzuakrQcxOcfkVxU/OCyYtYl2atuepq9B4L8b7lWgnrUrTvTyHQXPq6Sro
/C/zWFIgdIyGLyKxR3JtDXo3owUWwSQXKR0KMGr0FZcT6PkMkhxDt9OVhOtVspMbKzpG3VWF
UZGbnYElTKYbb/6yNT0Yu6QBllDTnfNJmK6uWtmnu49qZUUFfX45Pb39qWPoH4+vP9x7VSVB
bVWFBSLeaDC6MvE3GDo4Eat8JCDsJN09zeUgxdddHFWfJ91CaORpp4WJsdKvM4HVlYfdrghF
bfuzGhJvusxR64jKEn7AiQa6BfgPRLdlLkl21cFh7Awop4fj72+nx0ZSfVWkdxr+4g66flej
LTsw9LTfBRFxIjSw7QExYE4yKGWRxLxBySAKr0S54s/RdbjEwtZxMeBN39R4Tndot8MAGu4e
Gg6hSAVQfPZG/sRc8AWcPSlODRGsy0iEqllAMu1tAI2ZyGM44oR5/6U/SeowHfS5TQWpOG1j
VJ/qPEuu7TaA+Qegqu0y/QO16esxNayblNrLkKv53io2/3SBqOWkzFmnu3ZHh8dv7z9UmaL4
6fXt5f2xqa/cbiOxjpWvtaru6wK72209WZ9Hf3kclc5IwLfQZCuQ6G6B9RA+fbLGSzoj2Lpn
Wi6WHRZvPBVBiiGhHyzRriW87OeWg1BiC0znFlar+S585qwUHc9eStEEuGH5VrKWFM56xIr3
hQ1bYqUUaUPR4dvsivsq3hCBFgRFy66if7Qu6Dyg13zEzAB20DGqNg4PXbtmug3lIRcdKsyj
PBDcpkjyq4w3oSjLSR7LPCOWAQqHSW4iDqmmTWhuogEHLv1pirqM+OSCmkQH7XDXAmo1/W9l
V7LbNhBDf8XHFiiCFCh6V5SR7dpaoiVOT4KRGEEPTYzaQfP55SNH1iyU2p7iaKhZqOE65NCi
jmT/lgg7Rt7QMjOCxKd0kG+afka88tbCGC56LxmykarJfd3nfbVsmXajqdzrBk744hwZWNh1
3XZJxE3Hx+EG4uIYHEYzj0ZeJdK7MskV0xA1NM+Td+KRZNCAI1Zf401TXp60xm5SaUXOhey7
kTjJyjCNl9wREUYgclZSWV2OdwG0KF+Pp08L3CP8dhRWv9q/PJ98iiqIwZJ4KctK24peO5LU
O+LdF6W5TDddpdQQaMqsnWxEjTc2Cl0wHudfYOwcPrufECP0q44w2CaNThC7u0u56WmmJ+Oo
XG8eoRI0SCL16Q1y1OVdHrFFIfL8WMkTHGK3lC7DvQuVeWNMFXgBxROJqIyRQ384HX+8IFKD
FvHz7Xx4P9CPw/nx6urqo3NdHBJ4uW+uPhiZO1VNlKLl60pDneyki4JQOpWtygBY96QGDMu+
a82DiaT6UM4tfD4BvttJCxfDIutpFQLUu8bLc5KnPMOAmDnPxVQx/7ANk4sRa5VmYKbeBqb5
eMyaXhot8pSIlJCyHPh3xkVqptt/7IKhw5bzfoijZNtk6Ze4Tzfc6K6DdVhCVt8VOF+mnS4O
xxmxsBHxF21ZITRJuFo87c/7BbSKR7jfI8uFXfcROquJNFi7e5bxGxIYGxS8H8NzIauL/jZp
4TnhWy2nymrOTj4cNSX7yhQt6bRNhIU67TQuYiksdTxCwX4Y7Ze04+phUdycB+G+raAMILgS
get8BFuOXw83Ah6aOzVBabgDz1tZiBNi02LM1IoZ41vITA2kC8KNpi8QTugi/d6WakZhWcn0
60CaXwyu+dYlqeErHWZwBmQDerwOhLJyvoSGkItjkwAEGasgJoYkjbNwozEZIrUvSi/OZqjl
AhCPO7JLJyy9xQUWGN5ThOlPC5w2uzVs03B5TlfWHkK+pisajMmJPMhaUycfjWcfOELm8vUE
UbobBaWw1YAaR5/EhVr92tpt7k1JEt5uITx3Yem3RVR5fP19+HV8VCkTeYk2fnZn6tpVeOQK
B1G0SUqQBPr6xX3P5CgLJLq4F3iLPIYKWkvklLMQ37q8Qolvs+0zw1dZiBavRuK3dZ+tH0iP
ir2sebPuxReoNGKK+KLQxPiWmPAynocgUgr/D/a+fqrBAISthiTvzVY7q3b76OsStZO8GobQ
Tvzj7xvUeudtq9uFQHRSb79P+quzZL2VcqqeUoO69W2YYD665KIt4bpB28PpDJELTTFFOcj9
88HVvjddMeEZG0RSz3tJv/jlMm/vahiPhrAkNkVZk1FHYpg82ZghkWUaNaxrSma1/3oG3ePv
U3MdNcH4eTo7vN/NqIQgksG76+jCADZp6VQ9toYWmVf02LJJN4rSQo8fBmDWr8hO9xp2v0ZW
DAkvYN0hddx34Egj0U5Sm6TnOJrrd1wYf+2ITOLgOClvRV3mWDD1QxFHmkxhmt1vUa6I+Ob/
AAn5hpBw6gEA

--k1lZvvs/B4yU6o8G--
