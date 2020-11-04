Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722522A7022
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 23:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbgKDWEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 17:04:24 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43183 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732101AbgKDWEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 17:04:11 -0500
Received: by mail-oi1-f194.google.com with SMTP id t143so12281059oif.10;
        Wed, 04 Nov 2020 14:04:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RoHmyvawdfHUv1CllgHUwLfDLAfJEk1MgJAjHKAD5jA=;
        b=p2uKIPq3dHfTBDcu65eIHl077CKl6xP/hr6X87FG/T/yRtbbsascWCibfp798hVbJa
         XwO7Cdrru4aMZHuKB53Qep1wL16zzzwNeHN2r/b691nLdiFsZHKilxesczNLRkdOUpw3
         TsUz2S5oA7j6kBh/gfSVQS7kQD8uxvlDvYnrzjp/guQdgeY4CoADP7axQsHKC9fvlHu4
         YfAzJsCQVELBmjPBFpwPBpEn14WiVGhXTTvuAwS+MkoIDhoU8cdc/qZ2WawIlIEi5Xit
         hscz56EBAnAJL4X+jBZGGxx23Ij2bAgpLo74y6q3g0W8Qac1a0pR2MALasmCyg1lPCDe
         kuJw==
X-Gm-Message-State: AOAM533aiuiEA1yUQy5ggT8QJxHiUVCrVdcR/JFCuYBgJwZ6cv48elIa
        ycAX/8oKU50tpPJHsvXva5j9tqbGfw==
X-Google-Smtp-Source: ABdhPJzGaxwmDh+Yc5KevScWJsbFrWd7wFC9hqALT0pF0pIQ2haITx+cA93FaOeVFC4wgMEYwWoNoA==
X-Received: by 2002:aca:2405:: with SMTP id n5mr4037469oic.9.1604527449714;
        Wed, 04 Nov 2020 14:04:09 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m10sm831660oon.27.2020.11.04.14.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 14:04:09 -0800 (PST)
Received: (nullmailer pid 8016 invoked by uid 1000);
        Wed, 04 Nov 2020 22:04:08 -0000
Date:   Wed, 4 Nov 2020 16:04:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        fparent@baylibre.com, Collabora Kernel ML <kernel@collabora.com>,
        linux-arm-kernel@lists.infradead.org, drinkcat@chromium.org,
        linux-mediatek@lists.infradead.org, weiyi.lu@mediatek.com,
        matthias.bgg@gmail.com, hsinyi@chromium.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 14/16] dt-bindings: power: Add MT8192 power domains
Message-ID: <20201104220408.GA7986@bogus>
References: <20201030113622.201188-1-enric.balletbo@collabora.com>
 <20201030113622.201188-15-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030113622.201188-15-enric.balletbo@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 12:36:20 +0100, Enric Balletbo i Serra wrote:
> From: Weiyi Lu <weiyi.lu@mediatek.com>
> 
> Add power domains dt-bindings for MT8192.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  .../power/mediatek,power-controller.yaml      |  2 ++
>  include/dt-bindings/power/mt8192-power.h      | 32 +++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt8192-power.h
> 

Acked-by: Rob Herring <robh@kernel.org>
