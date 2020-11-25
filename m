Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73662C4188
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 14:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgKYN6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 08:58:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728984AbgKYN6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 08:58:11 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E9BE206F9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 13:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606312690;
        bh=6BAakfvw25ZBf9e/4UTzAJMhlZtXBDZymDJCaUeKHuw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B/cNhIZxFOHYhgTfS+R5OzNUXkSmxZjeMERd1AvmFDps499VpUoSFv2/cpESvB3Nj
         bcbOefl8Sf5w80ctXMXWElQSNRQLF3d6ZIieT4L/g/nMLBs8tQAe+EwMcp2gJNjYLw
         56iQrOLBvyFg+jxFWdvrcCU3E1Kir7IYsWD7oILM=
Received: by mail-ot1-f49.google.com with SMTP id n12so2316394otk.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 05:58:10 -0800 (PST)
X-Gm-Message-State: AOAM5328vetUPIZd824GGLfR0s72lOzEaBPULATvZwyzYu/gqm2DZGnY
        Q0ZCeeIjWIJ7BUu2rGCJ4k5xBPJgyj5N4Qx8daY=
X-Google-Smtp-Source: ABdhPJzRSEWXh9aFsAPHLM+ddYkmk1R1hHDj3GpSQwY0kRAD73s1ZmehK1Z9P6CwwXl/Q4pVLUir8OiQRon/FwEWxpI=
X-Received: by 2002:a9d:6317:: with SMTP id q23mr2842047otk.251.1606312689603;
 Wed, 25 Nov 2020 05:58:09 -0800 (PST)
MIME-Version: 1.0
References: <caa5c3cbe6253d67fed83c4351d85224f8cf226c.1606303816.git.michal.simek@xilinx.com>
 <20201125120739.GO8537@kernel.org> <7217421a-c4de-0bd1-3231-17563e51e3c9@xilinx.com>
 <CAK8P3a3QkWTCDg+v9qtW0aG7ndhmSukuZG-znS_NzRHyoZLQhw@mail.gmail.com> <5947a4da-a08f-049b-9162-628e42980b33@xilinx.com>
In-Reply-To: <5947a4da-a08f-049b-9162-628e42980b33@xilinx.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 25 Nov 2020 14:57:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0o+n5xvwk14ZZC8N0Uu91fmCXOshVqyic1uMxEapxSUA@mail.gmail.com>
Message-ID: <CAK8P3a0o+n5xvwk14ZZC8N0Uu91fmCXOshVqyic1uMxEapxSUA@mail.gmail.com>
Subject: Re: [PATCH] microblaze: Remove noMMU code
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Baoquan He <bhe@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 2:01 PM Michal Simek <michal.simek@xilinx.com> wrote:
> On 25. 11. 20 13:57, Arnd Bergmann wrote:
> > On Wed, Nov 25, 2020 at 1:14 PM Michal Simek <michal.simek@xilinx.com> wrote:
> >>
> >> And second part. I know I removed that Kconfig macros for it but maybe
> >> good to talk about what needs to change to support different page size
> >> for systems with MMU.
> >
> > I would recommend just leaving it hardwired to 4K. The benefits of larger
> > pages are rather questionable, especially on systems without tons of
> > RAM, and it's an endless source of problems.
> >
> > The commit that added the option, ba9c4f88d747 ("microblaze: Allow
> > PAGE_SIZE configuration"), was rather nebulous with "can improve
> > performance on some workloads".
> >
> > On PowerPC, the benefits of larger pages are mainly for the hashed
> > page table code, which I don't think exists anywhere else.
>
> Is there any standard benchmark to see if there is really any benefit?
> Exchanging tbl is quite expensive operation that's why there could be
> good improvement.
>
> But not a problem to remove it for now and get it back when this is
> properly tested.

The problem is that some benchmarks benefit hugely from larger
pages because of running into fewer TLB misses, but others
suffer even more because you end up using much more memory
to run the same workload.

IIRC I calculated that keeping the kernel source tree in the page
cache needs 10x as much physical memory on a 64K page
size compared to 4K pages because each file is stored in
a multiple of a full page. It's less of a problem if you have
terabytes of RAM, but on 32-bit systems you rarely do.

A more useful way to reduce TLB misses would be to support
huge pages. I see that the CPU can support 256KB, 1MB, 4MB
and 16 MB pages as well, so those would be good to have as
huge page sizes.

Some architectures actually support mixing huge page sizes
nowadays, but the easiest change would be to pick one of them.

      Arnd
