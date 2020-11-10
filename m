Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDF52AD881
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbgKJOSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbgKJOSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:18:52 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2D5C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:18:51 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id v144so17702486lfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yEb8SLvwYM6675N1kcLu33g5b43ooDKnUWDg2MuNw70=;
        b=dySosniDNPpgvWYF4+JGAVaSJLsfzMMHchLwrnUw7r39jGDntjB0KjI86SPwnxMR6L
         d14V7OlbU1WDRfwoXkx6VPRKNYd+dKojut7EImce3jBAZL4x/MbsJSUO/UzMM8JMKyOe
         q2KwphZsBP2cGW06PXu0h64z9B6Ldr0uo+jezxWNRu5HFkDXSb9WS3dfHJmk4pkTHmun
         xAiWGNHwY+DHgl2LMrU9speqjv1MBlOl1y5WbsKUDsN5f8IoPPRIMk5+4j1WxCId9dtG
         811Pv4gP2GBQ8Tkdvihd7JqGt89vdyUiN7Pw4TdZUdPmbLgP0WmSqLHG4DF36jlB/XIe
         c62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yEb8SLvwYM6675N1kcLu33g5b43ooDKnUWDg2MuNw70=;
        b=djWagk5L8SZmkRghC6hYXkmsXE7CbBDRC6kQVucaJ8NZBd6dIy/YFv2jFC+pwop0w7
         oq3o9H81ED5K+OQvCL0jIrvFetoUX9lYJ7CFI6AFvjrd7yZoDA5w5cIATI5RvDoy5Av9
         YEFVAtslX+6kZNuH7D+cqVzPNU8H4jV9u9uWmlHILdm8dqTir4pBcMASAlEk64Y9XJ+/
         46DNbeOgC0jqfjJkHZKlWM+ynIICXXTwK8AMgR2DfiLzj0tP3BzrPu9/lQaLLTpr+5PL
         zbTb1g0gGvOZqNtjo+xWsLnaNKJ5V4e5rfs/avuong2pIoX0DNw6Q6el/FnXdS2W72Zp
         pvZQ==
X-Gm-Message-State: AOAM532mP9lwDB0XWZEwfsNZrgmYqKOBKn892plo0/0UzoCisexTOtS1
        SYHGPqwcHjiNXREaBN3OSzdI3eN3/p0KX2S6Up7UAw==
X-Google-Smtp-Source: ABdhPJx8DR3A9HZXVyV5Hw/ZIpPtbFQchtKdOZgI87BTIuRS9xLwWyIYq34Y5zWUwvd/nYChAFW4q26/YE5DXMVzvfw=
X-Received: by 2002:a19:ca05:: with SMTP id a5mr4558685lfg.571.1605017930249;
 Tue, 10 Nov 2020 06:18:50 -0800 (PST)
MIME-Version: 1.0
References: <20201105120410.18305-1-srinivas.kandagatla@linaro.org>
 <20201105120410.18305-2-srinivas.kandagatla@linaro.org> <CACRpkda91ncAVGj8_qcEyKPnRQdJjXMMCQ4ZJ1t7bVfcCZF=CA@mail.gmail.com>
 <f6bfa003-b8c7-f0d1-24f1-14f45fa37a23@linaro.org>
In-Reply-To: <f6bfa003-b8c7-f0d1-24f1-14f45fa37a23@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Nov 2020 15:18:39 +0100
Message-ID: <CACRpkdZatw-zUcRNJRCcdjcv2aeYJn16PdLg3nonTMmWFbhxig@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: qcom: Add sm8250 lpass lpi pinctrl driver
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 12:08 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

> Some more detail of wiring of this additional pin-controller IP:
>
> This IP is an additional pinctrl block on top the existing SoC TLMM
> pin-controller (Audio) pins.
>
> The hw setup looks like:
>
> TLMM GPIO[146 - 159] --> LPASS LPI GPIO [0 - 13]
>
> However SoC TLMM pin-controller can only be touched for use of those
> pins in GPIO mode and non gpio mode is completely handled by the LPASS
> LPI pinctrl block. Apart from this slew rate is also available in this
> block for certain pins which are connected to SLIMbus or SoundWire Bus.

OK put this in the commit message, good to know!

I gues the pins are not quite "GPIO" at this point, instead they are
turned into LPASS pins?

> Normally we would not expect these pins to be touched by SoC TLMM
> pin-controller as these pins are used for audio usecase and the control
> is always with LPASS LPI controller. There are additional bits to
> configure/enforce this in SoC TLMM block!

If you start to use IRQs they might become hierarchical WRT the
TLMM. But no IRQ support yet, so...

Yours,
Linus Walleij
