Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5326A2B1A98
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgKMMEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:04:01 -0500
Received: from mga17.intel.com ([192.55.52.151]:54033 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgKMLji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:39:38 -0500
IronPort-SDR: UbHVdvlCEdCXVzqg3x5VpS9iGnoVJDRgggLaCZZurwR6yS3Dz56bS9gsV0pjUCaX1FtqBEXPg5
 /OGdU93/qgfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="150309964"
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; 
   d="gz'50?scan'50,208,50";a="150309964"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 03:37:34 -0800
IronPort-SDR: aaP9QehZlGVK4KPGsq5+HIy2brxp9jSegGjNfkjlT1VTkZp80rSBvso7uC25Xu1jnAQa1kUTMN
 r8jH574NLAOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; 
   d="gz'50?scan'50,208,50";a="361328272"
Received: from lkp-server02.sh.intel.com (HELO 697932c29306) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 13 Nov 2020 03:37:32 -0800
Received: from kbuild by 697932c29306 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kdXOW-0000HC-Ar; Fri, 13 Nov 2020 11:37:32 +0000
Date:   Fri, 13 Nov 2020 19:37:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: drivers/mmc/host/moxart-mmc.c:260:7: warning: variable 'dma_time'
 set but not used
Message-ID: <202011131956.egklXLCS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Krzysztof,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   585e5b17b92dead8a3aca4e3c9876fbca5f7e0ba
commit: 54d8454436a205682bd89d66d8d9eedbc8452d15 mmc: host: Enable compile testing of multiple drivers
date:   10 weeks ago
config: h8300-randconfig-r013-20201105 (attached as .config)
compiler: h8300-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=54d8454436a205682bd89d66d8d9eedbc8452d15
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 54d8454436a205682bd89d66d8d9eedbc8452d15
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=h8300 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/mmc/host/moxart-mmc.c:16:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   include/asm-generic/page.h:93:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      93 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/mmc/host/moxart-mmc.c: In function 'moxart_transfer_dma':
>> drivers/mmc/host/moxart-mmc.c:260:7: warning: variable 'dma_time' set but not used [-Wunused-but-set-variable]
     260 |  long dma_time;
         |       ^~~~~~~~
   drivers/mmc/host/moxart-mmc.c: In function 'moxart_request':
>> drivers/mmc/host/moxart-mmc.c:398:7: warning: variable 'pio_time' set but not used [-Wunused-but-set-variable]
     398 |  long pio_time;
         |       ^~~~~~~~

vim +/dma_time +260 drivers/mmc/host/moxart-mmc.c

1b66e94e6b99953 Jonas Jensen      2014-04-09  256  
1b66e94e6b99953 Jonas Jensen      2014-04-09  257  static void moxart_transfer_dma(struct mmc_data *data, struct moxart_host *host)
1b66e94e6b99953 Jonas Jensen      2014-04-09  258  {
feeef096a770d28 Heiner Kallweit   2017-03-26  259  	u32 len, dir_slave;
41f469cac2663a4 Nicholas Mc Guire 2016-07-25 @260  	long dma_time;
1b66e94e6b99953 Jonas Jensen      2014-04-09  261  	struct dma_async_tx_descriptor *desc = NULL;
1b66e94e6b99953 Jonas Jensen      2014-04-09  262  	struct dma_chan *dma_chan;
1b66e94e6b99953 Jonas Jensen      2014-04-09  263  
1b66e94e6b99953 Jonas Jensen      2014-04-09  264  	if (host->data_len == data->bytes_xfered)
1b66e94e6b99953 Jonas Jensen      2014-04-09  265  		return;
1b66e94e6b99953 Jonas Jensen      2014-04-09  266  
1b66e94e6b99953 Jonas Jensen      2014-04-09  267  	if (data->flags & MMC_DATA_WRITE) {
1b66e94e6b99953 Jonas Jensen      2014-04-09  268  		dma_chan = host->dma_chan_tx;
1b66e94e6b99953 Jonas Jensen      2014-04-09  269  		dir_slave = DMA_MEM_TO_DEV;
1b66e94e6b99953 Jonas Jensen      2014-04-09  270  	} else {
1b66e94e6b99953 Jonas Jensen      2014-04-09  271  		dma_chan = host->dma_chan_rx;
1b66e94e6b99953 Jonas Jensen      2014-04-09  272  		dir_slave = DMA_DEV_TO_MEM;
1b66e94e6b99953 Jonas Jensen      2014-04-09  273  	}
1b66e94e6b99953 Jonas Jensen      2014-04-09  274  
1b66e94e6b99953 Jonas Jensen      2014-04-09  275  	len = dma_map_sg(dma_chan->device->dev, data->sg,
feeef096a770d28 Heiner Kallweit   2017-03-26  276  			 data->sg_len, mmc_get_dma_dir(data));
1b66e94e6b99953 Jonas Jensen      2014-04-09  277  
1b66e94e6b99953 Jonas Jensen      2014-04-09  278  	if (len > 0) {
1b66e94e6b99953 Jonas Jensen      2014-04-09  279  		desc = dmaengine_prep_slave_sg(dma_chan, data->sg,
1b66e94e6b99953 Jonas Jensen      2014-04-09  280  					       len, dir_slave,
1b66e94e6b99953 Jonas Jensen      2014-04-09  281  					       DMA_PREP_INTERRUPT |
1b66e94e6b99953 Jonas Jensen      2014-04-09  282  					       DMA_CTRL_ACK);
1b66e94e6b99953 Jonas Jensen      2014-04-09  283  	} else {
1b66e94e6b99953 Jonas Jensen      2014-04-09  284  		dev_err(mmc_dev(host->mmc), "dma_map_sg returned zero length\n");
1b66e94e6b99953 Jonas Jensen      2014-04-09  285  	}
1b66e94e6b99953 Jonas Jensen      2014-04-09  286  
1b66e94e6b99953 Jonas Jensen      2014-04-09  287  	if (desc) {
1b66e94e6b99953 Jonas Jensen      2014-04-09  288  		host->tx_desc = desc;
1b66e94e6b99953 Jonas Jensen      2014-04-09  289  		desc->callback = moxart_dma_complete;
1b66e94e6b99953 Jonas Jensen      2014-04-09  290  		desc->callback_param = host;
1b66e94e6b99953 Jonas Jensen      2014-04-09  291  		dmaengine_submit(desc);
1b66e94e6b99953 Jonas Jensen      2014-04-09  292  		dma_async_issue_pending(dma_chan);
1b66e94e6b99953 Jonas Jensen      2014-04-09  293  	}
1b66e94e6b99953 Jonas Jensen      2014-04-09  294  
1b66e94e6b99953 Jonas Jensen      2014-04-09  295  	data->bytes_xfered += host->data_remain;
1b66e94e6b99953 Jonas Jensen      2014-04-09  296  
1b66e94e6b99953 Jonas Jensen      2014-04-09  297  	dma_time = wait_for_completion_interruptible_timeout(
1b66e94e6b99953 Jonas Jensen      2014-04-09  298  		   &host->dma_complete, host->timeout);
1b66e94e6b99953 Jonas Jensen      2014-04-09  299  
1b66e94e6b99953 Jonas Jensen      2014-04-09  300  	dma_unmap_sg(dma_chan->device->dev,
1b66e94e6b99953 Jonas Jensen      2014-04-09  301  		     data->sg, data->sg_len,
feeef096a770d28 Heiner Kallweit   2017-03-26  302  		     mmc_get_dma_dir(data));
1b66e94e6b99953 Jonas Jensen      2014-04-09  303  }
1b66e94e6b99953 Jonas Jensen      2014-04-09  304  
1b66e94e6b99953 Jonas Jensen      2014-04-09  305  
1b66e94e6b99953 Jonas Jensen      2014-04-09  306  static void moxart_transfer_pio(struct moxart_host *host)
1b66e94e6b99953 Jonas Jensen      2014-04-09  307  {
1b66e94e6b99953 Jonas Jensen      2014-04-09  308  	struct mmc_data *data = host->mrq->cmd->data;
1b66e94e6b99953 Jonas Jensen      2014-04-09  309  	u32 *sgp, len = 0, remain, status;
1b66e94e6b99953 Jonas Jensen      2014-04-09  310  
1b66e94e6b99953 Jonas Jensen      2014-04-09  311  	if (host->data_len == data->bytes_xfered)
1b66e94e6b99953 Jonas Jensen      2014-04-09  312  		return;
1b66e94e6b99953 Jonas Jensen      2014-04-09  313  
1b66e94e6b99953 Jonas Jensen      2014-04-09  314  	sgp = sg_virt(host->cur_sg);
1b66e94e6b99953 Jonas Jensen      2014-04-09  315  	remain = host->data_remain;
1b66e94e6b99953 Jonas Jensen      2014-04-09  316  
1b66e94e6b99953 Jonas Jensen      2014-04-09  317  	if (data->flags & MMC_DATA_WRITE) {
1b66e94e6b99953 Jonas Jensen      2014-04-09  318  		while (remain > 0) {
1b66e94e6b99953 Jonas Jensen      2014-04-09  319  			if (moxart_wait_for_status(host, FIFO_URUN, &status)
1b66e94e6b99953 Jonas Jensen      2014-04-09  320  			     == -ETIMEDOUT) {
1b66e94e6b99953 Jonas Jensen      2014-04-09  321  				data->error = -ETIMEDOUT;
1b66e94e6b99953 Jonas Jensen      2014-04-09  322  				complete(&host->pio_complete);
1b66e94e6b99953 Jonas Jensen      2014-04-09  323  				return;
1b66e94e6b99953 Jonas Jensen      2014-04-09  324  			}
1b66e94e6b99953 Jonas Jensen      2014-04-09  325  			for (len = 0; len < remain && len < host->fifo_width;) {
1b66e94e6b99953 Jonas Jensen      2014-04-09  326  				iowrite32(*sgp, host->base + REG_DATA_WINDOW);
1b66e94e6b99953 Jonas Jensen      2014-04-09  327  				sgp++;
1b66e94e6b99953 Jonas Jensen      2014-04-09  328  				len += 4;
1b66e94e6b99953 Jonas Jensen      2014-04-09  329  			}
1b66e94e6b99953 Jonas Jensen      2014-04-09  330  			remain -= len;
1b66e94e6b99953 Jonas Jensen      2014-04-09  331  		}
1b66e94e6b99953 Jonas Jensen      2014-04-09  332  
1b66e94e6b99953 Jonas Jensen      2014-04-09  333  	} else {
1b66e94e6b99953 Jonas Jensen      2014-04-09  334  		while (remain > 0) {
1b66e94e6b99953 Jonas Jensen      2014-04-09  335  			if (moxart_wait_for_status(host, FIFO_ORUN, &status)
1b66e94e6b99953 Jonas Jensen      2014-04-09  336  			    == -ETIMEDOUT) {
1b66e94e6b99953 Jonas Jensen      2014-04-09  337  				data->error = -ETIMEDOUT;
1b66e94e6b99953 Jonas Jensen      2014-04-09  338  				complete(&host->pio_complete);
1b66e94e6b99953 Jonas Jensen      2014-04-09  339  				return;
1b66e94e6b99953 Jonas Jensen      2014-04-09  340  			}
1b66e94e6b99953 Jonas Jensen      2014-04-09  341  			for (len = 0; len < remain && len < host->fifo_width;) {
1b66e94e6b99953 Jonas Jensen      2014-04-09  342  				/* SCR data must be read in big endian. */
1b66e94e6b99953 Jonas Jensen      2014-04-09  343  				if (data->mrq->cmd->opcode == SD_APP_SEND_SCR)
1b66e94e6b99953 Jonas Jensen      2014-04-09  344  					*sgp = ioread32be(host->base +
1b66e94e6b99953 Jonas Jensen      2014-04-09  345  							  REG_DATA_WINDOW);
1b66e94e6b99953 Jonas Jensen      2014-04-09  346  				else
1b66e94e6b99953 Jonas Jensen      2014-04-09  347  					*sgp = ioread32(host->base +
1b66e94e6b99953 Jonas Jensen      2014-04-09  348  							REG_DATA_WINDOW);
1b66e94e6b99953 Jonas Jensen      2014-04-09  349  				sgp++;
1b66e94e6b99953 Jonas Jensen      2014-04-09  350  				len += 4;
1b66e94e6b99953 Jonas Jensen      2014-04-09  351  			}
1b66e94e6b99953 Jonas Jensen      2014-04-09  352  			remain -= len;
1b66e94e6b99953 Jonas Jensen      2014-04-09  353  		}
1b66e94e6b99953 Jonas Jensen      2014-04-09  354  	}
1b66e94e6b99953 Jonas Jensen      2014-04-09  355  
1b66e94e6b99953 Jonas Jensen      2014-04-09  356  	data->bytes_xfered += host->data_remain - remain;
1b66e94e6b99953 Jonas Jensen      2014-04-09  357  	host->data_remain = remain;
1b66e94e6b99953 Jonas Jensen      2014-04-09  358  
1b66e94e6b99953 Jonas Jensen      2014-04-09  359  	if (host->data_len != data->bytes_xfered)
1b66e94e6b99953 Jonas Jensen      2014-04-09  360  		moxart_next_sg(host);
1b66e94e6b99953 Jonas Jensen      2014-04-09  361  	else
1b66e94e6b99953 Jonas Jensen      2014-04-09  362  		complete(&host->pio_complete);
1b66e94e6b99953 Jonas Jensen      2014-04-09  363  }
1b66e94e6b99953 Jonas Jensen      2014-04-09  364  
1b66e94e6b99953 Jonas Jensen      2014-04-09  365  static void moxart_prepare_data(struct moxart_host *host)
1b66e94e6b99953 Jonas Jensen      2014-04-09  366  {
1b66e94e6b99953 Jonas Jensen      2014-04-09  367  	struct mmc_data *data = host->mrq->cmd->data;
1b66e94e6b99953 Jonas Jensen      2014-04-09  368  	u32 datactrl;
1b66e94e6b99953 Jonas Jensen      2014-04-09  369  	int blksz_bits;
1b66e94e6b99953 Jonas Jensen      2014-04-09  370  
1b66e94e6b99953 Jonas Jensen      2014-04-09  371  	if (!data)
1b66e94e6b99953 Jonas Jensen      2014-04-09  372  		return;
1b66e94e6b99953 Jonas Jensen      2014-04-09  373  
1b66e94e6b99953 Jonas Jensen      2014-04-09  374  	host->data_len = data->blocks * data->blksz;
1b66e94e6b99953 Jonas Jensen      2014-04-09  375  	blksz_bits = ffs(data->blksz) - 1;
1b66e94e6b99953 Jonas Jensen      2014-04-09  376  	BUG_ON(1 << blksz_bits != data->blksz);
1b66e94e6b99953 Jonas Jensen      2014-04-09  377  
1b66e94e6b99953 Jonas Jensen      2014-04-09  378  	moxart_init_sg(host, data);
1b66e94e6b99953 Jonas Jensen      2014-04-09  379  
1b66e94e6b99953 Jonas Jensen      2014-04-09  380  	datactrl = DCR_DATA_EN | (blksz_bits & DCR_BLK_SIZE);
1b66e94e6b99953 Jonas Jensen      2014-04-09  381  
1b66e94e6b99953 Jonas Jensen      2014-04-09  382  	if (data->flags & MMC_DATA_WRITE)
1b66e94e6b99953 Jonas Jensen      2014-04-09  383  		datactrl |= DCR_DATA_WRITE;
1b66e94e6b99953 Jonas Jensen      2014-04-09  384  
1b66e94e6b99953 Jonas Jensen      2014-04-09  385  	if ((host->data_len > host->fifo_width) && host->have_dma)
1b66e94e6b99953 Jonas Jensen      2014-04-09  386  		datactrl |= DCR_DMA_EN;
1b66e94e6b99953 Jonas Jensen      2014-04-09  387  
1b66e94e6b99953 Jonas Jensen      2014-04-09  388  	writel(DCR_DATA_FIFO_RESET, host->base + REG_DATA_CONTROL);
1b66e94e6b99953 Jonas Jensen      2014-04-09  389  	writel(MASK_DATA | FIFO_URUN | FIFO_ORUN, host->base + REG_CLEAR);
1b66e94e6b99953 Jonas Jensen      2014-04-09  390  	writel(host->rate, host->base + REG_DATA_TIMER);
1b66e94e6b99953 Jonas Jensen      2014-04-09  391  	writel(host->data_len, host->base + REG_DATA_LENGTH);
1b66e94e6b99953 Jonas Jensen      2014-04-09  392  	writel(datactrl, host->base + REG_DATA_CONTROL);
1b66e94e6b99953 Jonas Jensen      2014-04-09  393  }
1b66e94e6b99953 Jonas Jensen      2014-04-09  394  
1b66e94e6b99953 Jonas Jensen      2014-04-09  395  static void moxart_request(struct mmc_host *mmc, struct mmc_request *mrq)
1b66e94e6b99953 Jonas Jensen      2014-04-09  396  {
1b66e94e6b99953 Jonas Jensen      2014-04-09  397  	struct moxart_host *host = mmc_priv(mmc);
41f469cac2663a4 Nicholas Mc Guire 2016-07-25 @398  	long pio_time;
41f469cac2663a4 Nicholas Mc Guire 2016-07-25  399  	unsigned long flags;
1b66e94e6b99953 Jonas Jensen      2014-04-09  400  	u32 status;
1b66e94e6b99953 Jonas Jensen      2014-04-09  401  
1b66e94e6b99953 Jonas Jensen      2014-04-09  402  	spin_lock_irqsave(&host->lock, flags);
1b66e94e6b99953 Jonas Jensen      2014-04-09  403  
1b66e94e6b99953 Jonas Jensen      2014-04-09  404  	init_completion(&host->dma_complete);
1b66e94e6b99953 Jonas Jensen      2014-04-09  405  	init_completion(&host->pio_complete);
1b66e94e6b99953 Jonas Jensen      2014-04-09  406  
1b66e94e6b99953 Jonas Jensen      2014-04-09  407  	host->mrq = mrq;
1b66e94e6b99953 Jonas Jensen      2014-04-09  408  
1b66e94e6b99953 Jonas Jensen      2014-04-09  409  	if (readl(host->base + REG_STATUS) & CARD_DETECT) {
1b66e94e6b99953 Jonas Jensen      2014-04-09  410  		mrq->cmd->error = -ETIMEDOUT;
1b66e94e6b99953 Jonas Jensen      2014-04-09  411  		goto request_done;
1b66e94e6b99953 Jonas Jensen      2014-04-09  412  	}
1b66e94e6b99953 Jonas Jensen      2014-04-09  413  
1b66e94e6b99953 Jonas Jensen      2014-04-09  414  	moxart_prepare_data(host);
1b66e94e6b99953 Jonas Jensen      2014-04-09  415  	moxart_send_command(host, host->mrq->cmd);
1b66e94e6b99953 Jonas Jensen      2014-04-09  416  
1b66e94e6b99953 Jonas Jensen      2014-04-09  417  	if (mrq->cmd->data) {
1b66e94e6b99953 Jonas Jensen      2014-04-09  418  		if ((host->data_len > host->fifo_width) && host->have_dma) {
1b66e94e6b99953 Jonas Jensen      2014-04-09  419  
1b66e94e6b99953 Jonas Jensen      2014-04-09  420  			writel(CARD_CHANGE, host->base + REG_INTERRUPT_MASK);
1b66e94e6b99953 Jonas Jensen      2014-04-09  421  
1b66e94e6b99953 Jonas Jensen      2014-04-09  422  			spin_unlock_irqrestore(&host->lock, flags);
1b66e94e6b99953 Jonas Jensen      2014-04-09  423  
1b66e94e6b99953 Jonas Jensen      2014-04-09  424  			moxart_transfer_dma(mrq->cmd->data, host);
1b66e94e6b99953 Jonas Jensen      2014-04-09  425  
1b66e94e6b99953 Jonas Jensen      2014-04-09  426  			spin_lock_irqsave(&host->lock, flags);
1b66e94e6b99953 Jonas Jensen      2014-04-09  427  		} else {
1b66e94e6b99953 Jonas Jensen      2014-04-09  428  
1b66e94e6b99953 Jonas Jensen      2014-04-09  429  			writel(MASK_INTR_PIO, host->base + REG_INTERRUPT_MASK);
1b66e94e6b99953 Jonas Jensen      2014-04-09  430  
1b66e94e6b99953 Jonas Jensen      2014-04-09  431  			spin_unlock_irqrestore(&host->lock, flags);
1b66e94e6b99953 Jonas Jensen      2014-04-09  432  
1b66e94e6b99953 Jonas Jensen      2014-04-09  433  			/* PIO transfers start from interrupt. */
1b66e94e6b99953 Jonas Jensen      2014-04-09  434  			pio_time = wait_for_completion_interruptible_timeout(
1b66e94e6b99953 Jonas Jensen      2014-04-09  435  				   &host->pio_complete, host->timeout);
1b66e94e6b99953 Jonas Jensen      2014-04-09  436  
1b66e94e6b99953 Jonas Jensen      2014-04-09  437  			spin_lock_irqsave(&host->lock, flags);
1b66e94e6b99953 Jonas Jensen      2014-04-09  438  		}
1b66e94e6b99953 Jonas Jensen      2014-04-09  439  
1b66e94e6b99953 Jonas Jensen      2014-04-09  440  		if (host->is_removed) {
1b66e94e6b99953 Jonas Jensen      2014-04-09  441  			dev_err(mmc_dev(host->mmc), "card removed\n");
1b66e94e6b99953 Jonas Jensen      2014-04-09  442  			mrq->cmd->error = -ETIMEDOUT;
1b66e94e6b99953 Jonas Jensen      2014-04-09  443  			goto request_done;
1b66e94e6b99953 Jonas Jensen      2014-04-09  444  		}
1b66e94e6b99953 Jonas Jensen      2014-04-09  445  
1b66e94e6b99953 Jonas Jensen      2014-04-09  446  		if (moxart_wait_for_status(host, MASK_DATA, &status)
1b66e94e6b99953 Jonas Jensen      2014-04-09  447  		    == -ETIMEDOUT) {
1b66e94e6b99953 Jonas Jensen      2014-04-09  448  			mrq->cmd->data->error = -ETIMEDOUT;
1b66e94e6b99953 Jonas Jensen      2014-04-09  449  			goto request_done;
1b66e94e6b99953 Jonas Jensen      2014-04-09  450  		}
1b66e94e6b99953 Jonas Jensen      2014-04-09  451  
1b66e94e6b99953 Jonas Jensen      2014-04-09  452  		if (status & DATA_CRC_FAIL)
1b66e94e6b99953 Jonas Jensen      2014-04-09  453  			mrq->cmd->data->error = -ETIMEDOUT;
1b66e94e6b99953 Jonas Jensen      2014-04-09  454  
1b66e94e6b99953 Jonas Jensen      2014-04-09  455  		if (mrq->cmd->data->stop)
1b66e94e6b99953 Jonas Jensen      2014-04-09  456  			moxart_send_command(host, mrq->cmd->data->stop);
1b66e94e6b99953 Jonas Jensen      2014-04-09  457  	}
1b66e94e6b99953 Jonas Jensen      2014-04-09  458  
1b66e94e6b99953 Jonas Jensen      2014-04-09  459  request_done:
1b66e94e6b99953 Jonas Jensen      2014-04-09  460  	spin_unlock_irqrestore(&host->lock, flags);
1b66e94e6b99953 Jonas Jensen      2014-04-09  461  	mmc_request_done(host->mmc, mrq);
1b66e94e6b99953 Jonas Jensen      2014-04-09  462  }
1b66e94e6b99953 Jonas Jensen      2014-04-09  463  

:::::: The code at line 260 was first introduced by commit
:::::: 41f469cac2663a41a7b0c84cb94e8f7024385ae4 mmc: moxart: fix wait_for_completion_interruptible_timeout return variable type

:::::: TO: Nicholas Mc Guire <hofrat@osadl.org>
:::::: CC: Ulf Hansson <ulf.hansson@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--UlVJffcvxoiEqYs2
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--UlVJffcvxoiEqYs2--
