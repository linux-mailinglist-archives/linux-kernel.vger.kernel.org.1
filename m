Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B8D2A86A4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbgKETCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:02:38 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:40364 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbgKETCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:02:37 -0500
Received: by mail-ej1-f68.google.com with SMTP id oq3so4145788ejb.7;
        Thu, 05 Nov 2020 11:02:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XFm1g1EiYzBluJLGmisV7ILMFqrL/YClqVXss+qbsWg=;
        b=HAiIlWfS1pHDO2t4PvmHiOSMn9zjh7dbUqDSLqQPwnxW+ERAjABPQPu2RCHSZX6r8U
         BVvedgfgysbBGn+b7P8fMNFbnzDNNMLA9Wsobyd9+o3CRwNLiZbxzCSTUYLzdlR3HBId
         qKE2dpUjLsWU+gJ2SjmEohXb7Plt+Qo9CFFiZqZmWmk6FAvR4VJg8EVZgL4PpX/M2dg2
         5u28F6rnHh6bbizpPMVzm9m7CI9ORLctmpaBZ+FyZABYlKGetpO1QbX66oLnhzSyEwYt
         R6NsMH5/Ubqlt4zchuHTHECD6YfBnKqgpCXOGjda6lQX1D/8SON/BLzIJvwGkBF9uP35
         N9WQ==
X-Gm-Message-State: AOAM532YLFish1tpj2WeKT5xrP1+0VpTYsBA8xItUqjQxfOdcwY8OLp0
        bGcXtuK0HoTHmEGqHhN1sYd1culAXyvHZQ==
X-Google-Smtp-Source: ABdhPJzaVwqw3472Feq75GhrSLPXU+RBfAY2Wt4c7vyClo62jBznXUBzGPV0Go9B4PQbXHib9moZbA==
X-Received: by 2002:a17:906:3a59:: with SMTP id a25mr3935249ejf.546.1604602955646;
        Thu, 05 Nov 2020 11:02:35 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id d11sm1439614edu.2.2020.11.05.11.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 11:02:34 -0800 (PST)
Date:   Thu, 5 Nov 2020 20:02:32 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        ming-fan.chen@mediatek.com
Subject: Re: [PATCH v5 1/3] dt-bindings: memory: mediatek: Convert SMI to DT
 schema
Message-ID: <20201105190232.GA217610@kozik-lap>
References: <20201103054200.21386-1-yong.wu@mediatek.com>
 <20201103054200.21386-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201103054200.21386-2-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 01:41:58PM +0800, Yong Wu wrote:
> Convert MediaTek SMI to DT schema.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../mediatek,smi-common.txt                   |  50 -------
>  .../mediatek,smi-common.yaml                  | 140 ++++++++++++++++++
>  .../memory-controllers/mediatek,smi-larb.txt  |  50 -------
>  .../memory-controllers/mediatek,smi-larb.yaml | 130 ++++++++++++++++
>  4 files changed, 270 insertions(+), 100 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml

Thanks, applied with Rob's tag.

Best regards,
Krzysztof

