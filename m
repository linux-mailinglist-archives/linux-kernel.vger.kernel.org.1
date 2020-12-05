Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209292CFA55
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 08:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgLEHqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 02:46:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbgLEHqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 02:46:39 -0500
Date:   Sat, 5 Dec 2020 13:15:54 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607154358;
        bh=E//ldQD+TeV8HCUYzMii3JTE74QciR7JyOaYyr12bKs=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=uMIHDlcDGdteusCW1MAbeyFsTH9qqwWeoyijGXtOzJd3kLzUIpPUt8tNgP9bn8TUo
         s2xV0klJP0LHZ7RaHrOvUS6Rp9T4igu5f/zNDOjTKS8+MC0ZIVl8BtAep0YhFeqV03
         0rYBSdgCa24ETK5HObcjQBhX4pa2dPPi5X5Vd8JyfArCIyMh08lHHTdwcUyOpmjpAv
         4OlXZlQXrtlLsEESoeYzhazLIyWYiMn6QxObeoEY4SSU2VgSkcPJX6fggKd4nUSYAp
         zgR3eWchsp17yXNRdDZIGcGzKqRZsDZuCFS7tm3K6qQUp6x9H0f/t/VWKkfY9VVlGO
         KOy3RN0RnvedQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 4/7] soundwire/regmap: use _no_pm functions in
 regmap_read/write
Message-ID: <20201205074554.GR8403@vkoul-mobl>
References: <20201202204645.23891-1-yung-chuan.liao@linux.intel.com>
 <20201202204645.23891-5-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202204645.23891-5-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-12-20, 04:46, Bard Liao wrote:
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
> 
> Fixes: 7c22ce6e21840 ('regmap: Add SoundWire bus support')
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
> ---
>  drivers/base/regmap/regmap-sdw.c | 4 ++--
>  drivers/soundwire/bus.c          | 6 ++++--
>  include/linux/soundwire/sdw.h    | 2 ++
>  3 files changed, 8 insertions(+), 4 deletions(-)
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
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 86c339d77a39..c5ea59673dee 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -405,10 +405,11 @@ sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
>  	return sdw_transfer(slave->bus, &msg);
>  }
>  
> -static int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value)
> +int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value)
>  {
>  	return sdw_nwrite_no_pm(slave, addr, 1, &value);
>  }
> +EXPORT_SYMBOL(sdw_write_no_pm);

Why not export this is patch 1..?

>  
>  static int
>  sdw_bread_no_pm(struct sdw_bus *bus, u16 dev_num, u32 addr)
> @@ -476,7 +477,7 @@ int sdw_bwrite_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 val
>  }
>  EXPORT_SYMBOL(sdw_bwrite_no_pm_unlocked);
>  
> -static int
> +int
>  sdw_read_no_pm(struct sdw_slave *slave, u32 addr)
>  {
>  	u8 buf;
> @@ -488,6 +489,7 @@ sdw_read_no_pm(struct sdw_slave *slave, u32 addr)
>  	else
>  		return buf;
>  }
> +EXPORT_SYMBOL(sdw_read_no_pm);
>  
>  static int sdw_update_no_pm(struct sdw_slave *slave, u32 addr, u8 mask, u8 val)
>  {
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index f0b01b728640..d08039d65825 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -1005,6 +1005,8 @@ int sdw_bus_exit_clk_stop(struct sdw_bus *bus);
>  
>  int sdw_read(struct sdw_slave *slave, u32 addr);
>  int sdw_write(struct sdw_slave *slave, u32 addr, u8 value);
> +int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value);
> +int sdw_read_no_pm(struct sdw_slave *slave, u32 addr);
>  int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
>  int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
>  
> -- 
> 2.17.1

-- 
~Vinod
