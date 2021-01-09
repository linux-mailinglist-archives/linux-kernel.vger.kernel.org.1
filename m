Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C9B2F0320
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 20:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbhAITQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 14:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbhAITQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 14:16:45 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E285EC061786
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 11:16:04 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id h205so31185108lfd.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 11:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xj+wdM4M3lEcvuGtKhWJM/1JZgF4kFJC8VcvB5NhKwQ=;
        b=Js+UCVunDyRvtAD/Vi2SOxakMOjEVHtBYDli/CvLZL9N2kyfy6Mh2BfhkGbmgvwG7d
         wVAed4qYoC9/strnC4F+u2fujRHgacUGXv0S+xOUtds7NRHfC3EqtIhxPvNnFM/po6Ea
         G207De9kWt0PKqoSbstfEKMde392XapWvBOaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xj+wdM4M3lEcvuGtKhWJM/1JZgF4kFJC8VcvB5NhKwQ=;
        b=X6n1TY6XUWjycz9TrF5CmYuG1INvShgNRTVb5uqhiowGrKpBAWsMsXY6tBk+7IlRRs
         s8YunbqYPyXGOT3XqYpM+0mdmtw5aHieREkf/fXZ6uw2UkXSd7Uwqxen+v3kG+3N0DLV
         MohtCy/sYWNlvAVO07Tr4xVRiWbD0CGoZjeoD8f+eF7RtSEDtAd33Rbdw8TM3AlVbKKY
         XFvav5vn7rEcpjolmXq5ZKBYaLMtghiHRCpNn8/lylcyFy8RC5/AFn1WPU5cQfitxEDR
         eZQVFHj8s0IfWjK5InTtc9vaSHKeEDJa7WQzoWdK+N2I9bUw46CFAhWQ5SG627hH6116
         ySXw==
X-Gm-Message-State: AOAM531WO+LI/EEeaCQeEu+hEK//wNA6WpQrBfNl7l2vgHf7NJyXpuNz
        P54W4YruRy9mVPFFpwCB3j8FOIn8Kt2vIw==
X-Google-Smtp-Source: ABdhPJzSxff+qslRMFipDvcf2CXwbvU9U5+H3NxATLHeUQT3WvBp4kKxm04L/JLHdld+WIzdYXjLFA==
X-Received: by 2002:a19:844c:: with SMTP id g73mr3805653lfd.462.1610219762876;
        Sat, 09 Jan 2021 11:16:02 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id m24sm2635209ljj.62.2021.01.09.11.16.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jan 2021 11:16:01 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id o19so31223700lfo.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 11:16:01 -0800 (PST)
X-Received: by 2002:a2e:3211:: with SMTP id y17mr3877771ljy.61.1610219761030;
 Sat, 09 Jan 2021 11:16:01 -0800 (PST)
MIME-Version: 1.0
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com> <20210107202525.GD504133@ziepe.ca>
 <X/eA/f1r5GXvcRWH@redhat.com> <20210108133649.GE504133@ziepe.ca>
 <X/iPtCktcQHwuK5T@redhat.com> <20210108181945.GF504133@ziepe.ca>
 <CALCETrVWGZ5MkN6S+o_h5isOHKVpjwSz-jyXSsp9VJjVOYOyyg@mail.gmail.com>
 <X/jr8QfeolQwn39f@redhat.com> <CALCETrWbmgyHR_d+FxKYpWYCc2XwZ8V8DNt_5bBL08Mi+1-_Uw@mail.gmail.com>
In-Reply-To: <CALCETrWbmgyHR_d+FxKYpWYCc2XwZ8V8DNt_5bBL08Mi+1-_Uw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 Jan 2021 11:15:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjy6j0PL5bburcTXH3UtD0fqKz5vfgvVJAMi-qevSAp2g@mail.gmail.com>
Message-ID: <CAHk-=wjy6j0PL5bburcTXH3UtD0fqKz5vfgvVJAMi-qevSAp2g@mail.gmail.com>
Subject: Re: [PATCH 0/2] page_count can't be used to decide when wp_page_copy
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Yu Zhao <yuzhao@google.com>,
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

On Sat, Jan 9, 2021 at 11:03 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> >
> > Sorry to ask but I'm curious, what also goes wrong if the user
> > modifies memory under GUP pin from vmsplice? That's not obvious to
> > see.
>
> It breaks the otherwise true rule that the data in pipe buffers is
> immutable.

Note that this continued harping on vmsplice() is entirely misguided.

Anything using GUP has the same issues.

This really has nothing to do with vmsplice() per se.

In many ways, vmsplice() might be the least of your issues, because
it's fairly easy to just limit that for untrusted use.

And no, that does not mean "we should make vmsplice root-only" kind of
limiting. There are no security issues in any normal situation. Again,
it's mainly about things that don't trust each other _despite_ running
in similar contexts as far as the kernel is concerned. IOW, exactly
that "zygote" kind of situation.

If you are a JIT (whether Zygote or a web browser), you basically need
to limit the things the untrusted JIT'ed code can do. And that
limiting may include vmsplice().

But note the "include" part of "include vmsplice()". Any other GUP
user really does have the same issues, it may just be less obvious and
have very different timings (or depend on access to devices etc).

Absolutely nothing cares about "data in pipe buffers changing" in any
other case. You can already write any data you want to a pipe, it
doesn't matter if it changes after the write or not.

(In many ways, "data in the page cache" is a *much* more difficult
issue for the kernel, and it's fundamental to any shared mmap. It's
much more difficult because that data is obviously very much also
accessible for DMA etc for writeout, and if you have something like
"checksums are calculated separately and non-atomically from the
actual DMA accesses", you will potentially get checksum errors where
the actual disk contents don't match your separately calculated
checksums until the _next_ write. This can actually be a feature -
seeing "further modifications were concurrent to the write" - but most
people end up considering it a bug).

               Linus
