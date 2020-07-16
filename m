Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01E52223BD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 15:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgGPNTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 09:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPNS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:18:59 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E893C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:18:58 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id j11so7095164ljo.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V5Ca35ebl+wW+EHbz97RD52Fd1hjs4/Wel1X7KjjjwU=;
        b=TM0YEFUdP7iBDYKwh4ec1iIrtslkCq4rp5m2aXZxanQ+giClbZOLrssAlnOWDqmgRD
         NVe1+V28mxw70te0fvKlWItF1bihnaN4BQLocyLLj740og2JrlJWFyM3vVOx+F1D8XfE
         NbO6kctlpEueZ2UdBTuKiQGMNYL/aH+CVET4yVibTBDMnSCfmZoS0lbnVxHbSEr9SLOM
         SsPaWdCiFhGoT5F43qj1X0MDzPBshnHn4lwqGhiFlGqu7cR3VPvDeQY5x9WD6PGApyeQ
         fs9pRPVcC71jxL4OVlBTrkxMImCb6WN3fpg0pUQfEgZutRqmInLMev0jucnLYgaSneTP
         yE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5Ca35ebl+wW+EHbz97RD52Fd1hjs4/Wel1X7KjjjwU=;
        b=gYuyzKC0T8ExzoLj6Eg0ETU+mExtQmBbNXfIzAa3eEL22oiW8n07mjM55kOcfs0v/J
         fuV45NOniarDHmFFuI8VAyBmTUJzFLrPsqSzV7N5/fHOr0Obj3wQymmTuvce/kiH6MVc
         l8mPEHjZdUMVS62PDuD08M0eWq9VxbQQp4g4ip3pyRXWSgnyZgexEnguF6xHuCrcoPl6
         ouVibV1E40kjwMsU/mpSmL11NOzF4eK09FCAfJrzycLG/tCOwPoBeTK9V3ptVOhAJG9G
         jpu1IOsWizN/EoNvKyRoWhwZTgy8pGMDvOIXA+LC+7OVgexv9rr6aBlJeqKAgOoWrMpl
         /qMQ==
X-Gm-Message-State: AOAM531dR5fLelR+xkJYjtrA38Vc71YTPuDZxRcma0j5tJ0hGiwUVLtP
        mc7sBpAkyZTiLoU8MmdqdaB0G/NwF2hZnb+ZtN5vzQ==
X-Google-Smtp-Source: ABdhPJy86RFx5YN1TLuTTiPAQzbWyCQEl/ZTbibswwlk/TQOzRl8YXQ8Qu2VA9B3JmqypWkyIaj27nmrqbmtdbYLPbI=
X-Received: by 2002:a2e:9a4d:: with SMTP id k13mr2115378ljj.283.1594905537158;
 Thu, 16 Jul 2020 06:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <1592818308-23001-1-git-send-email-mkshah@codeaurora.org> <1592818308-23001-4-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1592818308-23001-4-git-send-email-mkshah@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Jul 2020 15:18:46 +0200
Message-ID: <CACRpkdb-3Tf4s5=Gxjhy62GX=HUYkLOcPKZ6JWaLTQipz-0r6A@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] pinctrl: qcom: Use return value from irq_set_wake call
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        =?UTF-8?Q?open_list=3AGPIO_SUBSYSTEM_=3Clinux=2Dgpio=40vger=2Ekernel=2Eorg=3E=2C_Andy_?=
         =?UTF-8?Q?Gross_=3Cagross=40kernel=2Eorg=3E=2C_Thomas_Gleixner_=3Ctglx=40linutronix=2E?=
         =?UTF-8?Q?de=3E=2C_Jason_Cooper_=3Cjason=40lakedaemon=2Enet=3E=2C_Doug_Anderson_=3Cdia?=
         =?UTF-8?Q?nders=40chromium=2Eorg=3E=2C_Rajendra_Nayak_=3Crnayak=40codeaurora=2Eorg=3E=2C?=
         =?UTF-8?Q?_Lina_Iyer_=3Cilina=40codeaurora=2Eorg=3E=2C?= 
        <lsrao@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 11:32 AM Maulik Shah <mkshah@codeaurora.org> wrote:

> msmgpio irqchip is not using return value of irq_set_wake call.
> Start using it.
>
> Fixes: e35a6ae0eb3a ("pinctrl/msm: Setup GPIO chip in hierarchy")
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>

Is this something that's causing regressions so I should apply it for
fixes, or is it fine to keep this with the rest of the series for v5.9?

Yours,
Linus Walleij
