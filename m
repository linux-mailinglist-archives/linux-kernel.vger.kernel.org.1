Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96842A5CAB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 03:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbgKDCX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 21:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbgKDCXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 21:23:55 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7984FC061A4D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 18:23:55 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id z6so17613756qkz.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 18:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kDgxm1T53TPkpE3Yz1F2UbuRvdmfjdEjMI/BglHReuw=;
        b=C5md+tFjODn15o6Pg7gduZBQdiqI0jYG3jn4154+RDBn8A4/kVNMUXoQo+KHGsGW4u
         iF81Vj/cnbMfylflmIRCxhq399ZQpoqfC1Kl13eg4+pxGmmfIrkFWVVQmLYZthMOQMgF
         Sapx0+cr8YM22M9fwchthm2NgRxQNhNuucWPzuc0/s2HHIW/AnLqU903hsRHSIuC4nlD
         gcn4tKNp8ggSfb4DqeENwwf/nQhrcKntLOZM50gQJ+RxJZbvKoKSjXCgEdESjUGu8d8D
         t80U7Ir6F3aAYC2vCSwRoDJDz921hFJJeRk8ZxpbPRo/oHRKUUJHdJsQy1Ud+6gFclPe
         9QYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kDgxm1T53TPkpE3Yz1F2UbuRvdmfjdEjMI/BglHReuw=;
        b=phj+Ox8nB9G/DhutzavLKJsvpTcOxZ1JUbc0I4L4aHtSKImVuoSXJJ+AN0Inq6lc2m
         EI6O2G5WwzW8ehIlXZTqEmDdgg9YhenJWy98EYrFp0M8UtSmtqUBETa5lqjzYbY2f0TT
         OIJyWBYpjnQJda7osGRvja6sn0MGovwu9ZHHv3L7dIcMcRiJG+SFN7a4zVKvGRAElo4A
         K1RlWh0MRe3ELdOjMI7YdywiHrCIYvs/mj2Ord+Yjsv9/IZtMjj60qM1ZdBr9RlEBGEs
         NwjnJW3bH5MpdqpH0SsibHL2kRIYgwypudq2skhkP5HpqeezIEJDgRJhZWlgmqVS5P9i
         ZYmQ==
X-Gm-Message-State: AOAM532A0NEPNINFltgf1GthHWvMwbAUksHURRhcNHCWqv+KigBF60vU
        UcUkO+oxgFL2jZsPMS7BMo4fmCsedgsEbA==
X-Google-Smtp-Source: ABdhPJwJlphzvf/4x4KDL0zaBRTAiANepkcK+oUbTEn7eq1nHe2WsLsiJHMg2W3xlZpQh5HzBZvcNg==
X-Received: by 2002:a05:620a:15b1:: with SMTP id f17mr22163578qkk.54.1604456634681;
        Tue, 03 Nov 2020 18:23:54 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id x22sm852855qkn.125.2020.11.03.18.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2020 18:23:53 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0FE1627C005C;
        Tue,  3 Nov 2020 21:23:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 03 Nov 2020 21:23:53 -0500
X-ME-Sender: <xms:uBCiX0uBn93WtYIge9UOhld4B5wU6bFBTyJRzIAuUCB9m_fHFx_BbQ>
    <xme:uBCiXxeLLS6dgqADqb8uubWKw-_e7xnh872GRIIUrx5BrOctvZing62adeaokd5Mn
    e_lZR-8uDQukLO6yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtgedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepheegveeiteeufeeggfejteeghfekueetteeuleevgedtteegveeugeeutdeh
    iefgnecuffhomhgrihhnpehprghsthgvsghinhdrtghomhenucfkphepudefuddruddtje
    drudegjedruddvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeile
    dvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgt
    ohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:uBCiX_w677aCcJ6LED1F66qX3iCE84xY5vBNLK2zaMvdldXDOTHz4w>
    <xmx:uBCiX3PxDQCUdmVRORMD9vpedGA40mTkGkZ1AygfCnLn2o3gvw4zhw>
    <xmx:uBCiX0_kJBlgYpLyQuI1eFS1BNLk_mLWbZZhqt5kT9Ds0zAIPCqXSQ>
    <xmx:uRCiX4Z52ULPTCYVTAhSWgfiqihXZLOGttdiEamrmbIHn12mgJah4g>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2E74B3064682;
        Tue,  3 Nov 2020 21:23:52 -0500 (EST)
Date:   Wed, 4 Nov 2020 10:22:36 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Filipe Manana <fdmanana@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, peterz@infradead.org,
        Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: possible lockdep regression introduced by 4d004099a668
 ("lockdep: Fix lockdep recursion")
Message-ID: <20201104022236.GA1118860@boqun-archlinux>
References: <a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com>
 <20201103140828.GA2713762@boqun-archlinux>
 <283e8f43-91d1-7a19-ed9a-ac6cd13d41ce@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <283e8f43-91d1-7a19-ed9a-ac6cd13d41ce@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 07:44:29PM +0000, Filipe Manana wrote:
> 
> 
> On 03/11/20 14:08, Boqun Feng wrote:
> > Hi Filipe,
> > 
> > On Mon, Oct 26, 2020 at 11:26:49AM +0000, Filipe Manana wrote:
> >> Hello,
> >>
> >> I've recently started to hit a warning followed by tasks hanging after
> >> attempts to freeze a filesystem. A git bisection pointed to the
> >> following commit:
> >>
> >> commit 4d004099a668c41522242aa146a38cc4eb59cb1e
> >> Author: Peter Zijlstra <peterz@infradead.org>
> >> Date:   Fri Oct 2 11:04:21 2020 +0200
> >>
> >>     lockdep: Fix lockdep recursion
> >>
> >> This happens very reliably when running all xfstests with lockdep
> >> enabled, and the tested filesystem is btrfs (haven't tried other
> >> filesystems, but it shouldn't matter). The warning and task hangs always
> >> happen at either test generic/068 or test generic/390, and (oddly)
> >> always have to run all tests for it to trigger, running those tests
> >> individually on an infinite loop doesn't seem to trigger it (at least
> >> for a couple hours).
> >>
> >> The warning triggered is at fs/super.c:__sb_start_write() which always
> >> results later in several tasks hanging on a percpu rw_sem:
> >>
> >> https://pastebin.com/qnLvf94E
> >>
> > 
> > In your dmesg, I see line:
> > 
> > 	[ 9304.920151] INFO: lockdep is turned off.
> > 
> > , that means debug_locks is 0, that usually happens when lockdep find a
> > problem (i.e. a deadlock) and it turns itself off, because a problem is
> > found and it's pointless for lockdep to continue to run.
> > 
> > And I haven't found a lockdep splat in your dmesg, do you have a full
> > dmesg so that I can have a look?
> > 
> > This may be relevant because in commit 4d004099a66, we have
> > 
> > 	@@ -5056,13 +5081,13 @@ noinstr int lock_is_held_type(const struct lockdep_map *lock, int read)
> > 		unsigned long flags;
> > 		int ret = 0;
> > 
> > 	-       if (unlikely(current->lockdep_recursion))
> > 	+       if (unlikely(!lockdep_enabled()))
> > 			return 1; /* avoid false negative lockdep_assert_held() */
> > 
> > before this commit lock_is_held_type() and its friends may return false
> > if debug_locks==0, after this commit lock_is_held_type() and its friends
> > will always return true if debug_locks == 0. That could cause the
> > behavior here.
> > 
> > In case I'm correct, the following "fix" may be helpful. 
> > 
> > Regards,
> > Boqun
> > 
> > ----------8
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index 3e99dfef8408..c0e27fb949ff 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -5471,7 +5464,7 @@ noinstr int lock_is_held_type(const struct lockdep_map *lock, int read)
> >  	unsigned long flags;
> >  	int ret = 0;
> >  
> > -	if (unlikely(!lockdep_enabled()))
> > +	if (unlikely(debug_locks && !lockdep_enabled()))
> >  		return 1; /* avoid false negative lockdep_assert_held() */
> >  
> >  	raw_local_irq_save(flags);
> 
> Boqun, the patch fixes the problem for me!
> You can have Tested-by: Filipe Manana <fdmanana@suse.com>
> 

Thanks. Although I think it still means that we have a lock issue when
running xfstests (because we don't know why debug_locks gets cleared),
I guess I will have to reproduce this myself for further analysis, could
you share you .config?

Anyway, I think this fix still makes a bit sense, I will send a proper
patch so that the problem won't block fs folks.

Regards,
Boqun

> Thanks!
> 
> > 
> > 
> > 
> >> What happens is percpu_rwsem_is_held() is apparently returning a false
> >> positive, so this makes __sb_start_write() do a
> >> percpu_down_read_trylock() on a percpu_rw_sem at a higher level, which
> >> is expected to always succeed, because if the calling task is holding a
> >> freeze percpu_rw_sem at level 1, it's supposed to be able to try_lock
> >> the semaphore at level 2, since the freeze semaphores are always
> >> acquired by increasing level order.
> >>
> >> But the try_lock fails, it triggers the warning at __sb_start_write(),
> >> then its caller sb_start_pagefault() ignores the return value and
> >> callers such as btrfs_page_mkwrite() make the assumption the freeze
> >> semaphore was taken, proceed to do their stuff, and later call
> >> sb_end_pagefault(), which which will do an up_read() on the percpu_rwsem
> >> at level 2 despite not having not been able to down_read() the
> >> semaphore. This obviously corrupts the semaphore's read_count state, and
> >> later causes any task trying to down_write() it to hang forever.
> >>
> >> After such a hang I ran a drgn script to confirm it:
> >>
> >> $ cat dump_freeze_sems.py
> >> import sys
> >> import drgn
> >> from drgn import NULL, Object, cast, container_of, execscript, \
> >>     reinterpret, sizeof
> >> from drgn.helpers.linux import *
> >>
> >> mnt_path = b'/home/fdmanana/btrfs-tests/scratch_1'
> >>
> >> mnt = None
> >> for mnt in for_each_mount(prog, dst = mnt_path):
> >>     pass
> >>
> >> if mnt is None:
> >>     sys.stderr.write(f'Error: mount point {mnt_path} not found\n')
> >>     sys.exit(1)
> >>
> >> def dump_sem(level_enum):
> >>     level = level_enum.value_()
> >>     sem = mnt.mnt.mnt_sb.s_writers.rw_sem[level - 1]
> >>     print(f'freeze semaphore at level {level}, {str(level_enum)}')
> >>     print(f'    block {sem.block.counter.value_()}')
> >>     for i in for_each_possible_cpu(prog):
> >>         read_count = per_cpu_ptr(sem.read_count, i)
> >>         print(f'    read_count at cpu {i} = {read_count}')
> >>     print()
> >>
> >> # dump semaphore read counts for all freeze levels (fs.h)
> >> dump_sem(prog['SB_FREEZE_WRITE'])
> >> dump_sem(prog['SB_FREEZE_PAGEFAULT'])
> >> dump_sem(prog['SB_FREEZE_FS'])
> >>
> >>
> >> $ drgn dump_freeze_sems.py
> >> freeze semaphore at level 1, (enum <anonymous>)SB_FREEZE_WRITE
> >>     block 1
> >>     read_count at cpu 0 = *(unsigned int *)0xffffc2ec3ee00c74 = 3
> >>     read_count at cpu 1 = *(unsigned int *)0xffffc2ec3f200c74 = 4294967293
> >>     read_count at cpu 2 = *(unsigned int *)0xffffc2ec3f600c74 = 3
> >>     read_count at cpu 3 = *(unsigned int *)0xffffc2ec3fa00c74 = 4294967293
> >>
> >> freeze semaphore at level 2, (enum <anonymous>)SB_FREEZE_PAGEFAULT
> >>     block 1
> >>     read_count at cpu 0 = *(unsigned int *)0xffffc2ec3ee00c78 = 0
> >>     read_count at cpu 1 = *(unsigned int *)0xffffc2ec3f200c78 = 4294967295
> >>     read_count at cpu 2 = *(unsigned int *)0xffffc2ec3f600c78 = 0
> >>     read_count at cpu 3 = *(unsigned int *)0xffffc2ec3fa00c78 = 0
> >>
> >> freeze semaphore at level 3, (enum <anonymous>)SB_FREEZE_FS
> >>     block 0
> >>     read_count at cpu 0 = *(unsigned int *)0xffffc2ec3ee00c7c = 0
> >>     read_count at cpu 1 = *(unsigned int *)0xffffc2ec3f200c7c = 0
> >>     read_count at cpu 2 = *(unsigned int *)0xffffc2ec3f600c7c = 0
> >>     read_count at cpu 3 = *(unsigned int *)0xffffc2ec3fa00c7c = 0
> >>
> >> At levels 1 and 3, read_count sums to 0, so it's fine, but at level 2 it
> >> sums to -1. The system remains like that for hours at least, with no
> >> progress at all.
> >>
> >> Is there a known regression with that lockdep commit?
> >> Anything I can do to help debug it in case it's not obvious?
> >>
> >> Thanks.
> > 
