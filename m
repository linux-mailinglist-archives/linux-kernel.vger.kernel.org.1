Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FE92D9A16
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438183AbgLNOhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406215AbgLNOhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:37:17 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92702C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:36:36 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id v14so13924164wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8/m/yG9nmWATf2pwpEbnHeaYaYLTTFSZowBrAhqsvOw=;
        b=NDcqoZd96wzFTaRwe+9H+XLXhCCJcYOv5EVsUhYk8m1j/nS/oVvP7qz4XCpnp4qD41
         i7DlLOUDaoOzBc6o96g2UfD9MjlfuJJUHNAKzjO2xhe/Odg/q7Aj41nKXQmISvvUKny5
         FWc/R+K1Jx/91m6Uxadrnjg6pitrNqb3/rwH+o7d7YST26CoJRSjiTS128/ZCGfl5ri2
         a+YbW0NOvF9bvKzw/d+gBhaOrCX+VwjogxOc+VHEhSvRY6M4yiPIaXrJfAK384VNSuA+
         CTB38q3FNFLC47BbxhAJCQHXre9jd65GZHKhv+DwMJ4tOaJRsbdd+u3umwxmgZQrhOqM
         p5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8/m/yG9nmWATf2pwpEbnHeaYaYLTTFSZowBrAhqsvOw=;
        b=V6jXPjiz5nKawTU10vyAsKqbrcNteFIhFNo2F4CZ+qTxsEEAyXEFN1UZiubn/r9Fyx
         AZRvhgtEEuQBND1OGebh9umQC7p0i6M6U1CMzGnDjR05YkEqaKYGVvcwiVgxW1bA3oHv
         NgKOoxpZiAyMiujsIv9k72T01mWL3aqIdUONnlC60X3uBmmEnCxRQ7fPoniaNkLMciOA
         TJ/cmPJHWyOlgttdlp+nqDSilrdwxPsZmEpH9rUwJqcfV7MjxHqaZU1aanZjl23DJYzb
         /1PO0ImtefyJPnrYHRL0xacq6cBlgPxP6dGw92TS+mDGdXAQH8RPhGxpoZ+0OHY/DsNO
         gIsA==
X-Gm-Message-State: AOAM530yBdYfqRiJtKEd7E5av4evOmQT5JQr9kohZm/zs5zbxxqV5+ut
        pMXsi2iVIEQwxDuvIqrdfxHgCw==
X-Google-Smtp-Source: ABdhPJwu+cElapZXFY4A8uSyJOR+TrTmuMMBMIKgd17hiIKGGfvZB23aZNn8UqcZ7iK9v1o9eV2+wA==
X-Received: by 2002:a1c:4843:: with SMTP id v64mr28276897wma.186.1607956595296;
        Mon, 14 Dec 2020 06:36:35 -0800 (PST)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id w189sm19701366wmg.31.2020.12.14.06.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 06:36:34 -0800 (PST)
Date:   Mon, 14 Dec 2020 14:36:32 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] backlight: sky81452-backlight: convert comma to
 semicolon
Message-ID: <20201214143632.oiqmvpkai7kurc2d@holly.lan>
References: <20201214133458.3729-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214133458.3729-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 09:34:58PM +0800, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Weird! I guess it was harmless but still seriously weird ;-)

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Thanks!


> ---
>  drivers/video/backlight/sky81452-backlight.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
> index 8268ac43d54f..c95e0de7f4e7 100644
> --- a/drivers/video/backlight/sky81452-backlight.c
> +++ b/drivers/video/backlight/sky81452-backlight.c
> @@ -291,7 +291,7 @@ static int sky81452_bl_probe(struct platform_device *pdev)
>  	}
>  
>  	memset(&props, 0, sizeof(props));
> -	props.max_brightness = SKY81452_MAX_BRIGHTNESS,
> +	props.max_brightness = SKY81452_MAX_BRIGHTNESS;
>  	name = pdata->name ? pdata->name : SKY81452_DEFAULT_NAME;
>  	bd = devm_backlight_device_register(dev, name, dev, regmap,
>  						&sky81452_bl_ops, &props);
> -- 
> 2.22.0
> 
