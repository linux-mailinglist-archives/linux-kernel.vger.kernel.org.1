Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9782E6A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 20:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgL1TAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 14:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgL1TAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 14:00:06 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A001EC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 10:59:25 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id h22so26015963lfu.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 10:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WckqKvyMcxOxWJn+XJd5pF8fpheIZMuxrVFNQFWeDiU=;
        b=F+xbx3cxMIeJvRGT6SIxmwGMUxVxHvm2It+FAoKYpb1XcuOo1gvpTcoXZ0dFGXMsKh
         EiPkFernqyBs7LlPiJ5cl5ygZmuH+KdhJZUfeowCwJRBNUz1vr502ypNyJLNMyYo0Kas
         WKZ205/v4H6no05no2hZBVEeglN0OIHBN6jMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WckqKvyMcxOxWJn+XJd5pF8fpheIZMuxrVFNQFWeDiU=;
        b=FW+jBDugwc3BptagrufPooGy0/DgGFjVGS14g0qg//v9AZzgxsY2SKsyAi/iVxggdL
         3a8pzETk1GkS2SOcq+LBosaspqdHE3C1HugyIqo2UJWn2v5GueJVtSgLbS0c4oz+fsKU
         oxb/Ke2upe83oxeypW2IKW87U531skerTIv79WabMpEN88cz3Q1go1SKsZJly39M+1Zl
         /OVvax6n2nbDy82XUbHM5qb+Z6QH6XzpprDH00QXQj5xxFqkyfyTdbl/N+TPoCwD0M3d
         S8PIqrN7BJErzjEVwcnpYSm2A34FyYgPuwDR+CNecnyYXXOaI614TmDrwJ8AS1ABJ7kh
         DwZQ==
X-Gm-Message-State: AOAM532dj5ZjHsoS41TU5zVf377g7vr9U8wqTaElge6N4INHYcKk0Tl4
        FdUDIuE7NF8USyDxQntfDe7+inXBDIoxSA==
X-Google-Smtp-Source: ABdhPJybC5wmYaPPp0ljYoxo1c+Dpfb9iPMe6HtsvLR2iSwUz1HjO89NFHn9i4hUEghY5MoYnD0ovA==
X-Received: by 2002:a05:6512:211:: with SMTP id a17mr18227902lfo.562.1609181963761;
        Mon, 28 Dec 2020 10:59:23 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id u21sm6691167ljd.81.2020.12.28.10.59.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 10:59:22 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id h205so25932688lfd.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 10:59:22 -0800 (PST)
X-Received: by 2002:ac2:4987:: with SMTP id f7mr18670649lfl.41.1609181962432;
 Mon, 28 Dec 2020 10:59:22 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wg1+kf1AVzXA-RQX0zjM6t9J2Kay9xyuNqcFHWV-y5ZYw@mail.gmail.com>
 <20201228155149.GA197954@roeck-us.net>
In-Reply-To: <20201228155149.GA197954@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Dec 2020 10:59:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=whHbfec+vxjpCXhRdSwA7uw6m0hS9kGqqJv6Af0EMFVBw@mail.gmail.com>
Message-ID: <CAHk-=whHbfec+vxjpCXhRdSwA7uw6m0hS9kGqqJv6Af0EMFVBw@mail.gmail.com>
Subject: Re: Linux 5.11-rc1
To:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kalesh Singh <kaleshsingh@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 7:51 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Build results:
>         total: 153 pass: 151 fail: 2

Thanks for doing these for the mainline rc's too. I've seen them for
the stable kernels, but it's lovely to see it for rc1.

> ERROR: modpost: "irq_check_status_bit" [drivers/perf/arm_spe_pmu.ko] undefined!
>
> Caused by: fdd029630434 ("genirq: Move status flag checks to core")

Ahh. Does it just need a

 EXPORT_SYMBOL_GPL(irq_check_status_bit);

in there? Because it looks like at least irq_is_percpu() and
irq_is_percpu_devid() are used in drivers/perf/ and can apparently be
modules.

Thomas?

> ia64:defconfig:
>
> include/linux/mmzone.h:1156:2: error: #error Allocator MAX_ORDER exceeds SECTION_SIZE
>
> and various related warnings.
>
> Caused by: 214496cb1870 ("ia64: make SPARSEMEM default and disable DISCONTIGMEM")
>
> Fix submitted ("ia64: fix build failure caused by memory model changes").

Ok, I won't worry about that one.

> qemu boot tests:
>
> arm:raspi2 hangs during boot.
>
> Caused by: ffdad793d579 ("irqchip/bcm2836: Make IPIs use handle_percpu_devid_irq()")
>
> Fix submitted ("irqchip/bcm2836: Fix IPI acknowledgement after conversion to
> handle_percpu_devid_irq").

Same.

> parisc: Failed to execute /sbin/init (error -12)
>
> Caused by: c49dd3401802 ("mm: speedup mremap on 1GB or larger regions")

Looks like Kalesh is looking at it.

I don't think that was supposed to matter at all on parisc, but
clearly something bad happened.

parsic doesn't even enable HAVE_MOVE_PMD, much less the new
HAVE_MOVE_PUD. Strange.

                 Linus
