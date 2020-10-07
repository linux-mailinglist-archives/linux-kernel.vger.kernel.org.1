Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7B7285E44
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 13:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgJGLfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 07:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbgJGLfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 07:35:50 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E729CC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 04:35:49 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQ7jQ-000s0R-57; Wed, 07 Oct 2020 13:35:40 +0200
Message-ID: <7b7d6954b74e109e653539d880173fa9cb5c5ddf.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/2] mmap locking API: Order lock of nascent mm
 outside lock of live mm
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Michel Lespinasse <walken@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Date:   Wed, 07 Oct 2020 13:35:39 +0200
In-Reply-To: <CAG48ez2cW0mrSPihrtX6Kus2AYc0hKX8izpzvOMYrnk0eLOAoA@mail.gmail.com> (sfid-20201007_102849_013033_175305AA)
References: <20201006225450.751742-1-jannh@google.com>
         <20201006225450.751742-2-jannh@google.com>
         <115d17aa221b73a479e26ffee52899ddb18b1f53.camel@sipsolutions.net>
         <CAG48ez2cW0mrSPihrtX6Kus2AYc0hKX8izpzvOMYrnk0eLOAoA@mail.gmail.com>
         (sfid-20201007_102849_013033_175305AA)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jann,

> > > +++ b/arch/um/include/asm/mmu_context.h
> > > @@ -48,9 +48,8 @@ static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
> > >        * when the new ->mm is used for the first time.
> > >        */
> > >       __switch_mm(&new->context.id);
> > > -     mmap_write_lock_nested(new, SINGLE_DEPTH_NESTING);
> > > +     mmap_assert_write_locked(new);
> > >       uml_setup_stubs(new);
> > > -     mmap_write_unlock(new);
> > >  }
> > 
> > FWIW, this was I believe causing lockdep issues.
> > 
> > I think I had previously determined that this was pointless, since it's
> > still nascent and cannot be used yet?
> 
> Well.. the thing is that with patch 2/2, I'm not just protecting the
> mm while it hasn't been installed yet, but also after it's been
> installed, until setup_arg_pages() is done (which still uses a VMA
> pointer that we obtained really early in the nascent phase). 

Oh, sure. I was referring only to the locking in UML's activate_mm(),
quoted above. Sorry for not making that clear.

> So in summary, I think the code currently is not (visibly) buggy in
> the sense that you can make it do something bad, but it's extremely
> fragile and probably only safe by chance. This patchset is partly my
> attempt to make this a bit more future-proof before someone comes
> along and turns it into an actual memory corruption bug with some
> innocuous little change. (Because I've had a situation before where I
> thought "oh, this looks really fragile and only works by chance, but
> eh, it's not really worth changing that code" and then the next time I
> looked, it had turned into a security bug that had already made its
> way into kernel releases people were using.)

Right.

> > But I didn't really know for sure,
> > and this patch was never applied:
> > 
> > https://patchwork.ozlabs.org/project/linux-um/patch/20200604133752.397dedea0758.I7a24aaa26794eb3fa432003c1bf55cbb816489e2@changeid/
> 
> Eeeh... with all the kernel debugging infrastructure *disabled*,

but I didn't have it disabled, I had lockdep enabled, and lockdep was
complaining (now granted, I was still on 5.8 for that patch):

=============================
[ BUG: Invalid wait context ]
5.8.0-00006-gef4b340c886a #23 Not tainted
-----------------------------
swapper/1 is trying to lock:
000000006e54c160 (&mm->mmap_lock/1){....}-{3:3}, at: begin_new_exec+0x6c5/0xb26
other info that might help us debug this:
context-{4:4}
3 locks held by swapper/1:
 #0: 00000000705f4548 (&sig->cred_guard_mutex){+.+.}-{3:3}, at: __do_execve_file+0x12c/0x7ea
 #1: 00000000705f45e0 (&sig->exec_update_mutex){+.+.}-{3:3}, at: begin_new_exec+0x5db/0xb26
 #2: 00000000705e05a8 (&p->alloc_lock){+.+.}-{2:2}, at: begin_new_exec+0x66b/0xb26
stack backtrace:
CPU: 0 PID: 1 Comm: swapper Not tainted 5.8.0-00006-gef4b340c886a #23
Stack:
 6057fa2d 705e0760 705ebbb0 00000133
 6008d289 705e0760 705e0040 00000003
 705ebbc0 6028e02f 705ebc50 60080b29
Call Trace:
 [<6008d289>] ? printk+0x0/0x94
 [<60024a1a>] show_stack+0x153/0x174
 [<6008d289>] ? printk+0x0/0x94
 [<6028e02f>] dump_stack+0x34/0x36
 [<60080b29>] __lock_acquire+0x515/0x15f5
 [<6007c593>] ? hlock_class+0x0/0xa1
 [<6007fd90>] lock_acquire+0x347/0x42d
 [<6013def5>] ? begin_new_exec+0x6c5/0xb26
 [<60039b51>] ? set_signals+0x29/0x3f
 [<600835c1>] ? lock_acquired+0x310/0x320
 [<6013b5ce>] ? would_dump+0x0/0x8a
 [<600798fd>] down_write_nested+0x2f/0x83
 [<6013def5>] ? begin_new_exec+0x6c5/0xb26
 [<600798ce>] ? down_write_nested+0x0/0x83
 [<6013def5>] begin_new_exec+0x6c5/0xb26
 [<6019593b>] ? load_elf_phdrs+0x6f/0x9d
 [<60298d55>] ? memcmp+0x0/0x20
 [<60196612>] load_elf_binary+0x2cb/0xc49
 [...]

but it really looks just about the same on v5.9-rc8.

> > I guess your patches will also fix the lockdep complaints in UML in this
> > area, I hope I'll be able to test it soon.
> 
> That would be a nice side effect. :)

It does indeed fix it :)

johannes

