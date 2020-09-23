Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC7F276275
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 22:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgIWUtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 16:49:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38677 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWUtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 16:49:45 -0400
Received: by mail-io1-f65.google.com with SMTP id q4so980364iop.5;
        Wed, 23 Sep 2020 13:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SEZoIRilOUkQgdmz6is7KBsKDMCVx0GX2RscOowq3a4=;
        b=XCcIQ2SvjJfCegr5BO931EmeKOL6xPiR4JLSVAYvzatmHMdUTCWO4AJ5lPD3lDtN6d
         iFfo2VtsuXD8lLk8oH1EVWtI6m017trUwGIF9U/awzbMj0VoB1Bq+XMO9XLF6AaT3m3A
         51U0+ZvMWSzB6wJYGIp88VQpAO+8U947xLm+s1zLaSefhriR41zsjuNiaVvEY6mJINGf
         ussJWsLiw16HkF7wYYrW4eI8mlqc3RFssE0zeWnJj5Oa1SPRWivZdKCmFeJwWYHLsUBY
         L66tT1uXbjcFwuPHkFsTuaU0QHvNsae5/ag4ojBve6NepzKRVT3yFr4k8a/kOotTrdLg
         /9dQ==
X-Gm-Message-State: AOAM533h83GcmzlkfRmLlri17V/Ivrvx9RYQx/puWqcFo+vcVt5alj1k
        0PaTull07gxZTplNc07T5Q==
X-Google-Smtp-Source: ABdhPJx8Y5M8zaHuUXlqoSBgCpTNAFoHkyBHg9VKVE13hTyvmUpG7GOkivebkuvon99ClivInL0BPQ==
X-Received: by 2002:a6b:f413:: with SMTP id i19mr1059413iog.125.1600894184858;
        Wed, 23 Sep 2020 13:49:44 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p8sm418586ilj.36.2020.09.23.13.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 13:49:44 -0700 (PDT)
Received: (nullmailer pid 1282310 invoked by uid 1000);
        Wed, 23 Sep 2020 20:49:42 -0000
Date:   Wed, 23 Sep 2020 14:49:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Libin <huawei.libin@huawei.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Haoyu Lv <lvhaoyu@huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-snps-arc <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH v5 4/6] dt-bindings: dw-apb-ictl: support hierarchy irq
 domain
Message-ID: <20200923204942.GA1282222@bogus>
References: <20200918112202.3418-1-thunder.leizhen@huawei.com>
 <20200918112202.3418-5-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918112202.3418-5-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 19:22:00 +0800, Zhen Lei wrote:
> Add support to use dw-apb-ictl as primary interrupt controller.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../bindings/interrupt-controller/snps,dw-apb-ictl.txt     | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
