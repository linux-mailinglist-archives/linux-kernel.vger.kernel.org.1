Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9512D26AF32
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgIOVJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:09:43 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:36724 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgIOU2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 16:28:45 -0400
Received: by mail-il1-f193.google.com with SMTP id t12so4310428ilh.3;
        Tue, 15 Sep 2020 13:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jkjqJJoLf46hsZcBiW4RAEbj7jPvHIEIrC163Ok851k=;
        b=Yly3mztlq8O7BHahFHA0o7GbV5/VIol5tdrhYTVQYTMSkDrswfi9Pm6IRwpapP3868
         bvaiC9Sq0cDUS6cCj1gZQSyHMYVk8KUvjr4Vh2+TLh0si1JVRP2D10hVvAQb9hmLpDwN
         YyGxw1kd5HBXPzUNZt/J8kKE6c8D9IqY0wach3u1a/bAEMwPkMZUhY0/5TaYE++IeziK
         4vTxcjPpLFEGSeRarnX/db5XR5F1KWyjzmn3stse2UEOp39aB80LywQAd7Yqnx2UncgJ
         +KEHUwRPzFZvU6fHbh43M6rdR7xschu0axNJ5kcrDyyxs8deGWEy/U1c9S5ZdAFocPyn
         LN+w==
X-Gm-Message-State: AOAM531P7HNMMKG3zVa/3PSUMyRkyVvU4JZKbscrmeQ4ItARSc5GItW/
        p/NEudtgxoVyC3age5uyPnolgwiTKM/aKis=
X-Google-Smtp-Source: ABdhPJwrhDODEjHZ8RLAir9uwMQEdZvCz3g4kBb+8Ml4Uh7tFdytEvo26zCoazCq0d2QFZ81Fwq5hw==
X-Received: by 2002:a92:c791:: with SMTP id c17mr18450577ilk.107.1600201718947;
        Tue, 15 Sep 2020 13:28:38 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p17sm9387851ilj.81.2020.09.15.13.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 13:28:38 -0700 (PDT)
Received: (nullmailer pid 2454976 invoked by uid 1000);
        Tue, 15 Sep 2020 20:28:37 -0000
Date:   Tue, 15 Sep 2020 14:28:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: example: Extend based on practice
Message-ID: <20200915202837.GA2453633@bogus>
References: <20200910184706.9677-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910184706.9677-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 20:47:06 +0200, Krzysztof Kozlowski wrote:
> Extend the example schema with common rules which seems to be not that
> obvious:
> 1. Expecting arrays of phandles to be always ordered, regardless if
>    "xxx-names" is provided (e.g. clocks),
> 2. Add example of altering a property based on presence of other
>    property,
> 3. Document usage of unevaluatedProperties.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/example-schema.yaml   | 33 ++++++++++++++-----
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 

Applied, thanks!

I keep meaning to go work on improving this...
