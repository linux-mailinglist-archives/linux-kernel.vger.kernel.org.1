Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307A4269A93
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 02:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgIOAm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 20:42:58 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:38473 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgIOAmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:42:51 -0400
Received: by mail-il1-f195.google.com with SMTP id t18so1393645ilp.5;
        Mon, 14 Sep 2020 17:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ljTivD9aPg+KhnR32N2OLptR9gt/0CpuWiMcqWyJCeo=;
        b=nEmetuU+yJkUC5DOd9/dIK/cd462oA0l6mQ5aTpHekYQKvpgLjZjxKUSCiOFDpMQbh
         2hhdV0l+QQVkesfBClXcjh3dSNRMlPdpGf7Hjwft5i6wntG/XJo5uvEy2U9K84KwVmZL
         u04epcJ4w82xsNhaLJxCPi7NapEl2skq43iuovegox6sPNlS37HirjPCNuOCLf3T16X1
         HAsYLazyP1g7QCRAdvhorFL0tHZUW5YRXTb9e3FYUfIsLXR0hvGVW0c4KABxyYr95/oJ
         gHFlKgKBKEYlj+tsT5yFbTWmouOvQhAAgJOOhUs76uu+65/TJdG7cUCfG6yZKwwHPkm+
         4cVg==
X-Gm-Message-State: AOAM530NkSnlqG1IJjkbMiSaku+Q9tLW+hD2ai1Kp8rc0ONofiVn2EfV
        JWjA8UhSq9LFdAzDHsVMzg==
X-Google-Smtp-Source: ABdhPJzUShX3XEFb2+9+p9Q90jl6hIT+CV75GSpVkzUUmQNVd40GkohHW2eQma8HdTG14EAHPUGGzg==
X-Received: by 2002:a05:6e02:eac:: with SMTP id u12mr9654359ilj.285.1600130570492;
        Mon, 14 Sep 2020 17:42:50 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m15sm6693979iow.9.2020.09.14.17.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 17:42:49 -0700 (PDT)
Received: (nullmailer pid 591961 invoked by uid 1000);
        Tue, 15 Sep 2020 00:42:45 -0000
Date:   Mon, 14 Sep 2020 18:42:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, Tomasz Figa <tfiga@google.com>,
        srv_heupstream@mediatek.com, devicetree@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, chao.hao@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel@vger.kernel.org, anan.sun@mediatek.com,
        ming-fan.chen@mediatek.com, youlin.pei@mediatek.com
Subject: Re: [PATCH v2 06/23] dt-bindings: mediatek: Add binding for mt8192
 IOMMU and SMI
Message-ID: <20200915004245.GA591931@bogus>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
 <20200905080920.13396-7-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905080920.13396-7-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Sep 2020 16:09:03 +0800, Yong Wu wrote:
> This patch adds decriptions for mt8192 IOMMU and SMI.
> 
> mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
> table format. The M4U-SMI HW diagram is as below:
> 
>                           EMI
>                            |
>                           M4U
>                            |
>                       ------------
>                        SMI Common
>                       ------------
>                            |
>   +-------+------+------+----------------------+-------+
>   |       |      |      |       ......         |       |
>   |       |      |      |                      |       |
> larb0   larb1  larb2  larb4     ......      larb19   larb20
> disp0   disp1   mdp    vdec                   IPE      IPE
> 
> All the connections are HW fixed, SW can NOT adjust it.
> 
> mt8192 M4U support 0~16GB iova range. we preassign different engines
> into different iova ranges:
> 
> domain-id  module     iova-range                  larbs
>    0       disp        0 ~ 4G                      larb0/1
>    1       vcodec      4G ~ 8G                     larb4/5/7
>    2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20
>    3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
>    4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5
> 
> The iova range for CCU0/1(camera control unit) is HW requirement.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        |   9 +-
>  .../mediatek,smi-common.yaml                  |   5 +-
>  .../memory-controllers/mediatek,smi-larb.yaml |   3 +-
>  include/dt-bindings/memory/mt8192-larb-port.h | 239 ++++++++++++++++++
>  4 files changed, 251 insertions(+), 5 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
