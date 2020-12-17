Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29932DD66C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgLQRiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729667AbgLQRiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:38:11 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ED9C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 09:37:30 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id n26so39057291eju.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 09:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fLF6P+O62fQPSTng8hy4I8KBrSJzO2q6Xzt7+Jwjbu0=;
        b=Q/35/lbhLWd7jUP9iWj7T78K4JA+OJ44nAbfF31fVN6QvO0ng+xEqQQgcKVl0BFHpi
         Z076P1aqJldE8WHi0zDHBW3AyHaJI3WnASBCuK3UuTaprL8pmN75uX2V2SuE65pJcVhF
         LkrJeVoLrk+6qdMsXWATBpuoAu6zAo7Xl0wCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fLF6P+O62fQPSTng8hy4I8KBrSJzO2q6Xzt7+Jwjbu0=;
        b=FkdOvyGIf0lc+98UEnFpgRzm9jfquRCd8eAbX6BNk5K4f3xOFbqXPGiZcVZOfBS9r1
         eEAYZ7CMc1vrnhY4rRsWZBWbl0ffi2R4fZPYzxGXi/FWOdJ2Gf7/X2nxJytS34qppLd7
         X3Sm1Tp53scvBWoy4F+jsTV41IDp3H1Px1WBw+00hYOSRNkRlaK3k0JdrfkGyv2liARU
         x3/auejjwjCJT0ruC04CuhFjWwROjIns/P/DP126WZtqa20sY2DI4tkNV5FHbmokAUvd
         2H7CNAf6kYVyKl7YpV/tN53xw5YTMwcSQM7ALiylSFv0ZelhqrkPEkbAOul11JphMVEv
         vheA==
X-Gm-Message-State: AOAM530conmCy3nN0Vmw1AJTD7+wcZSz3RUc3J2J75OyzjwgkRTi0A6w
        3QVQPgSl5WlIZyomZKX7cblXW+KaWEUbossd90J1dw==
X-Google-Smtp-Source: ABdhPJyiLapDbFryDYgU3FGxGsnjDcJSPA4Y00bhcDs6zSyPtOYvkH6TskhdgNAa8vH9+dJF3a94dkgm9iNC0Vv5t78=
X-Received: by 2002:a17:906:2707:: with SMTP id z7mr89185ejc.418.1608226649339;
 Thu, 17 Dec 2020 09:37:29 -0800 (PST)
MIME-Version: 1.0
References: <20201215235639.31516-1-adrien.grassein@gmail.com> <20201215235639.31516-4-adrien.grassein@gmail.com>
In-Reply-To: <20201215235639.31516-4-adrien.grassein@gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 17 Dec 2020 23:07:18 +0530
Message-ID: <CAMty3ZAXQ4d92JubVcw_+EDNC0RQCDJGuoz=Budo7R2efpT7nA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] regulator: dt-bindings: pf8x00: fix
 nxp,phase-shift doc
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Troy Kisky <troy.kisky@boundarydevices.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 5:27 AM Adrien Grassein
<adrien.grassein@gmail.com> wrote:
>
> nxp,phase-shift is an enum so use enum format to describe it.
> Minimum and maximum values are also wrong.
>
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../bindings/regulator/nxp,pf8x00-regulator.yaml | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
> index 913532d0532e..1da724c6e2ba 100644
> --- a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
> @@ -60,21 +60,13 @@ properties:
>
>            nxp,phase-shift:
>              $ref: "/schemas/types.yaml#/definitions/uint32"
> -            minimum: 45
> -            maximum: 0
> +            minimum: 0
> +            maximum: 315
> +            default: 0
> +            enum: [ 0, 45, 90, 135, 180, 225, 270, 315 ]

On Wed, Dec 16, 2020 at 5:27 AM Adrien Grassein
<adrien.grassein@gmail.com> wrote:
>
> pf8x00 module build was not documented.
>
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  drivers/regulator/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 53fa84f4d1e1..9c6508e99fdd 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -828,6 +828,10 @@ config REGULATOR_PF8X00
>           Say y here to support the regulators found on the NXP
>           PF8100/PF8121A/PF8200 PMIC.
>
> +         Say M here if you want to support for the regulators found
> +         on the NXP PF8100/PF8121A/PF8200 PMIC. The module will be named
> +         "pf8x00-regulator".

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
