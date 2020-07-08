Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE4E218FD1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 20:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgGHSlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 14:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGHSlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:41:08 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1EBC061A0B;
        Wed,  8 Jul 2020 11:41:08 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d21so27462491lfb.6;
        Wed, 08 Jul 2020 11:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QRi5jMHaa0mST1XZGNNGHEwxlp+8YixDaL9LSAsnAek=;
        b=CWywoPS2XRKdURFbskIdlGaTFwdplmq0NsA26TFSUSGw01II4DquCE+6Qujb/7zn8o
         N5/ULbYIk6fAkFefUAMvpPbbPWZEO3qDTvmEEsxNRGo9WkLxTQsVmqtrojTb5NLp1TR8
         SJ7akEGqdWbk6n3ggK5whnA+YEwufLliGv0udLrIiw2OCpsB6wtz3MLHNh72urAEhRmM
         vzy0Huh0Ea2ykDZOKAfa++gVJAXh56bG3OIAi2MxbYDS3FfbcQU92thGjqXiWZ4wAQtn
         2qczRTH3qNyt8LnDOpvvXgXjCDKF+Ot86IWF4LImWRB7LZEUMvS2DTFvwbQXx4+i+AJH
         2T4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRi5jMHaa0mST1XZGNNGHEwxlp+8YixDaL9LSAsnAek=;
        b=T/7a12uYB4Iv8fJHS6DMKMKe4r0EUGTwVcIxRCn4iOjVlNvBtEj1n/dI7ju5lj6Lfb
         gXl8AyNdD3EQKoGCdlJ0ESdZGoJVvMYPk7uBcCndl3J2UZ49/hzXGhF73aKAjtKKZEVQ
         ixNO7tn9MC0ibmrjKplAcbmADBcfwAHaO3hbN9OuXiXQIynK3pWPIav8ihsfaicFquy7
         8TF7hbIl+BVBqsNu9c0RZyCx1lwZ3W6WXlBDXX1hiVF9lMBvFIhbpnNmhTexf6JFgfiu
         rczg8R8LhiznXgK9JYALvvVvyS+rVTkt4O+TR5CDUOZgH9RpXYT/kyOSjFCJ9xwTu+Oi
         Bi3g==
X-Gm-Message-State: AOAM532JeVvbJAf4g41uDj1aIpo6g2Gica0J2sEVvIZObxJKJH5fHB5P
        fkGCctIWp07ifnMLLZY/1/7upY8+NYPW2F186C4=
X-Google-Smtp-Source: ABdhPJxWVkgHmzHLWBFmJuEvkkPoGxUyslR2659b2CPa3QJkqGCyNAKXNhbUTqWOVLn4/PZeswDr9fPFYSjP9UvPiLY=
X-Received: by 2002:ac2:5f04:: with SMTP id 4mr37251463lfq.140.1594233665850;
 Wed, 08 Jul 2020 11:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAFXsbZrFRH2=+OgBARRkku2O0Okv=jg-uZaN+1Cv1tEwq-8k5Q@mail.gmail.com>
In-Reply-To: <CAFXsbZrFRH2=+OgBARRkku2O0Okv=jg-uZaN+1Cv1tEwq-8k5Q@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 8 Jul 2020 15:40:54 -0300
Message-ID: <CAOMZO5C42kbRM7T3kphdOFZPCPHz6kS+32X3CPncrAnhiP3HFw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610-zii-dev-rev-c.dts: Configure fibre port
 to 1000BaseX
To:     Chris Healy <cphealy@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

In the Subject you could remove the .dts from the dts name:

ARM: dts: vf610-zii-dev-rev-c: Configure fibre port to 1000BaseX

On Sun, Jul 5, 2020 at 9:51 PM Chris Healy <cphealy@gmail.com> wrote:
>
> The SFF soldered onto the board expects the port to use 1000BaseX.  It
> makes no sense to have the port set to SGMII, since it doesn't even
> support that mode.
>
> Signed-off-by: Chris Healy <cphealy@gmail.com>
> ---
>  arch/arm/boot/dts/vf610-zii-dev-rev-c.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
> b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
> index 778e02c000d1..de79dcfd32e6 100644
> --- a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
> +++ b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
> @@ -164,7 +164,7 @@
>                      port@9 {
>                          reg = <9>;
>                          label = "sff2";
> -                        phy-mode = "sgmii";
> +                        phy-mode = "1000base-x";

Looks like tabs were converted to spaces.
