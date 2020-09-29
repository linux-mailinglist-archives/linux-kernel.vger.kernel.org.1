Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5106227D819
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgI2U3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:29:41 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45379 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgI2U3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:29:40 -0400
Received: by mail-ot1-f65.google.com with SMTP id g96so5756804otb.12;
        Tue, 29 Sep 2020 13:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J2L6qugPACwpXfS1RWLXbtld+MIcJwvuegC+/efYoN4=;
        b=kGjq4FeSZwjjdUQf0q1WaqS7cZIczmjm2GQLhMldBMivg+9l+CXw/J8r8QxAcvnYY0
         29ktwJzE7syoN+huZoNVyl5EIbOuEK/3M2hYomdXf5fDGClwQ/b5G6S94Ncxy/TvoLRt
         fMbF4Xb8DtgYUFzkLZc4ubEavKFjlsaCJu+f2vDiKkrMMDQoSflbm5cIQRxeJs+/lAKN
         k+4/Yb8AmB0dZsCGyoc2kxg1deT1d37+kC7X2VgwTBVuZ7MOwjvvox8YTqSdSAmsW9fy
         KdsgIXA9m8RH4SArbcIBUv7BtVROW7rm2YRk/Ou6cG+qjO5U8xYm3zBzNzDcHWHEafop
         zC6A==
X-Gm-Message-State: AOAM530gfkwP8uW+YGwuBC7meszgVW/Uc8nO0wmBRmKMRWg9aax4N2vX
        lx2Kb0rwQyZiZMYFovv+vg==
X-Google-Smtp-Source: ABdhPJw+lDuc1OptR8BHPJo+IOImjZJ7Mhv9y47R1rZrwTOYqHbXVhU3WQacPPmAzxYtIS9bnjAxDw==
X-Received: by 2002:a05:6830:15d8:: with SMTP id j24mr3814544otr.361.1601411379766;
        Tue, 29 Sep 2020 13:29:39 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f194sm1227920oib.44.2020.09.29.13.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:29:39 -0700 (PDT)
Received: (nullmailer pid 1113728 invoked by uid 1000);
        Tue, 29 Sep 2020 20:29:38 -0000
Date:   Tue, 29 Sep 2020 15:29:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Libin <huawei.libin@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 10/17] dt-bindings: arm: hisilicon: convert system
 controller bindings to json-schema
Message-ID: <20200929202938.GA1113646@bogus>
References: <20200929141454.2312-1-thunder.leizhen@huawei.com>
 <20200929141454.2312-11-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929141454.2312-11-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 22:14:47 +0800, Zhen Lei wrote:
> Convert the Hisilicon system controller and its variants binding to DT
> schema format using json-schema. All of them are grouped into one yaml
> file, to help users understand differences and avoid repeated
> descriptions.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../controller/hisilicon,hi6220-sysctrl.txt        |  19 ----
>  .../controller/hisilicon,hip01-sysctrl.txt         |  19 ----
>  .../arm/hisilicon/controller/hisilicon,sysctrl.txt |  25 -----
>  .../bindings/arm/hisilicon/controller/sysctrl.yaml | 110 +++++++++++++++++++++
>  .../bindings/arm/hisilicon/hi3519-sysctrl.txt      |  14 ---
>  5 files changed, 110 insertions(+), 77 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-sysctrl.txt
>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip01-sysctrl.txt
>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/sysctrl.yaml
>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt
> 

Applied, thanks!
