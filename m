Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2932A749D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 02:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732911AbgKEBLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 20:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgKEBLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 20:11:14 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D517EC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 17:11:13 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id g19so148340qvy.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 17:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=02n7Ft9A0nmnA9LFLmoER4CNeuPjp1CSJm8N48ZVIN4=;
        b=HlwRMVYBzpYWj856lByxDYF9a18ynuX2KnrTDPP1CmPUDEzbvZGJCt7yrM/NWBzxgp
         o8T63Cu2DbkS7a/5spGECf56MBDrSJvtcgWct2uQ1kL5QkSsH/kwJNLlesn/tGp9BlS7
         Uaqm5+wAAqs9jHS8HNyAVc5+dOrqJlGpMo3uxYD6iYq5jOdH6CbuTAFdHlYn22e2z0Qr
         Su3GNC9BCZD3RSaSE+Ad1GLTIgIFT2rr46CZToEFQ6bbRJizsd1WQgrDMJ/37hhnKN5T
         qZIJuCnOzxMzx9Z7ndTqHgeHw6QK6DSJnJankhLYjOC/0LaZIl9aY3Jzy9z1KPaza09V
         mRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=02n7Ft9A0nmnA9LFLmoER4CNeuPjp1CSJm8N48ZVIN4=;
        b=hl/07p8AImATw0YZmPWd1FUNfWRl7Qc7M/TbfT94w4CsYpJODMgcFw5LKaktU6KZ1e
         oes1ryHbxrE1vFRFlkuUApEPE1At1yQJvTqj6hWM6UjSR0wv5GsRDwZSmft3acigUnz1
         g0SUHZxFmIm9kzTXN4WClC6mmSR5K4Wt1B2D/uBy0ktFpSuRm1NlgtJ0b17ozjxPpB6c
         DVjCzYC5Kul+YVKik+2NT3pH8/mhrHvsn4JPtFsOUp0LckcPJBHpvFP2IAoFCfwmyAxY
         +mlMpSx+XqG2rsH54fA1I1kaFIi/yN5SqcGUkpTyft/b5GEi/WXdRoFy62BaTh+r2B9Q
         uKTA==
X-Gm-Message-State: AOAM531xrm3ZyXs1me6kRrwo/nmMhr8BHOQfPE+C40za1cvmirbJCKsx
        Du+bS5dNSUhziEb7vEL50RQ=
X-Google-Smtp-Source: ABdhPJzvrq3jsU5NUj48nXjTgNziOTnn8kPntcxz+ai3roYhyHi5shc1m6ST9/ME9iHmaXY0iHelLw==
X-Received: by 2002:ad4:4e6d:: with SMTP id ec13mr561253qvb.41.1604538673094;
        Wed, 04 Nov 2020 17:11:13 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id z125sm5295qke.54.2020.11.04.17.11.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2020 17:11:12 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0F44827C0072;
        Wed,  4 Nov 2020 20:11:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 04 Nov 2020 20:11:11 -0500
X-ME-Sender: <xms:LlGjX1NTe5q-Q7GHAA4OT4MECl3zSFfOgT1iLd8tvK95lZCwjGkDcQ>
    <xme:LlGjX38o2aWWh3HXwocplVCnUG0sxBWcGXO4tdEuqZ-tx9qU9S7ZmLFq9OSV2HiLV
    hfp-8FTPUxeJ9omKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtiedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppeduieejrddvvddtrddvrdduvdeinecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:LlGjX0SwTCb6EjJ_2REN2JAoLBqM0HqMds6fxL9U55M4zEvqcUmjhA>
    <xmx:LlGjXxuRl_C5VJ3EPk61XxfNESbRYLmFNScMhgoIfS82iW55ECD7QA>
    <xmx:LlGjX9fODgg3yg4w3HpsEjNjJVB-TFwNo70SpLxbi-WogODMXcQzvQ>
    <xmx:L1GjX05sx-qDRuW_y9YptDHL0Rxa6VRf_6uBySdtRf2H7H_9BJtqqA>
Received: from localhost (unknown [167.220.2.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id C3D0432801D7;
        Wed,  4 Nov 2020 20:11:09 -0500 (EST)
Date:   Thu, 5 Nov 2020 09:10:12 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Filipe Manana <fdmanana@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, peterz@infradead.org,
        Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: possible lockdep regression introduced by 4d004099a668
 ("lockdep: Fix lockdep recursion")
Message-ID: <20201105011012.GB2748545@boqun-archlinux>
References: <a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com>
 <20201103140828.GA2713762@boqun-archlinux>
 <283e8f43-91d1-7a19-ed9a-ac6cd13d41ce@suse.com>
 <20201104022236.GA1118860@boqun-archlinux>
 <20201104033914.GA2739173@boqun-archlinux>
 <f8a30ef7-f03b-26d5-21df-f7f8ac373bae@suse.com>
 <7fd90864-a15d-8757-017e-7d73a7d4eac8@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fd90864-a15d-8757-017e-7d73a7d4eac8@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 07:54:40PM +0000, Filipe Manana wrote:
[...]
> 
> Ok, so I ran 5.10-rc2 plus your two patches (the fix and the debug one):
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index b71ad8d9f1c9..b31d4ad482c7 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -539,8 +539,10 @@ static struct lock_trace *save_trace(void)
>                 LOCK_TRACE_SIZE_IN_LONGS;
> 
>         if (max_entries <= 0) {
> -               if (!debug_locks_off_graph_unlock())
> +               if (!debug_locks_off_graph_unlock()) {
> +                       WARN_ON_ONCE(1);
>                         return NULL;
> +               }
> 
>                 print_lockdep_off("BUG: MAX_STACK_TRACE_ENTRIES too low!");
>                 dump_stack();
> @@ -5465,7 +5467,7 @@ noinstr int lock_is_held_type(const struct
> lockdep_map *lock, int read)
>         unsigned long flags;
>         int ret = 0;
> 
> -       if (unlikely(!lockdep_enabled()))
> +       if (unlikely(debug_locks && !lockdep_enabled()))
>                 return 1; /* avoid false negative lockdep_assert_held() */
> 
>         raw_local_irq_save(flags);
> 
> With 3 runs of all fstests, the WARN_ON_ONCE(1) wasn't triggered.
> Unexpected, right?
> 

Kinda, that means we still don't know why lockdep was turned off.

> Should I try something else?
> 

Thanks for trying this. Let me set up the reproducer on my side, and see
if I could get more information.

Regards,
Boqun

> Thanks.
> 
> 
> > 
> > Thanks!
> > 
> >>
> >> Alternatively, it's also helpful if you can try the following debug
> >> diff, with teh full set of xfstests:
> >>
> >> Thanks! Just trying to understand the real problem.
> >>
> >> Regards,
> >> Boqun
> >>
> >> -------------->8
> >> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> >> index b71ad8d9f1c9..9ae3e089e5c0 100644
> >> --- a/kernel/locking/lockdep.c
> >> +++ b/kernel/locking/lockdep.c
> >> @@ -539,8 +539,10 @@ static struct lock_trace *save_trace(void)
> >>  		LOCK_TRACE_SIZE_IN_LONGS;
> >>  
> >>  	if (max_entries <= 0) {
> >> -		if (!debug_locks_off_graph_unlock())
> >> +		if (!debug_locks_off_graph_unlock()) {
> >> +			WARN_ON_ONCE(1);
> >>  			return NULL;
> >> +		}
> >>  
> >>  		print_lockdep_off("BUG: MAX_STACK_TRACE_ENTRIES too low!");
> >>  		dump_stack();
> >>
> >>> I guess I will have to reproduce this myself for further analysis, could
> >>> you share you .config?
> >>>
> >>> Anyway, I think this fix still makes a bit sense, I will send a proper
> >>> patch so that the problem won't block fs folks.
> >>>
> >>> Regards,
> >>> Boqun
> >>>
> >>>> Thanks!
> >>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>>> What happens is percpu_rwsem_is_held() is apparently returning a false
> >>>>>> positive, so this makes __sb_start_write() do a
> >>>>>> percpu_down_read_trylock() on a percpu_rw_sem at a higher level, which
> >>>>>> is expected to always succeed, because if the calling task is holding a
> >>>>>> freeze percpu_rw_sem at level 1, it's supposed to be able to try_lock
> >>>>>> the semaphore at level 2, since the freeze semaphores are always
> >>>>>> acquired by increasing level order.
> >>>>>>
> >>>>>> But the try_lock fails, it triggers the warning at __sb_start_write(),
> >>>>>> then its caller sb_start_pagefault() ignores the return value and
> >>>>>> callers such as btrfs_page_mkwrite() make the assumption the freeze
> >>>>>> semaphore was taken, proceed to do their stuff, and later call
> >>>>>> sb_end_pagefault(), which which will do an up_read() on the percpu_rwsem
> >>>>>> at level 2 despite not having not been able to down_read() the
> >>>>>> semaphore. This obviously corrupts the semaphore's read_count state, and
> >>>>>> later causes any task trying to down_write() it to hang forever.
> >>>>>>
> >>>>>> After such a hang I ran a drgn script to confirm it:
> >>>>>>
> >>>>>> $ cat dump_freeze_sems.py
> >>>>>> import sys
> >>>>>> import drgn
> >>>>>> from drgn import NULL, Object, cast, container_of, execscript, \
> >>>>>>     reinterpret, sizeof
> >>>>>> from drgn.helpers.linux import *
> >>>>>>
> >>>>>> mnt_path = b'/home/fdmanana/btrfs-tests/scratch_1'
> >>>>>>
> >>>>>> mnt = None
> >>>>>> for mnt in for_each_mount(prog, dst = mnt_path):
> >>>>>>     pass
> >>>>>>
> >>>>>> if mnt is None:
> >>>>>>     sys.stderr.write(f'Error: mount point {mnt_path} not found\n')
> >>>>>>     sys.exit(1)
> >>>>>>
> >>>>>> def dump_sem(level_enum):
> >>>>>>     level = level_enum.value_()
> >>>>>>     sem = mnt.mnt.mnt_sb.s_writers.rw_sem[level - 1]
> >>>>>>     print(f'freeze semaphore at level {level}, {str(level_enum)}')
> >>>>>>     print(f'    block {sem.block.counter.value_()}')
> >>>>>>     for i in for_each_possible_cpu(prog):
> >>>>>>         read_count = per_cpu_ptr(sem.read_count, i)
> >>>>>>         print(f'    read_count at cpu {i} = {read_count}')
> >>>>>>     print()
> >>>>>>
> >>>>>> # dump semaphore read counts for all freeze levels (fs.h)
> >>>>>> dump_sem(prog['SB_FREEZE_WRITE'])
> >>>>>> dump_sem(prog['SB_FREEZE_PAGEFAULT'])
> >>>>>> dump_sem(prog['SB_FREEZE_FS'])
> >>>>>>
> >>>>>>
> >>>>>> $ drgn dump_freeze_sems.py
> >>>>>> freeze semaphore at level 1, (enum <anonymous>)SB_FREEZE_WRITE
> >>>>>>     block 1
> >>>>>>     read_count at cpu 0 = *(unsigned int *)0xffffc2ec3ee00c74 = 3
> >>>>>>     read_count at cpu 1 = *(unsigned int *)0xffffc2ec3f200c74 = 4294967293
> >>>>>>     read_count at cpu 2 = *(unsigned int *)0xffffc2ec3f600c74 = 3
> >>>>>>     read_count at cpu 3 = *(unsigned int *)0xffffc2ec3fa00c74 = 4294967293
> >>>>>>
> >>>>>> freeze semaphore at level 2, (enum <anonymous>)SB_FREEZE_PAGEFAULT
> >>>>>>     block 1
> >>>>>>     read_count at cpu 0 = *(unsigned int *)0xffffc2ec3ee00c78 = 0
> >>>>>>     read_count at cpu 1 = *(unsigned int *)0xffffc2ec3f200c78 = 4294967295
> >>>>>>     read_count at cpu 2 = *(unsigned int *)0xffffc2ec3f600c78 = 0
> >>>>>>     read_count at cpu 3 = *(unsigned int *)0xffffc2ec3fa00c78 = 0
> >>>>>>
> >>>>>> freeze semaphore at level 3, (enum <anonymous>)SB_FREEZE_FS
> >>>>>>     block 0
> >>>>>>     read_count at cpu 0 = *(unsigned int *)0xffffc2ec3ee00c7c = 0
> >>>>>>     read_count at cpu 1 = *(unsigned int *)0xffffc2ec3f200c7c = 0
> >>>>>>     read_count at cpu 2 = *(unsigned int *)0xffffc2ec3f600c7c = 0
> >>>>>>     read_count at cpu 3 = *(unsigned int *)0xffffc2ec3fa00c7c = 0
> >>>>>>
> >>>>>> At levels 1 and 3, read_count sums to 0, so it's fine, but at level 2 it
> >>>>>> sums to -1. The system remains like that for hours at least, with no
> >>>>>> progress at all.
> >>>>>>
> >>>>>> Is there a known regression with that lockdep commit?
> >>>>>> Anything I can do to help debug it in case it's not obvious?
> >>>>>>
> >>>>>> Thanks.
> >>>>>
> >>
