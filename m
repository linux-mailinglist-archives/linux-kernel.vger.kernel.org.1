Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2672CFA53
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 08:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgLEHpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 02:45:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgLEHpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 02:45:54 -0500
Date:   Sat, 5 Dec 2020 13:15:08 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607154313;
        bh=Gz0uxcIaiBt6Rjn6Q9HJJFBVPnsUhEeLWQb4MJBQeW8=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbRnAZJR1Akmax6bMESQWV0r16MUqubGJUmDimPTWMRtHXCddM40rRR/XIv2x/K53
         eHI5LBtjBaJRfYlQtJxSlME7tlUfPGq+BTipVX03lJoSJtdqz6S3O6VfD3GoWLii7c
         lUbaPWnrm1/2ayNDg84p0xETN+1UA98PsAjUk7yL0xP+arRlPDziRPHeXqTigkWN1L
         BKiBDr1UpIZeKNQlVxPuSRb5fBf87Rz1R0xJOvz2GRXxYBp5Cp2Y/xRxxZ7fsLXcCw
         IOK3BzX+zycqZz3owElNZUbeq62/wphZE/WO9YJlyYxYeEhODfLU6EY2oz7pL5qoBZ
         G8MWMZfZzg/Zw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 1/7] soundwire: bus: use sdw_update_no_pm when
 initializing a device
Message-ID: <20201205074508.GQ8403@vkoul-mobl>
References: <20201202204645.23891-1-yung-chuan.liao@linux.intel.com>
 <20201202204645.23891-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202204645.23891-2-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-12-20, 04:46, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> When a Slave device is resumed, it may resume the bus and restart the
> enumeration. During that process, we absolutely don't want to call
> regular read/write routines which will wait for the resume to
> complete, otherwise a deadlock occurs.
> 
> Fixes: 60ee9be25571 ('soundwire: bus: add PM/no-PM versions of read/write functions')

Change looks okay, but not sure why this is a fix for adding no pm
version?

> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/bus.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index d1e8c3a54976..60c42508c6c6 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -489,6 +489,18 @@ sdw_read_no_pm(struct sdw_slave *slave, u32 addr)
>  		return buf;
>  }
>  
> +static int sdw_update_no_pm(struct sdw_slave *slave, u32 addr, u8 mask, u8 val)
> +{
> +	int tmp;
> +
> +	tmp = sdw_read_no_pm(slave, addr);
> +	if (tmp < 0)
> +		return tmp;
> +
> +	tmp = (tmp & ~mask) | val;
> +	return sdw_write_no_pm(slave, addr, tmp);
> +}
> +
>  /**
>   * sdw_nread() - Read "n" contiguous SDW Slave registers
>   * @slave: SDW Slave
> @@ -1256,7 +1268,7 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
>  	val = slave->prop.scp_int1_mask;
>  
>  	/* Enable SCP interrupts */
> -	ret = sdw_update(slave, SDW_SCP_INTMASK1, val, val);
> +	ret = sdw_update_no_pm(slave, SDW_SCP_INTMASK1, val, val);
>  	if (ret < 0) {
>  		dev_err(slave->bus->dev,
>  			"SDW_SCP_INTMASK1 write failed:%d\n", ret);
> @@ -1271,7 +1283,7 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
>  	val = prop->dp0_prop->imp_def_interrupts;
>  	val |= SDW_DP0_INT_PORT_READY | SDW_DP0_INT_BRA_FAILURE;
>  
> -	ret = sdw_update(slave, SDW_DP0_INTMASK, val, val);
> +	ret = sdw_update_no_pm(slave, SDW_DP0_INTMASK, val, val);
>  	if (ret < 0)
>  		dev_err(slave->bus->dev,
>  			"SDW_DP0_INTMASK read failed:%d\n", ret);
> -- 
> 2.17.1

-- 
~Vinod
