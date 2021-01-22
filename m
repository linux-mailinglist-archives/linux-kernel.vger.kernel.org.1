Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BCE2FFFB7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbhAVKDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbhAVKBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:01:09 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABF7C061788
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 02:00:02 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o19so6744887lfo.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 02:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3b6S2/z3tpa4MkB+bZqY5tPcMx97QoLNDAPmEmPnGt0=;
        b=CD6w0ZgUypDgjE9zR0ZJVOxq+rlOgFypR7WRO0P5wQjcTwWxl7hRP3Ql2htnVNIAcX
         a6IqCbfY2yRx6C5mdcNVOsZuG69XJvCbRsJ9Uwt9kAhwZJKg1z4WKyK8EfJxQXhrmawK
         jvFt+Si3bh4KoOEFtnIjQlVBRf7/v7+F49qvweV/jRKr+KlXm110gJzTsJCQIWgstzaw
         67MyDzp+6NUBDMO2GYmaWO2h4m36KrN07K4BoFPv7KykDmlqx27YNW9ojW1K0wkSNu+M
         JNGZPmD0ZAsv4GIQ7hMVzNvVvRqICKOZ5otGgE3Bh6ATdVkrvErsTghZo2d4jrVmARuI
         cncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3b6S2/z3tpa4MkB+bZqY5tPcMx97QoLNDAPmEmPnGt0=;
        b=WfzkapMpHpNKakNeP+L6kUQxkt9Rr8FkIjgMNBsAvxKnnq/RsJDkATQijzSsbvMjji
         fY5Fki9twzkE7vmSusVtbpuJevxeFg/oa0zTPfX9aQo7jOkrz51zALrM5KIvn70v/cUO
         oo7SIvLVDFr+eBA89ss1sKDU0zjot3eA5S38w/K+y8jDVVHQrRqz6hphEJVqvTv2e5U+
         ztqDu3kVKLLucu3MjazlvL4KdIfIl0Wz4MqaSpzaVQd+8TI3f4a+JcqarSX14q9GnjIf
         WdhM/6xHLhr+kYfRmCzwt8OJ+S5vK3AahekiXH+pP9OW0fSMDVtCyXyvmXJc31nnGqbl
         uwXg==
X-Gm-Message-State: AOAM531I3VSlvidx13l4KjqgQieY30Bw6kGb/PFijollPp1wz47weYdY
        OmnV+uHd8gcM9kjo1TB+Bcm1kuftOUxIWFWuAyN9Ig==
X-Google-Smtp-Source: ABdhPJwUwANyZtTNJ+wpcGjC0EBfyorEBi8TdaoRhCKcIcRkNc2spagF6/gcNBcB8Dn2Aspuc2waqUkn0aaoZM6u8JY=
X-Received: by 2002:ac2:5c45:: with SMTP id s5mr19528lfp.586.1611309601102;
 Fri, 22 Jan 2021 02:00:01 -0800 (PST)
MIME-Version: 1.0
References: <20210111182928.587285-1-angelogioacchino.delregno@somainline.org>
 <CACRpkdZp3oqj4VeUZEPu=POwAdf-7R3NzNoN9XehtEi_R_fgkw@mail.gmail.com> <1e34145b-a04a-1cbb-7fbc-87c69b8dcfd7@somainline.org>
In-Reply-To: <1e34145b-a04a-1cbb-7fbc-87c69b8dcfd7@somainline.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Jan 2021 10:59:50 +0100
Message-ID: <CACRpkdacfa6usOZtc+A=ZxEpB1ij_gAKX2PLMOaX0mY_0qHp6A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: Add driver for Awinic AW9523/B I2C GPIO Expander
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, phone-devel@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 3:38 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@somainline.org> wrote:

> By the way, this is really LEVEL irq, not EDGE... To avoid any
> misunderstanding, I think that the best way to show you what I
> am seeing is to just copy-paste the relevant piece from the
> datasheet for this hardware (it's not a confidential datasheet
> and freely found on the internet).
>
> Check this out:
> " External MCU is required acknowledge by INTN pin. INTN is open-drain
> out-
> put, low-level active, and need external pull-up resistor.

This talks about what polarity (active low) the pin from the expander
to the SoC/CPU is. It has nothing to do with the line into the
expander.

> When AW9523B detect port change, any input state from high-level to
> low-level or from
>   low-level to high-level will generate interrupt after
> 8us internal deglitch. "
>
> ...but since the datasheet is sometimes unclear about "things" (I am
> mostly sure that they have translated it to english from chinese), I
> have actually checked whether the INTN pin was pushed LOW when one of
> the inputs goes from HIGH to LOW.. and.. it does... and as you imagine
> yeah.. it's slow.. and yes, as slow as you can imagine. :)
>
> So, in short, this chip is raising an interrupt when any input changes
> state, regardless of the change being LOW->HIGH or HIGH->LOW.

This means that the expander only supports
IRQ_TYPE_EDGE_BOTH and nothing else.

"port change" above means edges.

Augment your driver to only accept this type.

The consumers better request IRQ_TYPE_EDGE_BOTH
(from a device tree for example) and consumers better
handle the fact that they get interrupts on both rising
and falling edge as well, else they may need special
code to handle it. This is not a very nice feature of
the expander, it would be more helpful to users to
get interrupts on only rising or only falling edges, but
as written, it will generate interrupts on both transitions.

Yours,
Linus Walleij
