Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9AA29DA0C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389934AbgJ1XMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:12:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:27054 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbgJ1XM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:12:28 -0400
IronPort-SDR: r81g+c7A0xolC8eKeBXH4MQxqKCDbSRCs0V+v4ijO82HQSufRXjKPaGOtd72NCXZXgl50dQY7K
 Ayg9So98yb4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="168482582"
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="gz'50?scan'50,208,50";a="168482582"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 16:12:25 -0700
IronPort-SDR: ekcqKfNPmuPqGnhbhXHmOaXYe3oPJVZmm07ZlJXY7ZbqPEFrnvJXo3OhF33Jyz5MaX2mKuw4LO
 7WYHrFYLrMJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="gz'50?scan'50,208,50";a="468911368"
Received: from lkp-server02.sh.intel.com (HELO 0471ce7c9af6) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 28 Oct 2020 16:12:23 -0700
Received: from kbuild by 0471ce7c9af6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kXucA-0000EX-Md; Wed, 28 Oct 2020 23:12:22 +0000
Date:   Thu, 29 Oct 2020 07:11:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Will Deacon <will@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/dma/mediatek/mtk-hsdma.c:451:17: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202010290733.VhRpOMqe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   23859ae44402f4d935b9ee548135dd1e65e2cbf4
commit: a5460b5e5fb82656807840d40d3deaecad094044 READ_ONCE: Simplify implementations of {READ,WRITE}_ONCE()
date:   7 months ago
config: xtensa-randconfig-s031-20201029 (attached as .config)
compiler: xtensa-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-56-gc09e8239-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a5460b5e5fb82656807840d40d3deaecad094044
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a5460b5e5fb82656807840d40d3deaecad094044
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=xtensa 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> drivers/dma/mediatek/mtk-hsdma.c:451:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 volatile @@     got unsigned int [usertype] src @@
   drivers/dma/mediatek/mtk-hsdma.c:451:17: sparse:     expected restricted __le32 volatile
>> drivers/dma/mediatek/mtk-hsdma.c:451:17: sparse:     got unsigned int [usertype] src
   drivers/dma/mediatek/mtk-hsdma.c:452:17: sparse: sparse: restricted __le32 degrades to integer
   drivers/dma/mediatek/mtk-hsdma.c:452:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 volatile @@     got unsigned int @@
   drivers/dma/mediatek/mtk-hsdma.c:452:17: sparse:     expected restricted __le32 volatile
   drivers/dma/mediatek/mtk-hsdma.c:452:17: sparse:     got unsigned int
>> drivers/dma/mediatek/mtk-hsdma.c:456:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 volatile @@     got unsigned int [usertype] dest @@
   drivers/dma/mediatek/mtk-hsdma.c:456:17: sparse:     expected restricted __le32 volatile
>> drivers/dma/mediatek/mtk-hsdma.c:456:17: sparse:     got unsigned int [usertype] dest
   drivers/dma/mediatek/mtk-hsdma.c:457:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 volatile @@     got int @@
   drivers/dma/mediatek/mtk-hsdma.c:457:17: sparse:     expected restricted __le32 volatile
   drivers/dma/mediatek/mtk-hsdma.c:457:17: sparse:     got int
   drivers/dma/mediatek/mtk-hsdma.c:580:33: sparse: sparse: restricted __le32 degrades to integer
   drivers/dma/mediatek/mtk-hsdma.c:604:26: sparse: sparse: Using plain integer as NULL pointer
   drivers/dma/mediatek/mtk-hsdma.c:878:18: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le32 [usertype] ddone @@     got unsigned long @@
   drivers/dma/mediatek/mtk-hsdma.c:878:18: sparse:     expected restricted __le32 [usertype] ddone
   drivers/dma/mediatek/mtk-hsdma.c:878:18: sparse:     got unsigned long
   drivers/dma/mediatek/mtk-hsdma.c:879:16: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le32 [usertype] ls0 @@     got unsigned long @@
   drivers/dma/mediatek/mtk-hsdma.c:879:16: sparse:     expected restricted __le32 [usertype] ls0
   drivers/dma/mediatek/mtk-hsdma.c:879:16: sparse:     got unsigned long
   drivers/dma/mediatek/mtk-hsdma.c:883:18: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le32 [usertype] ddone @@     got unsigned long @@
   drivers/dma/mediatek/mtk-hsdma.c:883:18: sparse:     expected restricted __le32 [usertype] ddone
   drivers/dma/mediatek/mtk-hsdma.c:883:18: sparse:     got unsigned long
   drivers/dma/mediatek/mtk-hsdma.c:884:16: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le32 [usertype] ls0 @@     got unsigned long @@
   drivers/dma/mediatek/mtk-hsdma.c:884:16: sparse:     expected restricted __le32 [usertype] ls0
   drivers/dma/mediatek/mtk-hsdma.c:884:16: sparse:     got unsigned long
   drivers/dma/mediatek/mtk-hsdma.c: note: in included file (through arch/xtensa/include/asm/io.h, include/linux/scatterlist.h, include/linux/dmaengine.h):
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32

vim +451 drivers/dma/mediatek/mtk-hsdma.c

548c4597e984b7 Sean Wang 2018-03-15  411  
548c4597e984b7 Sean Wang 2018-03-15  412  static int mtk_hsdma_issue_pending_vdesc(struct mtk_hsdma_device *hsdma,
548c4597e984b7 Sean Wang 2018-03-15  413  					 struct mtk_hsdma_pchan *pc,
548c4597e984b7 Sean Wang 2018-03-15  414  					 struct mtk_hsdma_vdesc *hvd)
548c4597e984b7 Sean Wang 2018-03-15  415  {
548c4597e984b7 Sean Wang 2018-03-15  416  	struct mtk_hsdma_ring *ring = &pc->ring;
548c4597e984b7 Sean Wang 2018-03-15  417  	struct mtk_hsdma_pdesc *txd, *rxd;
548c4597e984b7 Sean Wang 2018-03-15  418  	u16 reserved, prev, tlen, num_sgs;
548c4597e984b7 Sean Wang 2018-03-15  419  	unsigned long flags;
548c4597e984b7 Sean Wang 2018-03-15  420  
548c4597e984b7 Sean Wang 2018-03-15  421  	/* Protect against PC is accessed by multiple VCs simultaneously */
548c4597e984b7 Sean Wang 2018-03-15  422  	spin_lock_irqsave(&hsdma->lock, flags);
548c4597e984b7 Sean Wang 2018-03-15  423  
548c4597e984b7 Sean Wang 2018-03-15  424  	/*
548c4597e984b7 Sean Wang 2018-03-15  425  	 * Reserve rooms, where pc->nr_free is used to track how many free
548c4597e984b7 Sean Wang 2018-03-15  426  	 * rooms in the ring being updated in user and IRQ context.
548c4597e984b7 Sean Wang 2018-03-15  427  	 */
548c4597e984b7 Sean Wang 2018-03-15  428  	num_sgs = DIV_ROUND_UP(hvd->len, MTK_HSDMA_MAX_LEN);
548c4597e984b7 Sean Wang 2018-03-15  429  	reserved = min_t(u16, num_sgs, atomic_read(&pc->nr_free));
548c4597e984b7 Sean Wang 2018-03-15  430  
548c4597e984b7 Sean Wang 2018-03-15  431  	if (!reserved) {
548c4597e984b7 Sean Wang 2018-03-15  432  		spin_unlock_irqrestore(&hsdma->lock, flags);
548c4597e984b7 Sean Wang 2018-03-15  433  		return -ENOSPC;
548c4597e984b7 Sean Wang 2018-03-15  434  	}
548c4597e984b7 Sean Wang 2018-03-15  435  
548c4597e984b7 Sean Wang 2018-03-15  436  	atomic_sub(reserved, &pc->nr_free);
548c4597e984b7 Sean Wang 2018-03-15  437  
548c4597e984b7 Sean Wang 2018-03-15  438  	while (reserved--) {
548c4597e984b7 Sean Wang 2018-03-15  439  		/* Limit size by PD capability for valid data moving */
548c4597e984b7 Sean Wang 2018-03-15  440  		tlen = (hvd->len > MTK_HSDMA_MAX_LEN) ?
548c4597e984b7 Sean Wang 2018-03-15  441  		       MTK_HSDMA_MAX_LEN : hvd->len;
548c4597e984b7 Sean Wang 2018-03-15  442  
548c4597e984b7 Sean Wang 2018-03-15  443  		/*
548c4597e984b7 Sean Wang 2018-03-15  444  		 * Setup PDs using the remaining VD info mapped on those
548c4597e984b7 Sean Wang 2018-03-15  445  		 * reserved rooms. And since RXD is shared memory between the
548c4597e984b7 Sean Wang 2018-03-15  446  		 * host and the device allocated by dma_alloc_coherent call,
548c4597e984b7 Sean Wang 2018-03-15  447  		 * the helper macro WRITE_ONCE can ensure the data written to
548c4597e984b7 Sean Wang 2018-03-15  448  		 * RAM would really happens.
548c4597e984b7 Sean Wang 2018-03-15  449  		 */
548c4597e984b7 Sean Wang 2018-03-15  450  		txd = &ring->txd[ring->cur_tptr];
548c4597e984b7 Sean Wang 2018-03-15 @451  		WRITE_ONCE(txd->desc1, hvd->src);
548c4597e984b7 Sean Wang 2018-03-15  452  		WRITE_ONCE(txd->desc2,
548c4597e984b7 Sean Wang 2018-03-15  453  			   hsdma->soc->ls0 | MTK_HSDMA_DESC_PLEN(tlen));
548c4597e984b7 Sean Wang 2018-03-15  454  
548c4597e984b7 Sean Wang 2018-03-15  455  		rxd = &ring->rxd[ring->cur_tptr];
548c4597e984b7 Sean Wang 2018-03-15 @456  		WRITE_ONCE(rxd->desc1, hvd->dest);
548c4597e984b7 Sean Wang 2018-03-15  457  		WRITE_ONCE(rxd->desc2, MTK_HSDMA_DESC_PLEN(tlen));
548c4597e984b7 Sean Wang 2018-03-15  458  
548c4597e984b7 Sean Wang 2018-03-15  459  		/* Associate VD, the PD belonged to */
548c4597e984b7 Sean Wang 2018-03-15  460  		ring->cb[ring->cur_tptr].vd = &hvd->vd;
548c4597e984b7 Sean Wang 2018-03-15  461  
548c4597e984b7 Sean Wang 2018-03-15  462  		/* Move forward the pointer of TX ring */
548c4597e984b7 Sean Wang 2018-03-15  463  		ring->cur_tptr = MTK_HSDMA_NEXT_DESP_IDX(ring->cur_tptr,
548c4597e984b7 Sean Wang 2018-03-15  464  							 MTK_DMA_SIZE);
548c4597e984b7 Sean Wang 2018-03-15  465  
548c4597e984b7 Sean Wang 2018-03-15  466  		/* Update VD with remaining data */
548c4597e984b7 Sean Wang 2018-03-15  467  		hvd->src  += tlen;
548c4597e984b7 Sean Wang 2018-03-15  468  		hvd->dest += tlen;
548c4597e984b7 Sean Wang 2018-03-15  469  		hvd->len  -= tlen;
548c4597e984b7 Sean Wang 2018-03-15  470  	}
548c4597e984b7 Sean Wang 2018-03-15  471  
548c4597e984b7 Sean Wang 2018-03-15  472  	/*
548c4597e984b7 Sean Wang 2018-03-15  473  	 * Tagging flag for the last PD for VD will be responsible for
548c4597e984b7 Sean Wang 2018-03-15  474  	 * completing VD.
548c4597e984b7 Sean Wang 2018-03-15  475  	 */
548c4597e984b7 Sean Wang 2018-03-15  476  	if (!hvd->len) {
548c4597e984b7 Sean Wang 2018-03-15  477  		prev = MTK_HSDMA_LAST_DESP_IDX(ring->cur_tptr, MTK_DMA_SIZE);
548c4597e984b7 Sean Wang 2018-03-15  478  		ring->cb[prev].flag = MTK_HSDMA_VDESC_FINISHED;
548c4597e984b7 Sean Wang 2018-03-15  479  	}
548c4597e984b7 Sean Wang 2018-03-15  480  
548c4597e984b7 Sean Wang 2018-03-15  481  	/* Ensure all changes indeed done before we're going on */
548c4597e984b7 Sean Wang 2018-03-15  482  	wmb();
548c4597e984b7 Sean Wang 2018-03-15  483  
548c4597e984b7 Sean Wang 2018-03-15  484  	/*
548c4597e984b7 Sean Wang 2018-03-15  485  	 * Updating into hardware the pointer of TX ring lets HSDMA to take
548c4597e984b7 Sean Wang 2018-03-15  486  	 * action for those pending PDs.
548c4597e984b7 Sean Wang 2018-03-15  487  	 */
548c4597e984b7 Sean Wang 2018-03-15  488  	mtk_dma_write(hsdma, MTK_HSDMA_TX_CPU, ring->cur_tptr);
548c4597e984b7 Sean Wang 2018-03-15  489  
548c4597e984b7 Sean Wang 2018-03-15  490  	spin_unlock_irqrestore(&hsdma->lock, flags);
548c4597e984b7 Sean Wang 2018-03-15  491  
548c4597e984b7 Sean Wang 2018-03-15  492  	return 0;
548c4597e984b7 Sean Wang 2018-03-15  493  }
548c4597e984b7 Sean Wang 2018-03-15  494  

:::::: The code at line 451 was first introduced by commit
:::::: 548c4597e984b79aad8190235d664f1c3a433f94 dmaengine: mediatek: Add MediaTek High-Speed DMA controller for MT7622 and MT7623 SoC

:::::: TO: Sean Wang <sean.wang@mediatek.com>
:::::: CC: Vinod Koul <vinod.koul@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--y0ulUmNC+osPPQO6
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--y0ulUmNC+osPPQO6--
