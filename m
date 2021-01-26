Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFC0304179
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406056AbhAZPGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:06:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38488 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406029AbhAZPCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611673248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p9vbxus2aTMX9bESQh4Z4Catq5RVjcE6wGhF//U40V0=;
        b=gTlTnqJ1Te3TfmYnHi2CPauYSE1NhTsJA3KZhi0J/nCpEZdh+eAiJXOsKkHX68Cls64GvI
        8VvbGU6bj0BKhmJz3gdljzw6cCRYId2gjDeXEGWA7efswflRMMwgPoxX6gXK3rPpyVO4Qs
        vuCHLcZrZL7b7hqbkw8C9NkFJKKmjF4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-Rr1IwgWQNkGqtopSIeKBAw-1; Tue, 26 Jan 2021 10:00:46 -0500
X-MC-Unique: Rr1IwgWQNkGqtopSIeKBAw-1
Received: by mail-qv1-f71.google.com with SMTP id a12so3369566qvo.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:00:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=p9vbxus2aTMX9bESQh4Z4Catq5RVjcE6wGhF//U40V0=;
        b=cVv2Fmj/9mosGiVWQCN1RGEkvyu1K/PYo3hvFf3vTbCNWxvk80u6aCwwh9bhTyEZaF
         8kaYoz8zZKGtszJ4abEQwUQtNy7KPpEWrenCZjmdZIfloDgZeOHa9n2V8lA9Iy3DwGOc
         Nx1CbxcE3ywpDgF60vrB7bgRjacHUzshRVoefv0yItAzQiKfx1lpnfzVBpAMccOuFZp9
         BSIEXDVaboLHBCPsFRwtsuGK0z0kuh3N12oXHotobhCMg+PZwN9gsr9FC0/sLez6uEwj
         SuWDV5hT2RD7K0O1sfP8pO4E7gXhk4R1LGgqlA/Y8dMPCIEMBQbgV145NYQN2H9d4A8U
         Tq5g==
X-Gm-Message-State: AOAM532JFDZLdrPnwM0tKUMRSXVDKSr1hctHDEGf7IJB0Blb2Jo9hmTF
        p3rEtbhkaQ+yQaO0o/609IhvLTscGcsj/flqADr8fia/AuqFLPNZjTS47f1j0b1rCiMMY3//pBu
        ZzSXNLB2vWV9pa3ZChgaYz5Mk
X-Received: by 2002:a37:a04d:: with SMTP id j74mr6027547qke.378.1611673245645;
        Tue, 26 Jan 2021 07:00:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIEF9sOwyTDzs3JYrs09MVu1NwYSI/zBnejB7jnTd9Bc6/Y/e9JQj9a+BD+22HHv7VeJa0uA==
X-Received: by 2002:a37:a04d:: with SMTP id j74mr6027516qke.378.1611673245350;
        Tue, 26 Jan 2021 07:00:45 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t22sm13558108qtp.7.2021.01.26.07.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 07:00:44 -0800 (PST)
Subject: Re: [PATCH v2 3/4] mfd: intel-m10-bmc: Add access table configuration
 to the regmap
To:     Xu Yilun <yilun.xu@intel.com>, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
References: <1611643836-7183-1-git-send-email-yilun.xu@intel.com>
 <1611643836-7183-4-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <ff9cf230-8a77-febc-d9af-5d9ecf868649@redhat.com>
Date:   Tue, 26 Jan 2021 07:00:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1611643836-7183-4-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/25/21 10:50 PM, Xu Yilun wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> This patch adds access tables to the MAX 10 BMC regmap. This prevents
> the host from accessing the unwanted I/O space. It also filters out the
> invalid outputs when reading the regmap debugfs interface.
>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v2: no change.

v2: Use M10BMC_LEGACY_BUILD_VER

Looks good.

Reviewed-by: Tom Rix <trix@redhat.com>


> ---
>  drivers/mfd/intel-m10-bmc.c       | 13 +++++++++++++
>  include/linux/mfd/intel-m10-bmc.h |  5 ++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> index aad86f0..4240e99 100644
> --- a/drivers/mfd/intel-m10-bmc.c
> +++ b/drivers/mfd/intel-m10-bmc.c
> @@ -23,10 +23,23 @@ static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
>  	{ .name = "n3000bmc-secure" },
>  };
>  
> +static const struct regmap_range m10bmc_regmap_range[] = {
> +	regmap_reg_range(M10BMC_LEGACY_BUILD_VER, M10BMC_LEGACY_BUILD_VER),
> +	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
> +	regmap_reg_range(M10BMC_FLASH_BASE, M10BMC_FLASH_END),
> +};
> +
> +static const struct regmap_access_table m10bmc_access_table = {
> +	.yes_ranges	= m10bmc_regmap_range,
> +	.n_yes_ranges	= ARRAY_SIZE(m10bmc_regmap_range),
> +};
> +
>  static struct regmap_config intel_m10bmc_regmap_config = {
>  	.reg_bits = 32,
>  	.val_bits = 32,
>  	.reg_stride = 4,
> +	.wr_table = &m10bmc_access_table,
> +	.rd_table = &m10bmc_access_table,
>  	.max_register = M10BMC_MEM_END,
>  };
>  
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index 99f44b1..dc2e858 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -11,7 +11,10 @@
>  
>  #define M10BMC_LEGACY_BUILD_VER		0x300468
>  #define M10BMC_SYS_BASE			0x300800
> -#define M10BMC_MEM_END			0x1fffffff
> +#define M10BMC_SYS_END			0x300fff
> +#define M10BMC_FLASH_BASE		0x10000000
> +#define M10BMC_FLASH_END		0x1fffffff
> +#define M10BMC_MEM_END			M10BMC_FLASH_END
>  
>  /* Register offset of system registers */
>  #define NIOS2_FW_VERSION		0x0

