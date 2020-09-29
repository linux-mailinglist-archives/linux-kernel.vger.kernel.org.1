Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703E527CE5E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgI2NF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgI2NF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:05:27 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D87C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:05:26 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v23so3971956ljd.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7PoE7dEYIPuVwlkZqO1LLEHQQKtt25v2DVlOMP6AHo=;
        b=fUrzP0OYv9HgWhQEMMveAgcsP7oGj/RW2J167Cs+TZnEA0MmgxSrelrsBCojKwOaa6
         C7IaETPGB5R7hH9hQNXgG2HLmDPyF1O++WCdUdkUGtbGYOUD5d0KCW0yIDcHJcfBtEat
         MN/soPKcLbN4alynV/3Oq+K/7mWC0qHK4SI11ExFZsTAFvCK4Rr5iEnJKQmICmPDJeO7
         o8qQ2wEJduVhtV1ohJ1kkxbunGkigCjg6s1Nvw4CBjNLc5DToEuXlxXRhEH1JBrJGQp8
         tbpuiHeV9873EhxbWuAY+kf+fDFSBk81xTK2W77hnbMtlTAq48VilmGB7saaXhZG/eXm
         TXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7PoE7dEYIPuVwlkZqO1LLEHQQKtt25v2DVlOMP6AHo=;
        b=mEQ+TrfGA/PJhkiic3zvjRP9H8xo+LE3Og0hTBbjtm4GGPopTU97gw2fXoFdfuiudY
         VGGf5x+a8Dhu+gN7RvOQZRWENdoGw0oN1Wzrvtm/+5/VtzsKWZ+OQ0RUE6/MxO9/Rn5O
         Nnh7zPeArqxQ/jYA0r+6pZYoq1g4U6veEUtJD3x6Uw+FjD5u5MGTfMTKgacMWkD4lkWg
         AgNPZNdfYVlRJM767mvahYFfYLUwUFCFrz5Hk5C15xiTUuFEYIogUmy58fBb39f7W/0k
         sDBBRw/rJMXW6Mpqceqpq2TtYdaNcIhbNTRenkJg5Naut6n3lACgjLT4KKSEx6p6diZy
         bPHw==
X-Gm-Message-State: AOAM531/HwTtRWazONGkB/4sflNx+GaIrC+7+UKhsm+nHsOZz3vfQaQl
        gM0kn4EPOaZJa5wrlogGU/yRdLvxYJ4/EkYYVow6sA==
X-Google-Smtp-Source: ABdhPJy/X+0WMwLJnnaZKPuQshR6BsIoPrQETBygBLitZ3v7V9F2iF7XKoEqTKr05CyXJA2Nt3Dv7vr56hcwRJbw9jg=
X-Received: by 2002:a2e:a177:: with SMTP id u23mr1110925ljl.104.1601384725264;
 Tue, 29 Sep 2020 06:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <1600320829-1453-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1600320829-1453-1-git-send-email-Anson.Huang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Sep 2020 15:05:14 +0200
Message-ID: <CACRpkdY-A6i+2SRVn9TJC8C3+rYa1qMcSHSwOaR_jKfxjOK2VQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/4] gpio: mxc: Support module build
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        oleksandr.suvorov@toradex.com, Peng Fan <peng.fan@nxp.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Lubomir Rintel <lkundrak@v3.sk>, Joel Stanley <joel@jms.id.au>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 7:40 AM Anson Huang <Anson.Huang@nxp.com> wrote:

> Change config to tristate, add module device table, module author,
> description and license to support module build for i.MX GPIO driver.
>
> As this is a SoC GPIO module, it provides common functions for most
> of the peripheral devices, such as GPIO pins control, secondary
> interrupt controller for GPIO pins IRQ etc., without GPIO driver, most
> of the peripheral devices will NOT work properly, so GPIO module is
> similar with clock, pinctrl driver that should be loaded ONCE and
> never unloaded.
>
> Since MXC GPIO driver needs to have init function to register syscore
> ops once, here still use subsys_initcall(), NOT module_platform_driver().
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

This patch (1) applied to the GPIO tree.
Please apply the rest through the ARM SoC tree!

Yours,
Linus Walleij
