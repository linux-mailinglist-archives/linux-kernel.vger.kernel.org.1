Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47DA2D0592
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 16:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgLFPDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 10:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgLFPDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 10:03:23 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62255C0613D1
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 07:02:43 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id 23so1332294lfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 07:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7GSF7/q8MnFUXWw+PCnNRKUNyaVuIobqjrVeLl4q8oM=;
        b=kOCuOXb6USjnRhIr8MASK53UanhDGAkTbTLq+CMMz9gJEM8JM9hA0ztutFWH+lj2A0
         E6N+5OvSsKYRqaHiZ2E7LhWLorYl3f0VgYsS2wIM1WP8YjNxOHtNiV629gR/Y5L+syWm
         QnhTHsPmYHsEeuEZkzOf5Yf1ru8aE7EG4XvI8txPrwFJai3W47QdEIspB0Qob/UX76zP
         lcyhRaIRYT7MYFjxFy9FmUkBJssgaG/wRKcn75pN90/JHyZtA0MRqoE2+gcSKzzbZa3l
         ZP14VTynl2nyYdugXgVwtsRwfsGdn7J6ivYbwPPSOTOCOVmL3OK81ED+wHhF4+MoeYXZ
         Hyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7GSF7/q8MnFUXWw+PCnNRKUNyaVuIobqjrVeLl4q8oM=;
        b=qeXFigfeVAvpUjzm8udWghBToAa0QhJSn5LTQnz3xthGsgpkwBpuzsJFgaCG/H4QqA
         oa6P9yDIn5Htb5+3BKKFEO1n7UF2EYTef3y0XuCEU+rvO7Tc6dQoqGFL6JPpOq8Jdw46
         nANQWlZgUpDc4HjxptLJLsx0N9Ybhj6FnZQJLkab0Wsm1FyS5+RXCA2SDuGt8dnvtwN7
         xZCJ0gZmxR9AuRPTPisjKkxye9p+NXTZh1V2TcN3tPjxOkM6LpMuCEPScM1eKcpLIH7+
         5D+9BhhCI4KyrahlWcyqMXB1bCzgdW90qg/8D8X68PZcZkqcqh+T2cSroBK48Hx3dgDq
         +GRw==
X-Gm-Message-State: AOAM533LvuT6y0sdmNlf5KITSDzpNErgIS9g6kxkdG9B3/AJMTxyagQT
        BPP5+8OUVmeuvutXxvsQmoTmWUVI67j/YBuBw4QKIg==
X-Google-Smtp-Source: ABdhPJwvs892kp0Bqkxvf0wpF1Imbv+JqWWKo/L7nlbwoTL6xww6KxK3jwQtxp92trguwcg/bu4WrU/YMXd7+MQPgNk=
X-Received: by 2002:a19:ad41:: with SMTP id s1mr6982448lfd.571.1607266961278;
 Sun, 06 Dec 2020 07:02:41 -0800 (PST)
MIME-Version: 1.0
References: <1606728979-44259-1-git-send-email-luojiaxing@huawei.com>
 <20201130112250.GK4077@smile.fi.intel.com> <63f7dcc4-a924-515a-2fea-31ec80f3353e@huawei.com>
 <20201205221522.ifjravnir5bzmjff@mobilestation>
In-Reply-To: <20201205221522.ifjravnir5bzmjff@mobilestation>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 6 Dec 2020 16:02:30 +0100
Message-ID: <CACRpkdawv2NUahn2gniH=29T6qqqFYSa53giC01PS1wq91+Ksg@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: dwapb: mask/unmask IRQ when disable/enable it
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     luojiaxing <luojiaxing@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 5, 2020 at 11:15 PM Serge Semin <fancer.lancer@gmail.com> wrote:

> Hmm, that sounds like a problem, but the explanation is a bit unclear
> to me. AFAICS you are saying that the only callbacks which are
> called during the IRQ request/release are the irq_enable(), right? If
> so then the only reason why we haven't got a problem reported due to
> that so far is that the IRQs actually unmasked by default.

What we usually do in cases like that (and I have discussed this
with tglx in the past I think) is to simply mask off all IRQs in probe().
Then they will be unmasked when requested by drivers.

See e.g. gpio-pl061 that has this line in probe():
writeb(0, pl061->base + GPIOIE); /* disable irqs */

Yours,
Linus Walleij
