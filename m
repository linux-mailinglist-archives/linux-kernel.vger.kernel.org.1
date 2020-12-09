Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBF92D4842
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 18:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgLIRtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 12:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLIRtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:49:23 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFB9C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 09:48:43 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id v3so542604vkb.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 09:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DjObpwsQOixsfClK1GgVMLvQ0A3T3bBbvQfg+er+Umo=;
        b=dKYrNjElh2XhBB8xtEQ46H/YwUSv0U490Ae4dDyAL9H9xieG8SyD6a4duzxrP1ddpo
         nTdpn3gnbZScP+/8wIekuvzI8x601Grr7pjDvbRj8Ewf1Ic7EhjWGsuQSnRonPPNdPfq
         LLIV7a5EkySZDMfEYVZfzXFS1yxVjcm1BlHdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DjObpwsQOixsfClK1GgVMLvQ0A3T3bBbvQfg+er+Umo=;
        b=K2i5JC045uEIaMITqqhQ4XNmQZAtoZBBZ5dPoy8roFDKH4J9ujks1ezXINZg81QCl+
         vuTPpr0QpSBrv5WhuIqC0hahtQE9ViXk4pXGsj6db11rKLIZhM/42Ue1s75RGlF6uOaC
         0b/bDCjMo5nElXuVAEKBZt6U5rCF56VicXwKDssG+S8DKbNIHr7cZyZP0hSKjIu3bwO+
         kNmQ6TYnQ/KgrvD/jyOIOlUHYOzYE/mH9gEPmhLk9FSo0VaqEx4vd6BlCaHlKx32b7E3
         y0/zdyV2syiX3Qp/md3pPZSmGyvTX65PxZOdsi7CKahu9J65nwpuABWjtZR130CDLVnX
         piWg==
X-Gm-Message-State: AOAM530MsGaK54J50bXm64e7tlw7kRb1sGBBNr5d3tizSIMopL1H03aM
        Jzsiy/LPJDkA+6/rQmamFYLS2kn6awOf6g==
X-Google-Smtp-Source: ABdhPJxli5cNGCZL4A77cul6bO0oW+DjPTTDyiNR6VcQkEDScUEk+ElpkrmIbWFpKVkusyavW5puOw==
X-Received: by 2002:a1f:34d5:: with SMTP id b204mr3295515vka.15.1607536122408;
        Wed, 09 Dec 2020 09:48:42 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id f70sm196686vke.56.2020.12.09.09.48.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 09:48:41 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id w18so1343519vsk.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 09:48:41 -0800 (PST)
X-Received: by 2002:a67:8c41:: with SMTP id o62mr3244996vsd.49.1607536121097;
 Wed, 09 Dec 2020 09:48:41 -0800 (PST)
MIME-Version: 1.0
References: <20201209020757.5917-1-chris.ruehl@gtsys.com.hk>
In-Reply-To: <20201209020757.5917-1-chris.ruehl@gtsys.com.hk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 9 Dec 2020 09:48:29 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UESmNc5w6b3rXV9+1UteQYN7NBY7sqNzvjgcbbJBFusw@mail.gmail.com>
Message-ID: <CAD=FV=UESmNc5w6b3rXV9+1UteQYN7NBY7sqNzvjgcbbJBFusw@mail.gmail.com>
Subject: Re: [PATCH v2] phy: rockchip-emmc: emmc_phy_init() always return 0
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 8, 2020 at 6:08 PM Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:
>
> rockchip_emmc_phy_init() return variable is not set with the error value
> if clk_get() failed. 'emmcclk' is optional, thus use clk_get_optional()
> and if the return value != NULL make error processing and set the
> return code accordingly.
>
> Fixes: 52c0624a10cce phy: rockchip-emmc: Set phyctrl_frqsel based on card clock
>
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  drivers/phy/rockchip/phy-rockchip-emmc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c b/drivers/phy/rockchip/phy-rockchip-emmc.c
> index 48e2d75b1004..a23034416481 100644
> --- a/drivers/phy/rockchip/phy-rockchip-emmc.c
> +++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
> @@ -245,15 +245,17 @@ static int rockchip_emmc_phy_init(struct phy *phy)
>          * - SDHCI driver to get the PHY
>          * - SDHCI driver to init the PHY
>          *
> -        * The clock is optional, so upon any error we just set to NULL.
> +        * The clock is optional, using clk_get_optional() to get the clock
> +        * and do error processing if the return value != NULL
>          *
>          * NOTE: we don't do anything special for EPROBE_DEFER here.  Given the
>          * above expected use case, EPROBE_DEFER isn't sensible to expect, so
>          * it's just like any other error.
>          */
> -       rk_phy->emmcclk = clk_get(&phy->dev, "emmcclk");
> -       if (IS_ERR(rk_phy->emmcclk)) {
> -               dev_dbg(&phy->dev, "Error getting emmcclk: %d\n", ret);
> +       rk_phy->emmcclk = clk_get_optional(&phy->dev, "emmcclk");
> +       if (rk_phy->emmcclk && IS_ERR(rk_phy->emmcclk)) {

nit: no need to check for "rk_phy->emmcclk".  IS_ERR() will return
false for NULL.

Other than that, this looks fine to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
