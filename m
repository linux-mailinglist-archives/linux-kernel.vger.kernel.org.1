Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FCF2C1CAE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 05:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgKXE1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 23:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKXE1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 23:27:09 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F74C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 20:27:08 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id l11so27035997lfg.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 20:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=24cszGpR4ywO4s4bnLwJTzF6tXtNEZ3Sx4FvfUI5fRM=;
        b=Qo/w8pRweB3KyHg3F/WpjXkumwlz+D/AvIsfhGajTbc5rxWuFX6axMRr2JB4kSL4pA
         hIBC4OqrP3RwB25oHrD6ZaKBqVFGtNoYL6Y4nSMoCfYeCeQOINqE3jTOyTbnWeWoHLiI
         UkFQ9R+vhIKbEe6WKzj2zXtFUjc557jUOVygU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24cszGpR4ywO4s4bnLwJTzF6tXtNEZ3Sx4FvfUI5fRM=;
        b=lHuhrNWQQUJ+SiWfAYRjZsyPBtcU/nDrGKgfS27eXsC34kkeFRFn1CjWPEXKopRad1
         XnaSMhJUvrHuqLRXiTwTVVRDVlhosxX8//kTDBnZsFLfPpwvaUp2xyteCEA/LGcfkjRH
         isckmcPth5DFIhJK492qTXSYB5C4GL+CBrHCBbUrOiRtjcerFWHY6MfBdKdChYtqYUg9
         S1p3HvsYPhtqna9np7e+plQ0jsttW5lNPCdm6OV/tIAC/GphL//KhzfPHJ8zdp6Gnhm7
         NDlRzyMM2txvNov1VhqL/6kCWV0KxDhejROyLY47lc/CjLRPhK7/l5xw7UT9AqQuLd1y
         7LMA==
X-Gm-Message-State: AOAM532HAgyR2od2yz09u8SiM6Zb6o98tWek5m3+ztegMLiWozMkub6k
        WNHf0Aqq8iSo4VKgbxojZsAtVUlCTodgHg==
X-Google-Smtp-Source: ABdhPJyCs1i1otfJnLso8wkH+/l2IFOtD4DxN1PprNxHEziVyD5k0WMS6o40pdn6aOxg+RCyolwygA==
X-Received: by 2002:a19:3f94:: with SMTP id m142mr1062614lfa.113.1606192025831;
        Mon, 23 Nov 2020 20:27:05 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id l26sm180929ljb.92.2020.11.23.20.27.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 20:27:04 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id s27so6986249lfp.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 20:27:04 -0800 (PST)
X-Received: by 2002:a19:3f55:: with SMTP id m82mr1019862lfa.344.1606192024162;
 Mon, 23 Nov 2020 20:27:04 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d3a33205add2f7b2@google.com> <20200828100755.GG7072@quack2.suse.cz>
 <20200831100340.GA26519@quack2.suse.cz> <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
 <alpine.LSU.2.11.2011231928140.4305@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2011231928140.4305@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Nov 2020 20:26:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjcSFM+aqLnh7ucx3_tHpc1+9sJ+FfhSgVFH316uX2FZQ@mail.gmail.com>
Message-ID: <CAHk-=wjcSFM+aqLnh7ucx3_tHpc1+9sJ+FfhSgVFH316uX2FZQ@mail.gmail.com>
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
> The problem is that PageWriteback is not accompanied by a page reference
> (as the NOTE at the end of test_clear_page_writeback() acknowledges): as
> soon as TestClearPageWriteback has been done, that page could be removed
> from page cache, freed, and reused for something else by the time that
> wake_up_page() is reached.

Ugh.

Would it be possible to instead just make PageWriteback take the ref?

I don't hate your patch per se, but looking at that long explanation,
and looking at the gyrations end_page_writeback() does, I go "why
don't we do that?"

IOW, why couldn't we just make the __test_set_page_writeback()
increment the page count if the writeback flag wasn't already set, and
then make the end_page_writeback() do a put_page() after it all?

            Linus
