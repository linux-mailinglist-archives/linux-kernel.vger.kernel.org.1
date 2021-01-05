Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888652EB384
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 20:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbhAETci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 14:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbhAETch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 14:32:37 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C86AC061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 11:31:57 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id h205so1122121lfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 11:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z1FwgA8Ww/7IgT5bjT946IYpX2R2TC69Q6b+o2dVbrM=;
        b=hA6nC4lKLxKrUs7MpCZCbI/RF0tI9dTZsLbOuov9YMyi2/eXblwkza4XzkyzrEciUj
         crhUOeNHz05e8YTS0MYujgw/1O+8VFW3/DqDYUINeFKBBLNL9kILdj3grIay+vTfxBP1
         dk/siDfsguJmdFkH8uAtals9Ndiz3nqLvVNcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z1FwgA8Ww/7IgT5bjT946IYpX2R2TC69Q6b+o2dVbrM=;
        b=tWn25izFKA+7mhLFlaDo+SZjTF25giI4HBtwhTz+2yha3FSIPbEPMeuZ40PZ+6R2jw
         CCBnMX4kPgaRQzUR5uIVbp7jO5duP0AI9VJLV7wY5p9tGPRzelWnl2/g3ihXPRgoA0I7
         ui69mDzLWm39Hv6kpIJNSY5CR5OqmlveWmM0QSG0JJdkJni++KGeEi8zcVi5XCGJLP+u
         ywvIVTP9MWVGc/NaTLelQg+IO4iMoJKlz7aO6/+1d1PMOvvoyBZ1nj2rYB6A2J3nBFjX
         +6dQyjZIE8O0Mys8bdLuxeZ0ZEBZIwMfAp7JXFGxVp2lQ33uu2rM7Rmgqk8Wz3AIHJnx
         IUhw==
X-Gm-Message-State: AOAM5331mGRDIZYUnM7kUiWf7EOUu2vWn8i7nMStyeKmCRqrrsHf5sTt
        4+kJ+0as1CbYclcmjONCxhtsLThK48ki6g==
X-Google-Smtp-Source: ABdhPJwezd7IDoLheYCWOEOMM0sFpLYjTOyJCB0KvekqMOSuB4WK/9Mv+YlJmy9A4susqpLC+u41LA==
X-Received: by 2002:a19:c508:: with SMTP id w8mr365434lfe.658.1609875115516;
        Tue, 05 Jan 2021 11:31:55 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id l17sm9423lfg.205.2021.01.05.11.31.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 11:31:54 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 23so1051416lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 11:31:53 -0800 (PST)
X-Received: by 2002:a2e:b4af:: with SMTP id q15mr470264ljm.507.1609875113609;
 Tue, 05 Jan 2021 11:31:53 -0800 (PST)
MIME-Version: 1.0
References: <000000000000886dbd05b7ffa8db@google.com> <20210104124153.0992b1f7fd1a145e193a333f@linux-foundation.org>
 <CAHk-=wi6hd8ATJ1W90goTxjgyvuoFsf0xZdAJmZ2c0dx5wcJSg@mail.gmail.com> <alpine.LSU.2.11.2101041839440.3466@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2101041839440.3466@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Jan 2021 11:31:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi36CBggdRfdggACvf2hG+djM9kKnorrwsByN6uDvPExA@mail.gmail.com>
Message-ID: <CAHk-=wi36CBggdRfdggACvf2hG+djM9kKnorrwsByN6uDvPExA@mail.gmail.com>
Subject: Re: kernel BUG at mm/page-writeback.c:LINE!
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+2fc0712f8f8b8b8fa0ef@syzkaller.appspotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 7:29 PM Hugh Dickins <hughd@google.com> wrote:
>
> > But I feel it's really that end_page_writeback() itself is
> > fundamentally buggy, because the "wakeup" is not atomic with the bit
> > clearing _and_ it doesn't actually hold the page lock that is
> > allegedly serializing this all.
>
> And we won't be adding a lock_page() into end_page_writeback()!

Right.

However, the more I think about this, the more I feel
end_page_writeback() is kind of ok, and the real problem is that we
should have had a "lock/unlock" pattern for the PG_writeback bit
instead.

Instead, what we have is basically a special "wait for bit to clear",
and then external sychronization - even if lacking - for set/clear
bit.

And the "wait for bit to clear" and "set bit" aren't even adjacent -
the waiting happens in write_cache_pages(), but then the actual
setting happens later in the actual "(*writepage)()" function.

What _would_ be nicer, I feel, is if write_cache_pages() simply did
the equivalent of "lock_page()" except for setting the PG_writeback
bit. The whole "wait for bit to clear" is fundamentally a much more
ambiguous thing for that whole "what if somebody else got it" reason,
but it's also nasty because it can be very unfair (the same way our
"lock_page()" itself used to be very unfair).

IOW, you can have that situation where one actor continually waits for
the bit to clear, but then somebody else comes in and gets the bit
instead.

Of course, writeback is much less likely than lock_page(), so it
probably doesn't happen much in practice.

And honestly, while I think it would be good to make the rule be
"writepage function was entered with the writeback bit already held",
that kind of change would be a major pain. We have at leastr 49
different 'writepage' implementations, and while I think a few of them
end up just being block_write_full_page(), it means that we have a lot
of that

        BUG_ON(PageWriteback(page));
        set_page_writeback(page);

pattern in various random filesystem code that all would have to be changed.

So I think I know what I'd _like_ the code to be like, but I don't
think it's worth it.

> > So the one-liner of changing the "if" to "while" in
> > wait_on_page_writeback() should get us back to what we used to do.
>
> I think that is the realistic way to go.

Yeah, that's what I'll do.

> > Which makes me think that the best option would actually be to move
> > the bit clearing _into_ wake_up_page(). But that looks like a very big
> > change.

See above - having thought about this overnight, I don't think this is
even the best change.

> But I expect you to take one look and quickly opt instead for the "while"
> in wait_on_page_writeback(): which is not so bad now that you've shown a
> scenario which justifies it.

[ patch removed - I agree, this pain isn't worth it ]

               Linus
