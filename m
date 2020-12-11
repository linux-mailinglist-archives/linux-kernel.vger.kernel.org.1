Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6729C2D6E90
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 04:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395087AbgLKD1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 22:27:53 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35865 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395079AbgLKD1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:27:32 -0500
Received: by mail-oi1-f194.google.com with SMTP id 9so1208390oiq.3;
        Thu, 10 Dec 2020 19:27:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4pSkh7E1xr7wTWhVvXeOpIs5QlUy2hJdM1nCPWkeLMQ=;
        b=BWDcQf+3G7U7JkDNhLUmMpXpgeWyAWoUDTZa9qG9SgcwZja8mPvl6TIODhY1bgrLEb
         JjtipBlrESDeTyAchF6sNgjV52jRBd+Ead0LJw04WgG5g17X7u8rDKLtLB8sQ/I/lXGM
         RL/XZ5Dw1k8t3ScT3t5glehsFuO87VsMgLDtLkxP51IvjLwnk86OMzgnRWump31HJyDD
         DuxcsScmk91B8vBqkCT4DTP8TUwCHgSv357pZi4/yJSfC2DgwnJYLBq5Hn4UP3uhd5VU
         7xObYBPJKDaCgdxFCc+Z1UTSghLnrkYrPMpqic//T1ujgxmFYaGHpjWIgGoR5X7uo60I
         ob3Q==
X-Gm-Message-State: AOAM531nMsU06dJ5bkDUbRdk2+6ANvvx5Sd8lnbeF1BoldoOmbSsaVn0
        Un3TQEJbdnaPo0+sf2I9Rw==
X-Google-Smtp-Source: ABdhPJx5205LO26MqKp6Ub/kuVoybUxxhoy/4Vq3DLkmE1Wtdx0C35k3JVlobELwVo+TakeaqYmHyg==
X-Received: by 2002:aca:5204:: with SMTP id g4mr7858444oib.91.1607657211132;
        Thu, 10 Dec 2020 19:26:51 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q18sm1473097ood.35.2020.12.10.19.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 19:26:50 -0800 (PST)
Received: (nullmailer pid 3575040 invoked by uid 1000);
        Fri, 11 Dec 2020 03:26:48 -0000
Date:   Thu, 10 Dec 2020 21:26:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        youlin.pei@mediatek.com, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, anan.sun@mediatek.com,
        Robin Murphy <robin.murphy@arm.com>,
        srv_heupstream@mediatek.com, Tomasz Figa <tfiga@google.com>,
        chao.hao@mediatek.com, Will Deacon <will@kernel.org>,
        linux-mediatek@lists.infradead.org, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Evan Green <evgreen@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH v5 05/27] dt-bindings: memory: mediatek: Rename header
 guard for SMI header file
Message-ID: <20201211032648.GA3575010@robh.at.kernel.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-6-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209080102.26626-6-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Dec 2020 16:00:40 +0800, Yong Wu wrote:
> Only rename the header guard for all the SoC larb port header file.
> No funtional change.
> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  include/dt-bindings/memory/mt2701-larb-port.h | 4 ++--
>  include/dt-bindings/memory/mt2712-larb-port.h | 4 ++--
>  include/dt-bindings/memory/mt6779-larb-port.h | 4 ++--
>  include/dt-bindings/memory/mt8167-larb-port.h | 4 ++--
>  include/dt-bindings/memory/mt8173-larb-port.h | 4 ++--
>  include/dt-bindings/memory/mt8183-larb-port.h | 4 ++--
>  6 files changed, 12 insertions(+), 12 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
