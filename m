Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686E82F041E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 23:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbhAIWew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 17:34:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:43136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbhAIWew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 17:34:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D729236F9;
        Sat,  9 Jan 2021 22:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1610231651;
        bh=xK4aL4UFZkf+Rlc/E3V46Y+EN/9IVgasA9Hp0Txr0HI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c/FYC6TWuhwL3TCBblORLWBZC/WQURiD4kQv0hQR5atcRQTmD9pP64hIleoWhy7v7
         TviTQUmPN0uWQ4h3fw3cbwKwMxgjGWq8rAti7reeRABaH0e0xuZbiQX5yEq3Krj/wY
         osXxhn3hd5F7SrTzvBAgscfUlb+KHO7tTZ9TYY3Q=
Date:   Sat, 9 Jan 2021 14:34:10 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+5b0d0de84d6c65b8dd2b@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: upstream build error (11)
Message-Id: <20210109143410.eed9923407f73c00535bb450@linux-foundation.org>
In-Reply-To: <CACT4Y+b0-Rw+_aNtGnbwKj7FFM2yKDAsPFO3XP5DnirCRCbbNg@mail.gmail.com>
References: <0000000000001bc23b05b2b6fd8a@google.com>
        <CACT4Y+b0-Rw+_aNtGnbwKj7FFM2yKDAsPFO3XP5DnirCRCbbNg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Jan 2021 21:41:23 +0100 Dmitry Vyukov <dvyukov@google.com> wrote:

> On Wed, Oct 28, 2020 at 9:31 AM syzbot
> <syzbot+5b0d0de84d6c65b8dd2b@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    4d09c1d9 Merge tag 'devicetree-fixes-for-5.10-1' of git://..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1615899c500000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a5c844e56cc50cdb
> > dashboard link: https://syzkaller.appspot.com/bug?extid=5b0d0de84d6c65b8dd2b
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+5b0d0de84d6c65b8dd2b@syzkaller.appspotmail.com
> >
> > mm/process_vm_access.c:277:5: error: implicit declaration of function 'in_compat_syscall'; did you mean 'in_ia32_syscall'? [-Werror=implicit-function-declaration]
> 
> Other build failures are piling behind this.
> 
> #syz fix: mm/process_vm_access: Add missing #include <linux/compat.h>

For some reason I cant reproduce this with that .config, but presumably
this is the fix?


From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm/process_vm_access.c: include compat.h

mm/process_vm_access.c:277:5: error: implicit declaration of function 'in_compat_syscall'; did you mean 'in_ia32_syscall'? [-Werror=implicit-function-declaration]

Fixes: 38dc5079da7081e "Fix compat regression in process_vm_rw()"
Reported-by: syzbot+5b0d0de84d6c65b8dd2b@syzkaller.appspotmail.com
Cc: Kyle Huey <me@kylehuey.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/process_vm_access.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/process_vm_access.c~a
+++ a/mm/process_vm_access.c
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/uio.h>
 #include <linux/sched.h>
+#include <linux/compat.h>
 #include <linux/sched/mm.h>
 #include <linux/highmem.h>
 #include <linux/ptrace.h>
_

