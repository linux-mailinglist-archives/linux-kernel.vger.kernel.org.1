Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF2E2F0500
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 04:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbhAJD5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 22:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbhAJD5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 22:57:53 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E32C061786
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 19:57:12 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id x16so19925195ejj.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 19:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cV8ZqZdlJCrqMkTrujQl9EAYyHQiNVsrSGFMRnZRJxw=;
        b=eRAa1kQCQANkeqLwLL3/tJy2lwSmtWHajnrcMYSJ5nN7o46BCeUw9zUVaxBi9eifOH
         4n3qby9mFGgnOJUzJDVcvsK7YndJvWNIqhupAk8zKFJEYSwhMiPIXqgPAdTwcsByyFdr
         RPMJOy9Z0j1BumyB3nXDXFy4/7VPYYJbf5R8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cV8ZqZdlJCrqMkTrujQl9EAYyHQiNVsrSGFMRnZRJxw=;
        b=QguLhQpEin+ZoyWk6goKyi3zRuRuVu2mgWZ6GrJaiNJiHvtm4l2BmBo7JHvsouvMBu
         6nPdZPNZJ0ckpduHby6So4XswpyISqCJ3Jlkq81ssG0DHK267sPpklMycZPjUwvTFYfs
         WxBlf7w4Cvx8+t1T51kMm8t06C///4VJEI4waKRsyGeR98RQZdPXGX+ABBV1SUbh/9pl
         e05o9gTofg2ix+oP8A7KgCLx9wgljeABCVCs1OUCCp0qwqw/iiHz9r9n83HATMSbrev/
         wPfqJ9ky+RU+pltSzhLpOviFtmGdlf/HX0br2X46EWQjpaoIFO4lxmmBmA3UJ2HcGTrL
         ajxg==
X-Gm-Message-State: AOAM533C5PjaI5gstK1Un3hzCRqpqcAlp4NIxVGJHwr70DaMLxXGyGOn
        KMAePnywUaQkMyYuOuRXOJmSR0fikZy6wQ==
X-Google-Smtp-Source: ABdhPJzNQdsDUokQLyHiqe/JJHhG/7p5s6chIlpmv0yz74vGbryWYf5Ts1yZXI15avLwrq/XJtMfeA==
X-Received: by 2002:a17:906:fa12:: with SMTP id lo18mr7349526ejb.354.1610251031031;
        Sat, 09 Jan 2021 19:57:11 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id i24sm5282139ejx.31.2021.01.09.19.57.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jan 2021 19:57:10 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id b2so15346344edm.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 19:57:10 -0800 (PST)
X-Received: by 2002:a05:6512:338f:: with SMTP id h15mr4358383lfg.40.1610250728515;
 Sat, 09 Jan 2021 19:52:08 -0800 (PST)
MIME-Version: 1.0
References: <20210110004435.26382-1-aarcange@redhat.com> <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
 <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com> <X/prosulFrEoNnoF@redhat.com>
In-Reply-To: <X/prosulFrEoNnoF@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 Jan 2021 19:51:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjZTMsv0_GOyQpLRk_5U1r5W8e21f8sV0jykK=z47hjGQ@mail.gmail.com>
Message-ID: <CAHk-=wjZTMsv0_GOyQpLRk_5U1r5W8e21f8sV0jykK=z47hjGQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 9, 2021 at 6:51 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> I just don't see the simplification coming from
> 09854ba94c6aad7886996bfbee2530b3d8a7f4f4. Instead of checking
> page_mapcount above as an optimization, to me it looks much simpler to
> check it in a single place, in do_wp_page, that in addition of
> optimizing away the superfluous copy, would optimize away the above
> complexity as well.

Here's the difference:

 (a) in COW, "page_mapcount()" is pure and utter garbage, and has zero meaning.

Why? Because MAPCOUNT DOES NOT MATTER FOR COW.

COW is about "I'm about to write to this page, and that means I need
an _exclusive_ page so that I don't write to a page that somebody else
is using".

Can you admit that fundamental fact?

Notice how "page_mapcount()" has absolutely NOTHING to do with
"exclusive page". There are lots of other ways the page can be used
aside from mapcount. The page cache may have a reference to the page.
Somebody that did a GUP may have a reference to the page.

So what actually matters at COW time? The only thing that matters is
"am I the exclusive owner". And guess what? We have a count of page
references. It's "page_count()". That's *EXACTLY* the thing that says
"are there maybe other references to this page".

In other words, COW needs to use page_count(). It really is that easy.
End of story.

So, given that, why do I then do

> +     if (page_mapcount(page) != 1)
> +             return false;

in my patch, when I just told you that "page_mapcount()" is irrelevant for COW?

Guess what? The above isn't about COW. The above isn't about whether
we need to do a copy in order to be able to write to the page without
anybody else being affected by it.

No, at fork time, and at this clear_refs time, the question is
entirely different. The question is not "Do I have exclusive access to
the page", but it is "Did I _already_ made sure that I have exclusive
access to the page because I pinned it"?

See how different the question is?

Because *if* you have done a pinned COW for soem direct-IO read, and
*if* that page is dirty, then you know it's mapped only in your
address space. You're basically doing the _reverse_ of the COW test,
and asking yourself "is this my own private pinned page"?

And then it's actually perfectly sane to do a check that says
"obviously, if somebody else has this page mapped, then that's not the
case".

See?

For COW, "page_mapcount()" is pure and utter garbage, and entirely
meaningless. How many places it's mapped in doesn't matter. You may
have to COW even if it's only mapped in your address space (page
cache, GUP, whatever).

But for "did I already make this exclusive", then it's actually
meaningful to say "is it mapped somewhere else". We know it has other
users - that "page_may_be_pinned()" in fact *guarantees* that it has
other users. But we're double-checking that the other users aren't
other mappings.

That said, I did just realize that that "page_mapcount()" check is
actually pointless.

Because we do have a simpler one. Instead of checking whether all
those references that made us go "page_might_be_pinned()" aren't other
mappings, the simple check for "pte_writable()" would already have
told us that we had already done the COW.

So you are actually right that the page_mapcount() test in my patch is
not the best way to check for this. By the time we see
"page_may_be_pinned()", we might as well just say "Oh, it's a private
mapping and the pte is already writable, so we know we were the
exclusive mapper, because COW and fork() already guarantee that".

> And I won't comment if it's actually safe to skip random pages or
> not. All I know is for mprotect and uffd-wp, definitely the above
> approach wouldn't work.

Why do you say that?

You say ":definitely know", but I think you're full of it.

The fact is, if you have a pinned page, why wouldn't we say "you can't
turn it read-only"?

It's pinned in the VM address space - and it's pinned writable. Simple
and clear semantics. You can *remove* it, but you can't change the
pinning.

              Linus
