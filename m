Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F07E274634
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgIVQHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:07:51 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:40163 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgIVQHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:07:50 -0400
Received: by mail-il1-f193.google.com with SMTP id x18so15378979ila.7;
        Tue, 22 Sep 2020 09:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F7+BrvUPgVKWs+Ft1mHTZOhfkcaTDiJxgGH1Y7f/TKM=;
        b=XyWwTAPilulynU/bJX6sXm8aOE30JmNv9QWLmUNqwi7pNFxwi0xyw9O81qqC9qoD9x
         cXdg5JC03Kv4vKnMV7iwc1QAdsuGm4B0du/Ar+usSRh6MMhEgnOSj1Av53TnUnIh3xsV
         TMBVBUPKG/Yq9i9bP4Sr/6k7Bw/alORNRFw5oJ8aTzRl9QjzH9YVkwpNGtFRX9y7SQxt
         CX+/Fn2tvia99m58pPSitrAgMh/hxpx+Nb1odKNPMowYnvA5LCKCO3md/vh2I3Py6rsO
         6DSE/Rv79BLd86eqb5L+QLjB1mFUy0mryTn7yYWyLOoIrYwPfDqjxYGB6Utew3TbkklB
         aMGQ==
X-Gm-Message-State: AOAM530QSRU0sH8IECB+IqTF87lbU+1+iZ5C4eyBG8Y/VwRS/lDKXZnx
        ueK6fJUI9XN9PXRlR4flJg==
X-Google-Smtp-Source: ABdhPJyqvLH69RvwbH3NSNIYfqeuJSyfMOJ6wcBZfY7zb6r9ddzGrmuzScWO3eNeKcVGJhWVOt1L3g==
X-Received: by 2002:a92:1309:: with SMTP id 9mr4821490ilt.129.1600790869671;
        Tue, 22 Sep 2020 09:07:49 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id f1sm9083225ilh.25.2020.09.22.09.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 09:07:49 -0700 (PDT)
Received: (nullmailer pid 2773927 invoked by uid 1000);
        Tue, 22 Sep 2020 16:07:47 -0000
Date:   Tue, 22 Sep 2020 10:07:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        CK Hu <ck.hu@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: Re: [PATCH 4/4] dt-bindings: phy: convert HDMI PHY binding to YAML
 schema
Message-ID: <20200922160747.GA2773711@bogus>
References: <5af7c097d1c71a180d8ed1f1a44055859b42f1a0.1600760719.git.chunfeng.yun@mediatek.com>
 <4817a10e1c3b2beeb79b0cf5e182df747ce268e7.1600760719.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4817a10e1c3b2beeb79b0cf5e182df747ce268e7.1600760719.git.chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020 15:55:08 +0800, Chunfeng Yun wrote:
> Convert HDMI PHY binding to YAML schema mediatek,ufs-phy.yaml
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../display/mediatek/mediatek,hdmi.txt        | 17 +---
>  .../bindings/phy/mediatek,hdmi-phy.yaml       | 90 +++++++++++++++++++
>  2 files changed, 91 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.example.dt.yaml: example-0: hdmi-phy@10209100:reg:0: [0, 270569728, 0, 36] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml


See https://patchwork.ozlabs.org/patch/1368816

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

