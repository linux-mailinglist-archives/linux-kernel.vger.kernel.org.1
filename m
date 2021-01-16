Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C192F8FE1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 00:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbhAPXgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 18:36:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:34101 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbhAPXgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 18:36:44 -0500
IronPort-SDR: d/tU4a+lecUvkritmhyIDYt1MAyFE0g7tkFFCrZbNpASmjFTo72vGnL+J+5LbJFHyl/82fCeeH
 yYPNla45xExg==
X-IronPort-AV: E=McAfee;i="6000,8403,9866"; a="158463990"
X-IronPort-AV: E=Sophos;i="5.79,352,1602572400"; 
   d="gz'50?scan'50,208,50";a="158463990"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2021 15:36:02 -0800
IronPort-SDR: lOLEW0zl2RVgA2Dva4UvFunquzc6SYq4EaRxI5gDgLFiBeT6yL2XB10ldt/Jd5AoB4Z+c09A84
 94v5rZPC0M4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,352,1602572400"; 
   d="gz'50?scan'50,208,50";a="390458176"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 16 Jan 2021 15:36:00 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l0v6t-0001C8-LH; Sat, 16 Jan 2021 23:35:59 +0000
Date:   Sun, 17 Jan 2021 07:35:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: drivers/dma/ppc4xx/adma.c:4094:14: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202101170719.V8Qkb8cA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0da0a8a0a0e1845f495431c3d8d733d2bbf9e9e5
commit: 68f35add4ba4c850a33878633e10c02d7ba32d84 dmaengine: ppc4xx: make ppc440spe_adma_chan_list static
date:   3 months ago
config: powerpc-randconfig-s031-20210117 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-208-g46a52ca4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=68f35add4ba4c850a33878633e10c02d7ba32d84
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 68f35add4ba4c850a33878633e10c02d7ba32d84
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
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
   drivers/dma/ppc4xx/adma.c:1031:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned short * @@
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
>> drivers/dma/ppc4xx/adma.c:4094:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *regs @@     got void [noderef] __iomem * @@
   drivers/dma/ppc4xx/adma.c:4094:14: sparse:     expected void *regs
   drivers/dma/ppc4xx/adma.c:4094:14: sparse:     got void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:4102:31: sparse: sparse: too many warnings

vim +4094 drivers/dma/ppc4xx/adma.c

12458ea06efd7b Anatolij Gustschin       2009-12-11  4003  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4004  /**
12458ea06efd7b Anatolij Gustschin       2009-12-11  4005   * ppc440spe_adma_probe - probe the asynch device
12458ea06efd7b Anatolij Gustschin       2009-12-11  4006   */
463a1f8b3ceebe Bill Pemberton           2012-11-19  4007  static int ppc440spe_adma_probe(struct platform_device *ofdev)
12458ea06efd7b Anatolij Gustschin       2009-12-11  4008  {
05c02542c20aa0 Anatolij Gustschin       2010-06-03  4009  	struct device_node *np = ofdev->dev.of_node;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4010  	struct resource res;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4011  	struct ppc440spe_adma_device *adev;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4012  	struct ppc440spe_adma_chan *chan;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4013  	struct ppc_dma_chan_ref *ref, *_ref;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4014  	int ret = 0, initcode = PPC_ADMA_INIT_OK;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4015  	const u32 *idx;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4016  	int len;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4017  	void *regs;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4018  	u32 id, pool_size;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4019  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4020  	if (of_device_is_compatible(np, "amcc,xor-accelerator")) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4021  		id = PPC440SPE_XOR_ID;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4022  		/* As far as the XOR engine is concerned, it does not
12458ea06efd7b Anatolij Gustschin       2009-12-11  4023  		 * use FIFOs but uses linked list. So there is no dependency
12458ea06efd7b Anatolij Gustschin       2009-12-11  4024  		 * between pool size to allocate and the engine configuration.
12458ea06efd7b Anatolij Gustschin       2009-12-11  4025  		 */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4026  		pool_size = PAGE_SIZE << 1;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4027  	} else {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4028  		/* it is DMA0 or DMA1 */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4029  		idx = of_get_property(np, "cell-index", &len);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4030  		if (!idx || (len != sizeof(u32))) {
c6c93048baff25 Rob Herring              2017-07-18  4031  			dev_err(&ofdev->dev, "Device node %pOF has missing "
12458ea06efd7b Anatolij Gustschin       2009-12-11  4032  				"or invalid cell-index property\n",
c6c93048baff25 Rob Herring              2017-07-18  4033  				np);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4034  			return -EINVAL;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4035  		}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4036  		id = *idx;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4037  		/* DMA0,1 engines use FIFO to maintain CDBs, so we
12458ea06efd7b Anatolij Gustschin       2009-12-11  4038  		 * should allocate the pool accordingly to size of this
12458ea06efd7b Anatolij Gustschin       2009-12-11  4039  		 * FIFO. Thus, the pool size depends on the FIFO depth:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4040  		 * how much CDBs pointers the FIFO may contain then so
12458ea06efd7b Anatolij Gustschin       2009-12-11  4041  		 * much CDBs we should provide in the pool.
12458ea06efd7b Anatolij Gustschin       2009-12-11  4042  		 * That is
12458ea06efd7b Anatolij Gustschin       2009-12-11  4043  		 *   CDB size = 32B;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4044  		 *   CDBs number = (DMA0_FIFO_SIZE >> 3);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4045  		 *   Pool size = CDBs number * CDB size =
12458ea06efd7b Anatolij Gustschin       2009-12-11  4046  		 *      = (DMA0_FIFO_SIZE >> 3) << 5 = DMA0_FIFO_SIZE << 2.
12458ea06efd7b Anatolij Gustschin       2009-12-11  4047  		 */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4048  		pool_size = (id == PPC440SPE_DMA0_ID) ?
12458ea06efd7b Anatolij Gustschin       2009-12-11  4049  			    DMA0_FIFO_SIZE : DMA1_FIFO_SIZE;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4050  		pool_size <<= 2;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4051  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4052  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4053  	if (of_address_to_resource(np, 0, &res)) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4054  		dev_err(&ofdev->dev, "failed to get memory resource\n");
12458ea06efd7b Anatolij Gustschin       2009-12-11  4055  		initcode = PPC_ADMA_INIT_MEMRES;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4056  		ret = -ENODEV;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4057  		goto out;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4058  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4059  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4060  	if (!request_mem_region(res.start, resource_size(&res),
12458ea06efd7b Anatolij Gustschin       2009-12-11  4061  				dev_driver_string(&ofdev->dev))) {
a584bff5efae8c Joe Perches              2010-11-12  4062  		dev_err(&ofdev->dev, "failed to request memory region %pR\n",
a584bff5efae8c Joe Perches              2010-11-12  4063  			&res);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4064  		initcode = PPC_ADMA_INIT_MEMREG;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4065  		ret = -EBUSY;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4066  		goto out;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4067  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4068  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4069  	/* create a device */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4070  	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4071  	if (!adev) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4072  		initcode = PPC_ADMA_INIT_ALLOC;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4073  		ret = -ENOMEM;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4074  		goto err_adev_alloc;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4075  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4076  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4077  	adev->id = id;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4078  	adev->pool_size = pool_size;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4079  	/* allocate coherent memory for hardware descriptors */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4080  	adev->dma_desc_pool_virt = dma_alloc_coherent(&ofdev->dev,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4081  					adev->pool_size, &adev->dma_desc_pool,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4082  					GFP_KERNEL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4083  	if (adev->dma_desc_pool_virt == NULL) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4084  		dev_err(&ofdev->dev, "failed to allocate %d bytes of coherent "
12458ea06efd7b Anatolij Gustschin       2009-12-11  4085  			"memory for hardware descriptors\n",
12458ea06efd7b Anatolij Gustschin       2009-12-11  4086  			adev->pool_size);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4087  		initcode = PPC_ADMA_INIT_COHERENT;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4088  		ret = -ENOMEM;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4089  		goto err_dma_alloc;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4090  	}
d73111c6d43f08 Masanari Iida            2012-08-04  4091  	dev_dbg(&ofdev->dev, "allocated descriptor pool virt 0x%p phys 0x%llx\n",
12458ea06efd7b Anatolij Gustschin       2009-12-11  4092  		adev->dma_desc_pool_virt, (u64)adev->dma_desc_pool);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4093  
12458ea06efd7b Anatolij Gustschin       2009-12-11 @4094  	regs = ioremap(res.start, resource_size(&res));
12458ea06efd7b Anatolij Gustschin       2009-12-11  4095  	if (!regs) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4096  		dev_err(&ofdev->dev, "failed to ioremap regs!\n");
f3b77727e82722 Julia Lawall             2013-12-29  4097  		ret = -ENOMEM;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4098  		goto err_regs_alloc;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4099  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4100  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4101  	if (adev->id == PPC440SPE_XOR_ID) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4102  		adev->xor_reg = regs;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4103  		/* Reset XOR */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4104  		iowrite32be(XOR_CRSR_XASR_BIT, &adev->xor_reg->crsr);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4105  		iowrite32be(XOR_CRSR_64BA_BIT, &adev->xor_reg->crrr);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4106  	} else {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4107  		size_t fifo_size = (adev->id == PPC440SPE_DMA0_ID) ?
12458ea06efd7b Anatolij Gustschin       2009-12-11  4108  				   DMA0_FIFO_SIZE : DMA1_FIFO_SIZE;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4109  		adev->dma_reg = regs;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4110  		/* DMAx_FIFO_SIZE is defined in bytes,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4111  		 * <fsiz> - is defined in number of CDB pointers (8byte).
12458ea06efd7b Anatolij Gustschin       2009-12-11  4112  		 * DMA FIFO Length = CSlength + CPlength, where
12458ea06efd7b Anatolij Gustschin       2009-12-11  4113  		 * CSlength = CPlength = (fsiz + 1) * 8.
12458ea06efd7b Anatolij Gustschin       2009-12-11  4114  		 */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4115  		iowrite32(DMA_FIFO_ENABLE | ((fifo_size >> 3) - 2),
12458ea06efd7b Anatolij Gustschin       2009-12-11  4116  			  &adev->dma_reg->fsiz);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4117  		/* Configure DMA engine */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4118  		iowrite32(DMA_CFG_DXEPR_HP | DMA_CFG_DFMPP_HP | DMA_CFG_FALGN,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4119  			  &adev->dma_reg->cfg);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4120  		/* Clear Status */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4121  		iowrite32(~0, &adev->dma_reg->dsts);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4122  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4123  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4124  	adev->dev = &ofdev->dev;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4125  	adev->common.dev = &ofdev->dev;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4126  	INIT_LIST_HEAD(&adev->common.channels);
dd3daca162f741 Jingoo Han               2013-05-24  4127  	platform_set_drvdata(ofdev, adev);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4128  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4129  	/* create a channel */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4130  	chan = kzalloc(sizeof(*chan), GFP_KERNEL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4131  	if (!chan) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4132  		initcode = PPC_ADMA_INIT_CHANNEL;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4133  		ret = -ENOMEM;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4134  		goto err_chan_alloc;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4135  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4136  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4137  	spin_lock_init(&chan->lock);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4138  	INIT_LIST_HEAD(&chan->chain);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4139  	INIT_LIST_HEAD(&chan->all_slots);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4140  	chan->device = adev;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4141  	chan->common.device = &adev->common;
8ac695463f37af Russell King - ARM Linux 2012-03-06  4142  	dma_cookie_init(&chan->common);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4143  	list_add_tail(&chan->common.device_node, &adev->common.channels);
7f8281765f9949 Allen Pais               2020-08-31  4144  	tasklet_setup(&chan->irq_tasklet, ppc440spe_adma_tasklet);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4145  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4146  	/* allocate and map helper pages for async validation or
12458ea06efd7b Anatolij Gustschin       2009-12-11  4147  	 * async_mult/async_sum_product operations on DMA0/1.
12458ea06efd7b Anatolij Gustschin       2009-12-11  4148  	 */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4149  	if (adev->id != PPC440SPE_XOR_ID) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4150  		chan->pdest_page = alloc_page(GFP_KERNEL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4151  		chan->qdest_page = alloc_page(GFP_KERNEL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4152  		if (!chan->pdest_page ||
12458ea06efd7b Anatolij Gustschin       2009-12-11  4153  		    !chan->qdest_page) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4154  			if (chan->pdest_page)
12458ea06efd7b Anatolij Gustschin       2009-12-11  4155  				__free_page(chan->pdest_page);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4156  			if (chan->qdest_page)
12458ea06efd7b Anatolij Gustschin       2009-12-11  4157  				__free_page(chan->qdest_page);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4158  			ret = -ENOMEM;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4159  			goto err_page_alloc;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4160  		}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4161  		chan->pdest = dma_map_page(&ofdev->dev, chan->pdest_page, 0,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4162  					   PAGE_SIZE, DMA_BIDIRECTIONAL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4163  		chan->qdest = dma_map_page(&ofdev->dev, chan->qdest_page, 0,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4164  					   PAGE_SIZE, DMA_BIDIRECTIONAL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4165  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4166  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4167  	ref = kmalloc(sizeof(*ref), GFP_KERNEL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4168  	if (ref) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4169  		ref->chan = &chan->common;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4170  		INIT_LIST_HEAD(&ref->node);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4171  		list_add_tail(&ref->node, &ppc440spe_adma_chan_list);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4172  	} else {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4173  		dev_err(&ofdev->dev, "failed to allocate channel reference!\n");
12458ea06efd7b Anatolij Gustschin       2009-12-11  4174  		ret = -ENOMEM;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4175  		goto err_ref_alloc;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4176  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4177  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4178  	ret = ppc440spe_adma_setup_irqs(adev, chan, &initcode);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4179  	if (ret)
12458ea06efd7b Anatolij Gustschin       2009-12-11  4180  		goto err_irq;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4181  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4182  	ppc440spe_adma_init_capabilities(adev);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4183  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4184  	ret = dma_async_device_register(&adev->common);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4185  	if (ret) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4186  		initcode = PPC_ADMA_INIT_REGISTER;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4187  		dev_err(&ofdev->dev, "failed to register dma device\n");
12458ea06efd7b Anatolij Gustschin       2009-12-11  4188  		goto err_dev_reg;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4189  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4190  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4191  	goto out;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4192  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4193  err_dev_reg:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4194  	ppc440spe_adma_release_irqs(adev, chan);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4195  err_irq:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4196  	list_for_each_entry_safe(ref, _ref, &ppc440spe_adma_chan_list, node) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4197  		if (chan == to_ppc440spe_adma_chan(ref->chan)) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4198  			list_del(&ref->node);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4199  			kfree(ref);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4200  		}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4201  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4202  err_ref_alloc:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4203  	if (adev->id != PPC440SPE_XOR_ID) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4204  		dma_unmap_page(&ofdev->dev, chan->pdest,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4205  			       PAGE_SIZE, DMA_BIDIRECTIONAL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4206  		dma_unmap_page(&ofdev->dev, chan->qdest,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4207  			       PAGE_SIZE, DMA_BIDIRECTIONAL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4208  		__free_page(chan->pdest_page);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4209  		__free_page(chan->qdest_page);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4210  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4211  err_page_alloc:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4212  	kfree(chan);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4213  err_chan_alloc:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4214  	if (adev->id == PPC440SPE_XOR_ID)
12458ea06efd7b Anatolij Gustschin       2009-12-11  4215  		iounmap(adev->xor_reg);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4216  	else
12458ea06efd7b Anatolij Gustschin       2009-12-11  4217  		iounmap(adev->dma_reg);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4218  err_regs_alloc:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4219  	dma_free_coherent(adev->dev, adev->pool_size,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4220  			  adev->dma_desc_pool_virt,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4221  			  adev->dma_desc_pool);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4222  err_dma_alloc:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4223  	kfree(adev);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4224  err_adev_alloc:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4225  	release_mem_region(res.start, resource_size(&res));
12458ea06efd7b Anatolij Gustschin       2009-12-11  4226  out:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4227  	if (id < PPC440SPE_ADMA_ENGINES_NUM)
12458ea06efd7b Anatolij Gustschin       2009-12-11  4228  		ppc440spe_adma_devices[id] = initcode;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4229  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4230  	return ret;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4231  }
12458ea06efd7b Anatolij Gustschin       2009-12-11  4232  

:::::: The code at line 4094 was first introduced by commit
:::::: 12458ea06efd7b44281e68fe59c950ec7d59c649 ppc440spe-adma: adds updated ppc440spe adma driver

:::::: TO: Anatolij Gustschin <agust@denx.de>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--XsQoSWH+UP9D9v3l
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--XsQoSWH+UP9D9v3l--
