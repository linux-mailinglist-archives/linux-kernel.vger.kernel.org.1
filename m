Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30741B890F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 21:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgDYTiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 15:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgDYTiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 15:38:24 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B84C09B04D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 12:38:23 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id hi11so5400007pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 12:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=wDIY7Zc1oPrCnhuBYSFyR9XUZ6XtcZd19wi4ia+d3a0=;
        b=PQhZzQtKgnw95PWTl4LWH+6v6ZwbejfOj/qMmmsjdx7wU67v8uPiFk9qhqZ3opVNap
         pe2PUhJC3EaAKlByWg1UYK37UjsqYUF/x3wUJ1jfdQbxI7Qhs8KBFv/+vP11S7XvUBLK
         ZsTjWMqTlgaPZeNXBgJA48vLHmaCV2316iK3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=wDIY7Zc1oPrCnhuBYSFyR9XUZ6XtcZd19wi4ia+d3a0=;
        b=OmdhTGjvQUU5UvzBPJbZzRt124+z29yGKipYZ/lZ91IRWrfyoMavwlB1urOO1dteB0
         10j7EodCgdRbCOGEN9axE/cPfZz/4i/YHxAumM8Tmbth1meNcQKlrINV00BdNur4hh5C
         A/MfMvDrbfK4cxrkUE+1VrGv8EbLWT1ZwsHHHeS9UDNdlzATelN0MhvG73VM5FJEsuhC
         dzBsZWwVq88pk7rKkIjTfakzI9RAH5Y75ic4bam2qL33S5IgS+Qw4AcMJCJLbgO2jsYl
         4PLmFVvkySrPNMkmOzge8p3CUdOfOXhb5EqPFZeAeMW1uqziieWddNjfkxq1A7jGwEgN
         MPww==
X-Gm-Message-State: AGi0PuZn5S1ZteoHpzz3zrN1pBuYmrcFRz59n73BA74fnC/qSN+8YLJb
        WwXAqXnpHEOdnKeAV1Qg7ZHyog==
X-Google-Smtp-Source: APiQypKqi15ly1FCn64WfHLu7AD932QOaOgexubbURGEz41/S+Yww8OGEEEaC1cDZ/uvcHGogNT0rg==
X-Received: by 2002:a17:90a:25c3:: with SMTP id k61mr14548584pje.28.1587843502754;
        Sat, 25 Apr 2020 12:38:22 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w28sm7623732pgc.26.2020.04.25.12.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 12:38:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200423092431.v3.1.Ia50267a5549392af8b37e67092ca653a59c95886@changeid>
References: <20200423162548.129661-1-dianders@chromium.org> <20200423092431.v3.1.Ia50267a5549392af8b37e67092ca653a59c95886@changeid>
Subject: Re: [PATCH v3 1/6] drm/bridge: ti-sn65dsi86: Export bridge GPIOs to Linux
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        jeffrey.l.hugo@gmail.com, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, robdclark@chromium.org,
        jernej.skrabec@siol.net, jonas@kwiboo.se,
        bjorn.andersson@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Laurent.pinchart@ideasonboard.com, a.hajda@samsung.com,
        airlied@linux.ie, bgolaszewski@baylibre.com, daniel@ffwll.ch,
        linus.walleij@linaro.org, narmstrong@baylibre.com,
        robh+dt@kernel.org, spanda@codeaurora.org
Date:   Sat, 25 Apr 2020 12:38:21 -0700
Message-ID: <158784350116.117437.9524374865698963301@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-04-23 09:25:43)
> The ti-sn65dsi86 MIPI DSI to eDP bridge chip has 4 pins on it that can
> be used as GPIOs in a system.  Each pin can be configured as input,
> output, or a special function for the bridge chip.  These are:
> - GPIO1: SUSPEND Input
> - GPIO2: DSIA VSYNC
> - GPIO3: DSIA HSYNC or VSYNC
> - GPIO4: PWM
>=20
> Let's expose these pins as GPIOs.  A few notes:
> - Access to ti-sn65dsi86 is via i2c so we set "can_sleep".
> - These pins can't be configured for IRQ.
> - There are no programmable pulls or other fancy features.
> - Keeping the bridge chip powered might be expensive.  The driver is
>   setup such that if all used GPIOs are only inputs we'll power the
>   bridge chip on just long enough to read the GPIO and then power it
>   off again.  Setting a GPIO as output will keep the bridge powered.
> - If someone releases a GPIO we'll implicitly switch it to an input so
>   we no longer need to keep the bridge powered for it.
>=20
> Because of all of the above limitations we just need to implement a
> bare-bones GPIO driver.  The device tree bindings already account for
> this device being a GPIO controller so we only need the driver changes
> for it.
>=20
> NOTE: Despite the fact that these pins are nominally muxable I don't
> believe it makes sense to expose them through the pinctrl interface as
> well as the GPIO interface.  The special functions are things that the
> bridge chip driver itself would care about and it can just configure
> the pins as needed.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
