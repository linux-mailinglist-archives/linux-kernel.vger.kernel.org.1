Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311132D1E2E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 00:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgLGXOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 18:14:35 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37348 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgLGXOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 18:14:35 -0500
Received: by mail-ot1-f66.google.com with SMTP id o11so11520459ote.4;
        Mon, 07 Dec 2020 15:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FMfWfHv2wzoNIwcVOZya215y7ocesZYjo3SfGqRpwhM=;
        b=fUeKn9opqLxqzvzwAQv1fyA1ibK1RA/AkWXsrAGUskeOjl4OGuJMO/ycSgBAt4DeSi
         Pt7pSsZPDWDUMUu8hMZt1MrclX12oti/LtBuEVdttPRxY8RyVgImLRcwe61jBj80TXgD
         FXJfG2OvuAe2l3z/mAmirPJk1n6elDNHa+Mk2YmgWBaI2YxwjdQQjGkaPfDOVGiXIWab
         CDN88ISQbKw29o0BMqGFrn4o79qHqazRaEux9qbh8iYPq44nhKuWcJo88nlUmqfc1UVo
         7IKozqhjJrD98yIzAYQ/2i6lTOclWr9Uve4luiBIHV3kid4/9QPxEUUBoaYckPwg/vfl
         x3zA==
X-Gm-Message-State: AOAM532ltOAZwRzmA85VglTwrEP/ua1w8Wrq39mGpCxh3KsprPTSv+c8
        pMTzpoKAimQ3iRJruR5/FA==
X-Google-Smtp-Source: ABdhPJwY8L2lCOxVcrhiOYdR2CS5sbwBdDa2uQTR8kVPaHm8lSOS/OSL2o6wOI2e5/FfSmcKyMQdCQ==
X-Received: by 2002:a9d:3982:: with SMTP id y2mr14597036otb.260.1607382834342;
        Mon, 07 Dec 2020 15:13:54 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k20sm3315179oig.35.2020.12.07.15.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 15:13:53 -0800 (PST)
Received: (nullmailer pid 1030164 invoked by uid 1000);
        Mon, 07 Dec 2020 23:13:52 -0000
Date:   Mon, 7 Dec 2020 17:13:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH] dt-bindings: Correct GV11B GPU register sizes
Message-ID: <20201207231352.GA1028809@robh.at.kernel.org>
References: <20201124121842.1037035-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124121842.1037035-1-jonathanh@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020 12:18:42 +0000, Jon Hunter wrote:
> Commit 90a09178f309 ("dt-bindings: Add documentation for GV11B GPU")
> added the GV11B GPU device-tree bindings information but incorrectly
> added an additional 0 to the size of the addresses in the example.
> 
> Fixes: 90a09178f309 ("dt-bindings: Add documentation for GV11B GPU")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!

But really, it's just an example and rather than fix trivial things in 
txt bindings, convert them to schema please.
