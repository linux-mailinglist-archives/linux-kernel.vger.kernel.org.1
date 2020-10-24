Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7F2297E48
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 21:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763703AbgJXT6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 15:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762862AbgJXT6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 15:58:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF29C0613CE;
        Sat, 24 Oct 2020 12:58:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c194so6184480wme.2;
        Sat, 24 Oct 2020 12:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yI7DQlIbMqrUzjgEWDyjjKv7eTTNrYda8KbimVLIc34=;
        b=Kfs3KwQIv5oHHLZBxh0f7hx0NVJopMhp1MJXOke5qWjomNYbc9aCSK+m+heDKCf/mg
         s4L5wdwcIZB0V9GsKDNm50n5XVHN81Hs+//PqrXlr3B3Gnv0Ai3IlD9ToxhbOB7NRuUV
         xhl7oYwnhEvF4PoHPPyQ1ihzVCFt+gUeJ7zeosJrTlP8nD2YMJiEROoSd958jXIKu/xR
         EKluP+G5tCGD2efi+WbX2Uw2D2JmbaAqThRVEtWqiH32AQ6bFzyiE26Y6c1hY0ex8u8V
         IMVN8PDVjUaJS1gYUp/12+dw69NiVAgJacs+pVPNAGSrr2Fiyt6KYR1BxBEqb5UN7YOv
         eyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yI7DQlIbMqrUzjgEWDyjjKv7eTTNrYda8KbimVLIc34=;
        b=rprJqqUv5pi5/LqWjmtRLZmKkJtogouIIV+oZCHlUnXgP30uyPvcTBMynwcQqBLQeZ
         Pz2SVYhsUmsxV2dperLA2Xrj23B20NQ+8gtkUb6J3BN+MIBVZsh3XXEEP/ugYJZ/1ddo
         YsM7lIi8idXW/cBCb4JFaFfv87z+TgPBISjNdrSEthLnOXMZO586V8rOGRfPTby7rW5V
         zF68NFJVRRx+VQIMgbMxt5iB07mG2ZxA8HB/6cjC54gZ6gVsPGk9ff41cOaqZsa8jX8H
         3WEROISdjWC0MycqAvu2FpYB420mbR3UMSHZzaCgbu6oa0Ap3bmQw2sgNkycGxFXv4Hi
         tSbQ==
X-Gm-Message-State: AOAM533X49d8Gn27/nPJ8d/aor1MHmK46ns5iKKODMbWbIy0J3Qe1o/e
        XYHoLdq1ZbhaBbDlNcCWWgg=
X-Google-Smtp-Source: ABdhPJyrPbPLmcv1UVjJniX/1N6rypikoOlIc4kvJZnYMxhNeDIecThfOdFEaXW5slBdlVe1YUw00w==
X-Received: by 2002:a1c:a3c2:: with SMTP id m185mr8189575wme.161.1603569485953;
        Sat, 24 Oct 2020 12:58:05 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id v6sm11564319wmj.6.2020.10.24.12.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 12:58:05 -0700 (PDT)
Date:   Sat, 24 Oct 2020 21:58:03 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-sunxi] [PATCH 10/10] arm64: dts: allwinner: a64:
 bananapi-m64: Enable RGMII RX/TX delay on PHY
Message-ID: <20201024195803.GA30672@Red>
References: <20201024162515.30032-1-wens@kernel.org>
 <20201024162515.30032-10-wens@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201024162515.30032-10-wens@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 25, 2020 at 12:25:15AM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The Ethernet PHY on the Bananapi M64 has the RX and TX delays
> enabled on the PHY, using pull-ups on the RXDLY and TXDLY pins.
> 
> Fix the phy-mode description to correct reflect this so that the
> implementation doesn't reconfigure the delays incorrectly. This
> happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
> rx/tx delay config").
> 
> Fixes: e7295499903d ("arm64: allwinner: bananapi-m64: Enable dwmac-sun8i")
> Fixes: 94f442886711 ("arm64: dts: allwinner: A64: Restore EMAC changes")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> index 3ea5182ca489..e5e840b9fbb4 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> @@ -105,7 +105,7 @@ &ehci1 {
>  &emac {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&rgmii_pins>;
> -	phy-mode = "rgmii";
> +	phy-mode = "rgmii-id";
>  	phy-handle = <&ext_rgmii_phy>;
>  	phy-supply = <&reg_dc1sw>;
>  	status = "okay";
> -- 
> 2.28.0

Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Thanks
