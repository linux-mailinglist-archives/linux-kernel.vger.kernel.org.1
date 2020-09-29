Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F6627D80E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgI2U26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:28:58 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38326 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728457AbgI2U25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:28:57 -0400
Received: by mail-oi1-f195.google.com with SMTP id 26so6959425ois.5;
        Tue, 29 Sep 2020 13:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bVoe0onCvfCMQeU1B/9WRQhbpc2VxaWoqU+E5I8kvM8=;
        b=KIWjOJfX+NX6clDmZBjImnzy1kDesTLLEFi8G5pUcVY17x05xQYDi6f7+tN4NF+BdT
         zwpVe/jSsdl+/ONM5ENvea9AoBOXD4znoYBIAbGeZCT3rFhVpzTjl7MJyFRqRMd5bYQL
         udVQ4WkqLDZ1omUH3qzYuYb93B+UtGRC1KFJhhlg/PhB+bhkZiurk7KNEndEsvfWmH2L
         gNF42deC/MO2ZqDtyVZR9nWqHRGx/dJqjTW9h//RyoFol+xS0DANH8SI6i5uCRAD1zD3
         8YAiQTlkKr74acr+V0CiScEHNQtJq+qHOliz+y5RcX+ajVBsVoR2oFDjznvYLNzlydVO
         /rJw==
X-Gm-Message-State: AOAM532ePWGFxDDLzHTLgshhIOmlCaW0QsGSCxTsN2H5APgJnoCE/w24
        2yX05SERxFs2+PYQiEylOQ==
X-Google-Smtp-Source: ABdhPJyLb/H4+yYaaRK/vYJFxCMwpI13NrBcRXjiOpWoXSXN1jcchqpv+h0bTtsXRnY3nBe3z+jesw==
X-Received: by 2002:aca:72d0:: with SMTP id p199mr3531017oic.140.1601411336991;
        Tue, 29 Sep 2020 13:28:56 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q184sm3159083ooq.40.2020.09.29.13.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:28:56 -0700 (PDT)
Received: (nullmailer pid 1112255 invoked by uid 1000);
        Tue, 29 Sep 2020 20:28:55 -0000
Date:   Tue, 29 Sep 2020 15:28:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 03/17] dt-bindings: arm: hisilicon: split the
 dt-bindings of each controller into a separate file
Message-ID: <20200929202855.GA1112120@bogus>
References: <20200929141454.2312-1-thunder.leizhen@huawei.com>
 <20200929141454.2312-4-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929141454.2312-4-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 22:14:40 +0800, Zhen Lei wrote:
> Split the devicetree bindings of each Hisilicon controller from
> hisilicon.txt into a separate file, the file name is the compatible name
> attach the .txt file name extension.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../arm/hisilicon/controller/hisilicon,cpuctrl.txt |   8 +
>  .../controller/hisilicon,hi3798cv200-perictrl.txt  |  21 +++
>  .../controller/hisilicon,hi6220-aoctrl.txt         |  18 ++
>  .../controller/hisilicon,hi6220-mediactrl.txt      |  18 ++
>  .../controller/hisilicon,hi6220-pmctrl.txt         |  18 ++
>  .../controller/hisilicon,hi6220-sysctrl.txt        |  19 ++
>  .../controller/hisilicon,hip01-sysctrl.txt         |  19 ++
>  .../controller/hisilicon,hip04-bootwrapper.txt     |   9 +
>  .../controller/hisilicon,hip04-fabric.txt          |   5 +
>  .../arm/hisilicon/controller/hisilicon,pctrl.txt   |  13 ++
>  .../arm/hisilicon/controller/hisilicon,sysctrl.txt |  25 +++
>  .../bindings/arm/hisilicon/hisilicon.txt           | 194 ---------------------
>  12 files changed, 173 insertions(+), 194 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-aoctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-pmctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-sysctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip01-sysctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-fabric.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.txt
> 

Applied, thanks!
