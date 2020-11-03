Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F992A4756
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 15:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgKCOKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 09:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729508AbgKCOJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:09:25 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6061EC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 06:09:25 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id n63so6098668qte.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 06:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MdB11KsZ9kb3QT0CE4efS+SKgKC9dAMzdAa5Mt8uTP4=;
        b=qQih5dfA8aeh28xOv4figzxjDNauGjngrewXbXtDS2d78iT+kmz0SsKz7Fl3bv7twF
         S2Zd/qjv39he5ujkJnIWPLCeIFGjezlsCF27bG+97pqqslcCrzqpeZYYyina1vOSNM0y
         ZUNOkFhjFJByqofgee+obb4+FGDSDktqfHNJo23nPWPALftytwt+w4oS+QZjbakOLqlU
         JNVpnAd42ko7N+de91PL1aut9gNzuKz/2eUwLnVl1RCF4h2brM2VZNDrh2UWtgeopAO0
         v6v8EXUIOLCAEQrkK3FmVaju4CP3O/UPkSfx1qcYdsXhY8M7Vyo3xzV24s3LjaPdhXID
         xkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MdB11KsZ9kb3QT0CE4efS+SKgKC9dAMzdAa5Mt8uTP4=;
        b=qhmm2M5HSlVEff0C+Svjz8z7KT4W3quRS99gbnpCQGIYp6xgS6AlZd5FqgbZt+oNsU
         8nlFoeXLVlOxZuqFkmcrA6U0EhI7eT8qrEoOkc4HBaR6guZQ1p1S0OZDsLF4z5rxM19n
         0Be1idng5DuFfSRskBSiISfTXY4Q7seSYJxcR+hp0Bw6V9cjYDx+rbpXQXKHS2n3bhMU
         YJPJIDAfS6fV4CqdP42xfI64vlO12IcADJjYTdqn46cAQtTDgBYJqD8N75J1fCgynQDr
         xn3yfAB5w7r5pH6GdFaINq2d/WxN+q/DMPF0mSZTaiTCzXnb41P/OgtNCvjDqHrP6v72
         0M5g==
X-Gm-Message-State: AOAM532HKFZqL2CYBzuJsffgZEmGJUNSUdLjjlUhj7tBNDsBlP+9Xb1n
        QD68s/Vjqp+ZO+LBXr03VkM=
X-Google-Smtp-Source: ABdhPJyfXiE2s1N4B792n6mU9ybY8NvK/eFNuQMHPTc8qdBsA2l6ZfW8Q+ovHDIqbTK+Ou5Nb6F8mg==
X-Received: by 2002:aed:2685:: with SMTP id q5mr3943177qtd.151.1604412564558;
        Tue, 03 Nov 2020 06:09:24 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id n7sm10067485qtp.93.2020.11.03.06.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2020 06:09:23 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 67C0327C0054;
        Tue,  3 Nov 2020 09:09:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 03 Nov 2020 09:09:22 -0500
X-ME-Sender: <xms:kWShXykEstgNT_gFqJIh9oDI-0FtomDGnZQqObNgOXFGgmZZTkxo_g>
    <xme:kWShX523St9qhLWyHl7YKHFaB3uXaVhcEpMScgUk3PlPnw0PUKWO7lFhyL3x9ZsPo
    x9iievR4QcNx967BA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtfedgheekucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:kWShXwqU45VUbeMXk770W4VrtkDQfkE2Nk-DUrBFVN0aH9kK4qgoRw>
    <xmx:kWShX2lwArMJi4eU83K8N-xen8Gyl6N80xItJpL_WE1eqBRl0V7qVA>
    <xmx:kWShXw33F1SEtAvk3qWuZKWEAnDxujSQPLoTd8XWutlfRUJsDQBMkA>
    <xmx:kmShXzTlCQMW0Ha8skLFwrLpLVRt5hTCU_BPWCeDC3mftdbBiB0ALw>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 915063064674;
        Tue,  3 Nov 2020 09:09:21 -0500 (EST)
Date:   Tue, 3 Nov 2020 22:08:28 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Filipe Manana <fdmanana@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, peterz@infradead.org,
        Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: possible lockdep regression introduced by 4d004099a668
 ("lockdep: Fix lockdep recursion")
Message-ID: <20201103140828.GA2713762@boqun-archlinux>
References: <a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Filipe,

On Mon, Oct 26, 2020 at 11:26:49AM +0000, Filipe Manana wrote:
> Hello,
> 
> I've recently started to hit a warning followed by tasks hanging after
> attempts to freeze a filesystem. A git bisection pointed to the
> following commit:
> 
> commit 4d004099a668c41522242aa146a38cc4eb59cb1e
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Fri Oct 2 11:04:21 2020 +0200
> 
>     lockdep: Fix lockdep recursion
> 
> This happens very reliably when running all xfstests with lockdep
> enabled, and the tested filesystem is btrfs (haven't tried other
> filesystems, but it shouldn't matter). The warning and task hangs always
> happen at either test generic/068 or test generic/390, and (oddly)
> always have to run all tests for it to trigger, running those tests
> individually on an infinite loop doesn't seem to trigger it (at least
> for a couple hours).
> 
> The warning triggered is at fs/super.c:__sb_start_write() which always
> results later in several tasks hanging on a percpu rw_sem:
> 
> https://pastebin.com/qnLvf94E
> 

In your dmesg, I see line:

	[ 9304.920151] INFO: lockdep is turned off.

, that means debug_locks is 0, that usually happens when lockdep find a
problem (i.e. a deadlock) and it turns itself off, because a problem is
found and it's pointless for lockdep to continue to run.

And I haven't found a lockdep splat in your dmesg, do you have a full
dmesg so that I can have a look?

This may be relevant because in commit 4d004099a66, we have

	@@ -5056,13 +5081,13 @@ noinstr int lock_is_held_type(const struct lockdep_map *lock, int read)
		unsigned long flags;
		int ret = 0;

	-       if (unlikely(current->lockdep_recursion))
	+       if (unlikely(!lockdep_enabled()))
			return 1; /* avoid false negative lockdep_assert_held() */

before this commit lock_is_held_type() and its friends may return false
if debug_locks==0, after this commit lock_is_held_type() and its friends
will always return true if debug_locks == 0. That could cause the
behavior here.

In case I'm correct, the following "fix" may be helpful. 

Regards,
Boqun

----------8
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3e99dfef8408..c0e27fb949ff 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5471,7 +5464,7 @@ noinstr int lock_is_held_type(const struct lockdep_map *lock, int read)
 	unsigned long flags;
 	int ret = 0;
 
-	if (unlikely(!lockdep_enabled()))
+	if (unlikely(debug_locks && !lockdep_enabled()))
 		return 1; /* avoid false negative lockdep_assert_held() */
 
 	raw_local_irq_save(flags);



> What happens is percpu_rwsem_is_held() is apparently returning a false
> positive, so this makes __sb_start_write() do a
> percpu_down_read_trylock() on a percpu_rw_sem at a higher level, which
> is expected to always succeed, because if the calling task is holding a
> freeze percpu_rw_sem at level 1, it's supposed to be able to try_lock
> the semaphore at level 2, since the freeze semaphores are always
> acquired by increasing level order.
> 
> But the try_lock fails, it triggers the warning at __sb_start_write(),
> then its caller sb_start_pagefault() ignores the return value and
> callers such as btrfs_page_mkwrite() make the assumption the freeze
> semaphore was taken, proceed to do their stuff, and later call
> sb_end_pagefault(), which which will do an up_read() on the percpu_rwsem
> at level 2 despite not having not been able to down_read() the
> semaphore. This obviously corrupts the semaphore's read_count state, and
> later causes any task trying to down_write() it to hang forever.
> 
> After such a hang I ran a drgn script to confirm it:
> 
> $ cat dump_freeze_sems.py
> import sys
> import drgn
> from drgn import NULL, Object, cast, container_of, execscript, \
>     reinterpret, sizeof
> from drgn.helpers.linux import *
> 
> mnt_path = b'/home/fdmanana/btrfs-tests/scratch_1'
> 
> mnt = None
> for mnt in for_each_mount(prog, dst = mnt_path):
>     pass
> 
> if mnt is None:
>     sys.stderr.write(f'Error: mount point {mnt_path} not found\n')
>     sys.exit(1)
> 
> def dump_sem(level_enum):
>     level = level_enum.value_()
>     sem = mnt.mnt.mnt_sb.s_writers.rw_sem[level - 1]
>     print(f'freeze semaphore at level {level}, {str(level_enum)}')
>     print(f'    block {sem.block.counter.value_()}')
>     for i in for_each_possible_cpu(prog):
>         read_count = per_cpu_ptr(sem.read_count, i)
>         print(f'    read_count at cpu {i} = {read_count}')
>     print()
> 
> # dump semaphore read counts for all freeze levels (fs.h)
> dump_sem(prog['SB_FREEZE_WRITE'])
> dump_sem(prog['SB_FREEZE_PAGEFAULT'])
> dump_sem(prog['SB_FREEZE_FS'])
> 
> 
> $ drgn dump_freeze_sems.py
> freeze semaphore at level 1, (enum <anonymous>)SB_FREEZE_WRITE
>     block 1
>     read_count at cpu 0 = *(unsigned int *)0xffffc2ec3ee00c74 = 3
>     read_count at cpu 1 = *(unsigned int *)0xffffc2ec3f200c74 = 4294967293
>     read_count at cpu 2 = *(unsigned int *)0xffffc2ec3f600c74 = 3
>     read_count at cpu 3 = *(unsigned int *)0xffffc2ec3fa00c74 = 4294967293
> 
> freeze semaphore at level 2, (enum <anonymous>)SB_FREEZE_PAGEFAULT
>     block 1
>     read_count at cpu 0 = *(unsigned int *)0xffffc2ec3ee00c78 = 0
>     read_count at cpu 1 = *(unsigned int *)0xffffc2ec3f200c78 = 4294967295
>     read_count at cpu 2 = *(unsigned int *)0xffffc2ec3f600c78 = 0
>     read_count at cpu 3 = *(unsigned int *)0xffffc2ec3fa00c78 = 0
> 
> freeze semaphore at level 3, (enum <anonymous>)SB_FREEZE_FS
>     block 0
>     read_count at cpu 0 = *(unsigned int *)0xffffc2ec3ee00c7c = 0
>     read_count at cpu 1 = *(unsigned int *)0xffffc2ec3f200c7c = 0
>     read_count at cpu 2 = *(unsigned int *)0xffffc2ec3f600c7c = 0
>     read_count at cpu 3 = *(unsigned int *)0xffffc2ec3fa00c7c = 0
> 
> At levels 1 and 3, read_count sums to 0, so it's fine, but at level 2 it
> sums to -1. The system remains like that for hours at least, with no
> progress at all.
> 
> Is there a known regression with that lockdep commit?
> Anything I can do to help debug it in case it's not obvious?
> 
> Thanks.
