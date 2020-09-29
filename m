Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55A827D618
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 20:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgI2St6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 14:49:58 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40450 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2St5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 14:49:57 -0400
Received: by mail-oi1-f193.google.com with SMTP id t76so6607969oif.7;
        Tue, 29 Sep 2020 11:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QzGixWh04bg9LIh/RPGhJkv1YbsDDv3/7NrNdVV4KFw=;
        b=B0F+qd45WANdZ+J2c88gapAj0zHE3eKQYRpVzG70JBv16kQYqjgPPyiIJRrf9I6neA
         UXVZeLwS9iZ+W61feV97G+QDQolt1O1o2ei6ZNyMDI/nJfG4HaPbwz6eEYQAfwx1/dh+
         oAWnH/+oerSUdsZ+++xGqvRvAjGdhmLyhxsWP+ycL6Cu4hbPzRgNWXuCTv5Dujkozl8z
         W9iFbDMT+/b00gE61aoCg8l1QYaAFR3GJ/secenqMrRD8LpjINRkXYPm9awC9QoUsZbu
         mJfaya5mFsKYi+v+ktAHDyiLuZzxxMLatWb5n7M/1O6DlMG8D+Yr047I6n9nU8XbsEPh
         YO+A==
X-Gm-Message-State: AOAM532JjUCg9aHdhjxbZ4j0BxzKt0lTNGTdtBPiuMpchmFQlcLRh/ne
        +gCRcT7Tupz3hlaC3IvLjQ==
X-Google-Smtp-Source: ABdhPJzRzmq51UtIoGy+jdfsj6vD1zCP8EqSEp5YN2DhPjux2qDgaYvnyNQ+F0zeoNRGnc7fGPrIHg==
X-Received: by 2002:aca:c313:: with SMTP id t19mr3483322oif.65.1601405396635;
        Tue, 29 Sep 2020 11:49:56 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e22sm1264421oib.18.2020.09.29.11.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 11:49:55 -0700 (PDT)
Received: (nullmailer pid 950170 invoked by uid 1000);
        Tue, 29 Sep 2020 18:49:55 -0000
Date:   Tue, 29 Sep 2020 13:49:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Inki Dae <inki.dae@samsung.com>,
        David Airlie <airlied@linux.ie>, devicetree@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: gpu: samsung-rotator: Add missing
 properties
Message-ID: <20200929184955.GA950113@bogus>
References: <20200923150339.12497-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923150339.12497-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Sep 2020 17:03:39 +0200, Krzysztof Kozlowski wrote:
> Add common properties appearing in DTSes (iommus, power-domains) to fix
> dtbs_check warnings like:
> 
>   arch/arm/boot/dts/exynos4210-i9100.dt.yaml: rotator@12810000:
>     'iommus', 'power-domains' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v2:
> 1. Add maxItems to power domains and iommus
> 
> Changes since v1:
> 1. Add properties instead of using unevaluated
> ---
>  Documentation/devicetree/bindings/gpu/samsung-rotator.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Applied, thanks!
