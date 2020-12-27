Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4587F2E32EC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 22:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgL0VWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 16:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgL0VWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 16:22:14 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBD6C061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 13:21:33 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id x20so19992194lfe.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 13:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S705wJ8jeaSFVbMX7bL0WkIpIJX6/PwuZQDPsUKEpLs=;
        b=npHMd4OCN05Aebn/ekZGqwFyJ1W9GvnSHfl8tutjfMfvJndFGLG23HGXzPHJNsTix/
         2W2teMq12gH0ym4ssei9zcu8+07nbjToAS5I/g/DRlt98SjP9QzlkF5gLRbU0NGP1NPk
         gkJoWn1KPRUvtySlLhmsyabmwH+prgFWVsR0xUT64NWbJi0ZkVNj95WH4vvfPYEohweO
         Ssxm6v4jVu39NV0o9hthCfLIgDZ38kO3ibXLG+ZdtFJecbPPRbU+c+NphExJDywi4xVr
         jBwoYuV0dFxvlcROwZXEnpcq2BAICNYmQ+t+1apyvHszRbV2vjbauJC3E5pnL34C0yOI
         7aoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S705wJ8jeaSFVbMX7bL0WkIpIJX6/PwuZQDPsUKEpLs=;
        b=pLhvCsB5e82P3r6oEy/RuGmhPqNPed4RG1aeAnujpJH1NWuVY2zjikTUfM8Rb/Kg3n
         N9qmpiOLJfZvhRwp9yxQzDIZaYcoGx1tmTb3JnXdLQN458ecj92ewT2gJC+uq/bSBN+x
         gVellZDjP1Jn/9aMSCFkN9qyko2WvbsAwEaPuKC6ch7yvw4M2qiPyOnvhxBeqsYeaybx
         AquHT9CjzgHz62hwuLry4s5j+a8fiy0UlzKIDP8kp0vMHB/Q4g+wFbG40QOQ69VpYWFb
         xBKyBH+F7ZR6tX6nlcGVQlWJ5tTYFtmwz+byoHjJxOvbFmAvMEw5KWdi9FtRbFxhoD95
         a1Vw==
X-Gm-Message-State: AOAM530fBJ8B6LtAQyaCYCRsf3B061HIHX4kfq2oXGD0yF18opEmWPBa
        HFrLrGhs7nn5iCQUuDUnrOtjx0pCRZ6G9s8JDtkiqURhsQc=
X-Google-Smtp-Source: ABdhPJyc5EvZMaXo9k3+9/F9vBkhZsYE4IIEsTdjHaoNVq54awShCgL52rci+fH6v5fD8AHlPDiRrxBtX7V1KO90xyk=
X-Received: by 2002:a2e:3503:: with SMTP id z3mr21635698ljz.74.1609104092057;
 Sun, 27 Dec 2020 13:21:32 -0800 (PST)
MIME-Version: 1.0
References: <20201224112203.7174-1-nikita.shubin@maquefel.me> <20201224112203.7174-3-nikita.shubin@maquefel.me>
In-Reply-To: <20201224112203.7174-3-nikita.shubin@maquefel.me>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 27 Dec 2020 22:21:21 +0100
Message-ID: <CACRpkdadUVHefag4d42BJiOraAmHrXDcK7gzjZrLXn371rMwOA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] gpio: ep93xx: drop to_irq binding
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 12:22 PM Nikita Shubin
<nikita.shubin@maquefel.me> wrote:

> As ->to_irq is redefined in gpiochip_add_irqchip, having it defined in
> driver is useless, so let's drop it.
>
> Also i think it is worth to give a gentle warning in
> gpiochip_add_irqchip, to prevent people relying on to_irq.
>
> For example
>
> WARN_ON_ONCE(gc->to_irq,
> "to_irq is redefined in gpiochip_add_irqchip" \
> "and you shouldn't rely on it\n");
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Take out the suggestion in the commit message and implement it,
but I think WARN_ON is too nasty, just use dev_err().

Yours,
Linus Walleij
