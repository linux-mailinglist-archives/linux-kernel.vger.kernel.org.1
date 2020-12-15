Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6B22DAD0A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 13:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgLOMVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 07:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbgLOMV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:21:27 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DF7C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 04:20:46 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id y19so38727993lfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 04:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=muII2+EhsrlQ7LSgybh/KUQuhoxu6TW7ebZEi8ZaXUs=;
        b=Mc5KAKIPsGWsYtuYm15hGWgRznq0FUtGXVP30J7vozIqRfsegWcpjr3xuO8BGX07Jz
         JkDP+DG0mymmnbM6C8xNMeNeFa4P0r2c8gk9K0jdBai3USeKpbxRj/nvbnclj3O+Ulny
         LfJARz9rL+VDPB2jgLLOGXgd7FhgXkDrKy8spD4h7z9fY9PmPwvCNVsnv6W98peohNYI
         +575nEJrfHKiui8ZYD4qhr5VGWg/7MfP5okqTRv+Y//I6AF9rClLTbEOLiWjR2OQTj0E
         edmjAI/09JWOik8cWNSnbe2RHnjZUU/QdCHDnLkj46l3X3238HHWTFU00PZ7D+Y/JMv9
         RlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=muII2+EhsrlQ7LSgybh/KUQuhoxu6TW7ebZEi8ZaXUs=;
        b=fdV69Hmel7FT8QeE94KalsrSjwKAdZEoQo0E3Ya36Bnw3hLCdioWaRCOiR51zMHIsB
         0dMPWxXwipLfKCSbpOo10NKhsHqFaqNqhwb4aM2uOztP44n1ZAd1s89Pmwk/VAPAp9S2
         +Tec6w4D7/x4vzO3BDJul0DL6JAeihXu3Mbe8zESB51JmdP30okcAp5G9F0yzG/QGEQt
         atxPWSQCNLJJtJXZbzi452mYJ6gPwy/a7ifVssuc7reyKgHnKJLf5XY/rAX5MrhBv9wu
         uPAnxZaacMmC5rWBYg6tGTQXtwHwdVFwVm1FkPx/gIC/P3u931XtGRhAmIWwXbQPWiFp
         +tHQ==
X-Gm-Message-State: AOAM5321rXE02CxLBJqyB99U+JfnMxdgTfjbrz3qRZvB/rKwveiFHu4X
        GTlYkjEFBvXxt0X1K+6lO5HrauufTAeoSd1A2PZbcQ==
X-Google-Smtp-Source: ABdhPJxub0zGFqVvyvkyWV6EKot8wVecIzimdfMqyEVJRdaceaG3Jlkl7yjhIHyQBDQDuZnp+DULP9lqWDJOF+0ahlk=
X-Received: by 2002:a19:8384:: with SMTP id f126mr10543104lfd.649.1608034845054;
 Tue, 15 Dec 2020 04:20:45 -0800 (PST)
MIME-Version: 1.0
References: <5fd76cf2.1c69fb81.6f19b.b16a@mx.google.com> <483b08f2-09c3-e753-d2ce-4e34fee627f3@collabora.com>
In-Reply-To: <483b08f2-09c3-e753-d2ce-4e34fee627f3@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Dec 2020 13:20:34 +0100
Message-ID: <CACRpkdbozXM3FHQB9+GcPJZdNT+Vi1223m2uEqqJ21ukY1A4Gw@mail.gmail.com>
Subject: Re: linusw/devel bisection: baseline.bootrr.mediatek-mt8173-pinctrl-probed
 on mt8173-elm-hana
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Johan Hovold <johan@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        Sean Wang <sean.wang@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 11:28 PM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:

> Please see the bisection report below about the pinctrl driver
> failing to probe on the arm64 mt8173-elm-hana platform.

That's an excellent, helpful report which helps a lot!
Thank you for doing this!

> This is the error message:
>
> [    0.051788] gpio gpiochip0: Detected name collision for GPIO name ''
> [    0.051813] gpio gpiochip0: GPIO name collision on the same chip, this is not allowed, fix all lines on the chip to have unique names
> [    0.051832] gpiochip_add_data_with_key: GPIOs 377..511 (1000b000.pinctrl) failed to register, -17
> [    0.051946] mediatek-mt8173-pinctrl: probe of 1000b000.pinctrl failed with error -22

It seems we need to teach the core to ignore the name (empty string).

Yours,
Linus Walleij
