Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6136A2E6C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgL1Wzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbgL1TiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 14:38:06 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2781C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:37:25 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m5so171622pjv.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aP2IflqGvTJUzzYvZuXImaRefVVA1KclE0g//wHvG0o=;
        b=Hml9ivOHfPvshZaA12WNqRUgdZAAyt57TXxuUZj+sWsZr8L3xhCl4iUagk6wILT7Dj
         4WWcHBHv+5dERmVqytuRecoW5NWsqsoIxdxzYvLMEwgMtfUZWwM7OmO6dpy7PwYUaOSJ
         d8iMHjvR26M8P2ivMKIdQ/gXHV6MIgA9eveTVG7N3ygdKpJy57xjA2hsIjWwXdQwrd7N
         MxidSJ2SeK6gcFEbTTWb6fxi9okqQgboXkjbd4/RI65LgW0EpIJEOWg4fPv63k2URI8b
         7NeJ1WBu9BtVvCpvJAUOqU9S4J1beXmbqhUzAUrOdhhSa/sZ8W9sVieuD5GVI5s5G1/C
         QttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aP2IflqGvTJUzzYvZuXImaRefVVA1KclE0g//wHvG0o=;
        b=DC/BQYOxCtpel35dScacnYPdFpah21tAYmICfmQcX24p4j3DSpIcCLfypHWRNgyOF7
         xgqchvGW8HGSEeWqI3/agRzG+kI8PBPkmoO5rhWq2GSX+77orbMc4jMbjXtNdku72JOn
         kZ00W6f8Xo7SS9HT3m0+afDlrSl3LFlG/GghiUEShS78Rl0czB1QCeSTIc6iESxG4IiL
         GHv59S5+cgGa4oUIPW+wF9HLrPPtFLw54w0Yd1Hzhnu/8+IZdc4BAhCSbYzA4q5ysVov
         Ig/xdSGdtv4vGHRxGWW1pGUY33MAbkNhAz0QlbkyOXtaEl3bq7F0ZfbjztVmN2H1BUw6
         cneg==
X-Gm-Message-State: AOAM530Y4Czhn0IcT5qkA5MtuWPTIDVr0H+dqxUjMmGYQ3mtrXlFFgNH
        nHQicrNuySjR+G44X2lNswghNdUCMcK57dHTYWq8vi7wnw7aRQ==
X-Google-Smtp-Source: ABdhPJxjMTApkB84jlQZm3rnt7KguKNjWbwsQ/Ajio0Pnp5P4W8EGniAe7xMgl3wcI+t5/CwyjeUsX6d7WEP+4TRbVs=
X-Received: by 2002:a17:902:7592:b029:dc:3c87:1c63 with SMTP id
 j18-20020a1709027592b02900dc3c871c63mr34844772pll.47.1609184245208; Mon, 28
 Dec 2020 11:37:25 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wg1+kf1AVzXA-RQX0zjM6t9J2Kay9xyuNqcFHWV-y5ZYw@mail.gmail.com>
 <20201228155149.GA197954@roeck-us.net> <CAHk-=whHbfec+vxjpCXhRdSwA7uw6m0hS9kGqqJv6Af0EMFVBw@mail.gmail.com>
In-Reply-To: <CAHk-=whHbfec+vxjpCXhRdSwA7uw6m0hS9kGqqJv6Af0EMFVBw@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 28 Dec 2020 13:37:13 -0600
Message-ID: <CAC_TJvfpeRh322usynr2Ud3KVCd3HaNnviOmdhekXSnC-sq2sA@mail.gmail.com>
Subject: Re: Linux 5.11-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 12:59 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Dec 28, 2020 at 7:51 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Build results:
> >         total: 153 pass: 151 fail: 2
>
> Thanks for doing these for the mainline rc's too. I've seen them for
> the stable kernels, but it's lovely to see it for rc1.
>
> > ERROR: modpost: "irq_check_status_bit" [drivers/perf/arm_spe_pmu.ko] undefined!
> >
> > Caused by: fdd029630434 ("genirq: Move status flag checks to core")
>
> Ahh. Does it just need a
>
>  EXPORT_SYMBOL_GPL(irq_check_status_bit);
>
> in there? Because it looks like at least irq_is_percpu() and
> irq_is_percpu_devid() are used in drivers/perf/ and can apparently be
> modules.
>
> Thomas?
>
> > ia64:defconfig:
> >
> > include/linux/mmzone.h:1156:2: error: #error Allocator MAX_ORDER exceeds SECTION_SIZE
> >
> > and various related warnings.
> >
> > Caused by: 214496cb1870 ("ia64: make SPARSEMEM default and disable DISCONTIGMEM")
> >
> > Fix submitted ("ia64: fix build failure caused by memory model changes").
>
> Ok, I won't worry about that one.
>
> > qemu boot tests:
> >
> > arm:raspi2 hangs during boot.
> >
> > Caused by: ffdad793d579 ("irqchip/bcm2836: Make IPIs use handle_percpu_devid_irq()")
> >
> > Fix submitted ("irqchip/bcm2836: Fix IPI acknowledgement after conversion to
> > handle_percpu_devid_irq").
>
> Same.
>
> > parisc: Failed to execute /sbin/init (error -12)
> >
> > Caused by: c49dd3401802 ("mm: speedup mremap on 1GB or larger regions")
>
> Looks like Kalesh is looking at it.
>
> I don't think that was supposed to matter at all on parisc, but
> clearly something bad happened.
>
> parsic doesn't even enable HAVE_MOVE_PMD, much less the new
> HAVE_MOVE_PUD. Strange.

Hi Linus,

I had sent the fix for this issue which was taken into the -mm tree by
Andrew. (https://ozlabs.org/~akpm/mmotm/broken-out/mm-mremap-fix-extent-calculation.patch)

Please, let me know if there is anything else needed on my end.

Thanks,
Kalesh

>
>                  Linus
