Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30524285085
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgJFROV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgJFROV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:14:21 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF4EC061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 10:14:20 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h7so10722932wre.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 10:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RQkN1upH+slzKJbrqvfok78tbpU8Cenolhq9OlECd6A=;
        b=KSeuBH5t/vKToC5zcoC+y7kYXjwLeOm8feTMa90733C8BopxSpG0eFIiHU6f2JPIbq
         Wl8Rla+2of/uHa6ZUKH46vGJVuWPUiRfrfteZyCLXu3MMKhss2k9lztpnTokcp0dHJLc
         ZX03Qgm23v5lkOsVNWOfWbwvdm/vB59fNtIjvvS4UOctL+ct3k19ARHryUP7wQOmDcdK
         E7fcfPKg2zfvuKnMZY+AeYrYvqJQQUpvZV7alJ/8JDwSqwYVWn8sKSsmnxULqdg51vh6
         Ah9Qo3i5QLGtwRE+EqHUViTgyta+hc0O42FT8wVpXpXUAWLGQSRJX9M5QedGjQEc+MpW
         U8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQkN1upH+slzKJbrqvfok78tbpU8Cenolhq9OlECd6A=;
        b=e2k3rolglDpeazvYAgjdEZJupv5owIGr1pANcbY5jrlZ7JQ8563HWi192m7ebP/oKM
         ahaXkWHwScMqqEeModNmzFWgG/DRItuXAMB0dnudzFnyHHgalGIzS5FxBmpYyPqO2N8j
         EXCHs8VzpqDBxei/Ttgk+VNGi/W0wUI/z5ht5e3uDTSDVJwxD+3DCvsVD28Sy50NEL2F
         OeqVizaKubRbyFT2TnVqSvjKBdFpARPReAzSr28C0O7IvUwRGtuODfapRPjXLdHoOEaJ
         sW6PMZKXqfahr2rRFJC14AF0qRtmpFJ2dh1lqYa+JAsQCUAQfJPe+gIp7EMezfgu2VQw
         u4Sw==
X-Gm-Message-State: AOAM532ivROPu6IeOcofHA6SpSo/w2b3F6DWeIYjpUbQ4kRoGWNHTBOE
        aP+AtwmchZS+IH+4u+5PkZb2HFFdbd1kS3dutOksOA==
X-Google-Smtp-Source: ABdhPJx6JoolLP3mOQPYECXAgK8Q7YDbgX/kE5v0qictkEpeZ+HVDNJCsA+ZQIvOflpmzULotVi7OCEqMN67r0A90lQ=
X-Received: by 2002:adf:e806:: with SMTP id o6mr6065570wrm.42.1602004459187;
 Tue, 06 Oct 2020 10:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <cfce2276d172d3d9c4d34d966b58fd47f77c4e46.1599120059.git-series.maxime@cerno.tech>
 <20200929221526.GA1370981@ubuntu-m3-large-x86> <20200930140758.gummt3umouva3wyu@gilmour.lan>
 <20200930163823.GA237050@ubuntu-m3-large-x86> <cacbaef2-4221-50d8-3c5d-efab9f1a9c04@i2se.com>
 <20201001064843.dlewcu3b7dvqanyy@gilmour.lan> <20201001085402.t6mzzwzplviunhoc@gilmour.lan>
 <CAAvKZ65WqQqH-9JVdb5M6HcKbR3yQdvZha8n9UXXCfciYRq4aA@mail.gmail.com>
 <20201002151954.wazqc5riesdomlpx@gilmour.lan> <CAPY8ntCkY9F0e=hOyg=rs5G2a=iEbukWgmr0adXrwJQPm=uY6A@mail.gmail.com>
 <20201006152623.sjc3jxagj4wh7g5f@gilmour.lan>
In-Reply-To: <20201006152623.sjc3jxagj4wh7g5f@gilmour.lan>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 6 Oct 2020 18:14:01 +0100
Message-ID: <CAPY8ntAr+wV0F-GCxHLg+30tuu8van51BFQ9Nh_C1LD+CPRcLA@mail.gmail.com>
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

On Tue, 6 Oct 2020 at 16:26, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi Dave,
>
> On Fri, Oct 02, 2020 at 04:57:05PM +0100, Dave Stevenson wrote:
> > Hi Maxime
> >
> > On Fri, 2 Oct 2020 at 16:19, Maxime Ripard <maxime@cerno.tech> wrote:
> > >
> > > Hi Tim,
> > >
> > > On Thu, Oct 01, 2020 at 11:15:46AM +0100, Tim Gover wrote:
> > > > hdmi_enable_4k60=1 causes the firmware to select 3.3 GHz for the PLLC
> > > > VCO to support a core-frequency of 550 MHz which is the minimum
> > > > frequency required by the HVS at 4Kp60. The side effect is that if the
> > > > display clock requirements are lower than 4Kp60 then you will see
> > > > different core frequencies selected by DVFS.
> > > >
> > > > If enable_uart=1 and the mini-uart is selected (default unless
> > > > bluetooth is disabled) then the firmware will pin the core-frequency
> > > > to either core_freq max (500 or 550). Although, I think there is a way
> > > > of pinning it to a lower fixed frequency.
> > > >
> > > > The table in overclocking.md defines options for setting the maximum
> > > > core frequency but unless core_freq_min is specified DVFS will
> > > > automatically pick the lowest idle frequency required by the display
> > > > resolution.
> > >
> > > I'm wondering if there's some way to detect this from Linux? I guess it
> > > would be nice to be able to at least detect a broken config to warn /
> > > prevent an user that their situation is not going to be reliable / work
> > > really well (like if they have a 4k display without hdmi_enable_4kp60
> > > set, or the issue we're discussing here)
> >
> > The main filter in the firmware is the parameter
> > hdmi_pixel_freq_limit. That can either be set manually from
> > config.txt, or defaults appropriately based on hdmi_enable_4kp60.
> > Under firmware_kms [1] I read back those values to use as a filter
> > within crtc_mode_valid[2].
> > I can't think of a nice way of exposing that without the vc4 driver
> > gaining a DT link to the firmware, and that starts to get ugly.
>
> I had in mind something like if the clock driver can infer that somehow
> through some the boundaries reported by the firmware maybe? IIRC,
> hdmi_enable_4kp60 will already change the max frequency reported to
> 550MHz instead of 500MHz

Yes, that's plausible, but I don't know enough about the clock
infrastructure for advertising limits to know what works there.
Tell me what you need from the mailbox service and I'll see what I can do.

We do already have RPI_FIRMWARE_GET_MAX_CLOCK_RATE and
RPI_FIRMWARE_GET_MIN_CLOCK_RATE. It'd take a few minutes of staring at
the code (or a quick test) to confirm if they definitely are changed
for CORE clock by hdmi_enable_4kp60 - I think it does.

  Dave
