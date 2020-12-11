Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140A82D80A1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 22:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405267AbgLKVNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 16:13:18 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43199 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395275AbgLKVMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 16:12:23 -0500
Received: by mail-oi1-f193.google.com with SMTP id q25so11394628oij.10;
        Fri, 11 Dec 2020 13:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+QcwYARcq+TOO4C9gXJwXmDec1Cs70baMFzxTjYLSAY=;
        b=U+4QHP999YI64snf9HElpfWw43vUrBUCIPzJ9anptk1rtxR+fV7rhqqgs7ioahVS2Y
         mU41ZprUX9J/9l5cfLWLHCfz0tE0aUY0jsRYoFNZVtPpVP/obe9V+O6ypOcigpdSv3rN
         PqerKmMgr0KaC+ieol4cKcPaKMIcUVUdydXfst++TvP2WMrqJJwiX53K6evBhuLFmMQ+
         xmgQUMTGYD77+xKXp04NTX87YSXLesaIcujWYzk7oWa3kTxCsdx98kBh5IGvAFhL8BRm
         qsIeS0/UcYFgBon6c2Du3l6syVWaEEzY1EFHuyjPnkIyLQYt4oZcbO3vBD3OqrCXTJ/6
         PxbA==
X-Gm-Message-State: AOAM530nNJ+K90pY08MZqyh7vF95FZ/PuN99wvzaeYJSUgsm3YmC4n5W
        KZKvwS4/QcBjep6Zp/0b/sa9nsZo5w==
X-Google-Smtp-Source: ABdhPJwsNO3Sd0i4xG8R+1DDF1vPbIPz9yVwmkoU/5YeM2BQv7rSfZvpzd/Fdc8BXMhpv+Jn0EGnCQ==
X-Received: by 2002:a05:6808:3bc:: with SMTP id n28mr10918843oie.118.1607721101287;
        Fri, 11 Dec 2020 13:11:41 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w40sm1636821ooi.41.2020.12.11.13.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 13:11:38 -0800 (PST)
Received: (nullmailer pid 947560 invoked by uid 1000);
        Fri, 11 Dec 2020 21:11:37 -0000
Date:   Fri, 11 Dec 2020 15:11:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        martin.kepplinger@puri.sm, Laurent.pinchart@ideasonboard.com,
        jernej.skrabec@siol.net, vkoul@kernel.org, jonas@kwiboo.se,
        narmstrong@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kishon@ti.com, kernel@pengutronix.de,
        linux-imx@nxp.com, dri-devel@lists.freedesktop.org,
        robert.chiras@nxp.com, a.hajda@samsung.com, airlied@linux.ie,
        agx@sigxcpu.org
Subject: Re: [PATCH v3 4/5] dt-bindings: phy: mixel: mipi-dsi-phy: Add Mixel
 combo PHY support for i.MX8qxp
Message-ID: <20201211211137.GA946445@robh.at.kernel.org>
References: <1607651182-12307-1-git-send-email-victor.liu@nxp.com>
 <1607651182-12307-5-git-send-email-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1607651182-12307-5-git-send-email-victor.liu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Dec 2020 09:46:21 +0800, Liu Ying wrote:
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
> v2->v3:
> * No change.
> 
> v1->v2:
> * Add the binding for i.MX8qxp Mixel combo PHY based on the converted binding.
>   (Guido)
> 
>  .../bindings/phy/mixel,mipi-dsi-phy.yaml           | 41 ++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
