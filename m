Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E532A9087
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgKFHkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKFHkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:40:13 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D70EC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 23:40:13 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id b8so268979wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 23:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FBCTJlC6IgyFxCdhJWM7lRLLPX+oBdWzGjC12/FTDB0=;
        b=pP0Aad/y+VvQMppvdJTxmqkGA4n7WEkLPyt0/SQqsohWMZ0WCGFRVCVmubPTCNXu0i
         5KNjN8/SSrCK8qBoc1YJIGSd+hKEK6wVFBW+XP+rVqlJ5PQDO3VGYGEE14Dq+VmLb8IX
         RyVc0DaKILVBsdfK3BftUj2y6HAmcyB5pSXulB7gxP202bNkGcLU33VBDUTTDcMCfGFY
         0yiP2IcVCo+9spH4njz0g/Eg34mgcg76IxFAkbjwrtcJWF9o2stQ95KvJ7bWDY1xDe+4
         7raWX71MTb9znWi2191NtF5tnkDxDYtyDBXD3L27pOvWNLR1g95rDF57YCSbEpzpxktU
         m6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FBCTJlC6IgyFxCdhJWM7lRLLPX+oBdWzGjC12/FTDB0=;
        b=qYPraqx0hV7DR/RtPNhxCtVL30+QfYVkBuVDYmdEhQBdzqy+XyKL5kutr9xnVkBabm
         hpmd7SAj3HU4JhGu7T8LVnnE+I4ZURJi7G4doiAEFkZNIhzGG3+T3QmeN8pQG5WpkbWP
         JnsEzD+5YQGJ/ZZMrY/VLJG1+AV6wq6Uy4krYwbrqz83saoxaOpjAWEMyEVG+UfbziT1
         /tjFoZcl4Oer4qR3++mA8mkV2wO3Kcq86PK6uGdAAwRiXB5YqeSKVq87lIl7mUUqDI1Y
         M4KOXrz0ugkzPacgr5IeE1lpRmVRchKdINES4YshtWPkof3qWN2WDebxwNl17D5nPP9/
         kRgA==
X-Gm-Message-State: AOAM533ZvwI1Qx2tyHma3FV6/40yzJtJHxgl98Fh34ZI/IdFQQBmSBhi
        iokrfAgkoVyIc71nrVqIQ6U=
X-Google-Smtp-Source: ABdhPJxA7N7QLsOuq5CNYGAsnhTp/0gYkEQ50Az1rX2NwdZ2BSd2VBcyl2AEiH8Wu9NFtEaAddlinA==
X-Received: by 2002:adf:face:: with SMTP id a14mr1144899wrs.6.1604648411971;
        Thu, 05 Nov 2020 23:40:11 -0800 (PST)
Received: from ziggy.stardust ([213.195.112.112])
        by smtp.gmail.com with ESMTPSA id v6sm863384wrb.53.2020.11.05.23.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 23:40:11 -0800 (PST)
Subject: Re: [PATCH] mfd: syscon: Add
 syscon_regmap_lookup_by_phandle_optional() function.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>
References: <20201027211154.3371691-1-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <d6e29e8b-9d5e-455b-24dc-7ec016c9b6b2@gmail.com>
Date:   Fri, 6 Nov 2020 08:40:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201027211154.3371691-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/10/2020 22:11, Enric Balletbo i Serra wrote:
> This adds syscon_regmap_lookup_by_phandle_optional() function to get an
> optional regmap.
> 
> It behaves the same as syscon_regmap_lookup_by_phandle() except where
> there is no regmap phandle. In this case, instead of returning -ENODEV,
> the function returns NULL. This makes error checking simpler when the
> regmap phandle is optional.
> 
> Suggested-by: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> 
>   drivers/mfd/syscon.c       | 13 +++++++++++++
>   include/linux/mfd/syscon.h | 11 +++++++++++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index ca465794ea9c..60c5c2b194cc 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -255,6 +255,19 @@ struct regmap *syscon_regmap_lookup_by_phandle_args(struct device_node *np,
>   }
>   EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle_args);
>   
> +struct regmap *syscon_regmap_lookup_by_phandle_optional(struct device_node *np,
> +					const char *property)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = syscon_regmap_lookup_by_phandle(np, property);
> +	if (IS_ERR(regmap) && PTR_ERR(regmap) == -ENODEV)
> +		return NULL;
> +
> +	return regmap;
> +}
> +EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle_optional);
> +
>   static int syscon_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
> index 7f20e9b502a5..a1fe8aedced2 100644
> --- a/include/linux/mfd/syscon.h
> +++ b/include/linux/mfd/syscon.h
> @@ -28,6 +28,9 @@ extern struct regmap *syscon_regmap_lookup_by_phandle_args(
>   					const char *property,
>   					int arg_count,
>   					unsigned int *out_args);
> +extern struct regmap *syscon_regmap_lookup_by_phandle_optional(
> +					struct device_node *np,
> +					const char *property);
>   #else
>   static inline struct regmap *device_node_to_regmap(struct device_node *np)
>   {
> @@ -59,6 +62,14 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle_args(
>   {
>   	return ERR_PTR(-ENOTSUPP);
>   }
> +
> +static inline struct regmap *syscon_regmap_lookup_by_phandle_optional(
> +					struct device_node *np,
> +					const char *property)
> +{
> +	return ERR_PTR(-ENOTSUPP);
> +}
> +
>   #endif
>   
>   #endif /* __LINUX_MFD_SYSCON_H__ */
> 
