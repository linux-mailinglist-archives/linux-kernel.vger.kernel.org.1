Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91291C254B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 14:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgEBMbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 May 2020 08:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727029AbgEBMbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 08:31:08 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606E7C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 05:31:08 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id d7so2545175ioq.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 05:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sqj5OwuLQEiWexB38E560Tjsw1EblC4/Va2EqzU4zWU=;
        b=TDQZRCub/ffrM2W4i8QJOuhIY+QH+daszsb1JtU2K1qx68balRapnI/NPBGF3rx+0k
         9+fT7x5KhGLiXSZlABWZAN8+G7oPLjRIS6o+sGKU5g6dDcLc1XbSGaZtOy/kwXWWDdgi
         EA+Qr24M2AWf8vtQrYUIITqUhyYcUdON3jdrg3YIlgiDChIKAuKIYBONAajUi5Y3eMkG
         IqvHBs/bCOi3d67GUs7y81AzXERtMJ5v5QlOrn4uwJqxzEAPBGIrOKcIIKq1orflrxNg
         dA5rMjh6CQec4qmjX6sO9PExSF9TZzgYDWxUrX/UqFalmZGdgN2BjMe2YEOIVfEJxCNA
         EW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sqj5OwuLQEiWexB38E560Tjsw1EblC4/Va2EqzU4zWU=;
        b=l0fhsOHiufLimGS/QL91tkYhrRRczWyotw2H9hOzNQmBuHu69Du8KnX5EH4eCgqSsK
         sXTEoSCqZpP+8IGhafyv/5DxSWvHmggVdmNY17EON6s9TiEBRiaLOEcyuZbF/pNdd7FW
         R9Lsnak+uWon0Ih41IxeohWlewCcHFJy+JNBRf6T/ejQb74BePXFYohCyVuvOda1R6X0
         r/vEidp97H1CtnMHEI6yRX5/hwW5HhbaMtENJT2LUxA7xlaPjYx++VrncZIFrOzDPcPb
         XzvtEjs2TtV4tfeWd7yyJ4c7chKJuQrCCAcp0EvLWYhOaromxjOA/zJa708MSd8YsjmE
         bkmQ==
X-Gm-Message-State: AGi0PuaiXf/b/0Ah3yj0IrFNsZvcbJJP/w5Y87b+AIQqLrk5e7JJtB/+
        3AITeJaqEq0Liglxw6l6WcdmyGQwzWqzoaKRIRmC/W0E0cw=
X-Google-Smtp-Source: APiQypLCKDX6+VT+B8oaq1wJy/OgIWsAdpELwqgIIb/i0Sgf4Zq30t2c9jYp25yvXVW+C9OZQ58ht4N448yyjimkCWo=
X-Received: by 2002:a02:a60b:: with SMTP id c11mr6944237jam.45.1588422667696;
 Sat, 02 May 2020 05:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200306103839.1231057-1-aford173@gmail.com> <20200306103839.1231057-2-aford173@gmail.com>
In-Reply-To: <20200306103839.1231057-2-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 2 May 2020 07:30:56 -0500
Message-ID: <CAHCN7x+cG873bhDkGPjq9u2bn=b0QRpdYgh_yvWkfyLBde_mxw@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable IMX/FSL Audio Support for WM8962
To:     arm-soc <linux-arm-kernel@lists.infradead.org>
Cc:     Adam Ford-BE <aford@beaconembedded.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 4:38 AM Adam Ford <aford173@gmail.com> wrote:
>
> The Beacon EmbeddedWorks i.MX8M Mini kit has a WM8962 audio codec.
> This patch enables the required drivers as modules to enable sound.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
>

Gentle ping.  I don't know who the right person is to ask for this.

adam
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index d19ca82b3c40..ab71a407288f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -601,6 +601,9 @@ CONFIG_SND_HDA_TEGRA=m
>  CONFIG_SND_HDA_CODEC_HDMI=m
>  CONFIG_SND_SOC=y
>  CONFIG_SND_BCM2835_SOC_I2S=m
> +CONFIG_SND_IMX_SOC=m
> +CONFIG_SND_SOC_FSL_ASOC_CARD=m
> +CONFIG_SND_SOC_IMX_AUDMIX=m
>  CONFIG_SND_MESON_AXG_SOUND_CARD=m
>  CONFIG_SND_SOC_ROCKCHIP=m
>  CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
> @@ -614,6 +617,7 @@ CONFIG_SND_SOC_ES7134=m
>  CONFIG_SND_SOC_ES7241=m
>  CONFIG_SND_SOC_PCM3168A_I2C=m
>  CONFIG_SND_SOC_TAS571X=m
> +CONFIG_SND_SOC_WM8962=m
>  CONFIG_SND_SIMPLE_CARD=m
>  CONFIG_SND_AUDIO_GRAPH_CARD=m
>  CONFIG_I2C_HID=m
> --
> 2.25.0
>
