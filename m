Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2271E24661D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 14:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgHQMO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 08:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbgHQMOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:14:16 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 533DD2072E;
        Mon, 17 Aug 2020 12:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597666456;
        bh=SEtwrw8sAsNOlbZ277m2AQgNTdD6hRM23Zfb7NdecOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1GvFQQ8wTo47RRjSr3A49xWB70B29cZgm08CH3xQDUtL1dGPgIKaWoh39V3LjIaZm
         Xjr0OBo7rvXZ024dquiRm8fwY/DMIPfBbynuaR3iWQOfe6/JjtoWBmK8JUL34+4Sk3
         R3OXMK/G70Su6c8WCCFm6g0xDvbxctE1J+I9pIDg=
Date:   Mon, 17 Aug 2020 17:44:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH v2] soundwire: SDCA: add helper macro to access controls
Message-ID: <20200817121411.GR2639@vkoul-mobl>
References: <20200816201058.9687-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200816201058.9687-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-08-20, 04:10, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The upcoming SDCA (SoundWire Device Class Audio) specification defines
> a hiearchical encoding to interface with Class-defined capabilities,

typo hiearchical

> based on which audio function, entity, control and channel being used.

Can you please elaborate on what do these terms refer to?

Also can we have some documentation for this and how Linux is going to
use it..

> 
> The specification is not yet accessible to the general public but this
> information is released with explicit permission from the MIPI Board
> to avoid delays with SDCA support on Linux platforms.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
> 
> Changelog:
> 
> v2:
>  - add SDW_SDCA_MBQ_CTL
> 
> ---
>  include/linux/soundwire/sdw_registers.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/soundwire/sdw_registers.h b/include/linux/soundwire/sdw_registers.h
> index 5d3c271af7d1..4517c0f65b4f 100644
> --- a/include/linux/soundwire/sdw_registers.h
> +++ b/include/linux/soundwire/sdw_registers.h
> @@ -305,4 +305,16 @@
>  #define SDW_CASC_PORT_MASK_INTSTAT3		1
>  #define SDW_CASC_PORT_REG_OFFSET_INTSTAT3	2
>  
> +/* v1.2 device - SDCA address mapping */
> +#define SDW_SDCA_CTL(fun, ent, ctl, ch)		(BIT(30) |			\
> +						 (((fun) & 0x7) << 22) |	\
> +						 (((ent) & 0x40) << 15) |	\
> +						 (((ent) & 0x3f) << 7) |	\
> +						 (((ctl) & 0x30) << 15) |	\
> +						 (((ctl) & 0x0f) << 3) |	\
> +						 (((ch) & 0x38) << 12) |	\
> +						 ((ch) & 0x07))
> +

how about adding an underscore to the arguments here:

#define SDW_SDCA_CTL(_fun, _ent, _ctl, _ch)
and so on..

-- 
~Vinod
