Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD8C2918B6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 19:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgJRR5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 13:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJRR5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 13:57:31 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6237FC061755;
        Sun, 18 Oct 2020 10:57:31 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id b15so6479253iod.13;
        Sun, 18 Oct 2020 10:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OwO+2ZoIYjKx+96e5MqXXHni5zWxT99/uuVKtCrnVVo=;
        b=ceXunY3GU5QjPeRYXc3VZxMqop3hJMRfsJRoNP5K7dRjVbltTMllPJaBu+Ie2l9Gx2
         6Xx9tS6W+nq3YPiPAFoC2WtAz7xNQwMP5puEvlJSdf2MvCf9PExectwcjn9yh+ncDDqE
         Jqav5fiP0OfgA7vJfHU4w8on0cgRBXy8YUXXrinSVUIa4wNexJnpEVvXd8SCYk0AnniZ
         j5PdaMMmhn8OXqZWRWeYYsW/NgQpxFHcMCFNZnBmOyI+qFNv0zog5L1xATW7rUH5MjYz
         6sg6/XqhDNCLiDqMe3OHKn9F5DK3HWa2ke3OlnkAiYhOFnHF8QKaXCklYI/vsuzfJ5a5
         5PHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OwO+2ZoIYjKx+96e5MqXXHni5zWxT99/uuVKtCrnVVo=;
        b=ShBfniRGmlCBTvMkKEnEGRYswVz7gXppw3OGFRty4DYNgoX1I+Yl6QzFlySufRn71e
         MTykJ9glTyajd7MgbOmM4cY+DVUBwlhGUxRpIGljRWANcKTSRNBan544IHYOFFvyOkRu
         eCRXVfcuBTejRcLX9h4u3+j18vO/SsyNQ+Rm8ZjugZrNap+lWzZipHWE6kTwc+BjkzTI
         yoBGiK1Wsxbi1Bk1xBUp3o4D5k/huQhYwmtqj2dOZx4UG2on6DbXDY8McYPl9SHD8j6s
         11wz97dNeI8fgHGx0NhPW3nTlikTQJbm4W6jKpQwMXIOh2e5zIs+PU67ktFY/rqlWwF6
         /E/Q==
X-Gm-Message-State: AOAM533zd+8MQD59u3R3XR/Lges34ZWj2nZWh+LKMpOgYVAJgkSjb8ms
        NBmODKgpeCKZkppxDmp3bayVOX4GHfgm6wTMBX8=
X-Google-Smtp-Source: ABdhPJwr6NI8pWAaho1g3dNXpZysRqfWDeooGwv6tQWtY7JMiU1nkjvZkaRS8fJroNaHrqiI1LxMLwIoYdJMGXMw/9M=
X-Received: by 2002:a6b:610c:: with SMTP id v12mr8342499iob.101.1603043850518;
 Sun, 18 Oct 2020 10:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201018172409.1754775-1-peron.clem@gmail.com>
In-Reply-To: <20201018172409.1754775-1-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 18 Oct 2020 19:57:19 +0200
Message-ID: <CAJiuCce+VHusdYPv7QutYvCcCByz=nRcBotPNL6E=jA4U4=YoA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: beelink-gs1: Enable both RGMII
 RX/TX delay
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 18 Oct 2020 at 19:24, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Before the commit:
> net: phy: realtek: fix rtl8211e rx/tx delay config
bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay config")

With the hash for reference it's better :)
Clement

>
> The software overwrite for RX/TX delays of the RTL8211e were not
> working properly and the Beelink GS1 had both RX/TX delay of RGMII
> interface set using pull-up on the TXDLY and RXDLY pins.
>
> Now that these delays are working properly they overwrite the HW
> config and set this to 'rgmii' meaning no delay on both RX/TX.
> This makes the ethernet of this board not working anymore.
>
> Set the phy-mode to 'rgmii-id' meaning RGMII with RX/TX delays
> in the device-tree to keep the correct configuration.
>
> Fixes: 089bee8dd119 ("arm64: dts: allwinner: h6: Introduce Beelink GS1 bo=
ard")
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/ar=
ch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> index a364cb4e5b3f..6ab53860e447 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> @@ -99,7 +99,7 @@ &ehci0 {
>  &emac {
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&ext_rgmii_pins>;
> -       phy-mode =3D "rgmii";
> +       phy-mode =3D "rgmii-id";
>         phy-handle =3D <&ext_rgmii_phy>;
>         phy-supply =3D <&reg_aldo2>;
>         status =3D "okay";
> --
> 2.25.1
>
