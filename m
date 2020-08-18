Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE461247E85
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 08:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgHRGhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 02:37:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgHRGhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:37:04 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD7CD2067C;
        Tue, 18 Aug 2020 06:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597732623;
        bh=dZSAWCWw2Yr4Ikp61oQRYzkrpKvcnnTKUAUP5LmfiXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yfK0MpI62iHBXicepZ/nbfEXMhlBtodoik2AbZS/H7ayua+RxAd0OTX2rcxjiodsx
         t68SVSr1UkvBj7K6lYC2bbWEbRQAoIL8YfuBibKPs8+ypGeQ1Ld3DqzH95kX5yOsXG
         lrzgN1T8Vl97z94l6r8jRGedNlBUmgKr1BS1YS7Y=
Date:   Tue, 18 Aug 2020 12:06:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 2/2] soundwire: fix port_ready[] dynamic allocation in
 mipi_disco and ASoC codecs
Message-ID: <20200818063659.GW2639@vkoul-mobl>
References: <20200817174727.15139-1-yung-chuan.liao@linux.intel.com>
 <20200817174727.15139-3-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817174727.15139-3-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-20, 01:47, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The existing code allocates memory for the total number of ports.
> This only works if the ports are contiguous, but will break if e.g. a
> Devices uses port0, 1, and 14. The port_ready[] array would contain 3
> elements, which would lead to an out-of-bounds access. Conversely in
> other cases, the wrong port index would be used leading to timeouts on
> prepare.
> 
> This can be fixed by allocating for the worst-case of 15
> ports (DP0..DP14). In addition since the number is now fixed, we can
> use an array instead of a dynamic allocation.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/mipi_disco.c  | 18 +-----------------
>  drivers/soundwire/slave.c       |  4 ++++
>  include/linux/soundwire/sdw.h   |  2 +-
>  sound/soc/codecs/max98373-sdw.c | 15 +--------------
>  sound/soc/codecs/rt1308-sdw.c   | 14 +-------------
>  sound/soc/codecs/rt5682-sdw.c   | 15 +--------------
>  sound/soc/codecs/rt700-sdw.c    | 15 +--------------
>  sound/soc/codecs/rt711-sdw.c    | 15 +--------------
>  sound/soc/codecs/rt715-sdw.c    | 33 +--------------------------------

This looks fine, but the asoc changes are not dependent, so maybe we
should split them up and then can go thru Mark. Or Mark acks, either way
would work for me

>  9 files changed, 12 insertions(+), 119 deletions(-)
> 
> diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
> index 4ae62b452b8c..55a9c51c84c1 100644
> --- a/drivers/soundwire/mipi_disco.c
> +++ b/drivers/soundwire/mipi_disco.c
> @@ -289,7 +289,7 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
>  	struct sdw_slave_prop *prop = &slave->prop;
>  	struct device *dev = &slave->dev;
>  	struct fwnode_handle *port;
> -	int num_of_ports, nval, i, dp0 = 0;
> +	int nval;
>  
>  	device_property_read_u32(dev, "mipi-sdw-sw-interface-revision",
>  				 &prop->mipi_revision);
> @@ -352,7 +352,6 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
>  			return -ENOMEM;
>  
>  		sdw_slave_read_dp0(slave, port, prop->dp0_prop);
> -		dp0 = 1;
>  	}
>  
>  	/*
> @@ -383,21 +382,6 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
>  	sdw_slave_read_dpn(slave, prop->sink_dpn_prop, nval,
>  			   prop->sink_ports, "sink");
>  
> -	/* some ports are bidirectional so check total ports by ORing */
> -	nval = prop->source_ports | prop->sink_ports;
> -	num_of_ports = hweight32(nval) + dp0; /* add DP0 */
> -
> -	/* Allocate port_ready based on num_of_ports */
> -	slave->port_ready = devm_kcalloc(&slave->dev, num_of_ports,
> -					 sizeof(*slave->port_ready),
> -					 GFP_KERNEL);
> -	if (!slave->port_ready)
> -		return -ENOMEM;
> -
> -	/* Initialize completion */
> -	for (i = 0; i < num_of_ports; i++)
> -		init_completion(&slave->port_ready[i]);
> -
>  	return 0;
>  }
>  EXPORT_SYMBOL(sdw_slave_read_prop);
> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
> index 0839445ee07b..a762ee24e6fa 100644
> --- a/drivers/soundwire/slave.c
> +++ b/drivers/soundwire/slave.c
> @@ -25,6 +25,7 @@ static int sdw_slave_add(struct sdw_bus *bus,
>  {
>  	struct sdw_slave *slave;
>  	int ret;
> +	int i;
>  
>  	slave = kzalloc(sizeof(*slave), GFP_KERNEL);
>  	if (!slave)
> @@ -58,6 +59,9 @@ static int sdw_slave_add(struct sdw_bus *bus,
>  	init_completion(&slave->probe_complete);
>  	slave->probed = false;
>  
> +	for (i = 0; i < SDW_MAX_PORTS; i++)
> +		init_completion(&slave->port_ready[i]);
> +
>  	mutex_lock(&bus->bus_lock);
>  	list_add_tail(&slave->node, &bus->slaves);
>  	mutex_unlock(&bus->bus_lock);
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 0aa4c6af7554..63e71645fd13 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -619,7 +619,7 @@ struct sdw_slave {
>  	struct dentry *debugfs;
>  #endif
>  	struct list_head node;
> -	struct completion *port_ready;
> +	struct completion port_ready[SDW_MAX_PORTS];
>  	enum sdw_clk_stop_mode curr_clk_stop_mode;
>  	u16 dev_num;
>  	u16 dev_num_sticky;
> diff --git a/sound/soc/codecs/max98373-sdw.c b/sound/soc/codecs/max98373-sdw.c
> index 5fe724728e84..a3ec92775ea7 100644
> --- a/sound/soc/codecs/max98373-sdw.c
> +++ b/sound/soc/codecs/max98373-sdw.c
> @@ -282,7 +282,7 @@ static const struct dev_pm_ops max98373_pm = {
>  static int max98373_read_prop(struct sdw_slave *slave)
>  {
>  	struct sdw_slave_prop *prop = &slave->prop;
> -	int nval, i, num_of_ports;
> +	int nval, i;
>  	u32 bit;
>  	unsigned long addr;
>  	struct sdw_dpn_prop *dpn;
> @@ -295,7 +295,6 @@ static int max98373_read_prop(struct sdw_slave *slave)
>  	prop->clk_stop_timeout = 20;
>  
>  	nval = hweight32(prop->source_ports);
> -	num_of_ports = nval;
>  	prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
>  					  sizeof(*prop->src_dpn_prop),
>  					  GFP_KERNEL);
> @@ -315,7 +314,6 @@ static int max98373_read_prop(struct sdw_slave *slave)
>  
>  	/* do this again for sink now */
>  	nval = hweight32(prop->sink_ports);
> -	num_of_ports += nval;
>  	prop->sink_dpn_prop = devm_kcalloc(&slave->dev, nval,
>  					   sizeof(*prop->sink_dpn_prop),
>  					   GFP_KERNEL);
> @@ -333,17 +331,6 @@ static int max98373_read_prop(struct sdw_slave *slave)
>  		i++;
>  	}
>  
> -	/* Allocate port_ready based on num_of_ports */
> -	slave->port_ready = devm_kcalloc(&slave->dev, num_of_ports,
> -					 sizeof(*slave->port_ready),
> -					 GFP_KERNEL);
> -	if (!slave->port_ready)
> -		return -ENOMEM;
> -
> -	/* Initialize completion */
> -	for (i = 0; i < num_of_ports; i++)
> -		init_completion(&slave->port_ready[i]);
> -
>  	/* set the timeout values */
>  	prop->clk_stop_timeout = 20;
>  
> diff --git a/sound/soc/codecs/rt1308-sdw.c b/sound/soc/codecs/rt1308-sdw.c
> index b0ba0d2acbdd..09c69dbab12a 100644
> --- a/sound/soc/codecs/rt1308-sdw.c
> +++ b/sound/soc/codecs/rt1308-sdw.c
> @@ -118,7 +118,7 @@ static int rt1308_clock_config(struct device *dev)
>  static int rt1308_read_prop(struct sdw_slave *slave)
>  {
>  	struct sdw_slave_prop *prop = &slave->prop;
> -	int nval, i, num_of_ports = 1;
> +	int nval, i;
>  	u32 bit;
>  	unsigned long addr;
>  	struct sdw_dpn_prop *dpn;
> @@ -131,7 +131,6 @@ static int rt1308_read_prop(struct sdw_slave *slave)
>  
>  	/* for sink */
>  	nval = hweight32(prop->sink_ports);
> -	num_of_ports += nval;
>  	prop->sink_dpn_prop = devm_kcalloc(&slave->dev, nval,
>  						sizeof(*prop->sink_dpn_prop),
>  						GFP_KERNEL);
> @@ -149,17 +148,6 @@ static int rt1308_read_prop(struct sdw_slave *slave)
>  		i++;
>  	}
>  
> -	/* Allocate port_ready based on num_of_ports */
> -	slave->port_ready = devm_kcalloc(&slave->dev, num_of_ports,
> -					sizeof(*slave->port_ready),
> -					GFP_KERNEL);
> -	if (!slave->port_ready)
> -		return -ENOMEM;
> -
> -	/* Initialize completion */
> -	for (i = 0; i < num_of_ports; i++)
> -		init_completion(&slave->port_ready[i]);
> -
>  	/* set the timeout values */
>  	prop->clk_stop_timeout = 20;
>  
> diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
> index 94bf6bee78e6..b7c97aba7f17 100644
> --- a/sound/soc/codecs/rt5682-sdw.c
> +++ b/sound/soc/codecs/rt5682-sdw.c
> @@ -537,7 +537,7 @@ static int rt5682_update_status(struct sdw_slave *slave,
>  static int rt5682_read_prop(struct sdw_slave *slave)
>  {
>  	struct sdw_slave_prop *prop = &slave->prop;
> -	int nval, i, num_of_ports = 1;
> +	int nval, i;
>  	u32 bit;
>  	unsigned long addr;
>  	struct sdw_dpn_prop *dpn;
> @@ -549,7 +549,6 @@ static int rt5682_read_prop(struct sdw_slave *slave)
>  	prop->sink_ports = 0x2;		/* BITMAP: 00000010 */
>  
>  	nval = hweight32(prop->source_ports);
> -	num_of_ports += nval;
>  	prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
>  					  sizeof(*prop->src_dpn_prop),
>  					  GFP_KERNEL);
> @@ -569,7 +568,6 @@ static int rt5682_read_prop(struct sdw_slave *slave)
>  
>  	/* do this again for sink now */
>  	nval = hweight32(prop->sink_ports);
> -	num_of_ports += nval;
>  	prop->sink_dpn_prop = devm_kcalloc(&slave->dev, nval,
>  					   sizeof(*prop->sink_dpn_prop),
>  					   GFP_KERNEL);
> @@ -587,17 +585,6 @@ static int rt5682_read_prop(struct sdw_slave *slave)
>  		i++;
>  	}
>  
> -	/* Allocate port_ready based on num_of_ports */
> -	slave->port_ready = devm_kcalloc(&slave->dev, num_of_ports,
> -					 sizeof(*slave->port_ready),
> -					 GFP_KERNEL);
> -	if (!slave->port_ready)
> -		return -ENOMEM;
> -
> -	/* Initialize completion */
> -	for (i = 0; i < num_of_ports; i++)
> -		init_completion(&slave->port_ready[i]);
> -
>  	/* set the timeout values */
>  	prop->clk_stop_timeout = 20;
>  
> diff --git a/sound/soc/codecs/rt700-sdw.c b/sound/soc/codecs/rt700-sdw.c
> index 4d14048d1197..b19fbcc12c69 100644
> --- a/sound/soc/codecs/rt700-sdw.c
> +++ b/sound/soc/codecs/rt700-sdw.c
> @@ -333,7 +333,7 @@ static int rt700_update_status(struct sdw_slave *slave,
>  static int rt700_read_prop(struct sdw_slave *slave)
>  {
>  	struct sdw_slave_prop *prop = &slave->prop;
> -	int nval, i, num_of_ports = 1;
> +	int nval, i;
>  	u32 bit;
>  	unsigned long addr;
>  	struct sdw_dpn_prop *dpn;
> @@ -345,7 +345,6 @@ static int rt700_read_prop(struct sdw_slave *slave)
>  	prop->sink_ports = 0xA; /* BITMAP:  00001010 */
>  
>  	nval = hweight32(prop->source_ports);
> -	num_of_ports += nval;
>  	prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
>  						sizeof(*prop->src_dpn_prop),
>  						GFP_KERNEL);
> @@ -365,7 +364,6 @@ static int rt700_read_prop(struct sdw_slave *slave)
>  
>  	/* do this again for sink now */
>  	nval = hweight32(prop->sink_ports);
> -	num_of_ports += nval;
>  	prop->sink_dpn_prop = devm_kcalloc(&slave->dev, nval,
>  						sizeof(*prop->sink_dpn_prop),
>  						GFP_KERNEL);
> @@ -383,17 +381,6 @@ static int rt700_read_prop(struct sdw_slave *slave)
>  		i++;
>  	}
>  
> -	/* Allocate port_ready based on num_of_ports */
> -	slave->port_ready = devm_kcalloc(&slave->dev, num_of_ports,
> -					sizeof(*slave->port_ready),
> -					GFP_KERNEL);
> -	if (!slave->port_ready)
> -		return -ENOMEM;
> -
> -	/* Initialize completion */
> -	for (i = 0; i < num_of_ports; i++)
> -		init_completion(&slave->port_ready[i]);
> -
>  	/* set the timeout values */
>  	prop->clk_stop_timeout = 20;
>  
> diff --git a/sound/soc/codecs/rt711-sdw.c b/sound/soc/codecs/rt711-sdw.c
> index 45b928954b58..dc4a2b482462 100644
> --- a/sound/soc/codecs/rt711-sdw.c
> +++ b/sound/soc/codecs/rt711-sdw.c
> @@ -337,7 +337,7 @@ static int rt711_update_status(struct sdw_slave *slave,
>  static int rt711_read_prop(struct sdw_slave *slave)
>  {
>  	struct sdw_slave_prop *prop = &slave->prop;
> -	int nval, i, num_of_ports = 1;
> +	int nval, i;
>  	u32 bit;
>  	unsigned long addr;
>  	struct sdw_dpn_prop *dpn;
> @@ -349,7 +349,6 @@ static int rt711_read_prop(struct sdw_slave *slave)
>  	prop->sink_ports = 0x8; /* BITMAP:  00001000 */
>  
>  	nval = hweight32(prop->source_ports);
> -	num_of_ports += nval;
>  	prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
>  						sizeof(*prop->src_dpn_prop),
>  						GFP_KERNEL);
> @@ -369,7 +368,6 @@ static int rt711_read_prop(struct sdw_slave *slave)
>  
>  	/* do this again for sink now */
>  	nval = hweight32(prop->sink_ports);
> -	num_of_ports += nval;
>  	prop->sink_dpn_prop = devm_kcalloc(&slave->dev, nval,
>  						sizeof(*prop->sink_dpn_prop),
>  						GFP_KERNEL);
> @@ -387,17 +385,6 @@ static int rt711_read_prop(struct sdw_slave *slave)
>  		i++;
>  	}
>  
> -	/* Allocate port_ready based on num_of_ports */
> -	slave->port_ready = devm_kcalloc(&slave->dev, num_of_ports,
> -					sizeof(*slave->port_ready),
> -					GFP_KERNEL);
> -	if (!slave->port_ready)
> -		return -ENOMEM;
> -
> -	/* Initialize completion */
> -	for (i = 0; i < num_of_ports; i++)
> -		init_completion(&slave->port_ready[i]);
> -
>  	/* set the timeout values */
>  	prop->clk_stop_timeout = 20;
>  
> diff --git a/sound/soc/codecs/rt715-sdw.c b/sound/soc/codecs/rt715-sdw.c
> index d11b23d6b240..d8ed07305ffc 100644
> --- a/sound/soc/codecs/rt715-sdw.c
> +++ b/sound/soc/codecs/rt715-sdw.c
> @@ -431,7 +431,7 @@ static int rt715_update_status(struct sdw_slave *slave,
>  static int rt715_read_prop(struct sdw_slave *slave)
>  {
>  	struct sdw_slave_prop *prop = &slave->prop;
> -	int nval, i, num_of_ports = 1;
> +	int nval, i;
>  	u32 bit;
>  	unsigned long addr;
>  	struct sdw_dpn_prop *dpn;
> @@ -443,7 +443,6 @@ static int rt715_read_prop(struct sdw_slave *slave)
>  	prop->sink_ports = 0x0;	/* BITMAP:  00000000 */
>  
>  	nval = hweight32(prop->source_ports);
> -	num_of_ports += nval;
>  	prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
>  					sizeof(*prop->src_dpn_prop),
>  					GFP_KERNEL);
> @@ -460,36 +459,6 @@ static int rt715_read_prop(struct sdw_slave *slave)
>  		i++;
>  	}
>  
> -	/* do this again for sink now */
> -	nval = hweight32(prop->sink_ports);
> -	num_of_ports += nval;
> -	prop->sink_dpn_prop = devm_kcalloc(&slave->dev, nval,
> -					sizeof(*prop->sink_dpn_prop),
> -					GFP_KERNEL);
> -	if (!prop->sink_dpn_prop)
> -		return -ENOMEM;
> -
> -	dpn = prop->sink_dpn_prop;
> -	i = 0;
> -	addr = prop->sink_ports;
> -	for_each_set_bit(bit, &addr, 32) {
> -		dpn[i].num = bit;
> -		dpn[i].simple_ch_prep_sm = true;
> -		dpn[i].ch_prep_timeout = 10;
> -		i++;
> -	}
> -
> -	/* Allocate port_ready based on num_of_ports */
> -	slave->port_ready = devm_kcalloc(&slave->dev, num_of_ports,
> -					sizeof(*slave->port_ready),
> -					GFP_KERNEL);
> -	if (!slave->port_ready)
> -		return -ENOMEM;
> -
> -	/* Initialize completion */
> -	for (i = 0; i < num_of_ports; i++)
> -		init_completion(&slave->port_ready[i]);
> -
>  	/* set the timeout values */
>  	prop->clk_stop_timeout = 20;
>  
> -- 
> 2.17.1

-- 
~Vinod
