Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5CC26DE40
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgIQO3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:29:49 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44718 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbgIQOZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:25:07 -0400
Received: from [192.168.86.179] (c-73-38-52-84.hsd1.vt.comcast.net [73.38.52.84])
        by linux.microsoft.com (Postfix) with ESMTPSA id EB7DD20B7178;
        Thu, 17 Sep 2020 07:15:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EB7DD20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600352136;
        bh=p3fqxLPIJozFQkWu3Fz+4Wr2YMms5zt1i+JTof0NDzM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=B31bP1QE0UddHqszYBCzAXT06DgGP8/Ki5sH5oKYThqdPSx/iS+tTWb102Oz7tFSA
         y1h6z2HykVxmf7T3n/u6AR3W4odXjVcfcUQCcV0f/7qOtYM71Vum6woq+/Grweba6t
         neUmJzrrhA9QeCSCbCUax8iYsO5iNeSMCjrW6KFo=
Subject: Re: [RFC PATCH v7 11/23] sched/fair: core wide cfs task priority
 comparison
To:     Peter Zijlstra <peterz@infradead.org>,
        Julien Desfossez <jdesfossez@digitalocean.com>
Cc:     Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Aaron Lu <ziqian.lzq@antfin.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <d02923d38df20f1d8c51cf4df6dce66ac0a385ce.1598643276.git.jdesfossez@digitalocean.com>
 <20200828212927.GE29142@worktop.programming.kicks-ass.net>
From:   Vineeth Pillai <viremana@linux.microsoft.com>
Message-ID: <8b9f28f2-7f21-b7da-1056-732b6227ea25@linux.microsoft.com>
Date:   Thu, 17 Sep 2020 10:15:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828212927.GE29142@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 8/28/20 5:29 PM, Peter Zijlstra wrote:
>
> This is still a horrible patch..

I was working on your idea of using the lag as a tool to compare vruntime
across cpus:
https://lwn.net/ml/linux-kernel/20200506143506.GH5298@hirez.programming.kicks-ass.net/
https://lwn.net/ml/linux-kernel/20200514130248.GD2940@hirez.programming.kicks-ass.net/

Basically, I record the clock time when a sibling is force idled. And before
comparison, if the sibling is still force idled, take the weighted delta 
of time
the sibling was force idled and then decrement it from the vruntime. The
lag is  computed in pick_task_fair as we do cross-cpu comparison only after
a task_pick.

I think this can solve the SMTn issues since we are doing a one-sided
comaprison.

I have done some initial testing and looks good. Need to do some deep 
analysis
and check the fairness cases. Thought of sharing the prototype and get 
feedback
as I am doing further testing. Please have a look and let me know your 
thoughts.

The git tree is here: 
https://github.com/vineethrp/linux/tree/coresched/pre-v8-v5.9-rc-lagfix
It has  the review comments addressed since v8 was posted.

Thanks,
Vineeth

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cea9a63c2e7a..52b3e7b356e9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -136,19 +136,8 @@ static inline bool prio_less(struct task_struct *a, 
struct task_struct *b)
         if (pa == -1) /* dl_prio() doesn't work because of stop_class 
above */
                 return !dl_time_before(a->dl.deadline, b->dl.deadline);

-       if (pa == MAX_RT_PRIO + MAX_NICE)  { /* fair */
-               u64 vruntime = b->se.vruntime;
-
-               /*
-                * Normalize the vruntime if tasks are in different cpus.
-                */
-               if (task_cpu(a) != task_cpu(b)) {
-                       vruntime -= task_cfs_rq(b)->min_vruntime;
-                       vruntime += task_cfs_rq(a)->min_vruntime;
-               }
-
-               return !((s64)(a->se.vruntime - vruntime) <= 0);
-       }
+       if (pa == MAX_RT_PRIO + MAX_NICE)       /* fair */
+               return cfs_prio_less(a, b);

         return false;
  }
@@ -235,6 +224,13 @@ static void sched_core_dequeue(struct rq *rq, 
struct task_struct *p)

         rb_erase(&p->core_node, &rq->core_tree);
         RB_CLEAR_NODE(&p->core_node);
+
+    /*
+     * Reset last force idle time if this rq will be
+     * empty after this dequeue.
+     */
+    if (rq->nr_running == 1)
+        rq->core_fi_time = 0;
  }

  /*
@@ -310,8 +306,10 @@ static int __sched_core_stopper(void *data)
                          * cgroup tags. However, dying tasks could still be
                          * left in core queue. Flush them here.
                          */
-                       if (!enabled)
+                       if (!enabled) {
                                 sched_core_flush(cpu);
+                               rq->core_fi_time = 0;
+            }

                         rq->core_enabled = enabled;
                 }
@@ -5181,9 +5179,17 @@ next_class:;
                 if (!rq_i->core_pick)
                         continue;

-               if (is_task_rq_idle(rq_i->core_pick) && rq_i->nr_running &&
-                   !rq_i->core->core_forceidle) {
-                       rq_i->core->core_forceidle = true;
+               if (is_task_rq_idle(rq_i->core_pick) && rq_i->nr_running) {
+
+                       if (!rq_i->core->core_forceidle)
+                               rq_i->core->core_forceidle = true;
+
+                       /*
+                        * XXX: Should we record force idled time a bit 
later on the
+                        * pick_next_task of this sibling when it forces 
itself idle?
+                        */
+                       rq_i->core_fi_time = rq_clock_task(rq_i);
+                       trace_printk("force idle(cpu=%d) TS=%llu\n", i, 
rq_i->core_fi_time);
                 }

                 rq_i->core_pick->core_occupation = occ;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index eadc62930336..7f62a50e23e1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -389,6 +389,12 @@ static inline struct sched_entity 
*parent_entity(struct sched_entity *se)
         return se->parent;
  }

+static inline bool
+is_same_tg(struct sched_entity *se, struct sched_entity *pse)
+{
+       return se->cfs_rq->tg == pse->cfs_rq->tg;
+}
+
  static void
  find_matching_se(struct sched_entity **se, struct sched_entity **pse)
  {
@@ -453,6 +459,12 @@ static inline struct sched_entity 
*parent_entity(struct sched_entity *se)
         return NULL;
  }

+static inline bool
+is_same_tg(struct sched_entity *se, struct sched_entity *pse)
+{
+       return true;
+}
+
  static inline void
  find_matching_se(struct sched_entity **se, struct sched_entity **pse)
  {
@@ -6962,13 +6974,26 @@ static struct task_struct *pick_task_fair(struct 
rq *rq)
  {
         struct cfs_rq *cfs_rq = &rq->cfs;
         struct sched_entity *se;
+       u64 lag = 0;

         if (!cfs_rq->nr_running)
                 return NULL;

+       /*
+        * Calculate the lag caused due to force idle on this
+        * sibling. Since we do cross-cpu comparison of vruntime
+        * only after a task pick, it should be safe to compute
+        * the lag here.
+        */
+       if (rq->core_fi_time) {
+               lag = rq_clock_task(rq) - rq->core_fi_time;
+               if ((s64)lag < 0)
+                       lag = 0;
+       }
         do {
                 struct sched_entity *curr = cfs_rq->curr;

+
                 se = pick_next_entity(cfs_rq, NULL);

                 if (curr) {
@@ -6977,11 +7002,15 @@ static struct task_struct *pick_task_fair(struct 
rq *rq)

                         if (!se || entity_before(curr, se))
                                 se = curr;
+
+                       cfs_rq->core_lag += lag;
                 }

                 cfs_rq = group_cfs_rq(se);
         } while (cfs_rq);

+       rq->core_fi_time = 0;
+
         return task_of(se);
  }
  #endif
@@ -10707,6 +10736,41 @@ static inline void task_tick_core(struct rq 
*rq, struct task_struct *curr)
             __entity_slice_used(&curr->se))
                 resched_curr(rq);
  }
+
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
+{
+       struct sched_entity *se_a = &a->se, *se_b = &b->se;
+       struct cfs_rq *cfs_rq_a, *cfs_rq_b;
+       u64 vruntime_a, vruntime_b;
+
+#ifdef CONFIG_FAIR_GROUP_SCHED
+       while (!is_same_tg(se_a, se_b)) {
+               int se_a_depth = se_a->depth;
+               int se_b_depth = se_b->depth;
+
+               if (se_a_depth <= se_b_depth)
+                       se_b = parent_entity(se_b);
+               if (se_a_depth >= se_b_depth)
+                       se_a = parent_entity(se_a);
+       }
+#endif
+
+       cfs_rq_a = cfs_rq_of(se_a);
+       cfs_rq_b = cfs_rq_of(se_b);
+
+       vruntime_a = se_a->vruntime - cfs_rq_a->min_vruntime;
+       vruntime_b = se_b->vruntime - cfs_rq_b->min_vruntime;
+
+       trace_printk("(%s/%d;%Ld,%Lu) ?< (%s/%d;%Ld,%Lu)\n",
+                    a->comm, a->pid, vruntime_a, cfs_rq_a->core_lag,
+                    b->comm, b->pid, vruntime_b, cfs_rq_b->core_lag);
+       if (cfs_rq_a != cfs_rq_b) {
+               vruntime_a -= calc_delta_fair(cfs_rq_a->core_lag, &a->se);
+               vruntime_b -= calc_delta_fair(cfs_rq_b->core_lag, &b->se);
+       }
+
+       return !((s64)(vruntime_a - vruntime_b) <= 0);
+}
  #else
  static inline void task_tick_core(struct rq *rq, struct task_struct 
*curr) {}
  #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5374ace195b9..a1c15edf8dd5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -607,6 +607,10 @@ struct cfs_rq {
         struct list_head        throttled_list;
  #endif /* CONFIG_CFS_BANDWIDTH */
  #endif /* CONFIG_FAIR_GROUP_SCHED */
+
+#ifdef CONFIG_SCHED_CORE
+       u64                     core_lag;
+#endif
  };

  static inline int rt_bandwidth_enabled(void)
@@ -1056,6 +1060,7 @@ struct rq {
  #ifdef CONFIG_SCHED_CORE
         /* per rq */
         struct rq               *core;
+       u64                     core_fi_time; /* Last forced idle TS */
         struct task_struct      *core_pick;
         unsigned int            core_enabled;
         unsigned int            core_sched_seq;
vineeth@vinstation340u:~/WS/kernel_test/linux-qemu/out$ git show > log
vineeth@vinstation340u:~/WS/kernel_test/linux-qemu/out$ cat log
commit e97ec4d317ac01cabbcdcb1ac8a315a02b3e39f6
Author: Vineeth Pillai <viremana@linux.microsoft.com>
Date:   Wed Sep 16 11:35:37 2020 -0400

     sched/coresched: lag based cross cpu vruntime comparison

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cea9a63c2e7a..52b3e7b356e9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -136,19 +136,8 @@ static inline bool prio_less(struct task_struct *a, 
struct task_struct *b)
      if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
          return !dl_time_before(a->dl.deadline, b->dl.deadline);

-    if (pa == MAX_RT_PRIO + MAX_NICE)  { /* fair */
-        u64 vruntime = b->se.vruntime;
-
-        /*
-         * Normalize the vruntime if tasks are in different cpus.
-         */
-        if (task_cpu(a) != task_cpu(b)) {
-            vruntime -= task_cfs_rq(b)->min_vruntime;
-            vruntime += task_cfs_rq(a)->min_vruntime;
-        }
-
-        return !((s64)(a->se.vruntime - vruntime) <= 0);
-    }
+    if (pa == MAX_RT_PRIO + MAX_NICE)    /* fair */
+        return cfs_prio_less(a, b);

      return false;
  }
@@ -235,6 +224,13 @@ static void sched_core_dequeue(struct rq *rq, 
struct task_struct *p)

      rb_erase(&p->core_node, &rq->core_tree);
      RB_CLEAR_NODE(&p->core_node);
+
+    /*
+     * Reset last force idle time if this rq will be
+     * empty after this dequeue.
+     */
+    if (rq->nr_running == 1)
+        rq->core_fi_time = 0;
  }

  /*
@@ -310,8 +306,10 @@ static int __sched_core_stopper(void *data)
               * cgroup tags. However, dying tasks could still be
               * left in core queue. Flush them here.
               */
-            if (!enabled)
+            if (!enabled) {
                  sched_core_flush(cpu);
+                rq->core_fi_time = 0;
+                /* XXX Reset cfs_rq->core_lag? */
+            }

              rq->core_enabled = enabled;
          }
@@ -5181,9 +5179,17 @@ next_class:;
          if (!rq_i->core_pick)
              continue;

-        if (is_task_rq_idle(rq_i->core_pick) && rq_i->nr_running &&
-            !rq_i->core->core_forceidle) {
-            rq_i->core->core_forceidle = true;
+        if (is_task_rq_idle(rq_i->core_pick) && rq_i->nr_running) {
+
+            if (!rq_i->core->core_forceidle)
+                rq_i->core->core_forceidle = true;
+
+            /*
+             * XXX: Should we record force idled time a bit later on the
+             * pick_next_task of this sibling when it forces itself idle?
+             */
+            rq_i->core_fi_time = rq_clock_task(rq_i);
+            trace_printk("force idle(cpu=%d) TS=%llu\n", i, 
rq_i->core_fi_time);
          }

          rq_i->core_pick->core_occupation = occ;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index eadc62930336..7f62a50e23e1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -389,6 +389,12 @@ static inline struct sched_entity 
*parent_entity(struct sched_entity *se)
      return se->parent;
  }

+static inline bool
+is_same_tg(struct sched_entity *se, struct sched_entity *pse)
+{
+    return se->cfs_rq->tg == pse->cfs_rq->tg;
+}
+
  static void
  find_matching_se(struct sched_entity **se, struct sched_entity **pse)
  {
@@ -453,6 +459,12 @@ static inline struct sched_entity 
*parent_entity(struct sched_entity *se)
      return NULL;
  }

+static inline bool
+is_same_tg(struct sched_entity *se, struct sched_entity *pse)
+{
+    return true;
+}
+
  static inline void
  find_matching_se(struct sched_entity **se, struct sched_entity **pse)
  {
@@ -6962,13 +6974,26 @@ static struct task_struct *pick_task_fair(struct 
rq *rq)
  {
      struct cfs_rq *cfs_rq = &rq->cfs;
      struct sched_entity *se;
+  u64 lag = 0;

      if (!cfs_rq->nr_running)
          return NULL;

+    /*
+     * Calculate the lag caused due to force idle on this
+     * sibling. Since we do cross-cpu comparison of vruntime
+     * only after a task pick, it should be safe to compute
+     * the lag here.
+     */
+    if (rq->core_fi_time) {
+        lag = rq_clock_task(rq) - rq->core_fi_time;
+        if ((s64)lag < 0)
+            lag = 0;
+    }
      do {
          struct sched_entity *curr = cfs_rq->curr;

+
          se = pick_next_entity(cfs_rq, NULL);

          if (curr) {
@@ -6977,11 +7002,15 @@ static struct task_struct *pick_task_fair(struct 
rq *rq)

              if (!se || entity_before(curr, se))
                  se = curr;
+
+            cfs_rq->core_lag += lag;
          }

          cfs_rq = group_cfs_rq(se);
      } while (cfs_rq);

+    rq->core_fi_time = 0;
+
      return task_of(se);
  }
  #endif
@@ -10707,6 +10736,41 @@ static inline void task_tick_core(struct rq 
*rq, struct task_struct *curr)
          __entity_slice_used(&curr->se))
          resched_curr(rq);
  }
+
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
+{
+    struct sched_entity *se_a = &a->se, *se_b = &b->se;
+    struct cfs_rq *cfs_rq_a, *cfs_rq_b;
+    u64 vruntime_a, vruntime_b;
+
+#ifdef CONFIG_FAIR_GROUP_SCHED
+    while (!is_same_tg(se_a, se_b)) {
+        int se_a_depth = se_a->depth;
+        int se_b_depth = se_b->depth;
+
+        if (se_a_depth <= se_b_depth)
+            se_b = parent_entity(se_b);
+        if (se_a_depth >= se_b_depth)
+            se_a = parent_entity(se_a);
+    }
+#endif
+
+    cfs_rq_a = cfs_rq_of(se_a);
+    cfs_rq_b = cfs_rq_of(se_b);
+
+    vruntime_a = se_a->vruntime - cfs_rq_a->min_vruntime;
+    vruntime_b = se_b->vruntime - cfs_rq_b->min_vruntime;
+
+    trace_printk("(%s/%d;%Ld,%Lu) ?< (%s/%d;%Ld,%Lu)\n",
+             a->comm, a->pid, vruntime_a, cfs_rq_a->core_lag,
+             b->comm, b->pid, vruntime_b, cfs_rq_b->core_lag);
+    if (cfs_rq_a != cfs_rq_b) {
+        vruntime_a -= calc_delta_fair(cfs_rq_a->core_lag, &a->se);
+        vruntime_b -= calc_delta_fair(cfs_rq_b->core_lag, &b->se);
+    }
+
+    return !((s64)(vruntime_a - vruntime_b) <= 0);
+}
  #else
  static inline void task_tick_core(struct rq *rq, struct task_struct 
*curr) {}
  #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5374ace195b9..a1c15edf8dd5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -607,6 +607,10 @@ struct cfs_rq {
      struct list_head    throttled_list;
  #endif /* CONFIG_CFS_BANDWIDTH */
  #endif /* CONFIG_FAIR_GROUP_SCHED */
+
+#ifdef CONFIG_SCHED_CORE
+    u64            core_lag;
+#endif
  };

  static inline int rt_bandwidth_enabled(void)
@@ -1056,6 +1060,7 @@ struct rq {
  #ifdef CONFIG_SCHED_CORE
      /* per rq */
      struct rq        *core;
+   u64            core_fi_time; /* Last forced idle TS */
      struct task_struct    *core_pick;
      unsigned int        core_enabled;
      unsigned int        core_sched_seq;
