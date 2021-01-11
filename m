Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0142F0B97
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 04:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbhAKDvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 22:51:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbhAKDu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 22:50:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9012422582;
        Mon, 11 Jan 2021 03:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610337018;
        bh=oF44X8MQp1tyEl4InMD1qaQfyI71Rk1wT1E24QEzvaM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hxWfKiy+bu70dZnqT7LW7apV4XDov5/X0ZEYnyv+ONT3O9/6T355k5rLOBqrF3e6Y
         87jJn9NU63wpQXKhlkF+D1/KNSxKPRQd9mSQ3IZUvkGqc5Dt102X/TjXU2M0bepbn9
         DcwezPTZWN07fsWv9Oi7Ge+9P79i7myQJglv2oUzFqDDQrsDE3alcBl+7ph20YcVt8
         PJrfSpF9DhH0vV+lRFHUMwf6iZU5IbphuAADu/RypT1cLENteTOBlTUQDnCKQV/DmL
         6wu2XMtNmqe9z2kXuXYlZXLxfgKU3VT/XZJN1Raa1ozzJZU409kuXm1muUs/cu87hU
         Wj+64lkHoHMOw==
Received: by mail-lj1-f178.google.com with SMTP id w26so1852792ljo.4;
        Sun, 10 Jan 2021 19:50:18 -0800 (PST)
X-Gm-Message-State: AOAM531QEG3JvNK5ARlBqjpr+RJerxRMJisCc00hcTqg/hQhPyk7lwNN
        q7/b0wwwG8PVWk4yfI2Djmw+Qam3maLH7eGTl7U=
X-Google-Smtp-Source: ABdhPJzsN1bIRsgHV/UHN7LB05l3V5yKl2nri69NVhnFJhW/PtOCOlO/tG5A3xpIY6wtYnvESGVV4unem0fDRm36t28=
X-Received: by 2002:a2e:89d7:: with SMTP id c23mr6296678ljk.282.1610337016887;
 Sun, 10 Jan 2021 19:50:16 -0800 (PST)
MIME-Version: 1.0
References: <20210110194851.10207-1-jbx6244@gmail.com>
In-Reply-To: <20210110194851.10207-1-jbx6244@gmail.com>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 11 Jan 2021 11:50:05 +0800
X-Gmail-Original-Message-ID: <CAGb2v653hjzoQ20JsbO=wjf3hAWBa8M6fFA10Q+FRQ1xQcGgDQ@mail.gmail.com>
Message-ID: <CAGb2v653hjzoQ20JsbO=wjf3hAWBa8M6fFA10Q+FRQ1xQcGgDQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: rename pinctrl nodename to gmac2io
 for nanopi-r2s board
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Jan 11, 2021 at 3:50 AM Johan Jonker <jbx6244@gmail.com> wrote:
>
> A test with the command below gives this error:
> /arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dt.yaml:
> ethernet-phy: 'reg' is a required property
>
> The pinctrl nodename "ethernet-phy" conflicts with the rules
> in the "ethernet-phy.yaml" document, so rename it to "gmac2io".

This seems more like an unintended side effect of the ethernet-phy binding.
Is there a way to limit the matching of the binding only if the parent is an
"mdio" or "ethernet" node? Would that make more sense?


Regards
ChenYu

> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/net/ethernet-phy.yaml
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
> index 2ee07d15a..86732b45d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
> @@ -280,7 +280,7 @@
>                 };
>         };
>
> -       ethernet-phy {
> +       gmac2io {
>                 eth_phy_reset_pin: eth-phy-reset-pin {
>                         rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
>                 };
> --
> 2.11.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
