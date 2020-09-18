Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF23270304
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 19:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgIRRQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 13:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgIRRQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 13:16:45 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A10C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 10:16:44 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z17so6883147lfi.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 10:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+w7EhF1DkZ1hqDHXWlBRJ6gXYmxZBjmMIR7/y1ENzF8=;
        b=JFvaow/4OrxULwRj9GRXoJIA8e0oFwbaG7Tc2sEcxqpzL78d8NqlYerFoVZEmOlQOj
         Fk6suiHeSSXPzAzoeNSJE7LdWOMLaud90cAItb0UqLSPFrKgj0Mdd0RAwmPHUwcIEZFt
         AnoZWDKC7vrvH6Hl7hZX37XDwfqaNJqSOmWaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+w7EhF1DkZ1hqDHXWlBRJ6gXYmxZBjmMIR7/y1ENzF8=;
        b=KZHLMPr2vm+lt5JV6wmA+sznsmTDm56Oy8owwtG3TDMQT282WfEIKiFML7Ui+AJKW2
         UjJMzeW2d97SvL/Y3ikdvuntmHJazykl3n5ftR59jCZR3zwy0lY0MweshS+sEdRespp+
         18ECU3UWQ2Q06z4/IE+JUNwpN1iIdnQePMy7oX/I8Q4cxTtfuFo9k2AsRXhJt+5LUtvm
         JT6i9oIouTV/PjNjjbuNaT9jwo8N8f3fMegCZxeAGuemYe7s9HOPp62UyeU5w0ctKF32
         YWI0Et2XG3ihCYuPB/UrLXpqtbt94TA0KtADHHUIMSuyJwCpMrXOjdNCdp1xoXpwKEcx
         +IPQ==
X-Gm-Message-State: AOAM531sNFLscEXN9lJ9n6zzn5TNHbUvh/2r6B44qCGecBvScDoaKaU5
        GoQAWWvR8LXtE2bEBx2VD9rrJ+9zhmVPWw==
X-Google-Smtp-Source: ABdhPJxJJldfZGtZbPj+z+3/ot1ruOMHleE3sBOtaqAxBwtkEZhA29/np5OmmbFgvfKwukwfJtvPWg==
X-Received: by 2002:ac2:4c19:: with SMTP id t25mr10410473lfq.375.1600449401975;
        Fri, 18 Sep 2020 10:16:41 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id r13sm700221lfe.114.2020.09.18.10.16.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 10:16:36 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id w3so5708677ljo.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 10:16:36 -0700 (PDT)
X-Received: by 2002:a05:651c:514:: with SMTP id o20mr12959868ljp.312.1600449395900;
 Fri, 18 Sep 2020 10:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200915193838.GN1221970@ziepe.ca> <20200915213330.GE2949@xz-x1>
 <20200915232238.GO1221970@ziepe.ca> <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca> <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca> <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca> <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1>
In-Reply-To: <20200918164032.GA5962@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Sep 2020 10:16:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whL44VySgScXjvCQ4VkeaW3nOcPMn0UwnY03iOE=1T7VQ@mail.gmail.com>
Message-ID: <CAHk-=whL44VySgScXjvCQ4VkeaW3nOcPMn0UwnY03iOE=1T7VQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
To:     Peter Xu <peterx@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 9:40 AM Peter Xu <peterx@redhat.com> wrote:
>
> Firstly in the draft patch mm->has_pinned is introduced and it's written to 1
> as long as FOLL_GUP is called once.  It's never reset after set.

That's fine. That was what I was expecting you to do. It only needs to
be cleared at mm creation time (fork/exec), and I see you added that
in mm_init() already.

Since this only matters for fork(), and is really just a filter for
the (very) special behavior, and people who _actually_ do the page
pinning won't likely be mixing that with thousands of forks anyway, it
really doesn't matter.

It's literally just about "I'm a normal process, I've never done any
special rdma page pinning, let me fork a lot with no overhead" flag.

The only change I'd make is to make it a "int" and put it next to the
"int map_count", since that will pack better on 64-bit (assuming you
don't do the randomize_layout thing, in which case it's all moot).

Even if we were to expand it to an actual page count, I'm not
convinced we'd ever want anybody to pin more than 2 billion pages.
That's a minimum of 8 TB of RAM. Even if that were physically possibly
on some machines, it doesn't seem reasonable.

So even if that flag were to ever become an actual count, more than 32
bits seems pointless and wrong.

And as a flag, it most certainly doesn't need "unsigned long".

> One more thing (I think) we need to do is to pass the new vma from
> copy_page_range() down into the end because if we want to start cow during
> fork() then we need to operate on that new vma too when new page linked to it
> rather than the parent's.

Ahh. Because you  pass the new vma down to the rmap routines.

I actually think it's unnecessary, because all the rmap routines
*really* care about is not the vma, but the anonvma associated with
it. Which will be the same for the parent and the child.

But we'd probably have to change the calling convention for rmap for
that to be obvious, so your solution seems ok. Maybe not optimal, but
I think we're going for "let's make things as clear as possible"
rather than optimal right now.

My main worry here is that it makes the calls really ugly, and we
generally try to avoid having that many arguments, but it was bad
before, and these are generally inlined, so changing it to use a
argument structure wouldn't even help code generation.

So it's not pretty. But it is what it is.

> One issue is when we charge for cgroup we probably can't do that onto the new
> mm/task, since copy_namespaces() is called after copy_mm().

That cannot possibly matter as far as I can see.

Copying the page in between those two calls is already possible since
we've already dropped the mmap_lock by the time copy_namespaces() is
called. So if the parent was threaded, and another thread did a write
access, the parent would have caused that COW that we did early.

And any page copying cost should be to the parent anyway, since that
is who did the pinning that caused the copy in the first place.

So for both of those reasons - the COW can already happen between
copy_mm() and copy_namespaces(), *and* charging it to the parent
namespace is proper anyway - I think your cgroup worry is not
relevant.

I'm not even sure anything relevant to accounting is created, but my
point is that even if it is, I don't see how it could be an issue.

> The other thing is on how to fail.  E.g., when COW failed due to either
> charging of cgroup or ENOMEM, ideally we should fail fork() too.  Though that
> might need more changes - current patch silently kept the shared page for
> simplicity.

We already can fail forkind due to memory allocations failing. Again,
not an issue. It happens.

The only real thing to worry about would be that this doesn't affect
normal programs, and that mm flag takes care of that.

               Linus
