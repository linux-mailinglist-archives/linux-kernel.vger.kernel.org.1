Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87ACB2762AD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 23:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgIWVBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 17:01:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34890 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgIWVBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 17:01:02 -0400
Received: by mail-io1-f66.google.com with SMTP id r9so1042797ioa.2;
        Wed, 23 Sep 2020 14:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mg90ElUtiZesMw1UUe+/w2NeHYCEFaTIe1YGqzCbx7Y=;
        b=Hdj1Q6sfh8aWKZTroFaIm8EDCqc1FvIo7wyqMmgg7rKEYUaby7j+JsjoEjmzEOHUvh
         q/R43lmCN8TGg4lpS0uWcYGt8Wj1sqRUIE08wNSCjdwwbkdzmQccCzoT3jucGEb+Lyev
         No25QHXa4pgHjLokdmOpAK/x1HiIUYG0vaobQRJo41+tNYbdbdmnX2TydHs6rJPeytTR
         iqDwV15MwCiv6i8nKiIHLDZBUYaRXlpmX7GMvuefu8Kg26+ajyQhePV47oZbkW2/ifHY
         exa0SguT5ef/UgI/+xJBPnN3CBlp4g7d9hZJLqU4l3vLxrXvFEbzHnc4exNrnjdrybT/
         pp6A==
X-Gm-Message-State: AOAM531klaSAzYq85x9SeQZ8JVPsRnWFXXfVpCpwbOdqzXXlz6/KbfJM
        F6kCm0dZo1su7OuUiDrUMQ==
X-Google-Smtp-Source: ABdhPJy2JsWYXI/YLqkuIPMOoF3F5q8pl7grjT3yFAYPqRbXSDesdobyBdbksEcQnTaMM5Ct55J6HA==
X-Received: by 2002:a02:91c5:: with SMTP id s5mr1022369jag.133.1600894861563;
        Wed, 23 Sep 2020 14:01:01 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y8sm392518iln.17.2020.09.23.14.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 14:01:00 -0700 (PDT)
Received: (nullmailer pid 1300598 invoked by uid 1000);
        Wed, 23 Sep 2020 21:00:59 -0000
Date:   Wed, 23 Sep 2020 15:00:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Libin <huawei.libin@huawei.com>
Subject: Re: [PATCH 1/1] dt-bindings: sp804: add support for Hisilicon sp804
 timer
Message-ID: <20200923210059.GA1300521@bogus>
References: <20200919124412.4135-1-thunder.leizhen@huawei.com>
 <20200919124412.4135-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919124412.4135-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Sep 2020 20:44:12 +0800, Zhen Lei wrote:
> Some Hisilicon SoCs, such as Hi1212, use the Hisilicon extended sp804
> timer.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/timer/arm,sp804.yaml | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

Applied, thanks!
