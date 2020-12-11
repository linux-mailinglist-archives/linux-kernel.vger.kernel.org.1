Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFEF2D6E7B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 04:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405212AbgLKDVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 22:21:16 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38563 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405196AbgLKDUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:20:12 -0500
Received: by mail-oi1-f196.google.com with SMTP id o25so8326436oie.5;
        Thu, 10 Dec 2020 19:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s3P83P57LBssVizfzonJVX27ZJaiiEw3vUl+G1G8C2A=;
        b=YJYBIwbfcO1i+meooCGH6Y173UJs0lR98g0WeqQfa71P6Cxm83w5mooSr10r/JpV7k
         x5mDuIlXw0Z0z9+INGsFA4nB76kLAbwpr3FF2tlGkvWQeKi1KOCZOtMfMBFFaZpv4oRR
         kyI9mgk+1N9YXQBmLy26kt20jhWKJHsY1NT64KbiE0d9kPUJuKsqwe60JjzHXkSIsKk7
         pBwk8XPN+MI1/i7vmDyBFuBOn9UOZewfLXxb41191Qu2dYOyaduAHgU0Sn0fADp61fLB
         zrrNF61lciqDS0Puy4jX2ok4rjI3t1anwh68GUur+hjvzFNpXHN1IzV2B8odvx+jhcYq
         WiIg==
X-Gm-Message-State: AOAM533xbrscYAFrJwuSfNS4kyPgXalqWR05G6rcRtXGjIlf5wjMvUqO
        vIkOvWvZ9HNnLIG0wnDR3Q==
X-Google-Smtp-Source: ABdhPJy7f9jT4f0a9VTi2ZrxM64YP9Ebor8koJwFtxTzBR9yGdaLztovQe5yrb0aUfaCQieDDpJ3yQ==
X-Received: by 2002:aca:b1c3:: with SMTP id a186mr7847675oif.8.1607656771855;
        Thu, 10 Dec 2020 19:19:31 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o21sm1572676otj.1.2020.12.10.19.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 19:19:31 -0800 (PST)
Received: (nullmailer pid 3565556 invoked by uid 1000);
        Fri, 11 Dec 2020 03:19:29 -0000
Date:   Thu, 10 Dec 2020 21:19:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, a.hajda@samsung.com,
        robh+dt@kernel.org, airlied@linux.ie, agx@sigxcpu.org,
        narmstrong@baylibre.com, vkoul@kernel.org, jernej.skrabec@siol.net,
        linux-imx@nxp.com, dri-devel@lists.freedesktop.org,
        jonas@kwiboo.se, robert.chiras@nxp.com, kishon@ti.com,
        kernel@pengutronix.de, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        martin.kepplinger@puri.sm, Laurent.pinchart@ideasonboard.com,
        shawnguo@kernel.org
Subject: Re: [PATCH v2 4/5] dt-bindings: phy: mixel: mipi-dsi-phy: Add Mixel
 combo PHY support for i.MX8qxp
Message-ID: <20201211031929.GA3565526@robh.at.kernel.org>
References: <1607495069-10946-1-git-send-email-victor.liu@nxp.com>
 <1607495069-10946-5-git-send-email-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1607495069-10946-5-git-send-email-victor.liu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Dec 2020 14:24:27 +0800, Liu Ying wrote:
> Add support for Mixel MIPI DPHY + LVDS PHY combo IP
> as found on Freescale i.MX8qxp SoC.
> 
> Cc: Guido Günther <agx@sigxcpu.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v1->v2:
> * Add the binding for i.MX8qxp Mixel combo PHY based on the converted binding.
>   (Guido)
> 
>  .../bindings/phy/mixel,mipi-dsi-phy.yaml           | 41 ++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
