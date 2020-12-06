Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE652D0007
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 02:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgLFBJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 20:09:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:48134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgLFBJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 20:09:56 -0500
Date:   Sat, 5 Dec 2020 17:09:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1607216955;
        bh=iR0gnDAVARhUhkY/2dG1rFBVInUGVIG+gjXDYhR2BQY=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=NlLIFUqDaA+5U7pK/IsW0oTZeBeL3BcY6kh98GDW5PK3h1gCrTf0CaQwv0H2W93A7
         ZVCwpaldFruv9fzTJoQPDcK49SZIL2o7LHmFxhnFLxFrMdWJUf0lO8TzmlH2Pv1qnB
         zcGbs4XHXMoeXKxuE9egw6fcS/KqR03rEW5oAu3Y=
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     "qiang.zhang@windriver.com" <qiang.zhang@windriver.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "andreyknvl@google.com" <andreyknvl@google.com>,
        "qcai@redhat.com" <qcai@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <walter-zh.wu@mediatek.com>
Subject: Re: [PATCH] kasan: fix slab double free when cpu-hotplug
Message-Id: <20201205170914.e380173074b2deded2ade3d3@linux-foundation.org>
In-Reply-To: <1607185035.22062.42.camel@mtksdccf07>
References: <20201204102206.20237-1-qiang.zhang@windriver.com>
        <1607083295.22062.15.camel@mtksdccf07>
        <20201204172521.ed9f77164ff9f9fc91f35ee0@linux-foundation.org>
        <1607185035.22062.42.camel@mtksdccf07>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Dec 2020 00:17:15 +0800 Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:

> On Fri, 2020-12-04 at 17:25 -0800, Andrew Morton wrote:
> > On Fri, 4 Dec 2020 20:01:35 +0800 Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:
> > 
> > > > diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> > > > index d98b516f372f..55783125a767 100644
> > > > --- a/mm/kasan/quarantine.c
> > > > +++ b/mm/kasan/quarantine.c
> > > > @@ -194,7 +194,6 @@ bool quarantine_put(struct kmem_cache *cache, void *object)
> > > >  
> > > >  	q = this_cpu_ptr(&cpu_quarantine);
> > > >  	if (q->offline) {
> > > > -		qlink_free(&meta->quarantine_link, cache);
> > > >  		local_irq_restore(flags);
> > > >  		return false;
> 
> Hi Andrew,
> 
> Return false will cause slab allocator to free the object.
> Thus, we do not need to qlink_free here to free object twice.
> 
> The return value is introduced from Andrey's patch.
> "kasan: sanitize objects when metadata doesn't fit"
> 
> 
> > > >  	}
> > > 
> > > Hi Qiang,
> > > 
> > > Thanks for fixing this.
> > > Due to that issue, my commit has been removed by Stephen from
> > > linux-next.
> > > 
> > > 
> > > Hi Stephen, Andrew,
> > > 
> > > Should I directly upload the v4 or Stephen can pick the commit which 
> > > has been removed back to the linux-next.
> > 
> > I took care of it.  Restored the original patch and added this one as a
> > -fix.
> 
> Thanks for taking care of it.
> 
> I think there are some problem in the patch you just restored.
> I saw the restored patch is not based on Andrey's patch and Stephen's
> fix conflict patch.
> 
> But the issue Qiang fixed need to be based on the Andrey's patch and
> Stephen's fix conflict patch.
> "kasan: sanitize objects when metadata doesn't fit"
> "kasan-rename-get_alloc-free_info-fix"
> 
> If the restored patch is not based on that, it may cause some problems
> and conflicts.
> 
> I think I can prepare a patch v4 based on Andrey's patch, fix the
> conflict and include the Qiang's modification.

I'm not sure what you mean here.  When appying this fix, yes, I had to
replace "meta" with "info", of course.

So the combined patch, which I'd like to send to Linus next week is as
below.  Is there something wrong with it?


From: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Subject: kasan: fix object remaining in offline per-cpu quarantine

We hit this issue in our internal test.  When enabling generic kasan, a
kfree()'d object is put into per-cpu quarantine first.  If the cpu goes
offline, object still remains in the per-cpu quarantine.  If we call
kmem_cache_destroy() now, slub will report "Objects remaining" error.

[   74.982625] =============================================================================
[   74.983380] BUG test_module_slab (Not tainted): Objects remaining in test_module_slab on __kmem_cache_shutdown()
[   74.984145] -----------------------------------------------------------------------------
[   74.984145]
[   74.984883] Disabling lock debugging due to kernel taint
[   74.985561] INFO: Slab 0x(____ptrval____) objects=34 used=1 fp=0x(____ptrval____) flags=0x2ffff00000010200
[   74.986638] CPU: 3 PID: 176 Comm: cat Tainted: G    B             5.10.0-rc1-00007-g4525c8781ec0-dirty #10
[   74.987262] Hardware name: linux,dummy-virt (DT)
[   74.987606] Call trace:
[   74.987924]  dump_backtrace+0x0/0x2b0
[   74.988296]  show_stack+0x18/0x68
[   74.988698]  dump_stack+0xfc/0x168
[   74.989030]  slab_err+0xac/0xd4
[   74.989346]  __kmem_cache_shutdown+0x1e4/0x3c8
[   74.989779]  kmem_cache_destroy+0x68/0x130
[   74.990176]  test_version_show+0x84/0xf0
[   74.990679]  module_attr_show+0x40/0x60
[   74.991218]  sysfs_kf_seq_show+0x128/0x1c0
[   74.991656]  kernfs_seq_show+0xa0/0xb8
[   74.992059]  seq_read+0x1f0/0x7e8
[   74.992415]  kernfs_fop_read+0x70/0x338
[   74.993051]  vfs_read+0xe4/0x250
[   74.993498]  ksys_read+0xc8/0x180
[   74.993825]  __arm64_sys_read+0x44/0x58
[   74.994203]  el0_svc_common.constprop.0+0xac/0x228
[   74.994708]  do_el0_svc+0x38/0xa0
[   74.995088]  el0_sync_handler+0x170/0x178
[   74.995497]  el0_sync+0x174/0x180
[   74.996050] INFO: Object 0x(____ptrval____) @offset=15848
[   74.996752] INFO: Allocated in test_version_show+0x98/0xf0 age=8188 cpu=6 pid=172
[   75.000802]  stack_trace_save+0x9c/0xd0
[   75.002420]  set_track+0x64/0xf0
[   75.002770]  alloc_debug_processing+0x104/0x1a0
[   75.003171]  ___slab_alloc+0x628/0x648
[   75.004213]  __slab_alloc.isra.0+0x2c/0x58
[   75.004757]  kmem_cache_alloc+0x560/0x588
[   75.005376]  test_version_show+0x98/0xf0
[   75.005756]  module_attr_show+0x40/0x60
[   75.007035]  sysfs_kf_seq_show+0x128/0x1c0
[   75.007433]  kernfs_seq_show+0xa0/0xb8
[   75.007800]  seq_read+0x1f0/0x7e8
[   75.008128]  kernfs_fop_read+0x70/0x338
[   75.008507]  vfs_read+0xe4/0x250
[   75.008990]  ksys_read+0xc8/0x180
[   75.009462]  __arm64_sys_read+0x44/0x58
[   75.010085]  el0_svc_common.constprop.0+0xac/0x228
[   75.011006] kmem_cache_destroy test_module_slab: Slab cache still has objects

Register a cpu hotplug function to remove all objects in the offline
per-cpu quarantine when cpu is going offline.  Set a per-cpu variable to
indicate this cpu is offline.

[qiang.zhang@windriver.com: fix slab double free when cpu-hotplug]
  Link: https://lkml.kernel.org/r/20201204102206.20237-1-qiang.zhang@windriver.com
Link: https://lkml.kernel.org/r/1606895585-17382-2-git-send-email-Kuan-Ying.Lee@mediatek.com
Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: Guangye Yang <guangye.yang@mediatek.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Nicholas Tang <nicholas.tang@mediatek.com>
Cc: Miles Chen <miles.chen@mediatek.com>
Cc: Qian Cai <qcai@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/kasan/quarantine.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

--- a/mm/kasan/quarantine.c~kasan-fix-object-remain-in-offline-per-cpu-quarantine
+++ a/mm/kasan/quarantine.c
@@ -29,6 +29,7 @@
 #include <linux/srcu.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/cpuhotplug.h>
 
 #include "../slab.h"
 #include "kasan.h"
@@ -43,6 +44,7 @@ struct qlist_head {
 	struct qlist_node *head;
 	struct qlist_node *tail;
 	size_t bytes;
+	bool offline;
 };
 
 #define QLIST_INIT { NULL, NULL, 0 }
@@ -188,6 +190,10 @@ void quarantine_put(struct kasan_free_me
 	local_irq_save(flags);
 
 	q = this_cpu_ptr(&cpu_quarantine);
+	if (q->offline) {
+		local_irq_restore(flags);
+		return;
+	}
 	qlist_put(q, &info->quarantine_link, cache->size);
 	if (unlikely(q->bytes > QUARANTINE_PERCPU_SIZE)) {
 		qlist_move_all(q, &temp);
@@ -328,3 +334,36 @@ void quarantine_remove_cache(struct kmem
 
 	synchronize_srcu(&remove_cache_srcu);
 }
+
+static int kasan_cpu_online(unsigned int cpu)
+{
+	this_cpu_ptr(&cpu_quarantine)->offline = false;
+	return 0;
+}
+
+static int kasan_cpu_offline(unsigned int cpu)
+{
+	struct qlist_head *q;
+
+	q = this_cpu_ptr(&cpu_quarantine);
+	/* Ensure the ordering between the writing to q->offline and
+	 * qlist_free_all. Otherwise, cpu_quarantine may be corrupted
+	 * by interrupt.
+	 */
+	WRITE_ONCE(q->offline, true);
+	barrier();
+	qlist_free_all(q, NULL);
+	return 0;
+}
+
+static int __init kasan_cpu_quarantine_init(void)
+{
+	int ret = 0;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mm/kasan:online",
+				kasan_cpu_online, kasan_cpu_offline);
+	if (ret < 0)
+		pr_err("kasan cpu quarantine register failed [%d]\n", ret);
+	return ret;
+}
+late_initcall(kasan_cpu_quarantine_init);
_

