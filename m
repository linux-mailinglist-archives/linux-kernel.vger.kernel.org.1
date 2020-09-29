Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA12C27D6A8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgI2TRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:17:34 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33583 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgI2TRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:17:34 -0400
Received: by mail-oi1-f195.google.com with SMTP id m7so6739411oie.0;
        Tue, 29 Sep 2020 12:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1nC0es8g1NzWvZKCMmdl55CzhKqrlvkgrYx2RbaaxwI=;
        b=oWgFbLpYhpEitvkdJuEfIccnLFKtK4qeHe0ON0CLZk0yQ9HTIuZ73rRBPSR6DeP9OR
         rVRNGTnq1hwN477IaQXIR225w0ly13LY1fRD8d/WxHlae+pAhT2jljvX5eiFJYFVJ47D
         8ooA74r0Jgalgs9iiRJoobMOxW4Vbxwf2nUlUpqjea7fuu9ptdLXbpRQsc3yxzVOkjDH
         vcALC4vchG6w/pPQ2Dt7m5x8QsU9WJOLXHwOGJZ9lMa/M/l71qMtPWYdyItyaHdul5e7
         o51kDNlW3buMQNytDvnwnIZFAdaxxUlpX7dEI4ols/BTuEUnYfzREWv69XEQOu9hmfRn
         9NVg==
X-Gm-Message-State: AOAM531zhi4eDVmcE305LuP4nZcT+JzsoQoISeSJksXJdXmPFJOMBOJS
        OxS/LQTZ/GdniYJlJbTKYQ==
X-Google-Smtp-Source: ABdhPJwerSdv84ElY01cBKGCLTfBwf+LqEnwAzs6JtZzwtxf596RvSIa0KtYdCIziTBN7ekTg+Ouag==
X-Received: by 2002:aca:f5cc:: with SMTP id t195mr3665021oih.10.1601407053294;
        Tue, 29 Sep 2020 12:17:33 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f29sm3069037ook.44.2020.09.29.12.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 12:17:32 -0700 (PDT)
Received: (nullmailer pid 996225 invoked by uid 1000);
        Tue, 29 Sep 2020 19:17:31 -0000
Date:   Tue, 29 Sep 2020 14:17:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Li Yang <leoyang.li@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/14] dt-bindings: arm: fsl: document i.MX51 boards
Message-ID: <20200929191731.GA996191@bogus>
References: <20200926162811.5335-1-krzk@kernel.org>
 <20200926162811.5335-7-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926162811.5335-7-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 18:28:04 +0200, Krzysztof Kozlowski wrote:
> Document and adjust the compatibles for i.MX51 based boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          | 24 ++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
