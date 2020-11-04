Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90AA2A6472
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 13:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgKDMge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 07:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgKDMgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 07:36:33 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011B6C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 04:36:33 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id m26so19129760otk.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 04:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVb8/RbNDJYhkorSN6bimCxe79UOkbAUrQdoTOawrjk=;
        b=LFGjSoCfJkkqDGZvbx8OXBBNkxgfAedNqXIo07FnoMCHg2jlNSYzGAfU6c+xbdBL4l
         qDpDG1VSEc4Zi3iAO2WvytnftCJ/jmlPQVpb0zIAUDAuWFZ6HOxe1I9XgJfh4gIYomGY
         AcSClw4IrgDZDBGuBQbBfwdHekhheK/geQXcTnKgpwyonV3rwx2YEknxiMbtf3fZRcdV
         YH0ASf9BzP1CKZDamaq+wusNG13okoekcnqs3fusVijhsMMVdxHcW5jDzry9asdpdBY7
         TI2lmEPXsZndrsgJDSfKG+zmdDlgyCpPm/V2fMx5mim6cBrNcQ75GR9kdPsuS9A9n/gp
         GNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVb8/RbNDJYhkorSN6bimCxe79UOkbAUrQdoTOawrjk=;
        b=pEyxLEj3+Nb6/6F3vKvWmq1xSAoIWxGOHufH5MpAWenGVzU3/KOrwbpKBTJpTfkgIJ
         NpRRK9d01y1IfRHrsdmIz3i2v0ZFP9dHR4s7iyKbT46MKkeJusAkGOW5w2DmHwQd/zlP
         MXYrwwwnh707Z/V8xtubkCZM9+7hDxTLJaTNXL5IkodgKq0U8NThpBg/fTrTSwFCLX3E
         9GRb27BIpgXLyXChzr8VPvDEg2FgycCruNBk7uphWW2mw8GCr+Klaq92Z4t62XBBnPLo
         1GYGtJyEAhkAHyeQX66aVApEIRd0X/Gfz2ILEveMbe6X6SPDtjh/SaiHjPEKRGQHZhus
         n5Jg==
X-Gm-Message-State: AOAM532xr2/1foAJ/d2Gx4hVA4nH4NA2LVh3Bw77UNE2tLuyTtS8YRn9
        5JEN6zFax25ande/rhpAzhwIqqqBV+RAN8ofe/DcVw==
X-Google-Smtp-Source: ABdhPJyK2zY+C07iD8w6EBRYLDu02PjG20qra3SjpRaESNCnGnN2KfqIUAfzeWA5l49kGRBzEiiu5UOzLl+vbNhsR+8=
X-Received: by 2002:a9d:649:: with SMTP id 67mr19396919otn.233.1604493392047;
 Wed, 04 Nov 2020 04:36:32 -0800 (PST)
MIME-Version: 1.0
References: <20201103175841.3495947-1-elver@google.com> <20201103163103.109deb9d49a140032d67434f@linux-foundation.org>
In-Reply-To: <20201103163103.109deb9d49a140032d67434f@linux-foundation.org>
From:   Marco Elver <elver@google.com>
Date:   Wed, 4 Nov 2020 13:36:20 +0100
Message-ID: <CANpmjNM1HQ_TwqJ6Ad=Mr=oKVnud-qzD=-LhchPAouu1RDHLqw@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] KFENCE: A low-overhead sampling-based memory
 safety error detector
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@purestorage.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        SeongJae Park <sjpark@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Nov 2020 at 01:31, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Tue,  3 Nov 2020 18:58:32 +0100 Marco Elver <elver@google.com> wrote:
>
> > This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
> > low-overhead sampling-based memory safety error detector of heap
> > use-after-free, invalid-free, and out-of-bounds access errors.  This
> > series enables KFENCE for the x86 and arm64 architectures, and adds
> > KFENCE hooks to the SLAB and SLUB allocators.
> >
> > KFENCE is designed to be enabled in production kernels, and has near
> > zero performance overhead. Compared to KASAN, KFENCE trades performance
> > for precision. The main motivation behind KFENCE's design, is that with
> > enough total uptime KFENCE will detect bugs in code paths not typically
> > exercised by non-production test workloads. One way to quickly achieve a
> > large enough total uptime is when the tool is deployed across a large
> > fleet of machines.
>
> Has kfence detected any kernel bugs yet?  What is its track record?

Not yet, but once we deploy in various production kernels, we expect
to find new bugs (we'll report back with results once deployed).
Especially in drivers or subsystems that syzkaller+KASAN can't touch,
e.g. where real devices are required to get coverage. We expect to
have first results on this within 3 months, and can start backports
now that KFENCE for mainline is being finalized. This will likely also
make it into Android, but deployment there will take much longer.

The story is similar with the user space version of the tool
(GWP-ASan), where results started to materialize once it was deployed
across the fleet.

> Will a kfence merge permit us to remove some other memory debugging
> subsystem?  We seem to have rather a lot of them.

Nothing obvious I think. KFENCE is unique in that it is meant for
production fleets of machines (with ~zero overhead and no new HW
features), with the caveat that due to it being sampling based, it's
not so suitable for single machine testing. The other debugging tools
are suitable for the latter, but not former.

Thanks,
-- Marco
