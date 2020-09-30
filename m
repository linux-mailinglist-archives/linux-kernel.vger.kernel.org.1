Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C5E27F250
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbgI3TEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:04:52 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:42633 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgI3TEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:04:51 -0400
Received: by mail-ej1-f65.google.com with SMTP id q13so4395774ejo.9;
        Wed, 30 Sep 2020 12:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qn3mNh54CqAuBAt9+ws+x4Z31ABQSXrym70MfwajZo8=;
        b=XdBb8oVVK1nDp5pzm6u2esG9VVcArXMur3JSekAoCfOdRyax/5NaagFUCX5W1d2PT0
         fvoqXSIYupFhVWVkcYaOjnzyPCkyHNyM71OuUNkDNmcVS72dEA8LMDhY0t/TFNGUYbgK
         XaU0BR1ClGcEEYF5faXzv3en2/lNHu/mbItFEwMDDQbnuBuG4/UacWEr/DvfMQ1QC3r4
         EOoL9fuUHkgCpXPBnQDZubrX3sySPOtMXP5nf7dqzuKsTZHaxryn6kTJSd0Mrap2vE/l
         FODI0mcfDkKLBfy6/wIxKk46yS1RUCktTvwP+Y+vMnHtuBZ+vG5zwmfI5c7OB0HEz7GL
         70nw==
X-Gm-Message-State: AOAM533MUWBmpiaqpAGCmcvwJhtyt5YeECvoZDuzQmpV1YozRGp3/DTh
        0xFo8RnENpGirpGmKgZPtcg=
X-Google-Smtp-Source: ABdhPJxQI9wJtZ4KhzUHB4vbNUjbXK4ijIN8ypJglgGGhxsoTuirhbxWHFy/I3xKSeghHdcd8VOTjQ==
X-Received: by 2002:a17:906:2454:: with SMTP id a20mr4279364ejb.294.1601492689036;
        Wed, 30 Sep 2020 12:04:49 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id f13sm2199350edn.73.2020.09.30.12.04.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Sep 2020 12:04:47 -0700 (PDT)
Date:   Wed, 30 Sep 2020 21:04:45 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 12/12] dt-bindings: arm: fsl: document i.MX6Q boards
Message-ID: <20200930190445.GA27153@kozik-lap>
References: <20200930190143.27032-1-krzk@kernel.org>
 <20200930190143.27032-13-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930190143.27032-13-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 09:01:43PM +0200, Krzysztof Kozlowski wrote:
> Document and adjust the compatibles for i.MX6Q based boards.
> The Toradex Boards use multiple compatibles.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          | 56 +++++++++++++++++--
>  1 file changed, 50 insertions(+), 6 deletions(-)

Please skip this one, I sent it too fast. I did not finish yet all other
i.MX 6 and need to squash here some work-in-progress.

Best regards,
Krzysztof

