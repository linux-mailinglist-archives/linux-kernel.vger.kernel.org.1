Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE592AB418
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgKIJ5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:57:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:58924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbgKIJ5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:57:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604915827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VqUT5Ew7CfjTLxS1jEvJwTPcFd9sn4o8DV646v5yPtc=;
        b=VCgaoZ0kJhYZjJS7lA/1JWoXcu1W2h6+dPzecM6+8QSiZWLWAcXcz0wj91i6ESA5R14uiK
        6BcCUcmP6KBSAaNeNUujbKFa+KmV/Lsp6TiGrZIb6MUJ95o02a6VI58QUeuKS14woeVoZi
        mygd6s15/tKH7B20IAh+aFDHXQ+jc0M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 196FAABAE;
        Mon,  9 Nov 2020 09:57:07 +0000 (UTC)
Subject: Re: possible lockdep regression introduced by 4d004099a668 ("lockdep:
 Fix lockdep recursion")
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, peterz@infradead.org,
        Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        darrick.wong@oracle.com
References: <a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com>
 <20201103140828.GA2713762@boqun-archlinux>
 <283e8f43-91d1-7a19-ed9a-ac6cd13d41ce@suse.com>
 <20201104022236.GA1118860@boqun-archlinux>
 <20201104033914.GA2739173@boqun-archlinux>
 <f8a30ef7-f03b-26d5-21df-f7f8ac373bae@suse.com>
 <7fd90864-a15d-8757-017e-7d73a7d4eac8@suse.com>
 <20201105011012.GB2748545@boqun-archlinux>
 <20201109084410.GA286534@boqun-archlinux>
From:   Filipe Manana <fdmanana@suse.com>
Message-ID: <45b3c967-5ed9-c044-465c-bf442059eb44@suse.com>
Date:   Mon, 9 Nov 2020 09:57:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201109084410.GA286534@boqun-archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/11/20 08:44, Boqun Feng wrote:
> Hi Filipe,
> 
> On Thu, Nov 05, 2020 at 09:10:12AM +0800, Boqun Feng wrote:
>> On Wed, Nov 04, 2020 at 07:54:40PM +0000, Filipe Manana wrote:
>> [...]
>>>
>>> Ok, so I ran 5.10-rc2 plus your two patches (the fix and the debug one):
>>>
>>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>>> index b71ad8d9f1c9..b31d4ad482c7 100644
>>> --- a/kernel/locking/lockdep.c
>>> +++ b/kernel/locking/lockdep.c
>>> @@ -539,8 +539,10 @@ static struct lock_trace *save_trace(void)
>>>                 LOCK_TRACE_SIZE_IN_LONGS;
>>>
>>>         if (max_entries <= 0) {
>>> -               if (!debug_locks_off_graph_unlock())
>>> +               if (!debug_locks_off_graph_unlock()) {
>>> +                       WARN_ON_ONCE(1);
>>>                         return NULL;
>>> +               }
>>>
>>>                 print_lockdep_off("BUG: MAX_STACK_TRACE_ENTRIES too low!");
>>>                 dump_stack();
>>> @@ -5465,7 +5467,7 @@ noinstr int lock_is_held_type(const struct
>>> lockdep_map *lock, int read)
>>>         unsigned long flags;
>>>         int ret = 0;
>>>
>>> -       if (unlikely(!lockdep_enabled()))
>>> +       if (unlikely(debug_locks && !lockdep_enabled()))
>>>                 return 1; /* avoid false negative lockdep_assert_held() */
>>>
>>>         raw_local_irq_save(flags);
>>>
>>> With 3 runs of all fstests, the WARN_ON_ONCE(1) wasn't triggered.
>>> Unexpected, right?
>>>
>>
>> Kinda, that means we still don't know why lockdep was turned off.
>>
>>> Should I try something else?
>>>
>>
>> Thanks for trying this. Let me set up the reproducer on my side, and see
>> if I could get more information.
>>
> 
> I could hit this with btrfs/187, and when we hit it, lockdep will report
> the deadlock and turn off, and I think this is the root cause for your
> hitting the original problem, I will add some analysis after the lockdep
> splat.
> 
> [12295.973309] ============================================
> [12295.974770] WARNING: possible recursive locking detected
> [12295.974770] 5.10.0-rc2-btrfs-next-71 #20 Not tainted
> [12295.974770] --------------------------------------------
> [12295.974770] zsh/701247 is trying to acquire lock:
> [12295.974770] ffff92cef43480b8 (&eb->lock){++++}-{2:2}, at: btrfs_tree_read_lock_atomic+0x34/0x140 [btrfs]
> [12295.974770] 
>                but task is already holding lock:
> [12295.974770] ffff92cef434a038 (&eb->lock){++++}-{2:2}, at: btrfs_tree_read_lock_atomic+0x34/0x140 [btrfs]
> [12295.974770] 
>                other info that might help us debug this:
> [12295.974770]  Possible unsafe locking scenario:
> 
> [12295.974770]        CPU0
> [12295.974770]        ----
> [12295.974770]   lock(&eb->lock);
> [12295.974770]   lock(&eb->lock);
> [12295.974770] 
>                 *** DEADLOCK ***
> 
> [12295.974770]  May be due to missing lock nesting notation
> 
> [12295.974770] 2 locks held by zsh/701247:
> [12295.974770]  #0: ffff92cef3d315b0 (&sig->cred_guard_mutex){+.+.}-{3:3}, at: bprm_execve+0xaa/0x920
> [12295.974770]  #1: ffff92cef434a038 (&eb->lock){++++}-{2:2}, at: btrfs_tree_read_lock_atomic+0x34/0x140 [btrfs]
> [12295.974770] 
>                stack backtrace:
> [12295.974770] CPU: 6 PID: 701247 Comm: zsh Not tainted 5.10.0-rc2-btrfs-next-71 #20
> [12295.974770] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.0 12/17/2019
> [12295.974770] Call Trace:
> [12295.974770]  dump_stack+0x8b/0xb0
> [12295.974770]  __lock_acquire.cold+0x175/0x2e9
> [12295.974770]  lock_acquire+0x15b/0x490
> [12295.974770]  ? btrfs_tree_read_lock_atomic+0x34/0x140 [btrfs]
> [12295.974770]  ? read_block_for_search+0xf4/0x350 [btrfs]
> [12295.974770]  _raw_read_lock+0x40/0xa0
> [12295.974770]  ? btrfs_tree_read_lock_atomic+0x34/0x140 [btrfs]
> [12295.974770]  btrfs_tree_read_lock_atomic+0x34/0x140 [btrfs]
> [12295.974770]  btrfs_search_slot+0x6ac/0xca0 [btrfs]
> [12295.974770]  btrfs_lookup_xattr+0x7d/0xd0 [btrfs]
> [12295.974770]  btrfs_getxattr+0x67/0x130 [btrfs]
> [12295.974770]  __vfs_getxattr+0x53/0x70
> [12295.974770]  get_vfs_caps_from_disk+0x68/0x1a0
> [12295.974770]  ? sched_clock_cpu+0x114/0x180
> [12295.974770]  cap_bprm_creds_from_file+0x181/0x6c0
> [12295.974770]  security_bprm_creds_from_file+0x2a/0x40
> [12295.974770]  begin_new_exec+0xf4/0xc40
> [12295.974770]  ? load_elf_phdrs+0x6b/0xb0
> [12295.974770]  load_elf_binary+0x66b/0x1620
> [12295.974770]  ? read_hv_sched_clock_tsc+0x5/0x20
> [12295.974770]  ? sched_clock+0x5/0x10
> [12295.974770]  ? sched_clock_local+0x12/0x80
> [12295.974770]  ? sched_clock_cpu+0x114/0x180
> [12295.974770]  bprm_execve+0x3ce/0x920
> [12295.974770]  do_execveat_common+0x1b0/0x1f0
> [12295.974770]  __x64_sys_execve+0x39/0x50
> [12295.974770]  do_syscall_64+0x33/0x80
> [12295.974770]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [12295.974770] RIP: 0033:0x7f6aaefc13cb
> [12295.974770] Code: 48 3d 00 f0 ff ff 76 e7 f7 d8 64 41 89 00 eb df 0f 1f 80 00 00 00 00 f7 d8 64 41 89 00 eb dc f3 0f 1e fa b8 3b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 4a 0f 00 f7 d8 64 89 01 48
> [12295.974770] RSP: 002b:00007ffd33b54d58 EFLAGS: 00000207 ORIG_RAX: 000000000000003b
> [12295.974770] RAX: ffffffffffffffda RBX: 00007f6aaf28bc88 RCX: 00007f6aaefc13cb
> [12295.974770] RDX: 00007ffd33b5fd98 RSI: 00007f6aaf28bc88 RDI: 00007ffd33b55280
> [12295.974770] RBP: 00007ffd33b54d80 R08: 00007ffd33b54ce0 R09: 0000000000000001
> [12295.974770] R10: 0000000000000008 R11: 0000000000000207 R12: 00007ffd33b55280
> 
> The deadlock senario reported by this splat is as follow:
> 
> 	CPU 0					CPU 2
> 	=====					=====
> 	btrfs_search_slot():
> 	  btrfs_tree_read_lock_atomic():
> 	    read_lock(&eb->lock);		<a random writer>
> 						write_lock(&eb->lock);
> 						// waiting for the lock
> 	  ...
> 	  btrfs_tree_read_lock_atomic():
> 	    read_lock(&eb->lock); // blocked because the fairness.
> 
> In short, you can not use nested read_lock() on the same lock. However,
> I'm not sure whether we have the real problem here, because I don't
> think btrfs_search_slot() can pick the same extent buffer twice in
> btrfs_search_slot(). Also copy the author of the code for more
> information.

Ah yes. We have several lockdep splats for which the fixes are not in
5.10-rcs yet. Some may be already in the integration branch [1] and
others not yet in any tree, but can be found in the btrfs mailing list.

For that particular one, it's fixed by the following patch:

https://lore.kernel.org/linux-btrfs/1cee2922a32c305056a9559ccf7aede49777beae.1604591048.git.josef@toxicpanda.com/

(It belongs to a series)

You'll likely see more different lockdep splats, this is due to a
transition from custom btree locks to rw semaphores that is in progress,
and some preparatory work for that is already in 5.10-rcs.

Btw, I could hit the fs freeze deadlock even when lockdep didn't produce
any previous splat.

Jan was hitting it too with ext4, and Darrick with xfs - though I can't
tell if they hit any lockdep splat before hitting the freeze deadlock.

Thanks for reporting it.

[1] https://github.com/kdave/btrfs-devel/commits/misc-next

> 
> Regards,
> Boqun
> 
>> Regards,
>> Boqun
>>
>>> Thanks.
>>>
>>>
> 
