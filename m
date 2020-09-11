Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775412665EF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgIKRSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:18:31 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:43692 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgIKO6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 10:58:24 -0400
Received: by mail-ej1-f67.google.com with SMTP id o8so14186796ejb.10;
        Fri, 11 Sep 2020 07:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dyRucZNm28md89mx/pOf3gZWnRQfYA7sbvDVwnAnZ74=;
        b=bCUFZ8aMdJYNk2S0RLI52hKuc89u2e/S3ztdd0kNAN3j1qGI+191klxw7ZurMKgowz
         F8VofdHN5kxXITLgEM8tjNprmA+deuMhhUmcoNttXxU6F1a2Uc2Xch62bQGpSOCwquQc
         hhOtUWgH3YnzChhnrm+jWjESgv2ocXJHBRf4P4bqwLzJZTcaoBNPCTrnkyx/5adwIV+L
         irIi9IkK7HxhFnW4XyQUoKQSlBbD+xkGBTRpdT1gVwPX27H00thD3M89LfqHQRMpjeFZ
         vUPi7tMBO6aSRadZV4gLuuZsD0pKh5zUcsqOrVkggyQDJuJ9Nz/4qiqkVufpMqGr/Fhn
         nIWw==
X-Gm-Message-State: AOAM532LCNmjHwYwvvH7JZFjAdMuVYxmLbLanAk5RyUjhwr9QVh2UPSk
        I+V0PbskZHzW0BU7c4aUpU8=
X-Google-Smtp-Source: ABdhPJzEFJh32P9XFCoL6b6HJBE98lnsBmOx88hw37vP0PmvRkv5gR+ungj+zLUx4/JPA+XfKl1wAw==
X-Received: by 2002:a17:906:9389:: with SMTP id l9mr2465355ejx.537.1599836023257;
        Fri, 11 Sep 2020 07:53:43 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id h2sm1753694ejk.33.2020.09.11.07.53.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Sep 2020 07:53:42 -0700 (PDT)
Date:   Fri, 11 Sep 2020 16:53:40 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH v3 1/3] ARM: dts: exynos: Add assigned clock parent to
 CMU in Exynos3250
Message-ID: <20200911145340.GB15290@kozik-lap>
References: <20200906142146.21266-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200906142146.21266-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 06, 2020 at 04:21:44PM +0200, Krzysztof Kozlowski wrote:
> Commit 52005dece527 ("ARM: dts: Add assigned clock parents to CMU node
> for exynos3250") added assigned clocks under Clock Management Unit to
> fix hangs when accessing ISP registers.
> 
> However the dtschema expects "clocks" property if "assigned-clocks" are
> used.  Add reference to input clock, the parent used in
> "assigned-clock-parents" to silence the dtschema warnings:
> 
>   arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml: clock-controller@10030000: 'clocks' is a dependency of 'assigned-clocks'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v2:
> 1. Use XUSBXTI as real input clock.
> 
> Changes since v1:
> 1. Add clocks property.
> 
> This is a v2 for:
> https://lore.kernel.org/linux-samsung-soc/20200901101534.GE23793@kozik-lap/T/#me85ac382b847dadbc3f6ebf30e94e70b5df1ebb6
> ---
>  arch/arm/boot/dts/exynos3250-artik5.dtsi | 4 ++++
>  arch/arm/boot/dts/exynos3250-monk.dts    | 4 ++++
>  arch/arm/boot/dts/exynos3250-rinato.dts  | 4 ++++

Applied.

Best regards,
Krzysztof

