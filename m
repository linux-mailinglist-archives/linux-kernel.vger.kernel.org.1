Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47383281740
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 17:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388097AbgJBP50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 11:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBP5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:57:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20966C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 08:57:25 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so2359745wrp.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 08:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RKAvB3+WMKNN79UahsqcncMsVNqOcgEb3CYVYKIldnE=;
        b=avZDU7go3+yv2IeEagTPM8GH/4BJn08wqf5PQiplnVADu+OAvfUcqmRM1af3wCvl+u
         RFO+xnZ8SUVbzCHkhjKXkZRtfQTiSQU9AtLUK4ZL3ePXVt8v7zC2Yl3mmc07FaJ2vViy
         GzroUTM1aHOB6qAlZpGSgBAwsdUHsPVAq43hfKmoNvDrtcDMnwviGJkWEPim3xt0mlO6
         POEMXBQD10jxyvHgVOQ50LlCv9hSQhnGMGVAfHQ7l5zQZ9Zqw44YKhjZ2rXog0hiBNKi
         WJKEljWSN3mkOzpn3P9G8oCaAeEQ10F8YeNaegkg930nU8gpVYGuEJsfSc+0YAjzvFNi
         dezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RKAvB3+WMKNN79UahsqcncMsVNqOcgEb3CYVYKIldnE=;
        b=OcFi+JufJSrW8jvfTFJBxOHsB/aniSzljtGBbg2fgc6NuAu1Xf1TjREt0HrJurpjIV
         T6M3HfoMenZUNwwZN6Aj4Jvn4hAUFF/8/Ad0kA4Cw1FzHwFPN1ZV1Im8sxccdK/SzXkz
         KVNL5sIejgGH0dMvYNIQ93U/a+hQ5e8uDVnhwNC/x3I9SbgoxjuuMW3WVyt7d3Wmik6l
         iYQkU/TFsaQwN4LPH7Ejv1QcQiskTzOFJ3d5pAdLUH+zcsqW6Xk1WlTQDVBce3awN9DQ
         ZTifwBqtAO4pp5htveaOGl/WDCod5zWSa1MbDYDUTzlQL0AdfwzOoGNkZ+q0mAwTIjV2
         0uGA==
X-Gm-Message-State: AOAM5319qLkGQlSTvJrt32raTJgjd7sG4VgK6J1ZiDT1km5MWXShPCoy
        KDatJpkZ2CXbVaDbqEF7/xu5iSxXkcPT491YKAGBIQ==
X-Google-Smtp-Source: ABdhPJxwrWnm+dIu+CTA7AHImJjo0wrCfg7Coce7eyfVsTucN19FAy0Kl9BsdVtITTMsbzxPFLnGj/dMkoXGrlM33Yg=
X-Received: by 2002:adf:fa02:: with SMTP id m2mr3765016wrr.273.1601654243794;
 Fri, 02 Oct 2020 08:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
 <cfce2276d172d3d9c4d34d966b58fd47f77c4e46.1599120059.git-series.maxime@cerno.tech>
 <20200929221526.GA1370981@ubuntu-m3-large-x86> <20200930140758.gummt3umouva3wyu@gilmour.lan>
 <20200930163823.GA237050@ubuntu-m3-large-x86> <cacbaef2-4221-50d8-3c5d-efab9f1a9c04@i2se.com>
 <20201001064843.dlewcu3b7dvqanyy@gilmour.lan> <20201001085402.t6mzzwzplviunhoc@gilmour.lan>
 <CAAvKZ65WqQqH-9JVdb5M6HcKbR3yQdvZha8n9UXXCfciYRq4aA@mail.gmail.com> <20201002151954.wazqc5riesdomlpx@gilmour.lan>
In-Reply-To: <20201002151954.wazqc5riesdomlpx@gilmour.lan>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 2 Oct 2020 16:57:05 +0100
Message-ID: <CAPY8ntCkY9F0e=hOyg=rs5G2a=iEbukWgmr0adXrwJQPm=uY6A@mail.gmail.com>
Subject: Re: [PATCH v5 80/80] ARM: dts: bcm2711: Enable the display pipeline
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Tim Gover <tim.gover@raspberrypi.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Fri, 2 Oct 2020 at 16:19, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi Tim,
>
> On Thu, Oct 01, 2020 at 11:15:46AM +0100, Tim Gover wrote:
> > hdmi_enable_4k60=1 causes the firmware to select 3.3 GHz for the PLLC
> > VCO to support a core-frequency of 550 MHz which is the minimum
> > frequency required by the HVS at 4Kp60. The side effect is that if the
> > display clock requirements are lower than 4Kp60 then you will see
> > different core frequencies selected by DVFS.
> >
> > If enable_uart=1 and the mini-uart is selected (default unless
> > bluetooth is disabled) then the firmware will pin the core-frequency
> > to either core_freq max (500 or 550). Although, I think there is a way
> > of pinning it to a lower fixed frequency.
> >
> > The table in overclocking.md defines options for setting the maximum
> > core frequency but unless core_freq_min is specified DVFS will
> > automatically pick the lowest idle frequency required by the display
> > resolution.
>
> I'm wondering if there's some way to detect this from Linux? I guess it
> would be nice to be able to at least detect a broken config to warn /
> prevent an user that their situation is not going to be reliable / work
> really well (like if they have a 4k display without hdmi_enable_4kp60
> set, or the issue we're discussing here)

The main filter in the firmware is the parameter
hdmi_pixel_freq_limit. That can either be set manually from
config.txt, or defaults appropriately based on hdmi_enable_4kp60.
Under firmware_kms [1] I read back those values to use as a filter
within crtc_mode_valid[2].
I can't think of a nice way of exposing that without the vc4 driver
gaining a DT link to the firmware, and that starts to get ugly.

  Dave

[1] https://github.com/raspberrypi/linux/blob/rpi-5.9.y/drivers/gpu/drm/vc4/vc4_firmware_kms.c#L1859
[2] https://github.com/raspberrypi/linux/blob/rpi-5.9.y/drivers/gpu/drm/vc4/vc4_firmware_kms.c#L1077
