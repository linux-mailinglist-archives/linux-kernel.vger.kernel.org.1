Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E8E27C7DC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 13:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbgI2L5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 07:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731557AbgI2L4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:56:55 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE61CC0613D2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 04:56:54 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id w11so5189012lfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 04:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wEyAKkg0BRNQb0XI+Fllxgmsp9nACuRk2KZy+Qn9luc=;
        b=yHaYZoOWCf/DHJ8zu/uGiwS87eaTWm5X0wFr6/CgM+gCpKVtO1OPRnU7MlwLFUI9p+
         mBBWvwggrUlrZvBFXfkwqtk502CUhlHOaT2t559bQqiY1oR4qARzAybhVKHCCgQHiZLT
         z69TeGvPcFpc3YXXgHwmSAOjmXQYzvcmKvNXmKoMPL/nwFhT6VHaXnL/m5pe2QWup9fT
         HkFJ5uGvhPyMuJZfZ0r1AsSxtKq16wvunbGCMvHBsESfALV2QBUJNT9JLStrZS4uJfHu
         GEs3vqIorBxvGYEIXEWYX/cEK5FE32k08PERFeKojMhszEQoYxqUrzdUjNTac2pDAHfi
         kuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wEyAKkg0BRNQb0XI+Fllxgmsp9nACuRk2KZy+Qn9luc=;
        b=udnDwF7K/zoDAaVo5XSrQEsSXTDninuWdkQQSt2iAP0yJ4+cUe7Tzp5jfiRvjATm7Z
         ofcpj9KBd3H3C8czsjNqiDsgAN0b6aWYt9BfUtyeSWEFtBpZXLoosQJOgv5b+8p/f8QY
         +5i81jF82MaVbd6WvA0QKvJvJ4do1EgfDGCev5cqmkB/ZGH9pih875nBXO6LauoVwIte
         ySzdDFROfpU0CDeP6lNv8Lig/5AW5mmqoabTJDAEkMmEhMHBz5PB4BPJskad2uqTTbwe
         hMwwyH4JTbfuEM810rdN7RvIjjbkv4hbFB1X1sVFau4TrrgNcMD86aCQrmnWXxe6SGcW
         uv8g==
X-Gm-Message-State: AOAM531MBVW4OikVAy7QYzJOx2g8fFht2SXT+u0ro+ezk1jd0dhFlbCT
        Y+ojps5cZrB5EKut3zfObDyaCh9vo8LysQNA2y0HIw==
X-Google-Smtp-Source: ABdhPJxD9RnJu9niLvXl7peBAqIn8XNlpZwat8yHk+I/9rvKMxpEJuaIW7mJjGdLPOSa+o71BKqK6zUX6arDevsifYk=
X-Received: by 2002:a19:1c8:: with SMTP id 191mr1004517lfb.585.1601380613115;
 Tue, 29 Sep 2020 04:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200916162250.16098-1-krzk@kernel.org>
In-Reply-To: <20200916162250.16098-1-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Sep 2020 13:56:42 +0200
Message-ID: <CACRpkdacWQKgCY1E=ONegPRE001UA-DmvRKB+Yz1maapYQ5rVQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] gpio: add common dtschema
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Anson Huang <Anson.Huang@nxp.com>,
        Sungbo Eo <mans0n@gorani.run>, Stefan Agner <stefan@agner.ch>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yash Shah <yash.shah@sifive.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-unisoc@lists.infradead.org,
        MSM <linux-arm-msm@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 6:23 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> This is independent work of pca953x bindings:
> https://lore.kernel.org/lkml/20200916155715.21009-1-krzk@kernel.org/T/#u
>
> The DTS patches can be also applied independently.

I'm a big fan of this patch series and hope for a v2 soon
so I can apply them.

If you do not foresee any conflicts in the DTS files I can
apply also these, else you can apply them in the i.MX DTS
tree (wherever that is) or I can provide an immutable
branch, whichever you like!

Yours,
Linus Walleij
