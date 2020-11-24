Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939A12C1D29
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 05:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgKXExn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 23:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgKXExn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 23:53:43 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A5BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 20:53:42 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id d17so26997751lfq.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 20:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39gr2tFdgeuXdCwWbn22GRnP3K3VvibhIlGf9k17rGw=;
        b=SwaVIz6ZuT6iXE5tagOrwT7N6KNmmSkcEsDFfOdmzj5yjFEuDkdXhaHbzf22ipogzf
         zWRWhpolqbEMbnZmb7w8SY8YssaOfvRbra2P6MvkDrdQIcceCNS8eCPycSxvqCyBE/Wt
         Aogcb79k9z8ri+jJ6nmyXvkP8hv8F792ZSl3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39gr2tFdgeuXdCwWbn22GRnP3K3VvibhIlGf9k17rGw=;
        b=Nm49fjrB1Jhcl4o+So53TCynAkSZIfDM333zhMeiylw4KSx1DJsiSjHqANGu9UZAmj
         0km0HA2Q5uuHzNb57QOgyMcmQQ86PgKVNL7u6vvdFOmuLlZo8DtlPTDCSHjcZnpKXAHf
         MXFw9Aoot8WF9YTu8B4XQH6Go1kpz2mZ4KFvy2kC5RmawubXah7EwbBR9dE3Dx8LKQgF
         cpsoJkDFxaLFufjyiCJmocjFf62lNkKXIbK2prJ0EIL7x6sQJ2olK3pO6C2ePUd3i8Q0
         amRzM7hqRRhgj0tzs2kl514ShJoDjXgj4uxwvESXV6YsuUsE6+mDvBQF37EU78tYcFAk
         1zcw==
X-Gm-Message-State: AOAM531dzcXBHRzbOlN2a/wCB+51ETvf4e8XVz8r/Gdh19qIKeK2SXiW
        7vRVCUgixJ8UPBTybGZIOtn4qqgtIccwYA==
X-Google-Smtp-Source: ABdhPJwgHRcsPxEUVvwQZtwc5/H1k1TdukQICpivK9JTfXOAcvZ+ujTtBJMn/6E3k9VFcXJNSk/8Uw==
X-Received: by 2002:a19:f00b:: with SMTP id p11mr1082892lfc.166.1606193621098;
        Mon, 23 Nov 2020 20:53:41 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 26sm187386ljg.73.2020.11.23.20.53.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 20:53:38 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id u18so26994927lfd.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 20:53:37 -0800 (PST)
X-Received: by 2002:a19:ae06:: with SMTP id f6mr1057406lfc.133.1606193616810;
 Mon, 23 Nov 2020 20:53:36 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d3a33205add2f7b2@google.com> <20200828100755.GG7072@quack2.suse.cz>
 <20200831100340.GA26519@quack2.suse.cz> <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
 <alpine.LSU.2.11.2011231928140.4305@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2011231928140.4305@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Nov 2020 20:53:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=whYO5v09E8oHoYQDn7qqV0hBu713AjF+zxJ9DCr1+WOtQ@mail.gmail.com>
Message-ID: <CAHk-=whYO5v09E8oHoYQDn7qqV0hBu713AjF+zxJ9DCr1+WOtQ@mail.gmail.com>
Subject: Re: kernel BUG at fs/ext4/inode.c:LINE!
To:     Hugh Dickins <hughd@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+3622cea378100f45d59f@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Linux-MM <linux-mm@kvack.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 8:07 PM Hugh Dickins <hughd@google.com> wrote:
>
> Then on crashing a second time, realized there's a stronger reason against
> that approach.  If my testing just occasionally crashes on that check,
> when the page is reused for part of a compound page, wouldn't it be much
> more common for the page to get reused as an order-0 page before reaching
> wake_up_page()?  And on rare occasions, might that reused page already be
> marked PageWriteback by its new user, and already be waited upon?  What
> would that look like?
>
> It would look like BUG_ON(PageWriteback) after wait_on_page_writeback()
> in write_cache_pages() (though I have never seen that crash myself).

So looking more at the patch, I started looking at this part:

> +       writeback = TestClearPageWriteback(page);
> +       /* No need for smp_mb__after_atomic() after TestClear */
> +       waiters = PageWaiters(page);
> +       if (waiters) {
> +               /*
> +                * Writeback doesn't hold a page reference on its own, relying
> +                * on truncation to wait for the clearing of PG_writeback.
> +                * We could safely wake_up_page_bit(page, PG_writeback) here,
> +                * while holding i_pages lock: but that would be a poor choice
> +                * if the page is on a long hash chain; so instead choose to
> +                * get_page+put_page - though atomics will add some overhead.
> +                */
> +               get_page(page);
> +       }

and thinking more about this, my first reaction was "but that has the
same race, just a smaller window".

And then reading the comment more, I realize you relied on the i_pages
lock, and that this odd ordering was to avoid the possible latency.

But what about the non-mapping case? I'm not sure how that happens,
but this does seem very fragile.

I'm wondering why you didn't want to just do the get_page()
unconditionally and early. Is avoiding the refcount really such a big
optimization?

            Linus
