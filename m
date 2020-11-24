Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE092C1D18
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 05:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgKXElx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 23:41:53 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35102 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbgKXElw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 23:41:52 -0500
Received: by mail-lj1-f195.google.com with SMTP id r18so5745324ljc.2;
        Mon, 23 Nov 2020 20:41:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qNg9BCPmUa7zVn4hdXCfbMqNTMndQjQt0tAc7CL5ayQ=;
        b=agOjJE7/fsrWkECADnvggGrOls34vqm+AIa0ue6u7MhP+LuzVDpocHrd3QPot33mH4
         /TB7xUfzMykOPfikRFy25hsRtI1XLeokmGrclFfiiceHkbNyvKSND6Zer7fbROAsPYTf
         HjIWesaxk+fhLt+5UFXg8xTZJhMVoYquNhKN89vY5G7OElm4SFeHrw6xXjLlyNj64m+W
         np/0KFvNCQbK3krOjyp54/sUqWfUK4K6ch1qAAlqqbGrRGuEF9aGFa3Vhfupenrty1Zy
         QK1cmwb/eQCrcGXKHHm/mcWw6KXganMOiZyaRkDWAWjODxj8HP2B9qIMiyCOeqzQz6Xk
         kMpg==
X-Gm-Message-State: AOAM533RVH3RiUaGa1XFKeaXnirg48K/FFMT8BL6jUFVwBQofCdXQ09D
        3iOs+rO+MaXS+TxGx6MTu4z+56ezkjeMHg==
X-Google-Smtp-Source: ABdhPJyFyJIS9NNGFeb27YVRaDAB6ukvpWyYohymAXctLIZ2LbmvIiVttcF0SUAgWq8sCXWLVQEZlg==
X-Received: by 2002:a2e:9798:: with SMTP id y24mr1081828lji.151.1606192909470;
        Mon, 23 Nov 2020 20:41:49 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id m20sm1587216lfc.172.2020.11.23.20.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 20:41:48 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id f24so7647759ljk.13;
        Mon, 23 Nov 2020 20:41:48 -0800 (PST)
X-Received: by 2002:a2e:8546:: with SMTP id u6mr1085490ljj.125.1606192908700;
 Mon, 23 Nov 2020 20:41:48 -0800 (PST)
MIME-Version: 1.0
References: <20201123161041.2304766-1-michael@fossekall.de> <4bf42c9e-9f70-bc30-1a88-44a127cd989a@sholland.org>
In-Reply-To: <4bf42c9e-9f70-bc30-1a88-44a127cd989a@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 24 Nov 2020 12:41:37 +0800
X-Gmail-Original-Message-ID: <CAGb2v65=SoATrLDKvXH-EjdVJT3E4e+yQ6Ad0Nn1BQsB9aJvog@mail.gmail.com>
Message-ID: <CAGb2v65=SoATrLDKvXH-EjdVJT3E4e+yQ6Ad0Nn1BQsB9aJvog@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add
 gpio-poweroff to DT
To:     Samuel Holland <samuel@sholland.org>
Cc:     Michael Klein <michael@fossekall.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 12:14 PM Samuel Holland <samuel@sholland.org> wrote:
>
> On 11/23/20 10:10 AM, Michael Klein wrote:
> > Add gpio-poweroff node to allow the board to power itself off after
> > shutdown by disabling the SYSTEM and CPUX regulators (U5 resp. U6).
> > The RST button can be used to restart the board.
>
> The PSCI client will override this driver once the PSCI implementation
> is upgraded to v0.2 or newer functions. So having this around should
> cause no compatibility issues (although it would print an error in dmesg
> at that point). This seems like a reasonable thing to do for the other
> H2+/H3 boards that use a similar regulator layout.

I wonder if this (gpio-poweroff) works if those regulators are also in the DT?

> Reviewed-by: Samuel Holland <samuel@sholland.org>
>
> > Signed-off-by: Michael Klein <michael@fossekall.de>
> > ---
> >  arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> > index 4c6704e4c57e..76e79e6db733 100644
> > --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> > +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> > @@ -46,6 +46,11 @@ sw4 {
> >               };
> >       };
> >
> > +     gpio_poweroff {
> > +             compatible = "gpio-poweroff";
> > +             gpios = <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 */
> > +     };
> > +
> >       reg_vdd_cpux: vdd-cpux-regulator {
> >               compatible = "regulator-gpio";
> >               regulator-name = "vdd-cpux";
> >
>
