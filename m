Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABBC2E9396
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 11:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbhADKr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 05:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbhADKrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:47:25 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CA5C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 02:46:44 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id c5so31673001wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 02:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5cnKwGKMAW2uD7Mf320R7/SnXF3WX1LG6Qh3O1drZ/Q=;
        b=hmCCGppBxS67+7BXqQG7Lw+tVho3R1OcBqp3hz5toxuy0QJeDKHzxhOHn/OPB9LuaB
         TyRcrHvXbhdEl/+7VTeQDe1BX1fDZqTBfmYqeTSRNKfY8Iel4EnMnLHyDDkN8fNQTZtv
         qoS7n7uPI/VlCfls/vUHdmk8+niCQIE8MyIRw9AQTPN4XlxsFdX3SEVmmoWUZ6B2JsXX
         oPUpO1OI7PdcZphmKDlODxsyJmOXS6kmQx8Un4U4NBdwvlb7DtInP/gWNfpmZ3GTCCyu
         yR1UNiR2nUC8UDLCULzVX+XQX/zN9uGPjEAuBM07HcHQbZ/gd9AtQbYGnTUXxCHq7nqR
         zvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5cnKwGKMAW2uD7Mf320R7/SnXF3WX1LG6Qh3O1drZ/Q=;
        b=t5yJIGKvYIuF90HjNBIF+pPVQAnwsATgWd7su0PAEBVgqG1b5h/VLl9sjiev2kkg9Y
         DNcvTC6LL1pVsJRXeoLAhrAc82AckH7KrAaMqlBq6Onlx1E6wJqYZzUB4GGuBbqGqYmt
         zdzDHhHQUUaJI6wWxl1q8MpozQONBWILUp7at1qWpZbWcNtR5ik3VwFKWeCILH99cmvr
         1YR2O33EoSgmfXeyNVfK75T8qGRn0zYUQBqHVXW1u0S/OT5t/KHHEWg606hhO4V0zT+z
         rDgXj+wLMfARhlMTvgcPx1RpJ4OBLycaKiX2GVL82GozNpku/GP/MZ/Ul7AUt527xxjQ
         gjuA==
X-Gm-Message-State: AOAM5337Fp+i1OjakULq4tNxzdqqtQeg21F2k/SYTPj51hzcW8SK+bJd
        ehH02uKarTGVJTSHxabXmP18Uw==
X-Google-Smtp-Source: ABdhPJxLg9y2ii+HtYdwO5mHHkoRyLpzpRo5RBXbyYGGjZWmmsW9YQQWIhm9fV2y95zhm1wlI5iR0Q==
X-Received: by 2002:adf:e452:: with SMTP id t18mr76358986wrm.177.1609757203325;
        Mon, 04 Jan 2021 02:46:43 -0800 (PST)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o23sm95805633wro.57.2021.01.04.02.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 02:46:42 -0800 (PST)
Date:   Mon, 4 Jan 2021 10:46:40 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] video: backlight: use DEFINE_MUTEX() for mutex
 lock
Message-ID: <20210104104640.2fe5lmi6hljb6rgr@holly.lan>
References: <20201224132601.31791-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224132601.31791-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 09:26:01PM +0800, Zheng Yongjun wrote:
> mutex lock can be initialized automatically with DEFINE_MUTEX()
> rather than explicitly calling mutex_init().
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/video/backlight/backlight.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 537fe1b376ad..d7a09c422547 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -64,7 +64,7 @@
>   */
>  
>  static struct list_head backlight_dev_list;
> -static struct mutex backlight_dev_list_mutex;
> +static DEFINE_MUTEX(backlight_dev_list_mutex);
>  static struct blocking_notifier_head backlight_notifier;

Why do we want to convert one of these variables to use a
static initializers but leave the other two unchanged? Surely they
should all be changed.


Daniel.


>  
>  static const char *const backlight_types[] = {
> @@ -757,7 +757,6 @@ static int __init backlight_class_init(void)
>  	backlight_class->dev_groups = bl_device_groups;
>  	backlight_class->pm = &backlight_class_dev_pm_ops;
>  	INIT_LIST_HEAD(&backlight_dev_list);
> -	mutex_init(&backlight_dev_list_mutex);
>  	BLOCKING_INIT_NOTIFIER_HEAD(&backlight_notifier);
>  
>  	return 0;
> -- 
> 2.22.0
> 
