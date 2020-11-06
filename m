Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5574A2A9F47
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgKFVmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbgKFVmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:42:32 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCED2C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:42:31 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id u4so1957259pgr.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OXc4atPpFOTrcSg081/4sIuZT64NxkfFUx9nAZMphqM=;
        b=JHQA2x7RUul/WbvzBh+NCAC2SubSSIltNd2gKAlpOnmoLwaVd7Zb/095OFXFBGVrbm
         NxexypIO3UYGGZ8mZc31LTSarPk/aXdsZau0KFB3EeHvoejSdv2KU+JtOde3IPhWkzxJ
         J12bT5ki2uydGV5jj5WAZ7p11QOhuvNEWYz+ulw7Vyco2tEsHugl9I+2jchIIyo0u7lP
         VMUCjVewHVxT2zR2ynvfyRBdUJlnPEnPvsmIaqxiQs1CPk5dwz81snasmnU2Kv6L9sTJ
         t8xsNllVuuW7bl29u7ULwJ9QGtnTatfa3eX+VotI9+0qs83jX26m/61hipYjrnb2GAeY
         wfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OXc4atPpFOTrcSg081/4sIuZT64NxkfFUx9nAZMphqM=;
        b=GY498aU7HcgSf+9s1yqd0ZPsV34NDkWB9B2PZDF/Z2aJjZ2ybTYHr9wRnBB+2GDxkn
         VovKhmgQwNjMFlMF80mHO/gKzNizw90ClMAXdSRgf0gRpb2p805HlxkGHl95uRcJMh01
         SsqCHZ1MCe654CTtuGKoH/nMYGaQ18uwJOV9nQp1kenMDwyY5BtneNUuAu5gyUqZsiMP
         GGA3d9hXL+JKax4QrFDOUo8XZ4Thq7TrCR/CrcriKTQZ1vgnQTXzjdrIxYbmaYrzOuGa
         4FF8ZpeAFwMHAb23+FkISQubws8EmQFXuYIxS+U8y4lxry0MviUMhLmjRnVTtALabt+o
         fhYg==
X-Gm-Message-State: AOAM533+827AfpTeeyDU71oOziE6TJBd1x6Ltc3wpLRNUNPzbng+/Z1K
        gVG3OB8oyvc+iAc4FJqOnDvBXQ==
X-Google-Smtp-Source: ABdhPJxcsqXEXVbFt07FBSIIOzpWnolNscd/0h6xqo027RWz4u9s4UdUkMFghcxXXpxQwaKlnvXAsw==
X-Received: by 2002:a17:90a:c201:: with SMTP id e1mr1600872pjt.16.1604698951256;
        Fri, 06 Nov 2020 13:42:31 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b29sm3153149pff.194.2020.11.06.13.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:42:30 -0800 (PST)
Date:   Fri, 6 Nov 2020 14:42:28 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 21/26] coresight: etm4x: Use TRCDEVARCH for component
 discovery
Message-ID: <20201106214228.GE3299843@xps15>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-23-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028220945.3826358-23-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:09:40PM +0000, Suzuki K Poulose wrote:
> We have been using TRCIDR1 for detecting the ETM version. This
> is in preparation for the future IP support.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../coresight/coresight-etm4x-core.c          | 46 +++++++++----------
>  1 file changed, 23 insertions(+), 23 deletions(-)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

I'm out of time for today, I will resume on Monday.

Thanks,
Mathieu

> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 4ef47a2946a4..e36bc1c722c7 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -141,18 +141,6 @@ static void etm4_cs_unlock(struct etmv4_drvdata *drvdata,
>  		CS_UNLOCK(csa->base);
>  }
>  
> -static bool etm4_arch_supported(u8 arch)
> -{
> -	/* Mask out the minor version number */
> -	switch (arch & 0xf0) {
> -	case ETM_ARCH_V4:
> -		break;
> -	default:
> -		return false;
> -	}
> -	return true;
> -}
> -
>  static int etm4_cpu_id(struct coresight_device *csdev)
>  {
>  	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> @@ -677,6 +665,26 @@ static const struct coresight_ops etm4_cs_ops = {
>  static bool etm_init_iomem_access(struct etmv4_drvdata *drvdata,
>  				  struct csdev_access *csa)
>  {
> +	u32 devarch = readl_relaxed(drvdata->base + TRCDEVARCH);
> +	u32 idr1 = readl_relaxed(drvdata->base + TRCIDR1);
> +
> +	/*
> +	 * All ETMs must implement TRCDEVARCH to indicate that
> +	 * the component is an ETMv4. To support any broken
> +	 * implementations we fall back to TRCIDR1 check, which
> +	 * is not really reliable.
> +	 */
> +	if ((devarch & ETM_DEVARCH_ID_MASK) == ETM_DEVARCH_ETMv4x_ARCH) {
> +		drvdata->arch = etm_devarch_to_arch(devarch);
> +	} else {
> +		pr_warn("CPU%d: ETM4x incompatible TRCDEVARCH: %x, falling back to TRCIDR1\n",
> +			smp_processor_id(), devarch);
> +
> +		if (ETM_TRCIDR1_ARCH_MAJOR(idr1) != ETM_TRCIDR1_ARCH_ETMv4)
> +			return false;
> +		drvdata->arch = etm_trcidr_to_arch(idr1);
> +	}
> +
>  	*csa = CSDEV_ACCESS_IOMEM(drvdata->base);
>  	return true;
>  }
> @@ -693,7 +701,6 @@ static bool etm_init_csdev_access(struct etmv4_drvdata *drvdata,
>  static void etm4_init_arch_data(void *info)
>  {
>  	u32 etmidr0;
> -	u32 etmidr1;
>  	u32 etmidr2;
>  	u32 etmidr3;
>  	u32 etmidr4;
> @@ -758,14 +765,6 @@ static void etm4_init_arch_data(void *info)
>  	/* TSSIZE, bits[28:24] Global timestamp size field */
>  	drvdata->ts_size = BMVAL(etmidr0, 24, 28);
>  
> -	/* base architecture of trace unit */
> -	etmidr1 = etm4x_relaxed_read32(csa, TRCIDR1);
> -	/*
> -	 * TRCARCHMIN, bits[7:4] architecture the minor version number
> -	 * TRCARCHMAJ, bits[11:8] architecture major versin number
> -	 */
> -	drvdata->arch = BMVAL(etmidr1, 4, 11);
> -
>  	/* maximum size of resources */
>  	etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
>  	/* CIDSIZE, bits[9:5] Indicates the Context ID size */
> @@ -1602,7 +1601,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  				etm4_init_arch_data,  &init_arg, 1))
>  		dev_err(dev, "ETM arch init failed\n");
>  
> -	if (etm4_arch_supported(drvdata->arch) == false)
> +	if (!drvdata->arch)
>  		return -EINVAL;
>  
>  	etm4_init_trace_id(drvdata);
> @@ -1634,7 +1633,8 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  
>  	pm_runtime_put(&adev->dev);
>  	dev_info(&drvdata->csdev->dev, "CPU%d: ETM v%d.%d initialized\n",
> -		 drvdata->cpu, drvdata->arch >> 4, drvdata->arch & 0xf);
> +		 drvdata->cpu, ETM_ARCH_MAJOR_VERSION(drvdata->arch),
> +		 ETM_ARCH_MINOR_VERSION(drvdata->arch));
>  
>  	if (boot_enable) {
>  		coresight_enable(drvdata->csdev);
> -- 
> 2.24.1
> 
