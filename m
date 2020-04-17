Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49ED31AD389
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 02:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgDQAMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 20:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726507AbgDQAMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 20:12:17 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24A9C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 17:12:15 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k133so555194oih.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 17:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=weS8ut8MyVdtR/8doQhR0Yj9vQW+AHpAC1tZDODgP9A=;
        b=jV/Am+Kry4hgFkIjG1xx/9ispjIuh+h4eGTkndY8rZ3lBXukhWlinYgu4EUeJ+cpMl
         VMhjMhwgHz2rR3TTF5lJpS8iqxsgBLpNn1UK7ukvxSIpgRtZYPAgXaVl58hAjJocch8W
         GoLWfHBNXdTD1WUrSkOy4ChIc9ZEPreaZkjUEWsyC/a5NljzoMxKY1msUZz1T81ZioTa
         KAX/DjTLb7dsmXx4e5fIO6IG8AcnQvsw3LGV0EvXoFWmvzexT9qeyeUYCQsYRariLDoU
         UWl5DkXLfJdBki9IEjJZnfFYmpPchJBfE6afrLtEzBVLv/ijXCVcV3eE42qEJBKCy3KG
         2b/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=weS8ut8MyVdtR/8doQhR0Yj9vQW+AHpAC1tZDODgP9A=;
        b=aqwLlzhusQwUYuxFn2zY1zUpyOXstw/TvJnMORBVh1LIYWRgifZ2GJsfIo9q5FkvS2
         NocHH1ooNDEGvFsdSnFqv4HCQdwhMldh/zN5Ev23W17+tAR2ycZKy/nuG8KCl0xpucSS
         8ujqs0SCCV1YOK5HihjldYkAx2/zQaEGN+ekpxwVE53Hyyc9fPA/1FmBpta63UiP/JgZ
         8zxMJL3u8bVWlhtyk0IdKBzwQufDXD8HAoB9NRMZSU+GVkJScJnCB6aNDPldK6WMkDt6
         Ihk/CfamXNauhdoTDmVka7CAg5jmLjdk4HBanCxRRfFuSt9EhiiZd4L4q9NpcxLsghy9
         CuXw==
X-Gm-Message-State: AGi0Puanh39SP6+FvGkPqf8Sx6bCUeKpHJDe8cZK5dHkRUHqZv7rS/39
        iDvCT400v/u9IoveyPclCgWVUA==
X-Google-Smtp-Source: APiQypLfi7wlQaXIPxwNmWqq8gtANHdhI+E0cUE6j5KkfiS6tNu4sWaylED/JXY9TIYSTDMABpmCGw==
X-Received: by 2002:aca:f4c4:: with SMTP id s187mr496947oih.83.1587082334538;
        Thu, 16 Apr 2020 17:12:14 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 26sm8241549oot.25.2020.04.16.17.12.13
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 16 Apr 2020 17:12:13 -0700 (PDT)
Date:   Thu, 16 Apr 2020 17:11:48 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] shmem: fix possible deadlocks on shmlock_user_lock
Message-ID: <alpine.LSU.2.11.2004161707410.16322@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent commit 71725ed10c40 ("mm: huge tmpfs: try to split_huge_page()
when punching hole") has allowed syzkaller to probe deeper, uncovering
a long-standing lockdep issue between the irq-unsafe shmlock_user_lock,
the irq-safe xa_lock on mapping->i_pages, and shmem inode's info->lock
which nests inside xa_lock (or tree_lock) since 4.8's shmem_uncharge().

user_shm_lock(), servicing SysV shmctl(SHM_LOCK), wants shmlock_user_lock
while its caller shmem_lock() holds info->lock with interrupts disabled;
but hugetlbfs_file_setup() calls user_shm_lock() with interrupts enabled,
and might be interrupted by a writeback endio wanting xa_lock on i_pages.
This may not risk an actual deadlock, since shmem inodes do not take part
in writeback accounting, but there are several easy ways to avoid it.

Requiring interrupts disabled for shmlock_user_lock would be easy,
but it's a high-level global lock for which that seems inappropriate.
Instead, recall that the use of info->lock to guard info->flags in
shmem_lock() dates from pre-3.1 days, when races with SHMEM_PAGEIN and
SHMEM_TRUNCATE could occur: nowadays it serves no purpose, the only flag
added or removed is VM_LOCKED itself, and calls to shmem_lock() an inode
are already serialized by the caller.  Take info->lock out of the chain
and the possibility of deadlock or lockdep warning goes away.

Reported-by: syzbot+c8a8197c8852f566b9d9@syzkaller.appspotmail.com
Link: https://lore.kernel.org/lkml/000000000000e5838c05a3152f53@google.com/
Reported-by: syzbot+40b71e145e73f78f81ad@syzkaller.appspotmail.com
Link: https://lore.kernel.org/lkml/0000000000003712b305a331d3b1@google.com/
Fixes: 4595ef88d136 ("shmem: make shmem_inode_info::lock irq-safe")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
---

 mm/shmem.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- 5.7-rc1/mm/shmem.c	2020-04-11 12:58:26.415524805 -0700
+++ linux/mm/shmem.c	2020-04-16 11:04:06.729738730 -0700
@@ -2179,7 +2179,11 @@ int shmem_lock(struct file *file, int lo
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	int retval = -ENOMEM;
 
-	spin_lock_irq(&info->lock);
+	/*
+	 * What serializes the accesses to info->flags?
+	 * ipc_lock_object() when called from shmctl_do_lock(),
+	 * no serialization needed when called from shm_destroy().
+	 */
 	if (lock && !(info->flags & VM_LOCKED)) {
 		if (!user_shm_lock(inode->i_size, user))
 			goto out_nomem;
@@ -2194,7 +2198,6 @@ int shmem_lock(struct file *file, int lo
 	retval = 0;
 
 out_nomem:
-	spin_unlock_irq(&info->lock);
 	return retval;
 }
 
