Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FE42767E1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 06:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgIXE3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 00:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgIXE3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 00:29:30 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7B6C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 21:29:30 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id c5so187105ilk.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 21:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qj92FMGcpgxsdyUE56yoRlee9YhbsU/CYNtrILGXrHI=;
        b=hKpwx2YFNPQQjIl9obkIR88i8flXLlEDKWxisryuqYs45VmEht4DryPajZHZDrfgJo
         Lr7xg4gz90OwQUlv600R7W23mD8oRCNtjAiWMyhJuhjJ0BhDv6JdimhYmHd5J5gyT2Dy
         pKmtNuGp8qb2Y9/v95kVPaazILhYm8WAxoATiV7dl+O3/Jakwtn0wFCDwC8J2utZPAUN
         ooVNZsT2cnge4jawn/OSnkpR9vYPAJd3OGcXEs/E2HpK16SmkxjkEwQDl3enHcN86C3F
         a35u2//yA5cHN3x4scuZ/EPVcltWqAZWPmquI4A2wTaFTGa3B84C5AqlKGVMN0B60Yus
         vHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qj92FMGcpgxsdyUE56yoRlee9YhbsU/CYNtrILGXrHI=;
        b=BDMJBb6h8NQQMT0foxxQkO4kuen2Q/ThP1LGO4Qss0XW/fNCieF+U8+X9hGtUTZ3Lz
         5lwMStbinWZZz7y7x4eXztF7QfS3cFfsdVddggYHtitjwAJl8ETLBSZmNAQhPLnP/Sub
         ZeN+e1pLdnmaZ2EOINk9m97/UYBLECFdmSHb78RkBdfMzKXGdQgRhQCGoJRuqZ97Ddp7
         VYys0MLzMHMrnO4xddtQW3Vf/a4zuPSZ0lg/64eTI1DwvwZJRGG9qbsEhVr+AZ/wQE1R
         1irz22d/A8INv/TqOLLtgFpQlIgmtBrwVYCpJ5//oFp/ibbwCiYX/PN55fTOTAK0NcsQ
         46Wg==
X-Gm-Message-State: AOAM5304qb629ElschW90AaQy3KzP9sAKtcDrUS1uFA4TLtIs2WiGwTt
        NAwry/qm5xiVmoROC0N3E7z7g0e/apH+hakII5A=
X-Google-Smtp-Source: ABdhPJxPfqY8QUPf2j8F+mjd8vxgY0gvW57lNgORQ3ajNglXpQPqzal3Fo3UsraealyXmnxEAKajzM/jFfds1uWW1fc=
X-Received: by 2002:a92:7989:: with SMTP id u131mr2492233ilc.93.1600921769596;
 Wed, 23 Sep 2020 21:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200917181347.1359365-1-axelrasmussen@google.com>
 <CALOAHbDSHGeXjJN3E5mTOAFTVsXAvQL9+nSYTqht5Lz8HRNv0A@mail.gmail.com>
 <CAJHvVcg6eY0vVtfi8D6D9aus7=5zeP2H7Yc0mY5ofXztSzOFqQ@mail.gmail.com>
 <CALOAHbBr=ASfvHw1ZscWBE=CY-e7sBrLV0F5Ow=g1UGxmQsWcw@mail.gmail.com>
 <20200922125113.12ef1e03@gandalf.local.home> <CALOAHbD2qgvd7CHy6ZFJ_h8drtRWEU=E-hPofY-TuGTNfxyQbw@mail.gmail.com>
 <20200923120924.49638d90@oasis.local.home>
In-Reply-To: <20200923120924.49638d90@oasis.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 24 Sep 2020 12:28:53 +0800
Message-ID: <CALOAHbBFr8TrwAJ+V7RrTrj==ogcyqUMVBqVYTtTCvcHfD8j7g@mail.gmail.com>
Subject: Re: [PATCH] mmap_lock: add tracepoints around lock acquisition
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 12:09 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 23 Sep 2020 18:04:17 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > > What you can do, and what we have done is the following:
> > >
> > > (see include/linux/page_ref.h)
> > >
> > >
> > > #ifdef CONFIG_TRACING
> > > extern struct tracepoint __tracepoint_mmap_lock_start_locking;
> > > extern struct tracepoint __tracepoint_mmap_lock_acquire_returned;
> > >
> > > #define mmap_lock_tracepoint_active(t) static_key_false(&(__tracepoint_mmap_lock_##t).key)
> > >
> > > #else
> > > #define mmap_lock_tracepoint_active(t) false
> > > #endif
> > >
> > > static inline void mmap_write_lock(struct mm_struct *mm)
> > > {
> > >         if (mmap_lock_tracepoint_active(start_locking))
> > >                 mmap_lock_start_trace_wrapper();
> > >         down_write(&mm->mmap_lock);
> > >         if (mmap_lock_tracepoint_active(acquire_returned))
> > >                 mmap_lock_acquire_trace_wrapper();
> > > }
> > >
> > >
> > > -- Steve
> >
> >
> > Great!
> >
> > Thanks Steve.
>
> If the above becomes useful, I may just add helper functions into a
> header file that you can include. Perhaps call it: tracepoint_active()
> and you need to pass in as an argument the name of the tracepoint.
>

Yes, please. The new helper would be useful.

-- 
Thanks
Yafang
