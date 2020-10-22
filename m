Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9775B2958C5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505070AbgJVHFB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Oct 2020 03:05:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:38162 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411294AbgJVHFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:05:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9F03AD4A;
        Thu, 22 Oct 2020 07:04:59 +0000 (UTC)
References: <87lfg2ob83.fsf@suse.de>
 <20201019095812.25710-1-rpalethorpe@suse.com>
 <CALvZod6FNH3cZfZxLSFXtQR5bV_2Tese0793Ve9rd1YNW22MKg@mail.gmail.com>
 <87mu0hwik7.fsf@suse.de> <20201020172402.GD46039@blackbook>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Richard Palethorpe <rpalethorpe@suse.de>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Shakeel Butt <shakeelb@google.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Reply-To: rpalethorpe@suse.de
In-reply-to: <20201020172402.GD46039@blackbook>
Date:   Thu, 22 Oct 2020 08:04:58 +0100
Message-ID: <87sga6vizp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Michal Koutný <mkoutny@suse.com> writes:

> Hi.
>
> On Tue, Oct 20, 2020 at 06:52:08AM +0100, Richard Palethorpe <rpalethorpe@suse.de> wrote:
>> I don't think that is relevant as we get the memcg from objcg->memcg
>> which is set during reparenting. I suppose however, we can determine if
>> the objcg was reparented by inspecting memcg->objcg.
> +1
>
>> If we just check use_hierarchy then objects directly charged to the
>> memcg where use_hierarchy=0 will not be uncharged. However, maybe it is
>> better to check if it was reparented and if use_hierarchy=0.
> I think (I had to make a table) the yielded condition would be:
>
> if ((memcg->use_hierarchy && reparented) || (!mem_cgroup_is_root(memcg) && !reparented))

This looks correct, but I don't think we need to check for reparenting
after all. We have the following unique scenarious:

use_hierarchy=1, memcg=?, reparented=?:
Because use_hierarchy=1 any descendants will have charged the current
memcg, including root, so we can simply uncharge regardless of the memcg
or objcg.

use_hierarchy=0, memcg!=root, reparented=?:
When use_hierarchy=0, objcgs are *only* reparented to root, so if we are
not root the objcg must belong to us.

use_hierarchy=0, memcg=root, reparented=?:
We must have been reparented because root is not initialised with an
objcg, but use_hierarchy=0 so we can not uncharge.

So I believe that the following is sufficient.

if (memcg->use_hierarchy || !mem_cgroup_is_root(memcg))
> 	 __memcg_kmem_uncharge(memcg, nr_pages);
>
> (I admit it's not very readable.)
>
>
> Michal

For the record, I did create the following patch which checks for
reparenting, but it appears to be unecessary.

----

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6877c765b8d0..0285f760f003 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -257,6 +257,14 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
 #ifdef CONFIG_MEMCG_KMEM
 extern spinlock_t css_set_lock;

+/* Assumes objcg originated from a descendant of memcg or is memcg's */
+static bool obj_cgroup_did_charge(const struct obj_cgroup *objcg,
+                                 const struct mem_cgroup *memcg)
+{
+       return memcg->use_hierarchy ||
+               rcu_access_pointer(memcg->objcg) == objcg;
+}
+
 static void obj_cgroup_release(struct percpu_ref *ref)
 {
        struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
@@ -291,7 +299,7 @@ static void obj_cgroup_release(struct percpu_ref *ref)

        spin_lock_irqsave(&css_set_lock, flags);
        memcg = obj_cgroup_memcg(objcg);
-       if (nr_pages)
+       if (nr_pages && obj_cgroup_did_charge(objcg, memcg))
                __memcg_kmem_uncharge(memcg, nr_pages);
        list_del(&objcg->list);
        mem_cgroup_put(memcg);
@@ -3100,6 +3108,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 static void drain_obj_stock(struct memcg_stock_pcp *stock)
 {
        struct obj_cgroup *old = stock->cached_objcg;
+       struct mem_cgroup *memcg;

        if (!old)
                return;
@@ -3110,7 +3119,9 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)

                if (nr_pages) {
                        rcu_read_lock();
-                       __memcg_kmem_uncharge(obj_cgroup_memcg(old), nr_pages);
+                       memcg = obj_cgroup_memcg(old);
+                       if (obj_cgroup_did_charge(old, memcg))
+                               __memcg_kmem_uncharge(memcg, nr_pages);
                        rcu_read_unlock();
                }

-- 
Thank you,
Richard.
