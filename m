Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA3E2B5B29
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgKQInD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:43:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:13710 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgKQInC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:43:02 -0500
IronPort-SDR: 9RP4StRMtdbY97SQV3Bjq5NjTsjlEty9QOYfYJmvfY2Ix1pdI7VMLCvYLyzUybNshTGGYR9ZS2
 msqZGa1k/O7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="167377202"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="167377202"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 00:43:02 -0800
IronPort-SDR: FFTrmY4XmRjdf/G9khiTYwk1jESs2494duNzVO8cvfLmSVVDGV7QGJyKD8zuMZoN9V1Mp5EF8b
 cVNUJ1LLY9PQ==
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="475845267"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.117])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 00:43:00 -0800
Date:   Tue, 17 Nov 2020 16:42:14 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/iio/adc/at91_adc.c:450:16: warning: Shifting signed 32-bit
 value by 31 bits is undefined behaviour
Message-ID: <20201117084214.GC3723@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9c87c9f41245baa3fc4716cf39141439cf405b01
commit: 4027860dcc4cd0c45c36bae21e45bee5a17f2f0f iio: Kconfig: at91_adc: add COMPILE_TEST dependency to driver
compiler: s390-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <rong.a.chen@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/iio/adc/at91_adc.c:450:16: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
     if (status & AT91_ADC_ISR_PENS) {
                  ^

vim +450 drivers/iio/adc/at91_adc.c

84882b060301c35 Alexandre Belloni 2014-04-15  417  
84882b060301c35 Alexandre Belloni 2014-04-15  418  static irqreturn_t at91_adc_9x5_interrupt(int irq, void *private)
c8b11de0404d318 Josh Wu           2013-10-08  419  {
c8b11de0404d318 Josh Wu           2013-10-08  420  	struct iio_dev *idev = private;
c8b11de0404d318 Josh Wu           2013-10-08  421  	struct at91_adc_state *st = iio_priv(idev);
c8b11de0404d318 Josh Wu           2013-10-08  422  	u32 status = at91_adc_readl(st, st->registers->status_register);
c8b11de0404d318 Josh Wu           2013-10-08  423  	const uint32_t ts_data_irq_mask =
c8b11de0404d318 Josh Wu           2013-10-08  424  		AT91_ADC_IER_XRDY |
c8b11de0404d318 Josh Wu           2013-10-08  425  		AT91_ADC_IER_YRDY |
c8b11de0404d318 Josh Wu           2013-10-08  426  		AT91_ADC_IER_PRDY;
c8b11de0404d318 Josh Wu           2013-10-08  427  
d4f51956ac8ad30 Ludovic Desroches 2014-10-09  428  	if (status & GENMASK(st->num_channels - 1, 0))
c8b11de0404d318 Josh Wu           2013-10-08  429  		handle_adc_eoc_trigger(irq, idev);
c8b11de0404d318 Josh Wu           2013-10-08  430  
c8b11de0404d318 Josh Wu           2013-10-08  431  	if (status & AT91_ADC_IER_PEN) {
c8b11de0404d318 Josh Wu           2013-10-08  432  		at91_adc_writel(st, AT91_ADC_IDR, AT91_ADC_IER_PEN);
c8b11de0404d318 Josh Wu           2013-10-08  433  		at91_adc_writel(st, AT91_ADC_IER, AT91_ADC_IER_NOPEN |
c8b11de0404d318 Josh Wu           2013-10-08  434  			ts_data_irq_mask);
c8b11de0404d318 Josh Wu           2013-10-08  435  		/* Set up period trigger for sampling */
c8b11de0404d318 Josh Wu           2013-10-08  436  		at91_adc_writel(st, st->registers->trigger_register,
c8b11de0404d318 Josh Wu           2013-10-08  437  			AT91_ADC_TRGR_MOD_PERIOD_TRIG |
c8b11de0404d318 Josh Wu           2013-10-08  438  			AT91_ADC_TRGR_TRGPER_(st->ts_sample_period_val));
c8b11de0404d318 Josh Wu           2013-10-08  439  	} else if (status & AT91_ADC_IER_NOPEN) {
c8b11de0404d318 Josh Wu           2013-10-08  440  		at91_adc_writel(st, st->registers->trigger_register, 0);
c8b11de0404d318 Josh Wu           2013-10-08  441  		at91_adc_writel(st, AT91_ADC_IDR, AT91_ADC_IER_NOPEN |
c8b11de0404d318 Josh Wu           2013-10-08  442  			ts_data_irq_mask);
c8b11de0404d318 Josh Wu           2013-10-08  443  		at91_adc_writel(st, AT91_ADC_IER, AT91_ADC_IER_PEN);
c8b11de0404d318 Josh Wu           2013-10-08  444  
c8b11de0404d318 Josh Wu           2013-10-08  445  		input_report_key(st->ts_input, BTN_TOUCH, 0);
c8b11de0404d318 Josh Wu           2013-10-08  446  		input_sync(st->ts_input);
c8b11de0404d318 Josh Wu           2013-10-08  447  	} else if ((status & ts_data_irq_mask) == ts_data_irq_mask) {
c8b11de0404d318 Josh Wu           2013-10-08  448  		/* Now all touchscreen data is ready */
c8b11de0404d318 Josh Wu           2013-10-08  449  
c8b11de0404d318 Josh Wu           2013-10-08 @450  		if (status & AT91_ADC_ISR_PENS) {
c8b11de0404d318 Josh Wu           2013-10-08  451  			/* validate data by pen contact */
c8b11de0404d318 Josh Wu           2013-10-08  452  			at91_ts_sample(st);
c8b11de0404d318 Josh Wu           2013-10-08  453  		} else {
c8b11de0404d318 Josh Wu           2013-10-08  454  			/* triggered by event that is no pen contact, just read
c8b11de0404d318 Josh Wu           2013-10-08  455  			 * them to clean the interrupt and discard all.
c8b11de0404d318 Josh Wu           2013-10-08  456  			 */
c8b11de0404d318 Josh Wu           2013-10-08  457  			at91_adc_readl(st, AT91_ADC_TSXPOSR);
c8b11de0404d318 Josh Wu           2013-10-08  458  			at91_adc_readl(st, AT91_ADC_TSYPOSR);
c8b11de0404d318 Josh Wu           2013-10-08  459  			at91_adc_readl(st, AT91_ADC_TSPRESSR);
c8b11de0404d318 Josh Wu           2013-10-08  460  		}
c8b11de0404d318 Josh Wu           2013-10-08  461  	}
0e589d5fb3172b0 Maxime Ripard     2012-05-11  462  
0e589d5fb3172b0 Maxime Ripard     2012-05-11  463  	return IRQ_HANDLED;
0e589d5fb3172b0 Maxime Ripard     2012-05-11  464  }
0e589d5fb3172b0 Maxime Ripard     2012-05-11  465  

:::::: The code at line 450 was first introduced by commit
:::::: c8b11de0404d318c4a67bf6b9066663b9d93786c iio: at91: introduce touch screen support in iio adc driver

:::::: TO: Josh Wu <josh.wu@atmel.com>
:::::: CC: Jonathan Cameron <jic23@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
