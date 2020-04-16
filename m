Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F2D1ACF1C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 19:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbgDPRt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 13:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727816AbgDPRtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:49:55 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0B7C061A0C;
        Thu, 16 Apr 2020 10:49:55 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id rh22so1929194ejb.12;
        Thu, 16 Apr 2020 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O9vqKvQJSosI2zy51g44Ony9xOnUOUnQzLKmbPYbXLs=;
        b=rfmBJsjW7+iTxonwOCa9eCjK/EmzWmpsGcOogRYhp8EKYhNyd9HpF5Ix//iAy7xSf2
         Mzq9b7MumB9KO/PUheOIa/m+S6RHDonRpqTFDuMG15bAWrFdQJea/fVK3pL4tIiv25YI
         E1u5q1/jCMFhdUA1jQ8jvzX0mzbNXFLEAys1Gju0aZITfFrNkM7TqdgdFzNvw2UjwIZN
         POeYLUtBG+z/YvS9AI46Ddr8gt5atrXRUib1JNxz4OiBBWl7ijjeVA/eTLQ97eAlrJO3
         8Df88AU9SeyWCF+ufDJ9hXne0Ahwgg1njLoo0yg25cXkPYpsQyn8i6sY1jhOVX2Au0mO
         A3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O9vqKvQJSosI2zy51g44Ony9xOnUOUnQzLKmbPYbXLs=;
        b=oEdweKjHBgCiDTZuh6InganaKFrpR/pnQFZZc2OCyMFFpOpSgCU5oGfq4HB3MphC4C
         fyVyaizhLYw3Am85DONAh6YIWEv4epnUy69B/wrrEBJW+f8cV99bb492hhDe2TRyI23L
         EewEboFoS9rTFSgZ9I15Q6KvQJWKUAP3xCKyy5LrGCaStURKJaHi7zdfruhJFCtz/klU
         GgkvpPMGFiRZQtnxCJzjcBES/nY0uiu62Ayy6gT/9i0WEDnBynPZNEc60OjwVejIo64L
         FWc5fkQDH5gd4qHSs88QQ1z9BJepmhj35fUIe0gQLtwat1HW0/6wyj0lALndSgkMl542
         na5g==
X-Gm-Message-State: AGi0PuYzV03J43r0PhqZMCUmP00F/xPLixsO8ppxBRgaSZPGwp7N7+fI
        aQT+6D+/Tp0leWz0d0YvHp5JKIf8W0Ka/g5q4R4=
X-Google-Smtp-Source: APiQypLEk2gMPX17Qyadyvo1VqaylHm20tB8KtuyppUGRUqPXNDwTXsEmsPQN4DGCwkKaSyK8Y5IYXm3qjuuAz/y7dQ=
X-Received: by 2002:a17:906:2962:: with SMTP id x2mr10033635ejd.233.1587059393912;
 Thu, 16 Apr 2020 10:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200414200017.226136-1-martin.blumenstingl@googlemail.com>
 <20200414200017.226136-2-martin.blumenstingl@googlemail.com> <1jblnrbu16.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jblnrbu16.fsf@starbuckisacylon.baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 16 Apr 2020 19:49:42 +0200
Message-ID: <CAFBinCCV=RNqLpJfj6JUkoc_+NXMWNgsdUSdAfucLCJCFWddUQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: meson: meson8b: Fix the first parent of vid_pll_in_sel
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Thu, Apr 16, 2020 at 12:32 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Tue 14 Apr 2020 at 22:00, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
> > Use hdmi_pll_lvds_out as parent of the vid_pll_in_sel clock. It's not
> > easy to see that the vendor kernel does the same, but it actually does.
> > meson_clk_pll_ops in mainline still cannot fully recalculate all rates
> > from the HDMI PLL registers because some register bits (at the time of
> > writing it's unknown which bits are used for this) double the HDMI PLL
> > output rate (compared to simply considering M, N and FRAC).
>
> Have you considered adding a fixed_factor pre-multiplier, like in the
> gxbb driver ?
>
> Seems to be the same thing
it seems like I haven't been clear enough here: the doubling only
happens for some - but not all - PLL settings.

Let me give you two examples with values from the 3.10 vendor kernel:
1. the CVBS modes use a hdmi_pll_dco freq of 1296MHz
it uses: M = 54, N = 1 and FRAC = 0
with our existing clock tree this works out perfectly: 24MHz * 54 / 1 = 1296MHz

2. HDMI 1080P mode uses hdmi_pll_dco freq of 2970MHz
it uses M = 61, N = 1 and FRAC = 3584
with our existing clock tree this doesn't end up right: (24MHz * 61 /
1)  + (24MHz * 3584 / 4095) = 1485MHz

I did play with the registers and our clock-measurer.
it *seems* that the HHI_VID_PLL_CNTL3 and/or HHI_VID_PLL_CNTL4 are
related to this doubling, but I don't know for sure
my assumption is that there's either a fixed pre-multiplier like you
suggested and then a configurable "divide by 2" somewhere or there's
simply a configurable "multiply by 2" somewhere
Either way, I want to fix that at some point but since I don't know
the related bits I want to do that later on (in separate patches once
I have figured it out)


Regards
Martin
