Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27482B130E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgKMAMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgKMAMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:12:52 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EE2C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:12:51 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id w24so7022640wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5aQjoHmKrLDA7704pKLy9Q0aTKPXPjODcZdmkkFaAvM=;
        b=a3g8ssQ0AnZoCd/JTaE9Zur8XHCobId19WHZqBZ9OMzRvt0/2DWgwUGv4tIAYyA9ti
         NTKWqXcty0BqPatWH4ydgNSlYEfib+xVdMhJarL7bhnykWoKfFJJb8yiHAj1X5m8lb2f
         owZczQKIpJtxzDVx2PBtu93q39CfsSRQOlk2uYeFUhg66C4QhqUUCZ2hzU6VuuQkd5QX
         w6yaLJItUN4m2PZRNeqqN0B5AG9dm1upZsdvjochKSzR2RFsqc2591uPSb/JrGvVYXtd
         Qe5oS0H2xgfHUDs/HqK7+9HFeJq3AVWdVwrwfGYUWrgHki6ke5DRH7Wv5c3fY8j51Eoc
         4Qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5aQjoHmKrLDA7704pKLy9Q0aTKPXPjODcZdmkkFaAvM=;
        b=BvHzl+a5l4Go9GgDksaGCwBN1Wa8Tgb7GtM3zwQ7QwK6rn1Ama/cJRyTIuzI8HWCJc
         Cx/aal9gHX6pEjX8iNo6imuZSU193dzYA5fIfFqmkQn+WAsEXdFOkRA2gYGiJy2X7H4c
         Ek7qZoZbhwqaftAQ+a970U9sL5jt7GEiH/Wn3WhBp+kQmkCqqgDMSDhGmu/zOdNclkkP
         bRPokOre0JkLtg2mB7wKi7zpSh8RBzreLWp0yRVqQJ2DiqLN+JSS/8U2FPHDPUmnEJod
         hbuATXOjtor0W68oeYGpmr5aOxf47bAIrh2IAI6AzGODnEsm8MQFgQZHWJdy7BYx0BP9
         tSYw==
X-Gm-Message-State: AOAM533xHah3dxqu0eDHc7qH3/sVOFTHaWb5Gtr3qoj5zu66AVCjl46G
        jjKTQt6mzO5tUaBCV+wt1MNhmMaYIeo6QmVB
X-Google-Smtp-Source: ABdhPJycOkoPoA49v+6wIv01mpIMZOe0z2s1IdIKn9+jEMRFcTEdNcyZ60fn59VzPo5JZPEvWCQN9g==
X-Received: by 2002:a1c:4ca:: with SMTP id 193mr326206wme.137.1605226370583;
        Thu, 12 Nov 2020 16:12:50 -0800 (PST)
Received: from ?IPv6:2001:861:3a84:7260:5d3c:83d5:8524:33ca? ([2001:861:3a84:7260:5d3c:83d5:8524:33ca])
        by smtp.gmail.com with ESMTPSA id v8sm8046333wmg.28.2020.11.12.16.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 16:12:49 -0800 (PST)
Subject: Re: [PATCH v2] reset: make shared pulsed reset controls
 re-triggerable
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jim Quinlan <james.quinlan@broadcom.com>
References: <20201112230043.28987-1-aouledameur@baylibre.com>
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Message-ID: <96bce8ff-9601-e6cc-94b1-abd9583e19ae@baylibre.com>
Date:   Fri, 13 Nov 2020 01:12:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201112230043.28987-1-aouledameur@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please find in this patchset [0] a use case of the reset_control_rearm() call
on some of meson usb drivers:


[0] https://lore.kernel.org/lkml/20201113000508.14702-1-aouledameur@baylibre.com/

On 13/11/2020 00:00, Amjad Ouled-Ameur wrote:

> The current reset framework API does not allow to release what is done by
> reset_control_reset(), IOW decrement triggered_count. Add the new
> reset_control_rearm() call to do so.
>
> When reset_control_reset() has been called once, the counter
> triggered_count, in the reset framework, is incremented i.e the resource
> under the reset is in-use and the reset should not be done again.
> reset_control_rearm() would be the way to state that the resource is
> no longer used and, that from the caller's perspective, the reset can be
> fired again if necessary.
>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reported-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
> Change since v1: [0]
> * Renamed the new call from reset_control_(array_)resettable to
> reset_control_(array_)rearm
> * Open-coded reset_control_array_rearm to check for errors before
> decrementing triggered_count because we cannot roll back in case an
> error occurs while decrementing one of the rstc.
> * Reworded the new call's description.
>
> [0] https://lore.kernel.org/lkml/20201001132758.12280-1-aouledameur@baylibre.com
>
>   drivers/reset/core.c  | 73 +++++++++++++++++++++++++++++++++++++++++++
>   include/linux/reset.h |  1 +
>   2 files changed, 74 insertions(+)
>
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index a2df88e90011..34e89aa0fb5e 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -208,6 +208,39 @@ static int reset_control_array_reset(struct reset_control_array *resets)
>   	return 0;
>   }
>   
> +static int reset_control_array_rearm(struct reset_control_array *resets)
> +{
> +	struct reset_control *rstc;
> +	int i;
> +
> +	for (i = 0; i < resets->num_rstcs; i++) {
> +		rstc = resets->rstc[i];
> +
> +		if (!rstc)
> +			continue;
> +
> +		if (WARN_ON(IS_ERR(rstc)))
> +			return -EINVAL;
> +
> +		if (rstc->shared) {
> +			if (WARN_ON(atomic_read(&rstc->deassert_count) != 0))
> +				return -EINVAL;
> +		} else {
> +			if (!rstc->acquired)
> +				return -EPERM;
> +		}
> +	}
> +
> +	for (i = 0; i < resets->num_rstcs; i++) {
> +		rstc = resets->rstc[i];
> +
> +		if (rstc && rstc->shared)
> +			WARN_ON(atomic_dec_return(&rstc->triggered_count) < 0);
> +	}
> +
> +	return 0;
> +}
> +
>   static int reset_control_array_assert(struct reset_control_array *resets)
>   {
>   	int ret, i;
> @@ -325,6 +358,46 @@ int reset_control_reset(struct reset_control *rstc)
>   }
>   EXPORT_SYMBOL_GPL(reset_control_reset);
>   
> +/**
> + * reset_control_rearm - allow shared reset line to be re-triggered"
> + * @rstc: reset controller
> + *
> + * On a shared reset line the actual reset pulse is only triggered once for the
> + * lifetime of the reset_control instance, except if this call is used.
> + *
> + * Calls to this function must be balanced with calls to reset_control_reset,
> + * a warning is thrown in case triggered_count ever dips below 0.
> + *
> + * Consumers must not use reset_control_(de)assert on shared reset lines when
> + * reset_control_reset or reset_control_rearm have been used.
> + *
> + * If rstc is NULL the function will just return 0.
> + */
> +int reset_control_rearm(struct reset_control *rstc)
> +{
> +	if (!rstc)
> +		return 0;
> +
> +	if (WARN_ON(IS_ERR(rstc)))
> +		return -EINVAL;
> +
> +	if (reset_control_is_array(rstc))
> +		return reset_control_array_rearm(rstc_to_array(rstc));
> +
> +	if (rstc->shared) {
> +		if (WARN_ON(atomic_read(&rstc->deassert_count) != 0))
> +			return -EINVAL;
> +
> +		WARN_ON(atomic_dec_return(&rstc->triggered_count) < 0);
> +	} else {
> +		if (!rstc->acquired)
> +			return -EPERM;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(reset_control_rearm);
> +
>   /**
>    * reset_control_assert - asserts the reset line
>    * @rstc: reset controller
> diff --git a/include/linux/reset.h b/include/linux/reset.h
> index 05aa9f440f48..439fec7112a9 100644
> --- a/include/linux/reset.h
> +++ b/include/linux/reset.h
> @@ -13,6 +13,7 @@ struct reset_control;
>   #ifdef CONFIG_RESET_CONTROLLER
>   
>   int reset_control_reset(struct reset_control *rstc);
> +int reset_control_rearm(struct reset_control *rstc);
>   int reset_control_assert(struct reset_control *rstc);
>   int reset_control_deassert(struct reset_control *rstc);
>   int reset_control_status(struct reset_control *rstc);

