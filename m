Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7559A2C8FD6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 22:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388549AbgK3VT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 16:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387645AbgK3VT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:19:57 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73851C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:19:11 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id r20so385358pjp.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R+fRkUoQp+Unl2rwWqZSXKuCttfMlLMAzbaR7xc5JoE=;
        b=PYGaSkx+R23+S+lfB9W0YiljksUoh0XjND8T8xEmQOGzwp2vDmPXxTepNqM2mD3qKX
         VcETzGLoSFrWbezZ22URw73NdNvN3Vja52iDl4wCJ0QP7ZTx1ylKVrEFx9p3jMZpdAJx
         94IZDENfmbWw2JAI1acwWhgdVvFpbOt/qwxFL2lV6ya/A7J/HJcbrMZWSA6cDSG8uPCG
         djQQMFysUB4g35Wn/U2xQqL2XByKkm5+aFCZJ0svTQKJ4p0hziIMtXGjUT0WMijIRjEo
         UrH3TM8BpJ5M5kSZjrs5fGz884r4okKUZxG6R6f0VlGChYzvSoMT39nZryPFHGP+8CcZ
         k3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R+fRkUoQp+Unl2rwWqZSXKuCttfMlLMAzbaR7xc5JoE=;
        b=MXXEkIV5sTWGM0pV0Xnpl1E4Y+r1NjqwFhykEPUEhinrhP8uuTv9/saATeJw0p5xso
         Xs4fZscfFj/I0DKP8EWh+RAG/mptnNFgqRV2ZGkjtGNtaOgVjBMafqSl8i3xV3QKFElz
         2eRGguNbLIM2SGRh9GAj3/ueZODbQ1Z+bxF9ETii8e8hHPiGmky4T3WyKQarfcLm2BU+
         IWUbMn4PuUwI3YYZiRTALAnoH2EXdfQ949e2RwP3Avx+kKmPFecpcemI5x8eMnY70SeF
         9kWLLCqfxiPjag6Sxn9h8BY3TblUvkVDCEjRECpTlOROJHwYNlE6ee5b8NSpJ3uwRX0H
         9U8A==
X-Gm-Message-State: AOAM531xlduDENcD8n9Vgtx+q8gJe6Spgsp4FkrWZyvScsONXi0owNfS
        AUNYbHa/D4SHuUQzBGxQvdg3Vw==
X-Google-Smtp-Source: ABdhPJzgkoi3AlDuVfVbDJ3UWGzkwcp38mTJMkGAgZ1nj+CuxcyLomrB2dXhurqbsKDGdRhPfz2JVg==
X-Received: by 2002:a17:902:6acc:b029:d8:c6ee:6d6c with SMTP id i12-20020a1709026accb02900d8c6ee6d6cmr20684450plt.7.1606771150937;
        Mon, 30 Nov 2020 13:19:10 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id gp14sm400005pjb.6.2020.11.30.13.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 13:19:10 -0800 (PST)
Date:   Mon, 30 Nov 2020 14:19:08 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        jonathan.zhouwen@huawei.com, coresight@lists.linaro.org
Subject: Re: [PATCH v4 11/25] coresight: etm4x: Define DEVARCH register fields
Message-ID: <20201130211908.GG1092947@xps15>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
 <20201119164547.2982871-12-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119164547.2982871-12-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 04:45:33PM +0000, Suzuki K Poulose wrote:
> Define the fields of the DEVARCH register for identifying
> a component as an ETMv4.x unit. Going forward, we use the
> DEVARCH register for the component identification, rather
> than the TRCIDR3.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../coresight/coresight-etm4x-core.c          |  4 +-
>  drivers/hwtracing/coresight/coresight-etm4x.h | 42 +++++++++++++++++++
>  2 files changed, 44 insertions(+), 2 deletions(-)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index c2499b62e64e..6f776f075602 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1622,8 +1622,8 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  static struct amba_cs_uci_id uci_id_etm4[] = {
>  	{
>  		/*  ETMv4 UCI data */
> -		.devarch	= 0x47704a13,
> -		.devarch_mask	= 0xfff0ffff,
> +		.devarch	= ETM_DEVARCH_ETMv4x_ARCH,
> +		.devarch_mask	= ETM_DEVARCH_ID_MASK,
>  		.devtype	= 0x00000013,
>  	}
>  };
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 6591a59c1012..d8f047547a36 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -498,6 +498,48 @@
>  					 ETM_MODE_EXCL_KERN | \
>  					 ETM_MODE_EXCL_USER)
>  
> +/*
> + * TRCDEVARCH Bit field definitions
> + * Bits[31:21]	- ARCHITECT = Always Arm Ltd.
> + *                * Bits[31:28] = 0x4
> + *                * Bits[27:21] = 0b0111011
> + * Bit[20]	- PRESENT,  Indicates the presence of this register.
> + *
> + * Bit[19:16]	- REVISION, Revision of the architecture.
> + *
> + * Bit[15:0]	- ARCHID, Identifies this component as an ETM
> + *                * Bits[15:12] - architecture version of ETM
> + *                *             = 4 for ETMv4
> + *                * Bits[11:0] = 0xA13, architecture part number for ETM.
> + */
> +#define ETM_DEVARCH_ARCHITECT_MASK		GENMASK(31, 21)
> +#define ETM_DEVARCH_ARCHITECT_ARM		((0x4 << 28) | (0b0111011 << 21))
> +#define ETM_DEVARCH_PRESENT			BIT(20)
> +#define ETM_DEVARCH_REVISION_SHIFT		16
> +#define ETM_DEVARCH_REVISION_MASK		GENMASK(19, 16)
> +#define ETM_DEVARCH_REVISION(x)			\
> +	(((x) & ETM_DEVARCH_REVISION_MASK) >> ETM_DEVARCH_REVISION_SHIFT)
> +#define ETM_DEVARCH_ARCHID_MASK			GENMASK(15, 0)
> +#define ETM_DEVARCH_ARCHID_ARCH_VER_SHIFT	12
> +#define ETM_DEVARCH_ARCHID_ARCH_VER_MASK	GENMASK(15, 12)
> +#define ETM_DEVARCH_ARCHID_ARCH_VER(x)		\
> +	(((x) & ETM_DEVARCH_ARCHID_ARCH_VER_MASK) >> ETM_DEVARCH_ARCHID_ARCH_VER_SHIFT)
> +
> +#define ETM_DEVARCH_MAKE_ARCHID_ARCH_VER(ver)			\
> +	(((ver) << ETM_DEVARCH_ARCHID_ARCH_VER_SHIFT) & ETM_DEVARCH_ARCHID_ARCH_VER_MASK)
> +
> +#define ETM_DEVARCH_ARCHID_ARCH_PART(x)		((x) & 0xfffUL)
> +
> +#define ETM_DEVARCH_MAKE_ARCHID(major)			\
> +	((ETM_DEVARCH_MAKE_ARCHID_ARCH_VER(major)) | ETM_DEVARCH_ARCHID_ARCH_PART(0xA13))
> +
> +#define ETM_DEVARCH_ARCHID_ETMv4x		ETM_DEVARCH_MAKE_ARCHID(0x4)
> +
> +#define ETM_DEVARCH_ID_MASK						\
> +	(ETM_DEVARCH_ARCHITECT_MASK | ETM_DEVARCH_ARCHID_MASK | ETM_DEVARCH_PRESENT)
> +#define ETM_DEVARCH_ETMv4x_ARCH						\
> +	(ETM_DEVARCH_ARCHITECT_ARM | ETM_DEVARCH_ARCHID_ETMv4x | ETM_DEVARCH_PRESENT)
> +
>  #define TRCSTATR_IDLE_BIT		0
>  #define TRCSTATR_PMSTABLE_BIT		1
>  #define ETM_DEFAULT_ADDR_COMP		0
> -- 
> 2.24.1
> 
