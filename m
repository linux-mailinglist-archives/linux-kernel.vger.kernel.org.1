Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F4D27D81C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgI2U3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:29:49 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46908 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgI2U3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:29:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id 95so5742693ota.13;
        Tue, 29 Sep 2020 13:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I+wPKUELaiVWs9BqMn5Wih3qfCTbkJC/1hJW4h/x+38=;
        b=hv9ZAzzZFY3pZSEnGlLf7trNuLkYklt6wEy6Z5G3PwOyFAgm/jCXZ21QyeVgCEOL6P
         V74seNxwrilN/RZKwDZ0uAm+Vf2vqX1hWsV0RuBIIGO32qVugxG+jTpjP7T+s9k9lSAU
         +CJC0aHDRBgp24ADnXdXqc+zG2naNW6g64dot0ZbkJtZ4q52EDkORbt1JzUCgrC2bB4B
         YZYoHYM3kA3nckychPtoMnc9fXZDRLPzpWQJSnSCRV1Rin5enbxoW2PBTowwydRkuuz4
         3bcNLkkqjsRputxH2K3Nadvn4PbzWahROk5ppJ7+coHjflBxbzyHs7ys1E2nMstQcEPQ
         0kvA==
X-Gm-Message-State: AOAM530FGoXwL5nbaSKtlDbcWeXW5t15BEgFQ1Iiw4WuEdElkWOzlr5m
        rEbHwfh1AJRZ/EionLSGEg==
X-Google-Smtp-Source: ABdhPJwr5ipgtH6u8uvODeHAQzCKoGI368qZYubAvw+BZEI6bpL1NfmyFiRGgAHPcWc0gTM1jncjcA==
X-Received: by 2002:a9d:7dc9:: with SMTP id k9mr3708183otn.177.1601411387622;
        Tue, 29 Sep 2020 13:29:47 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i205sm1244560oih.23.2020.09.29.13.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:29:47 -0700 (PDT)
Received: (nullmailer pid 1114100 invoked by uid 1000);
        Tue, 29 Sep 2020 20:29:46 -0000
Date:   Tue, 29 Sep 2020 15:29:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Libin <huawei.libin@huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 11/17] dt-bindings: arm: hisilicon: convert hisilicon,
 cpuctrl bindings to json-schema
Message-ID: <20200929202946.GA1114023@bogus>
References: <20200929141454.2312-1-thunder.leizhen@huawei.com>
 <20200929141454.2312-12-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929141454.2312-12-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 22:14:48 +0800, Zhen Lei wrote:
> Convert the Hisilicon CPU controller binding to DT schema format using
> json-schema.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../bindings/arm/hisilicon/controller/cpuctrl.yaml | 29 ++++++++++++++++++++++
>  .../arm/hisilicon/controller/hisilicon,cpuctrl.txt |  8 ------
>  2 files changed, 29 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml
>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt
> 

Applied, thanks!
