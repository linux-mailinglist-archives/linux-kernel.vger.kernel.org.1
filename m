Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F00E257788
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 12:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgHaKmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 06:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgHaKmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 06:42:50 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0CF32098B;
        Mon, 31 Aug 2020 10:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598870570;
        bh=Ln4rslb3Qsf+jYORwga2CatpNCzcbpYy/Pfp93sjrw4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sZ7OU0XojCp1IV3YBbtZTQRSx2suJ/BI4B3xU1Dp75rSwSUEq9Z+5VOSBBlpyiVsh
         BeccjOU83nQjGeOnUH6plZqG409HyITYDcMZ9Mvfrj7SD08/f82sxq2Jy6C+xi+xNi
         CCo7EtL+aD/WMTrR6Lg5NcXVaPbL+LLcPaAzmN6Q=
Received: by mail-ed1-f52.google.com with SMTP id w1so1325914edr.3;
        Mon, 31 Aug 2020 03:42:49 -0700 (PDT)
X-Gm-Message-State: AOAM530tgRyPuAu/45z6G23Fn+YcEFHfwFTNLZFXxjVgBcklD/csOa8V
        /+GlYM99sKahOzJo43oN+ACwvkbVfnNJrK8vLoU=
X-Google-Smtp-Source: ABdhPJwViqVYGSP6932iPPY+2iN3GoPMIaINZHzZatPm+H4YsszcHa5UXjR7pSZMmgTBEXj5UlNydJx7zm0sEPCX2u0=
X-Received: by 2002:a05:6402:ca7:: with SMTP id cn7mr578907edb.143.1598870568303;
 Mon, 31 Aug 2020 03:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200830135200.24304-1-krzk@kernel.org> <CGME20200830135508eucas1p21ad0d4f6a2ef78f854fc74750db3fa2a@eucas1p2.samsung.com>
 <20200830135200.24304-23-krzk@kernel.org> <c9daff05-dca7-f1b1-8cfe-46b185bf60dd@samsung.com>
 <CAJKOXPfR8YVmBqCd5+8B2TdM_tXZbWobK0pLxXxxkrsDEMR-vw@mail.gmail.com> <96651e85-c27f-3167-7b41-2ea051c25c65@kernel.org>
In-Reply-To: <96651e85-c27f-3167-7b41-2ea051c25c65@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 31 Aug 2020 12:42:37 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdF4zzXvYrOiGQM9o=4rrWHvEr=o9aSTuR238dEaiD4cQ@mail.gmail.com>
Message-ID: <CAJKOXPdF4zzXvYrOiGQM9o=4rrWHvEr=o9aSTuR238dEaiD4cQ@mail.gmail.com>
Subject: Re: [PATCH 23/33] ARM: dts: exynos: Remove empty camera pinctrl
 configuration in Odroid X/U3
To:     Sylwester Nawrocki <snawrocki@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Denis GNUtoo Carikli <GNUtoo@cyberdimension.org>,
        Simon Shields <simon@lineageos.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 at 12:35, Sylwester Nawrocki <snawrocki@kernel.org> wrote:
>
> Hi,
>
> On 8/31/20 10:38, Krzysztof Kozlowski wrote:
> > On Mon, 31 Aug 2020 at 10:31, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> >> On 30.08.2020 15:51, Krzysztof Kozlowski wrote:
> >>> The camera's pinctrl configuration is simply empty and not effective.
> >>> Remove it to fix dtbs_check warning:
> >>>
> >>>     arch/arm/boot/dts/exynos4412-odroidx.dt.yaml: camera: pinctrl-0: True is not of type 'array'
> >>>
> >>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >>
> >> I think that this was intentional to properly enable support for
> >> mem-2-mem mode in Exynos4-IS (FIMC), but I'm not sure what are the
> >> default values if no pinctrl properties are provided. Sylwester, could
> >> you comment?
> >
> > Indeed it could be intentional... I see now errors:
> > [   33.752203] s5p-fimc-md soc:camera: Failed to get pinctrl: -19
> >
> > I wonder why getting an empty pinctrl is needed... maybe the driver
> > should accept missing pinctrl?
>
> It might have been better to have the pinctrl properties optional, as there
> might be boards without the image sensor attached and FIMC could still be
> used in memory-to-memory mode, as Marek pointed out. But it seems too late
> now to change that. The binding defines the pinctrl properties as required
> (Documentation/devicetree/bindings/media/samsung-fimc.txt) and we need to
> keep them in dtses.

You can always make a required property optional and it is not a break
of ABI. The other way around would be a break. Why then not changing
the driver to accept optional pinctrl?

Best regards,
Krzysztof
