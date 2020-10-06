Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9AE28510E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgJFRmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:42:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45273 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgJFRmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:42:24 -0400
Received: by mail-ot1-f68.google.com with SMTP id f37so9511388otf.12;
        Tue, 06 Oct 2020 10:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qcdVVsuOoJSsciqyI4x1smopaEokqWO2AhD7kFOR+b4=;
        b=aHIghfbEG7FKo7e9j6Irm11XmXRYPB02AvA4up7UYOxbcLj5KFFv35OQfNPw0KETPe
         X5wwfs1kstxmdPVYm+Z7bgCwcXgZFiafOztB3Tjax9wuf6lYYBT/95B1GQPflJzioYFT
         NMgB9rSkqe1y9JtgF+j67tb7s+RjrJsWGV7Tna4GOBM47or4amfkgwS9dnTA0A8fuI9f
         fd9hr7OAfdsZjSmO9M3BIaM9HbiotK6Mpv1VzXFm2XCCJ4KgBhFJGAMwBizUUmdczyej
         1nUj17m6Kdrdq8+2Jfn0FT6dvSeo8jCj82eXtuK74raXdnJEM6Alvk/cfe2AiYioarQl
         zrWg==
X-Gm-Message-State: AOAM532RZHaG13NBHNEt+74PTTM50HJOan1YIRAqWcYCjxYsr3M9gmUk
        hKfisK4xCmeWilTXYEe5xw==
X-Google-Smtp-Source: ABdhPJy+zeElLxLI7Ibo9bKDD4DwXtRKnjDwB9+Pqaz2dhTAVo3YhemmXBUFCB4os7dDMwCRRFOxbw==
X-Received: by 2002:a9d:268:: with SMTP id 95mr3580655otb.148.1602006143715;
        Tue, 06 Oct 2020 10:42:23 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s13sm1252277otq.5.2020.10.06.10.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 10:42:23 -0700 (PDT)
Received: (nullmailer pid 2512736 invoked by uid 1000);
        Tue, 06 Oct 2020 17:42:22 -0000
Date:   Tue, 6 Oct 2020 12:42:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Robert Jones <rjones@gateworks.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 08/12] dt-bindings: arm: fsl: document i.MX7S boards
Message-ID: <20201006174222.GA2512673@bogus>
References: <20201001170759.9592-1-krzk@kernel.org>
 <20201001170759.9592-9-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001170759.9592-9-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Oct 2020 19:07:55 +0200, Krzysztof Kozlowski wrote:
> Document and adjust the compatibles for i.MX7S based boards.
> The Toradex boards use multiple compatibles.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
