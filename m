Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C204E258C80
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 12:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIAKN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 06:13:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42452 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIAKN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:13:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id c18so844037wrm.9;
        Tue, 01 Sep 2020 03:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=60OSzGQnLdO/drci+KqV2aNKAQlqAAKks8TSNwdM2FY=;
        b=GTz4d8MoyAeV6Tk/Pu6reOc3nXo6n2CGsXSa2SklzXvL0tQAOsjAgwzGxHwe/ddLIe
         rpd3XRECac2nqSwL8Z+N7N/1ZGVc/+NCWPKKJaQCtjbOwnXVIcNm7gAXkAyQoTa5yxTO
         fKJzD1vlcd+go0vdUqg+H7llsadwdcM50R3k4FA0R0+86W7hB57TRR2LJixrw9pIraQx
         UYEIX/q9Ios2jtWwtriVAIoTymFwd7Blnb3lSMOor/4/CxWOujHcmAg879YLJD6LIy0h
         AExZm5YH8JryIPGGfBFH621kZtP+962PM6vnhF/VI+SVSIAb/pdlP25UQFU5bsTkftE1
         vcKg==
X-Gm-Message-State: AOAM530IDFJWx23gTbwbDQ/X/SmIn+CpYpCxAwntfMXKvsAN0ps6JQiy
        y3BWxHk5Ge8Wv9lUo+Y+IEw=
X-Google-Smtp-Source: ABdhPJxMqwy/axvlMjQ/xJnNPGIvM2iHQeNPPj3R8YD2jG1F8eJm1SltrAiVX5VChjwgA+YtEBCEew==
X-Received: by 2002:a05:6000:7:: with SMTP id h7mr1171095wrx.16.1598955206626;
        Tue, 01 Sep 2020 03:13:26 -0700 (PDT)
Received: from kozik-lap ([194.230.155.106])
        by smtp.googlemail.com with ESMTPSA id c6sm1490149wrr.15.2020.09.01.03.13.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Sep 2020 03:13:26 -0700 (PDT)
Date:   Tue, 1 Sep 2020 12:13:22 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: Re: [PATCH 08/10] arm64: dts: exynos: Add compatibles to sysreg nodes
Message-ID: <20200901101322.GD23793@kozik-lap>
References: <20200829142501.31478-1-krzk@kernel.org>
 <20200829142501.31478-8-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200829142501.31478-8-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 04:24:59PM +0200, Krzysztof Kozlowski wrote:
> System register nodes, implementing syscon binding, should use
> appropriate compatible.  This fixes dtbs_check warnings:
> 
>   arch/arm64/boot/dts/exynos/exynos5433-tm2.dt.yaml: syscon@13b80000:
>     compatible: ['syscon'] is not valid under any of the given schemas
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 6 +++---

Applied.

Best regards,
Krzysztof

