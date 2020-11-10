Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DF32ACA96
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 02:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbgKJBlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 20:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgKJBlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 20:41:45 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41663C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 17:41:45 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id l2so10071782qkf.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 17:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xbKFwnFDfRjfb+GuzyBf6hy+kwS2BhuryL/Yh/hEVws=;
        b=Bum286xoN0x+Y5rXqJ+gnjuIHJAKR7q/mwbwy0kS5I5ku1xRVmwukhXX0uZEqE0HnH
         WW8LHknIpNobIIKsll4f6eaJh9YCFsbCOsSGCqD1O6480NHhg1CPZgrZxMk3iAt0EtBB
         Bt+bYFJSc7xeQ3aeaph2q3MczmdQSNYBuFlugG+9MEo6ViFsUimdUFo+ufSglCPPc2Qx
         noNtGlLxgcgasAwIi43Mv99Z/hX4lMzTgD4QIBmYZ3XRh+BHmwZlNP6Wm1HL8SORT00W
         YlLeiPtfmS/Db2Uy2GM8GS6SnCF4HXlEYUL40vlh2+4r37gGT7ZmqU7KRof9GXx5AewF
         yVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xbKFwnFDfRjfb+GuzyBf6hy+kwS2BhuryL/Yh/hEVws=;
        b=oj9VaZAiy4QEVUjB3DmVU9FgW1l0O3Ps/fnpS4HuipEdwE1UAU2rCdgL2ugx8Q1TdR
         gstDCLF4KbUU+EQY4ziad2JRFDuEEMcSDOArLGsuP7zsOJBcBogfxipzvu8BK+/fDwlc
         NPnuYoRsDkzcr9xytLSAsYMy8xIQ2wukR10JKv+/UKkSV5k0P/GtuTXZwDRkcfHcG0xh
         dt8n5W7lQxun93cNm5ittl0rBgLnqDvKt/UVPSkq6Gici0IRpT4aWIkem9A5VVGRkAed
         rIL7ueCUaMqrPJNMr+DcajjFYtaGCgqmcNw389TB5fJ146Vs2rP3tBc4HPHqil91+JZy
         UjVQ==
X-Gm-Message-State: AOAM532wBgZzRFP8+mgeWiKfdvvZ3IaD/GwMN94kcsW7etZHSQN+YfQw
        5/DgMBp9sFXVimeXeUA+gWc=
X-Google-Smtp-Source: ABdhPJw3+vh/CjadFQMhmYlZFRDDg3oUeNFKVDD6KAMa+4nwfKrI6uoCgzPLOwYU1xK3CyMGFAOwAQ==
X-Received: by 2002:a37:b483:: with SMTP id d125mr15674637qkf.456.1604972504317;
        Mon, 09 Nov 2020 17:41:44 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id q1sm6901354qti.95.2020.11.09.17.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 17:41:43 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 476EF27C0054;
        Mon,  9 Nov 2020 20:41:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 09 Nov 2020 20:41:43 -0500
X-ME-Sender: <xms:1u-pXxA6KmAAEkYXYSQiasExFV72i1AZAK0iwAMY9lYXKtjRkjLXuQ>
    <xme:1u-pX_g025D3iLDcqvkg5wHQjqWciWdEMxAVtoBedopLJVAuqUeqj7cxGpJtaRJHV
    Ddu6kCEwvfMMkN6TA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudduiedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvefhteeuhfeugeehueehveeghffgffduueeguefhgfeludehvdeugeeiteeu
    ueejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecukf
    hppedufedurddutdejrddugeejrdduvdeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsoh
    hnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhg
    peepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:1u-pX8m17HrjSsrmasGD7-HDEYtE9m0qYxfyaMqdGzntNIb4mXBXeQ>
    <xmx:1u-pX7xoSyrWWEGLrP_n3YPIAsjbSwYFAXeXzC9PdUeDsYWWZ3g_VQ>
    <xmx:1u-pX2REyJOfgGt5d1SN-YguEaSAKTGbt4q7jCLMdv_ubjxkqX-OuA>
    <xmx:1--pX1FD2rkP_vNScQOw0vs2RJ7kpdmnqO64jPXw5K5cDOGuhrhaYA>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 772EB3063081;
        Mon,  9 Nov 2020 20:41:42 -0500 (EST)
Date:   Tue, 10 Nov 2020 09:41:29 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Filipe Manana <fdmanana@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, peterz@infradead.org,
        Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        darrick.wong@oracle.com
Subject: Re: possible lockdep regression introduced by 4d004099a668
 ("lockdep: Fix lockdep recursion")
Message-ID: <20201110014129.GB286534@boqun-archlinux>
References: <a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com>
 <20201103140828.GA2713762@boqun-archlinux>
 <283e8f43-91d1-7a19-ed9a-ac6cd13d41ce@suse.com>
 <20201104022236.GA1118860@boqun-archlinux>
 <20201104033914.GA2739173@boqun-archlinux>
 <f8a30ef7-f03b-26d5-21df-f7f8ac373bae@suse.com>
 <7fd90864-a15d-8757-017e-7d73a7d4eac8@suse.com>
 <20201105011012.GB2748545@boqun-archlinux>
 <20201109084410.GA286534@boqun-archlinux>
 <45b3c967-5ed9-c044-465c-bf442059eb44@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45b3c967-5ed9-c044-465c-bf442059eb44@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 09:57:05AM +0000, Filipe Manana wrote:
> 
> 
> On 09/11/20 08:44, Boqun Feng wrote:
> > Hi Filipe,
> > 
> > On Thu, Nov 05, 2020 at 09:10:12AM +0800, Boqun Feng wrote:
> >> On Wed, Nov 04, 2020 at 07:54:40PM +0000, Filipe Manana wrote:
> >> [...]
> >>>
> >>> Ok, so I ran 5.10-rc2 plus your two patches (the fix and the debug one):
> >>>
> >>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> >>> index b71ad8d9f1c9..b31d4ad482c7 100644
> >>> --- a/kernel/locking/lockdep.c
> >>> +++ b/kernel/locking/lockdep.c
> >>> @@ -539,8 +539,10 @@ static struct lock_trace *save_trace(void)
> >>>                 LOCK_TRACE_SIZE_IN_LONGS;
> >>>
> >>>         if (max_entries <= 0) {
> >>> -               if (!debug_locks_off_graph_unlock())
> >>> +               if (!debug_locks_off_graph_unlock()) {
> >>> +                       WARN_ON_ONCE(1);
> >>>                         return NULL;
> >>> +               }
> >>>
> >>>                 print_lockdep_off("BUG: MAX_STACK_TRACE_ENTRIES too low!");
> >>>                 dump_stack();
> >>> @@ -5465,7 +5467,7 @@ noinstr int lock_is_held_type(const struct
> >>> lockdep_map *lock, int read)
> >>>         unsigned long flags;
> >>>         int ret = 0;
> >>>
> >>> -       if (unlikely(!lockdep_enabled()))
> >>> +       if (unlikely(debug_locks && !lockdep_enabled()))
> >>>                 return 1; /* avoid false negative lockdep_assert_held() */
> >>>
> >>>         raw_local_irq_save(flags);
> >>>
> >>> With 3 runs of all fstests, the WARN_ON_ONCE(1) wasn't triggered.
> >>> Unexpected, right?
> >>>
> >>
> >> Kinda, that means we still don't know why lockdep was turned off.
> >>
> >>> Should I try something else?
> >>>
> >>
> >> Thanks for trying this. Let me set up the reproducer on my side, and see
> >> if I could get more information.
> >>
> > 
> > I could hit this with btrfs/187, and when we hit it, lockdep will report
> > the deadlock and turn off, and I think this is the root cause for your
> > hitting the original problem, I will add some analysis after the lockdep
> > splat.
> > 
> > [12295.973309] ============================================
> > [12295.974770] WARNING: possible recursive locking detected
> > [12295.974770] 5.10.0-rc2-btrfs-next-71 #20 Not tainted
> > [12295.974770] --------------------------------------------
> > [12295.974770] zsh/701247 is trying to acquire lock:
> > [12295.974770] ffff92cef43480b8 (&eb->lock){++++}-{2:2}, at: btrfs_tree_read_lock_atomic+0x34/0x140 [btrfs]
> > [12295.974770] 
> >                but task is already holding lock:
> > [12295.974770] ffff92cef434a038 (&eb->lock){++++}-{2:2}, at: btrfs_tree_read_lock_atomic+0x34/0x140 [btrfs]
> > [12295.974770] 
> >                other info that might help us debug this:
> > [12295.974770]  Possible unsafe locking scenario:
> > 
> > [12295.974770]        CPU0
> > [12295.974770]        ----
> > [12295.974770]   lock(&eb->lock);
> > [12295.974770]   lock(&eb->lock);
> > [12295.974770] 
> >                 *** DEADLOCK ***
> > 
> > [12295.974770]  May be due to missing lock nesting notation
> > 
> > [12295.974770] 2 locks held by zsh/701247:
> > [12295.974770]  #0: ffff92cef3d315b0 (&sig->cred_guard_mutex){+.+.}-{3:3}, at: bprm_execve+0xaa/0x920
> > [12295.974770]  #1: ffff92cef434a038 (&eb->lock){++++}-{2:2}, at: btrfs_tree_read_lock_atomic+0x34/0x140 [btrfs]
> > [12295.974770] 
> >                stack backtrace:
> > [12295.974770] CPU: 6 PID: 701247 Comm: zsh Not tainted 5.10.0-rc2-btrfs-next-71 #20
> > [12295.974770] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.0 12/17/2019
> > [12295.974770] Call Trace:
> > [12295.974770]  dump_stack+0x8b/0xb0
> > [12295.974770]  __lock_acquire.cold+0x175/0x2e9
> > [12295.974770]  lock_acquire+0x15b/0x490
> > [12295.974770]  ? btrfs_tree_read_lock_atomic+0x34/0x140 [btrfs]
> > [12295.974770]  ? read_block_for_search+0xf4/0x350 [btrfs]
> > [12295.974770]  _raw_read_lock+0x40/0xa0
> > [12295.974770]  ? btrfs_tree_read_lock_atomic+0x34/0x140 [btrfs]
> > [12295.974770]  btrfs_tree_read_lock_atomic+0x34/0x140 [btrfs]
> > [12295.974770]  btrfs_search_slot+0x6ac/0xca0 [btrfs]
> > [12295.974770]  btrfs_lookup_xattr+0x7d/0xd0 [btrfs]
> > [12295.974770]  btrfs_getxattr+0x67/0x130 [btrfs]
> > [12295.974770]  __vfs_getxattr+0x53/0x70
> > [12295.974770]  get_vfs_caps_from_disk+0x68/0x1a0
> > [12295.974770]  ? sched_clock_cpu+0x114/0x180
> > [12295.974770]  cap_bprm_creds_from_file+0x181/0x6c0
> > [12295.974770]  security_bprm_creds_from_file+0x2a/0x40
> > [12295.974770]  begin_new_exec+0xf4/0xc40
> > [12295.974770]  ? load_elf_phdrs+0x6b/0xb0
> > [12295.974770]  load_elf_binary+0x66b/0x1620
> > [12295.974770]  ? read_hv_sched_clock_tsc+0x5/0x20
> > [12295.974770]  ? sched_clock+0x5/0x10
> > [12295.974770]  ? sched_clock_local+0x12/0x80
> > [12295.974770]  ? sched_clock_cpu+0x114/0x180
> > [12295.974770]  bprm_execve+0x3ce/0x920
> > [12295.974770]  do_execveat_common+0x1b0/0x1f0
> > [12295.974770]  __x64_sys_execve+0x39/0x50
> > [12295.974770]  do_syscall_64+0x33/0x80
> > [12295.974770]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [12295.974770] RIP: 0033:0x7f6aaefc13cb
> > [12295.974770] Code: 48 3d 00 f0 ff ff 76 e7 f7 d8 64 41 89 00 eb df 0f 1f 80 00 00 00 00 f7 d8 64 41 89 00 eb dc f3 0f 1e fa b8 3b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 4a 0f 00 f7 d8 64 89 01 48
> > [12295.974770] RSP: 002b:00007ffd33b54d58 EFLAGS: 00000207 ORIG_RAX: 000000000000003b
> > [12295.974770] RAX: ffffffffffffffda RBX: 00007f6aaf28bc88 RCX: 00007f6aaefc13cb
> > [12295.974770] RDX: 00007ffd33b5fd98 RSI: 00007f6aaf28bc88 RDI: 00007ffd33b55280
> > [12295.974770] RBP: 00007ffd33b54d80 R08: 00007ffd33b54ce0 R09: 0000000000000001
> > [12295.974770] R10: 0000000000000008 R11: 0000000000000207 R12: 00007ffd33b55280
> > 
> > The deadlock senario reported by this splat is as follow:
> > 
> > 	CPU 0					CPU 2
> > 	=====					=====
> > 	btrfs_search_slot():
> > 	  btrfs_tree_read_lock_atomic():
> > 	    read_lock(&eb->lock);		<a random writer>
> > 						write_lock(&eb->lock);
> > 						// waiting for the lock
> > 	  ...
> > 	  btrfs_tree_read_lock_atomic():
> > 	    read_lock(&eb->lock); // blocked because the fairness.
> > 
> > In short, you can not use nested read_lock() on the same lock. However,
> > I'm not sure whether we have the real problem here, because I don't
> > think btrfs_search_slot() can pick the same extent buffer twice in
> > btrfs_search_slot(). Also copy the author of the code for more
> > information.
> 
> Ah yes. We have several lockdep splats for which the fixes are not in
> 5.10-rcs yet. Some may be already in the integration branch [1] and
> others not yet in any tree, but can be found in the btrfs mailing list.
> 
> For that particular one, it's fixed by the following patch:
> 
> https://lore.kernel.org/linux-btrfs/1cee2922a32c305056a9559ccf7aede49777beae.1604591048.git.josef@toxicpanda.com/
> 
> (It belongs to a series)
> 
> You'll likely see more different lockdep splats, this is due to a
> transition from custom btree locks to rw semaphores that is in progress,
> and some preparatory work for that is already in 5.10-rcs.
> 

Thanks for the information!

> Btw, I could hit the fs freeze deadlock even when lockdep didn't produce
> any previous splat.
> 

And this is the weird part, which means lockdep get turned off silently.
That probably means there is a bug (either in fs code or lockdep) that
we don't know, and my previous "fix" although works as per your testing,
but it may hide the real problem...

So I just send out another fix, which is similar to my previous one, but
leave a warning so that once we hit the problem we can be warned and not
miss the silent lockdep turn-off.

Regards,
Boqun

> Jan was hitting it too with ext4, and Darrick with xfs - though I can't
> tell if they hit any lockdep splat before hitting the freeze deadlock.
> 
> Thanks for reporting it.
> 
> [1] https://github.com/kdave/btrfs-devel/commits/misc-next
> 
> > 
> > Regards,
> > Boqun
> > 
> >> Regards,
> >> Boqun
> >>
> >>> Thanks.
> >>>
> >>>
> > 
