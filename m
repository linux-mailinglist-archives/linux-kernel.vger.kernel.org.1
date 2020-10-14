Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B33328DC2C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgJNI71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgJNI71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:59:27 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 968BB20B1F;
        Wed, 14 Oct 2020 08:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602665963;
        bh=Sj2T4/bRpwtW4iuuAgiogpnM1mzn/YGH6hqufNV+CLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X8I0mwI67pNIWUFE1G1pthWX/oxSYWQURRBI9t+WfZlPVPcJRkcPAmbW3J95ueJVe
         9OdjiBGa77dKBPzztqIWNYCJdoEw0A5Mnhn3FDNKtBiRChOf2P6Tpbj4GLK7wt/7TX
         g4a5nJBbSH3u1tdrsJcoKSJWi5d9SJkTNwftJgxk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH 1/1] tracepoints: tree-wide: Replace %p with %px
Date:   Wed, 14 Oct 2020 17:59:19 +0900
Message-Id: <160266595921.74973.16021029265750003477.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <160266594977.74973.9883936722540767319.stgit@devnote2>
References: <160266594977.74973.9883936722540767319.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To help debugging kernel, use %px to show real addresses on
tracefs/trace file.

Since ftrace human-readable format uses vsprintf(), all %p are
translated to hash values instead of pointer address.

However, when debugging the kernel, raw address value gives a
hint when comparing with the memory mapping in the kernel.
(Those are sometimes used with crash log, which is not hashed too)

Moreover, this is not improving the security because the tracefs
can be used only by root user and the raw address values are readable
from tracefs/percpu/cpu*/trace_pipe_raw file.

Note that this has been done by the following script.

 #!/bin/sh
 tmp=`mktemp`
 for h in include/trace/events/*.h ; do
   sed -e 's/\(%p\)\([^a-zA-Z]\)/\1x\2/g' $h > $tmp
   cp $tmp $h
 done
 rm $tmp

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/trace/events/afs.h           |    6 ++---
 include/trace/events/alarmtimer.h    |    2 +-
 include/trace/events/btrfs.h         |   14 ++++++-----
 include/trace/events/cachefiles.h    |   20 ++++++++--------
 include/trace/events/cma.h           |    4 ++-
 include/trace/events/filelock.h      |   10 ++++----
 include/trace/events/filemap.h       |    4 ++-
 include/trace/events/fs_dax.h        |    2 +-
 include/trace/events/fscache.h       |   28 +++++++++++------------
 include/trace/events/host1x.h        |    4 ++-
 include/trace/events/huge_memory.h   |    6 ++---
 include/trace/events/ib_mad.h        |    4 ++-
 include/trace/events/io_uring.h      |   28 +++++++++++------------
 include/trace/events/kmem.h          |   18 +++++++--------
 include/trace/events/lock.h          |    4 ++-
 include/trace/events/mlxsw.h         |   10 ++++----
 include/trace/events/mmc.h           |    4 ++-
 include/trace/events/napi.h          |    2 +-
 include/trace/events/nbd.h           |    4 ++-
 include/trace/events/net.h           |    8 +++---
 include/trace/events/nilfs2.h        |   14 ++++++-----
 include/trace/events/objagg.h        |   20 ++++++++--------
 include/trace/events/page_pool.h     |    8 +++---
 include/trace/events/page_ref.h      |    4 ++-
 include/trace/events/pagemap.h       |    4 ++-
 include/trace/events/percpu.h        |    8 +++---
 include/trace/events/pwc.h           |    4 ++-
 include/trace/events/pwm.h           |    2 +-
 include/trace/events/qdisc.h         |    2 +-
 include/trace/events/rcu.h           |   12 +++++-----
 include/trace/events/rpcgss.h        |    4 ++-
 include/trace/events/rpcrdma.h       |   42 +++++++++++++++++-----------------
 include/trace/events/rtc.h           |    2 +-
 include/trace/events/rxrpc.h         |    6 ++---
 include/trace/events/skb.h           |    6 ++---
 include/trace/events/spi.h           |    6 ++---
 include/trace/events/sunrpc.h        |   12 +++++-----
 include/trace/events/tegra_apb_dma.h |    2 +-
 include/trace/events/timer.h         |   14 ++++++-----
 include/trace/events/vb2.h           |    2 +-
 include/trace/events/vmscan.h        |    6 ++---
 include/trace/events/workqueue.h     |    8 +++---
 include/trace/events/xdp.h           |    6 ++---
 include/trace/events/xen.h           |   34 ++++++++++++++--------------
 44 files changed, 205 insertions(+), 205 deletions(-)

diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 5f0c1cf1ea13..066b74877a6e 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -795,7 +795,7 @@ TRACE_EVENT(afs_call_done,
 		    __entry->abort_code = call->abort_code;
 			   ),
 
-	    TP_printk("   c=%08x ret=%d ab=%d [%p]",
+	    TP_printk("   c=%08x ret=%d ab=%d [%px]",
 		      __entry->call,
 		      __entry->ret,
 		      __entry->abort_code,
@@ -880,7 +880,7 @@ TRACE_EVENT(afs_dir_check_failed,
 		    __entry->i_size = i_size;
 			   ),
 
-	    TP_printk("vn=%p %llx/%llx",
+	    TP_printk("vn=%px %llx/%llx",
 		      __entry->vnode, __entry->off, __entry->i_size)
 	    );
 
@@ -917,7 +917,7 @@ TRACE_EVENT(afs_page_dirty,
 		    __entry->priv = priv;
 			   ),
 
-	    TP_printk("vn=%p %lx %s %lu-%lu",
+	    TP_printk("vn=%px %lx %s %lu-%lu",
 		      __entry->vnode, __entry->page, __entry->where,
 		      __entry->priv & AFS_PRIV_MAX,
 		      __entry->priv >> AFS_PRIV_SHIFT)
diff --git a/include/trace/events/alarmtimer.h b/include/trace/events/alarmtimer.h
index 13483c7ca70b..4c1eb5c3c5bd 100644
--- a/include/trace/events/alarmtimer.h
+++ b/include/trace/events/alarmtimer.h
@@ -62,7 +62,7 @@ DECLARE_EVENT_CLASS(alarm_class,
 		__entry->now = now;
 	),
 
-	TP_printk("alarmtimer:%p type:%s expires:%llu now:%llu",
+	TP_printk("alarmtimer:%px type:%s expires:%llu now:%llu",
 		  __entry->alarm,
 		  show_alarm_type((1 << __entry->alarm_type)),
 		  __entry->expires,
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 863335ecb7e8..091740d363da 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1351,7 +1351,7 @@ TRACE_EVENT(alloc_extent_state,
 		__entry->ip	= (const void *)IP
 	),
 
-	TP_printk("state=%p mask=%s caller=%pS", __entry->state,
+	TP_printk("state=%px mask=%s caller=%pS", __entry->state,
 		  show_gfp_flags(__entry->mask), __entry->ip)
 );
 
@@ -1371,7 +1371,7 @@ TRACE_EVENT(free_extent_state,
 		__entry->ip = (const void *)IP
 	),
 
-	TP_printk("state=%p caller=%pS", __entry->state, __entry->ip)
+	TP_printk("state=%px caller=%pS", __entry->state, __entry->ip)
 );
 
 DECLARE_EVENT_CLASS(btrfs__work,
@@ -1398,8 +1398,8 @@ DECLARE_EVENT_CLASS(btrfs__work,
 		__entry->normal_work	= &work->normal_work;
 	),
 
-	TP_printk_btrfs("work=%p (normal_work=%p) wq=%p func=%ps ordered_func=%p "
-		  "ordered_free=%p",
+	TP_printk_btrfs("work=%px (normal_work=%px) wq=%px func=%ps ordered_func=%px "
+		  "ordered_free=%px",
 		  __entry->work, __entry->normal_work, __entry->wq,
 		   __entry->func, __entry->ordered_func, __entry->ordered_free)
 );
@@ -1423,7 +1423,7 @@ DECLARE_EVENT_CLASS(btrfs__work__done,
 		__entry->wtag		= wtag;
 	),
 
-	TP_printk_btrfs("work->%p", __entry->wtag)
+	TP_printk_btrfs("work->%px", __entry->wtag)
 );
 
 DEFINE_EVENT(btrfs__work, btrfs_work_queued,
@@ -1473,7 +1473,7 @@ DECLARE_EVENT_CLASS(btrfs__workqueue,
 		__entry->high		= high;
 	),
 
-	TP_printk_btrfs("name=%s%s wq=%p", __get_str(name),
+	TP_printk_btrfs("name=%s%s wq=%px", __get_str(name),
 		  __print_flags(__entry->high, "",
 				{(WQ_HIGHPRI),	"-high"}),
 		  __entry->wq)
@@ -1501,7 +1501,7 @@ DECLARE_EVENT_CLASS(btrfs__workqueue_done,
 		__entry->wq		= wq;
 	),
 
-	TP_printk_btrfs("wq=%p", __entry->wq)
+	TP_printk_btrfs("wq=%px", __entry->wq)
 );
 
 DEFINE_EVENT(btrfs__workqueue_done, btrfs_workqueue_destroy,
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 5d9de24cb9c0..4c961edfa1a0 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -91,7 +91,7 @@ TRACE_EVENT(cachefiles_ref,
 		    __entry->why	= why;
 			   ),
 
-	    TP_printk("c=%p o=%p u=%d %s",
+	    TP_printk("c=%px o=%px u=%d %s",
 		      __entry->cookie, __entry->obj, __entry->usage,
 		      __print_symbolic(__entry->why, cachefiles_obj_ref_traces))
 	    );
@@ -115,7 +115,7 @@ TRACE_EVENT(cachefiles_lookup,
 		    __entry->inode	= inode;
 			   ),
 
-	    TP_printk("o=%p d=%p i=%p",
+	    TP_printk("o=%px d=%px i=%px",
 		      __entry->obj, __entry->de, __entry->inode)
 	    );
 
@@ -137,7 +137,7 @@ TRACE_EVENT(cachefiles_mkdir,
 		    __entry->ret	= ret;
 			   ),
 
-	    TP_printk("o=%p d=%p r=%u",
+	    TP_printk("o=%px d=%px r=%u",
 		      __entry->obj, __entry->de, __entry->ret)
 	    );
 
@@ -159,7 +159,7 @@ TRACE_EVENT(cachefiles_create,
 		    __entry->ret	= ret;
 			   ),
 
-	    TP_printk("o=%p d=%p r=%u",
+	    TP_printk("o=%px d=%px r=%u",
 		      __entry->obj, __entry->de, __entry->ret)
 	    );
 
@@ -183,7 +183,7 @@ TRACE_EVENT(cachefiles_unlink,
 		    __entry->why	= why;
 			   ),
 
-	    TP_printk("o=%p d=%p w=%s",
+	    TP_printk("o=%px d=%px w=%s",
 		      __entry->obj, __entry->de,
 		      __print_symbolic(__entry->why, cachefiles_obj_kill_traces))
 	    );
@@ -211,7 +211,7 @@ TRACE_EVENT(cachefiles_rename,
 		    __entry->why	= why;
 			   ),
 
-	    TP_printk("o=%p d=%p t=%p w=%s",
+	    TP_printk("o=%px d=%px t=%px w=%s",
 		      __entry->obj, __entry->de, __entry->to,
 		      __print_symbolic(__entry->why, cachefiles_obj_kill_traces))
 	    );
@@ -233,7 +233,7 @@ TRACE_EVENT(cachefiles_mark_active,
 		    __entry->de		= de;
 			   ),
 
-	    TP_printk("o=%p d=%p",
+	    TP_printk("o=%px d=%px",
 		      __entry->obj, __entry->de)
 	    );
 
@@ -261,7 +261,7 @@ TRACE_EVENT(cachefiles_wait_active,
 		    __entry->fsc_flags	= xobj->fscache.flags;
 			   ),
 
-	    TP_printk("o=%p d=%p wo=%p wf=%x wff=%x",
+	    TP_printk("o=%px d=%px wo=%px wf=%x wff=%x",
 		      __entry->obj, __entry->de, __entry->xobj,
 		      __entry->flags, __entry->fsc_flags)
 	    );
@@ -286,7 +286,7 @@ TRACE_EVENT(cachefiles_mark_inactive,
 		    __entry->inode	= inode;
 			   ),
 
-	    TP_printk("o=%p d=%p i=%p",
+	    TP_printk("o=%px d=%px i=%px",
 		      __entry->obj, __entry->de, __entry->inode)
 	    );
 
@@ -310,7 +310,7 @@ TRACE_EVENT(cachefiles_mark_buried,
 		    __entry->why	= why;
 			   ),
 
-	    TP_printk("o=%p d=%p w=%s",
+	    TP_printk("o=%px d=%px w=%s",
 		      __entry->obj, __entry->de,
 		      __print_symbolic(__entry->why, cachefiles_obj_kill_traces))
 	    );
diff --git a/include/trace/events/cma.h b/include/trace/events/cma.h
index 5017a8829270..5720a8442700 100644
--- a/include/trace/events/cma.h
+++ b/include/trace/events/cma.h
@@ -29,7 +29,7 @@ TRACE_EVENT(cma_alloc,
 		__entry->align = align;
 	),
 
-	TP_printk("pfn=%lx page=%p count=%u align=%u",
+	TP_printk("pfn=%lx page=%px count=%u align=%u",
 		  __entry->pfn,
 		  __entry->page,
 		  __entry->count,
@@ -55,7 +55,7 @@ TRACE_EVENT(cma_release,
 		__entry->count = count;
 	),
 
-	TP_printk("pfn=%lx page=%p count=%u",
+	TP_printk("pfn=%lx page=%px count=%u",
 		  __entry->pfn,
 		  __entry->page,
 		  __entry->count)
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index c705e4944a50..a7746916e6df 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -54,7 +54,7 @@ TRACE_EVENT(locks_get_lock_context,
 		__entry->ctx = ctx;
 	),
 
-	TP_printk("dev=0x%x:0x%x ino=0x%lx type=%s ctx=%p",
+	TP_printk("dev=0x%x:0x%x ino=0x%lx type=%s ctx=%px",
 		  MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
 		  __entry->i_ino, show_fl_type(__entry->type), __entry->ctx)
 );
@@ -92,7 +92,7 @@ DECLARE_EVENT_CLASS(filelock_lock,
 		__entry->ret = ret;
 	),
 
-	TP_printk("fl=0x%p dev=0x%x:0x%x ino=0x%lx fl_blocker=0x%p fl_owner=0x%p fl_pid=%u fl_flags=%s fl_type=%s fl_start=%lld fl_end=%lld ret=%d",
+	TP_printk("fl=0x%px dev=0x%x:0x%x ino=0x%lx fl_blocker=0x%px fl_owner=0x%px fl_pid=%u fl_flags=%s fl_type=%s fl_start=%lld fl_end=%lld ret=%d",
 		__entry->fl, MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
 		__entry->i_ino, __entry->fl_blocker, __entry->fl_owner,
 		__entry->fl_pid, show_fl_flags(__entry->fl_flags),
@@ -145,7 +145,7 @@ DECLARE_EVENT_CLASS(filelock_lease,
 		__entry->fl_downgrade_time = fl ? fl->fl_downgrade_time : 0;
 	),
 
-	TP_printk("fl=0x%p dev=0x%x:0x%x ino=0x%lx fl_blocker=0x%p fl_owner=0x%p fl_flags=%s fl_type=%s fl_break_time=%lu fl_downgrade_time=%lu",
+	TP_printk("fl=0x%px dev=0x%x:0x%x ino=0x%lx fl_blocker=0x%px fl_owner=0x%px fl_flags=%s fl_type=%s fl_break_time=%lu fl_downgrade_time=%lu",
 		__entry->fl, MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
 		__entry->i_ino, __entry->fl_blocker, __entry->fl_owner,
 		show_fl_flags(__entry->fl_flags),
@@ -195,7 +195,7 @@ TRACE_EVENT(generic_add_lease,
 		__entry->fl_type = fl->fl_type;
 	),
 
-	TP_printk("dev=0x%x:0x%x ino=0x%lx wcount=%d rcount=%d icount=%d fl_owner=0x%p fl_flags=%s fl_type=%s",
+	TP_printk("dev=0x%x:0x%x ino=0x%lx wcount=%d rcount=%d icount=%d fl_owner=0x%px fl_flags=%s fl_type=%s",
 		MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
 		__entry->i_ino, __entry->wcount, __entry->rcount,
 		__entry->icount, __entry->fl_owner,
@@ -228,7 +228,7 @@ TRACE_EVENT(leases_conflict,
 		__entry->conflict = conflict;
 	),
 
-	TP_printk("conflict %d: lease=0x%p fl_flags=%s fl_type=%s; breaker=0x%p fl_flags=%s fl_type=%s",
+	TP_printk("conflict %d: lease=0x%px fl_flags=%s fl_type=%s; breaker=0x%px fl_flags=%s fl_type=%s",
 		__entry->conflict,
 		__entry->lease,
 		show_fl_flags(__entry->l_fl_flags),
diff --git a/include/trace/events/filemap.h b/include/trace/events/filemap.h
index 796053e162d2..2bfabfad29f4 100644
--- a/include/trace/events/filemap.h
+++ b/include/trace/events/filemap.h
@@ -36,7 +36,7 @@ DECLARE_EVENT_CLASS(mm_filemap_op_page_cache,
 			__entry->s_dev = page->mapping->host->i_rdev;
 	),
 
-	TP_printk("dev %d:%d ino %lx page=%p pfn=%lu ofs=%lu",
+	TP_printk("dev %d:%d ino %lx page=%px pfn=%lu ofs=%lu",
 		MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
 		__entry->i_ino,
 		pfn_to_page(__entry->pfn),
@@ -105,7 +105,7 @@ TRACE_EVENT(file_check_and_advance_wb_err,
 			__entry->new = file->f_wb_err;
 		),
 
-		TP_printk("file=%p dev=%d:%d ino=0x%lx old=0x%x new=0x%x",
+		TP_printk("file=%px dev=%d:%d ino=0x%lx old=0x%x new=0x%x",
 			__entry->file, MAJOR(__entry->s_dev),
 			MINOR(__entry->s_dev), __entry->i_ino, __entry->old,
 			__entry->new)
diff --git a/include/trace/events/fs_dax.h b/include/trace/events/fs_dax.h
index 97b09fcf7e52..0cdef6d1916c 100644
--- a/include/trace/events/fs_dax.h
+++ b/include/trace/events/fs_dax.h
@@ -81,7 +81,7 @@ DECLARE_EVENT_CLASS(dax_pmd_load_hole_class,
 		__entry->zero_page = zero_page;
 		__entry->radix_entry = radix_entry;
 	),
-	TP_printk("dev %d:%d ino %#lx %s address %#lx zero_page %p "
+	TP_printk("dev %d:%d ino %#lx %s address %#lx zero_page %px "
 			"radix_entry %#lx",
 		MAJOR(__entry->dev),
 		MINOR(__entry->dev),
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index d16fe6ed78a2..9b823da320f6 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -186,7 +186,7 @@ TRACE_EVENT(fscache_cookie,
 		    __entry->flags	= cookie->flags;
 			   ),
 
-	    TP_printk("%s c=%p u=%d p=%p Nc=%d Na=%d f=%02x",
+	    TP_printk("%s c=%px u=%d p=%px Nc=%d Na=%d f=%02x",
 		      __print_symbolic(__entry->where, fscache_cookie_traces),
 		      __entry->cookie, __entry->usage,
 		      __entry->parent, __entry->n_children, __entry->n_active,
@@ -209,7 +209,7 @@ TRACE_EVENT(fscache_netfs,
 		    __entry->name[7]		= 0;
 			   ),
 
-	    TP_printk("c=%p n=%s",
+	    TP_printk("c=%px n=%s",
 		      __entry->cookie, __entry->name)
 	    );
 
@@ -237,7 +237,7 @@ TRACE_EVENT(fscache_acquire,
 		    __entry->name[7]		= 0;
 			   ),
 
-	    TP_printk("c=%p p=%p pu=%d pc=%d pf=%02x n=%s",
+	    TP_printk("c=%px p=%px pu=%d pc=%d pf=%02x n=%s",
 		      __entry->cookie, __entry->parent, __entry->p_usage,
 		      __entry->p_n_children, __entry->p_flags, __entry->name)
 	    );
@@ -267,7 +267,7 @@ TRACE_EVENT(fscache_relinquish,
 		    __entry->retire	= retire;
 			   ),
 
-	    TP_printk("c=%p u=%d p=%p Nc=%d Na=%d f=%02x r=%u",
+	    TP_printk("c=%px u=%d p=%px Nc=%d Na=%d f=%02x r=%u",
 		      __entry->cookie, __entry->usage,
 		      __entry->parent, __entry->n_children, __entry->n_active,
 		      __entry->flags, __entry->retire)
@@ -294,7 +294,7 @@ TRACE_EVENT(fscache_enable,
 		    __entry->flags	= cookie->flags;
 			   ),
 
-	    TP_printk("c=%p u=%d Nc=%d Na=%d f=%02x",
+	    TP_printk("c=%px u=%d Nc=%d Na=%d f=%02x",
 		      __entry->cookie, __entry->usage,
 		      __entry->n_children, __entry->n_active, __entry->flags)
 	    );
@@ -320,7 +320,7 @@ TRACE_EVENT(fscache_disable,
 		    __entry->flags	= cookie->flags;
 			   ),
 
-	    TP_printk("c=%p u=%d Nc=%d Na=%d f=%02x",
+	    TP_printk("c=%px u=%d Nc=%d Na=%d f=%02x",
 		      __entry->cookie, __entry->usage,
 		      __entry->n_children, __entry->n_active, __entry->flags)
 	    );
@@ -350,7 +350,7 @@ TRACE_EVENT(fscache_osm,
 		    memcpy(__entry->state, state->short_name, 8);
 			   ),
 
-	    TP_printk("c=%p o=%p %s %s%sev=%d",
+	    TP_printk("c=%px o=%px %s %s%sev=%d",
 		      __entry->cookie,
 		      __entry->object,
 		      __entry->state,
@@ -381,7 +381,7 @@ TRACE_EVENT(fscache_page,
 		    __entry->why		= why;
 			   ),
 
-	    TP_printk("c=%p %s pg=%lx",
+	    TP_printk("c=%px %s pg=%lx",
 		      __entry->cookie,
 		      __print_symbolic(__entry->why, fscache_page_traces),
 		      __entry->page)
@@ -407,7 +407,7 @@ TRACE_EVENT(fscache_check_page,
 		    __entry->n			= n;
 			   ),
 
-	    TP_printk("c=%p pg=%p val=%p n=%d",
+	    TP_printk("c=%px pg=%px val=%px n=%d",
 		      __entry->cookie, __entry->page, __entry->val, __entry->n)
 	    );
 
@@ -424,7 +424,7 @@ TRACE_EVENT(fscache_wake_cookie,
 		    __entry->cookie		= cookie;
 			   ),
 
-	    TP_printk("c=%p", __entry->cookie)
+	    TP_printk("c=%px", __entry->cookie)
 	    );
 
 TRACE_EVENT(fscache_op,
@@ -445,7 +445,7 @@ TRACE_EVENT(fscache_op,
 		    __entry->why		= why;
 			   ),
 
-	    TP_printk("c=%p op=%p %s",
+	    TP_printk("c=%px op=%px %s",
 		      __entry->cookie, __entry->op,
 		      __print_symbolic(__entry->why, fscache_op_traces))
 	    );
@@ -470,7 +470,7 @@ TRACE_EVENT(fscache_page_op,
 		    __entry->what		= what;
 			   ),
 
-	    TP_printk("c=%p %s pg=%lx op=%p",
+	    TP_printk("c=%px %s pg=%lx op=%px",
 		      __entry->cookie,
 		      __print_symbolic(__entry->what, fscache_page_op_traces),
 		      __entry->page, __entry->op)
@@ -496,7 +496,7 @@ TRACE_EVENT(fscache_wrote_page,
 		    __entry->ret		= ret;
 			   ),
 
-	    TP_printk("c=%p pg=%lx op=%p ret=%d",
+	    TP_printk("c=%px pg=%lx op=%px ret=%d",
 		      __entry->cookie, __entry->page, __entry->op, __entry->ret)
 	    );
 
@@ -522,7 +522,7 @@ TRACE_EVENT(fscache_gang_lookup,
 		    __entry->store_limit	= store_limit;
 			   ),
 
-	    TP_printk("c=%p op=%p r0=%lx n=%d sl=%lx",
+	    TP_printk("c=%px op=%px r0=%lx n=%d sl=%lx",
 		      __entry->cookie, __entry->op, __entry->results0, __entry->n,
 		      __entry->store_limit)
 	    );
diff --git a/include/trace/events/host1x.h b/include/trace/events/host1x.h
index 1ba84b738e46..117b7d40c5ed 100644
--- a/include/trace/events/host1x.h
+++ b/include/trace/events/host1x.h
@@ -120,7 +120,7 @@ TRACE_EVENT(host1x_cdma_push_gather,
 		__entry->offset = offset;
 	),
 
-	TP_printk("name=%s, bo=%p, words=%u, offset=%d, contents=[%s]",
+	TP_printk("name=%s, bo=%px, words=%u, offset=%d, contents=[%s]",
 	  __entry->name, __entry->bo,
 	  __entry->words, __entry->offset,
 	  __print_hex(__get_dynamic_array(cmdbuf),
@@ -255,7 +255,7 @@ TRACE_EVENT(host1x_syncpt_wait_check,
 		__entry->min = min;
 	),
 
-	TP_printk("bo=%p, offset=%05x, id=%d, thresh=%d, current=%d",
+	TP_printk("bo=%px, offset=%05x, id=%d, thresh=%d, current=%d",
 		__entry->bo, __entry->offset,
 		__entry->syncpt_id, __entry->thresh,
 		__entry->min)
diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 4fdb14a81108..23b9b7b399e0 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -75,7 +75,7 @@ TRACE_EVENT(mm_khugepaged_scan_pmd,
 		__entry->unmapped = unmapped;
 	),
 
-	TP_printk("mm=%p, scan_pfn=0x%lx, writable=%d, referenced=%d, none_or_zero=%d, status=%s, unmapped=%d",
+	TP_printk("mm=%px, scan_pfn=0x%lx, writable=%d, referenced=%d, none_or_zero=%d, status=%s, unmapped=%d",
 		__entry->mm,
 		__entry->pfn,
 		__entry->writable,
@@ -103,7 +103,7 @@ TRACE_EVENT(mm_collapse_huge_page,
 		__entry->status = status;
 	),
 
-	TP_printk("mm=%p, isolated=%d, status=%s",
+	TP_printk("mm=%px, isolated=%d, status=%s",
 		__entry->mm,
 		__entry->isolated,
 		__print_symbolic(__entry->status, SCAN_STATUS))
@@ -160,7 +160,7 @@ TRACE_EVENT(mm_collapse_huge_page_swapin,
 		__entry->ret = ret;
 	),
 
-	TP_printk("mm=%p, swapped_in=%d, referenced=%d, ret=%d",
+	TP_printk("mm=%px, swapped_in=%d, referenced=%d, ret=%d",
 		__entry->mm,
 		__entry->swapped_in,
 		__entry->referenced,
diff --git a/include/trace/events/ib_mad.h b/include/trace/events/ib_mad.h
index 59363a083ecb..70b9fd028450 100644
--- a/include/trace/events/ib_mad.h
+++ b/include/trace/events/ib_mad.h
@@ -84,7 +84,7 @@ DECLARE_EVENT_CLASS(ib_mad_send_template,
 		create_mad_addr_info(wr, qp_info, __entry);
 	),
 
-	TP_printk("%d:%d QP%d agent %p: " \
+	TP_printk("%d:%d QP%d agent %px: " \
 		  "wrtid 0x%llx; %d/%d retries(%d); timeout %lu length %d : " \
 		  "hdr : base_ver 0x%x class 0x%x class_ver 0x%x " \
 		  "method 0x%x status 0x%x class_specific 0x%x tid 0x%llx " \
@@ -165,7 +165,7 @@ TRACE_EVENT(ib_mad_send_done_handler,
 		__entry->length = wc->byte_len;
 	),
 
-	TP_printk("%d:%d QP%d : SEND WC Status %d : agent %p: " \
+	TP_printk("%d:%d QP%d : SEND WC Status %d : agent %px: " \
 		  "wrtid 0x%llx %d/%d retries(%d) timeout %lu length %d: " \
 		  "hdr : base_ver 0x%x class 0x%x class_ver 0x%x " \
 		  "method 0x%x status 0x%x",
diff --git a/include/trace/events/io_uring.h b/include/trace/events/io_uring.h
index 9f0d3b7d56b0..df1841f05544 100644
--- a/include/trace/events/io_uring.h
+++ b/include/trace/events/io_uring.h
@@ -43,7 +43,7 @@ TRACE_EVENT(io_uring_create,
 		__entry->flags		= flags;
 	),
 
-	TP_printk("ring %p, fd %d sq size %d, cq size %d, flags %d",
+	TP_printk("ring %px, fd %d sq size %d, cq size %d, flags %d",
 			  __entry->ctx, __entry->fd, __entry->sq_entries,
 			  __entry->cq_entries, __entry->flags)
 );
@@ -89,7 +89,7 @@ TRACE_EVENT(io_uring_register,
 		__entry->ret		= ret;
 	),
 
-	TP_printk("ring %p, opcode %d, nr_user_files %d, nr_user_bufs %d, "
+	TP_printk("ring %px, opcode %d, nr_user_files %d, nr_user_bufs %d, "
 			  "eventfd %d, ret %ld",
 			  __entry->ctx, __entry->opcode, __entry->nr_files,
 			  __entry->nr_bufs, __entry->eventfd, __entry->ret)
@@ -121,7 +121,7 @@ TRACE_EVENT(io_uring_file_get,
 		__entry->fd		= fd;
 	),
 
-	TP_printk("ring %p, fd %d", __entry->ctx, __entry->fd)
+	TP_printk("ring %px, fd %d", __entry->ctx, __entry->fd)
 );
 
 /**
@@ -157,7 +157,7 @@ TRACE_EVENT(io_uring_queue_async_work,
 		__entry->flags	= flags;
 	),
 
-	TP_printk("ring %p, request %p, flags %d, %s queue, work %p",
+	TP_printk("ring %px, request %px, flags %d, %s queue, work %px",
 			  __entry->ctx, __entry->req, __entry->flags,
 			  __entry->rw ? "hashed" : "normal", __entry->work)
 );
@@ -190,7 +190,7 @@ TRACE_EVENT(io_uring_defer,
 		__entry->data	= user_data;
 	),
 
-	TP_printk("ring %p, request %p user_data %llu", __entry->ctx,
+	TP_printk("ring %px, request %px user_data %llu", __entry->ctx,
 			__entry->req, __entry->data)
 );
 
@@ -223,7 +223,7 @@ TRACE_EVENT(io_uring_link,
 		__entry->target_req	= target_req;
 	),
 
-	TP_printk("ring %p, request %p linked after %p",
+	TP_printk("ring %px, request %px linked after %px",
 			  __entry->ctx, __entry->req, __entry->target_req)
 );
 
@@ -253,7 +253,7 @@ TRACE_EVENT(io_uring_cqring_wait,
 		__entry->min_events	= min_events;
 	),
 
-	TP_printk("ring %p, min_events %d", __entry->ctx, __entry->min_events)
+	TP_printk("ring %px, min_events %d", __entry->ctx, __entry->min_events)
 );
 
 /**
@@ -281,7 +281,7 @@ TRACE_EVENT(io_uring_fail_link,
 		__entry->link	= link;
 	),
 
-	TP_printk("request %p, link %p", __entry->req, __entry->link)
+	TP_printk("request %px, link %px", __entry->req, __entry->link)
 );
 
 /**
@@ -310,7 +310,7 @@ TRACE_EVENT(io_uring_complete,
 		__entry->res		= res;
 	),
 
-	TP_printk("ring %p, user_data 0x%llx, result %ld",
+	TP_printk("ring %px, user_data 0x%llx, result %ld",
 			  __entry->ctx, (unsigned long long)__entry->user_data,
 			  __entry->res)
 );
@@ -351,7 +351,7 @@ TRACE_EVENT(io_uring_submit_sqe,
 		__entry->sq_thread	= sq_thread;
 	),
 
-	TP_printk("ring %p, op %d, data 0x%llx, non block %d, sq_thread %d",
+	TP_printk("ring %px, op %d, data 0x%llx, non block %d, sq_thread %d",
 			  __entry->ctx, __entry->opcode,
 			  (unsigned long long) __entry->user_data,
 			  __entry->force_nonblock, __entry->sq_thread)
@@ -379,7 +379,7 @@ TRACE_EVENT(io_uring_poll_arm,
 		__entry->events		= events;
 	),
 
-	TP_printk("ring %p, op %d, data 0x%llx, mask 0x%x, events 0x%x",
+	TP_printk("ring %px, op %d, data 0x%llx, mask 0x%x, events 0x%x",
 			  __entry->ctx, __entry->opcode,
 			  (unsigned long long) __entry->user_data,
 			  __entry->mask, __entry->events)
@@ -405,7 +405,7 @@ TRACE_EVENT(io_uring_poll_wake,
 		__entry->mask		= mask;
 	),
 
-	TP_printk("ring %p, op %d, data 0x%llx, mask 0x%x",
+	TP_printk("ring %px, op %d, data 0x%llx, mask 0x%x",
 			  __entry->ctx, __entry->opcode,
 			  (unsigned long long) __entry->user_data,
 			  __entry->mask)
@@ -431,7 +431,7 @@ TRACE_EVENT(io_uring_task_add,
 		__entry->mask		= mask;
 	),
 
-	TP_printk("ring %p, op %d, data 0x%llx, mask %x",
+	TP_printk("ring %px, op %d, data 0x%llx, mask %x",
 			  __entry->ctx, __entry->opcode,
 			  (unsigned long long) __entry->user_data,
 			  __entry->mask)
@@ -455,7 +455,7 @@ TRACE_EVENT(io_uring_task_run,
 		__entry->user_data	= user_data;
 	),
 
-	TP_printk("ring %p, op %d, data 0x%llx",
+	TP_printk("ring %px, op %d, data 0x%llx",
 			  __entry->ctx, __entry->opcode,
 			  (unsigned long long) __entry->user_data)
 );
diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index f65b1f6db22d..a35acd5b3596 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -35,7 +35,7 @@ DECLARE_EVENT_CLASS(kmem_alloc,
 		__entry->gfp_flags	= gfp_flags;
 	),
 
-	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
+	TP_printk("call_site=%pS ptr=%px bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
 		(void *)__entry->call_site,
 		__entry->ptr,
 		__entry->bytes_req,
@@ -88,7 +88,7 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
 		__entry->node		= node;
 	),
 
-	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d",
+	TP_printk("call_site=%pS ptr=%px bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d",
 		(void *)__entry->call_site,
 		__entry->ptr,
 		__entry->bytes_req,
@@ -131,7 +131,7 @@ DECLARE_EVENT_CLASS(kmem_free,
 		__entry->ptr		= ptr;
 	),
 
-	TP_printk("call_site=%pS ptr=%p",
+	TP_printk("call_site=%pS ptr=%px",
 		  (void *)__entry->call_site, __entry->ptr)
 );
 
@@ -165,7 +165,7 @@ TRACE_EVENT(mm_page_free,
 		__entry->order		= order;
 	),
 
-	TP_printk("page=%p pfn=%lu order=%d",
+	TP_printk("page=%px pfn=%lu order=%d",
 			pfn_to_page(__entry->pfn),
 			__entry->pfn,
 			__entry->order)
@@ -185,7 +185,7 @@ TRACE_EVENT(mm_page_free_batched,
 		__entry->pfn		= page_to_pfn(page);
 	),
 
-	TP_printk("page=%p pfn=%lu order=0",
+	TP_printk("page=%px pfn=%lu order=0",
 			pfn_to_page(__entry->pfn),
 			__entry->pfn)
 );
@@ -211,7 +211,7 @@ TRACE_EVENT(mm_page_alloc,
 		__entry->migratetype	= migratetype;
 	),
 
-	TP_printk("page=%p pfn=%lu order=%d migratetype=%d gfp_flags=%s",
+	TP_printk("page=%px pfn=%lu order=%d migratetype=%d gfp_flags=%s",
 		__entry->pfn != -1UL ? pfn_to_page(__entry->pfn) : NULL,
 		__entry->pfn != -1UL ? __entry->pfn : 0,
 		__entry->order,
@@ -237,7 +237,7 @@ DECLARE_EVENT_CLASS(mm_page,
 		__entry->migratetype	= migratetype;
 	),
 
-	TP_printk("page=%p pfn=%lu order=%u migratetype=%d percpu_refill=%d",
+	TP_printk("page=%px pfn=%lu order=%u migratetype=%d percpu_refill=%d",
 		__entry->pfn != -1UL ? pfn_to_page(__entry->pfn) : NULL,
 		__entry->pfn != -1UL ? __entry->pfn : 0,
 		__entry->order,
@@ -270,7 +270,7 @@ TRACE_EVENT(mm_page_pcpu_drain,
 		__entry->migratetype	= migratetype;
 	),
 
-	TP_printk("page=%p pfn=%lu order=%d migratetype=%d",
+	TP_printk("page=%px pfn=%lu order=%d migratetype=%d",
 		pfn_to_page(__entry->pfn), __entry->pfn,
 		__entry->order, __entry->migratetype)
 );
@@ -304,7 +304,7 @@ TRACE_EVENT(mm_page_alloc_extfrag,
 					get_pageblock_migratetype(page));
 	),
 
-	TP_printk("page=%p pfn=%lu alloc_order=%d fallback_order=%d pageblock_order=%d alloc_migratetype=%d fallback_migratetype=%d fragmenting=%d change_ownership=%d",
+	TP_printk("page=%px pfn=%lu alloc_order=%d fallback_order=%d pageblock_order=%d alloc_migratetype=%d fallback_migratetype=%d fragmenting=%d change_ownership=%d",
 		pfn_to_page(__entry->pfn),
 		__entry->pfn,
 		__entry->alloc_order,
diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index d7512129a324..7b4216f4eb55 100644
--- a/include/trace/events/lock.h
+++ b/include/trace/events/lock.h
@@ -30,7 +30,7 @@ TRACE_EVENT(lock_acquire,
 		__entry->lockdep_addr = lock;
 	),
 
-	TP_printk("%p %s%s%s", __entry->lockdep_addr,
+	TP_printk("%px %s%s%s", __entry->lockdep_addr,
 		  (__entry->flags & 1) ? "try " : "",
 		  (__entry->flags & 2) ? "read " : "",
 		  __get_str(name))
@@ -52,7 +52,7 @@ DECLARE_EVENT_CLASS(lock,
 		__entry->lockdep_addr = lock;
 	),
 
-	TP_printk("%p %s",  __entry->lockdep_addr, __get_str(name))
+	TP_printk("%px %s",  __entry->lockdep_addr, __get_str(name))
 );
 
 DEFINE_EVENT(lock, lock_release,
diff --git a/include/trace/events/mlxsw.h b/include/trace/events/mlxsw.h
index 19a25ed323a5..99d7d8919a08 100644
--- a/include/trace/events/mlxsw.h
+++ b/include/trace/events/mlxsw.h
@@ -29,7 +29,7 @@ TRACE_EVENT(mlxsw_sp_acl_atcam_entry_add_ctcam_spill,
 		__entry->aregion = aregion;
 	),
 
-	TP_printk("mlxsw_sp %p, aregion %p",
+	TP_printk("mlxsw_sp %px, aregion %px",
 		  __entry->mlxsw_sp, __entry->aregion)
 );
 
@@ -49,7 +49,7 @@ TRACE_EVENT(mlxsw_sp_acl_tcam_vregion_rehash,
 		__entry->vregion = vregion;
 	),
 
-	TP_printk("mlxsw_sp %p, vregion %p",
+	TP_printk("mlxsw_sp %px, vregion %px",
 		  __entry->mlxsw_sp, __entry->vregion)
 );
 
@@ -69,7 +69,7 @@ TRACE_EVENT(mlxsw_sp_acl_tcam_vregion_migrate,
 		__entry->vregion = vregion;
 	),
 
-	TP_printk("mlxsw_sp %p, vregion %p",
+	TP_printk("mlxsw_sp %px, vregion %px",
 		  __entry->mlxsw_sp, __entry->vregion)
 );
 
@@ -89,7 +89,7 @@ TRACE_EVENT(mlxsw_sp_acl_tcam_vregion_migrate_end,
 		__entry->vregion = vregion;
 	),
 
-	TP_printk("mlxsw_sp %p, vregion %p",
+	TP_printk("mlxsw_sp %px, vregion %px",
 		  __entry->mlxsw_sp, __entry->vregion)
 );
 
@@ -109,7 +109,7 @@ TRACE_EVENT(mlxsw_sp_acl_tcam_vregion_rehash_rollback_failed,
 		__entry->vregion = vregion;
 	),
 
-	TP_printk("mlxsw_sp %p, vregion %p",
+	TP_printk("mlxsw_sp %px, vregion %px",
 		  __entry->mlxsw_sp, __entry->vregion)
 );
 
diff --git a/include/trace/events/mmc.h b/include/trace/events/mmc.h
index 7b706ff21335..78c6e7c750e6 100644
--- a/include/trace/events/mmc.h
+++ b/include/trace/events/mmc.h
@@ -72,7 +72,7 @@ TRACE_EVENT(mmc_request_start,
 		__entry->mrq = mrq;
 	),
 
-	TP_printk("%s: start struct mmc_request[%p]: "
+	TP_printk("%s: start struct mmc_request[%px]: "
 		  "cmd_opcode=%u cmd_arg=0x%x cmd_flags=0x%x cmd_retries=%u "
 		  "stop_opcode=%u stop_arg=0x%x stop_flags=0x%x stop_retries=%u "
 		  "sbc_opcode=%u sbc_arg=0x%x sbc_flags=0x%x sbc_retires=%u "
@@ -160,7 +160,7 @@ TRACE_EVENT(mmc_request_done,
 		__entry->mrq = mrq;
 	),
 
-	TP_printk("%s: end struct mmc_request[%p]: "
+	TP_printk("%s: end struct mmc_request[%px]: "
 		  "cmd_opcode=%u cmd_err=%d cmd_resp=0x%x 0x%x 0x%x 0x%x "
 		  "cmd_retries=%u stop_opcode=%u stop_err=%d "
 		  "stop_resp=0x%x 0x%x 0x%x 0x%x stop_retries=%u "
diff --git a/include/trace/events/napi.h b/include/trace/events/napi.h
index 6678cf8b235b..edba8ea17300 100644
--- a/include/trace/events/napi.h
+++ b/include/trace/events/napi.h
@@ -31,7 +31,7 @@ TRACE_EVENT(napi_poll,
 		__entry->budget = budget;
 	),
 
-	TP_printk("napi poll on napi struct %p for device %s work %d budget %d",
+	TP_printk("napi poll on napi struct %px for device %s work %d budget %d",
 		  __entry->napi, __get_str(dev_name),
 		  __entry->work, __entry->budget)
 );
diff --git a/include/trace/events/nbd.h b/include/trace/events/nbd.h
index 9849956f34d8..1baf6e451b7c 100644
--- a/include/trace/events/nbd.h
+++ b/include/trace/events/nbd.h
@@ -24,7 +24,7 @@ DECLARE_EVENT_CLASS(nbd_transport_event,
 	),
 
 	TP_printk(
-		"nbd transport event: request %p, handle 0x%016llx",
+		"nbd transport event: request %px, handle 0x%016llx",
 		__entry->req,
 		__entry->handle
 	)
@@ -77,7 +77,7 @@ DECLARE_EVENT_CLASS(nbd_send_request,
 		__entry->request = rq;
 	),
 
-	TP_printk("nbd%lld: request %p", __entry->dev_index, __entry->request)
+	TP_printk("nbd%lld: request %px", __entry->dev_index, __entry->request)
 );
 
 #ifdef DEFINE_EVENT_WRITABLE
diff --git a/include/trace/events/net.h b/include/trace/events/net.h
index 2399073c3afc..a38ac147df55 100644
--- a/include/trace/events/net.h
+++ b/include/trace/events/net.h
@@ -58,7 +58,7 @@ TRACE_EVENT(net_dev_start_xmit,
 		__entry->gso_type = skb_shinfo(skb)->gso_type;
 	),
 
-	TP_printk("dev=%s queue_mapping=%u skbaddr=%p vlan_tagged=%d vlan_proto=0x%04x vlan_tci=0x%04x protocol=0x%04x ip_summed=%d len=%u data_len=%u network_offset=%d transport_offset_valid=%d transport_offset=%d tx_flags=%d gso_size=%d gso_segs=%d gso_type=%#x",
+	TP_printk("dev=%s queue_mapping=%u skbaddr=%px vlan_tagged=%d vlan_proto=0x%04x vlan_tci=0x%04x protocol=0x%04x ip_summed=%d len=%u data_len=%u network_offset=%d transport_offset_valid=%d transport_offset=%d tx_flags=%d gso_size=%d gso_segs=%d gso_type=%#x",
 		  __get_str(name), __entry->queue_mapping, __entry->skbaddr,
 		  __entry->vlan_tagged, __entry->vlan_proto, __entry->vlan_tci,
 		  __entry->protocol, __entry->ip_summed, __entry->len,
@@ -91,7 +91,7 @@ TRACE_EVENT(net_dev_xmit,
 		__assign_str(name, dev->name);
 	),
 
-	TP_printk("dev=%s skbaddr=%p len=%u rc=%d",
+	TP_printk("dev=%s skbaddr=%px len=%u rc=%d",
 		__get_str(name), __entry->skbaddr, __entry->len, __entry->rc)
 );
 
@@ -136,7 +136,7 @@ DECLARE_EVENT_CLASS(net_dev_template,
 		__assign_str(name, skb->dev->name);
 	),
 
-	TP_printk("dev=%s skbaddr=%p len=%u",
+	TP_printk("dev=%s skbaddr=%px len=%u",
 		__get_str(name), __entry->skbaddr, __entry->len)
 )
 
@@ -215,7 +215,7 @@ DECLARE_EVENT_CLASS(net_dev_rx_verbose_template,
 		__entry->gso_type = skb_shinfo(skb)->gso_type;
 	),
 
-	TP_printk("dev=%s napi_id=%#x queue_mapping=%u skbaddr=%p vlan_tagged=%d vlan_proto=0x%04x vlan_tci=0x%04x protocol=0x%04x ip_summed=%d hash=0x%08x l4_hash=%d len=%u data_len=%u truesize=%u mac_header_valid=%d mac_header=%d nr_frags=%d gso_size=%d gso_type=%#x",
+	TP_printk("dev=%s napi_id=%#x queue_mapping=%u skbaddr=%px vlan_tagged=%d vlan_proto=0x%04x vlan_tci=0x%04x protocol=0x%04x ip_summed=%d hash=0x%08x l4_hash=%d len=%u data_len=%u truesize=%u mac_header_valid=%d mac_header=%d nr_frags=%d gso_size=%d gso_type=%#x",
 		  __get_str(name), __entry->napi_id, __entry->queue_mapping,
 		  __entry->skbaddr, __entry->vlan_tagged, __entry->vlan_proto,
 		  __entry->vlan_tci, __entry->protocol, __entry->ip_summed,
diff --git a/include/trace/events/nilfs2.h b/include/trace/events/nilfs2.h
index 84ee31fc04cc..81253bc43e08 100644
--- a/include/trace/events/nilfs2.h
+++ b/include/trace/events/nilfs2.h
@@ -38,7 +38,7 @@ TRACE_EVENT(nilfs2_collection_stage_transition,
 			__entry->stage = sci->sc_stage.scnt;
 		    ),
 
-	    TP_printk("sci = %p stage = %s",
+	    TP_printk("sci = %px stage = %s",
 		      __entry->sci,
 		      show_collection_stage(__entry->stage))
 );
@@ -88,7 +88,7 @@ TRACE_EVENT(nilfs2_transaction_transition,
 		    __entry->state = state;
 		    ),
 
-	    TP_printk("sb = %p ti = %p count = %d flags = %x state = %s",
+	    TP_printk("sb = %px ti = %px count = %d flags = %x state = %s",
 		      __entry->sb,
 		      __entry->ti,
 		      __entry->count,
@@ -115,7 +115,7 @@ TRACE_EVENT(nilfs2_segment_usage_check,
 		    __entry->cnt = cnt;
 		    ),
 
-	    TP_printk("sufile = %p segnum = %llu cnt = %lu",
+	    TP_printk("sufile = %px segnum = %llu cnt = %lu",
 		      __entry->sufile,
 		      __entry->segnum,
 		      __entry->cnt)
@@ -137,7 +137,7 @@ TRACE_EVENT(nilfs2_segment_usage_allocated,
 		    __entry->segnum = segnum;
 		    ),
 
-	    TP_printk("sufile = %p segnum = %llu",
+	    TP_printk("sufile = %px segnum = %llu",
 		      __entry->sufile,
 		      __entry->segnum)
 );
@@ -158,7 +158,7 @@ TRACE_EVENT(nilfs2_segment_usage_freed,
 		    __entry->segnum = segnum;
 		    ),
 
-	    TP_printk("sufile = %p segnum = %llu",
+	    TP_printk("sufile = %px segnum = %llu",
 		      __entry->sufile,
 		      __entry->segnum)
 );
@@ -182,7 +182,7 @@ TRACE_EVENT(nilfs2_mdt_insert_new_block,
 		    __entry->block = block;
 		    ),
 
-	    TP_printk("inode = %p ino = %lu block = %lu",
+	    TP_printk("inode = %px ino = %lu block = %lu",
 		      __entry->inode,
 		      __entry->ino,
 		      __entry->block)
@@ -210,7 +210,7 @@ TRACE_EVENT(nilfs2_mdt_submit_block,
 		    __entry->mode = mode;
 		    ),
 
-	    TP_printk("inode = %p ino = %lu blkoff = %lu mode = %x",
+	    TP_printk("inode = %px ino = %lu blkoff = %lu mode = %x",
 		      __entry->inode,
 		      __entry->ino,
 		      __entry->blkoff,
diff --git a/include/trace/events/objagg.h b/include/trace/events/objagg.h
index fcec0fc9eb0c..353bfca5bf8e 100644
--- a/include/trace/events/objagg.h
+++ b/include/trace/events/objagg.h
@@ -25,7 +25,7 @@ TRACE_EVENT(objagg_create,
 		__entry->objagg = objagg;
 	),
 
-	TP_printk("objagg %p", __entry->objagg)
+	TP_printk("objagg %px", __entry->objagg)
 );
 
 TRACE_EVENT(objagg_destroy,
@@ -41,7 +41,7 @@ TRACE_EVENT(objagg_destroy,
 		__entry->objagg = objagg;
 	),
 
-	TP_printk("objagg %p", __entry->objagg)
+	TP_printk("objagg %px", __entry->objagg)
 );
 
 TRACE_EVENT(objagg_obj_create,
@@ -60,7 +60,7 @@ TRACE_EVENT(objagg_obj_create,
 		__entry->obj = obj;
 	),
 
-	TP_printk("objagg %p, obj %p", __entry->objagg, __entry->obj)
+	TP_printk("objagg %px, obj %px", __entry->objagg, __entry->obj)
 );
 
 TRACE_EVENT(objagg_obj_destroy,
@@ -79,7 +79,7 @@ TRACE_EVENT(objagg_obj_destroy,
 		__entry->obj = obj;
 	),
 
-	TP_printk("objagg %p, obj %p", __entry->objagg, __entry->obj)
+	TP_printk("objagg %px, obj %px", __entry->objagg, __entry->obj)
 );
 
 TRACE_EVENT(objagg_obj_get,
@@ -101,7 +101,7 @@ TRACE_EVENT(objagg_obj_get,
 		__entry->refcount = refcount;
 	),
 
-	TP_printk("objagg %p, obj %p, refcount %u",
+	TP_printk("objagg %px, obj %px, refcount %u",
 		  __entry->objagg, __entry->obj, __entry->refcount)
 );
 
@@ -124,7 +124,7 @@ TRACE_EVENT(objagg_obj_put,
 		__entry->refcount = refcount;
 	),
 
-	TP_printk("objagg %p, obj %p, refcount %u",
+	TP_printk("objagg %px, obj %px, refcount %u",
 		  __entry->objagg, __entry->obj, __entry->refcount)
 );
 
@@ -150,7 +150,7 @@ TRACE_EVENT(objagg_obj_parent_assign,
 		__entry->parent_refcount = parent_refcount;
 	),
 
-	TP_printk("objagg %p, obj %p, parent %p, parent_refcount %u",
+	TP_printk("objagg %px, obj %px, parent %px, parent_refcount %u",
 		  __entry->objagg, __entry->obj,
 		  __entry->parent, __entry->parent_refcount)
 );
@@ -177,7 +177,7 @@ TRACE_EVENT(objagg_obj_parent_unassign,
 		__entry->parent_refcount = parent_refcount;
 	),
 
-	TP_printk("objagg %p, obj %p, parent %p, parent_refcount %u",
+	TP_printk("objagg %px, obj %px, parent %px, parent_refcount %u",
 		  __entry->objagg, __entry->obj,
 		  __entry->parent, __entry->parent_refcount)
 );
@@ -198,7 +198,7 @@ TRACE_EVENT(objagg_obj_root_create,
 		__entry->obj = obj;
 	),
 
-	TP_printk("objagg %p, obj %p",
+	TP_printk("objagg %px, obj %px",
 		  __entry->objagg, __entry->obj)
 );
 
@@ -218,7 +218,7 @@ TRACE_EVENT(objagg_obj_root_destroy,
 		__entry->obj = obj;
 	),
 
-	TP_printk("objagg %p, obj %p",
+	TP_printk("objagg %px, obj %px",
 		  __entry->objagg, __entry->obj)
 );
 
diff --git a/include/trace/events/page_pool.h b/include/trace/events/page_pool.h
index ad0aa7f31675..4f024e7911d3 100644
--- a/include/trace/events/page_pool.h
+++ b/include/trace/events/page_pool.h
@@ -34,7 +34,7 @@ TRACE_EVENT(page_pool_release,
 		__entry->cnt		= pool->destroy_cnt;
 	),
 
-	TP_printk("page_pool=%p inflight=%d hold=%u release=%u cnt=%llu",
+	TP_printk("page_pool=%px inflight=%d hold=%u release=%u cnt=%llu",
 		__entry->pool, __entry->inflight, __entry->hold,
 		__entry->release, __entry->cnt)
 );
@@ -60,7 +60,7 @@ TRACE_EVENT(page_pool_state_release,
 		__entry->pfn		= page_to_pfn(page);
 	),
 
-	TP_printk("page_pool=%p page=%p pfn=%lu release=%u",
+	TP_printk("page_pool=%px page=%px pfn=%lu release=%u",
 		  __entry->pool, __entry->page, __entry->pfn, __entry->release)
 );
 
@@ -85,7 +85,7 @@ TRACE_EVENT(page_pool_state_hold,
 		__entry->pfn	= page_to_pfn(page);
 	),
 
-	TP_printk("page_pool=%p page=%p pfn=%lu hold=%u",
+	TP_printk("page_pool=%px page=%px pfn=%lu hold=%u",
 		  __entry->pool, __entry->page, __entry->pfn, __entry->hold)
 );
 
@@ -107,7 +107,7 @@ TRACE_EVENT(page_pool_update_nid,
 		__entry->new_nid	= new_nid;
 	),
 
-	TP_printk("page_pool=%p pool_nid=%d new_nid=%d",
+	TP_printk("page_pool=%px pool_nid=%d new_nid=%d",
 		  __entry->pool, __entry->pool_nid, __entry->new_nid)
 );
 
diff --git a/include/trace/events/page_ref.h b/include/trace/events/page_ref.h
index 5d2ea93956ce..f6b309f313b4 100644
--- a/include/trace/events/page_ref.h
+++ b/include/trace/events/page_ref.h
@@ -36,7 +36,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
 		__entry->val = v;
 	),
 
-	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d",
+	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%px mt=%d val=%d",
 		__entry->pfn,
 		show_page_flags(__entry->flags & ((1UL << NR_PAGEFLAGS) - 1)),
 		__entry->count,
@@ -86,7 +86,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
 		__entry->ret = ret;
 	),
 
-	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d ret=%d",
+	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%px mt=%d val=%d ret=%d",
 		__entry->pfn,
 		show_page_flags(__entry->flags & ((1UL << NR_PAGEFLAGS) - 1)),
 		__entry->count,
diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagemap.h
index 8fd1babae761..5802dcbf4377 100644
--- a/include/trace/events/pagemap.h
+++ b/include/trace/events/pagemap.h
@@ -49,7 +49,7 @@ TRACE_EVENT(mm_lru_insertion,
 	),
 
 	/* Flag format is based on page-types.c formatting for pagemap */
-	TP_printk("page=%p pfn=%lu lru=%d flags=%s%s%s%s%s%s",
+	TP_printk("page=%px pfn=%lu lru=%d flags=%s%s%s%s%s%s",
 			__entry->page,
 			__entry->pfn,
 			__entry->lru,
@@ -78,7 +78,7 @@ TRACE_EVENT(mm_lru_activate,
 	),
 
 	/* Flag format is based on page-types.c formatting for pagemap */
-	TP_printk("page=%p pfn=%lu", __entry->page, __entry->pfn)
+	TP_printk("page=%px pfn=%lu", __entry->page, __entry->pfn)
 
 );
 
diff --git a/include/trace/events/percpu.h b/include/trace/events/percpu.h
index df112a64f6c9..fea8479b1eec 100644
--- a/include/trace/events/percpu.h
+++ b/include/trace/events/percpu.h
@@ -34,7 +34,7 @@ TRACE_EVENT(percpu_alloc_percpu,
 		__entry->ptr		= ptr;
 	),
 
-	TP_printk("reserved=%d is_atomic=%d size=%zu align=%zu base_addr=%p off=%d ptr=%p",
+	TP_printk("reserved=%d is_atomic=%d size=%zu align=%zu base_addr=%px off=%d ptr=%px",
 		  __entry->reserved, __entry->is_atomic,
 		  __entry->size, __entry->align,
 		  __entry->base_addr, __entry->off, __entry->ptr)
@@ -58,7 +58,7 @@ TRACE_EVENT(percpu_free_percpu,
 		__entry->ptr		= ptr;
 	),
 
-	TP_printk("base_addr=%p off=%d ptr=%p",
+	TP_printk("base_addr=%px off=%d ptr=%px",
 		__entry->base_addr, __entry->off, __entry->ptr)
 );
 
@@ -101,7 +101,7 @@ TRACE_EVENT(percpu_create_chunk,
 		__entry->base_addr	= base_addr;
 	),
 
-	TP_printk("base_addr=%p", __entry->base_addr)
+	TP_printk("base_addr=%px", __entry->base_addr)
 );
 
 TRACE_EVENT(percpu_destroy_chunk,
@@ -118,7 +118,7 @@ TRACE_EVENT(percpu_destroy_chunk,
 		__entry->base_addr	= base_addr;
 	),
 
-	TP_printk("base_addr=%p", __entry->base_addr)
+	TP_printk("base_addr=%px", __entry->base_addr)
 );
 
 #endif /* _TRACE_PERCPU_H */
diff --git a/include/trace/events/pwc.h b/include/trace/events/pwc.h
index a2da764a3b41..c61fc19630b7 100644
--- a/include/trace/events/pwc.h
+++ b/include/trace/events/pwc.h
@@ -28,7 +28,7 @@ TRACE_EVENT(pwc_handler_enter,
 					 ? pdev->fill_buf->filled : 0);
 		__assign_str(name, pdev->v4l2_dev.name);
 	),
-	TP_printk("dev=%s (fbuf=%p filled=%d) urb=%p (status=%d actual_length=%u)",
+	TP_printk("dev=%s (fbuf=%px filled=%d) urb=%px (status=%d actual_length=%u)",
 		__get_str(name),
 		__entry->fbuf,
 		__entry->fbuf__filled,
@@ -52,7 +52,7 @@ TRACE_EVENT(pwc_handler_exit,
 		__entry->fbuf__filled = pdev->fill_buf->filled;
 		__assign_str(name, pdev->v4l2_dev.name);
 	),
-	TP_printk(" dev=%s (fbuf=%p filled=%d) urb=%p",
+	TP_printk(" dev=%s (fbuf=%px filled=%d) urb=%px",
 		__get_str(name),
 		__entry->fbuf,
 		__entry->fbuf__filled,
diff --git a/include/trace/events/pwm.h b/include/trace/events/pwm.h
index cf243de41cc8..12a08df8db3a 100644
--- a/include/trace/events/pwm.h
+++ b/include/trace/events/pwm.h
@@ -30,7 +30,7 @@ DECLARE_EVENT_CLASS(pwm,
 		__entry->enabled = state->enabled;
 	),
 
-	TP_printk("%p: period=%llu duty_cycle=%llu polarity=%d enabled=%d",
+	TP_printk("%px: period=%llu duty_cycle=%llu polarity=%d enabled=%d",
 		  __entry->pwm, __entry->period, __entry->duty_cycle,
 		  __entry->polarity, __entry->enabled)
 
diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
index 330d32d84485..58209557cb3a 100644
--- a/include/trace/events/qdisc.h
+++ b/include/trace/events/qdisc.h
@@ -41,7 +41,7 @@ TRACE_EVENT(qdisc_dequeue,
 		__entry->txq_state	= txq->state;
 	),
 
-	TP_printk("dequeue ifindex=%d qdisc handle=0x%X parent=0x%X txq_state=0x%lX packets=%d skbaddr=%p",
+	TP_printk("dequeue ifindex=%d qdisc handle=0x%X parent=0x%X txq_state=0x%lX packets=%d skbaddr=%px",
 		  __entry->ifindex, __entry->handle, __entry->parent,
 		  __entry->txq_state, __entry->packets, __entry->skbaddr )
 );
diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index ced71237b7e4..2791086138ca 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -500,7 +500,7 @@ TRACE_EVENT_RCU(rcu_callback,
 		__entry->qlen = qlen;
 	),
 
-	TP_printk("%s rhp=%p func=%ps %ld",
+	TP_printk("%s rhp=%px func=%ps %ld",
 		  __entry->rcuname, __entry->rhp, __entry->func,
 		  __entry->qlen)
 );
@@ -534,7 +534,7 @@ TRACE_EVENT_RCU(rcu_kvfree_callback,
 		__entry->qlen = qlen;
 	),
 
-	TP_printk("%s rhp=%p func=%ld %ld",
+	TP_printk("%s rhp=%px func=%ld %ld",
 		  __entry->rcuname, __entry->rhp, __entry->offset,
 		  __entry->qlen)
 );
@@ -591,7 +591,7 @@ TRACE_EVENT_RCU(rcu_invoke_callback,
 		__entry->func = rhp->func;
 	),
 
-	TP_printk("%s rhp=%p func=%ps",
+	TP_printk("%s rhp=%px func=%ps",
 		  __entry->rcuname, __entry->rhp, __entry->func)
 );
 
@@ -620,7 +620,7 @@ TRACE_EVENT_RCU(rcu_invoke_kvfree_callback,
 		__entry->offset	= offset;
 	),
 
-	TP_printk("%s rhp=%p func=%ld",
+	TP_printk("%s rhp=%px func=%ld",
 		  __entry->rcuname, __entry->rhp, __entry->offset)
 );
 
@@ -648,7 +648,7 @@ TRACE_EVENT_RCU(rcu_invoke_kfree_bulk_callback,
 		__entry->p = p;
 	),
 
-	TP_printk("%s bulk=0x%p nr_records=%lu",
+	TP_printk("%s bulk=0x%px nr_records=%lu",
 		__entry->rcuname, __entry->p, __entry->nr_records)
 );
 
@@ -730,7 +730,7 @@ TRACE_EVENT_RCU(rcu_torture_read,
 		__entry->c = c;
 	),
 
-	TP_printk("%s torture read %p %luus c: %lu %lu",
+	TP_printk("%s torture read %px %luus c: %lu %lu",
 		  __entry->rcutorturename, __entry->rhp,
 		  __entry->secs, __entry->c_old, __entry->c)
 );
diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index ffdbe6f85da8..d930360d9e14 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -155,7 +155,7 @@ DECLARE_EVENT_CLASS(rpcgss_ctx_class,
 		__assign_str(principal, gc->gc_principal)
 	),
 
-	TP_printk("cred=%p service=%s principal='%s'",
+	TP_printk("cred=%px service=%s principal='%s'",
 		__entry->cred, show_gss_service(__entry->service),
 		__get_str(principal))
 );
@@ -452,7 +452,7 @@ TRACE_EVENT(rpcgss_update_slack,
 		__entry->verfsize = auth->au_verfsize;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x auth=%p rslack=%u ralign=%u verfsize=%u\n",
+	TP_printk("task:%u@%u xid=0x%08x auth=%px rslack=%u ralign=%u verfsize=%u\n",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->auth, __entry->rslack, __entry->ralign,
 		__entry->verfsize)
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index abe942225637..491f752b1f17 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -82,7 +82,7 @@ DECLARE_EVENT_CLASS(xprtrdma_reply_event,
 		__entry->proc = be32_to_cpu(rep->rr_proc);
 	),
 
-	TP_printk("rxprt %p xid=0x%08x rep=%p: version %u proc %u",
+	TP_printk("rxprt %px xid=0x%08x rep=%px: version %u proc %u",
 		__entry->r_xprt, __entry->xid, __entry->rep,
 		__entry->version, __entry->proc
 	)
@@ -114,7 +114,7 @@ DECLARE_EVENT_CLASS(xprtrdma_rxprt,
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("peer=[%s]:%s r_xprt=%p",
+	TP_printk("peer=[%s]:%s r_xprt=%px",
 		__get_str(addr), __get_str(port), __entry->r_xprt
 	)
 );
@@ -150,7 +150,7 @@ DECLARE_EVENT_CLASS(xprtrdma_connect_class,
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("peer=[%s]:%s r_xprt=%p: rc=%d connection status=%d",
+	TP_printk("peer=[%s]:%s r_xprt=%px: rc=%d connection status=%d",
 		__get_str(addr), __get_str(port), __entry->r_xprt,
 		__entry->rc, __entry->connect_status
 	)
@@ -367,7 +367,7 @@ DECLARE_EVENT_CLASS(xprtrdma_cb_event,
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 	),
 
-	TP_printk("xid=0x%08x, rqst=%p req=%p rep=%p",
+	TP_printk("xid=0x%08x, rqst=%px req=%px rep=%px",
 		__entry->xid, __entry->rqst, __entry->req, __entry->rep
 	)
 );
@@ -447,7 +447,7 @@ TRACE_EVENT(xprtrdma_op_connect,
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("peer=[%s]:%s r_xprt=%p delay=%lu",
+	TP_printk("peer=[%s]:%s r_xprt=%px delay=%lu",
 		__get_str(addr), __get_str(port), __entry->r_xprt,
 		__entry->delay
 	)
@@ -479,7 +479,7 @@ TRACE_EVENT(xprtrdma_op_set_cto,
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("peer=[%s]:%s r_xprt=%p: connect=%lu reconnect=%lu",
+	TP_printk("peer=[%s]:%s r_xprt=%px: connect=%lu reconnect=%lu",
 		__get_str(addr), __get_str(port), __entry->r_xprt,
 		__entry->connect / HZ, __entry->reconnect / HZ
 	)
@@ -543,7 +543,7 @@ TRACE_EVENT(xprtrdma_createmrs,
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("peer=[%s]:%s r_xprt=%p: created %u MRs",
+	TP_printk("peer=[%s]:%s r_xprt=%px: created %u MRs",
 		__get_str(addr), __get_str(port), __entry->r_xprt,
 		__entry->count
 	)
@@ -572,7 +572,7 @@ TRACE_EVENT(xprtrdma_mr_get,
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x req=%p",
+	TP_printk("task:%u@%u xid=0x%08x req=%px",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->req
 	)
@@ -601,7 +601,7 @@ TRACE_EVENT(xprtrdma_nomrs,
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x req=%p",
+	TP_printk("task:%u@%u xid=0x%08x req=%px",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->req
 	)
@@ -755,7 +755,7 @@ TRACE_EVENT(xprtrdma_post_send,
 		__entry->signaled = req->rl_wr.send_flags & IB_SEND_SIGNALED;
 	),
 
-	TP_printk("task:%u@%u req=%p sc=%p (%d SGE%s) %s",
+	TP_printk("task:%u@%u req=%px sc=%px (%d SGE%s) %s",
 		__entry->task_id, __entry->client_id,
 		__entry->req, __entry->sc, __entry->num_sge,
 		(__entry->num_sge == 1 ? "" : "s"),
@@ -778,7 +778,7 @@ TRACE_EVENT(xprtrdma_post_recv,
 		__entry->rep = rep;
 	),
 
-	TP_printk("rep=%p",
+	TP_printk("rep=%px",
 		__entry->rep
 	)
 );
@@ -810,7 +810,7 @@ TRACE_EVENT(xprtrdma_post_recvs,
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("peer=[%s]:%s r_xprt=%p: %u new recvs, %d active (rc %d)",
+	TP_printk("peer=[%s]:%s r_xprt=%px: %u new recvs, %d active (rc %d)",
 		__get_str(addr), __get_str(port), __entry->r_xprt,
 		__entry->count, __entry->posted, __entry->status
 	)
@@ -836,7 +836,7 @@ TRACE_EVENT(xprtrdma_post_linv,
 		__entry->xid = be32_to_cpu(req->rl_slot.rq_xid);
 	),
 
-	TP_printk("req=%p xid=0x%08x status=%d",
+	TP_printk("req=%px xid=0x%08x status=%d",
 		__entry->req, __entry->xid, __entry->status
 	)
 );
@@ -869,7 +869,7 @@ TRACE_EVENT(xprtrdma_wc_send,
 		__entry->vendor_err = __entry->status ? wc->vendor_err : 0;
 	),
 
-	TP_printk("req=%p sc=%p unmapped=%u: %s (%u/0x%x)",
+	TP_printk("req=%px sc=%px unmapped=%u: %s (%u/0x%x)",
 		__entry->req, __entry->sc, __entry->unmap_count,
 		rdma_show_wc_status(__entry->status),
 		__entry->status, __entry->vendor_err
@@ -903,7 +903,7 @@ TRACE_EVENT(xprtrdma_wc_receive,
 		}
 	),
 
-	TP_printk("rep=%p %u bytes: %s (%u/0x%x)",
+	TP_printk("rep=%px %u bytes: %s (%u/0x%x)",
 		__entry->rep, __entry->byte_len,
 		rdma_show_wc_status(__entry->status),
 		__entry->status, __entry->vendor_err
@@ -1090,7 +1090,7 @@ TRACE_EVENT(xprtrdma_reply,
 		__entry->credits = credits;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x, %u credits, rep=%p -> req=%p",
+	TP_printk("task:%u@%u xid=0x%08x, %u credits, rep=%px -> req=%px",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->credits, __entry->rep, __entry->req
 	)
@@ -1117,7 +1117,7 @@ TRACE_EVENT(xprtrdma_defer_cmp,
 		__entry->xid = be32_to_cpu(rep->rr_xid);
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x rep=%p",
+	TP_printk("task:%u@%u xid=0x%08x rep=%px",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->rep
 	)
@@ -1215,7 +1215,7 @@ TRACE_EVENT(xprtrdma_op_allocate,
 		__entry->rcvsize = task->tk_rqstp->rq_rcvsize;
 	),
 
-	TP_printk("task:%u@%u req=%p (%zu, %zu)",
+	TP_printk("task:%u@%u req=%px (%zu, %zu)",
 		__entry->task_id, __entry->client_id,
 		__entry->req, __entry->callsize, __entry->rcvsize
 	)
@@ -1243,7 +1243,7 @@ TRACE_EVENT(xprtrdma_op_free,
 		__entry->rep = req->rl_reply;
 	),
 
-	TP_printk("task:%u@%u req=%p rep=%p",
+	TP_printk("task:%u@%u req=%px rep=%px",
 		__entry->task_id, __entry->client_id,
 		__entry->req, __entry->rep
 	)
@@ -1275,7 +1275,7 @@ TRACE_EVENT(xprtrdma_cb_setup,
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("peer=[%s]:%s r_xprt=%p: %u reqs",
+	TP_printk("peer=[%s]:%s r_xprt=%px: %u reqs",
 		__get_str(addr), __get_str(port),
 		__entry->r_xprt, __entry->reqs
 	)
@@ -1306,7 +1306,7 @@ TRACE_EVENT(xprtrdma_leaked_rep,
 		__entry->rep = rep;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x rep=%p",
+	TP_printk("task:%u@%u xid=0x%08x rep=%px",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->rep
 	)
diff --git a/include/trace/events/rtc.h b/include/trace/events/rtc.h
index 621333f1c890..2d08cbf34a63 100644
--- a/include/trace/events/rtc.h
+++ b/include/trace/events/rtc.h
@@ -174,7 +174,7 @@ DECLARE_EVENT_CLASS(rtc_timer_class,
 		__entry->period = timer->period;
 	),
 
-	TP_printk("RTC timer:(%p) expires:%lld period:%lld",
+	TP_printk("RTC timer:(%px) expires:%lld period:%lld",
 		  __entry->timer, __entry->expires, __entry->period
 	)
 );
diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index c33079b986e8..feaade848dff 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -637,7 +637,7 @@ TRACE_EVENT(rxrpc_call,
 		    __entry->aux = aux;
 			   ),
 
-	    TP_printk("c=%08x %s u=%d sp=%pSR a=%p",
+	    TP_printk("c=%08x %s u=%d sp=%pSR a=%px",
 		      __entry->call,
 		      __print_symbolic(__entry->op, rxrpc_call_traces),
 		      __entry->usage,
@@ -669,7 +669,7 @@ TRACE_EVENT(rxrpc_skb,
 		    __entry->where = where;
 			   ),
 
-	    TP_printk("s=%p %cx %s u=%d m=%d p=%pSR",
+	    TP_printk("s=%px %cx %s u=%d m=%d p=%pSR",
 		      __entry->skb,
 		      __entry->flags & RXRPC_SKB_TX_BUFFER ? 'T' : 'R',
 		      __print_symbolic(__entry->op, rxrpc_skb_traces),
@@ -1420,7 +1420,7 @@ TRACE_EVENT(rxrpc_connect_call,
 		    __entry->call_id = call->call_id;
 			   ),
 
-	    TP_printk("c=%08x u=%p %08x:%08x",
+	    TP_printk("c=%08x u=%px %08x:%08x",
 		      __entry->call,
 		      (void *)__entry->user_call_ID,
 		      __entry->cid,
diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
index 9e92f22eb086..2124ae3ab44d 100644
--- a/include/trace/events/skb.h
+++ b/include/trace/events/skb.h
@@ -30,7 +30,7 @@ TRACE_EVENT(kfree_skb,
 		__entry->protocol = ntohs(skb->protocol);
 	),
 
-	TP_printk("skbaddr=%p protocol=%u location=%p",
+	TP_printk("skbaddr=%px protocol=%u location=%px",
 		__entry->skbaddr, __entry->protocol, __entry->location)
 );
 
@@ -48,7 +48,7 @@ TRACE_EVENT(consume_skb,
 		__entry->skbaddr = skb;
 	),
 
-	TP_printk("skbaddr=%p", __entry->skbaddr)
+	TP_printk("skbaddr=%px", __entry->skbaddr)
 );
 
 TRACE_EVENT(skb_copy_datagram_iovec,
@@ -67,7 +67,7 @@ TRACE_EVENT(skb_copy_datagram_iovec,
 		__entry->len = len;
 	),
 
-	TP_printk("skbaddr=%p len=%d", __entry->skbaddr, __entry->len)
+	TP_printk("skbaddr=%px len=%d", __entry->skbaddr, __entry->len)
 );
 
 #endif /* _TRACE_SKB_H */
diff --git a/include/trace/events/spi.h b/include/trace/events/spi.h
index 0dd9171d2ad8..237167bf8b03 100644
--- a/include/trace/events/spi.h
+++ b/include/trace/events/spi.h
@@ -60,7 +60,7 @@ DECLARE_EVENT_CLASS(spi_message,
 		__entry->msg = msg;
 	),
 
-        TP_printk("spi%d.%d %p", (int)__entry->bus_num,
+        TP_printk("spi%d.%d %px", (int)__entry->bus_num,
 		  (int)__entry->chip_select,
 		  (struct spi_message *)__entry->msg)
 );
@@ -103,7 +103,7 @@ TRACE_EVENT(spi_message_done,
 		__entry->actual = msg->actual_length;
 	),
 
-        TP_printk("spi%d.%d %p len=%u/%u", (int)__entry->bus_num,
+        TP_printk("spi%d.%d %px len=%u/%u", (int)__entry->bus_num,
 		  (int)__entry->chip_select,
 		  (struct spi_message *)__entry->msg,
                   (unsigned)__entry->actual, (unsigned)__entry->frame)
@@ -153,7 +153,7 @@ DECLARE_EVENT_CLASS(spi_transfer,
 			       xfer->rx_buf, __get_dynamic_array_len(rx_buf));
 	),
 
-	TP_printk("spi%d.%d %p len=%d tx=[%*phD] rx=[%*phD]",
+	TP_printk("spi%d.%d %px len=%d tx=[%*phD] rx=[%*phD]",
 		  __entry->bus_num, __entry->chip_select,
 		  __entry->xfer, __entry->len,
 		  __get_dynamic_array_len(tx_buf), __get_dynamic_array(tx_buf),
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 65d7dfbbc9cd..48ecbce89b39 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -77,7 +77,7 @@ DECLARE_EVENT_CLASS(rpc_xdr_buf_class,
 		__entry->msg_len = xdr->len;
 	),
 
-	TP_printk("task:%u@%u head=[%p,%zu] page=%u tail=[%p,%zu] len=%u",
+	TP_printk("task:%u@%u head=[%px,%zu] page=%u tail=[%px,%zu] len=%u",
 		__entry->task_id, __entry->client_id,
 		__entry->head_base, __entry->head_len, __entry->page_len,
 		__entry->tail_base, __entry->tail_len, __entry->msg_len
@@ -642,7 +642,7 @@ TRACE_EVENT(rpc_xdr_overflow,
 	),
 
 	TP_printk(
-		"task:%u@%u %sv%d %s requested=%zu p=%p end=%p xdr=[%p,%zu]/%u/[%p,%zu]/%u\n",
+		"task:%u@%u %sv%d %s requested=%zu p=%px end=%px xdr=[%px,%zu]/%u/[%px,%zu]/%u\n",
 		__entry->task_id, __entry->client_id,
 		__get_str(progname), __entry->version, __get_str(procedure),
 		__entry->requested, __entry->p, __entry->end,
@@ -701,7 +701,7 @@ TRACE_EVENT(rpc_xdr_alignment,
 	),
 
 	TP_printk(
-		"task:%u@%u %sv%d %s offset=%zu copied=%u xdr=[%p,%zu]/%u/[%p,%zu]/%u\n",
+		"task:%u@%u %sv%d %s offset=%zu copied=%u xdr=[%px,%zu]/%u/[%px,%zu]/%u\n",
 		__entry->task_id, __entry->client_id,
 		__get_str(progname), __entry->version, __get_str(procedure),
 		__entry->offset, __entry->copied,
@@ -1231,7 +1231,7 @@ DECLARE_EVENT_CLASS(svc_xdr_buf_class,
 		__entry->msg_len = xdr->len;
 	),
 
-	TP_printk("xid=0x%08x head=[%p,%zu] page=%u tail=[%p,%zu] len=%u",
+	TP_printk("xid=0x%08x head=[%px,%zu] page=%u tail=[%px,%zu] len=%u",
 		__entry->xid,
 		__entry->head_base, __entry->head_len, __entry->page_len,
 		__entry->tail_base, __entry->tail_len, __entry->msg_len
@@ -1664,7 +1664,7 @@ DECLARE_EVENT_CLASS(svc_deferred_event,
 		__assign_str(addr, dr->xprt->xpt_remotebuf);
 	),
 
-	TP_printk("addr=%s dr=%p xid=0x%08x", __get_str(addr), __entry->dr,
+	TP_printk("addr=%s dr=%px xid=0x%08x", __get_str(addr), __entry->dr,
 		__entry->xid)
 );
 
@@ -1886,7 +1886,7 @@ DECLARE_EVENT_CLASS(cache_event,
 		__assign_str(name, cd->name);
 	),
 
-	TP_printk("cache=%s entry=%p", __get_str(name), __entry->h)
+	TP_printk("cache=%s entry=%px", __get_str(name), __entry->h)
 );
 #define DEFINE_CACHE_EVENT(name) \
 	DEFINE_EVENT(cache_event, name, \
diff --git a/include/trace/events/tegra_apb_dma.h b/include/trace/events/tegra_apb_dma.h
index 971cd02d2daf..1a6ec7acadb0 100644
--- a/include/trace/events/tegra_apb_dma.h
+++ b/include/trace/events/tegra_apb_dma.h
@@ -37,7 +37,7 @@ TRACE_EVENT(tegra_dma_complete_cb,
 		__entry->count = count;
 		__entry->ptr = ptr;
 		),
-	TP_printk("channel %s: done %d, ptr %p",
+	TP_printk("channel %s: done %d, ptr %px",
 		  __get_str(chan), __entry->count, __entry->ptr)
 );
 
diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 19abb6c3eb73..477064f98f82 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -23,7 +23,7 @@ DECLARE_EVENT_CLASS(timer_class,
 		__entry->timer	= timer;
 	),
 
-	TP_printk("timer=%p", __entry->timer)
+	TP_printk("timer=%px", __entry->timer)
 );
 
 /**
@@ -73,7 +73,7 @@ TRACE_EVENT(timer_start,
 		__entry->flags		= flags;
 	),
 
-	TP_printk("timer=%p function=%ps expires=%lu [timeout=%ld] cpu=%u idx=%u flags=%s",
+	TP_printk("timer=%px function=%ps expires=%lu [timeout=%ld] cpu=%u idx=%u flags=%s",
 		  __entry->timer, __entry->function, __entry->expires,
 		  (long)__entry->expires - __entry->now,
 		  __entry->flags & TIMER_CPUMASK,
@@ -107,7 +107,7 @@ TRACE_EVENT(timer_expire_entry,
 		__entry->baseclk	= baseclk;
 	),
 
-	TP_printk("timer=%p function=%ps now=%lu baseclk=%lu",
+	TP_printk("timer=%px function=%ps now=%lu baseclk=%lu",
 		  __entry->timer, __entry->function, __entry->now,
 		  __entry->baseclk)
 );
@@ -183,7 +183,7 @@ TRACE_EVENT(hrtimer_init,
 		__entry->mode		= mode;
 	),
 
-	TP_printk("hrtimer=%p clockid=%s mode=%s", __entry->hrtimer,
+	TP_printk("hrtimer=%px clockid=%s mode=%s", __entry->hrtimer,
 		  decode_clockid(__entry->clockid),
 		  decode_hrtimer_mode(__entry->mode))
 );
@@ -214,7 +214,7 @@ TRACE_EVENT(hrtimer_start,
 		__entry->mode		= mode;
 	),
 
-	TP_printk("hrtimer=%p function=%ps expires=%llu softexpires=%llu "
+	TP_printk("hrtimer=%px function=%ps expires=%llu softexpires=%llu "
 		  "mode=%s", __entry->hrtimer, __entry->function,
 		  (unsigned long long) __entry->expires,
 		  (unsigned long long) __entry->softexpires,
@@ -247,7 +247,7 @@ TRACE_EVENT(hrtimer_expire_entry,
 		__entry->function	= hrtimer->function;
 	),
 
-	TP_printk("hrtimer=%p function=%ps now=%llu",
+	TP_printk("hrtimer=%px function=%ps now=%llu",
 		  __entry->hrtimer, __entry->function,
 		  (unsigned long long) __entry->now)
 );
@@ -266,7 +266,7 @@ DECLARE_EVENT_CLASS(hrtimer_class,
 		__entry->hrtimer	= hrtimer;
 	),
 
-	TP_printk("hrtimer=%p", __entry->hrtimer)
+	TP_printk("hrtimer=%px", __entry->hrtimer)
 );
 
 /**
diff --git a/include/trace/events/vb2.h b/include/trace/events/vb2.h
index a40146dea83d..78587f1928d6 100644
--- a/include/trace/events/vb2.h
+++ b/include/trace/events/vb2.h
@@ -33,7 +33,7 @@ DECLARE_EVENT_CLASS(vb2_event_class,
 		__entry->timestamp = vb->timestamp;
 	),
 
-	TP_printk("owner = %p, queued = %u, owned_by_drv = %d, index = %u, "
+	TP_printk("owner = %px, queued = %u, owned_by_drv = %d, index = %u, "
 		  "type = %u, bytesused = %u, timestamp = %llu", __entry->owner,
 		  __entry->queued_count,
 		  __entry->owned_by_drv_count,
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 2070df64958e..88a67b1e68ab 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -215,7 +215,7 @@ TRACE_EVENT(mm_shrink_slab_start,
 		__entry->priority = priority;
 	),
 
-	TP_printk("%pS %p: nid: %d objects to shrink %ld gfp_flags %s cache items %ld delta %lld total_scan %ld priority %d",
+	TP_printk("%pS %px: nid: %d objects to shrink %ld gfp_flags %s cache items %ld delta %lld total_scan %ld priority %d",
 		__entry->shrink,
 		__entry->shr,
 		__entry->nid,
@@ -254,7 +254,7 @@ TRACE_EVENT(mm_shrink_slab_end,
 		__entry->total_scan = total_scan;
 	),
 
-	TP_printk("%pS %p: nid: %d unused scan count %ld new scan count %ld total_scan %ld last shrinker return val %d",
+	TP_printk("%pS %px: nid: %d unused scan count %ld new scan count %ld total_scan %ld last shrinker return val %d",
 		__entry->shrink,
 		__entry->shr,
 		__entry->nid,
@@ -330,7 +330,7 @@ TRACE_EVENT(mm_vmscan_writepage,
 						page_is_file_lru(page));
 	),
 
-	TP_printk("page=%p pfn=%lu flags=%s",
+	TP_printk("page=%px pfn=%lu flags=%s",
 		pfn_to_page(__entry->pfn),
 		__entry->pfn,
 		show_reclaim_flags(__entry->reclaim_flags))
diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqueue.h
index 9b8ae961acc5..60bb99b7596f 100644
--- a/include/trace/events/workqueue.h
+++ b/include/trace/events/workqueue.h
@@ -43,7 +43,7 @@ TRACE_EVENT(workqueue_queue_work,
 		__entry->cpu		= pwq->pool->cpu;
 	),
 
-	TP_printk("work struct=%p function=%ps workqueue=%p req_cpu=%u cpu=%u",
+	TP_printk("work struct=%px function=%ps workqueue=%px req_cpu=%u cpu=%u",
 		  __entry->work, __entry->function, __entry->workqueue,
 		  __entry->req_cpu, __entry->cpu)
 );
@@ -70,7 +70,7 @@ TRACE_EVENT(workqueue_activate_work,
 		__entry->work		= work;
 	),
 
-	TP_printk("work struct %p", __entry->work)
+	TP_printk("work struct %px", __entry->work)
 );
 
 /**
@@ -95,7 +95,7 @@ TRACE_EVENT(workqueue_execute_start,
 		__entry->function	= work->func;
 	),
 
-	TP_printk("work struct %p: function %ps", __entry->work, __entry->function)
+	TP_printk("work struct %px: function %ps", __entry->work, __entry->function)
 );
 
 /**
@@ -121,7 +121,7 @@ TRACE_EVENT(workqueue_execute_end,
 		__entry->function	= function;
 	),
 
-	TP_printk("work struct %p: function %ps", __entry->work, __entry->function)
+	TP_printk("work struct %px: function %ps", __entry->work, __entry->function)
 );
 
 #endif /*  _TRACE_WORKQUEUE_H */
diff --git a/include/trace/events/xdp.h b/include/trace/events/xdp.h
index cd24e8a59529..c485a6f38fca 100644
--- a/include/trace/events/xdp.h
+++ b/include/trace/events/xdp.h
@@ -325,7 +325,7 @@ TRACE_EVENT(mem_disconnect,
 		__entry->allocator	= xa->allocator;
 	),
 
-	TP_printk("mem_id=%d mem_type=%s allocator=%p",
+	TP_printk("mem_id=%d mem_type=%s allocator=%px",
 		  __entry->mem_id,
 		  __print_symbolic(__entry->mem_type, __MEM_TYPE_SYM_TAB),
 		  __entry->allocator
@@ -357,7 +357,7 @@ TRACE_EVENT(mem_connect,
 		__entry->ifindex	= rxq->dev->ifindex;
 	),
 
-	TP_printk("mem_id=%d mem_type=%s allocator=%p"
+	TP_printk("mem_id=%d mem_type=%s allocator=%px"
 		  " ifindex=%d",
 		  __entry->mem_id,
 		  __print_symbolic(__entry->mem_type, __MEM_TYPE_SYM_TAB),
@@ -385,7 +385,7 @@ TRACE_EVENT(mem_return_failed,
 		__entry->mem_type	= mem->type;
 	),
 
-	TP_printk("mem_id=%d mem_type=%s page=%p",
+	TP_printk("mem_id=%d mem_type=%s page=%px",
 		  __entry->mem_id,
 		  __print_symbolic(__entry->mem_type, __MEM_TYPE_SYM_TAB),
 		  __entry->page
diff --git a/include/trace/events/xen.h b/include/trace/events/xen.h
index a5ccfa67bc5c..742284fdac8d 100644
--- a/include/trace/events/xen.h
+++ b/include/trace/events/xen.h
@@ -77,7 +77,7 @@ TRACE_EVENT(xen_mc_callback,
 		    __entry->fn = fn;
 		    __entry->data = data;
 		    ),
-	    TP_printk("callback %ps, data %p",
+	    TP_printk("callback %ps, data %px",
 		      __entry->fn, __entry->data)
 	);
 
@@ -140,7 +140,7 @@ DECLARE_EVENT_CLASS(xen_mmu__set_pte,
 		    ),
 	    TP_fast_assign(__entry->ptep = ptep;
 			   __entry->pteval = pteval.pte),
-	    TP_printk("ptep %p pteval %0*llx (raw %0*llx)",
+	    TP_printk("ptep %px pteval %0*llx (raw %0*llx)",
 		      __entry->ptep,
 		      (int)sizeof(pteval_t) * 2, (unsigned long long)pte_val(native_make_pte(__entry->pteval)),
 		      (int)sizeof(pteval_t) * 2, (unsigned long long)__entry->pteval)
@@ -167,7 +167,7 @@ TRACE_EVENT(xen_mmu_set_pte_at,
 			   __entry->addr = addr;
 			   __entry->ptep = ptep;
 			   __entry->pteval = pteval.pte),
-	    TP_printk("mm %p addr %lx ptep %p pteval %0*llx (raw %0*llx)",
+	    TP_printk("mm %px addr %lx ptep %px pteval %0*llx (raw %0*llx)",
 		      __entry->mm, __entry->addr, __entry->ptep,
 		      (int)sizeof(pteval_t) * 2, (unsigned long long)pte_val(native_make_pte(__entry->pteval)),
 		      (int)sizeof(pteval_t) * 2, (unsigned long long)__entry->pteval)
@@ -184,7 +184,7 @@ TRACE_EVENT(xen_mmu_set_pmd,
 		    ),
 	    TP_fast_assign(__entry->pmdp = pmdp;
 			   __entry->pmdval = pmdval.pmd),
-	    TP_printk("pmdp %p pmdval %0*llx (raw %0*llx)",
+	    TP_printk("pmdp %px pmdval %0*llx (raw %0*llx)",
 		      __entry->pmdp,
 		      (int)sizeof(pmdval_t) * 2, (unsigned long long)pmd_val(native_make_pmd(__entry->pmdval)),
 		      (int)sizeof(pmdval_t) * 2, (unsigned long long)__entry->pmdval)
@@ -204,7 +204,7 @@ TRACE_EVENT(xen_mmu_pte_clear,
 	    TP_fast_assign(__entry->mm = mm;
 			   __entry->addr = addr;
 			   __entry->ptep = ptep),
-	    TP_printk("mm %p addr %lx ptep %p",
+	    TP_printk("mm %px addr %lx ptep %px",
 		      __entry->mm, __entry->addr, __entry->ptep)
 	);
 
@@ -215,7 +215,7 @@ TRACE_EVENT(xen_mmu_pmd_clear,
 		    __field(pmd_t *, pmdp)
 		    ),
 	    TP_fast_assign(__entry->pmdp = pmdp),
-	    TP_printk("pmdp %p", __entry->pmdp)
+	    TP_printk("pmdp %px", __entry->pmdp)
 	);
 #endif
 
@@ -232,7 +232,7 @@ TRACE_EVENT(xen_mmu_set_pud,
 		    ),
 	    TP_fast_assign(__entry->pudp = pudp;
 			   __entry->pudval = native_pud_val(pudval)),
-	    TP_printk("pudp %p pudval %0*llx (raw %0*llx)",
+	    TP_printk("pudp %px pudval %0*llx (raw %0*llx)",
 		      __entry->pudp,
 		      (int)sizeof(pudval_t) * 2, (unsigned long long)pud_val(native_make_pud(__entry->pudval)),
 		      (int)sizeof(pudval_t) * 2, (unsigned long long)__entry->pudval)
@@ -251,7 +251,7 @@ TRACE_EVENT(xen_mmu_set_p4d,
 	    TP_fast_assign(__entry->p4dp = p4dp;
 			   __entry->user_p4dp = user_p4dp;
 			   __entry->p4dval = p4d_val(p4dval)),
-	    TP_printk("p4dp %p user_p4dp %p p4dval %0*llx (raw %0*llx)",
+	    TP_printk("p4dp %px user_p4dp %px p4dval %0*llx (raw %0*llx)",
 		      __entry->p4dp, __entry->user_p4dp,
 		      (int)sizeof(p4dval_t) * 2, (unsigned long long)pgd_val(native_make_pgd(__entry->p4dval)),
 		      (int)sizeof(p4dval_t) * 2, (unsigned long long)__entry->p4dval)
@@ -267,7 +267,7 @@ TRACE_EVENT(xen_mmu_set_pud,
 		    ),
 	    TP_fast_assign(__entry->pudp = pudp;
 			   __entry->pudval = native_pud_val(pudval)),
-	    TP_printk("pudp %p pudval %0*llx (raw %0*llx)",
+	    TP_printk("pudp %px pudval %0*llx (raw %0*llx)",
 		      __entry->pudp,
 		      (int)sizeof(pudval_t) * 2, (unsigned long long)pgd_val(native_make_pgd(__entry->pudval)),
 		      (int)sizeof(pudval_t) * 2, (unsigned long long)__entry->pudval)
@@ -289,7 +289,7 @@ DECLARE_EVENT_CLASS(xen_mmu_ptep_modify_prot,
 			   __entry->addr = addr;
 			   __entry->ptep = ptep;
 			   __entry->pteval = pteval.pte),
-	    TP_printk("mm %p addr %lx ptep %p pteval %0*llx (raw %0*llx)",
+	    TP_printk("mm %px addr %lx ptep %px pteval %0*llx (raw %0*llx)",
 		      __entry->mm, __entry->addr, __entry->ptep,
 		      (int)sizeof(pteval_t) * 2, (unsigned long long)pte_val(native_make_pte(__entry->pteval)),
 		      (int)sizeof(pteval_t) * 2, (unsigned long long)__entry->pteval)
@@ -316,7 +316,7 @@ TRACE_EVENT(xen_mmu_alloc_ptpage,
 			   __entry->pfn = pfn;
 			   __entry->level = level;
 			   __entry->pinned = pinned),
-	    TP_printk("mm %p  pfn %lx  level %d  %spinned",
+	    TP_printk("mm %px  pfn %lx  level %d  %spinned",
 		      __entry->mm, __entry->pfn, __entry->level,
 		      __entry->pinned ? "" : "un")
 	);
@@ -346,7 +346,7 @@ DECLARE_EVENT_CLASS(xen_mmu_pgd,
 		    ),
 	    TP_fast_assign(__entry->mm = mm;
 			   __entry->pgd = pgd),
-	    TP_printk("mm %p pgd %p", __entry->mm, __entry->pgd)
+	    TP_printk("mm %px pgd %px", __entry->mm, __entry->pgd)
 	);
 #define DEFINE_XEN_MMU_PGD_EVENT(name)				\
 	DEFINE_EVENT(xen_mmu_pgd, name,				\
@@ -380,7 +380,7 @@ TRACE_EVENT(xen_mmu_flush_tlb_others,
 			   __entry->mm = mm;
 			   __entry->addr = addr,
 			   __entry->end = end),
-	    TP_printk("ncpus %d mm %p addr %lx, end %lx",
+	    TP_printk("ncpus %d mm %px addr %lx, end %lx",
 		      __entry->ncpus, __entry->mm, __entry->addr, __entry->end)
 	);
 
@@ -411,7 +411,7 @@ TRACE_EVENT(xen_cpu_write_ldt_entry,
 			   __entry->entrynum = entrynum;
 			   __entry->desc = desc;
 		    ),
-	    TP_printk("dt %p  entrynum %d  entry %016llx",
+	    TP_printk("dt %px  entrynum %d  entry %016llx",
 		      __entry->dt, __entry->entrynum,
 		      (unsigned long long)__entry->desc)
 	);
@@ -426,7 +426,7 @@ TRACE_EVENT(xen_cpu_write_idt_entry,
 	    TP_fast_assign(__entry->dt = dt;
 			   __entry->entrynum = entrynum;
 		    ),
-	    TP_printk("dt %p  entrynum %d",
+	    TP_printk("dt %px  entrynum %d",
 		      __entry->dt, __entry->entrynum)
 	);
 
@@ -454,7 +454,7 @@ TRACE_EVENT(xen_cpu_write_gdt_entry,
 			   __entry->desc = *(u64 *)desc;
 			   __entry->type = type;
 		    ),
-	    TP_printk("dt %p  entrynum %d  type %d  desc %016llx",
+	    TP_printk("dt %px  entrynum %d  type %d  desc %016llx",
 		      __entry->dt, __entry->entrynum, __entry->type,
 		      (unsigned long long)__entry->desc)
 	);
@@ -468,7 +468,7 @@ TRACE_EVENT(xen_cpu_set_ldt,
 		    ),
 	    TP_fast_assign(__entry->addr = addr;
 			   __entry->entries = entries),
-	    TP_printk("addr %p  entries %u",
+	    TP_printk("addr %px  entries %u",
 		      __entry->addr, __entry->entries)
 	);
 

