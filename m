Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5626C29678C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 01:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900682AbgJVXL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 19:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507980AbgJVXL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 19:11:56 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71332C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 16:11:56 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y1so1770945plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 16:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JxRD+phXO6nKRrNVkXhm+T+K0XfSv6hV9PXOgCrbpxQ=;
        b=gJYZS7tdUvlN6n7wCC6l8UKl/hQUhS0a6hGb7Q/FBosbV/kTJYwYa24LeSwif7tuem
         Nn8zHuCTR/p2vGK96HHZNjZTTCn3+7Xg1V5R7WwuMwwXGlg+qmNFVEfUcN5zF3aE+Qcp
         bKHh9uZDPoR1Ypgud9k2zNTUGjlrMOZRc32Ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JxRD+phXO6nKRrNVkXhm+T+K0XfSv6hV9PXOgCrbpxQ=;
        b=PGVIVPReZYxW51zQY8k+QvxuW8992Hv/5W283pzOd04r3/2ieb/2sobZT0AC9Wwj/M
         LE+Z/uEGYzBOBo8VEVmKOc5RHXQIGPhkKxNB+KiJ2voyDU/3j7l/nMTMmbga5eeevOTL
         slO/6lAZ4MtnA+tqx7MoEKwmFLiseEskoyDX9UikG8PVmpWCiQ5lf8I20VfkolxOKIFK
         297f/mzbcGM0LdKWvTTDN2GZz8MCMTsHjFWMyE9ZS54oMeTGJvVKIXPRv8g8e9dlMHX9
         qwAYoM/QrBzrnyf61MGLfRVoosf37F9x+7DvMDh8aPc4HdIB+/Ii+md4Gnef/vy6D3QH
         oKJA==
X-Gm-Message-State: AOAM530pNlLZBWOshNPEu++HmwIqk6zYbsrYKKC2/2Vs+wUcxY4PvKPT
        AFh+JPCEjyzbiB4aCpygcIvE9qMftv/Qdg==
X-Google-Smtp-Source: ABdhPJwanyKMItO53tEIK+YOBtmjNLDv9bowFtkwMunDrjYdlFl+At5zV32VvWIFntrsv8IJXKuB9g==
X-Received: by 2002:a17:902:8d8f:b029:d0:cc02:8527 with SMTP id v15-20020a1709028d8fb02900d0cc028527mr4828551plo.33.1603408315815;
        Thu, 22 Oct 2020 16:11:55 -0700 (PDT)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com. [209.85.210.178])
        by smtp.gmail.com with ESMTPSA id y1sm3178790pjl.12.2020.10.22.16.11.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 16:11:55 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id x13so2244346pfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 16:11:55 -0700 (PDT)
X-Received: by 2002:a67:1e01:: with SMTP id e1mr4095984vse.49.1603407959647;
 Thu, 22 Oct 2020 16:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201022050445.930403-1-amstan@chromium.org> <20201021220404.v3.1.I96b8d872ec51171f19274e43e96cadc092881271@changeid>
In-Reply-To: <20201021220404.v3.1.I96b8d872ec51171f19274e43e96cadc092881271@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 22 Oct 2020 16:05:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vf2wfPK7CCwHi65ubPnCPWJw4Qh2nKtfC=yx7h8pvuyg@mail.gmail.com>
Message-ID: <CAD=FV=Vf2wfPK7CCwHi65ubPnCPWJw4Qh2nKtfC=yx7h8pvuyg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ARM: dts: rockchip: veyron: Remove 0 point from brightness-levels
To:     Alexandru Stan <amstan@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 21, 2020 at 10:05 PM Alexandru Stan <amstan@chromium.org> wrote:
>
> The extra 0 only adds one point in the userspace visible range,
> so this change is almost a noop with the current driver behavior.
>
> We don't need the 0% point, userspace seems to handle this just fine
> because it uses the bl_power property to turn off the display.
>
> Furthermore after adding "backlight: pwm_bl: Fix interpolation" patch,
> the backlight interpolation will work a little differently. So we need
> to preemptively remove the 0-3 segment since otherwise we would have a
> 252 long interpolation that would slowly go between 0 and 3, looking
> really bad in userspace. So it's almost a noop/cleanup now, but it will
> be required in the future.
>
> Signed-off-by: Alexandru Stan <amstan@chromium.org>
> ---
>
>  arch/arm/boot/dts/rk3288-veyron-jaq.dts    | 2 +-
>  arch/arm/boot/dts/rk3288-veyron-minnie.dts | 2 +-
>  arch/arm/boot/dts/rk3288-veyron-tiger.dts  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
