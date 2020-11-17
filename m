Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B987D2B6911
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgKQPuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:50:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:59082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgKQPuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:50:11 -0500
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2C24246A5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605628210;
        bh=u1el01G9Rxn5QxKul4igkMQ+uIlzPCYj5W5qeoA3aQQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pJsP79dfyNR7hwm2vMl/nNj/v7y0qCYaDefg1qA/I/gKlNIhUwDa1l8XB8mNNNUSj
         TaTPHZpQpBxw9wMZySyzuDFryAOEfmm/HftDzu9u0THtsEgc0KpuT/va/qGJUeyL1R
         sjfRV5Q4qaBaChgIIidBhRL3MnJ1qKlDcMvajw9Q=
Received: by mail-wr1-f42.google.com with SMTP id m6so6471383wrg.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 07:50:09 -0800 (PST)
X-Gm-Message-State: AOAM53211iZlfCBfDV7voN9Ow+mXsML0k5ZvL/FS7Ywz0L5MisXrEtv+
        x0DeIsvNMwfXNYHVthO5I5Oy6Mk0LxR807s+cWqUiQ==
X-Google-Smtp-Source: ABdhPJzeqtLFoEF4ietenDEVnPD2MdOjQpmq7/+A2FPVapFRdUjKO6SMMFp4UDuSP+XGuK6xU5Eu9TstsDJk/X3d560=
X-Received: by 2002:a5d:4991:: with SMTP id r17mr188952wrq.70.1605628208195;
 Tue, 17 Nov 2020 07:50:08 -0800 (PST)
MIME-Version: 1.0
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116144757.1920077-12-alexandre.chartre@oracle.com> <CALCETrXoykRjRPYPfZr6gBKoMnHuRYiJTDOcFYMq8GLef00j1A@mail.gmail.com>
 <820278dc-5f8e-6224-71b4-7c61819f68d1@oracle.com> <CALCETrXYP13pPcRfDDkwetLgzA3quYOBg7OTo5nbpLpPfSqaLw@mail.gmail.com>
 <d4be0149-1a28-24e8-7821-e8c96f98a7ac@oracle.com>
In-Reply-To: <d4be0149-1a28-24e8-7821-e8c96f98a7ac@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 17 Nov 2020 07:49:53 -0800
X-Gmail-Original-Message-ID: <CALCETrWRBG5fuqZNbrYCKnxSiO9we_sTVWpWwa8GOj8j1UfZPQ@mail.gmail.com>
Message-ID: <CALCETrWRBG5fuqZNbrYCKnxSiO9we_sTVWpWwa8GOj8j1UfZPQ@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 11/21] x86/pti: Extend PTI user mappings
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        jan.setjeeilers@oracle.com, Junaid Shahid <junaids@google.com>,
        oweisse@google.com, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alexander Graf <graf@amazon.de>, mgross@linux.intel.com,
        kuzuno@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 12:42 AM Alexandre Chartre
<alexandre.chartre@oracle.com> wrote:
>
>
> On 11/17/20 12:06 AM, Andy Lutomirski wrote:
> > On Mon, Nov 16, 2020 at 12:18 PM Alexandre Chartre
> > <alexandre.chartre@oracle.com> wrote:
> >>
> >>
> >> On 11/16/20 8:48 PM, Andy Lutomirski wrote:
> >>> On Mon, Nov 16, 2020 at 6:49 AM Alexandre Chartre
> >>> <alexandre.chartre@oracle.com> wrote:
> >>>>
> >>>> Extend PTI user mappings so that more kernel entry code can be executed
> >>>> with the user page-table. To do so, we need to map syscall and interrupt
> >>>> entry code, per cpu offsets (__per_cpu_offset, which is used some in
> >>>> entry code), the stack canary, and the PTI stack (which is defined per
> >>>> task).
> >>>
> >>> Does anything unmap the PTI stack?  Mapping is easy, and unmapping
> >>> could be a pretty big mess.
> >>>
> >>
> >> No, there's no unmap. The mapping exists as long as the task page-table
> >> does (i.e. as long as the task mm exits). I assume that the task stack
> >> and mm are freed at the same time but that's not something I have checked.
> >>
> >
> > Nope.  A multi-threaded mm will free task stacks when the task exits,
> > but the mm may outlive the individual tasks.  Additionally, if you
> > allocate page tables as part of mapping PTI stacks, you need to make
> > sure the pagetables are freed.
>
> So I think I just need to unmap the PTI stack from the user page-table
> when the task exits. Everything else is handled because the kernel and
> PTI stack are allocated in a single chunk (referenced by task->stack).
>
>
> >  Finally, you need to make sure that
> > the PTI stacks have appropriate guard pages -- just doubling the
> > allocation is not safe enough.
>
> The PTI stack does have guard pages because it maps only a part of the task
> stack into the user page-table, so pages around the PTI stack are not mapped
> into the user-pagetable (the page below is the task stack guard, and the page
> above is part of the kernel-only stack so it's never mapped into the user
> page-table).
>
> + *   +-------------+
> + *   |             | ^                       ^
> + *   | kernel-only | | KERNEL_STACK_SIZE     |
> + *   |    stack    | |                       |
> + *   |             | V                       |
> + *   +-------------+ <- top of kernel stack  | THREAD_SIZE
> + *   |             | ^                       |
> + *   | kernel and  | | KERNEL_STACK_SIZE     |
> + *   | PTI stack   | |                       |
> + *   |             | V                       v
> + *   +-------------+ <- top of stack

There's no guard page between the stacks.  That seems unfortunate.

>
> > My intuition is that this is going to be far more complexity than is justified.
>
> Sounds like only the PTI stack unmap is missing, which is hopefully not
> that bad. I will check that.
>
> alex.
