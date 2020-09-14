Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1487B26970A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgINUvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:51:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40983 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgINUvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:51:21 -0400
Received: by mail-io1-f66.google.com with SMTP id z13so1627651iom.8;
        Mon, 14 Sep 2020 13:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q5BuFwXqgWUyM2oW2u+tt0CE/M323vwAM6Qm21hju84=;
        b=kjQiN0zD/XSckDJcxZ8XYqrYK4X5OAt+DAfEuDUHbbtKGqOR+sIziDc0UUCHnu/28W
         DBYIv0FkZi8XDPGJhm0FB5zF3FQbIkTOh9TY1aAN6INOiQeP5ZHXp97Hidm4jpscHvg1
         //iCk/eqVRXuC6wXDuE2C1IzU5qvmEIefX7FmMr/xlg6MEkgwdphJrsqapTspjIw1akn
         Tpc6LqikYtjGW0Ie9QJpx+LVIllahaO/D6UUysAFxVxsHbX5KRBA7ag9nlQIjbeUVvGs
         keowR6S3HPPB+TfQza2DyjQlyHtsZWoLBrv7risHtAki09SCdtUPG1ACUaEgQlpGfMts
         0g3Q==
X-Gm-Message-State: AOAM531QHmW8bI+3NXC9dQqBh7XFdPwDNptiAguEWCoCt7gV1IpAw8IH
        z80jFg4l4xnStEoZK//tvQ==
X-Google-Smtp-Source: ABdhPJxE2UxbjL3QpfM0FOA4k43+/+Tgm72pSVHJj60Dn1909MAmkzZSXMCLRYo9mu9sX4x7/Aw5ZQ==
X-Received: by 2002:a05:6638:1381:: with SMTP id w1mr15242941jad.34.1600116680100;
        Mon, 14 Sep 2020 13:51:20 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id r17sm7702364ilj.72.2020.09.14.13.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:51:19 -0700 (PDT)
Received: (nullmailer pid 223842 invoked by uid 1000);
        Mon, 14 Sep 2020 20:51:17 -0000
Date:   Mon, 14 Sep 2020 14:51:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: gpu: arm, mali-midgard: Add missing
 properties
Message-ID: <20200914205117.GA223785@bogus>
References: <20200903191438.12781-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903191438.12781-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Sep 2020 21:14:33 +0200, Krzysztof Kozlowski wrote:
> Add common properties appearing in DTSes (opp-table) to fix dtbs_check
> warnings like:
> 
>   arch/arm64/boot/dts/exynos/exynos5433-tm2.dt.yaml: gpu@14ac0000:
>     'opp-table' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Add properties instead of using unevaluated
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
