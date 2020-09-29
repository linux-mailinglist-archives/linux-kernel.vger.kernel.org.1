Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B748C27D82C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgI2Uaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:30:35 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36770 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgI2Uae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:30:34 -0400
Received: by mail-oi1-f196.google.com with SMTP id v20so6987976oiv.3;
        Tue, 29 Sep 2020 13:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FPuz5WYxD2Tu+G8ZAl/6vtkSKIukSKn7qBbQcNvXQ6c=;
        b=GM6H1SuChKBSIncCzp/RzEZdPWfQ7q/XeExIW4WiFBCaYukraygftOtB7Oq4h7YLbc
         fwsGBz4eSdfhFiz1Oi5ha9fOfTgshj+8mZtDr4m2Wcl1+GoOVj70XHo8cP/bBX/UDXuB
         1nWVEhdK2rz/eq9bqw8XOtywn0QBLAKdNysFeIxlJRYxODPX2dUzY0FGDh14AIRcM/+G
         1MZr6GF6BlqCwEgqzBtpEDn50YYAuhooCATI+dzQXVJzwMvjZOT25IB9C71n/OtkbShW
         rzBZ0b5P8G3uVcwOABsInDi1pxz4Ll4kdup8Un8D917O1EIpQdVz4kByoEcvsMvLnejL
         ux6g==
X-Gm-Message-State: AOAM530WZ5Ynsvpg35RNBg9A4Sx/bHipGPOt5faAvSb5mURcWaXiI+Ne
        MDaC2ULZmKvckxociEt611Dqdh9Zd0c8eZI=
X-Google-Smtp-Source: ABdhPJzaRmU7TO9qK1YLGHlubybZE2VKwptF+SyTHWB/MKRoeHcdoAj6k45sOvT7OjZo0M4H7d//wQ==
X-Received: by 2002:a05:6808:9bc:: with SMTP id e28mr3696293oig.71.1601411433051;
        Tue, 29 Sep 2020 13:30:33 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v18sm3128046oof.41.2020.09.29.13.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:30:32 -0700 (PDT)
Received: (nullmailer pid 1115864 invoked by uid 1000);
        Tue, 29 Sep 2020 20:30:31 -0000
Date:   Tue, 29 Sep 2020 15:30:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Wei Xu <xuwei5@hisilicon.com>, Libin <huawei.libin@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 16/17] dt-bindings: arm: hisilicon: convert hisilicon,
 hi3798cv200-perictrl bindings to json-schema
Message-ID: <20200929203031.GA1115813@bogus>
References: <20200929141454.2312-1-thunder.leizhen@huawei.com>
 <20200929141454.2312-17-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929141454.2312-17-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 22:14:53 +0800, Zhen Lei wrote:
> Convert the Hisilicon Hi3798CV200 Peripheral Controller binding to DT
> schema format using json-schema.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../hisilicon/controller/hi3798cv200-perictrl.yaml | 64 ++++++++++++++++++++++
>  .../controller/hisilicon,hi3798cv200-perictrl.txt  | 21 -------
>  2 files changed, 64 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi3798cv200-perictrl.yaml
>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
> 

Applied, thanks!
