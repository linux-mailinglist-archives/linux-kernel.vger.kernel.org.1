Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CF0290A3C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 19:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436534AbgJPRF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 13:05:57 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41852 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411016AbgJPRF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 13:05:57 -0400
Received: by mail-oi1-f196.google.com with SMTP id q136so3166914oic.8;
        Fri, 16 Oct 2020 10:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A/8zvBkLXoT4fEh9CsyvZyg2kP0as5ZRTpEA4cUQadM=;
        b=MjQEsi/VtvxR7/nCkgcyRROCZ75b5ux6SKYzVuRFDyMSBSz1/WUAy+p9Y43o8d6kJR
         Sz2U3BRYyWA/llbaAT4hc0lW02fGI47sEnSXjp8s0J2FBStPqvWjp5vrkTJz60RZOy63
         QEmQo0UM4xIymK4D9vJgKrvjYcABhcT9KOr+h8v0qL0cmu51ndk1WhPNxW1G8YXUxBgI
         lgsXK06j0RgR35LkjsLaW4U1F8dLvWDBbWYW22+QB5w8YuWWJXPOGH9cMNK1eEo1pBGg
         SnXogBXMjZVosRsRNXdeml+L7XjseO5nR3HuqDMNhQmzKDRRzQbq5enc+GdzRaSDgItY
         MU1w==
X-Gm-Message-State: AOAM530Bn+go8gmnbXFDhy9HqqtiV178xQJh7/8WbxZzU6DHvEMRYPHS
        FJpKJ/YbwvbwccqkqWw37Q==
X-Google-Smtp-Source: ABdhPJyjPngvK3jGAxGOuwhlIOYYS1zCLm3aD/Xx327eCGhbRFr2IuTXTaHPU5PXNKTwVIovqB2ljA==
X-Received: by 2002:aca:4a16:: with SMTP id x22mr3148253oia.61.1602867954905;
        Fri, 16 Oct 2020 10:05:54 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p16sm1117563otl.17.2020.10.16.10.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 10:05:54 -0700 (PDT)
Received: (nullmailer pid 1581435 invoked by uid 1000);
        Fri, 16 Oct 2020 17:05:52 -0000
Date:   Fri, 16 Oct 2020 12:05:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        CK Hu <ck.hu@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Min Guo <min.guo@mediatek.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/8] dt-bindings: phy: convert phy-mtk-tphy.txt to
 YAML schema
Message-ID: <20201016170552.GA1580710@bogus>
References: <20201013085207.17749-1-chunfeng.yun@mediatek.com>
 <20201013085207.17749-2-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013085207.17749-2-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 04:52:01PM +0800, Chunfeng Yun wrote:
> Convert phy-mtk-tphy.txt to YAML schema mediatek,tphy.yaml
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: modify description and compatible
> ---
>  .../bindings/phy/mediatek,tphy.yaml           | 263 ++++++++++++++++++
>  .../devicetree/bindings/phy/phy-mtk-tphy.txt  | 162 -----------
>  2 files changed, 263 insertions(+), 162 deletions(-)
>  create mode 100755 Documentation/devicetree/bindings/phy/mediatek,tphy.yaml

Also, need to fix the mode.

>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
