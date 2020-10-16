Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA80290A40
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 19:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411032AbgJPRG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 13:06:26 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39636 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436537AbgJPRGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 13:06:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id f10so3038257otb.6;
        Fri, 16 Oct 2020 10:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qTk3r2ciTgh4me1BoYFyfE+JWDJPOXnD3hJCbfqxA5o=;
        b=C1Pt6WcSlD3No0Kh5Hw/vtlwasSwmAem3V9xnIsxjcX4+OEaEVkA7Z48cUd10/l8/A
         ewUvbwS64X3kDtCWS7TyjS9Am4PQA6aW54Lmn1ZrdBdwAbduJJeurlxH29lytxKFxEZf
         UocOHW0QNTg1POUVqiAtR+ANk8pubZwkTLDJmzDK71kNGenwWKGOCR41yjEr3MnxTmX3
         6liC4MiImKbZav8OOJdfvVBbekbBj4T0EvtWWzH2Tw90Qqv7YJImSA0PrcJfNYI5OdaW
         oRXJyi5nhhdZMKOLW6bKsvus/sJSqbGAsMSf6BcouBO15EFi/RBHns2/HDTxlRWxS8/u
         NcsQ==
X-Gm-Message-State: AOAM532Wf5x8kokZIWU3E3z1/B/riDEhy89ukJMdOcvdVKlBFrMZkDgf
        M5KdGAlKNjAbqAnuL2yhpg==
X-Google-Smtp-Source: ABdhPJyyosGHhSz7fBWayeJxfdk3OWayQGywHW7RULyDMfKvzBSgTsUyFnhJAZmvoFSE0v5DxfFSug==
X-Received: by 2002:a9d:6b99:: with SMTP id b25mr3231621otq.60.1602867984017;
        Fri, 16 Oct 2020 10:06:24 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k13sm1280277ooi.41.2020.10.16.10.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 10:06:23 -0700 (PDT)
Received: (nullmailer pid 1582215 invoked by uid 1000);
        Fri, 16 Oct 2020 17:06:22 -0000
Date:   Fri, 16 Oct 2020 12:06:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     David Airlie <airlied@linux.ie>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Min Guo <min.guo@mediatek.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: phy: convert phy-mtk-ufs.txt to YAML
 schema
Message-ID: <20201016170622.GA1582169@bogus>
References: <20201013085207.17749-1-chunfeng.yun@mediatek.com>
 <20201013085207.17749-3-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013085207.17749-3-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Oct 2020 16:52:02 +0800, Chunfeng Yun wrote:
> Convert phy-mtk-ufs.txt to YAML schema mediatek,ufs-phy.yaml
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: fix binding check warning of reg in example
> ---
>  .../bindings/phy/mediatek,ufs-phy.yaml        | 64 +++++++++++++++++++
>  .../devicetree/bindings/phy/phy-mtk-ufs.txt   | 38 -----------
>  2 files changed, 64 insertions(+), 38 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,ufs-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-ufs.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
