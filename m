Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3682AC5E4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 21:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgKIUWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 15:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgKIUWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 15:22:08 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222C0C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 12:22:08 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id t22so5287481plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 12:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bW2hYDR209olnXN7rEKOa9sbiMCdvyzNIoGJT+r5Th4=;
        b=m0q+MCN4z/B4HIjSft5rFOLyJWJjL4X59tEoxLp2dG8/re6+bIA52UvFwJu6iWSRe2
         ovY6o3jcTzaCtKOjuDVCKVPpW3N9r3hFjTBYvBaeiuEe4kSsczH+3sEXxwt7hvALHPiO
         aInQbPLNGueJD4/8yhrOwlsz4VvGxFBeaGkveO6x9a3XWFfBUI/6zpszW3mi1V9cfJ4O
         ZMSI6arZV0t+3WHBC6suCTRnqmiaUkHkzFF1QQ6W4bvT55PH6TodsN8SXBjIxQvyTToi
         gYgllIpCkWC8eHLT56/RoB2WyPROYdJrCVpVNkUD/5GyPCjZ3mPZvXMrZ0nlpL2GwUtx
         Qlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bW2hYDR209olnXN7rEKOa9sbiMCdvyzNIoGJT+r5Th4=;
        b=JaRiFbGzOP8EDwTHOhK0xXvZA0qbbQNHE5Md6T3FfyHq9fRG6VWeSrWe+ZYy7kQNYL
         1C/MTjF9WRdUaqsUuqBhIzfazUQjTmex60ChCwsfKiKWM6SBUh4TJyfKi1Qklvz/HJ2y
         2IvUepf3fxB5EnwsM/cQCTRv6D0n88ceA5v9XgcCionYklguyFrjWStTk/DpL0OIvWhJ
         hbSIzP6C3GJn453vAaxhareqFrRkOmecatFrTJkTCo3XDu61l+uJGzZdLGMuoP6Tkhbk
         Za7JrTAne/Lh7/SReM1z7iNGKVTd12Le645eLxw/NQarRMBQQQKs8T3LxRXEHNS+xamk
         c8OQ==
X-Gm-Message-State: AOAM531D+e21jnzZhJ5lse9RW1+4VxEwslOhKbPM+BHxjGrx9Z+5WFaL
        PGtMGH6TeE/3V5esICd8gAL+KUjlMNpV5g==
X-Google-Smtp-Source: ABdhPJyUpJGtVedeyiGxpoPznItI4efoY3gfkjO4R69ezeXWSMB1IQukg4nRItyv6CeGUx04n+SOEg==
X-Received: by 2002:a17:902:74c7:b029:d7:e593:fcb with SMTP id f7-20020a17090274c7b02900d7e5930fcbmr4950180plt.71.1604953327574;
        Mon, 09 Nov 2020 12:22:07 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m10sm319905pjr.3.2020.11.09.12.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 12:22:06 -0800 (PST)
Date:   Mon, 9 Nov 2020 13:22:05 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 23/26] coresight: etm4x: Detect system instructions
 support
Message-ID: <20201109202205.GB3396611@xps15>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-25-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028220945.3826358-25-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:09:42PM +0000, Suzuki K Poulose wrote:
> ETM v4.4 onwards adds support for system instruction access
> to the ETM. Detect the support on an ETM and switch to using the
> mode when available.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../coresight/coresight-etm4x-core.c          | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 4bc2f15b6332..dc537b5612eb 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -675,6 +675,37 @@ static const struct coresight_ops etm4_cs_ops = {
>  	.source_ops	= &etm4_source_ops,
>  };
>  
> +static inline bool cpu_supports_sysreg_trace(void)
> +{
> +	u64 dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
> +
> +	return ((dfr0 >> ID_AA64DFR0_TRACEVER_SHIFT) & 0xfUL) > 0;

I would do:

        return ((dfr0 >> ID_AA64DFR0_TRACEVER_SHIFT) & 0xfUL) == 1;

Because any other value than '1' are reserved.

> +}
> +
> +static bool etm_init_sysreg_access(struct etmv4_drvdata *drvdata,
> +				   struct csdev_access *csa)
> +{
> +	u32 devarch;
> +
> +	if (!cpu_supports_sysreg_trace())
> +		return false;
> +
> +	/*
> +	 * ETMs implementing sysreg access must implement TRCDEVARCH.
> +	 */
> +	devarch = read_etm4x_sysreg_const_offset(TRCDEVARCH);
> +	if ((devarch & ETM_DEVARCH_ID_MASK) != ETM_DEVARCH_ETMv4x_ARCH)
> +		return false;
> +	*csa = (struct csdev_access) {
> +		.io_mem	= false,
> +		.read	= etm4x_sysreg_read,
> +		.write	= etm4x_sysreg_write,
> +	};
> +
> +	drvdata->arch = etm_devarch_to_arch(devarch);
> +	return true;
> +}
> +
>  static bool etm_init_iomem_access(struct etmv4_drvdata *drvdata,
>  				  struct csdev_access *csa)
>  {
> @@ -705,9 +736,17 @@ static bool etm_init_iomem_access(struct etmv4_drvdata *drvdata,
>  static bool etm_init_csdev_access(struct etmv4_drvdata *drvdata,
>  				  struct csdev_access *csa)
>  {
> +	/*
> +	 * Always choose the memory mapped io, if there is
> +	 * a memory map to prevent sysreg access on broken
> +	 * systems.
> +	 */
>  	if (drvdata->base)
>  		return etm_init_iomem_access(drvdata, csa);
>  
> +	if (etm_init_sysreg_access(drvdata, csa))
> +		return true;
> +
>  	return false;

With the above:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  }
>  
> -- 
> 2.24.1
> 
