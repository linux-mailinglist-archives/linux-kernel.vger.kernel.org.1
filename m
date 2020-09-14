Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCF02695E3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgINTwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgINTwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:52:19 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1B4C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 12:52:18 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u3so431794pjr.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 12:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TcdXkIRAgGt9vXRg+9Us0U0AFK7n0jMIa5WCvYtwILM=;
        b=FPUKR3nHDfH1uQGswRa0iOrC38WOiDscwoCFyblK+wa5WCHpKSpu1ohj2jx94vGuQ5
         15v0sOLKFZkdvLVqK1eqcd5FPU1JHQMi993XU6BnOioTMeVpV9pO5xlrzwhbiuaRWHOK
         UgrxQphfAoIFH7PuCuZYNcdRBe0JGSIpA+who=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TcdXkIRAgGt9vXRg+9Us0U0AFK7n0jMIa5WCvYtwILM=;
        b=Ryb/2QsIpH4XJR7y1gotzf6Y2RLF6luPk919d0g+6jvqdNcVGOKq9oBq9B5w7G8U5e
         lvjMbG/m5Fc7qh2BLPIfMD7BA64uSKBFb90ahFufKuBK6BPBfnVRlz5P2gM5bBKMJeMC
         K77rz21g7M3j7F/6By/qAUQZUo7I1bRsBf4cV1Hx9QHGPyFfD/qt6lBI5PySDCGvgtfT
         YzUIXwhofsRkDDc4iRfGGSqL2UzQ5sC/BIedoP2tOTTZq8pHDf4fr+fo3nwaiscZC8ae
         4kBeSpSfxwOXzTHsgBHMvyTvy4p6w+dfJuxfALrHbCy0T0eKPSoZ8LwPdGBv4tppb0OP
         vKaA==
X-Gm-Message-State: AOAM5330ZPzx/EVAvYL2diRXxEVGOUkCqnO43dHUh3ka76z5JYU9bdIu
        TvKIZBqRvhhog4qRq+nVSO5nHvTB0wbg3g==
X-Google-Smtp-Source: ABdhPJyvaGe6IuXXfOb+69HllwzXZHyMNkRjAzV8J/qE513073dFZWsGZiJRD8ocLZcYuMZ0WrjqAg==
X-Received: by 2002:a17:90a:ead5:: with SMTP id ev21mr817563pjb.188.1600113137463;
        Mon, 14 Sep 2020 12:52:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id jz6sm10163667pjb.22.2020.09.14.12.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 12:52:16 -0700 (PDT)
Date:   Mon, 14 Sep 2020 12:52:15 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-usb@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Peter Chen <peter.chen@nxp.com>, linux-kernel@vger.kernel.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 2/2] USB: misc: Add onboard_usb_hub driver
Message-ID: <20200914195215.GD2022397@google.com>
References: <20200914112716.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200914112716.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200914112716.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just noticed that building this results in a compilation error, due
to a missing brace. I tested this patch, but with another patch on top
with debug logs, the other patch adds the brace.

I'll still hold off a bit before sending v2, for if others have
comments.

On Mon, Sep 14, 2020 at 11:27:49AM -0700, Matthias Kaehlcke wrote:

> diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> new file mode 100644
> index 000000000000..e5a816d0b124
> --- /dev/null
> +++ b/drivers/usb/misc/onboard_usb_hub.c
>
> +static int onboard_hub_suspend(struct platform_device *pdev, pm_message_t msg)
> +{
> +	struct onboard_hub *hub = dev_get_drvdata(&pdev->dev);
> +	int rc = 0;
> +
> +	if (!hub->cfg.power_off_in_suspend)
> +		return 0;
> +
> +	hub->has_wakeup_capable_descendants = false;
> +
> +	if (hub->cfg.wakeup_source) {
> +		struct udev_node *node;
> +
> +		mutex_lock(&hub->lock);
> +
> +		list_for_each_entry(node, &hub->udev_list, list) {
> +			if (usb_wakeup_enabled_descendants(node->udev)) {
> +				hub->has_wakeup_capable_descendants = true;
> +				break;

missing brace here:	}

> +		}
> +
> +		mutex_unlock(&hub->lock);
> +	}
> +
> +	if (!hub->has_wakeup_capable_descendants)
> +		rc = onboard_hub_power_off(hub);
> +
> +	return rc;
> +}
