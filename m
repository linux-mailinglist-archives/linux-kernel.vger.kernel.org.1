Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3730E3039F8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404004AbhAZKPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:15:22 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:37277 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731494AbhAYT1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:27:49 -0500
Received: by mail-ot1-f49.google.com with SMTP id h14so13880513otr.4;
        Mon, 25 Jan 2021 11:27:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rMSnythaK4LFQsW5PlS81Mrlcsyec/gXB8IqOq/hvBs=;
        b=mn42I6VwmE0lPX1i5cY9+Ao1a3srpFcPJOSFvUUkokJsYNikwtcoZ2O6o6PxB9XQjM
         /okDDMkT4FOCUNxkg/OU5AY8mCMkLLPdTvs9AfEqBUqt4fp8YdFxRsH5/nucTg68ZqDb
         KRRD2eZABtX7THuOFHem01V3tmFnXyHTkxJ4vkU8lrspqV68+XW6iF/0KRSyiL+J0F5X
         df6JhsarFO3QfLUqnc3+DOZSuNy0W/DCP2j3zTem0b9wb7HW9iKyAAm5/UAXN5VW8Gdn
         H/pv2jVjTmDkWWkp0sNRLIpEWEjyYEbV6fodmT+BujuekGZJ6FcRJ5Vz5CScyreNQGI3
         JjoQ==
X-Gm-Message-State: AOAM5315KfPbhmzaDaY1VF/5/WsZ2Tigu5PyeparLLF3yF8zSzT5O2S4
        4yuN9X/ADzuohXKpx3oJJg==
X-Google-Smtp-Source: ABdhPJxcdD+A3ReVkIe5LdLjsOSjCXzIQzzE8Jiep2pdwq/Met5kvdKeWTxeat3Vqk6RR1S6MfLZCg==
X-Received: by 2002:a9d:1d43:: with SMTP id m61mr1562004otm.231.1611602822404;
        Mon, 25 Jan 2021 11:27:02 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n203sm3726310oib.4.2021.01.25.11.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:26:59 -0800 (PST)
Received: (nullmailer pid 812719 invoked by uid 1000);
        Mon, 25 Jan 2021 19:26:58 -0000
Date:   Mon, 25 Jan 2021 13:26:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>, fshao@chromium.org,
        boris.brezillon@collabora.com, hsinyi@chromium.org,
        hoegsberg@chromium.org, Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v10 2/4] arm64: dts: mt8183: Add node for the Mali GPU
Message-ID: <20210125192658.GA806742@robh.at.kernel.org>
References: <20210113060703.3122661-1-drinkcat@chromium.org>
 <20210113140546.v10.2.I9f45f5c1f975422d58b5904d11546349e9ccdc94@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113140546.v10.2.I9f45f5c1f975422d58b5904d11546349e9ccdc94@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 02:07:01PM +0800, Nicolas Boichat wrote:
> Add a basic GPU node for mt8183.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> The binding we use with out-of-tree Mali drivers includes more
> clocks, this is used for devfreq: the out-of-tree driver switches
> clk_mux to clk_sub_parent (26Mhz), adjusts clk_main_parent, then
> switches clk_mux back to clk_main_parent:
> (see https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.19/drivers/gpu/arm/midgard/platform/mediatek/mali_kbase_runtime_pm.c#423)
> clocks =
>         <&topckgen CLK_TOP_MFGPLL_CK>,
>         <&topckgen CLK_TOP_MUX_MFG>,
>         <&clk26m>,
>         <&mfgcfg CLK_MFG_BG3D>;
> clock-names =
>         "clk_main_parent",
>         "clk_mux",
>         "clk_sub_parent",
>         "subsys_mfg_cg";
> (based on discussions, this probably belongs in the clock core)
> 
> This only matters for devfreq, that is disabled anyway as we don't
> have platform-specific code to handle >1 supplies.
> 
> (no changes since v6)
> 
> Changes in v6:
>  - Add gpu regulators to kukui dtsi as well.
>  - Power domains are now attached to spm, not scpsys
>  - Drop R-B.
> 
> Changes in v5:
>  - Rename "2d" power domain to "core2" (keep R-B again).
> 
> Changes in v4:
>  - Add power-domain-names to describe the 3 domains.
>    (kept Alyssa's reviewed-by as the change is minor)
> 
> Changes in v3:
>  - No changes
> 
> Changes in v2:
>  - Use sram instead of mali_sram as SRAM supply name.
>  - Rename mali@ to gpu@.
> 
>  arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   6 +
>  .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   6 +
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 105 ++++++++++++++++++
>  3 files changed, 117 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> index cba2d8933e79..0a8c2fad8e16 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> @@ -42,6 +42,12 @@ &auxadc {
>  	status = "okay";
>  };
>  
> +&gpu {
> +	supply-names = "mali", "sram";

Not a documented property, nor should it be.

Did you run this against dtbs_check with your schema changes?

> +	mali-supply = <&mt6358_vgpu_reg>;
> +	sram-supply = <&mt6358_vsram_gpu_reg>;
> +};
> +
>  &i2c0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c_pins_0>;
