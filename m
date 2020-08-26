Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8182C252AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 11:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgHZJsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 05:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbgHZJsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:48:22 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C33EC2075E;
        Wed, 26 Aug 2020 09:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598435301;
        bh=Iy0PPrLl7Bd/yyILufkraB05ZmIEaRK3D+xoob+NABs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n0wzNPBUocQie5n5JGb5sa+2fSll3loKsiMANLvADZJf2PGrwPs9ClV0OLHylkORD
         da0y3shYsUpokhL0bEOXYPqNPh4O395aiK2sSEUK0jrV01m15hFJgnYBQY0C/Mk6Ny
         hcqrlwsqWjSIGDDqkBxw/7+GKzlZH4znwz/bXiZw=
Date:   Wed, 26 Aug 2020 15:18:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 09/11] soundwire: intel: add dynamic debug trace for
 clock-stop invalid configs
Message-ID: <20200826094817.GC2639@vkoul-mobl>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
 <20200818024120.20721-10-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818024120.20721-10-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-20, 10:41, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Detect cases where the clock is assumed to be stopped but the IP is
> not in the relevant state, and add a dynamic debug trace.

you meant a debug print..and it looks like error print below (also in title).

> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 7c63581270fd..b82d02af3c4f 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1964,6 +1964,11 @@ static int intel_resume_runtime(struct device *dev)
>  			}
>  		}
>  	} else if (!clock_stop_quirks) {
> +
> +		clock_stop0 = sdw_cdns_is_clock_stop(&sdw->cdns);
> +		if (!clock_stop0)
> +			dev_err(dev, "%s invalid configuration, clock was not stopped", __func__);
> +
>  		ret = intel_init(sdw);
>  		if (ret) {
>  			dev_err(dev, "%s failed: %d", __func__, ret);
> -- 
> 2.17.1

-- 
~Vinod
