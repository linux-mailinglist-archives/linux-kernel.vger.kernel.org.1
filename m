Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666D427461A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgIVQE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:04:58 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:40830 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgIVQEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:04:55 -0400
Received: by mail-il1-f194.google.com with SMTP id x18so15368528ila.7;
        Tue, 22 Sep 2020 09:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CKfLdUexUfPdpjwTDlKQ3XKMxqzDUbFupt+mG72mDMc=;
        b=dgE6Jil8q7+/PT/svwXC26D+wNn+A/+9mS0h06YlkYNsTqiymvjYpWJClrI1GOKhRf
         7AQWjcn6XtThXI6jqCC6fZkQBWT9pl4lySvRFJM4e6RX7kLle3YgP39C1s3nPiDf+k5H
         KFYYAGfxkjZ8D3NsZRpHsmGt4kKMMMcMBPyyniZri9/F1vvequfIyi6DWhJNRgkQoXoy
         AOJv4WLexqGizs0V5VA41QVpzZxF67z8kZqF2SQInVsaf2iHO3KqOTJ7bM8JBqq4SZ6i
         JBga48TeAv+pPxDrV7V5ghZq3I8El6CZCO4mGpW4Wqo1NtN4vlxhl6pEO/0oVuY90AJt
         FXRA==
X-Gm-Message-State: AOAM533dLkdy2ETBrma5hgraIqP96uhl/q95J4GjTbGGsLw8OsnfUD4N
        XEXh9Oban2XgCdZQIj3m9A==
X-Google-Smtp-Source: ABdhPJyGE4qpjft/53rjEnM1nes6ybplFwv2lRkqN4ajfiISqxLZHyh9XWi1DNlUUSO+vOKKTAg4Fw==
X-Received: by 2002:a92:730b:: with SMTP id o11mr4773209ilc.91.1600790694176;
        Tue, 22 Sep 2020 09:04:54 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k2sm7557712ioj.2.2020.09.22.09.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 09:04:53 -0700 (PDT)
Received: (nullmailer pid 2769164 invoked by uid 1000);
        Tue, 22 Sep 2020 16:04:52 -0000
Date:   Tue, 22 Sep 2020 10:04:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Stanley Chu <stanley.chu@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, linux-mediatek@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: phy: convert phy-mtk-tphy.txt to YAML
 schema
Message-ID: <20200922160452.GA2768616@bogus>
References: <5af7c097d1c71a180d8ed1f1a44055859b42f1a0.1600760719.git.chunfeng.yun@mediatek.com>
 <33b4c569db10d983c7a9485a8bd6ec4efc0a1242.1600760719.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33b4c569db10d983c7a9485a8bd6ec4efc0a1242.1600760719.git.chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020 15:55:06 +0800, Chunfeng Yun wrote:
> Convert phy-mtk-tphy.txt to YAML schema mediatek,tphy.yaml
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../bindings/phy/mediatek,tphy.yaml           | 260 ++++++++++++++++++
>  .../devicetree/bindings/phy/phy-mtk-tphy.txt  | 162 -----------
>  2 files changed, 260 insertions(+), 162 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/mediatek,tphy.example.dt.yaml: t-phy@11290000: usb-phy@11290800:clocks: [[4294967295, 15]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/mediatek,tphy.example.dt.yaml: t-phy@11290000: usb-phy@11290800:clock-names: ['ref'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/mediatek,tphy.example.dt.yaml: t-phy@11290000: usb-phy@11290900:clocks: [[4294967295]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/mediatek,tphy.example.dt.yaml: t-phy@11290000: usb-phy@11290900:clock-names: ['ref'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/mediatek,tphy.example.dt.yaml: t-phy@11290000: usb-phy@11291000:clocks: [[4294967295, 15]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/mediatek,tphy.example.dt.yaml: t-phy@11290000: usb-phy@11291000:clock-names: ['ref'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml


See https://patchwork.ozlabs.org/patch/1368817

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

