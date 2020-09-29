Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFE127C743
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 13:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbgI2Lwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 07:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731222AbgI2Lwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:52:34 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC62C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 04:52:34 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 77so5183533lfj.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 04:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+tsxcTYlmIt7fvSKcCyMiXfnmpMUlkCmokvJqIWw/AQ=;
        b=jjOWrjZ7uwCllS0OYNttixtOrGeXrQxJugCu2v3GwGaMU88Cbu9bKFfcGk4YgS8kA6
         CsxTSPEhUEB3QIobkbv54/t2k1Apsnjom+7y/88PmGKC6hXYb23/zfW9e2NG9HFaTWH3
         giuTVdl61v/yhftsQIkuKaAtvCQDNCkOPMMCmqk4P1QjWB1kaBJQopeN3vzmME+jkiMF
         StGTEqKwiChGFx+SW7eOlWuhtGOUsgUvkCAYA8z9mGM0jiR9LJkVXCR2ev4BtHpPTdpD
         4tg6P7tqtBhWeLx7A/5BU61hYP1khSLAlsN0wd4MfmqHTfV2chMeeo+BbvoDURpxfFpK
         R8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+tsxcTYlmIt7fvSKcCyMiXfnmpMUlkCmokvJqIWw/AQ=;
        b=XDWELO3hrYDucudSGr15IVFHD9FrzGw9L8jpZpRImhp7w8p1NmiTixOjzeIfmgLiTR
         tahMzxBGFi+giK0bs2Bbvz+9UKpHDKKOyGurUMNo3qqIYx7oW3zrbqy4MqQIFVxLuLe7
         LpcbNUnQ0A/Ov4PNdwUTj+lZI0WgA+P+d55JpnYdB9Yj8tlZs4oHKb1LxIChHQG4Nf+k
         wYdOnTp5tJbV2wsoTB8y8AUDRgt3Vd79OqYmdHkgUkjqYgMLz1CpDMA+JcrCC7LK+O5o
         xslg4dEpN3hSLSY6rACgiWq845HOsbbjonHBGWh5LsGIufldZgp7ZdeUHjFypD3hWXM0
         Veig==
X-Gm-Message-State: AOAM5337snr8aQkOIFBa9heYNSY9VM6/m7tjr5XB38+6jdNDY0793Z4C
        GnhNXzkg5QSl/lTrRZdjdOAhhfIj7i3v6zteqMlnbA==
X-Google-Smtp-Source: ABdhPJyz74jPaVUkdmhbwYZ2S+u3dSjvZvKxeT3Peh7LpsNsRgF1dUdYrIIkppHQ6YlpE4/57iHv2mOxCZjyaQ7fBcM=
X-Received: by 2002:ac2:4c11:: with SMTP id t17mr1163049lfq.260.1601380352826;
 Tue, 29 Sep 2020 04:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200920195848.27075-1-krzk@kernel.org>
In-Reply-To: <20200920195848.27075-1-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Sep 2020 13:52:22 +0200
Message-ID: <CACRpkdb+7jX7LV0U9J74sQefgxzkwOMv5E+8uvjrmb2Vexv+SQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: gpio: pl061: add gpio-line-names
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

On Sun, Sep 20, 2020 at 9:58 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Describe common "gpio-line-names" property to fix dtbs_check warnings
> like:
>
>   arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dt.yaml: gpio@e8a0b000:
>     'gpio-line-names' does not match any of the regexes: 'pinctrl-[0-9]+'
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Patch applied.

Yours,
Linus Walleij
