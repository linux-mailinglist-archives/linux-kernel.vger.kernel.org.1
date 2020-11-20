Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC852BB330
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbgKTSav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbgKTSau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:30:50 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE715C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 10:30:49 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id v5so2422314vkn.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 10:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BC7NdDnWCC9mZgNsEelPHiGH18KsWVryHJxe1zU4XUQ=;
        b=ILqfOchh//XAmWhRIoGW8ea1f98KB61yJH3MFcwcxzJilrCT1ybHU6ZCAKSPTFPSNc
         KonM+iPhG1a5oNbj0vFYellIQQP8aF/oq3q+SrTnVs87Vj285osEIkZ4r417DAOm8uRh
         79qOT8Rhzf60nkCudlh6i3xXqPh9oPt+C+ZqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BC7NdDnWCC9mZgNsEelPHiGH18KsWVryHJxe1zU4XUQ=;
        b=eC+wPc/pNfx8iKu1OSdlApj6b9324w/uh7CTIVt65Iuvb02kFci24zjDemo/HRRJnc
         ubve2EqO2Kl3qKdHRXJ/sVd6fWhm64H0CbkQQ0hV1ZIkTizmqDU00L/bK1xQTmNG0x2C
         +uRW7Pa+P4ivxqnKobEpCn6CqhIi9wzjvXuDk+t7HhD63+HDBIh+DTuZD774N6XpYT9J
         /Nv3j0whioO4q7lAVNvVBXmRyQOQNjNrVf4AVkPK+QX6o1jr6uNQ3lnA9Udy5WgVeVzH
         Ux4z1OLmaFE8n74YqtrZx5Hty1o/o88JobO/QOx8rJu5dNBGU1t7d2CSGfuMVwAh5WLN
         PTNg==
X-Gm-Message-State: AOAM5339Xi/T3MRaJ4JGVmBON08O5/OoZpg4GymR3Ubc+/pRFJ/dK3pB
        YYd17omIxLstd/wVR5VPorH7SIjOYYv8rQ==
X-Google-Smtp-Source: ABdhPJz3Y5UB508RZ5Xn3GJzjwNbDN2cAh3qt/78gWfcinoTmcPNsRuz4bHU47OfTB+8Pr+2bpVQ/g==
X-Received: by 2002:a1f:1e41:: with SMTP id e62mr14849875vke.9.1605897048956;
        Fri, 20 Nov 2020 10:30:48 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id j6sm400925vsj.29.2020.11.20.10.30.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 10:30:48 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id t15so3436882ual.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 10:30:48 -0800 (PST)
X-Received: by 2002:a9f:3dcc:: with SMTP id e12mr17854529uaj.121.1605897047963;
 Fri, 20 Nov 2020 10:30:47 -0800 (PST)
MIME-Version: 1.0
References: <20201120182426.541884-1-swboyd@chromium.org>
In-Reply-To: <20201120182426.541884-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Nov 2020 10:30:36 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V0qcfnsOPfEf9PFsss8V=KncFrjnV6KJ-6Qr1+GfzDgA@mail.gmail.com>
Message-ID: <CAD=FV=V0qcfnsOPfEf9PFsss8V=KncFrjnV6KJ-6Qr1+GfzDgA@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: qcom: sc7180: Add prox sensor to LTE sku
 Lazor boards
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 20, 2020 at 10:24 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> There's a proximity sensor on Lazor devices, but only for LTE SKUs.
> Enable it only on the Lazor LTE SKUs and also configure it properly so
> it works.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v2 (https://lore.kernel.org/r/20201120074508.3236616-1-swboyd@chromium.org):
>  * Also disabled ap_sar_sensor_i2c node in trogdor.dtsi file
>
> Changes from v1 (https://lore.kernel.org/r/20201118045454.2503325-1-swboyd@chromium.org):
>  * Fixed startup-sensor property to be 0 instead of 1
>  * Fixed proxraw-strength to be 8 instead of 2
>
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dts | 8 ++++++++
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts | 8 ++++++++
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi       | 7 ++++++-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi             | 1 -
>  4 files changed, 22 insertions(+), 2 deletions(-)

I haven't personally reviewed the actual numbers for the SAR sensor
config, but things look sane.  One last nit you could fix upstream is
the removal of the "disabled" in "sc7180-trogdor-r1.dts" now that it's
disabled by default...  In any case...

Reviewed-by: Douglas Anderson <dianders@chromium.org>
