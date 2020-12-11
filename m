Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1C22D82B8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 00:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407148AbgLKX1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 18:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407132AbgLKX1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 18:27:24 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D614C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 15:26:44 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id y19so15544053lfa.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 15:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z6PhJZv6zHVP6qteVXw9cQb7pTkmh+2trbpC+4pCjps=;
        b=aNmmHGi/zWi5kpFJTnTMq1+watX4PO35pqD0r2jLcVqAVUP6UBt9Eb3uBxi4YFfh0i
         0zeJS7It7fqlxQAEftY4XGC0MGLMrkoi2B+sHmM1J8EbMMj7zzB0arkvtDwNY8Er7AAj
         iM/1vdqagg/2Bedamdmi1Akw6sAjAhLuBd0Ob15DaylDTsTLcUrT9qwmyAK8yVhr/lPu
         LGJ83SiaXoSKRRZDDt6jhmvJjJVxs0n+jJ7izz4NQxKyuSZ5bftepLvJf2LhmL+OsBTj
         bdO+FPuWldrl4Sv3GRPL6sF32lUx3fEV2dLkLFnduFYxi9igLNynAcN09lNld582nxwo
         EP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z6PhJZv6zHVP6qteVXw9cQb7pTkmh+2trbpC+4pCjps=;
        b=cC2NXJaYyv3Fm92FxoG8b++stnevNQ8SoK+LyZZFaVS+30m37EPo17lxYKBabw93au
         v/FZm5f9Yn0a6LUbGg7xOeUn2xyOfXBrUuoObaNrx3h3TsxTFcPalGCT0PryNtEtmrV+
         hl05Av3Y3VlDSCo7VXKguhrQirf1nSLS3UsNRB6oVkbSdbExSh7dUcNaug0t7KUrBUWO
         s9gIUiN/H3MBBzTyF/pk5YnlSpnbi/63xlaq2/Cq6tyQ7h0eYTfQeiqhOWin3f8plOLU
         bAd7by1kdLore8oNJvYxZTFC/P3pAWriUo2Q0H8SuVEDRYLIbuTMgS+uXpVrwr+LxKwa
         mCHg==
X-Gm-Message-State: AOAM5338Bo4KkMnBPGpaBP/bzaobtE+FUAv3dmO2xZVlSaZSd9/tQ00N
        4VQx5mYIHA6Ni7BhIPnARCKWiheVYGTZjeshP9bxCXeDhMvouA==
X-Google-Smtp-Source: ABdhPJw4tAM4PtQO1s/eAGmfEsWUJtb+ticJs8TiFvLhBoTMhtc4ZjM2UG8WjozcdEDVwDdvV1XB7C8e0QxZxuIqHRc=
X-Received: by 2002:a19:6557:: with SMTP id c23mr5077406lfj.157.1607729202738;
 Fri, 11 Dec 2020 15:26:42 -0800 (PST)
MIME-Version: 1.0
References: <20201210070514.13238-1-nikita.shubin@maquefel.me>
In-Reply-To: <20201210070514.13238-1-nikita.shubin@maquefel.me>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Dec 2020 00:26:31 +0100
Message-ID: <CACRpkdaUdF_4RDWAw=8B_HL0e13KmwU34oYDGc-sFctD_5VAjQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: irq hooks: fix recursion in gpiochip_irq_unmask
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Maulik Shah <mkshah@codeaurora.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 8:06 AM Nikita Shubin <nikita.shubin@maquefel.me> wrote:

> irqchip shared with multiple gpiochips, leads to recursive call of
> gpiochip_irq_mask/gpiochip_irq_unmask which was assigned to
> rqchip->irq_mask/irqchip->irq_unmask, these happens becouse of
> only irqchip->irq_enable == gpiochip_irq_enable is checked.
>
> Let's add an additional check to make sure shared irqchip is detected
> even if irqchip->irq_enable wasn't defined.
>
> Fixes: a8173820f441 ("gpio: gpiolib: Allow GPIO IRQs to lazy disable")
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Good catch!
Patch applied.

Yours,
Linus Walleij
