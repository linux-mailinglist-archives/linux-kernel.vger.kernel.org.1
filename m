Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DC92C82F7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgK3LO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgK3LOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:14:25 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3B1C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:13:45 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w16so9874152pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ylWqeCaojXahUBRs7tWWOFsUs6Y8SM8mpT1ztQJPZd0=;
        b=nqhj9BT9+WCVKuCz8Q2lcCFUUmolsn0nXw9i4y3ckunvZuV1abLCXaTszeMWjQM0Bq
         wzszHyudG7j/Ony1y37fPgtGPcI7tbTfZS80x1ktlFE/uuRI6uaIl7hyTv5g6iHCVonW
         YXvaA6MX2yS5rPPM8FPphL7BJQz59I8vY5AKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ylWqeCaojXahUBRs7tWWOFsUs6Y8SM8mpT1ztQJPZd0=;
        b=I2B1x5tYfeSup9vda94aMGXr76yQj+o7ICvlwswJ1zmigG5D6Nsof805QSnhKhaIqG
         40fjMHZ/MJdxdTHZPXI/UFFnkMEjzW3kDb/2TXsXE0AkG8sRZ1UMQJvEVo274QLVj4G4
         753cJ5zGT1hCq4RT2ymnr0tndQLFXPcfB3jhIV8P1dwdN/ljLVaNeGCZQ0EqCIBj3/h2
         x5BLcN2yHclbV9GesJJWwR5oWFiTI57q9DV4palTZqXKOknwm1HmBrNmJw14Lu46ZOLM
         0NVW3dpLxqLQU/RKGUlc+6ybf1cvpUB6F7xyWB4GMkDDL4AF3ZkrEqSLpF2/jq8jbt9u
         l9oA==
X-Gm-Message-State: AOAM532nT7YvaaJwX6rasyxMZGGWlkF5EXX13j3C9GFQFRayRthQ/qjS
        gyANqUJI0rLFaXEzPdJI7T0TCA==
X-Google-Smtp-Source: ABdhPJxtxKJ3Ouuac5shSBMgyDJniyLHnpSM3fINGObBbJy49hgqBs8/pwklTMJIjQlKupFLUXTDiQ==
X-Received: by 2002:a05:6a00:1389:b029:18b:2d21:2f1a with SMTP id t9-20020a056a001389b029018b2d212f1amr18263454pfg.1.1606734824573;
        Mon, 30 Nov 2020 03:13:44 -0800 (PST)
Received: from chromium.org ([2401:fa00:1:b:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id 10sm4147168pgq.93.2020.11.30.03.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 03:13:44 -0800 (PST)
Date:   Mon, 30 Nov 2020 19:13:40 +0800
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Crystal Guo <crystal.guo@mediatek.com>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, yong.liang@mediatek.com,
        stanley.chu@mediatek.com, srv_heupstream@mediatek.com,
        seiya.wang@mediatek.com, linux-kernel@vger.kernel.org,
        fan.chen@mediatek.com, linux-mediatek@lists.infradead.org,
        yingjoe.chen@mediatek.com, s-anna@ti.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [v6, 3/3] reset-controller: ti: force the write operation when
 assert or deassert
Message-ID: <20201130111340.GA3042402@chromium.org>
References: <20200930022159.5559-1-crystal.guo@mediatek.com>
 <20200930022159.5559-4-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930022159.5559-4-crystal.guo@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 10:21:59AM +0800, Crystal Guo wrote:
> Force the write operation in case the read already happens
> to return the correct value.
> 
> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> ---
>  drivers/reset/reset-ti-syscon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/reset/reset-ti-syscon.c b/drivers/reset/reset-ti-syscon.c
> index 5d1f8306cd4f..c34394f1e9e2 100644
> --- a/drivers/reset/reset-ti-syscon.c
> +++ b/drivers/reset/reset-ti-syscon.c
> @@ -97,7 +97,7 @@ static int ti_syscon_reset_assert(struct reset_controller_dev *rcdev,
>  	mask = BIT(control->assert_bit);
>  	value = (control->flags & ASSERT_SET) ? mask : 0x0;
>  
> -	return regmap_update_bits(data->regmap, control->assert_offset, mask, value);
> +	return regmap_write_bits(data->regmap, control->assert_offset, mask, value);
>  }

I don't think there are no reset controllers with cached regmap,
thus I don't think this is needed.
Are there any specific reasons behind this, what I've missed here?

We need to be sure that all other devices using this driver
should have no side effects on write.

I can think of a weird controller doing unwanted things internally
on every write disregarding the current state. (or is this overly
paranoid?)

>  
>  /**
> @@ -128,7 +128,7 @@ static int ti_syscon_reset_deassert(struct reset_controller_dev *rcdev,
>  	mask = BIT(control->deassert_bit);
>  	value = (control->flags & DEASSERT_SET) ? mask : 0x0;
>  
> -	return regmap_update_bits(data->regmap, control->deassert_offset, mask, value);
> +	return regmap_write_bits(data->regmap, control->deassert_offset, mask, value);
>  }
>  
>  /**
