Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2980E2D27DF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgLHJj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgLHJjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:39:24 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C2AC061285
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 01:38:56 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id f24so18324602ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 01:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Df6CqLv6JOagx1Y8po8wBRxgE1D965nfEA75Zeqy5oU=;
        b=hiBfGGso9wRtqNNhBBDBX1PZJI4bsFd8GYtW1arlG6wQ4COUeIZUEbdlyvCERMJMNo
         G3mKLQX6l8yLU9kEnfD7DSvjlpMv/k/voYdOTNP7XWZPPJ/qSQk8mxqGTTh8jNzexWF+
         IM8Az+l2VS7WmMT17YcIg6P/3wHd3R+VH1SSg9INsPTtt3qSUiUthy5zd7hakcqWkB+O
         qSfwe3vWou5ZGLP9SOQvoHKDMgFZGQ1O3JUjz3sj++5TS4p8K381xHRqUXYIzwKWdgKO
         FQZL/lFJPkZkG5N/3mq019RC7s6wgK9FMFx6XuoeVpbfGEDxYEjwM070MoklamNKuEIX
         cY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Df6CqLv6JOagx1Y8po8wBRxgE1D965nfEA75Zeqy5oU=;
        b=d5rs2xTTBYIGyomEzJp/RvdPeKmAEkqoilfqpQCov9kxBqkvDRgaVIqbW5AlT6gqdG
         b6/0OvFSA+2Cr2fDqA9Ly7ocKZzijJvK6EAlqMzsh1sDVsjipzvqFkKiWAVagPrF56dh
         P3n76pYKSFSZKhq9umTa7YsSEgyr/IFkPTnJ2nJ/h0l8LS7cIWEPGumSfwqS309I6Kd7
         hZuj0/EzM1whIDnuBvZvB7EAmlJNyRww3Sg/WqGVqVjJgbSfFNJ7RSg62SVLrfxCpI1B
         qIfvq7Z8xUptNQyDm7bzZNU9k4RKr3S8nfGW/mtqHWkcoWqWcl7yl/gYRnWZMbUPWaWZ
         StaA==
X-Gm-Message-State: AOAM532P2U4eiCnrVjb7qv3OhwgZCTMTr1Xpxeh0mBxlRG15vp93XOo1
        cNYSrBrnSjgUE1oCbCJR6xHOCZqC5krJF1i+Jnp/vQ==
X-Google-Smtp-Source: ABdhPJxQWX+drL6yggghfNbiTL59lvfCIOzavoQ1GoTxnH37PaUwIwrN8fyjAkWeHJ5nGm3eQq7eo4VvW5wksxdLa68=
X-Received: by 2002:a2e:910f:: with SMTP id m15mr10801861ljg.467.1607420334616;
 Tue, 08 Dec 2020 01:38:54 -0800 (PST)
MIME-Version: 1.0
References: <20201203191135.21576-1-info@metux.net> <20201203191135.21576-2-info@metux.net>
 <0080d492-2f07-d1c6-d18c-73d4204a5d40@metux.net>
In-Reply-To: <0080d492-2f07-d1c6-d18c-73d4204a5d40@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Dec 2020 10:38:43 +0100
Message-ID: <CACRpkdb4R4yHcUV2KbGEC_RkU+QmH6Xg7X+qee8sEa9TURGr8A@mail.gmail.com>
Subject: Re: Howto listen to/handle gpio state changes ? Re: [PATCH v2 2/2]
 drivers: gpio: add virtio-gpio guest driver
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 5, 2020 at 9:15 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:

> The virtio-gpio device/host can raise a signal on line state change.
> Kinda IRQ, but not actually running through real IRQs, instead by a
> message running though queue. (hmm, kida MSI ? :o).
>
> I've tried allocating an IRQ range and calling generic_handle_irq(),
> but then I'm getting unhanled IRQ trap.

This is Bartosz territory, but the gpio-mockup.c driver will insert
IRQs into the system, he went and added really core stuff
into kernel/irq to make this happen. Notice that in Kconfig
it does:

select IRQ_SIM

Then this is used:
include/linux/irq_sim.h

This is intended for simulating IRQs and both GPIO and IIO use it.
I think this inserts IRQs from debugfs and I have no idea how
flexible that is.

If it is suitable for what you want to do I don't know but it's
virtio so...

Yours,
Linus Walleij
