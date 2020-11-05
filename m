Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4C52A779D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 07:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgKEG4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 01:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKEG4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 01:56:41 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5CBC0613D1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 22:56:41 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id l26so178115oop.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 22:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EwC6aaL5scs/P7pPY4FBOZM78H0SX2GDzgejVIvtuSI=;
        b=fGjMpbieMBYGTP8eXkgUOsId8oCd1W0FvaKudufpR/oS4DI1DbaCiew8igvijFxBwS
         EHhoyWaghz1rNg9gKQCAQEMN3BvUTuPkhwCLnk+EQobkdb1tXrYj5a6rBuBQ9F39Dtu2
         VId+sax2ltEsuv9c8Q5RCbyHOAWv1FbLTXg3Y6Kxeguv4tq/CGHIJ5pl5IMERreUSAD6
         UM7T1zFhlnlo2IpL2n6yFmJuAaptDx4lxL3h/VKMT/l7r47IVPkX3DEsgSi/n94y6fle
         ImOYBhqXAjxHdO7nOj+r4aj8mZCPgD+HXicU4xsdbx3245xjMpmp6wc7bZmCqDJpgBra
         17xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EwC6aaL5scs/P7pPY4FBOZM78H0SX2GDzgejVIvtuSI=;
        b=kHdGeXSzbYM7v/bFaSqX2J+4Kp8lOBoEpJ3C4ulPWcpHoddQCzcAKWKHj04sWWGkhL
         VoVg/UXujc0dL+T+5T39p9pkz+f2p5FQU1vrB8GiJB56gxX84KTjOAUOrujrcAYsTVu7
         VSbckeswh5Belu4lIR4Qa44lUZ7WxcwmxCtZw6t7glVFx6ev41UCMcVGdjJ/7KguEYny
         7HjZdjhFh5iWiFGAO3RCpyAv246o3OcIytzbcaHF+aG2JWr6Aw9uo+670xIXqQSZ5/m3
         Dlhj7cQu8uABnHCxV2sxwnTadUiHTMCSWFdOjlM3m6uvfLZBadfFiPdIwuURmAAnGukv
         9l+A==
X-Gm-Message-State: AOAM532iGFIASBwR4Lhiu2eaEIMGhSo3Gi+dA57sBxcfsSHw1MdnGInI
        Tnmn61SxtLwM4aSKAtXTNXXtMkqfsYDuP+59Ei9/GA==
X-Google-Smtp-Source: ABdhPJzG+mUg1IhLpXs4PxzIVuJht73184cn4t2P8RYlFePqEzl5jZbufSglQtuHFx1WT3FcXVbe7LhHZNe2AclMWNk=
X-Received: by 2002:a4a:96b0:: with SMTP id s45mr804814ooi.33.1604559400459;
 Wed, 04 Nov 2020 22:56:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1602838910.git.zong.li@sifive.com> <691e24d1c45a4b56b57ce1e02a04268c4253a77d.1602838910.git.zong.li@sifive.com>
 <160454441626.3965362.17922436443029310228@swboyd.mtv.corp.google.com>
In-Reply-To: <160454441626.3965362.17922436443029310228@swboyd.mtv.corp.google.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 5 Nov 2020 14:56:27 +0800
Message-ID: <CANXhq0oNpVAwGYHwjFngdGtbLHGZ8tMvgdQ8Prsg2N9L9Qpf5A@mail.gmail.com>
Subject: Re: [PATCH 2/4] clk: sifive: Use common name for prci configuration
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, linux-clk@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Yash Shah <yash.shah@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 10:46 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Zong Li (2020-10-16 02:18:24)
> > Use generic name CLK_SIFIVE_PRCI instead of CLK_SIFIVE_FU540_PRCI. This
> > patch is prepared for fu740 support.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
>
> Looks ok but needs an ack from riscv maintainers to go through clk
> tree. I was worried it would break defconfigs but it seems that the arch
> selects the config so this should be OK, right?

Yes, this config is selected by arch, the defconfig won't be impacted.

>
> >  arch/riscv/Kconfig.socs     | 2 +-
> >  drivers/clk/sifive/Kconfig  | 6 +++---
> >  drivers/clk/sifive/Makefile | 2 +-
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index 8a55f6156661..3284d5c291be 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -5,7 +5,7 @@ config SOC_SIFIVE
> >         select SERIAL_SIFIVE if TTY
> >         select SERIAL_SIFIVE_CONSOLE if TTY
> >         select CLK_SIFIVE
> > -       select CLK_SIFIVE_FU540_PRCI
> > +       select CLK_SIFIVE_PRCI
> >         select SIFIVE_PLIC
> >         help
> >           This enables support for SiFive SoC platform hardware.
