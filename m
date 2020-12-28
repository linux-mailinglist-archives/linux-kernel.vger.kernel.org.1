Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CA12E3726
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 13:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgL1Mj7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Dec 2020 07:39:59 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:36929 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgL1Mj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 07:39:59 -0500
Received: by mail-oi1-f171.google.com with SMTP id l207so11326121oib.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 04:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/o8rPjEOOY9jTW5pza5TK39eJRh/+9dlM5dwzzNz0WE=;
        b=ULjwI4fGmG84tsxoILOgUBhxOI+NCO4UxW7Nr9Z0K6KEXJOzbLH27qgVf43ZBq0Jj2
         nQQG8TVRA3dGUQUdV51TgRwSn4IPn8nHrDBh6+aQKo/gsIda+8y2J3ygm+JnwsijA7x0
         QV/uquwBpBudBepT5DPk+NnEg9Uw04DnyBuqP16Z2U0KHme2/EZwAybtFvvZxVt5j0TE
         +n2/6h4q3GssHE98u+rZTFlYCpSyY6j9rpYCKLTsqtCfR4c2NrOEcRVzXd3JGTFoJvT/
         iRZyKNaSrw0aTWuRLsNwibCd/EH1Cv8MUTQeKL+K/tAYBzuaMZ/HLSRO3xrHmJvMt2mN
         wh/A==
X-Gm-Message-State: AOAM533ypFmb14j7mhvyahbKmBj9c5H8Wn0EQUgDNqke+qSwMAo2tgL2
        mLlq0Qc6lPbZ8KJQf+FYv88nXAdiYm91o/JicwnvpAqlsgA=
X-Google-Smtp-Source: ABdhPJy+Nmw5tYpNUtl8ndWNxKOELbStVOp0R2quuKmnpLXGzL7PAVV3mSoqsRa65uV4QGBgOIOP/6YVNL7rqo/8ghc=
X-Received: by 2002:aca:3cc5:: with SMTP id j188mr11845795oia.54.1609159158285;
 Mon, 28 Dec 2020 04:39:18 -0800 (PST)
MIME-Version: 1.0
References: <20201228115349.57334-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20201228115349.57334-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Dec 2020 13:39:07 +0100
Message-ID: <CAMuHMdWXc7iWs3hbQyuokC18zZ9eL294MTeQa+tvB8Ahq-QUcg@mail.gmail.com>
Subject: Re: [PATCH] arm64: smp: remove unused variable
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 12:55 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Not used anymore after refactoring:
>
> arch/arm64/kernel/smp.c: In function ‘arch_show_interrupts’:
> arch/arm64/kernel/smp.c:810:16: warning: unused variable ‘irq’ [-Wunused-variable]
>   810 |   unsigned int irq = irq_desc_get_irq(ipi_desc[i]);
>
> Fixes: 5089bc51f81f ("arm64/smp: Use irq_desc_kstat_cpu() in arch_show_interrupts()")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>

Fix sent 13 days ago:
https://lore.kernel.org/linux-arm-kernel/20201215103026.2872532-1-geert+renesas@glider.be/

Note that the Fixes tag in my patch is different, as apparently the
offending commit was rebased a few hours later.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
