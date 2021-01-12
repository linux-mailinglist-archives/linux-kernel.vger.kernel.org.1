Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1A12F2D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 11:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbhALKpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 05:45:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:48588 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbhALKpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:45:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 616B4AD18;
        Tue, 12 Jan 2021 10:44:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 146D71E084C; Tue, 12 Jan 2021 11:44:25 +0100 (CET)
Date:   Tue, 12 Jan 2021 11:44:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+2fc0712f8f8b8b8fa0ef@syzkaller.appspotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: kernel BUG at mm/page-writeback.c:LINE!
Message-ID: <20210112104425.GA8760@quack2.suse.cz>
References: <000000000000886dbd05b7ffa8db@google.com>
 <20210104124153.0992b1f7fd1a145e193a333f@linux-foundation.org>
 <CAHk-=wi6hd8ATJ1W90goTxjgyvuoFsf0xZdAJmZ2c0dx5wcJSg@mail.gmail.com>
 <alpine.LSU.2.11.2101041839440.3466@eggly.anvils>
 <CAHk-=wi36CBggdRfdggACvf2hG+djM9kKnorrwsByN6uDvPExA@mail.gmail.com>
 <CAHk-=wh=5kDGukMs2sVZ8uHZJX4VL13oD5+xMAR4HvuY6QckLg@mail.gmail.com>
 <CAHk-=wgD9GK5CeHopYmRHoYS9cNuCmDMsc=+MbM_KgJ0KB+=ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgD9GK5CeHopYmRHoYS9cNuCmDMsc=+MbM_KgJ0KB+=ng@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08-01-21 18:04:21, Linus Torvalds wrote:
> On Tue, Jan 5, 2021 at 11:53 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I took your "way to go" statement as an ack, and made it all be commit
> > c2407cf7d22d ("mm: make wait_on_page_writeback() wait for multiple
> > pending writebacks").
> 
> Oh, and Michael Larabel (of phoronix) reports that that one-liner does
> something bad to a few PostgreSQL tests, on the order of 5-10%
> regression on some machines (but apparently not others).

Do you have more details? From my experience (we do regular pgbench runs
for various kernels in various configs in SUSE) PostgreSQL numbers tend to
be somewhat noisy and more dependent on CPU scheduling and NUMA locality
than anything else. But it very much depends on the exact config passed to
pgbench so that's why I'm asking...

> I suspect that's a sign of instability in the benchmark numbers, but
> it probably also means that we have some silly condition where
> multiple threads want to clean the same page.
> 
> I sent him a patch to try if it ends up being better to just not wake
> things up early at all (instead of the "if" -> "while") conversion.
> That trivial patch appended here in case anybody has comments.
> 
> Just the fact that that one-liner made a performance impact makes me
> go "hmm", though. Michael didn't see the BUG_ON(), so it's presumably
> some _other_ user of wait_on_page_writeback() than the
> write_cache_pages() one that causes issues.
> 
> Anybody got any suspicions? Honestly, when working on the page wait
> queues, I was working under the assumption that it's really just the
> page lock that truly matters.
> 
> I'm thinking things like __filemap_fdatawait_range(), which doesn't
> hold the page lock at all, so it's all kinds of non-serialized, and
> could now be waiting for any number of IO's ro complete..
> 
> Oh well. This email doesn't really have a point, it's more of a
> heads-up that that "wait to see one or multiple writebacks" thing
> seems to matter more than I would have expected for some loads..

Honestly I'm surprised your patch made a difference as well. It is pretty
common a page gets redirtied while it's being written back but usually it
takes time before next writeback of the page is started. But I guess with
the DB load it is possible e.g. if we frequently flush out some page for
data consistency reasons (I know PostgreSQL is using sync_file_range(2)
interface to start flushing pages early and then uses fsync(2) when it
really needs the pages written which could create a situation with unfair
treatment of PageWriteback bit).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
