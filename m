Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 034CC1A2955
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 21:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgDHT3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 15:29:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39188 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbgDHT3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 15:29:32 -0400
Received: by mail-ed1-f68.google.com with SMTP id a43so10196905edf.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 12:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2I+dB0B50ThXp7siibS6X0DXKO49NnaL82k0TLoeWMY=;
        b=yG0cOYotYZuBAHkbHGXBv0uN7O2sOdDW9Xa72jt9GZNrxi33xcOgMzmAHf3YDnIa6i
         +Vy532bm2PY05QTAe+unZbwW2F3j9potMZeBwAZHxs1gKyHunW4Tr30rO2hSp+26e4LV
         RgOBQNLhdk9lS1geSwI0Ey12NZ8m5Ywwemz4WVgFHBNWslZJBkZsbU0exFoNu6DvElNA
         sTT/It3byeFv8dJ3jdYGFLtxyEEa+anQeXaZMARoU2pUltGiLOqg8w37QTVtF9Cl3tCh
         x7nOyTiVA8SCK3eA4wMZeGh+Ku20Fz7K4beH0a7Qp7x21GB1NgbfDjhIe7ZS4f731t9o
         iikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2I+dB0B50ThXp7siibS6X0DXKO49NnaL82k0TLoeWMY=;
        b=Fth7DTmamIMEBl7aZ7rS61+3LSiq2Uqiforw6Vxfr/ttWnFGFTO9zyVERLgk56ZPOu
         mHmsgbYnJYbRROWxnPILmFB0EjwdvylzryGflY4ghFTx8bwAaPFhmi8gB5Vb1ZmWyg0Y
         laquuAvdzvSXRgQnEaAcK2jPPM/9SnpEUXKsXbmsdgm/ALWYGKE2tRaI2eGq2KKVoSg5
         8m5djoCLElgSK/vnvq+sDSibwtXLddmS87em35T1N57MjDr+b6cuLWLj7dS1J1CKynOd
         6N2b2huKrQLqdbjnji1rxPTDMQ4YFFIbjclhffIg1EU8BcHOEZaZTbNVwsMWTvjbU7+0
         DtZg==
X-Gm-Message-State: AGi0Pub5hn751MTJKlSVWBUb4+0h7DW/XjlSChY5NRZXOyx2wzgn/+YK
        vgQkOxd82dXQ9mNFuHMhE2VrnqJ65B8ENMkyWFZqxA==
X-Google-Smtp-Source: APiQypKh7MW2L6vpdFisNj8DwA8ikhEpPvrYzpnHu5MtT/bhd43a6I3U63RAoZ5wvMWEYIF3IRyyczq1bpXE+OzPmX4=
X-Received: by 2002:a17:906:6987:: with SMTP id i7mr8255013ejr.12.1586374169369;
 Wed, 08 Apr 2020 12:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2004071029270.8662@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4goJ2jbXNVZbMUKtRUominhuMhuTKrMh=fnhrfvC4jyjw@mail.gmail.com> <alpine.LRH.2.02.2004081439080.13932@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2004081439080.13932@file01.intranet.prod.int.rdu2.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 8 Apr 2020 12:29:18 -0700
Message-ID: <CAPcyv4grNHvyYEc4W6PkymhEJvLb17tXbC3JZdqvtFxmMZ8DCQ@mail.gmail.com>
Subject: Re: [PATCH] memcpy_flushcache: use cache flusing for larger lengths
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 11:54 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Tue, 7 Apr 2020, Dan Williams wrote:
>
> > On Tue, Apr 7, 2020 at 8:02 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> > >
> > > [ resending this to x86 maintainers ]
> > >
> > > Hi
> > >
> > > I tested performance of various methods how to write to optane-based
> > > persistent memory, and found out that non-temporal stores achieve
> > > throughput 1.3 GB/s. 8 cached stores immediatelly followed by clflushopt
> > > or clwb achieve throughput 1.6 GB/s.
> > >
> > > memcpy_flushcache uses non-temporal stores, I modified it to use cached
> > > stores + clflushopt and it improved performance of the dm-writecache
> > > target significantly:
> > >
> > > dm-writecache throughput:
> > > (dd if=/dev/zero of=/dev/mapper/wc bs=64k oflag=direct)
> > > writecache block size   512             1024            2048            4096
> > > movnti                  496 MB/s        642 MB/s        725 MB/s        744 MB/s
> > > clflushopt              373 MB/s        688 MB/s        1.1 GB/s        1.2 GB/s
> > >
> > > For block size 512, movnti works better, for larger block sizes,
> > > clflushopt is better.
> >
> > This should use clwb instead of clflushopt, the clwb macri
> > automatically converts back to clflushopt if clwb is not supported.
>
> But we want to invalidate cache, we do not expect CPU to access these data
> anymore (it will be accessed by a DMA engine during writeback).

The cluflushopt and clwb instructions should have identical overhead,
but clwb wins on the rare chance the written data is needed again
soon. If it is never needed again then the cost of dropping a clean
cache line is the same as if the line was invalidated in the first
instance. In both cases (clflushopt and clwb) the snoop traffic
overhead is still paid whether the written-back line is still present
in the cache or not.

>
> > > I was also testing the novafs filesystem, it is not upstream, but it
> > > benefitted from similar change in __memcpy_flushcache and
> > > __copy_user_nocache:
> > > write throughput on big files - movnti: 662 MB/s, clwb: 1323 MB/s
> > > write throughput on small files - movnti: 621 MB/s, clwb: 1013 MB/s
> > >
> > >
> > > I submit this patch for __memcpy_flushcache that improves dm-writecache
> > > performance.
> > >
> > > Other ideas - should we introduce memcpy_to_pmem instead of modifying
> > > memcpy_flushcache and move this logic there? Or should I modify the
> > > dm-writecache target directly to use clflushopt with no change to the
> > > architecture-specific code?
> >
> > This also needs to mention your analysis that showed that this can
> > have negative cache pollution effects [1], so I'm not sure how to
> > decide when to make the tradeoff. Once we have movdir64b the tradeoff
> > equation changes yet again:
> >
> > [1]: https://lore.kernel.org/linux-nvdimm/alpine.LRH.2.02.2004010941310.23210@file01.intranet.prod.int.rdu2.redhat.com/
>
> I analyzed it some more. I have created this program that tests writecache
> w.r.t. cache pollution:
>
> http://people.redhat.com/~mpatocka/testcases/pmem/misc/l1-test-2.c
>
> It fills the cache with a chain of random pointers and then walks these
> pointers to evaluate cache pollution. Between the walks, it writes data to
> the dm-writecache target.
>
> With the original kernel, the result is:
> 8503 - 11366
> real    0m7.985s
> user    0m0.585s
> sys     0m7.390s
>
> With dm-writecache hacked to use cached writes + clflushopt:
> 8513 - 11379
> real    0m5.045s
> user    0m0.670s
> sys     0m4.365s
>
> So, the hacked dm-writecache is significantly faster, while the cache
> micro-benchmark doesn't show any more cache pollution.

Nice. These are now the pmem numbers, or dram? Otherwise, what changed
that was making nt-writes on pmem perform better compared to your
previous test? I'm just trying to track the results.

> That's for dm-writecache. Are there some other significant users of
> memcpy_flushcache that need to be checked?

The only other user is direct and dax-I/O to the pmem driver.
