Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF64327462D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgIVQHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:07:21 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35296 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgIVQHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:07:21 -0400
Received: by mail-io1-f65.google.com with SMTP id r9so20248481ioa.2;
        Tue, 22 Sep 2020 09:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zF77TzjrjYmXHXCkSrv/gVnYfB2PIU90P8T+fzmt7Pk=;
        b=TT9BpfNvl1D+QrKULfDVXIgWzho+XAvUS57/zUHpevl7PoOVOS/9EqBXKz1P5SZ6YJ
         baWeE82EaylFDuSoFtWzHOvF64gXYVlaHddZQGVBQ8oPQWXebkDF71j3+jBPbKqPBPCu
         eb92GxHmRiZStA9Z9PkOMr/0Y/ODjDg9GP8PFWhWtTxy25zz2PSQljzm1BRzewQamg4R
         A/Xl7anppKeChBNTFJYCmKXsf3FnIBIF9WVJ+khf1Indg+tUY96mEe29OoyaKz94sZNK
         GaPcS4m3nlbGYiXWJ/CPTsHrI2kY1djDBQPVPPYLSCZv9L4FsmfvTdhY/06OYVCvXo8i
         YgoA==
X-Gm-Message-State: AOAM533MHCyltZ0orA22pnTvdrMQFKHMe4cCTcqiHuAxj3BOw17obMk2
        qGeYkCkAPDukJhJTQi8sOA==
X-Google-Smtp-Source: ABdhPJzt0CvS500bgQNFVROZZ0PumLBOgLUdWUuWg7zB0QotcFRl7mSab3HVsaqhvkXOoytRw5oRZg==
X-Received: by 2002:a05:6602:2013:: with SMTP id y19mr3976939iod.148.1600790840376;
        Tue, 22 Sep 2020 09:07:20 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id 2sm5005397iow.4.2020.09.22.09.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 09:07:19 -0700 (PDT)
Received: (nullmailer pid 2773058 invoked by uid 1000);
        Tue, 22 Sep 2020 16:07:18 -0000
Date:   Tue, 22 Sep 2020 10:07:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/4] dt-bindings: phy: convert phy-mtk-ufs.txt to YAML
 schema
Message-ID: <20200922160718.GA2772140@bogus>
References: <5af7c097d1c71a180d8ed1f1a44055859b42f1a0.1600760719.git.chunfeng.yun@mediatek.com>
 <006ecd5b88fd7d23a355f2522c37e745f72ac45a.1600760719.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006ecd5b88fd7d23a355f2522c37e745f72ac45a.1600760719.git.chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020 15:55:07 +0800, Chunfeng Yun wrote:
> Convert phy-mtk-ufs.txt to YAML schema mediatek,ufs-phy.yaml
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../bindings/phy/mediatek,ufs-phy.yaml        | 64 +++++++++++++++++++
>  .../devicetree/bindings/phy/phy-mtk-ufs.txt   | 38 -----------
>  2 files changed, 64 insertions(+), 38 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,ufs-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-ufs.txt
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/mediatek,ufs-phy.example.dt.yaml: example-0: ufs-phy@11fa0000:reg:0: [0, 301596672, 0, 49152] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml


See https://patchwork.ozlabs.org/patch/1368813

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

