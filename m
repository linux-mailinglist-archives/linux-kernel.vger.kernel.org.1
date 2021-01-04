Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0472EA109
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 00:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbhADXoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 18:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbhADXoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:44:44 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA36C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 15:44:02 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qw4so38993475ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 15:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1WyRnE3FCyMn5lEtFjWaRD8K2XDmf+b9oA3QV7CY8n0=;
        b=SfyxRJvKNM1X28EwvAfTS7BZlF0oMAXEYwfZrBB9ih/I0v1qUWx2vTSSBmIPoIk3XN
         NerrTiIAdGQ0ZfU8R/ib1aYHbkJUfxS9U3NvMz8uQQLInIzJlc+BTUBFWQucO5kHsibS
         xgSpZ7zn5JJ1uoiJ9I0E3t4m6ycE+5i5MX4nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1WyRnE3FCyMn5lEtFjWaRD8K2XDmf+b9oA3QV7CY8n0=;
        b=BNShvnC2TOu9Ibvre7ULeh52/NY6tSpTi4/hpUljquSki8TZsQ5Mmw1Mx0hV1DHiQ5
         BnE+yLOWi91fvZqPzatRp+NFkfu8V8DwbazTEMs5eoli3bY0eBFDzmW+LIDj/DwkDsPs
         YuCUNZF5a50cm9zO8VglpB8dO/B6NXaXdU2kvksbhMRwC4ox/aX0IGSr+yudxrlMyvVQ
         BddnWbrj9WAZJlLeAHDYfqz8hx77OKAxb6lPv4J4ruYxcpI/Q1wo4w0SH5qH//4MZl2k
         T3c5MGGCbKUFJRoL0hRAIrzMvlVnFh6yUKzlQ9Ta5a+6EenkCp1iHtjOwhVCoeB8qpAG
         B5ng==
X-Gm-Message-State: AOAM53202fbcdZXXYTqI3jDz8xN71DKymQR3hTpShsfxhevRTQZvUEHG
        VD/xJqF7VP63HXzgYuuzdyuSjG3sG+hHsg==
X-Google-Smtp-Source: ABdhPJwaZ8wQiDjybKlpYlLht9lzKMaC9Dfz7yx05KZvZ1cc00eTJKV5Bok/VIxn391PeoQr/juypg==
X-Received: by 2002:a05:651c:30d:: with SMTP id a13mr35722245ljp.238.1609797167151;
        Mon, 04 Jan 2021 13:52:47 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id e25sm7569246lfc.40.2021.01.04.13.52.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 13:52:46 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id s26so67907998lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 13:52:46 -0800 (PST)
X-Received: by 2002:a2e:b4af:: with SMTP id q15mr35051887ljm.507.1609797165713;
 Mon, 04 Jan 2021 13:52:45 -0800 (PST)
MIME-Version: 1.0
References: <000000000000886dbd05b7ffa8db@google.com> <20210104124153.0992b1f7fd1a145e193a333f@linux-foundation.org>
In-Reply-To: <20210104124153.0992b1f7fd1a145e193a333f@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Jan 2021 13:52:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi6hd8ATJ1W90goTxjgyvuoFsf0xZdAJmZ2c0dx5wcJSg@mail.gmail.com>
Message-ID: <CAHk-=wi6hd8ATJ1W90goTxjgyvuoFsf0xZdAJmZ2c0dx5wcJSg@mail.gmail.com>
Subject: Re: kernel BUG at mm/page-writeback.c:LINE!
To:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+2fc0712f8f8b8b8fa0ef@syzkaller.appspotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 12:41 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> >
> > kernel BUG at mm/page-writeback.c:2241!
> > Call Trace:
> >  mpage_writepages+0xd8/0x230 fs/mpage.c:714
> >  do_writepages+0xec/0x290 mm/page-writeback.c:2352
> >  __filemap_fdatawrite_range+0x2a1/0x380 mm/filemap.c:422
> >  fat_cont_expand+0x169/0x230 fs/fat/file.c:235
> >  fat_setattr+0xac2/0xf40 fs/fat/file.c:501
> >  notify_change+0xb60/0x10a0 fs/attr.c:336
> >  do_truncate+0x134/0x1f0 fs/open.c:64
> >  do_sys_ftruncate+0x703/0x860 fs/open.c:195
> >  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Well that's exciting. write_cache_pages() does:
>
>                         if (PageWriteback(page)) {
>                                 if (wbc->sync_mode != WB_SYNC_NONE)
>                                         wait_on_page_writeback(page);
>                                 else
>                                         goto continue_unlock;
>                         }
>
> bang -->>               BUG_ON(PageWriteback(page));

This is the same situation that was discussed earlier, and that we
thought Hugh commit 073861ed77b6 ("mm: fix VM_BUG_ON(PageTail) and
BUG_ON(PageWriteback)") should fix.

Basically, the theory was that the sequence

                if (PageWriteback(page))
                        wait_on_page_writeback(page);
                BUG_ON(PageWriteback(page));

could have the wake-up of the _previous_ owner of the page happen, and
wake up the wait_on_page_writeback() waiter, but then a new owner of
the page would re-allocate it and mark it for writeback.

> So either wait_on_page_writeback() simply failed to work (returned
> without waiting) or someone came in and unexpectedly set PG_writeback a
> second time.

So Hugh found at least _one_ way that that "someone came in and
unexpectedly set PG_writeback a second time" could happen.

But that fix by Hugh is already in that  HEAD commit that syzbot is
now reporting, so there's something else going on.

> Linus, how confident are you in those wait_on_page_bit_common()
> changes?

Pretty confident. The atomicity of the bitops themselves is fairly simple.

But in the writeback bit? No. The old code would basically _loop_ if
it was woken up and the writeback bit was set again, and would hide
any problems with it.

The new code basically goes "ok, the writeback bit was clear at one
point, so I've waited enough".

We could easily turn the "if ()" in wait_on_page_writeback() into a "while()".

But honestly, it does smell to me like the bug is always in the caller
not having serialized with whatever actually starts writeback. High
figured out one such case.

This code holds the page lock, but I don't see where
set_page_writeback() would always be done with the page lock held. So
what really protects against PG_writeback simply being set again?

The whole BUG_ON() seems entirely buggy to me.

In fact, even if you hold the page lock while doing
set_page_writeback(), since the actual IO does *NOT* hold the page
lock, the unlock happens without it. So even if every single case of
setting the page writeback were to hold the page lock, what keeps this
from happening:

CPU1 = end previous writeback
CPU2 = start new writeback under page lock
CPU3 = write_cache_pages()

  CPU1          CPU2            CPU3
  ----          ----            ----

  end_page_writeback()
    test_clear_page_writeback(page)
    ... delayed...


                lock_page();
                set_page_writeback()
                unlock_page()


                                lock_page()
                                wait_on_page_writeback();

    wake_up_page(page, PG_writeback);
    .. wakes up CPU3 ..

                                BUG_ON(PageWriteback(page));

IOW, that BUG_ON() really feels entirely bogus to me. Notice how it
wasn't actually serialized with the waking up of the _previous_ bit.

Could we make the wait_on_page_writeback() just loop if it sees the
page under writeback again? Sure.

Could we make the wait_on_page_bit_common() code say "if this is
PG_writeback, I won't wake it up after all, because the bit is set
again?" Sure.

But I feel it's really that end_page_writeback() itself is
fundamentally buggy, because the "wakeup" is not atomic with the bit
clearing _and_ it doesn't actually hold the page lock that is
allegedly serializing this all.

That raciness was what caused the "stale wakeup from previous owner"
thing too. And I think that Hugh fixed the page re-use case, but the
fundamental problem of end_page_writeback() kind of remained.

And yes, I think this was all hidden by wait_on_page_writeback()
effectively looping over the "PageWriteback(page)" test because of how
wait_on_page_bit() worked.

So the one-liner of changing the "if" to "while" in
wait_on_page_writeback() should get us back to what we used to do.

Except I still get the feeling that the bug really is not in
wait_on_page_writeback(), but in the end_page_writeback() side.

Comments? I'm perfectly happy doing the one-liner. I would just be
_happier_ with end_page_writeback() having the serialization..

The real problem is that "wake_up_page(page, bit)" is not the thing
that actually clears the bit. So there's a fundamental race between
clearing the bit and waking something up.

Which makes me think that the best option would actually be to move
the bit clearing _into_ wake_up_page(). But that looks like a very big
change.

                   Linus
