Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABE12C1AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 02:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgKXBUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 20:20:06 -0500
Received: from mga07.intel.com ([134.134.136.100]:27812 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgKXBUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 20:20:05 -0500
IronPort-SDR: MRN9avk1pBLC5IJta1dPD3pHUNYewWN9NXndmiU+ISCZUcnp6Zhj99BE/2d9sCeuPFEWiKJlN9
 Z5vvT+U6ixVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="236011571"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="236011571"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 17:20:04 -0800
IronPort-SDR: +glYmkMn2JMMErRs9vbTSKZRn2SbA/rF8R7s1+JR/3uVIXWTKzgX7zss4tDw6xADgB/mJSOVOC
 aay6H//04jww==
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="546630072"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.117])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 17:20:03 -0800
Date:   Tue, 24 Nov 2020 09:19:14 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>
Subject: drivers/leds/leds-lp55xx-common.c:204:4: warning: Variable 'j' is
 modified but its new value is never used.
Message-ID: <20201124011914.GY3723@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   418baf2c28f3473039f2f7377760bd8f6897ae18
commit: 92a81562e695628086acb92f95090ab09d9b9ec0 leds: lp55xx: Add multicolor framework support to lp55xx
compiler: c6x-elf-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <rong.a.chen@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/leds/leds-lp55xx-common.c:204:4: warning: Variable 'j' is modified but its new value is never used. [unreadVariable]
      j++;
      ^

vim +/j +204 drivers/leds/leds-lp55xx-common.c

0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  158) 
9e9b3db1b2f725b Milo(Woogyom  Kim 2013-02-05  159) static int lp55xx_init_led(struct lp55xx_led *led,
9e9b3db1b2f725b Milo(Woogyom  Kim 2013-02-05  160) 			struct lp55xx_chip *chip, int chan)
9e9b3db1b2f725b Milo(Woogyom  Kim 2013-02-05  161) {
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  162) 	struct lp55xx_platform_data *pdata = chip->pdata;
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  163) 	struct lp55xx_device_config *cfg = chip->cfg;
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  164) 	struct device *dev = &chip->cl->dev;
92a81562e695628 Dan Murphy        2020-07-16  165  	int max_channel = cfg->max_channel;
92a81562e695628 Dan Murphy        2020-07-16  166  	struct mc_subled *mc_led_info;
92a81562e695628 Dan Murphy        2020-07-16  167  	struct led_classdev *led_cdev;
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  168) 	char name[32];
92a81562e695628 Dan Murphy        2020-07-16  169  	int i, j = 0;
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  170) 	int ret;
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  171) 
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  172) 	if (chan >= max_channel) {
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  173) 		dev_err(dev, "invalid channel: %d / %d\n", chan, max_channel);
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  174) 		return -EINVAL;
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  175) 	}
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  176) 
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  177) 	if (pdata->led_config[chan].led_current == 0)
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  178) 		return 0;
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  179) 
92a81562e695628 Dan Murphy        2020-07-16  180  	if (pdata->led_config[chan].name) {
92a81562e695628 Dan Murphy        2020-07-16  181  		led->cdev.name = pdata->led_config[chan].name;
92a81562e695628 Dan Murphy        2020-07-16  182  	} else {
92a81562e695628 Dan Murphy        2020-07-16  183  		snprintf(name, sizeof(name), "%s:channel%d",
92a81562e695628 Dan Murphy        2020-07-16  184  			pdata->label ? : chip->cl->name, chan);
92a81562e695628 Dan Murphy        2020-07-16  185  		led->cdev.name = name;
92a81562e695628 Dan Murphy        2020-07-16  186  	}
92a81562e695628 Dan Murphy        2020-07-16  187  
92a81562e695628 Dan Murphy        2020-07-16  188  	if (pdata->led_config[chan].num_colors > 1) {
92a81562e695628 Dan Murphy        2020-07-16  189  		mc_led_info = devm_kcalloc(dev,
92a81562e695628 Dan Murphy        2020-07-16  190  					   pdata->led_config[chan].num_colors,
92a81562e695628 Dan Murphy        2020-07-16  191  					   sizeof(*mc_led_info), GFP_KERNEL);
92a81562e695628 Dan Murphy        2020-07-16  192  		if (!mc_led_info)
92a81562e695628 Dan Murphy        2020-07-16  193  			return -ENOMEM;
92a81562e695628 Dan Murphy        2020-07-16  194  
92a81562e695628 Dan Murphy        2020-07-16  195  		led_cdev = &led->mc_cdev.led_cdev;
92a81562e695628 Dan Murphy        2020-07-16  196  		led_cdev->name = led->cdev.name;
92a81562e695628 Dan Murphy        2020-07-16  197  		led_cdev->brightness_set_blocking = lp55xx_set_mc_brightness;
92a81562e695628 Dan Murphy        2020-07-16  198  		led->mc_cdev.num_colors = pdata->led_config[chan].num_colors;
92a81562e695628 Dan Murphy        2020-07-16  199  		for (i = 0; i < led->mc_cdev.num_colors; i++) {
92a81562e695628 Dan Murphy        2020-07-16  200  			mc_led_info[i].color_index =
92a81562e695628 Dan Murphy        2020-07-16  201  				pdata->led_config[chan].color_id[i];
92a81562e695628 Dan Murphy        2020-07-16  202  			mc_led_info[i].channel =
92a81562e695628 Dan Murphy        2020-07-16  203  					pdata->led_config[chan].output_num[i];
92a81562e695628 Dan Murphy        2020-07-16 @204  			j++;
92a81562e695628 Dan Murphy        2020-07-16  205  		}
92a81562e695628 Dan Murphy        2020-07-16  206  
92a81562e695628 Dan Murphy        2020-07-16  207  		led->mc_cdev.subled_info = mc_led_info;
92a81562e695628 Dan Murphy        2020-07-16  208  	} else {
92a81562e695628 Dan Murphy        2020-07-16  209  		led->cdev.brightness_set_blocking = lp55xx_set_brightness;
92a81562e695628 Dan Murphy        2020-07-16  210  	}
92a81562e695628 Dan Murphy        2020-07-16  211  
92a81562e695628 Dan Murphy        2020-07-16  212  	led->cdev.groups = lp55xx_led_groups;
92a81562e695628 Dan Murphy        2020-07-16  213  	led->cdev.default_trigger = pdata->led_config[chan].default_trigger;
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  214) 	led->led_current = pdata->led_config[chan].led_current;
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  215) 	led->max_current = pdata->led_config[chan].max_current;
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  216) 	led->chan_nr = pdata->led_config[chan].chan_nr;
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  217) 
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  218) 	if (led->chan_nr >= max_channel) {
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  219) 		dev_err(dev, "Use channel numbers between 0 and %d\n",
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  220) 			max_channel - 1);
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  221) 		return -EINVAL;
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  222) 	}
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  223) 
92a81562e695628 Dan Murphy        2020-07-16  224  	if (pdata->led_config[chan].num_colors > 1)
92a81562e695628 Dan Murphy        2020-07-16  225  		ret = devm_led_classdev_multicolor_register(dev, &led->mc_cdev);
92a81562e695628 Dan Murphy        2020-07-16  226  	else
c732eaf01f9c213 Dan Murphy        2020-07-16  227  		ret = devm_led_classdev_register(dev, &led->cdev);
92a81562e695628 Dan Murphy        2020-07-16  228  
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  229) 	if (ret) {
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  230) 		dev_err(dev, "led register err: %d\n", ret);
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  231) 		return ret;
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  232) 	}
0e2023463a3c941 Milo(Woogyom  Kim 2013-02-05  233) 
9e9b3db1b2f725b Milo(Woogyom  Kim 2013-02-05  234) 	return 0;
9e9b3db1b2f725b Milo(Woogyom  Kim 2013-02-05  235) }
9e9b3db1b2f725b Milo(Woogyom  Kim 2013-02-05  236) 

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
