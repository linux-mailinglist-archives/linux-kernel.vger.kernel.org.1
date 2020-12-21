Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F312E0159
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 20:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgLUT5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 14:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgLUT5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 14:57:37 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCC1C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 11:56:56 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id n42so3960071ota.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 11:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=jpHcMUzJVHFVPi7Akq8Eh5lxIGBqQFzRb10DQ8flvLM=;
        b=FUJnouETvOQvu6x4uMT8uhuW+dO5NkiYc/o0F7sMwcDbGoLpHztp+QsYVFmUr6ERSk
         R7hunmLdkVroIhH1KdRKJNGaObn+P0RJ6IMzS4Se2VQPBcxJDRa0jp/vCgNRPhUoJwbC
         2a6XtqPxxmmy69L+uK8tH1PuZFb7JRXlPVh21nTHJEG4iHR4onXiQzaYfv61CKwTtjIc
         2Mg+Jm6UBbwGr6Gt1JB5FA+IafQmTskByVX/BmT4ePHfikYzVeH/Eo0PiglQxnJHC1VE
         BgACM2z6wTSsWk6mgY0wbZWY6Aj4w/hi/MBLdccmqURJh74i+35LcZ684ORLGyu5Omiy
         phpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=jpHcMUzJVHFVPi7Akq8Eh5lxIGBqQFzRb10DQ8flvLM=;
        b=dBZGfWnISCIYQwG2KwGnZHUHgfkQmZqNbq0M5j4wGJ8nBRbA22ypzfpNh+po35BaNC
         x+0bYQi5KPqNrw3w/zxw7+M25yoC3n1OwjamLJ3JA9pV1ETRl8G6R5Ka2C3yfaoQV7ju
         JMQ6FK9dOaejYRSfq2JsqQx+zy65XOrGgP9y1DB4xJdgHVbB670ESWf9qKKMwgF2HMUE
         SlcI7uQXrm/7WBNONrf94kiRAx6KnnGZmMl+g7KkRvkvWlmZUIYyLmI5quXRmjxtV5Xt
         iUbk24E4+dTaiXx56uhKnAbl60fQZ1AslF3MJKmKm+ulJuQ301ql1pDv3fQOtTS+5lfN
         yWXw==
X-Gm-Message-State: AOAM530bKFQz+RIrBYnGzTesdzcTkVbl4ive6JUfTsGSLIrfMZVWb4pS
        xHzDVv14Fu8vIDOJT8YxO/7mYA==
X-Google-Smtp-Source: ABdhPJwBsr2jO6BB7ToOqlk5aNb4NrXv6AlU6uxH2uR1D0yGlRoNZqwKbVcD0qQLdXJATCzFRiaEuA==
X-Received: by 2002:a05:6830:8c:: with SMTP id a12mr13146138oto.167.1608580612880;
        Mon, 21 Dec 2020 11:56:52 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v13sm3884112ook.13.2020.12.21.11.56.51
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 21 Dec 2020 11:56:52 -0800 (PST)
Date:   Mon, 21 Dec 2020 11:56:36 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     syzbot <syzbot+e5a33e700b1dd0da20a2@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: INFO: task can't die in shrink_inactive_list (2)
In-Reply-To: <20201123195452.8ecd01b1fc2ce287dfd6a0d5@linux-foundation.org>
Message-ID: <alpine.LSU.2.11.2012211128480.2302@eggly.anvils>
References: <0000000000000340a105b49441d3@google.com> <20201123195452.8ecd01b1fc2ce287dfd6a0d5@linux-foundation.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020, Andrew Morton wrote:
> On Fri, 20 Nov 2020 17:55:22 -0800 syzbot <syzbot+e5a33e700b1dd0da20a2@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    03430750 Add linux-next specific files for 20201116
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13f80e5e500000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a1c4c3f27041fdb8
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e5a33e700b1dd0da20a2
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f7bc5a500000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10934cf2500000
> 
> Alex, your series "per memcg lru lock" changed the vmscan code rather a
> lot.  Could you please take a look at that reproducer?

Andrew, I promised I'd take a look at this syzreport too (though I think
we're agreed by now that it has nothing to do with per-memcg lru_lock).

I did try, but (unlike Alex) did not manage to get the reproducer to
reproduce it.  No doubt I did not try hard enough: I did rather lose
interest after seeing that it appears to involve someone with
CAP_SYS_ADMIN doing an absurdly large ioctl(BLKFRASET) on /dev/nullb0
("Null test block driver" enabled via CONFIG_BLK_DEV_NULL_BLK=y: that I
did enable) and faulting from it: presumably triggering an absurd amount
of readahead.

Cc'ing Matthew since he has a particular interest in readahead, and
might be inspired to make some small safe change that would fix this,
and benefit realistic cases too; but on the whole it didn't look worth
worrying about - or at least not by me.

Hugh

> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+e5a33e700b1dd0da20a2@syzkaller.appspotmail.com
> > 
> > INFO: task syz-executor880:8534 can't die for more than 143 seconds.
> > task:syz-executor880 state:R  running task     stack:25304 pid: 8534 ppid:  8504 flags:0x00004006
> > Call Trace:
> >  context_switch kernel/sched/core.c:4269 [inline]
> >  __schedule+0x890/0x2030 kernel/sched/core.c:5019
> >  preempt_schedule_common+0x45/0xc0 kernel/sched/core.c:5179
> >  preempt_schedule_thunk+0x16/0x18 arch/x86/entry/thunk_64.S:40
> >  __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:169 [inline]
> >  _raw_spin_unlock_irq+0x3c/0x40 kernel/locking/spinlock.c:199
> >  spin_unlock_irq include/linux/spinlock.h:404 [inline]
> >  shrink_inactive_list+0x4b1/0xce0 mm/vmscan.c:1974
> >  shrink_list mm/vmscan.c:2167 [inline]
> >  shrink_lruvec+0x61b/0x11b0 mm/vmscan.c:2462
> >  shrink_node_memcgs mm/vmscan.c:2650 [inline]
> >  shrink_node+0x839/0x1d60 mm/vmscan.c:2767
> >  shrink_zones mm/vmscan.c:2970 [inline]
> >  do_try_to_free_pages+0x38b/0x1440 mm/vmscan.c:3025
> >  try_to_free_pages+0x29f/0x720 mm/vmscan.c:3264
> >  __perform_reclaim mm/page_alloc.c:4360 [inline]
> >  __alloc_pages_direct_reclaim mm/page_alloc.c:4381 [inline]
> >  __alloc_pages_slowpath.constprop.0+0x917/0x2510 mm/page_alloc.c:4785
> >  __alloc_pages_nodemask+0x5f0/0x730 mm/page_alloc.c:4995
> >  alloc_pages_current+0x191/0x2a0 mm/mempolicy.c:2271
> >  alloc_pages include/linux/gfp.h:547 [inline]
> >  __page_cache_alloc mm/filemap.c:977 [inline]
> >  __page_cache_alloc+0x2ce/0x360 mm/filemap.c:962
> >  page_cache_ra_unbounded+0x3a1/0x920 mm/readahead.c:216
> >  do_page_cache_ra+0xf9/0x140 mm/readahead.c:267
> >  do_sync_mmap_readahead mm/filemap.c:2721 [inline]
> >  filemap_fault+0x19d0/0x2940 mm/filemap.c:2809
> >  __do_fault+0x10d/0x4d0 mm/memory.c:3623
> >  do_shared_fault mm/memory.c:4071 [inline]
> >  do_fault mm/memory.c:4149 [inline]
> >  handle_pte_fault mm/memory.c:4385 [inline]
> >  __handle_mm_fault mm/memory.c:4520 [inline]
> >  handle_mm_fault+0x3033/0x55d0 mm/memory.c:4618
> >  do_user_addr_fault+0x55b/0xba0 arch/x86/mm/fault.c:1377
> >  handle_page_fault arch/x86/mm/fault.c:1434 [inline]
> >  exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1490
> >  asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:580
> > RIP: 0033:0x400e71
> > Code: Unable to access opcode bytes at RIP 0x400e47.
> > RSP: 002b:00007f8a5353fdc0 EFLAGS: 00010246
> > RAX: 6c756e2f7665642f RBX: 00000000006dbc38 RCX: 0000000000402824
> > RDX: 928195da81441750 RSI: 0000000000000000 RDI: 00000000006dbc30
> > RBP: 00000000006dbc30 R08: 0000000000000000 R09: 00007f8a53540700
> > R10: 00007f8a535409d0 R11: 0000000000000202 R12: 00000000006dbc3c
> > R13: 00007ffe80747a5f R14: 00007f8a535409c0 R15: 0000000000000001
> > 
> > Showing all locks held in the system:
> > 1 lock held by khungtaskd/1659:
> >  #0: ffffffff8b339ce0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6252
> > 1 lock held by kswapd0/2195:
> > 1 lock held by kswapd1/2196:
> > 1 lock held by in:imklog/8191:
> >  #0: ffff8880125b1270 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:932
> > 1 lock held by cron/8189:
> > 2 locks held by syz-executor880/8502:
> > 2 locks held by syz-executor880/8505:
> > 2 locks held by syz-executor880/8507:
> > 2 locks held by syz-executor880/11706:
> > 2 locks held by syz-executor880/11709:
> > 3 locks held by syz-executor880/12008:
> > 2 locks held by syz-executor880/12015:
> > 
> > =============================================
> > 
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > syzbot can test patches for this issue, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
