Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A822728CEAD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgJMMtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:49:50 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41305 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgJMMtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:49:49 -0400
Received: by mail-oi1-f196.google.com with SMTP id q136so21153854oic.8;
        Tue, 13 Oct 2020 05:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h+4lx1NmWtXfOrC3rFHXIicegWjQFHB1Qz6MGdDJkro=;
        b=o9sHpTqXW2nFNeJUT+Xgmp4506jhKUYxCeTnrydwZDYP1AJCacrtpnmYwqn4jdFpW/
         GagM+s7eMz+efvyDpPS5b5MXvh9XjRJIbn7aSRMWvj83/jg5KpUPOkllahEIK4Tn34pz
         8PoNHNI55hkc3RaUKMfEWcbaiiaHFduQpMTZgwOYJNwsq02YfbLEiTcsjmDUzSty/Mb3
         zfgbbTmpT/pALGX85QQqdhEPNI9dIGn0g5AdtqUw5xucXSL9rRiuJkElzY2i3uVnKjFS
         /d09dF2+Ce8KvGLr92Rs8Mec+1FYKtTtLN+xSuWaqhEIzjQcz8Cy5OO2w4MhdUE1dueQ
         CKDQ==
X-Gm-Message-State: AOAM531dru8v7/exEIlaYXTa3w/Bugl2K6AZG4sdBhzZNqz8RwGz4Msu
        I/UzZGVRsIihqJt1Iyc+uw==
X-Google-Smtp-Source: ABdhPJzzBhpFlOx96qHNV3x8rQzmHhlP80ozoqo1sj8XLzaIjsAHsnPOnKQvXA/PKTfjxDJM1j/OZA==
X-Received: by 2002:a05:6808:f:: with SMTP id u15mr6766651oic.34.1602593388830;
        Tue, 13 Oct 2020 05:49:48 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a192sm7632544ooc.12.2020.10.13.05.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 05:49:47 -0700 (PDT)
Received: (nullmailer pid 3322788 invoked by uid 1000);
        Tue, 13 Oct 2020 12:49:46 -0000
Date:   Tue, 13 Oct 2020 07:49:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, CK Hu <ck.hu@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Daniel Vetter <daniel@ffwll.ch>, linux-usb@vger.kernel.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: Re: [PATCH v2 7/8] dt-bindings: usb: convert mediatek,mtu3.txt to
 YAML schema
Message-ID: <20201013124946.GA3322281@bogus>
References: <20201013085207.17749-1-chunfeng.yun@mediatek.com>
 <20201013085207.17749-7-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013085207.17749-7-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Oct 2020 16:52:06 +0800, Chunfeng Yun wrote:
> Convert mediatek,mtu3.txt to YAML schema mediatek,mtu3.yaml
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: new patch
> ---
>  .../devicetree/bindings/usb/mediatek,mtu3.txt | 108 ---------
>  .../bindings/usb/mediatek,mtu3.yaml           | 227 ++++++++++++++++++
>  2 files changed, 227 insertions(+), 108 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/mediatek,tphy.example.dt.yaml: usb@11271000: compatible: ['mediatek,mt8173-mtu3'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/mediatek,tphy.example.dt.yaml: usb@11271000: 'clocks' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/mediatek,tphy.example.dt.yaml: usb@11271000: 'clock-names' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml


See https://patchwork.ozlabs.org/patch/1381414

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

