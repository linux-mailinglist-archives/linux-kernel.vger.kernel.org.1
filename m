Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901692AEFE3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgKKLqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 06:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgKKLpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:45:43 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45BBC061A47
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:45:39 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id i3so404070vkk.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W2LROEDqwB/YAfpZuvnNBx/s/n4ussPUTp1SoV848WE=;
        b=Rj4QLbP7hQUGidksqh3Sz+Mz1awLgghgywmgmq9iaGhu6djYI966xmN5JUcRmcYrq/
         Woc2NSWg8j33913hx6Vmfrrzuym6+skblcbvL41IiQFacYFt1SjAs/nslFk+g3W36u4V
         5Z4diCxFrS93BVrqJ7SDLPJfjdeswkTya8vvZmjaKgR3zhBTTE1EhWuFIHUSn9N1wPo1
         iX4p8Jc2fBB3F1mpe8ZqM6XFLIoz2+OX+tvgiLg3x8tn5z0hkeUvi4fzbnv3qjZga/O9
         dv9NoC5jp/yLI8jF8N3x1Yw2xoMv3ppOhpBWH3CIkWAXgT5hobFLAqPh/q8PjOiT3/Eo
         yovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W2LROEDqwB/YAfpZuvnNBx/s/n4ussPUTp1SoV848WE=;
        b=gCE/kcD/L2aUUyKGmOnmmAugooJN0qFNJY/WGkRp/sw+hW0Dpqvq/vphJbxjptmZor
         AhHVw3i8SXRXzyh44qWgLlw7TxFSrdID+xL7ohrC0gQQnjcSPydx2xfrmx88xIswe2fr
         OnEET2UE/nKLPGtLQ5bCWrkX2S4ZQhze/f6Nyd+iWTxk66k+P+m1/hB0w2RzJfRZA7ad
         wm+CF7XthuZHjNGlYAgNt/+xeRUSXPQggP3xWjJ8nsbTMR5jQNMFGN3RcFPJnzD/lsId
         kIsPx4aDZO+Rh2cj7vsnCHRrARQM4OT1wEpg4adqavZlzv3INTUr3KF8lZxmqH9t7Fol
         4r+Q==
X-Gm-Message-State: AOAM531fMhXO7H5oMpfItrIDRpJHRYJ2Bt/d02PZT8UaoDKnEU9P+wTE
        zB41VNHf0CnvZXAV2GK+EL4GhBWNE16Nz8VTBDstlQ==
X-Google-Smtp-Source: ABdhPJy49vZO4pNDp6JtJUn+KdVv0aND0NyO3da5g+cVxXyOVmgGe9S4bf/F/v98cY0CP0i1NrbPCyiERv3WhWMkEBU=
X-Received: by 2002:a1f:41cc:: with SMTP id o195mr13053486vka.15.1605095138861;
 Wed, 11 Nov 2020 03:45:38 -0800 (PST)
MIME-Version: 1.0
References: <20201104234427.26477-1-digetx@gmail.com> <20201104234427.26477-2-digetx@gmail.com>
In-Reply-To: <20201104234427.26477-2-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Nov 2020 12:45:02 +0100
Message-ID: <CAPDyKFpYeLjeYan74QdtWxtLhZZT-855Rd21sFHBkQXZg78D5g@mail.gmail.com>
Subject: Re: [PATCH v1 01/30] dt-bindings: host1x: Document OPP and voltage
 regulator properties
To:     Dmitry Osipenko <digetx@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Nov 2020 at 00:44, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Document new DVFS OPP table and voltage regulator properties of the
> Host1x bus and devices sitting on the bus.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../display/tegra/nvidia,tegra20-host1x.txt   | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
> index 34d993338453..0593c8df70bb 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
> @@ -20,6 +20,18 @@ Required properties:
>  - reset-names: Must include the following entries:
>    - host1x
>
> +Optional properties:
> +- operating-points-v2: See ../bindings/opp/opp.txt for details.
> +- core-supply: Phandle of voltage regulator of the SoC "core" power domain.
> +
> +For each opp entry in 'operating-points-v2' table of host1x and its modules:
> +- opp-supported-hw: One bitfield indicating:
> +       On Tegra20: SoC process ID mask
> +       On Tegra30+: SoC speedo ID mask
> +
> +       A bitwise AND is performed against the value and if any bit
> +       matches, the OPP gets enabled.
> +
>  Each host1x client module having to perform DMA through the Memory Controller
>  should have the interconnect endpoints set to the Memory Client and External
>  Memory respectively.
> @@ -45,6 +57,8 @@ of the following host1x client modules:
>    - interconnect-names: Must include name of the interconnect path for each
>      interconnect entry. Consult TRM documentation for information about
>      available memory clients, see MEMORY CONTROLLER section.
> +  - core-supply: Phandle of voltage regulator of the SoC "core" power domain.
> +  - operating-points-v2: See ../bindings/opp/opp.txt for details.
>

As discussed in the thread for the cover-letter.

We already have DT bindings for power-domains (providers and
consumers). Please use them instead of adding SoC specific bindings to
each peripheral device.

[...]

Kind regards
Uffe
