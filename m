Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08BC25AF40
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 17:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgIBPgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 11:36:01 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:33725 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgIBPfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:35:53 -0400
Received: by mail-ej1-f68.google.com with SMTP id j11so1592648ejk.0;
        Wed, 02 Sep 2020 08:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GCEsTdInS4YkDl/rs9szjQgucjoUvpkSLEs7mz1t++4=;
        b=kEk0nAFLnXSWcXv04QUfqZACxSxV2guiswkFaOiOmRNF1tQLdNdjULMuRnLEZ7N8JR
         jJ5npkwRgkSbt+n35QgfctPyww+SczPAbwcbR6AgZH/YaO5hFWT08E0UxVYSFyI6/g2L
         Q5iyRUGLaRPHzruy5nDlXkYpn8HqsgbkET0UN9U5cj2C5Q5j7tb26qwi0inCyrbBb0US
         eK7iAn73iL0RTZgiwYA7kZcwFkuLhXwKflsQZqb/ANemPgsYdCV30cOxRIRmdnZQ2yJz
         IcuWRoFSdwAp207yHeyuvLqC9qafw5rYjNPXH3oemLVbLPp1DaksVN+C9X9BpDd66FCc
         De1Q==
X-Gm-Message-State: AOAM53152WQfy7ChpFJl5W0oug90KIJk7VghXafYnT6zJcZ7anRE/BiQ
        88q6QRuIvUZhtkCHr6c9YMOctvtR6WD3oQ==
X-Google-Smtp-Source: ABdhPJzw7TROsNYzuEprNdGNAqhujN6cK49CW6dMCBTEBU/ojNemUw092ImCl/ElfWwyB7tC0pTXIA==
X-Received: by 2002:a17:906:e24f:: with SMTP id gq15mr557382ejb.395.1599060951087;
        Wed, 02 Sep 2020 08:35:51 -0700 (PDT)
Received: from kozik-lap ([194.230.155.106])
        by smtp.googlemail.com with ESMTPSA id lg22sm4841727ejb.48.2020.09.02.08.35.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Sep 2020 08:35:50 -0700 (PDT)
Date:   Wed, 2 Sep 2020 17:35:47 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH 4/4] ARM: dts: exynos: Remove snps,dwc2 compatible in
 Exynos3250
Message-ID: <20200902153547.GA21503@kozik-lap>
References: <20200829172532.29358-1-krzk@kernel.org>
 <20200829172532.29358-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200829172532.29358-4-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 07:25:32PM +0200, Krzysztof Kozlowski wrote:
> The binding for DesignWare HS OTG USB 2.0 in Samsung SoCs take only one
> compatible.  This fixes dtbs_check warnings like:
> 
>   arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml: hsotg@12480000:
>     compatible: ['samsung,s3c6400-hsotg', 'snps,dwc2'] is not valid under any of the given schemas (Possible causes of the failure):
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi | 2 +-

Applied.

Best regards,
Krzysztof

