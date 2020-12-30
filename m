Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776BA2E75D4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 04:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgL3Dae convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Dec 2020 22:30:34 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:34035 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgL3Dad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 22:30:33 -0500
Received: by mail-lf1-f43.google.com with SMTP id o19so35062009lfo.1;
        Tue, 29 Dec 2020 19:30:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sX2LDQEGW3G5clQ2nn9TM9i6s3O9DrPEgTBFsaiQlJA=;
        b=q34noouhR0KtAl0CHQIqxJYlGM1ydk2y+MFGi9pumjpb612p8I2G2Synw107KJfNxH
         kbYqMEWbXvAaW72WK5ZFbbRI+Vyv+hHDBoE/a+zkksVeolFQypQSQnmZo3MfkBgxeJJj
         9Qqj669HfrvYXQ0cQ3hYIUF31sZMfERYyFzJ8xWKcnAumOiAWEW3HptYtnTVCKD/Lh/M
         csSW/uW3D7D3FBgiQOmC6QWh5wl8LB7MPig6oFTSVsglQ6T1n11uvKdTc8IUewvwpLJQ
         AtgcgmH//5vCdthH3dHiFUewX2Ox5hFeY+eYsxyUOb6Io2pTpwYIN8MWg23GKl9Ld6Cv
         VXHQ==
X-Gm-Message-State: AOAM530/JRBtsrGNJF7lBrxNYQ8wNQkLZaLd41MPac3So2enBZZW0h8X
        f5VCi8SE5J4ByLHHepNayg1DoyrXHUjw7g==
X-Google-Smtp-Source: ABdhPJzKQKjLu9ZBtpQC/6WKqZUqvYjfvsHUlzWVSX7kjlWzY5NtOD3lRL7kCflG908umw+aNeRq/A==
X-Received: by 2002:a05:651c:2121:: with SMTP id a33mr25408307ljq.381.1609298990924;
        Tue, 29 Dec 2020 19:29:50 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id v21sm7093276ljk.73.2020.12.29.19.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 19:29:50 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id o13so35011903lfr.3;
        Tue, 29 Dec 2020 19:29:50 -0800 (PST)
X-Received: by 2002:a2e:8852:: with SMTP id z18mr27532558ljj.94.1609298990194;
 Tue, 29 Dec 2020 19:29:50 -0800 (PST)
MIME-Version: 1.0
References: <20201218195033.2301127-1-contact@paulk.fr> <3035881.9zrMQt1rZd@jernej-laptop>
In-Reply-To: <3035881.9zrMQt1rZd@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 30 Dec 2020 11:29:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v64xtm5wBuL6bkAYYFK2irjxs58df_xeHws6vaG_QDux+g@mail.gmail.com>
Message-ID: <CAGb2v64xtm5wBuL6bkAYYFK2irjxs58df_xeHws6vaG_QDux+g@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: sun8i-v3s: Add CSI0 MCLK pin definition
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Kocialkowski <contact@paulk.fr>,
        Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 4:17 PM Jernej Škrabec <jernej.skrabec@siol.net> wrote:
>
> Hi!
>
> Dne petek, 18. december 2020 ob 20:50:33 CET je Paul Kocialkowski napisal(a):
> > This adds a device-tree definition for the CSI0 MCLK pin,
> > which can be used for feeding MIPI CSI-2 sensors.
> >
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>
> Is this used anywhere? Current policy is to add pin definitions only if any
> user exists.

IIRC we sort of loosened that requirement with the use of /omit-if-no-ref/.
The A20 dtsi file has a whole bunch of pins defined that are not directly
used but are available for users to reference, especially in overlays.
The "-@" parameter for the device tree compiler, used to build overlay
compatible DTBs, makes the compiler ignore /omit-if-no-ref/ and include
all the nodes.

ChenYu

> Best regards,
> Jernej
>
> > ---
> >  arch/arm/boot/dts/sun8i-v3s.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi
> > b/arch/arm/boot/dts/sun8i-v3s.dtsi index a9f5795d4e57..bff822b9fa01 100644
> > --- a/arch/arm/boot/dts/sun8i-v3s.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
> > @@ -337,6 +337,12 @@ pio: pinctrl@1c20800 {
> >                       interrupt-controller;
> >                       #interrupt-cells = <3>;
> >
> > +                     /omit-if-no-ref/
> > +                     csi0_mclk_pin: csi0-mclk-pin {
> > +                             pins = "PE20";
> > +                             function = "csi_mipi";
> > +                     };
> > +
> >                       /omit-if-no-ref/
> >                       csi1_8bit_pins: csi1-8bit-pins {
> >                               pins = "PE0", "PE2", "PE3",
> "PE8", "PE9",
>
>
>
>
