Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9EA2A6698
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgKDOoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgKDOoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:44:20 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A077C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 06:44:20 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id x7so22340559wrl.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 06:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6unppK02QS93JTtQqhWex3J7B9162N1uKkJTqQRpaR8=;
        b=w4JXL5Y1Glp8H52II7Dr0cU3Ahk19eZaWSF0n3eJAARCJxtznBOwd8Xgk/Fn/0Tud6
         IcuTIOhwcQfPhKuluwAZmzd9l9IiIIqOv5eL5TyBQHHuRhvMj0z4L38SKqFW5hxz9T6P
         RLrq2Lve0zb23ToOYF0kGtuyl4F5FVfESPtHaXsQooLnjHGcHQx9NgplWSvH8TaABm2x
         mer6+JzBXls8KIgB2XF0mNn5BaRKHRlFzXLo0t1JfIIY3wSW5PlVSKaJbpGDXCIyYfMo
         3lgR6U7HHUR2eXWYqHwgZNz/MGfCiC64ANUFVuTUHzknDlQMjTiXltEFu+HoLQ3GA2Os
         QkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6unppK02QS93JTtQqhWex3J7B9162N1uKkJTqQRpaR8=;
        b=FARypxl7JaBq5mcAfH/Pwh99DNSuUL4Witw0VlqV+6SMsVrvs3g3JJ1+mehbq5n9Sa
         KEONIgxzp2d1Df0nZerd+uW0Df68A8om+3mKzGX6DsOESUDVFZS/QZ9VfcSSSamO56pw
         4RrkVRyQtpWgOguhIUSb5SXXazPNyObHro8jkZF8pX7Fjug2FfiGOC/lyl5dcBpZtWlW
         iLSFLQOpKHxZjGXZZoYBK/Rp+PzQSdE+zgyC6KWaFiTIkNtxZj2bAzIpqb707JuFS5j5
         YYm1+FUXLvYHXAbVBF/eTyKTCxfdZbVcoKGyBAQuj2sZNKFZuvbObrHCWBxf6GR6y4tz
         ZIMw==
X-Gm-Message-State: AOAM533l6S21Gv057Yjzp0E3z1P8dYGhGND2acSkfEYq+2U8SqcxkT3j
        WfPAK4nDVHtCGNqT+NOf6owZwg==
X-Google-Smtp-Source: ABdhPJzI4iNsW4PFp/037xEiTAQRn3xfX83SyjmpxrGCPimoexgyzKjCzEvLjtmMKlezxsneY76aCw==
X-Received: by 2002:a5d:5105:: with SMTP id s5mr1773917wrt.255.1604501059206;
        Wed, 04 Nov 2020 06:44:19 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id h4sm2628421wrp.52.2020.11.04.06.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 06:44:18 -0800 (PST)
Date:   Wed, 4 Nov 2020 14:44:16 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 3/5] mfd: tps65911-comparator: use regmap accessors
Message-ID: <20201104144416.GH4488@dell>
References: <cover.1601164493.git.mirq-linux@rere.qmqm.pl>
 <3c37cdd9a0f23157e56ada0e2f15aa7370661ef4.1601164493.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c37cdd9a0f23157e56ada0e2f15aa7370661ef4.1601164493.git.mirq-linux@rere.qmqm.pl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Sep 2020, Michał Mirosław wrote:

> Use regmap accessors directly for register manipulation - removing
> one layer of abstraction.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/mfd/tps65911-comparator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
