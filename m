Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1002F0854
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 17:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbhAJQOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 11:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbhAJQOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 11:14:35 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769BAC061786;
        Sun, 10 Jan 2021 08:13:54 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id j16so16373091edr.0;
        Sun, 10 Jan 2021 08:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9WjpRCnbLbQ2Qdf1Ey7F64blCszjEFXqOTBiRnYedL0=;
        b=SMKlMbuqjzvtxtYijXzls96rJU0t4WXEMmwzYeVxqBuyiJ8PlaCv2wsO5sqOSeoor2
         ghCYvoqh8M4WyAeBFz32qLhoZhdXEHgKQYSm40IdNnH5GmQRl1uTNDQ4/Boc2LTi431C
         eNQL5ap39rTBtnUMoHjvF+46dCGOOjcG0thjL5IxZkxa3/c8A7DxhqB+KFHtjlIq0Hqw
         ZpeRMmghQ/NUGnZ2xoe1JujCrLc+l8veD5ip1HXyE9ZzO4t1skDzM7klQHez7UCE9htt
         cd8mza93Q0Q2q6J4LUUd7QgJqzHu3bKbGcq3TU7wXTMPLf4hQRrJBp5nPkuSQvF3ppjJ
         Sc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9WjpRCnbLbQ2Qdf1Ey7F64blCszjEFXqOTBiRnYedL0=;
        b=PAXEBM9bRFXf1q3XmqkZhG/CQd15crZxaz9x2XxqKRfixbX9y9KTohYRW0w6QPN4UY
         f/N4fQVUR3KF1N7Tg7Az/gmvkVYfHr4VJST5QOZmmOb6yxwG0w4qqpdtZ4XsF0Kq9amR
         a+4gX+H1VxuKsm8llyFjRPyms9IUG/S+MDyu4bK+XwRu1Viy5/bEkVBi72vpZUtACtFX
         Ghk/ZQ88mNpNYmfKVwk66K8Vvb3L24/V3haSXEpogFCkaELe6AicZ3+3EUE1vZmknp4m
         nGjFVwmnCHmGRjwYhZx1bt9LT9/2kqznXtPYENvBP36LeSQBfHNQw75nXRaNlufiHbeY
         PDkw==
X-Gm-Message-State: AOAM531QKZGY5udNhHf3voOyprPf7qzqFz4GbaIkv+jeGW1Ek1Z8F11q
        VyZRkAJceYDjcksR5SeUvZo=
X-Google-Smtp-Source: ABdhPJyT4RC/TvecS75T/1igAQOGHhid8OTzo1ImT6ZcTc3p9fl1qqjkLXl43jSNNy1rYnDF/Rp1Nw==
X-Received: by 2002:a05:6402:1102:: with SMTP id u2mr11718664edv.18.1610295233183;
        Sun, 10 Jan 2021 08:13:53 -0800 (PST)
Received: from localhost (ip1f10d3e8.dynamic.kabel-deutschland.de. [31.16.211.232])
        by smtp.gmail.com with ESMTPSA id j25sm5896536ejx.125.2021.01.10.08.13.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 08:13:52 -0800 (PST)
Date:   Sun, 10 Jan 2021 17:13:43 +0100
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>, parthitce@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Michael Walle <michael@walle.cc>,
        Robert Jones <rjones@gateworks.com>,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>, Li Yang <leoyang.li@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: arm: fsl: Add Variscite i.MX6UL
 compatibles
Message-ID: <20210110161343.GC7264@ripley>
References: <1610144511-19018-1-git-send-email-oliver.graute@gmail.com>
 <1610144511-19018-4-git-send-email-oliver.graute@gmail.com>
 <CAOMZO5CD2GBroqf+c4vLwDmDEhU3ScGt8b7pxC+YuZK_aKS3nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5CD2GBroqf+c4vLwDmDEhU3ScGt8b7pxC+YuZK_aKS3nQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/21, Fabio Estevam wrote:
> On Fri, Jan 8, 2021 at 7:23 PM Oliver Graute <oliver.graute@gmail.com> wrote:
> 
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index 05906e2..5f74d78 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -240,6 +240,7 @@ properties:
> >                - technexion,imx6ul-pico-dwarf   # TechNexion i.MX6UL Pico-Dwarf
> >                - technexion,imx6ul-pico-hobbit  # TechNexion i.MX6UL Pico-Hobbit
> >                - technexion,imx6ul-pico-pi      # TechNexion i.MX6UL Pico-Pi
> > +              - variscite,imx6ul-var-6ulcustomboard # i.MX UltraLite Carrier-board
> 
> You missed to add a "6" in the description: i.MX6 UltraLite Carrier-board

I will add it.

thx

Best regards,

Oliver
