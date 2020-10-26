Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160B8298C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 12:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773790AbgJZL0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 07:26:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:49252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1773761AbgJZL0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 07:26:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603711610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jvjWuxh1rJEFJZVLVpImzX0aYv344XBeVk5if5mZwXM=;
        b=MQo0xXqTGIT4cQPVjeQuE4i1Lfz91bgQjv8yduRJI/rYkMkyOpWGbgYRnZfyuwArNyCkwR
        VaNWu7388AU3a6a/UKrN951e88GZcyEPRwn9u+4DgGdOeyQd1nKKqEh1rFLueApw1aTe+W
        /fBKLZsA6GjJl+a92tuj1l+8ZDrucRc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4AF87AC98;
        Mon, 26 Oct 2020 11:26:50 +0000 (UTC)
From:   Filipe Manana <fdmanana@suse.com>
Subject: possible lockdep regression introduced by 4d004099a668 ("lockdep: Fix
 lockdep recursion")
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     peterz@infradead.org, Jan Kara <jack@suse.cz>,
        David Sterba <dsterba@suse.com>
Message-ID: <a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com>
Date:   Mon, 26 Oct 2020 11:26:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've recently started to hit a warning followed by tasks hanging after
attempts to freeze a filesystem. A git bisection pointed to the
following commit:

commit 4d004099a668c41522242aa146a38cc4eb59cb1e
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Fri Oct 2 11:04:21 2020 +0200

    lockdep: Fix lockdep recursion

This happens very reliably when running all xfstests with lockdep
enabled, and the tested filesystem is btrfs (haven't tried other
filesystems, but it shouldn't matter). The warning and task hangs always
happen at either test generic/068 or test generic/390, and (oddly)
always have to run all tests for it to trigger, running those tests
individually on an infinite loop doesn't seem to trigger it (at least
for a couple hours).

The warning triggered is at fs/super.c:__sb_start_write() which always
results later in several tasks hanging on a percpu rw_sem:

https://pastebin.com/qnLvf94E

What happens is percpu_rwsem_is_held() is apparently returning a false
positive, so this makes __sb_start_write() do a
percpu_down_read_trylock() on a percpu_rw_sem at a higher level, which
is expected to always succeed, because if the calling task is holding a
freeze percpu_rw_sem at level 1, it's supposed to be able to try_lock
the semaphore at level 2, since the freeze semaphores are always
acquired by increasing level order.

But the try_lock fails, it triggers the warning at __sb_start_write(),
then its caller sb_start_pagefault() ignores the return value and
callers such as btrfs_page_mkwrite() make the assumption the freeze
semaphore was taken, proceed to do their stuff, and later call
sb_end_pagefault(), which which will do an up_read() on the percpu_rwsem
at level 2 despite not having not been able to down_read() the
semaphore. This obviously corrupts the semaphore's read_count state, and
later causes any task trying to down_write() it to hang forever.

After such a hang I ran a drgn script to confirm it:

$ cat dump_freeze_sems.py
import sys
import drgn
from drgn import NULL, Object, cast, container_of, execscript, \
    reinterpret, sizeof
from drgn.helpers.linux import *

mnt_path = b'/home/fdmanana/btrfs-tests/scratch_1'

mnt = None
for mnt in for_each_mount(prog, dst = mnt_path):
    pass

if mnt is None:
    sys.stderr.write(f'Error: mount point {mnt_path} not found\n')
    sys.exit(1)

def dump_sem(level_enum):
    level = level_enum.value_()
    sem = mnt.mnt.mnt_sb.s_writers.rw_sem[level - 1]
    print(f'freeze semaphore at level {level}, {str(level_enum)}')
    print(f'    block {sem.block.counter.value_()}')
    for i in for_each_possible_cpu(prog):
        read_count = per_cpu_ptr(sem.read_count, i)
        print(f'    read_count at cpu {i} = {read_count}')
    print()

# dump semaphore read counts for all freeze levels (fs.h)
dump_sem(prog['SB_FREEZE_WRITE'])
dump_sem(prog['SB_FREEZE_PAGEFAULT'])
dump_sem(prog['SB_FREEZE_FS'])


$ drgn dump_freeze_sems.py
freeze semaphore at level 1, (enum <anonymous>)SB_FREEZE_WRITE
    block 1
    read_count at cpu 0 = *(unsigned int *)0xffffc2ec3ee00c74 = 3
    read_count at cpu 1 = *(unsigned int *)0xffffc2ec3f200c74 = 4294967293
    read_count at cpu 2 = *(unsigned int *)0xffffc2ec3f600c74 = 3
    read_count at cpu 3 = *(unsigned int *)0xffffc2ec3fa00c74 = 4294967293

freeze semaphore at level 2, (enum <anonymous>)SB_FREEZE_PAGEFAULT
    block 1
    read_count at cpu 0 = *(unsigned int *)0xffffc2ec3ee00c78 = 0
    read_count at cpu 1 = *(unsigned int *)0xffffc2ec3f200c78 = 4294967295
    read_count at cpu 2 = *(unsigned int *)0xffffc2ec3f600c78 = 0
    read_count at cpu 3 = *(unsigned int *)0xffffc2ec3fa00c78 = 0

freeze semaphore at level 3, (enum <anonymous>)SB_FREEZE_FS
    block 0
    read_count at cpu 0 = *(unsigned int *)0xffffc2ec3ee00c7c = 0
    read_count at cpu 1 = *(unsigned int *)0xffffc2ec3f200c7c = 0
    read_count at cpu 2 = *(unsigned int *)0xffffc2ec3f600c7c = 0
    read_count at cpu 3 = *(unsigned int *)0xffffc2ec3fa00c7c = 0

At levels 1 and 3, read_count sums to 0, so it's fine, but at level 2 it
sums to -1. The system remains like that for hours at least, with no
progress at all.

Is there a known regression with that lockdep commit?
Anything I can do to help debug it in case it's not obvious?

Thanks.
