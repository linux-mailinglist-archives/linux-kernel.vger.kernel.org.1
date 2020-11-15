Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3E22B32CC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 08:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgKOHAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 02:00:50 -0500
Received: from mga07.intel.com ([134.134.136.100]:55156 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbgKOHAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 02:00:50 -0500
IronPort-SDR: CIPdSwmbgYrAY1IwxugGxa6pd2qmBzmUZlRrNU8EfXnEB5pIwTk9LYFJo5rODKpx73c5C7ym7G
 0RdmGtyZWJBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9805"; a="234782287"
X-IronPort-AV: E=Sophos;i="5.77,479,1596524400"; 
   d="gz'50?scan'50,208,50";a="234782287"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2020 23:00:47 -0800
IronPort-SDR: FNCArKuX4hkDPCOz10PHacjiKfxLIufkEsXxXxVe2r/EZoYObxlCsrrVoZ/zlK4I4fMGk6ajgE
 Qg4f5l27B5RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,479,1596524400"; 
   d="gz'50?scan'50,208,50";a="361786398"
Received: from lkp-server01.sh.intel.com (HELO 2e68b9ba5db3) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 14 Nov 2020 23:00:45 -0800
Received: from kbuild by 2e68b9ba5db3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1keC1l-00005O-4w; Sun, 15 Nov 2020 07:00:45 +0000
Date:   Sun, 15 Nov 2020 15:00:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: drivers/dma/sun6i-dma.c:244:45: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202011151520.iMsVt6PV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e28c0d7c92c89016c12a677616668957351e7542
commit: 005b73d0dd83c9cb9420a196bea8070cde30ecac m68knommu: __force type casts for raw IO access
date:   4 months ago
config: m68k-randconfig-s031-20201115 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-107-gaf3512a6-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=005b73d0dd83c9cb9420a196bea8070cde30ecac
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 005b73d0dd83c9cb9420a196bea8070cde30ecac
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   drivers/dma/sun6i-dma.c: note: in included file (through arch/m68k/include/asm/io.h, include/linux/scatterlist.h, include/linux/dmaengine.h):
   arch/m68k/include/asm/io_no.h:96:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile [usertype] @@     got restricted __le32 [usertype] @@
   arch/m68k/include/asm/io_no.h:96:17: sparse:     expected unsigned int volatile [usertype]
   arch/m68k/include/asm/io_no.h:96:17: sparse:     got restricted __le32 [usertype]
   arch/m68k/include/asm/io_no.h:96:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile [usertype] @@     got restricted __le32 [usertype] @@
   arch/m68k/include/asm/io_no.h:96:17: sparse:     expected unsigned int volatile [usertype]
   arch/m68k/include/asm/io_no.h:96:17: sparse:     got restricted __le32 [usertype]
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:96:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile [usertype] @@     got restricted __le32 [usertype] @@
   arch/m68k/include/asm/io_no.h:96:17: sparse:     expected unsigned int volatile [usertype]
   arch/m68k/include/asm/io_no.h:96:17: sparse:     got restricted __le32 [usertype]
   arch/m68k/include/asm/io_no.h:96:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile [usertype] @@     got restricted __le32 [usertype] @@
   arch/m68k/include/asm/io_no.h:96:17: sparse:     expected unsigned int volatile [usertype]
   arch/m68k/include/asm/io_no.h:96:17: sparse:     got restricted __le32 [usertype]
   arch/m68k/include/asm/io_no.h:96:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile [usertype] @@     got restricted __le32 [usertype] @@
   arch/m68k/include/asm/io_no.h:96:17: sparse:     expected unsigned int volatile [usertype]
   arch/m68k/include/asm/io_no.h:96:17: sparse:     got restricted __le32 [usertype]
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>> drivers/dma/sun6i-dma.c:244:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *address @@     got void [noderef] __iomem *base @@
>> drivers/dma/sun6i-dma.c:244:45: sparse:     expected void *address
   drivers/dma/sun6i-dma.c:244:45: sparse:     got void [noderef] __iomem *base
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: too many warnings

vim +244 drivers/dma/sun6i-dma.c

555859308723d8 Maxime Ripard 2014-07-17  240  
555859308723d8 Maxime Ripard 2014-07-17  241  static inline void sun6i_dma_dump_chan_regs(struct sun6i_dma_dev *sdev,
555859308723d8 Maxime Ripard 2014-07-17  242  					    struct sun6i_pchan *pchan)
555859308723d8 Maxime Ripard 2014-07-17  243  {
42c0d54e623695 Vinod Koul    2014-07-28 @244  	phys_addr_t reg = virt_to_phys(pchan->base);
555859308723d8 Maxime Ripard 2014-07-17  245  
555859308723d8 Maxime Ripard 2014-07-17  246  	dev_dbg(sdev->slave.dev, "Chan %d reg: %pa\n"
555859308723d8 Maxime Ripard 2014-07-17  247  		"\t___en(%04x): \t0x%08x\n"
555859308723d8 Maxime Ripard 2014-07-17  248  		"\tpause(%04x): \t0x%08x\n"
555859308723d8 Maxime Ripard 2014-07-17  249  		"\tstart(%04x): \t0x%08x\n"
555859308723d8 Maxime Ripard 2014-07-17  250  		"\t__cfg(%04x): \t0x%08x\n"
555859308723d8 Maxime Ripard 2014-07-17  251  		"\t__src(%04x): \t0x%08x\n"
555859308723d8 Maxime Ripard 2014-07-17  252  		"\t__dst(%04x): \t0x%08x\n"
555859308723d8 Maxime Ripard 2014-07-17  253  		"\tcount(%04x): \t0x%08x\n"
555859308723d8 Maxime Ripard 2014-07-17  254  		"\t_para(%04x): \t0x%08x\n\n",
555859308723d8 Maxime Ripard 2014-07-17  255  		pchan->idx, &reg,
555859308723d8 Maxime Ripard 2014-07-17  256  		DMA_CHAN_ENABLE,
555859308723d8 Maxime Ripard 2014-07-17  257  		readl(pchan->base + DMA_CHAN_ENABLE),
555859308723d8 Maxime Ripard 2014-07-17  258  		DMA_CHAN_PAUSE,
555859308723d8 Maxime Ripard 2014-07-17  259  		readl(pchan->base + DMA_CHAN_PAUSE),
555859308723d8 Maxime Ripard 2014-07-17  260  		DMA_CHAN_LLI_ADDR,
555859308723d8 Maxime Ripard 2014-07-17  261  		readl(pchan->base + DMA_CHAN_LLI_ADDR),
555859308723d8 Maxime Ripard 2014-07-17  262  		DMA_CHAN_CUR_CFG,
555859308723d8 Maxime Ripard 2014-07-17  263  		readl(pchan->base + DMA_CHAN_CUR_CFG),
555859308723d8 Maxime Ripard 2014-07-17  264  		DMA_CHAN_CUR_SRC,
555859308723d8 Maxime Ripard 2014-07-17  265  		readl(pchan->base + DMA_CHAN_CUR_SRC),
555859308723d8 Maxime Ripard 2014-07-17  266  		DMA_CHAN_CUR_DST,
555859308723d8 Maxime Ripard 2014-07-17  267  		readl(pchan->base + DMA_CHAN_CUR_DST),
555859308723d8 Maxime Ripard 2014-07-17  268  		DMA_CHAN_CUR_CNT,
555859308723d8 Maxime Ripard 2014-07-17  269  		readl(pchan->base + DMA_CHAN_CUR_CNT),
555859308723d8 Maxime Ripard 2014-07-17  270  		DMA_CHAN_CUR_PARA,
555859308723d8 Maxime Ripard 2014-07-17  271  		readl(pchan->base + DMA_CHAN_CUR_PARA));
555859308723d8 Maxime Ripard 2014-07-17  272  }
555859308723d8 Maxime Ripard 2014-07-17  273  

:::::: The code at line 244 was first introduced by commit
:::::: 42c0d54e62369584f2491f072f405602ff504e0e dmaengine: sun6i: fix build failure on x86, xilinx targets

:::::: TO: Vinod Koul <vinod.koul@intel.com>
:::::: CC: Vinod Koul <vinod.koul@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ikeVEW9yuYc//A+q
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
HmdBBX0wZaX/A9RL9AIpbwEA

--ikeVEW9yuYc//A+q--
