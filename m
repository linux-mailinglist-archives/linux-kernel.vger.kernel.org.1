Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD1926970F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgINUvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:51:39 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:37434 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgINUva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:51:30 -0400
Received: by mail-il1-f194.google.com with SMTP id q4so930096ils.4;
        Mon, 14 Sep 2020 13:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/nkoIQBB8aeAjFrAyH3N5nJASsyTVOS6e3/91uOJWL0=;
        b=dF0GNDObWGgoQA8xvrXzLsZFFhS2cs693Tqph95/VX6htiMKb/BN8Ew+UMqggBjVg+
         wjoTUURHwgcu4gMYE/yqaHIG++sZk6UzgovkMFhY4mxWyPZn0juhnnv7kfqa/8ogXi8+
         /YcZ538OYwCSmCy6wdk4Fbp+Whj+u1hW4b9kPdfUyHYCcGXHfdQDIAU6tMvvoy7844hD
         h10/yv1cVNE5vvvGkWKPPp3pskGvW5hldp86fRGtekluRVikqfBAbUHTtVj7GWCMMP/M
         N865pJVTdX55tCOLbVgwv2y6sVWdMnU+VGD7Uv79BnL+FJxDmVE0R/C3okT8TxGjjgxI
         skqw==
X-Gm-Message-State: AOAM533tt9QDw5L5aIgLdcoV34HMfGBwRG2WnDnbnDjUNf6kj5kim/33
        oKaKWsjhYQmhJKXWO+bmfQ==
X-Google-Smtp-Source: ABdhPJySW4fP7h19hziwUa7lpqPD35KoCpqwbLWwpSzQ2G6BsEECfMvDt20Nm11mQDnWHmGgEX0ZXQ==
X-Received: by 2002:a92:cc83:: with SMTP id x3mr12988306ilo.232.1600116687680;
        Mon, 14 Sep 2020 13:51:27 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h15sm7389741ils.74.2020.09.14.13.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:51:27 -0700 (PDT)
Received: (nullmailer pid 224256 invoked by uid 1000);
        Mon, 14 Sep 2020 20:51:25 -0000
Date:   Mon, 14 Sep 2020 14:51:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Kukjin Kim <kgene@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 2/6] dt-bindings: gpu: arm, mali-utgard: Add missing
 properties
Message-ID: <20200914205125.GA224203@bogus>
References: <20200903191438.12781-1-krzk@kernel.org>
 <20200903191438.12781-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903191438.12781-2-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Sep 2020 21:14:34 +0200, Krzysztof Kozlowski wrote:
> Add common properties appearing in DTSes (opp-table) to fix dtbs_check
> warnings like:
> 
>   arch/arm/boot/dts/exynos4210-i9100.dt.yaml: gpu@13000000:
>     'opp-table' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Add properties instead of using unevaluated
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
