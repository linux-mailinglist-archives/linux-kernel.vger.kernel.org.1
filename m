Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EE327D822
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgI2UaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:30:06 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41683 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgI2UaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:30:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id x69so6955197oia.8;
        Tue, 29 Sep 2020 13:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=23GPEEbYq65wXZdHHL0RqZoE2ylTNiIegyVwYZU6NEo=;
        b=pBs39ipEc1bZa5Yu+HZj8qA+AzoXmCMJ6OMj7EzbI2fn8u5UyrRjJ8vrOLWT/rzTrt
         6ZA8KaS+zz2xbNbcA38mdfSgmrrmC9XswDBfsj6nwcC+K2vzPzUKyCUQSpUDBMLH84TV
         gd5yevF5yZVtRiRR7cRfNJ/vyaoA0iMcpC0/zUZ5SkKVer0QF/P4kV+v/Q90Bms7w8Hn
         LV/h0CCr5AZ0damJpFpYQFpjrYgL+qtmVbcxUZKlsd/oGylqf6qhvXyztH2DTdNnx+kU
         Q/5VGDiKc4FMQb78nQooVDJNEQUvBx9XjzsSQJm40FWUs4uXNVwY7WBkMxQERSCBGLus
         M6GA==
X-Gm-Message-State: AOAM532N9mM9XKnFt/+Nt9PB9lESaoF/TlWqFiYpdR/ojwW3vgzUE1uP
        pBNtPe9DdJKuUojc9TwC3g==
X-Google-Smtp-Source: ABdhPJx6QuSOv1TuvdLNjOPCtV4KIIBgO50LU3VwPtOUZW0YPYkYvmoUXE5w3+M2BEgYXs3SgWFnAQ==
X-Received: by 2002:aca:bd8a:: with SMTP id n132mr3680368oif.100.1601411404292;
        Tue, 29 Sep 2020 13:30:04 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 65sm1244413otj.75.2020.09.29.13.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:30:03 -0700 (PDT)
Received: (nullmailer pid 1114883 invoked by uid 1000);
        Tue, 29 Sep 2020 20:30:03 -0000
Date:   Tue, 29 Sep 2020 15:30:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: Re: [PATCH v5 13/17] dt-bindings: arm: hisilicon: convert hisilicon,
 hip04-fabric bindings to json-schema
Message-ID: <20200929203003.GA1114836@bogus>
References: <20200929141454.2312-1-thunder.leizhen@huawei.com>
 <20200929141454.2312-14-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929141454.2312-14-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 22:14:50 +0800, Zhen Lei wrote:
> Convert the Hisilicon Fabric controller binding to DT schema format using
> json-schema.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../arm/hisilicon/controller/hip04-fabric.yaml     | 27 ++++++++++++++++++++++
>  .../controller/hisilicon,hip04-fabric.txt          |  5 ----
>  2 files changed, 27 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hip04-fabric.yaml
>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-fabric.txt
> 

Applied, thanks!
