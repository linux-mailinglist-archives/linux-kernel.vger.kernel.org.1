Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D5D27B4FF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 21:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgI1TGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 15:06:48 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40074 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgI1TGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 15:06:48 -0400
Received: by mail-ot1-f66.google.com with SMTP id c2so2031348otp.7;
        Mon, 28 Sep 2020 12:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oBC/cmBwdfL6sdeUYig1LF5jizORtNa1Qw+J7HQyje4=;
        b=JFpDABz0MLvXKiFHDTTs7FioQVdVQrycbV2FRxJKeogmBwNVMx6KbMJaUMNqOam0vh
         l3jaiDNJJLM8CSmFvr8dhykarDYjARerUl3JNCxNsVSRxPCqC9vuDNSMUKbKf7HHWO/K
         hKtDI9a1h+6eH9DGPQLin0saU9O7VCXQl82ZsRb57jYyg9bd9c0IwLkHeRxRVzK4F4nl
         TKQ3szlkOnrLyexcIOU9hrF9T2Lc0hqv6DfRSARcAHKy7sURNH+pLy7o84GYbuOwef3D
         dQ93ac0zVxkMSRRlcrRVXnmDrMYIb/zxLiIc5qSLSd7x2LN+2+ktL/Wl6vSRoqVKjqlt
         HOiA==
X-Gm-Message-State: AOAM531kyopXfua6KwVAA4dUbtH4yIjBOVEufLlToOil3MDY1iQ5/m71
        s+L2fi7HAdh12MfHZ7CX3Q==
X-Google-Smtp-Source: ABdhPJypzRwOHLNoVbChDOVBUChNaYieJ7fRo1w4XgtksExbbsIckZGcS3nHDd14P/hoGXN6U/pfQA==
X-Received: by 2002:a05:6830:22ce:: with SMTP id q14mr315840otc.72.1601320005976;
        Mon, 28 Sep 2020 12:06:45 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j1sm414829oii.5.2020.09.28.12.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 12:06:45 -0700 (PDT)
Received: (nullmailer pid 3090288 invoked by uid 1000);
        Mon, 28 Sep 2020 19:06:44 -0000
Date:   Mon, 28 Sep 2020 14:06:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 02/20] dt-bindings: arm: hisilicon: convert Hisilicon
 board/soc bindings to json-schema
Message-ID: <20200928190644.GA3090236@bogus>
References: <20200928151324.2134-1-thunder.leizhen@huawei.com>
 <20200928151324.2134-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928151324.2134-3-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020 23:13:06 +0800, Zhen Lei wrote:
> Convert Hisilicon SoC bindings to DT schema format using json-schema.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../bindings/arm/hisilicon/hisilicon.txt           | 57 --------------------
>  .../bindings/arm/hisilicon/hisilicon.yaml          | 62 ++++++++++++++++++++++
>  2 files changed, 62 insertions(+), 57 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
