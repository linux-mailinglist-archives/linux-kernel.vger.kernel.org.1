Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBA92AB118
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 07:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgKIGJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 01:09:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:58452 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgKIGJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 01:09:10 -0500
IronPort-SDR: NOGoEccNEa5yd9sX0NQ9U8oWr35IOfQ9oJpQJHJuqpbbAIqyD79fU779lL0payxGLuOvogJUVx
 kj+EbI2yPpMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="231387050"
X-IronPort-AV: E=Sophos;i="5.77,462,1596524400"; 
   d="gz'50?scan'50,208,50";a="231387050"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2020 22:09:05 -0800
IronPort-SDR: 1zQpUydx+j9t3onXeahIgU5JYft9z+SjByAFihKM+g1RCJWN5DvXiIFJgl1zRKlZdG1kZBRA11
 e/MNgAnHqgBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,462,1596524400"; 
   d="gz'50?scan'50,208,50";a="472844942"
Received: from lkp-server02.sh.intel.com (HELO defa7f6e4f65) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Nov 2020 22:09:02 -0800
Received: from kbuild by defa7f6e4f65 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kc0MP-0000Ft-99; Mon, 09 Nov 2020 06:09:01 +0000
Date:   Mon, 9 Nov 2020 14:08:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/bridge/sil-sii8620.c:2355: undefined reference to
 `extcon_unregister_notifier'
Message-ID: <202011091430.z0RBkf3u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f8394f232b1eab649ce2df5c5f15b0e528c92091
commit: def2fbffe62c00c330c7f41584a356001179c59c kconfig: allow symbols implied by y to become m
date:   8 months ago
config: i386-randconfig-r022-20201106 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=def2fbffe62c00c330c7f41584a356001179c59c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout def2fbffe62c00c330c7f41584a356001179c59c
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/gpu/drm/bridge/sil-sii8620.o: in function `sii8620_remove':
>> drivers/gpu/drm/bridge/sil-sii8620.c:2355: undefined reference to `extcon_unregister_notifier'
   ld: drivers/gpu/drm/bridge/sil-sii8620.o: in function `sii8620_extcon_init':
>> drivers/gpu/drm/bridge/sil-sii8620.c:2179: undefined reference to `extcon_find_edev_by_node'
   ld: drivers/gpu/drm/bridge/sil-sii8620.c:2191: undefined reference to `extcon_register_notifier'
   ld: drivers/gpu/drm/bridge/sil-sii8620.o: in function `sii8620_extcon_work':
>> drivers/gpu/drm/bridge/sil-sii8620.c:2139: undefined reference to `extcon_get_state'

vim +2355 drivers/gpu/drm/bridge/sil-sii8620.c

688838442147d9d Maciej Purski    2018-02-27  2162  
688838442147d9d Maciej Purski    2018-02-27  2163  static int sii8620_extcon_init(struct sii8620 *ctx)
688838442147d9d Maciej Purski    2018-02-27  2164  {
688838442147d9d Maciej Purski    2018-02-27  2165  	struct extcon_dev *edev;
688838442147d9d Maciej Purski    2018-02-27  2166  	struct device_node *musb, *muic;
688838442147d9d Maciej Purski    2018-02-27  2167  	int ret;
688838442147d9d Maciej Purski    2018-02-27  2168  
688838442147d9d Maciej Purski    2018-02-27  2169  	/* get micro-USB connector node */
688838442147d9d Maciej Purski    2018-02-27  2170  	musb = of_graph_get_remote_node(ctx->dev->of_node, 1, -1);
688838442147d9d Maciej Purski    2018-02-27  2171  	/* next get micro-USB Interface Controller node */
688838442147d9d Maciej Purski    2018-02-27  2172  	muic = of_get_next_parent(musb);
688838442147d9d Maciej Purski    2018-02-27  2173  
688838442147d9d Maciej Purski    2018-02-27  2174  	if (!muic) {
688838442147d9d Maciej Purski    2018-02-27  2175  		dev_info(ctx->dev, "no extcon found, switching to 'always on' mode\n");
688838442147d9d Maciej Purski    2018-02-27  2176  		return 0;
688838442147d9d Maciej Purski    2018-02-27  2177  	}
688838442147d9d Maciej Purski    2018-02-27  2178  
688838442147d9d Maciej Purski    2018-02-27 @2179  	edev = extcon_find_edev_by_node(muic);
688838442147d9d Maciej Purski    2018-02-27  2180  	of_node_put(muic);
688838442147d9d Maciej Purski    2018-02-27  2181  	if (IS_ERR(edev)) {
688838442147d9d Maciej Purski    2018-02-27  2182  		if (PTR_ERR(edev) == -EPROBE_DEFER)
688838442147d9d Maciej Purski    2018-02-27  2183  			return -EPROBE_DEFER;
688838442147d9d Maciej Purski    2018-02-27  2184  		dev_err(ctx->dev, "Invalid or missing extcon\n");
688838442147d9d Maciej Purski    2018-02-27  2185  		return PTR_ERR(edev);
688838442147d9d Maciej Purski    2018-02-27  2186  	}
688838442147d9d Maciej Purski    2018-02-27  2187  
688838442147d9d Maciej Purski    2018-02-27  2188  	ctx->extcon = edev;
688838442147d9d Maciej Purski    2018-02-27  2189  	ctx->extcon_nb.notifier_call = sii8620_extcon_notifier;
688838442147d9d Maciej Purski    2018-02-27  2190  	INIT_WORK(&ctx->extcon_wq, sii8620_extcon_work);
688838442147d9d Maciej Purski    2018-02-27  2191  	ret = extcon_register_notifier(edev, EXTCON_DISP_MHL, &ctx->extcon_nb);
688838442147d9d Maciej Purski    2018-02-27  2192  	if (ret) {
688838442147d9d Maciej Purski    2018-02-27  2193  		dev_err(ctx->dev, "failed to register notifier for MHL\n");
688838442147d9d Maciej Purski    2018-02-27  2194  		return ret;
688838442147d9d Maciej Purski    2018-02-27  2195  	}
688838442147d9d Maciej Purski    2018-02-27  2196  
688838442147d9d Maciej Purski    2018-02-27  2197  	return 0;
688838442147d9d Maciej Purski    2018-02-27  2198  }
688838442147d9d Maciej Purski    2018-02-27  2199  
ce6e153f414a73a Andrzej Hajda    2016-10-10  2200  static inline struct sii8620 *bridge_to_sii8620(struct drm_bridge *bridge)
ce6e153f414a73a Andrzej Hajda    2016-10-10  2201  {
ce6e153f414a73a Andrzej Hajda    2016-10-10  2202  	return container_of(bridge, struct sii8620, bridge);
ce6e153f414a73a Andrzej Hajda    2016-10-10  2203  }
ce6e153f414a73a Andrzej Hajda    2016-10-10  2204  
e25f1f7c94e16d4 Maciej Purski    2017-08-24  2205  static int sii8620_attach(struct drm_bridge *bridge)
e25f1f7c94e16d4 Maciej Purski    2017-08-24  2206  {
e25f1f7c94e16d4 Maciej Purski    2017-08-24  2207  	struct sii8620 *ctx = bridge_to_sii8620(bridge);
e25f1f7c94e16d4 Maciej Purski    2017-08-24  2208  
e25f1f7c94e16d4 Maciej Purski    2017-08-24  2209  	sii8620_init_rcp_input_dev(ctx);
e25f1f7c94e16d4 Maciej Purski    2017-08-24  2210  
e25f1f7c94e16d4 Maciej Purski    2017-08-24  2211  	return sii8620_clear_error(ctx);
e25f1f7c94e16d4 Maciej Purski    2017-08-24  2212  }
e25f1f7c94e16d4 Maciej Purski    2017-08-24  2213  
e25f1f7c94e16d4 Maciej Purski    2017-08-24  2214  static void sii8620_detach(struct drm_bridge *bridge)
e25f1f7c94e16d4 Maciej Purski    2017-08-24  2215  {
e25f1f7c94e16d4 Maciej Purski    2017-08-24  2216  	struct sii8620 *ctx = bridge_to_sii8620(bridge);
e25f1f7c94e16d4 Maciej Purski    2017-08-24  2217  
710abfe8ead2477 Ronald Tschalär  2019-04-19  2218  	if (!IS_ENABLED(CONFIG_RC_CORE))
710abfe8ead2477 Ronald Tschalär  2019-04-19  2219  		return;
710abfe8ead2477 Ronald Tschalär  2019-04-19  2220  
e25f1f7c94e16d4 Maciej Purski    2017-08-24  2221  	rc_unregister_device(ctx->rc_dev);
e25f1f7c94e16d4 Maciej Purski    2017-08-24  2222  }
e25f1f7c94e16d4 Maciej Purski    2017-08-24  2223  
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2224  static int sii8620_is_packing_required(struct sii8620 *ctx,
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2225  				       const struct drm_display_mode *mode)
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2226  {
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2227  	int max_pclk, max_pclk_pp_mode;
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2228  
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2229  	if (sii8620_is_mhl3(ctx)) {
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2230  		max_pclk = MHL3_MAX_PCLK;
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2231  		max_pclk_pp_mode = MHL3_MAX_PCLK_PP_MODE;
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2232  	} else {
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2233  		max_pclk = MHL1_MAX_PCLK;
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2234  		max_pclk_pp_mode = MHL1_MAX_PCLK_PP_MODE;
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2235  	}
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2236  
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2237  	if (mode->clock < max_pclk)
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2238  		return 0;
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2239  	else if (mode->clock < max_pclk_pp_mode)
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2240  		return 1;
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2241  	else
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2242  		return -1;
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2243  }
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2244  
e7c2e4d368e2efc Marek Szyprowski 2017-11-09  2245  static enum drm_mode_status sii8620_mode_valid(struct drm_bridge *bridge,
e7c2e4d368e2efc Marek Szyprowski 2017-11-09  2246  					 const struct drm_display_mode *mode)
e7c2e4d368e2efc Marek Szyprowski 2017-11-09  2247  {
e7c2e4d368e2efc Marek Szyprowski 2017-11-09  2248  	struct sii8620 *ctx = bridge_to_sii8620(bridge);
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2249  	int pack_required = sii8620_is_packing_required(ctx, mode);
e7c2e4d368e2efc Marek Szyprowski 2017-11-09  2250  	bool can_pack = ctx->devcap[MHL_DCAP_VID_LINK_MODE] &
e7c2e4d368e2efc Marek Szyprowski 2017-11-09  2251  			MHL_DCAP_VID_LINK_PPIXEL;
e7c2e4d368e2efc Marek Szyprowski 2017-11-09  2252  
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2253  	switch (pack_required) {
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2254  	case 0:
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2255  		return MODE_OK;
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2256  	case 1:
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2257  		return (can_pack) ? MODE_OK : MODE_CLOCK_HIGH;
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2258  	default:
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2259  		return MODE_CLOCK_HIGH;
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2260  	}
e7c2e4d368e2efc Marek Szyprowski 2017-11-09  2261  }
e7c2e4d368e2efc Marek Szyprowski 2017-11-09  2262  
ce6e153f414a73a Andrzej Hajda    2016-10-10  2263  static bool sii8620_mode_fixup(struct drm_bridge *bridge,
ce6e153f414a73a Andrzej Hajda    2016-10-10  2264  			       const struct drm_display_mode *mode,
ce6e153f414a73a Andrzej Hajda    2016-10-10  2265  			       struct drm_display_mode *adjusted_mode)
ce6e153f414a73a Andrzej Hajda    2016-10-10  2266  {
ce6e153f414a73a Andrzej Hajda    2016-10-10  2267  	struct sii8620 *ctx = bridge_to_sii8620(bridge);
ce6e153f414a73a Andrzej Hajda    2016-10-10  2268  
bf1722cab55a32a Andrzej Hajda    2017-02-01  2269  	mutex_lock(&ctx->lock);
ce6e153f414a73a Andrzej Hajda    2016-10-10  2270  
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2271  	ctx->use_packed_pixel = sii8620_is_packing_required(ctx, adjusted_mode);
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2272  
ce6e153f414a73a Andrzej Hajda    2016-10-10  2273  	mutex_unlock(&ctx->lock);
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2274  
ecba7cfa3afbe48 Maciej Purski    2018-02-02  2275  	return true;
ce6e153f414a73a Andrzej Hajda    2016-10-10  2276  }
ce6e153f414a73a Andrzej Hajda    2016-10-10  2277  
ce6e153f414a73a Andrzej Hajda    2016-10-10  2278  static const struct drm_bridge_funcs sii8620_bridge_funcs = {
e25f1f7c94e16d4 Maciej Purski    2017-08-24  2279  	.attach = sii8620_attach,
e25f1f7c94e16d4 Maciej Purski    2017-08-24  2280  	.detach = sii8620_detach,
ce6e153f414a73a Andrzej Hajda    2016-10-10  2281  	.mode_fixup = sii8620_mode_fixup,
e7c2e4d368e2efc Marek Szyprowski 2017-11-09  2282  	.mode_valid = sii8620_mode_valid,
ce6e153f414a73a Andrzej Hajda    2016-10-10  2283  };
ce6e153f414a73a Andrzej Hajda    2016-10-10  2284  
ce6e153f414a73a Andrzej Hajda    2016-10-10  2285  static int sii8620_probe(struct i2c_client *client,
ce6e153f414a73a Andrzej Hajda    2016-10-10  2286  			 const struct i2c_device_id *id)
ce6e153f414a73a Andrzej Hajda    2016-10-10  2287  {
ce6e153f414a73a Andrzej Hajda    2016-10-10  2288  	struct device *dev = &client->dev;
ce6e153f414a73a Andrzej Hajda    2016-10-10  2289  	struct sii8620 *ctx;
ce6e153f414a73a Andrzej Hajda    2016-10-10  2290  	int ret;
ce6e153f414a73a Andrzej Hajda    2016-10-10  2291  
ce6e153f414a73a Andrzej Hajda    2016-10-10  2292  	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
ce6e153f414a73a Andrzej Hajda    2016-10-10  2293  	if (!ctx)
ce6e153f414a73a Andrzej Hajda    2016-10-10  2294  		return -ENOMEM;
ce6e153f414a73a Andrzej Hajda    2016-10-10  2295  
ce6e153f414a73a Andrzej Hajda    2016-10-10  2296  	ctx->dev = dev;
ce6e153f414a73a Andrzej Hajda    2016-10-10  2297  	mutex_init(&ctx->lock);
ce6e153f414a73a Andrzej Hajda    2016-10-10  2298  	INIT_LIST_HEAD(&ctx->mt_queue);
ce6e153f414a73a Andrzej Hajda    2016-10-10  2299  
ce6e153f414a73a Andrzej Hajda    2016-10-10  2300  	ctx->clk_xtal = devm_clk_get(dev, "xtal");
ce6e153f414a73a Andrzej Hajda    2016-10-10  2301  	if (IS_ERR(ctx->clk_xtal)) {
ce6e153f414a73a Andrzej Hajda    2016-10-10  2302  		dev_err(dev, "failed to get xtal clock from DT\n");
ce6e153f414a73a Andrzej Hajda    2016-10-10  2303  		return PTR_ERR(ctx->clk_xtal);
ce6e153f414a73a Andrzej Hajda    2016-10-10  2304  	}
ce6e153f414a73a Andrzej Hajda    2016-10-10  2305  
ce6e153f414a73a Andrzej Hajda    2016-10-10  2306  	if (!client->irq) {
ce6e153f414a73a Andrzej Hajda    2016-10-10  2307  		dev_err(dev, "no irq provided\n");
ce6e153f414a73a Andrzej Hajda    2016-10-10  2308  		return -EINVAL;
ce6e153f414a73a Andrzej Hajda    2016-10-10  2309  	}
ce6e153f414a73a Andrzej Hajda    2016-10-10  2310  	irq_set_status_flags(client->irq, IRQ_NOAUTOEN);
ce6e153f414a73a Andrzej Hajda    2016-10-10  2311  	ret = devm_request_threaded_irq(dev, client->irq, NULL,
ce6e153f414a73a Andrzej Hajda    2016-10-10  2312  					sii8620_irq_thread,
ce6e153f414a73a Andrzej Hajda    2016-10-10  2313  					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
ce6e153f414a73a Andrzej Hajda    2016-10-10  2314  					"sii8620", ctx);
e0ba12ea5e1329b Andrzej Hajda    2017-02-22  2315  	if (ret < 0) {
e0ba12ea5e1329b Andrzej Hajda    2017-02-22  2316  		dev_err(dev, "failed to install IRQ handler\n");
e0ba12ea5e1329b Andrzej Hajda    2017-02-22  2317  		return ret;
e0ba12ea5e1329b Andrzej Hajda    2017-02-22  2318  	}
ce6e153f414a73a Andrzej Hajda    2016-10-10  2319  
ce6e153f414a73a Andrzej Hajda    2016-10-10  2320  	ctx->gpio_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
ce6e153f414a73a Andrzej Hajda    2016-10-10  2321  	if (IS_ERR(ctx->gpio_reset)) {
ce6e153f414a73a Andrzej Hajda    2016-10-10  2322  		dev_err(dev, "failed to get reset gpio from DT\n");
ce6e153f414a73a Andrzej Hajda    2016-10-10  2323  		return PTR_ERR(ctx->gpio_reset);
ce6e153f414a73a Andrzej Hajda    2016-10-10  2324  	}
ce6e153f414a73a Andrzej Hajda    2016-10-10  2325  
ce6e153f414a73a Andrzej Hajda    2016-10-10  2326  	ctx->supplies[0].supply = "cvcc10";
ce6e153f414a73a Andrzej Hajda    2016-10-10  2327  	ctx->supplies[1].supply = "iovcc18";
ce6e153f414a73a Andrzej Hajda    2016-10-10  2328  	ret = devm_regulator_bulk_get(dev, 2, ctx->supplies);
ce6e153f414a73a Andrzej Hajda    2016-10-10  2329  	if (ret)
ce6e153f414a73a Andrzej Hajda    2016-10-10  2330  		return ret;
ce6e153f414a73a Andrzej Hajda    2016-10-10  2331  
688838442147d9d Maciej Purski    2018-02-27  2332  	ret = sii8620_extcon_init(ctx);
688838442147d9d Maciej Purski    2018-02-27  2333  	if (ret < 0) {
688838442147d9d Maciej Purski    2018-02-27  2334  		dev_err(ctx->dev, "failed to initialize EXTCON\n");
688838442147d9d Maciej Purski    2018-02-27  2335  		return ret;
688838442147d9d Maciej Purski    2018-02-27  2336  	}
688838442147d9d Maciej Purski    2018-02-27  2337  
ce6e153f414a73a Andrzej Hajda    2016-10-10  2338  	i2c_set_clientdata(client, ctx);
ce6e153f414a73a Andrzej Hajda    2016-10-10  2339  
ce6e153f414a73a Andrzej Hajda    2016-10-10  2340  	ctx->bridge.funcs = &sii8620_bridge_funcs;
ce6e153f414a73a Andrzej Hajda    2016-10-10  2341  	ctx->bridge.of_node = dev->of_node;
ce6e153f414a73a Andrzej Hajda    2016-10-10  2342  	drm_bridge_add(&ctx->bridge);
ce6e153f414a73a Andrzej Hajda    2016-10-10  2343  
688838442147d9d Maciej Purski    2018-02-27  2344  	if (!ctx->extcon)
ce6e153f414a73a Andrzej Hajda    2016-10-10  2345  		sii8620_cable_in(ctx);
ce6e153f414a73a Andrzej Hajda    2016-10-10  2346  
ce6e153f414a73a Andrzej Hajda    2016-10-10  2347  	return 0;
ce6e153f414a73a Andrzej Hajda    2016-10-10  2348  }
ce6e153f414a73a Andrzej Hajda    2016-10-10  2349  
ce6e153f414a73a Andrzej Hajda    2016-10-10  2350  static int sii8620_remove(struct i2c_client *client)
ce6e153f414a73a Andrzej Hajda    2016-10-10  2351  {
ce6e153f414a73a Andrzej Hajda    2016-10-10  2352  	struct sii8620 *ctx = i2c_get_clientdata(client);
ce6e153f414a73a Andrzej Hajda    2016-10-10  2353  
688838442147d9d Maciej Purski    2018-02-27  2354  	if (ctx->extcon) {
688838442147d9d Maciej Purski    2018-02-27 @2355  		extcon_unregister_notifier(ctx->extcon, EXTCON_DISP_MHL,
688838442147d9d Maciej Purski    2018-02-27  2356  					   &ctx->extcon_nb);
688838442147d9d Maciej Purski    2018-02-27  2357  		flush_work(&ctx->extcon_wq);
688838442147d9d Maciej Purski    2018-02-27  2358  		if (ctx->cable_state > 0)
688838442147d9d Maciej Purski    2018-02-27  2359  			sii8620_cable_out(ctx);
688838442147d9d Maciej Purski    2018-02-27  2360  	} else {
688838442147d9d Maciej Purski    2018-02-27  2361  		sii8620_cable_out(ctx);
688838442147d9d Maciej Purski    2018-02-27  2362  	}
e25f1f7c94e16d4 Maciej Purski    2017-08-24  2363  	drm_bridge_remove(&ctx->bridge);
ce6e153f414a73a Andrzej Hajda    2016-10-10  2364  
ce6e153f414a73a Andrzej Hajda    2016-10-10  2365  	return 0;
ce6e153f414a73a Andrzej Hajda    2016-10-10  2366  }
ce6e153f414a73a Andrzej Hajda    2016-10-10  2367  

:::::: The code at line 2355 was first introduced by commit
:::::: 688838442147d9dd94c2ef7c2c31a35cf150c5fa drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL

:::::: TO: Maciej Purski <m.purski@samsung.com>
:::::: CC: Chanwoo Choi <cw00.choi@samsung.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--BOKacYhQ+x31HxR3
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
3Ag9A8mPAAwgaKI+OJFezJOyWP8fasYwc6sZAgA=

--BOKacYhQ+x31HxR3--
