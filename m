Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC1C2D27C6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgLHJfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:35:08 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47020 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbgLHJfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:35:07 -0500
Received: by mail-lj1-f196.google.com with SMTP id f24so18311081ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 01:34:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n46FeDvrQgslntB/QvyVhRFq+v4FH13erjugPCMtV1w=;
        b=fXx4Y53DkBhBO0xIwVRAmR32ASJocd0agEanjnHZ1OO9DjlIrjr1xGPHnM0WVoODYk
         pfcaLP1Qhe7rDeG+t1uibXANFb/QQH/H637Yoa+TtA+zv+oY/TYlGd04dAlYVFlNiuwm
         ANU1r0EQovXQUvubU5ymsZv1w4LR9foMY4rmGW9IZ9WNFzBvGPR67SGPAr4jSOUOaJBx
         M1u1gNCrCE0S7bkAd4N6XHr9BoPu+5VYq3Gs4SmsLoecFyqcEHIgoNVQRqGEDc0t1IXm
         s6bB8basSbLZRWT3nHi1XHp1qHg9znlrI2PH2VtmKZX11zmgAYiu/MrV8BQeBqS6tJbl
         Cllg==
X-Gm-Message-State: AOAM531VAsFpDctXuJ7cbqpFxBOE0ELPB7+CNQBfwOcMHZm9/oQvFmr+
        iHyS55yRyoTju/+Og9oz774=
X-Google-Smtp-Source: ABdhPJy02FhKhfSnq0GfVhtpL9g3uz6VqfvBEbr919u7Jtx3QetFzJxS0YPPKSyOlaXDZZGUZhCqMA==
X-Received: by 2002:a2e:7119:: with SMTP id m25mr679541ljc.229.1607420065262;
        Tue, 08 Dec 2020 01:34:25 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id g69sm739199lfd.161.2020.12.08.01.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 01:34:24 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kmZOg-0002UD-GE; Tue, 08 Dec 2020 10:35:02 +0100
Date:   Tue, 8 Dec 2020 10:35:02 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     johan@kernel.org, vaibhav.sr@gmail.com, elder@kernel.org,
        gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        aibhav.sr@gmail.com, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: audio: Fix possible leak free widgets
 in gbaudio_dapm_free_controls
Message-ID: <X89IxvbYWjuyaQDT@localhost>
References: <20201205103827.31244-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205103827.31244-1-wanghai38@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 05, 2020 at 06:38:27PM +0800, Wang Hai wrote:
> In gbaudio_dapm_free_controls(), if one of the widgets is not found, an error
> will be returned directly, which will cause the rest to be unable to be freed,
> resulting in leak.
> 
> This patch fixes the bug. If if one of them is not found, just skip and free the others.

Apart from the typo, please break your lines at 72 columns or so (not
needed for the Fixes tag).

> Fixes: 510e340efe0c ("staging: greybus: audio: Add helper APIs for dynamic audio module")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  drivers/staging/greybus/audio_helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
> index 237531ba60f3..3011b8abce38 100644
> --- a/drivers/staging/greybus/audio_helper.c
> +++ b/drivers/staging/greybus/audio_helper.c
> @@ -135,7 +135,8 @@ int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
>  		if (!w) {
>  			dev_err(dapm->dev, "%s: widget not found\n",
>  				widget->name);
> -			return -EINVAL;
> +			widget++;
> +			continue;
>  		}
>  		widget++;
>  #ifdef CONFIG_DEBUG_FS

Not sure if we can ever have the widget lookup fail, but at least this
looks consistent now.

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
