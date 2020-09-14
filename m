Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167A62696F2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgINUrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:47:15 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43903 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgINUrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:47:10 -0400
Received: by mail-il1-f195.google.com with SMTP id a19so872135ilq.10;
        Mon, 14 Sep 2020 13:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3aJHQrNpFe8Ms3gECFD6wOZS5dd9+Y5gyYVALhIhZPs=;
        b=Gyloq5SXHCeK8TsN2ANsRq/JfswWZ/89MijnG72MoFewx3tblnhlf00JcM4vtyMlDw
         qkISdxEknurtD4xjl/y6WSjsbnSgCRQcs1c/OuSmD1HGcl/0/xykEkYxR/+/RXLe3/E2
         9OTRL24zUsinzHC8t911Uolo+gav4gAVSoOqa/hGuPH8nBNvubgRjatoZMpLmVLWy+47
         5L7nn4ISMFZuf+SB4SZpsumD6N/V5nRkyIIEjY5fvIuTAZPEH5lxSTUm/WVwr8UhXP9M
         rAxBIJex7n9xz/9cKAYbhHkHFXMQXQLk9btCe1hDRv+2NawraECPohthKzbYgQQYrGmq
         u1PQ==
X-Gm-Message-State: AOAM530ZERaXxKS3+8ncEp2moOP6O/utpozPazNLcFAGFm2Mwg3Zr1Hi
        /Lrcf3LNgkKPxp3iGuKDilXFhubUZTGC
X-Google-Smtp-Source: ABdhPJxD4UmmQJqNs60zscb6eErJmrhw8c8wPB1lZYaAuVy+FahVCfOn7jJiNsf7JikOi+D3N184pA==
X-Received: by 2002:a92:5a48:: with SMTP id o69mr10635813ilb.268.1600116428866;
        Mon, 14 Sep 2020 13:47:08 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s2sm7836569ili.49.2020.09.14.13.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:47:08 -0700 (PDT)
Received: (nullmailer pid 216997 invoked by uid 1000);
        Mon, 14 Sep 2020 20:47:06 -0000
Date:   Mon, 14 Sep 2020 14:47:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: timer: exynos4210-mct: Add missing
 clocks
Message-ID: <20200914204706.GA216915@bogus>
References: <20200903191311.12293-1-krzk@kernel.org>
 <20200903191311.12293-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903191311.12293-2-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Sep 2020 21:13:11 +0200, Krzysztof Kozlowski wrote:
> The Exynos Multi Core Timer driver requires two clocks.  This was never
> documented in the binding.  Add it to fix dtschema warnings like:
> 
>   arch/arm64/boot/dts/exynos/exynos5433-tm2.dt.yaml: timer@101c0000:
>     'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Add properties instead of using unevaluated
> ---
>  .../timer/samsung,exynos4210-mct.yaml         | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 

Applied, thanks!
