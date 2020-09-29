Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D8D27C757
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 13:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbgI2LxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 07:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731165AbgI2LxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:53:12 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3EEC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 04:53:12 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a15so3771969ljk.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 04:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kx4a5n3dqvCrWEJOLHbORqwKT2evqfk9ebyuySfjOtg=;
        b=OU7vwQdKxZ0/LaLBIdqXX1+fIXXyIvw8rgTl5QRSBJhESRYdc+j2h3iupiQg5463Ye
         KpfwCQcP+xtHykzaTmJ9hEtNQrN6jBPCtgtWGSznjpNY43P11jxRguU/ZwMmO4/5LU+s
         /B86olt2GnMoT4tgsoiZvB6K8+GUIe0XKu14UZ9uoHpd2BwqL6fbPHzvNYWgCjD2j5fJ
         T1ao/LSG4lXpoeuTLGxjwwNnBCuc4B/3d/ATesyG1VUkEFnyfPT1JHT5MyxU9X9KqTMc
         AkIr2rqMMJV8WtiZXs5bgM2acO0IM+QnbjKL5+AIJ0eDAnqnQGqIpSPgfScOloVYzq4b
         ebSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kx4a5n3dqvCrWEJOLHbORqwKT2evqfk9ebyuySfjOtg=;
        b=DbLZoCW8lIpC2HXz3fkzHc5EjFkQKZF0XGpNPac+Gsdzod5z+8/Mt3jFA7FH8QT7zn
         Oq0n03ESYsddpr6NFcj89hFocGpcs6lOsy4LaoW7X/z/AHSSoBx5pTgn9KFCshL2TCZ+
         rWPMNpIxKviiT0Setd0lZd4vqq/6Acbuie5g6j3t9vctaRLwDFls80KoIQ8iyLv0s9vd
         s2pZjBm/1jh1cEnFGyTXyNzKmNK3UK2iq/q/nvjj2jorqsuhJRNkMOjnzbXjn4/YKN83
         nRc3hVWSPB3mQvXjl3l9fVYdvlzUHzkieuUDguSWHaYyiTGaCEMCRYf2ETpeDMiAyFy3
         GTMA==
X-Gm-Message-State: AOAM531cYoa9LNNHKpTImxjqhKCVskq30hUtGMhNkx7QRV2Iv5tkAtjy
        73EuWwshpsdwv46d9RTBXJOmwRauneIzK6rvn/XMRg==
X-Google-Smtp-Source: ABdhPJyxfzQT2BAD2WMXJzi6V2K0dviJaIo85pSr+uDq2VHCHbTzqO83RgDyn4bkGg9eSg6Wd70UX8hhNgt6tNi9V6E=
X-Received: by 2002:a2e:4e01:: with SMTP id c1mr1004508ljb.144.1601380390453;
 Tue, 29 Sep 2020 04:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200920195848.27075-1-krzk@kernel.org> <20200920195848.27075-2-krzk@kernel.org>
In-Reply-To: <20200920195848.27075-2-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Sep 2020 13:52:59 +0200
Message-ID: <CACRpkda=R+=GBGGXrvjA9PUtq_t5772=Qd-9X9unhx=QTusnSw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: gpio: fsl-imx-gpio: add i.MX ARMv6
 and ARMv7 compatibles
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 9:59 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Several DTSes with ARMv6 and ARMv7 i.MX SoCs introduce their own
> compatibles so add them to fix dtbs_check warnings like:
>
>   arch/arm/boot/dts/imx35-pdk.dt.yaml: gpio@53fa4000:
>     compatible: ['fsl,imx35-gpio', 'fsl,imx31-gpio'] is not valid under any of the given schemas
>
>   arch/arm/boot/dts/imx51-babbage.dt.yaml: gpio@73f90000:
>     compatible: ['fsl,imx51-gpio', 'fsl,imx35-gpio'] is not valid under any of the given schemas
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Patch applied.

Yours,
Linus Walleij
