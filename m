Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE1029AA70
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418240AbgJ0LTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:19:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:59859 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2899138AbgJ0LTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:19:45 -0400
IronPort-SDR: EjYvuRbDUlqqlsqYBKTCCsivJTg9Fl7vrHVp7gm6kV9gDlZF4ZaeWpILYvx1EnoJE8ConJFwVi
 h98P7Zf7LTLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="168161615"
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="gz'50?scan'50,208,50";a="168161615"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 04:19:43 -0700
IronPort-SDR: VZdrzVju1f6tfl79ZcwbLfQJhhmeTWQeJWIr+rQAuO1g/natyTVUPmkbFAMtr8Xnx9zJsNoTpx
 PHwHJSdab7Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="gz'50?scan'50,208,50";a="525849090"
Received: from lkp-server01.sh.intel.com (HELO ef28dff175aa) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Oct 2020 04:19:40 -0700
Received: from kbuild by ef28dff175aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kXN0t-0000Cu-Qn; Tue, 27 Oct 2020 11:19:39 +0000
Date:   Tue, 27 Oct 2020 19:19:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bin Liu <b-liu@ti.com>
Subject: drivers/usb/musb/musbhsdma.c:324:8: warning: variable 'devctl' set
 but not used
Message-ID: <202010271956.lOGjlakw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Paul,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4525c8781ec0701ce824e8bd379ae1b129e26568
commit: 57aadb46bd634c7889403220dcd110c7ff2c4868 usb: musb: jz4740: Add support for DMA
date:   7 months ago
config: mips-randconfig-r022-20201027 (attached as .config)
compiler: mips-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=57aadb46bd634c7889403220dcd110c7ff2c4868
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 57aadb46bd634c7889403220dcd110c7ff2c4868
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/usb/musb/musbhsdma.c: In function 'dma_controller_irq':
>> drivers/usb/musb/musbhsdma.c:324:8: warning: variable 'devctl' set but not used [-Wunused-but-set-variable]
     324 |     u8 devctl;
         |        ^~~~~~

vim +/devctl +324 drivers/usb/musb/musbhsdma.c

550a7375fe72092 Felipe Balbi    2008-07-24  265  
edce61776c7e212 Min Guo         2020-01-15  266  irqreturn_t dma_controller_irq(int irq, void *private_data)
550a7375fe72092 Felipe Balbi    2008-07-24  267  {
458e6a511f9dc91 Felipe Balbi    2008-09-11  268  	struct musb_dma_controller *controller = private_data;
458e6a511f9dc91 Felipe Balbi    2008-09-11  269  	struct musb *musb = controller->private_data;
458e6a511f9dc91 Felipe Balbi    2008-09-11  270  	struct musb_dma_channel *musb_channel;
458e6a511f9dc91 Felipe Balbi    2008-09-11  271  	struct dma_channel *channel;
458e6a511f9dc91 Felipe Balbi    2008-09-11  272  
458e6a511f9dc91 Felipe Balbi    2008-09-11  273  	void __iomem *mbase = controller->base;
458e6a511f9dc91 Felipe Balbi    2008-09-11  274  
550a7375fe72092 Felipe Balbi    2008-07-24  275  	irqreturn_t retval = IRQ_NONE;
458e6a511f9dc91 Felipe Balbi    2008-09-11  276  
550a7375fe72092 Felipe Balbi    2008-07-24  277  	unsigned long flags;
550a7375fe72092 Felipe Balbi    2008-07-24  278  
458e6a511f9dc91 Felipe Balbi    2008-09-11  279  	u8 bchannel;
458e6a511f9dc91 Felipe Balbi    2008-09-11  280  	u8 int_hsdma;
458e6a511f9dc91 Felipe Balbi    2008-09-11  281  
f933a0c0fe0ea5f Anand Gadiyar   2009-12-28  282  	u32 addr, count;
458e6a511f9dc91 Felipe Balbi    2008-09-11  283  	u16 csr;
458e6a511f9dc91 Felipe Balbi    2008-09-11  284  
550a7375fe72092 Felipe Balbi    2008-07-24  285  	spin_lock_irqsave(&musb->lock, flags);
550a7375fe72092 Felipe Balbi    2008-07-24  286  
9c93d7fd464e7aa Min Guo         2020-01-15  287  	int_hsdma = musb_clearb(mbase, MUSB_HSDMA_INTR);
550a7375fe72092 Felipe Balbi    2008-07-24  288  
f933a0c0fe0ea5f Anand Gadiyar   2009-12-28  289  	if (!int_hsdma) {
b99d3659b309b35 Bin Liu         2016-06-30  290  		musb_dbg(musb, "spurious DMA irq");
f933a0c0fe0ea5f Anand Gadiyar   2009-12-28  291  
f933a0c0fe0ea5f Anand Gadiyar   2009-12-28  292  		for (bchannel = 0; bchannel < MUSB_HSDMA_CHANNELS; bchannel++) {
f933a0c0fe0ea5f Anand Gadiyar   2009-12-28  293  			musb_channel = (struct musb_dma_channel *)
f933a0c0fe0ea5f Anand Gadiyar   2009-12-28  294  					&(controller->channel[bchannel]);
f933a0c0fe0ea5f Anand Gadiyar   2009-12-28  295  			channel = &musb_channel->channel;
f933a0c0fe0ea5f Anand Gadiyar   2009-12-28  296  			if (channel->status == MUSB_DMA_STATUS_BUSY) {
f933a0c0fe0ea5f Anand Gadiyar   2009-12-28  297  				count = musb_read_hsdma_count(mbase, bchannel);
f933a0c0fe0ea5f Anand Gadiyar   2009-12-28  298  
f933a0c0fe0ea5f Anand Gadiyar   2009-12-28  299  				if (count == 0)
f933a0c0fe0ea5f Anand Gadiyar   2009-12-28  300  					int_hsdma |= (1 << bchannel);
f933a0c0fe0ea5f Anand Gadiyar   2009-12-28  301  			}
f933a0c0fe0ea5f Anand Gadiyar   2009-12-28  302  		}
f933a0c0fe0ea5f Anand Gadiyar   2009-12-28  303  
b99d3659b309b35 Bin Liu         2016-06-30  304  		musb_dbg(musb, "int_hsdma = 0x%x", int_hsdma);
f933a0c0fe0ea5f Anand Gadiyar   2009-12-28  305  
f933a0c0fe0ea5f Anand Gadiyar   2009-12-28  306  		if (!int_hsdma)
f933a0c0fe0ea5f Anand Gadiyar   2009-12-28  307  			goto done;
f933a0c0fe0ea5f Anand Gadiyar   2009-12-28  308  	}
f933a0c0fe0ea5f Anand Gadiyar   2009-12-28  309  
458e6a511f9dc91 Felipe Balbi    2008-09-11  310  	for (bchannel = 0; bchannel < MUSB_HSDMA_CHANNELS; bchannel++) {
458e6a511f9dc91 Felipe Balbi    2008-09-11  311  		if (int_hsdma & (1 << bchannel)) {
458e6a511f9dc91 Felipe Balbi    2008-09-11  312  			musb_channel = (struct musb_dma_channel *)
458e6a511f9dc91 Felipe Balbi    2008-09-11  313  					&(controller->channel[bchannel]);
458e6a511f9dc91 Felipe Balbi    2008-09-11  314  			channel = &musb_channel->channel;
550a7375fe72092 Felipe Balbi    2008-07-24  315  
550a7375fe72092 Felipe Balbi    2008-07-24  316  			csr = musb_readw(mbase,
458e6a511f9dc91 Felipe Balbi    2008-09-11  317  					MUSB_HSDMA_CHANNEL_OFFSET(bchannel,
550a7375fe72092 Felipe Balbi    2008-07-24  318  							MUSB_HSDMA_CONTROL));
550a7375fe72092 Felipe Balbi    2008-07-24  319  
458e6a511f9dc91 Felipe Balbi    2008-09-11  320  			if (csr & (1 << MUSB_HSDMA_BUSERROR_SHIFT)) {
458e6a511f9dc91 Felipe Balbi    2008-09-11  321  				musb_channel->channel.status =
550a7375fe72092 Felipe Balbi    2008-07-24  322  					MUSB_DMA_STATUS_BUS_ABORT;
458e6a511f9dc91 Felipe Balbi    2008-09-11  323  			} else {
550a7375fe72092 Felipe Balbi    2008-07-24 @324  				u8 devctl;
550a7375fe72092 Felipe Balbi    2008-07-24  325  
6995eb68aab70e7 Bryan Wu        2008-12-02  326  				addr = musb_read_hsdma_addr(mbase,
6995eb68aab70e7 Bryan Wu        2008-12-02  327  						bchannel);
458e6a511f9dc91 Felipe Balbi    2008-09-11  328  				channel->actual_len = addr
458e6a511f9dc91 Felipe Balbi    2008-09-11  329  					- musb_channel->start_addr;
550a7375fe72092 Felipe Balbi    2008-07-24  330  
b99d3659b309b35 Bin Liu         2016-06-30  331  				musb_dbg(musb, "ch %p, 0x%x -> 0x%x (%zu / %d) %s",
458e6a511f9dc91 Felipe Balbi    2008-09-11  332  					channel, musb_channel->start_addr,
458e6a511f9dc91 Felipe Balbi    2008-09-11  333  					addr, channel->actual_len,
458e6a511f9dc91 Felipe Balbi    2008-09-11  334  					musb_channel->len,
458e6a511f9dc91 Felipe Balbi    2008-09-11  335  					(channel->actual_len
458e6a511f9dc91 Felipe Balbi    2008-09-11  336  						< musb_channel->len) ?
550a7375fe72092 Felipe Balbi    2008-07-24  337  					"=> reconfig 0" : "=> complete");
550a7375fe72092 Felipe Balbi    2008-07-24  338  
550a7375fe72092 Felipe Balbi    2008-07-24  339  				devctl = musb_readb(mbase, MUSB_DEVCTL);
550a7375fe72092 Felipe Balbi    2008-07-24  340  
458e6a511f9dc91 Felipe Balbi    2008-09-11  341  				channel->status = MUSB_DMA_STATUS_FREE;
550a7375fe72092 Felipe Balbi    2008-07-24  342  
550a7375fe72092 Felipe Balbi    2008-07-24  343  				/* completed */
c418fd6c01fbc55 Paul Elder      2019-01-30  344  				if (musb_channel->transmit &&
c418fd6c01fbc55 Paul Elder      2019-01-30  345  					(!channel->desired_mode ||
c418fd6c01fbc55 Paul Elder      2019-01-30  346  					(channel->actual_len %
c418fd6c01fbc55 Paul Elder      2019-01-30  347  					    musb_channel->max_packet_sz))) {
b6e434a5404b9ce Sergei Shtylyov 2009-03-26  348  					u8  epnum  = musb_channel->epnum;
d026e9c76aac363 Tony Lindgren   2014-11-24  349  					int offset = musb->io.ep_offset(epnum,
b6e434a5404b9ce Sergei Shtylyov 2009-03-26  350  								    MUSB_TXCSR);
b6e434a5404b9ce Sergei Shtylyov 2009-03-26  351  					u16 txcsr;
b6e434a5404b9ce Sergei Shtylyov 2009-03-26  352  
b6e434a5404b9ce Sergei Shtylyov 2009-03-26  353  					/*
b6e434a5404b9ce Sergei Shtylyov 2009-03-26  354  					 * The programming guide says that we
b6e434a5404b9ce Sergei Shtylyov 2009-03-26  355  					 * must clear DMAENAB before DMAMODE.
b6e434a5404b9ce Sergei Shtylyov 2009-03-26  356  					 */
b6e434a5404b9ce Sergei Shtylyov 2009-03-26  357  					musb_ep_select(mbase, epnum);
b6e434a5404b9ce Sergei Shtylyov 2009-03-26  358  					txcsr = musb_readw(mbase, offset);
c418fd6c01fbc55 Paul Elder      2019-01-30  359  					if (channel->desired_mode == 1) {
b6e434a5404b9ce Sergei Shtylyov 2009-03-26  360  						txcsr &= ~(MUSB_TXCSR_DMAENAB
b6e434a5404b9ce Sergei Shtylyov 2009-03-26  361  							| MUSB_TXCSR_AUTOSET);
b6e434a5404b9ce Sergei Shtylyov 2009-03-26  362  						musb_writew(mbase, offset, txcsr);
550a7375fe72092 Felipe Balbi    2008-07-24  363  						/* Send out the packet */
b6e434a5404b9ce Sergei Shtylyov 2009-03-26  364  						txcsr &= ~MUSB_TXCSR_DMAMODE;
c418fd6c01fbc55 Paul Elder      2019-01-30  365  						txcsr |= MUSB_TXCSR_DMAENAB;
c418fd6c01fbc55 Paul Elder      2019-01-30  366  					}
b6e434a5404b9ce Sergei Shtylyov 2009-03-26  367  					txcsr |=  MUSB_TXCSR_TXPKTRDY;
b6e434a5404b9ce Sergei Shtylyov 2009-03-26  368  					musb_writew(mbase, offset, txcsr);
458e6a511f9dc91 Felipe Balbi    2008-09-11  369  				}
c7bbc056a92476b Sergei Shtylyov 2009-03-26  370  				musb_dma_completion(musb, musb_channel->epnum,
c7bbc056a92476b Sergei Shtylyov 2009-03-26  371  						    musb_channel->transmit);
550a7375fe72092 Felipe Balbi    2008-07-24  372  			}
550a7375fe72092 Felipe Balbi    2008-07-24  373  		}
550a7375fe72092 Felipe Balbi    2008-07-24  374  	}
6995eb68aab70e7 Bryan Wu        2008-12-02  375  
550a7375fe72092 Felipe Balbi    2008-07-24  376  	retval = IRQ_HANDLED;
550a7375fe72092 Felipe Balbi    2008-07-24  377  done:
550a7375fe72092 Felipe Balbi    2008-07-24  378  	spin_unlock_irqrestore(&musb->lock, flags);
550a7375fe72092 Felipe Balbi    2008-07-24  379  	return retval;
550a7375fe72092 Felipe Balbi    2008-07-24  380  }
edce61776c7e212 Min Guo         2020-01-15  381  EXPORT_SYMBOL_GPL(dma_controller_irq);
550a7375fe72092 Felipe Balbi    2008-07-24  382  

:::::: The code at line 324 was first introduced by commit
:::::: 550a7375fe720924241f0eb76e4a5c1a3eb8c32f USB: Add MUSB and TUSB support

:::::: TO: Felipe Balbi <felipe.balbi@nokia.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--VS++wcV0S1rZb1Fb
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--VS++wcV0S1rZb1Fb--
