Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEBB2FD45B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 16:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388026AbhATPlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 10:41:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23429 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390789AbhATPe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611156779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VIIe/BOEzrkNtQ9FvxVKg1uz2WE+ks6+SZjt56c4bzI=;
        b=KiQgzJSLVXWpnTQxnC3XNNYX/HxrngjJiTSo1yGVcnxTfFRrXEpFvGVx5gx8y6+pN0pWmw
        otW0EaCIjLh7Doww3JcpxmzhuLDbRHbdJ8AVAXFFr7bJJmzFIQVmdSSZneYFHy+cFyBL4a
        u8CkBSNZHpHy+AXGLxL490cfF8mE9Ko=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-ex0QSFyLMCmevvvdYJnWHA-1; Wed, 20 Jan 2021 10:32:56 -0500
X-MC-Unique: ex0QSFyLMCmevvvdYJnWHA-1
Received: by mail-qv1-f70.google.com with SMTP id t16so23480184qvk.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 07:32:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VIIe/BOEzrkNtQ9FvxVKg1uz2WE+ks6+SZjt56c4bzI=;
        b=JupZVmXbZq+tN87uXHwTnGlRfGYibGtfZXRoJuXZVqK3jcX44/d6RF3f+2QpNBVUlQ
         Phho7nTit3gOxZv6SO40b9pKiCA9toJGLGp6Wf+xggkM/VBZBQ+4O6XZZqt34h0oAvxe
         mlTtXLZvphTcCJVTm6F7XeR0tzULx8oHqrlM0I6KMgXIJAUgStePMGU0astT05+vs2d7
         q4qPpX0ZG3xkQgZLglyJP4kFLh9uMI6tZkDC9j1Hykmn8SxWOGCrlPDxe+vr0j4DMg1q
         pjzDHykpkcd2WdP5XHSvU9h2TduqQ4vbFe+y784JPapgAlyQN8BMUbPB2hMyJ9N5kJIG
         NGtw==
X-Gm-Message-State: AOAM532OC7mtzIO/UUwS0F0SlUoRnXhghezUN7Md0Mp5YASemmqz/SaC
        B39AHU3YcBzd/lf9uKreMpKA5YnkaUm6CYx2FSPaPWHkfytN9bXJM6cT6uRrV1rbdTv6jM5TK/8
        /Y0TnNSDuJGibo/l6hfQgGotj
X-Received: by 2002:ac8:1184:: with SMTP id d4mr9262507qtj.103.1611156775720;
        Wed, 20 Jan 2021 07:32:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoJMVcw0kgKfoBHON41TugeAdHodSIw7rdV066id7cQyw4udZvkz9ZwM/G8cJ6afm2Hvdkmw==
X-Received: by 2002:ac8:1184:: with SMTP id d4mr9262488qtj.103.1611156775475;
        Wed, 20 Jan 2021 07:32:55 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k187sm1557092qkc.74.2021.01.20.07.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 07:32:54 -0800 (PST)
Subject: Re: [PATCH 2/2] mfd: intel-m10-bmc: add access table configuration to
 the regmap
To:     Xu Yilun <yilun.xu@intel.com>, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
References: <1611110081-10056-1-git-send-email-yilun.xu@intel.com>
 <1611110081-10056-2-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0f17f8a7-d2f5-e88e-b3dc-0a75ea7f5ada@redhat.com>
Date:   Wed, 20 Jan 2021 07:32:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1611110081-10056-2-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/19/21 6:34 PM, Xu Yilun wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> This patch adds access tables to the MAX 10 BMC regmap. This prevents
> the host from accessing the unwanted I/O space. It also filters out the
> invalid outputs when reading the regmap debugfs interface.
>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
>  drivers/mfd/intel-m10-bmc.c       | 14 ++++++++++++++
>  include/linux/mfd/intel-m10-bmc.h |  5 ++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> index b84579b..0ae3053 100644
> --- a/drivers/mfd/intel-m10-bmc.c
> +++ b/drivers/mfd/intel-m10-bmc.c
> @@ -23,10 +23,24 @@ static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
>  	{ .name = "n3000bmc-secure" },
>  };
>  
> +static const struct regmap_range m10bmc_regmap_range[] = {
> +	regmap_reg_range(M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER,
> +			 M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER),

If this is the only value in the legacy map to be accessed, could it have its own #define ?

Something like

#define M10BMC_LEGACY_BUILD_VER ?

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

The legacy build ver should only be read, so shouldn't these tables be different ?

Tom

>  	.max_register = M10BMC_MEM_END,
>  };
>  
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index 06da62c..4ba88ed 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -11,7 +11,10 @@
>  
>  #define M10BMC_LEGACY_SYS_BASE		0x300400
>  #define M10BMC_SYS_BASE			0x300800
> -#define M10BMC_MEM_END			0x1fffffff
> +#define M10BMC_SYS_END			0x300fff
> +#define M10BMC_FLASH_BASE		0x10000000
> +#define M10BMC_FLASH_END		0x1fffffff
> +#define M10BMC_MEM_END			M10BMC_FLASH_END
>  
>  /* Register offset of system registers */
>  #define NIOS2_FW_VERSION		0x0

