Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F292304209
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406226AbhAZPQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:16:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59411 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391030AbhAZPAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:00:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611673126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=okIvk1yUHM3ghAKbiDcTVr1biqV692Nex0+1fcP9uyA=;
        b=LhUSBOyEocIs6y1SLeDlLnx8K586Gb79nU0yILb1fi7TKiqym1uhnYJhJpK+y5cSaMYlRA
        QOvCMT/WbkoadABpFZnFrVJrDRZVhuVwlchuCXi18z+HfvRUW5kEFmE44IwxPaNGZQU2jp
        lTKigwKwOgEDW4VAcluK6gqQaDIK+5M=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-1YVEHjPhN9OabLCknXsW7w-1; Tue, 26 Jan 2021 09:58:42 -0500
X-MC-Unique: 1YVEHjPhN9OabLCknXsW7w-1
Received: by mail-qt1-f200.google.com with SMTP id e9so9372852qtq.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=okIvk1yUHM3ghAKbiDcTVr1biqV692Nex0+1fcP9uyA=;
        b=qGOWchHri+jpP9KJ6l9zPParVvgi/Vomadc0TKV3WEU90/k2ToWYzWnhhSukin/iUt
         XVOaGlj/0pPYa1kPlV21CXIVCsU1JBUiMDw0NxITJmrwJlPoyjXYd8feVP5BSx4Wr/+H
         FFMdir5bREB+1OO0GwUmgvlKscHRFVG5J2bpIHjORWXVjK3AIUXa0sW86gQQqdKfPQ6t
         82F5JDSdg1Lzk/shfyhsgVml9IQOwV4qUtij9Rq0beJhhU4OgjGkZJCq2iYYvyj+e8z5
         jsg9UQUNv1vIDPjKDXWueGo61ryEyhgkuFUgcfxIAPmqBT/CcS5fo8S4ArJIq34GqGHY
         m9pQ==
X-Gm-Message-State: AOAM5335PGfvxM5pf8Q9sBKHhO046+e3+E69BllC8WroRdg6hNNSIn+X
        /zH5SNHav4qKdUhQhn8VaxqD79IQZr+t28N5csiRNgsIlJmbcZfardRJSgvulDSEo/0+0jEu+87
        xuJ585EtykUQlWdKWUTkmP3OA
X-Received: by 2002:a37:7003:: with SMTP id l3mr6074616qkc.467.1611673122480;
        Tue, 26 Jan 2021 06:58:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxf0OrXTo6I0HZ8tt8zacXtWeJldDE5lGxzJfva/sqqcRi21TrWHB6uP7Xhk3gJ008sacu6Hw==
X-Received: by 2002:a37:7003:: with SMTP id l3mr6074578qkc.467.1611673122147;
        Tue, 26 Jan 2021 06:58:42 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v18sm2833857qkv.62.2021.01.26.06.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 06:58:41 -0800 (PST)
Subject: Re: [PATCH v2 2/4] mfd: intel-m10-bmc: Simplify the legacy version
 reg definition
To:     Xu Yilun <yilun.xu@intel.com>, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
References: <1611643836-7183-1-git-send-email-yilun.xu@intel.com>
 <1611643836-7183-3-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <8b101def-1969-97ab-0c56-732e9159b4e7@redhat.com>
Date:   Tue, 26 Jan 2021 06:58:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1611643836-7183-3-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/25/21 10:50 PM, Xu Yilun wrote:
> The version register is the only one in the legacy I/O space to be
> accessed, so it is not necessary to define the legacy base & version
> register offset. A direct definition of the legacy version register
> address would be fine.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
>  drivers/mfd/intel-m10-bmc.c       | 12 +++++-------
>  include/linux/mfd/intel-m10-bmc.h |  2 +-
>  2 files changed, 6 insertions(+), 8 deletions(-)

Thanks for adding M10BMC_LEGACY_BUILD_VER

Reviewed-by: Tom Rix <trix@redhat.com>

> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> index b84579b..aad86f0 100644
> --- a/drivers/mfd/intel-m10-bmc.c
> +++ b/drivers/mfd/intel-m10-bmc.c
> @@ -74,16 +74,14 @@ static int check_m10bmc_version(struct intel_m10bmc *ddata)
>  
>  	/*
>  	 * This check is to filter out the very old legacy BMC versions,
> -	 * M10BMC_LEGACY_SYS_BASE is the offset to this old block of mmio
> -	 * registers. In the old BMC chips, the BMC version info is stored
> -	 * in this old version register (M10BMC_LEGACY_SYS_BASE +
> -	 * M10BMC_BUILD_VER), so its read out value would have not been
> -	 * LEGACY_INVALID (0xffffffff). But in new BMC chips that the
> +	 * 0x300400 is the offset to this old block of mmio registers. In the
> +	 * old BMC chips, the BMC version info is stored in this old version
> +	 * register (0x300400 + 0x68), so its read out value would have not
> +	 * been LEGACY_INVALID (0xffffffff). But in new BMC chips that the
>  	 * driver supports, the value of this register should be
>  	 * LEGACY_INVALID.
>  	 */
> -	ret = m10bmc_raw_read(ddata,
> -			      M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER, &v);
> +	ret = m10bmc_raw_read(ddata, M10BMC_LEGACY_BUILD_VER, &v);
>  	if (ret)
>  		return -ENODEV;
>  
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index 06da62c..99f44b1 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -9,7 +9,7 @@
>  
>  #include <linux/regmap.h>
>  
> -#define M10BMC_LEGACY_SYS_BASE		0x300400
> +#define M10BMC_LEGACY_BUILD_VER		0x300468
>  #define M10BMC_SYS_BASE			0x300800
>  #define M10BMC_MEM_END			0x1fffffff
>  

