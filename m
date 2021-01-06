Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A68D2EB9B3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 07:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbhAFF7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 00:59:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbhAFF7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 00:59:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C3EE22C9F;
        Wed,  6 Jan 2021 05:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609912745;
        bh=aovVTGHsEd7lpXJVZ9UJHQBManE8+HoTxC4a8R17IOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lk96XD1UnD3J5cm6LohB5oiOdNiupt0I0ZH09obXQ6As9gwszNIRMM9Tfpq9TfkHy
         USJuXkhzct4kvsvqNfc8SKyDfR0Bz8t/FzcrleQhfnoo5MvxhaI/4RVxrOcRQrGUs4
         rwSv4nwWkd2FncsvdYYXVVfJanwV000Uv5nw2Zf+b/hGPLlKdAQulg/o9ku7oxdexJ
         0M9k0D+9jHy6lNkZJ8Q6Octcb9pHd5/SHLhNSlg1nOHR2jc2G9SXc3wTtyruvGJ3a9
         fNwovDud6iHJmgER3ICyx108/BcwEwTQfiduUHoWl1TJ58eICjD1HxUnNuUBPTMkA5
         hv0hO+OtRggQA==
Date:   Wed, 6 Jan 2021 11:29:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH v2 5/9] regmap: sdw: use _no_pm functions in
 regmap_read/write
Message-ID: <20210106055901.GL2771@vkoul-mobl>
References: <20201209053459.5515-1-yung-chuan.liao@linux.intel.com>
 <20201209053459.5515-6-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209053459.5515-6-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HeY Mark,

On 09-12-20, 13:34, Bard Liao wrote:
> sdw_update_slave_status will be invoked when a codec is attached,
> and the codec driver will initialize the codec with regmap functions
> while the codec device is pm_runtime suspended.
> 
> regmap routines currently rely on regular SoundWire IO functions,
> which will call pm_runtime_get_sync()/put_autosuspend.
> 
> This causes a deadlock where the resume routine waits for an
> initialization complete signal that while the initialization complete
> can only be reached when the resume completes.
> 
> The only solution if we allow regmap functions to be used in resume
> operations as well as during codec initialization is to use _no_pm
> routines. The duty of making sure the bus is operational needs to be
> handled above the regmap level.

You okay these going thru sdw tree..?

> 
> Fixes: 7c22ce6e21840 ('regmap: Add SoundWire bus support')
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/base/regmap/regmap-sdw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
> index c92d614b4943..4b8d2d010cab 100644
> --- a/drivers/base/regmap/regmap-sdw.c
> +++ b/drivers/base/regmap/regmap-sdw.c
> @@ -11,7 +11,7 @@ static int regmap_sdw_write(void *context, unsigned int reg, unsigned int val)
>  	struct device *dev = context;
>  	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>  
> -	return sdw_write(slave, reg, val);
> +	return sdw_write_no_pm(slave, reg, val);
>  }
>  
>  static int regmap_sdw_read(void *context, unsigned int reg, unsigned int *val)
> @@ -20,7 +20,7 @@ static int regmap_sdw_read(void *context, unsigned int reg, unsigned int *val)
>  	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>  	int read;
>  
> -	read = sdw_read(slave, reg);
> +	read = sdw_read_no_pm(slave, reg);
>  	if (read < 0)
>  		return read;
>  
> -- 
> 2.17.1

-- 
~Vinod
