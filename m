Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716BF27D832
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgI2Uau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:30:50 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:47008 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbgI2Uas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:30:48 -0400
Received: by mail-oo1-f65.google.com with SMTP id b12so1630004oop.13;
        Tue, 29 Sep 2020 13:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ysicr+OljWVIkPaDnn1tgtJ552TftNwDVmnL4IPy1Vw=;
        b=KV1G7Tv1t0IvO1ZG4Ke+zB/PX048874M2UyRd4XcR44WjffnK2SFyCQqb3NZwt/D/H
         aJR+rJ66tRW/qdXQ2XpAkFIG3uUDRGp/4PszdXOPdlZqu2R1K3GndJ7mSF0bbK9IrYlP
         YMAISxpZYmbI6tAUR/m03XUk0WOOFKU4CXaQfhRP5KavnFi3r7k8YLM7Evf0fLQrDKit
         oXObFikqyumC/7o8H1vw02kPmt8W3MT/V/HytW1zGDwliTVIiVhGjX5qSoLrA9qMap6i
         UCUF9pFX6CbM2k0CElMCl+wbzlTxaXk8R2RMcy9Zg5ve0b76iDEi2N6mdBxNuc9RP07P
         hg2g==
X-Gm-Message-State: AOAM533oGCcDLvIk1HlxxOmrcd0U9yrLSivfrAVwHjYcae/oqw5P1o/H
        q5mhehcZ8nlBmB4pmae5iK7go5hwEPPoo6s=
X-Google-Smtp-Source: ABdhPJzthx1/V+C6uaz2ytlIzWVBDJkOcgLaPnHZxWaHlN9OivG5ndu6bmucQ7V6Rq54cfiV2MRAwA==
X-Received: by 2002:a4a:2c02:: with SMTP id o2mr5874345ooo.24.1601411447443;
        Tue, 29 Sep 2020 13:30:47 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f11sm3205239oot.4.2020.09.29.13.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:30:46 -0700 (PDT)
Received: (nullmailer pid 1116407 invoked by uid 1000);
        Tue, 29 Sep 2020 20:30:45 -0000
Date:   Tue, 29 Sep 2020 15:30:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Libin <huawei.libin@huawei.com>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 17/17] dt-bindings: arm: hisilicon: convert LPC
 controller bindings to json-schema
Message-ID: <20200929203045.GA1116288@bogus>
References: <20200929141454.2312-1-thunder.leizhen@huawei.com>
 <20200929141454.2312-18-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929141454.2312-18-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 22:14:54 +0800, Zhen Lei wrote:
> Convert the Hisilicon Hip06 SoCs implement a Low Pin Count (LPC)
> controller binding to DT schema format using json-schema.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../arm/hisilicon/hisilicon-low-pin-count.txt      | 33 ------------
>  .../bindings/arm/hisilicon/low-pin-count.yaml      | 61 ++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/low-pin-count.yaml
> 

Applied, thanks!
