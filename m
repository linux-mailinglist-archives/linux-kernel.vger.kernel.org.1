Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC912D5CDA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 15:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389813AbgLJODb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 09:03:31 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38725 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731725AbgLJOCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:02:38 -0500
Received: by mail-ot1-f65.google.com with SMTP id j20so440581otq.5;
        Thu, 10 Dec 2020 06:02:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gzXVrkHTuYt7eLZS3ECwj/trOu0cvJFlQnkF6qE3+w8=;
        b=XC6FxctKhcUZdWSm5QR+I6mKfqNeQ0r1iuH3IV0QOD2o2La5d6XZ9nYbVY8HXnnlYC
         qmKnCoNa47KWQzGy9ZmHhDFcNn+chnZoxyCxRteS2X6H5Q2iOIy5VB5Tg/iLM+raj5xT
         4cihNS9eRFZVCHO62uD676D7h3FzRcT5ZSWOlgh16UyzSKn4ZAXwAk7MGArx9HJ5L+Ik
         PgFG6/5uUCTwLQG9agT4G1QyC35GYGq6SnCeFQ3942eUc56fUwiaIzrGyZqIcttV1ARz
         +vM5DDOKmunfh/1/lKNZHEQ/V6pVZWbaag2ngPUP1Pl/AQkyAOMZ2cmMQPTflo8Mwcbk
         5gpw==
X-Gm-Message-State: AOAM532OJ92hfeGAoUFwrH3Uzy3mqn+NNmXTP+ppDZcMps0qlUcE15dn
        Vtlkfx39NhKkj0j4AfO6wg==
X-Google-Smtp-Source: ABdhPJzmjKYdnN80/BdHxS9eMtMdR1+4ITJdHQjuWkhkfxhKIxTxr4Bi+T2PFo3Taq36HCwBpWyrgw==
X-Received: by 2002:a9d:5d1a:: with SMTP id b26mr6059810oti.112.1607608917405;
        Thu, 10 Dec 2020 06:01:57 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y35sm1091659otb.5.2020.12.10.06.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 06:01:55 -0800 (PST)
Received: (nullmailer pid 2423529 invoked by uid 1000);
        Thu, 10 Dec 2020 14:01:54 -0000
Date:   Thu, 10 Dec 2020 08:01:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chen Feng <puck.chen@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v3 3/4] dt-bindings: reset: correct vendor prefix hisi to
 hisilicon
Message-ID: <20201210140154.GA2423435@robh.at.kernel.org>
References: <20201208124641.1787-1-thunder.leizhen@huawei.com>
 <20201208124641.1787-4-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208124641.1787-4-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Dec 2020 20:46:40 +0800, Zhen Lei wrote:
> The vendor prefix of "Hisilicon Limited" is "hisilicon", it is clearly
> stated in "vendor-prefixes.yaml".
> 
> Fixes: 836e23549583 ("dt-bindings: Document the hi3660 reset bindings")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
