Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4247D2F05B7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 07:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbhAJGdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 01:33:22 -0500
Received: from mga18.intel.com ([134.134.136.126]:54672 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbhAJGdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 01:33:22 -0500
IronPort-SDR: fVyR9DmBfcZNRVwilNHqfzn1vffF28D6Lf1KCLckf3N8hxFAAZ85q/FmLokeBq4RwEV/tFyweF
 t+ChYX1Z9Jbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9859"; a="165430749"
X-IronPort-AV: E=Sophos;i="5.79,335,1602572400"; 
   d="scan'208";a="165430749"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2021 22:32:40 -0800
IronPort-SDR: PE1hZlG6BNY+3gIUBoxV0vZNavCvMj7MZhmMNWGVE5Ll2FMok0Ef1yclobVp/5e3DZQjMs68s+
 zvS51AEHq7Hg==
X-IronPort-AV: E=Sophos;i="5.79,335,1602572400"; 
   d="scan'208";a="423411593"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.117])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2021 22:32:39 -0800
Date:   Sun, 10 Jan 2021 14:31:47 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>
Subject: drivers/net/ethernet/cadence/macb_main.c:4661:14: warning: Either
 the condition 'macb_config' is redundant or there is possible null pointer
 dereference: macb_config.
Message-ID: <20210110063147.GS399595@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   996e435fd401de35df62ac943ab9402cfe85c430
commit: edac63861db72a462ccdfad0b5dfa66985d58bd5 net: macb: add userio bits as platform configuration
compiler: nios2-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <rong.a.chen@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

   drivers/net/ethernet/cadence/macb_main.c:2908:5: warning: %d in format string (no. 1) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
       snprintf(stat_string, ETH_GSTRING_LEN, "q%d_%s",
       ^
>> drivers/net/ethernet/cadence/macb_main.c:4661:14: warning: Either the condition 'macb_config' is redundant or there is possible null pointer dereference: macb_config. [nullPointerRedundantCheck]
    bp->usrio = macb_config->usrio;
                ^
   drivers/net/ethernet/cadence/macb_main.c:4646:6: note: Assuming that condition 'macb_config' is not redundant
    if (macb_config)
        ^
   drivers/net/ethernet/cadence/macb_main.c:4661:14: note: Null pointer dereference
    bp->usrio = macb_config->usrio;
                ^

vim +/macb_config +4661 drivers/net/ethernet/cadence/macb_main.c

83a77e9ec4150ee drivers/net/ethernet/cadence/macb.c      Bartosz Folta                 2016-12-14  4573  
421d9df0628be16 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen               2015-03-07  4574  static int macb_probe(struct platform_device *pdev)
421d9df0628be16 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen               2015-03-07  4575  {
83a77e9ec4150ee drivers/net/ethernet/cadence/macb.c      Bartosz Folta                 2016-12-14  4576  	const struct macb_config *macb_config = &default_gem_config;
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4577  	int (*clk_init)(struct platform_device *, struct clk **,
f5473d1d44e4b42 drivers/net/ethernet/cadence/macb_main.c Harini Katakam                2019-03-01  4578  			struct clk **, struct clk **,  struct clk **,
f5473d1d44e4b42 drivers/net/ethernet/cadence/macb_main.c Harini Katakam                2019-03-01  4579  			struct clk **) = macb_config->clk_init;
83a77e9ec4150ee drivers/net/ethernet/cadence/macb.c      Bartosz Folta                 2016-12-14  4580  	int (*init)(struct platform_device *) = macb_config->init;
421d9df0628be16 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen               2015-03-07  4581  	struct device_node *np = pdev->dev.of_node;
aead88bd0e99054 drivers/net/ethernet/cadence/macb.c      shubhrajyoti.datta@xilinx.com 2016-08-16  4582  	struct clk *pclk, *hclk = NULL, *tx_clk = NULL, *rx_clk = NULL;
f5473d1d44e4b42 drivers/net/ethernet/cadence/macb_main.c Harini Katakam                2019-03-01  4583  	struct clk *tsu_clk = NULL;
421d9df0628be16 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen               2015-03-07  4584  	unsigned int queue_mask, num_queues;
f2ce8a9e48385f4 drivers/net/ethernet/cadence/macb.c      Andy Shevchenko               2015-07-24  4585  	bool native_io;
0c65b2b90d13c1d drivers/net/ethernet/cadence/macb_main.c Andrew Lunn                   2019-11-04  4586  	phy_interface_t interface;
421d9df0628be16 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen               2015-03-07  4587  	struct net_device *dev;
421d9df0628be16 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen               2015-03-07  4588  	struct resource *regs;
421d9df0628be16 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen               2015-03-07  4589  	void __iomem *mem;
421d9df0628be16 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen               2015-03-07  4590  	const char *mac;
421d9df0628be16 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen               2015-03-07  4591  	struct macb *bp;
404cd086f29e867 drivers/net/ethernet/cadence/macb_main.c Harini Katakam                2018-07-06  4592  	int err, val;
421d9df0628be16 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen               2015-03-07  4593  
f2ce8a9e48385f4 drivers/net/ethernet/cadence/macb.c      Andy Shevchenko               2015-07-24  4594  	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
f2ce8a9e48385f4 drivers/net/ethernet/cadence/macb.c      Andy Shevchenko               2015-07-24  4595  	mem = devm_ioremap_resource(&pdev->dev, regs);
f2ce8a9e48385f4 drivers/net/ethernet/cadence/macb.c      Andy Shevchenko               2015-07-24  4596  	if (IS_ERR(mem))
f2ce8a9e48385f4 drivers/net/ethernet/cadence/macb.c      Andy Shevchenko               2015-07-24  4597  		return PTR_ERR(mem);
f2ce8a9e48385f4 drivers/net/ethernet/cadence/macb.c      Andy Shevchenko               2015-07-24  4598  
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4599  	if (np) {
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4600  		const struct of_device_id *match;
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4601  
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4602  		match = of_match_node(macb_dt_ids, np);
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4603  		if (match && match->data) {
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4604  			macb_config = match->data;
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4605  			clk_init = macb_config->clk_init;
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4606  			init = macb_config->init;
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4607  		}
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4608  	}
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4609  
f5473d1d44e4b42 drivers/net/ethernet/cadence/macb_main.c Harini Katakam                2019-03-01  4610  	err = clk_init(pdev, &pclk, &hclk, &tx_clk, &rx_clk, &tsu_clk);
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4611  	if (err)
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4612  		return err;
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4613  
d54f89af6cc4d6d drivers/net/ethernet/cadence/macb_main.c Harini Katakam                2019-03-01  4614  	pm_runtime_set_autosuspend_delay(&pdev->dev, MACB_PM_TIMEOUT);
d54f89af6cc4d6d drivers/net/ethernet/cadence/macb_main.c Harini Katakam                2019-03-01  4615  	pm_runtime_use_autosuspend(&pdev->dev);
d54f89af6cc4d6d drivers/net/ethernet/cadence/macb_main.c Harini Katakam                2019-03-01  4616  	pm_runtime_get_noresume(&pdev->dev);
d54f89af6cc4d6d drivers/net/ethernet/cadence/macb_main.c Harini Katakam                2019-03-01  4617  	pm_runtime_set_active(&pdev->dev);
d54f89af6cc4d6d drivers/net/ethernet/cadence/macb_main.c Harini Katakam                2019-03-01  4618  	pm_runtime_enable(&pdev->dev);
f2ce8a9e48385f4 drivers/net/ethernet/cadence/macb.c      Andy Shevchenko               2015-07-24  4619  	native_io = hw_is_native_io(mem);
421d9df0628be16 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen               2015-03-07  4620  
f2ce8a9e48385f4 drivers/net/ethernet/cadence/macb.c      Andy Shevchenko               2015-07-24  4621  	macb_probe_queues(mem, native_io, &queue_mask, &num_queues);
421d9df0628be16 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen               2015-03-07  4622  	dev = alloc_etherdev_mq(sizeof(*bp), num_queues);
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4623  	if (!dev) {
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4624  		err = -ENOMEM;
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4625  		goto err_disable_clocks;
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4626  	}
421d9df0628be16 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen               2015-03-07  4627  
421d9df0628be16 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen               2015-03-07  4628  	dev->base_addr = regs->start;
421d9df0628be16 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen               2015-03-07  4629  
421d9df0628be16 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen               2015-03-07  4630  	SET_NETDEV_DEV(dev, &pdev->dev);
421d9df0628be16 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen               2015-03-07  4631  
421d9df0628be16 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen               2015-03-07  4632  	bp = netdev_priv(dev);
421d9df0628be16 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen               2015-03-07  4633  	bp->pdev = pdev;
421d9df0628be16 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen               2015-03-07  4634  	bp->dev = dev;
421d9df0628be16 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen               2015-03-07  4635  	bp->regs = mem;
f2ce8a9e48385f4 drivers/net/ethernet/cadence/macb.c      Andy Shevchenko               2015-07-24  4636  	bp->native_io = native_io;
f2ce8a9e48385f4 drivers/net/ethernet/cadence/macb.c      Andy Shevchenko               2015-07-24  4637  	if (native_io) {
7a6e0706c09b121 drivers/net/ethernet/cadence/macb.c      David S. Miller               2015-07-27  4638  		bp->macb_reg_readl = hw_readl_native;
7a6e0706c09b121 drivers/net/ethernet/cadence/macb.c      David S. Miller               2015-07-27  4639  		bp->macb_reg_writel = hw_writel_native;
f2ce8a9e48385f4 drivers/net/ethernet/cadence/macb.c      Andy Shevchenko               2015-07-24  4640  	} else {
7a6e0706c09b121 drivers/net/ethernet/cadence/macb.c      David S. Miller               2015-07-27  4641  		bp->macb_reg_readl = hw_readl;
7a6e0706c09b121 drivers/net/ethernet/cadence/macb.c      David S. Miller               2015-07-27  4642  		bp->macb_reg_writel = hw_writel;
f2ce8a9e48385f4 drivers/net/ethernet/cadence/macb.c      Andy Shevchenko               2015-07-24  4643  	}
421d9df0628be16 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen               2015-03-07  4644  	bp->num_queues = num_queues;
bfa0914afa95d44 drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4645  	bp->queue_mask = queue_mask;
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4646  	if (macb_config)
f6970505defd0e7 drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4647  		bp->dma_burst_length = macb_config->dma_burst_length;
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4648  	bp->pclk = pclk;
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4649  	bp->hclk = hclk;
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4650  	bp->tx_clk = tx_clk;
aead88bd0e99054 drivers/net/ethernet/cadence/macb.c      shubhrajyoti.datta@xilinx.com 2016-08-16  4651  	bp->rx_clk = rx_clk;
f5473d1d44e4b42 drivers/net/ethernet/cadence/macb_main.c Harini Katakam                2019-03-01  4652  	bp->tsu_clk = tsu_clk;
f36dbe6a285e062 drivers/net/ethernet/cadence/macb.c      Andy Shevchenko               2015-07-24  4653  	if (macb_config)
98b5a0f4a2282fb drivers/net/ethernet/cadence/macb.c      Harini Katakam                2015-05-06  4654  		bp->jumbo_max_len = macb_config->jumbo_max_len;
98b5a0f4a2282fb drivers/net/ethernet/cadence/macb.c      Harini Katakam                2015-05-06  4655  
3e2a5e153906432 drivers/net/ethernet/cadence/macb.c      Sergio Prado                  2016-02-09  4656  	bp->wol = 0;
7c4a1d0cfdc169b drivers/net/ethernet/cadence/macb.c      Sergio Prado                  2016-02-16  4657  	if (of_get_property(np, "magic-packet", NULL))
3e2a5e153906432 drivers/net/ethernet/cadence/macb.c      Sergio Prado                  2016-02-09  4658  		bp->wol |= MACB_WOL_HAS_MAGIC_PACKET;
ced4799d0637592 drivers/net/ethernet/cadence/macb_main.c Nicolas Ferre                 2020-07-10  4659  	device_set_wakeup_capable(&pdev->dev, bp->wol & MACB_WOL_HAS_MAGIC_PACKET);
3e2a5e153906432 drivers/net/ethernet/cadence/macb.c      Sergio Prado                  2016-02-09  4660  
edac63861db72a4 drivers/net/ethernet/cadence/macb_main.c Claudiu Beznea                2020-12-09 @4661  	bp->usrio = macb_config->usrio;
edac63861db72a4 drivers/net/ethernet/cadence/macb_main.c Claudiu Beznea                2020-12-09  4662  
c69618b3e4f220f drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4663  	spin_lock_init(&bp->lock);
f6970505defd0e7 drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4664  
ad78347f06581e4 drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4665  	/* setup capabilities */
f6970505defd0e7 drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4666  	macb_configure_caps(bp, macb_config);
f6970505defd0e7 drivers/net/ethernet/cadence/macb.c      Nicolas Ferre                 2015-03-31  4667  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

