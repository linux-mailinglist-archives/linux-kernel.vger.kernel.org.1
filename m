Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24582A5E29
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgKDGha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgKDGha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:37:30 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947D7C040203
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 22:37:28 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id w145so15456579oie.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 22:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NdyAupHoBSpX8M4LNhpuR15yjy0bTroUkv3Rh3Q8LnI=;
        b=EK8UYcc+V7mbPA5bIGcRMagowbDawbm+GUFAp0Zae+iwnjhU3XDGEG2pQWoO7dNIiH
         iROpuEoA50KNMGEgL2wvanozsOfE1uO5ufljm7v1JPHmmN1ma7YuJdt3JB1z02wC5rdN
         TFyqiALsjwDjp3oFLw72sa0Kj37oaj2wOpx7bQFOkm8Cb1ZQbkTGzlFClXkwCMl86agQ
         vqLdQr8HHLYy4eBSo0trBzkTVod5SCD4rv5xzwh8q7OADK0yWqvpYt8Z/e2p1zUYjNHC
         +WyOYPbfXaO1yHXAYgy/RU7VpTdpFmxb493pHA5MqL9mETHw3XAMfowwbvag06WFiGfQ
         KS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NdyAupHoBSpX8M4LNhpuR15yjy0bTroUkv3Rh3Q8LnI=;
        b=BtT9y9iMieuN7z9lTUmsmkJwTsJ2VaWTAFGUhm6C98y+3sq47knad/51NhB+MpxRJR
         kC5Jk/3Q7GrqIa4fxCL2q30ytES5AofmAcsNE9lF/Yi/Ha06zUo9AuraVobO++TOvUMg
         iMl2gZkTfu2cTYtT7fxqsx6RHylTMzdQbEp1jfdM/UVp8zAuhY00XWYJUi3dFM0lToz+
         SA8mMwUPZ8fytN+AqbXZjuvWUxDdlw0M1nJ+IGVtGY5fOpS8+Y7pY3hgRa5d8BNe2i6v
         V034ZYdLqd9yG7gyjZ3lKnvOs/AQPZTkJ3QKZfNGfQZPZXWf0yelAEOXvBMJfYgDx4Q9
         XhtQ==
X-Gm-Message-State: AOAM532ZmJIynMUe6wHFe0Vj2yxwVgXbmIDwxOFXV5SQASQgbbzpqAVa
        TTkzzqaRtnJHZvXbRyzo4qJ9V7MX6gwTXiIsLgZYnXvGyGg=
X-Google-Smtp-Source: ABdhPJxm7DLYXbMomK9YWiWLSTVUPaRI+VJJ5tgZdr7+a3a21THR3UvntEHG9wp+X9qffZpaoq6YN7wXRbLEutw3IRc=
X-Received: by 2002:aca:4b82:: with SMTP id y124mr1676328oia.35.1604471847796;
 Tue, 03 Nov 2020 22:37:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1602838910.git.zong.li@sifive.com> <d0627c5b-1007-bca0-e6d6-0a3740eaf6a7@gmail.com>
 <CANXhq0pgeDZkWgwmZE+sFPjYhAmNBNoYGPRfij+Yz_Pc8hNN-Q@mail.gmail.com>
In-Reply-To: <CANXhq0pgeDZkWgwmZE+sFPjYhAmNBNoYGPRfij+Yz_Pc8hNN-Q@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Wed, 4 Nov 2020 14:37:16 +0800
Message-ID: <CANXhq0p2txQE4-hCu0kGNQ4gX6t-RMjAyk4Jx5eZVVLbFKrPyg@mail.gmail.com>
Subject: Re: [PATCH 0/4] clk: add driver for the SiFive FU740
To:     Sean Anderson <seanga2@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Yash Shah <yash.shah@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 10:56 PM Zong Li <zong.li@sifive.com> wrote:
>
> On Fri, Oct 16, 2020 at 10:17 PM Sean Anderson <seanga2@gmail.com> wrote:
> >
> > On 10/16/20 5:18 AM, Zong Li wrote:
> > > Add a driver for the SiFive FU740 PRCI IP block, which handles more
> > > clocks than FU540. These patches also refactor the original
> > > implementation by spliting the dependent-code of fu540 and fu740
> > > respectively.
> > >
> > > Zong Li (4):
> > >   clk: sifive: Extract prci core to common base
> >
> > I don't see this patch, and it isn't listed on the web archive. Was it
> > not CC'd to this list?
> >
> >         --Sean
> >
>
> There is a problem on linux-riscv mailing list for the first one
> patch, the size of it is too big, it needs to be approved and posted
> on the list by moderator.
>
> This patch set is also sent to clk mailing list, and I can see it on that:
> https://patchwork.kernel.org/project/linux-clk/patch/b10784643665ad56ca41ea6754c7f28f8be1c7ca.1602838910.git.zong.li@sifive.com/
>
>
>
>
> > >   clk: sifive: Use common name for prci configuration
> > >   clk: sifive: Add a driver for the SiFive FU740 PRCI IP block
> > >   clk: sifive: Refactor __prci_clock array by using macro
> > >
> > >  arch/riscv/Kconfig.socs                       |   2 +-
> > >  drivers/clk/sifive/Kconfig                    |   8 +-
> > >  drivers/clk/sifive/Makefile                   |   5 +-
> > >  drivers/clk/sifive/fu540-prci.c               | 618 +-----------------
> > >  drivers/clk/sifive/fu540-prci.h               |  21 +
> > >  drivers/clk/sifive/fu740-prci.c               | 102 +++
> > >  drivers/clk/sifive/fu740-prci.h               |  21 +
> > >  drivers/clk/sifive/sifive-prci.c              | 529 +++++++++++++++
> > >  drivers/clk/sifive/sifive-prci.h              | 297 +++++++++
> > >  include/dt-bindings/clock/sifive-fu740-prci.h |  23 +
> > >  10 files changed, 1032 insertions(+), 594 deletions(-)
> > >  create mode 100644 drivers/clk/sifive/fu540-prci.h
> > >  create mode 100644 drivers/clk/sifive/fu740-prci.c
> > >  create mode 100644 drivers/clk/sifive/fu740-prci.h
> > >  create mode 100644 drivers/clk/sifive/sifive-prci.c
> > >  create mode 100644 drivers/clk/sifive/sifive-prci.h
> > >  create mode 100644 include/dt-bindings/clock/sifive-fu740-prci.h
> > >
> >

ping
