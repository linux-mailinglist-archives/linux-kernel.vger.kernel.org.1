Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9490B2E77B1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 11:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgL3KNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 05:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgL3KNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 05:13:44 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC7EC06179F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 02:13:04 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id w5so16984642wrm.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 02:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eVxSM5i76pIapJWPjbKuxmCHiHfbsJJSSitypQwb4yc=;
        b=Z5tL7BngstmdhY1rPFAHXODcLgsAk/5fHp4TLoBVTorrlAsCpFDCEqxGLx32ouhkg9
         Ggw7ScwfjueLWdeIsUyI2MTKUSUsrNN5WKDUp+Ck28UulmNoFXAyBt/jvp1cyJtmAksR
         xxKYBBUHHDsDfIuInPhfYA3p3ZI0Wu92xFeKlFLj+trUCCOnqHaSuPLuVk3GYN5yTWI2
         HxEJvbXDjF4RXgCt3QhENSmwRdv30vYt0SWrZm9hefk4bdhG43YPInIflKxK0fu2aXmH
         wy9cSVU5CqWIWcMlYnYrWJ3KZz9sKp5ElSHRTHAkhSTiryl6x2eN8FVSsy8F9umWCxLi
         hNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eVxSM5i76pIapJWPjbKuxmCHiHfbsJJSSitypQwb4yc=;
        b=gMI332b8ENhfKjs636TXToptnJ+7EHgnsEtb7AboFaDTNx8rJG1vRxd+kRgyqz+1Ig
         h6SPwYY+GXn9PuRXpZsCslmRvinPNTZMyGC1PvqhFoEJCpHXaQkUPuGTaltX1v26keXB
         DMCMDimUlnpzutL7iK2MxA8sBkV9AQoWZZgPDabONgy0rNVX8rb8nbXMheXk5PV8acAA
         ZsumB0bmBo+w1eWjshpMzAol0SnV57IXSlq4NPZ15KAJwYTzbAB3h+/Lh8iwEvdLiYmb
         orIT2HUEIQ508lEp/Q2SCm3XV/0ito2WrpAYNjodzqzIwKsk09nma+wBuWjefadg9v83
         N8dg==
X-Gm-Message-State: AOAM531gUT/+R0+w5SH3LTBKR3NWamLL9wijExj/cPb1Iq4+hxh1yDqP
        UA3jlqYJ3I9//fd5HQnDnLI=
X-Google-Smtp-Source: ABdhPJxefUIxqGz7wVH7Kss44qsC7ce7uVq5I2Yjroj/8zVSQjCvyEC/K5S2YffS44LycDCQ3qd7YA==
X-Received: by 2002:a5d:6983:: with SMTP id g3mr23791613wru.168.1609323183162;
        Wed, 30 Dec 2020 02:13:03 -0800 (PST)
Received: from arch-thunder.localdomain (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id x18sm74818507wrg.55.2020.12.30.02.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 02:13:02 -0800 (PST)
Date:   Wed, 30 Dec 2020 10:13:00 +0000
From:   Rui Miguel Silva <rmfrfs@gmail.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] staging: greybus: light: Use kzalloc for
 allocating only one thing
Message-ID: <20201230101300.sqouqv3ulez6mzmy@arch-thunder.localdomain>
References: <20201230013706.28698-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230013706.28698-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yongjun,
many thanks for your patch.

On Wed, Dec 30, 2020 at 09:37:06AM +0800, Zheng Yongjun wrote:
> Use kzalloc rather than kcalloc(1,...)
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> @@
> 
> - kcalloc(1,
> + kzalloc(
>           ...)
> // </smpl>
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Like Alex said, LGTM also.

Reviewed-by: Rui Miguel Silva <rmfrfs@gmail.com>

------
Cheers,
     Rui
> ---
>  drivers/staging/greybus/light.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
> index d2672b65c3f4..87d36948c610 100644
> --- a/drivers/staging/greybus/light.c
> +++ b/drivers/staging/greybus/light.c
> @@ -290,8 +290,7 @@ static int channel_attr_groups_set(struct gb_channel *channel,
>  	channel->attrs = kcalloc(size + 1, sizeof(*channel->attrs), GFP_KERNEL);
>  	if (!channel->attrs)
>  		return -ENOMEM;
> -	channel->attr_group = kcalloc(1, sizeof(*channel->attr_group),
> -				      GFP_KERNEL);
> +	channel->attr_group = kzalloc(sizeof(*channel->attr_group), GFP_KERNEL);
>  	if (!channel->attr_group)
>  		return -ENOMEM;
>  	channel->attr_groups = kcalloc(2, sizeof(*channel->attr_groups),
> -- 
> 2.22.0
> 
