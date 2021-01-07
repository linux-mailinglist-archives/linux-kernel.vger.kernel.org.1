Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00712EE764
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 22:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbhAGVGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 16:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbhAGVGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:06:19 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558DEC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 13:05:39 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id h22so17985025lfu.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 13:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUX48h8GuHiWfyIFKQorOeDH5aRr+rHoGufAxjKRRyc=;
        b=ftovYP2cAH+hAB7ZAEeA0T4+9dtWXkVbAjLBGYjo+GzUmiXiG8sO/GenbvD/TRQ5w9
         wnX3vD6FSNsYeiugwknMKP9/r7XvQdKmwwCOYUgWfcTkYFocALDMgnv661VNQPLP/ePd
         xM+cAz7WW3Lj2L46AwRaEYALXXbS6ZIgKA9kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUX48h8GuHiWfyIFKQorOeDH5aRr+rHoGufAxjKRRyc=;
        b=ksf2vSuo6tQAkTAQipfgZGS2GgAWBJuAv74tFpR3xZG4BmeDDoPFflbWkYTWcrFOu4
         1444VpvwBvNZ9HJz9Z8AXgxedS8o2hy2cBSsrIk5wqN5n8lky7Hx7oCtPsJlsospFb1i
         Ofqsp3B4nBxr1f7asa0EF0YD/Zr/fAeR5x+PvvATS/a6Uk8xGjbGiVanBckfX+HWHm1a
         b21zCr45/wRLqtjkoCovTDqVgZ2bHquDwGF1oHayRCBhUj6rBzkHFFz3VGqCNeVSrvhJ
         ce7u8yex+0dr4gR5purIiCr1ayHYM2bdQwPQ+taL3SV8ZHKWNjnuUTdK9TtXHmZnN7Mi
         6mKg==
X-Gm-Message-State: AOAM532M35IHUF4ii3RmtQTcNK0WQQTMe6vYbGyF8qmMYEzKzT095ClJ
        BfPjSHuHmWDbbjir8zjl2FcT8VL6SMDgbA==
X-Google-Smtp-Source: ABdhPJxcnNr4KBNRUfnF5nO4vpQIDsQL607PMUCETnHu5w7kWz/moakJVvNi9ijy9VkXrYQUgVTZzw==
X-Received: by 2002:a2e:858a:: with SMTP id b10mr138124lji.227.1610053536699;
        Thu, 07 Jan 2021 13:05:36 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id h22sm1408585lfj.302.2021.01.07.13.05.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 13:05:35 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id a12so17906213lfl.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 13:05:35 -0800 (PST)
X-Received: by 2002:a19:7d85:: with SMTP id y127mr267718lfc.253.1610053534902;
 Thu, 07 Jan 2021 13:05:34 -0800 (PST)
MIME-Version: 1.0
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com> <20210107202525.GD504133@ziepe.ca>
 <CAHk-=wjTuS9JB=Ms4WAMaOkGuLmvYwaf2W0JhXxNPdcv4NWZUA@mail.gmail.com>
In-Reply-To: <CAHk-=wjTuS9JB=Ms4WAMaOkGuLmvYwaf2W0JhXxNPdcv4NWZUA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Jan 2021 13:05:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjDkyom4haQu6OU_yykkCFqMi98qO2gUPgZBF-11krRAA@mail.gmail.com>
Message-ID: <CAHk-=wjDkyom4haQu6OU_yykkCFqMi98qO2gUPgZBF-11krRAA@mail.gmail.com>
Subject: Re: [PATCH 0/2] page_count can't be used to decide when wp_page_copy
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 12:32 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Which is really why I think this needs to be fixed by just fixing UFFD
> to take the write lock.

Side note, and not really related to UFFD, but the mmap_sem in
general: I was at one point actually hoping that we could make the
mmap_sem a spinlock, or at least make the rule be that we never do any
IO under it. At which point a write lock hopefully really shouldn't be
such a huge deal.

The main source of IO under the mmap lock was traditionally the page
faults obviously needing to read the data in, but we now try to handle
that with the whole notion of page fault restart instead.

But I'm 100% sure we don't do as good a job of it as we _could_ do,
and there are probably a lot of other cases where we end up doing IO
under the mmap lock simply because we can and nobody has looked at it
very much.

So if taking the mmap_sem for writing is a huge deal - because it ends
up serializing with IO by people who take it for reading - I think
that is something that might be worth really looking into.

For example, right now I think we (still) only do the page fault retry
once - and the second time if the page still isn't available, we'll
actually wait with the mmap_sem held. That goes back to the very
original page fault retry logic, when I was worried that some infinite
retry would cause busy-waiting because somebody didn't do the proper
"drop mmap_sem, then wait, then return retry".

And if that actually causes problems, maybe we should just make sure
to fix it? remove that FAULT_FLAG_TRIED bit entirely, and make the
rule be that we always drop the mmap_sem and retry?

Similarly, if there are users that don't set FAULT_FLAG_ALLOW_RETRY at
all (because they don't have the logic to check if it's a re-try and
re-do the mmap_sem etc), maybe we can just fix them. I think all the
architectures do it properly in their page fault paths (I think Peter
Xu converted them all - no?), but maybe there are cases of GUP that
don't have it.

Or maybe there is something else that I just didn't notice, where we
end up having bad latencies on the mmap_sem.

I think those would very much be worth fixing, so that if
UFFDIO_WRITEPROTECT taking the mmapo_sem for writing causes problems,
we can _fix_ those problems.

But I think it's entirely wrong to treat UFFDIO_WRITEPROTECT as
specially as Andrea seems to want to treat it. Particularly with
absolutely zero use cases to back it up.

                 Linus
