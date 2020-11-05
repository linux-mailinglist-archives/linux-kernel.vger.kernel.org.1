Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6603C2A8630
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbgKESjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:39:24 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38201 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKESjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:39:23 -0500
Received: by mail-ot1-f68.google.com with SMTP id b2so2367660ots.5;
        Thu, 05 Nov 2020 10:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oPwP/MMeCFhUmSj7N3WE3Z62TN2tMAgfxgbJBwkddp4=;
        b=OSkAigvl4a+1KT+tzxetTTYkdhhGXtmh1efUNVpsjCZQxqn9yp5RC+UwlIkMf7bAVE
         WHFKOIr1yQkhHrKKmv5Viv2AMiqQxntBsUkqYkaGbTPUMWygj9mQGeLUH4k6SAfeWatG
         T0ygSN0zzO8HhP4NJRmWb1dbEkfaJ57/iMC+0Os6H1M26opUwuWwG303jVq3Epjds+TP
         SFwTUQWgYAGh3JycFxI9o9oXdR/yniTg6asVdYlvvlLnsZ+jUJi2Gd+s7bJTWhEnmn+V
         9knRmIaPJgdjFxJE2TE3lZ9TACRu80A0WeBEVY9yTAHWT6MqmcjH+DRWkAMnc/hpOo5h
         cacw==
X-Gm-Message-State: AOAM530OEXrkSPGOWnqGUm/4lzPrMNEMQ6VsSrHZIo5yZ85upoN7gVi/
        lhVY8cE2QB+g/u0kFYxXtg==
X-Google-Smtp-Source: ABdhPJzRBgP5+/f3MDZQcsFSgW1dFGhtocXexNDBCjlPVJJSHJJGb717wfAecWqYjVCmXRQb6VMRYA==
X-Received: by 2002:a05:6830:1dab:: with SMTP id z11mr2479004oti.247.1604601562347;
        Thu, 05 Nov 2020 10:39:22 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j3sm556796oij.9.2020.11.05.10.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:39:21 -0800 (PST)
Received: (nullmailer pid 1607749 invoked by uid 1000);
        Thu, 05 Nov 2020 18:39:20 -0000
Date:   Thu, 5 Nov 2020 12:39:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        youlin.pei@mediatek.com, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, ming-fan.chen@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-mediatek@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>, Will Deacon <will@kernel.org>,
        anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com
Subject: Re: [PATCH v5 1/3] dt-bindings: memory: mediatek: Convert SMI to DT
 schema
Message-ID: <20201105183920.GA1607689@bogus>
References: <20201103054200.21386-1-yong.wu@mediatek.com>
 <20201103054200.21386-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103054200.21386-2-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Nov 2020 13:41:58 +0800, Yong Wu wrote:
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
> 

Reviewed-by: Rob Herring <robh@kernel.org>
