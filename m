Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4F226AA06
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 18:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgIOQlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 12:41:31 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35176 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbgIOP4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:56:47 -0400
Received: by mail-io1-f67.google.com with SMTP id r9so4652877ioa.2;
        Tue, 15 Sep 2020 08:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qq/umR2+igR2EbykY/qBvvF56Ie8JdULF4COjV3FUEE=;
        b=uQJFfou2KgCjpkA+p7JQKI0DDmqLB/n+bjkpMfEnQ3BtiNNUXvWV3sBHW17x8/FcVC
         mkYK+muYIJzTl+k1NLfC6thWLRXu1LzcSco4Lj69+BeDmtRftSy9nJj6tOqAREb6Iqr8
         K+2Ps+YKf0FX0i9iSC7tK3xKPBoRcWKjnbkLYnKXZMuRQeCTY86LoxwBWVcHJC8VPfvU
         ZEGPnhsuUMeNLkRoEO2AKsr+1BRclJdUJHU+4pAlQ/CT9ZSCNESYxT2ditjogp7SZCzK
         vMzd20L21HdpqCLGg5+VzlOZcddciENItQMl8L1xCLRgp/V0NmPBvWOUOjbkqa/Ykhl6
         NagA==
X-Gm-Message-State: AOAM5313+ktTGd5pqJQiZBrnlEVOb0o6GsENPW+c6Fsp7Pr/S04Gx081
        45Tm3h9UARVxsFY/AMFvlw==
X-Google-Smtp-Source: ABdhPJwM8FrqARUef6Insy0Hs85VhiHCgHuUtmKvLN32AAutZdzyMDMACDHa7+pa7wHE4mHOR7TOLg==
X-Received: by 2002:a6b:8b52:: with SMTP id n79mr15470287iod.122.1600185406059;
        Tue, 15 Sep 2020 08:56:46 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id l16sm9157487ilc.3.2020.09.15.08.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 08:56:45 -0700 (PDT)
Received: (nullmailer pid 2022676 invoked by uid 1000);
        Tue, 15 Sep 2020 15:56:41 -0000
Date:   Tue, 15 Sep 2020 09:56:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     matthias.bgg@gmail.com, krzk@kernel.org,
        linux-mediatek@lists.infradead.org, mars.cheng@mediatek.com,
        ck.hu@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        robh+dt@kernel.org, owen.chen@mediatek.com,
        macpaul.lin@mediatek.com, devicetree@vger.kernel.org,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        wendell.lin@mediatek.com, enric.balletbo@collabora.com
Subject: Re: [PATCH 1/2] dt-bindings: clock: mediatek: add bindings for
 MT8167 clocks
Message-ID: <20200915155641.GA2022646@bogus>
References: <20200907125646.1946282-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907125646.1946282-1-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Sep 2020 14:56:45 +0200, Fabien Parent wrote:
> Add binding documentation for topckgen, apmixedsys, infracfg, audsys,
> imgsys, mfgcfg, mmsys, vdecsys on MT8167 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../arm/mediatek/mediatek,apmixedsys.txt      |   1 +
>  .../bindings/arm/mediatek/mediatek,audsys.txt |   1 +
>  .../bindings/arm/mediatek/mediatek,imgsys.txt |   1 +
>  .../arm/mediatek/mediatek,infracfg.txt        |   1 +
>  .../bindings/arm/mediatek/mediatek,mfgcfg.txt |   1 +
>  .../arm/mediatek/mediatek,topckgen.txt        |   1 +
>  .../arm/mediatek/mediatek,vdecsys.txt         |   1 +
>  include/dt-bindings/clock/mt8167-clk.h        | 131 ++++++++++++++++++
>  8 files changed, 138 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mt8167-clk.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
