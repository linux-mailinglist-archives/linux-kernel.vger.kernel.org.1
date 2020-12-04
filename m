Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260962CEFC3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 15:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbgLDOgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 09:36:45 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:57741 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgLDOgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 09:36:44 -0500
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0B4Ea2xo020114;
        Fri, 4 Dec 2020 23:36:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Fri, 04 Dec 2020 23:36:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0B4Ea1rs020111
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 4 Dec 2020 23:36:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] lockdep: Allow tuning tracing capacity constants.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CACT4Y+Zh10241gchu6e_=LwxPSEzXT-0HSmhnTtkXFZevKi_yQ@mail.gmail.com>
 <CACT4Y+a8TjV+Pe6mwne777RV+xB+aHT6GxuMLAVBn5mtK4P0Lw@mail.gmail.com>
 <CACT4Y+ZSsKjvojD8iFVFv9F5X5BvZR8vLyaKrgxUxyknma04Sg@mail.gmail.com>
 <5e8342c4-702f-80a9-e669-8a7386ce0da1@i-love.sakura.ne.jp>
 <CACT4Y+a4X4MNkWsvRySokKE=gO8AH1kegtUQk9T0M37EfWtN-w@mail.gmail.com>
 <CACT4Y+aNJmuhk0KicX4FzKW6PhawFBgvrC2gSJcWwUkR8VSSmg@mail.gmail.com>
 <CACT4Y+ZBVOHD79Mbdpmuxn6OC757BSA7p+JF_YNyUEVfvRFdGQ@mail.gmail.com>
 <CACT4Y+YdpbM44wbObS261CtvC3xfQTamKxkt9eFUwwKGYTELsw@mail.gmail.com>
 <CACT4Y+ZXKwgdML0FxfkXtDqiWWGK3m9bx_i_i+wbQXNh_t4sLA@mail.gmail.com>
 <CACT4Y+asqRbjaN9ras=P5DcxKgzsnV0fvV0tYb2VkT+P00pFvQ@mail.gmail.com>
 <4b89985e-99f9-18bc-0bf1-c883127dc70c@i-love.sakura.ne.jp>
 <CACT4Y+Z=eEHz-MCf8GNxhx8f4asytfQ+2QUhA_0G+zbH2_D2Sg@mail.gmail.com>
 <4b8f7a57-fa20-47bd-48a0-ae35d860f233@i-love.sakura.ne.jp>
Message-ID: <1c351187-253b-2d49-acaf-4563c63ae7d2@i-love.sakura.ne.jp>
Date:   Fri, 4 Dec 2020 23:35:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <4b8f7a57-fa20-47bd-48a0-ae35d860f233@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I attempted some analysis, but I couldn't find which lock is causing nr_list_entries == 32768.
Since "struct lock_list list_entries[MAX_LOCKDEP_ENTRIES]" is marked as "static" variable in lockdep.c ,
none of /proc/lockdep_stats /proc/lockdep /proc/lockdep_chains can report which lock is responsible
for "BUG: MAX_LOCKDEP_ENTRIES too low!" message?

 lock-classes:                         3456 [max: 8192]
 direct dependencies:                 32768 [max: 32768]
 indirect dependencies:              200953
 all direct dependencies:           1213844
 dependency chains:                   56497 [max: 65536]
 dependency chain hlocks used:       249022 [max: 327680]
 dependency chain hlocks lost:            0
 in-hardirq chains:                      88
 in-softirq chains:                    2636
 in-process chains:                   53773
 stack-trace entries:                303496 [max: 524288]
 number of stack traces:              15714
 number of stack hash chains:         10103
 combined max dependencies:hardirq-safe locks:                     57
 hardirq-unsafe locks:                 2613
 softirq-safe locks:                    381
 softirq-unsafe locks:                 2202
 irq-safe locks:                        395
 irq-unsafe locks:                     2613
 hardirq-read-safe locks:                 4
 hardirq-read-unsafe locks:             233
 softirq-read-safe locks:                21
 softirq-read-unsafe locks:             218
 irq-read-safe locks:                    21
 irq-read-unsafe locks:                 233
 uncategorized locks:                   491
 unused locks:                            1
 max locking depth:                      20
 max bfs queue depth:                   749
 debug_locks:                             0

 zapped classes:                        224
 zapped lock chains:                    640
 large chain blocks:                      1

I was able to calculate "lock-classes:" and "indirect dependencies:" from /proc/lockdep , but
I failed to calculate "direct dependencies:" from /proc/lockdep . How can we calculate it?

grep ^FD: CrashLog-12016d55500000 | wc -l
3456

grep -F -- '->' CrashLog-12016d55500000 | wc -l
16004

grep '^ ->' CrashLog-12016d55500000 | wc -l
14014

grep '^ ->' CrashLog-12016d55500000 | sort -u | wc -l
2506

grep ^FD: CrashLog-12016d55500000 | awk ' BEGIN { FD=0; BD=0; } { if ($1 == "FD:") { FD=FD+$2; BD=BD+$4; } } END { print FD" "BD; } '
200953 200856

Top FD entries tend to be long held locks (e.g. workqueue) whereas
top BD entries tend to be short held locks (e.g. scheduler and timekeeping).
But given that this result is from a VM with only 2 CPUs, I think that
this result does not match your

  Examples of bad annotations is getting every CPU a separate class, that
  leads to nr_cpus! chains if CPUs arbitrarily nest (nr_cpus^2 if there's
  only a single nesting level).

case.

awk ' { if ($1 == "FD:") print $2" "$6$7 } ' CrashLog-12016d55500000 | sort -rV | head -n 40
1933 (wq_completion)usb_hub_wq
1932 (work_completion)(&hub->events)
1730 (wq_completion)events
1508 (delayed_fput_work).work
1332 &sb->s_type->i_mutex_key#13
1227 &f->f_pos_lock
1173 sb_writers#5
1095 (wq_completion)netns
1094 net_cleanup_work
1094 masq_mutex
1092 pernet_ops_rwsem
1046 (work_completion)(&m->wq)
1046 (work_completion)(&m->rq)
1045 &pipe->mutex/1
1043 tty_mutex
1042 &tty->legacy_mutex
1039 &p->lock
1035 &tty->legacy_mutex/1
1033 &tty->ldisc_sem
1009 cb_lock
1007 (work_completion)(&nlk->work)
1007 nlk_cb_mutex-GENERIC
1006 genl_mutex
985 sb_writers#8
984 sb_writers#13
984 sb_writers#6
979 &of->mutex
964 (work_completion)(&fw_work->work)
946 (wq_completion)events_power_efficient
943 &rdma_nl_types[idx].sem
942 link_ops_rwsem
939 (wq_completion)gid-cache-wq
937 (work_completion)(&work->work)
937 (work_completion)(&ndev_work->work)
936 devices_rwsem
931 kn->active#88
930 nsim_bus_dev_list_lock
926 rdma_nets_rwsem
924 &device->compat_devs_mutex
922 (wq_completion)ipv6_addrconf

awk ' { if ($3 == "BD:") print $4" "$6$7 } ' CrashLog-12016d55500000 | sort -urV | head -n 40
1618 pool_lock
1617 &obj_hash[i].lock
1510 &base->lock
1489 pvclock_gtod_data
1487 tk_core.seq.seqcount
1465 hrtimer_bases.lock
1460 &per_cpu_ptr(group->pcpu,cpu)->seq
1459 &rt_rq->rt_runtime_lock
1459 &ctx->lock/1
1458 &rt_b->rt_runtime_lock
1458 &ctx->lock
1457 &tsk->delays->lock
1457 &rq->lock/1
1457 &rd->rto_lock
1457 &cp->lock
1457 &cfs_rq->removed.lock
1457 &cfs_b->lock
1457 per_cpu_ptr(&cgroup_rstat_cpu_lock,cpu)
1456 &rq->lock
1299 &p->pi_lock
1266 depot_lock
1114 &____s->seqcount
1085 &n->list_lock
1071 &zone->lock
1039 &x->wait#13
1039 wq_mayday_lock
1038 &pool->lock
869 quarantine_lock
859 &cpuctx_lock
854 rcu_node_0
827 &rcu_state.expedited_wq
812 key#10
808 &memcg->deferred_split_queue.split_queue_lock
807 &pgdat->lru_lock
806 lock#3
804 &eb->refs_lock
798 &mapping->private_lock
788 &rcu_state.gp_wq
782 &page_wait_table[i]
778 pgd_lock

grep -F -- '->kn->active#' CrashLog-12016d55500000 | wc -l
533
grep -F -- '->kn->active#' CrashLog-12016d55500000 | sort -u | wc -l
439



FD:  931 BD:    1 .+.+: kn->active#88
 ->fs_reclaim
 ->&____s->seqcount
 ->kernfs_open_file_mutex
 ->nsim_bus_dev_list_lock
 ->&zone->lock
 ->nsim_bus_dev_list_lock.wait_lock
 ->&p->pi_lock
 ->&rq->lock



FD: 1933 BD:    1 +.+.: (wq_completion)usb_hub_wq
 ->(work_completion)(&hub->events)

FD: 1932 BD:    2 +.+.: (work_completion)(&hub->events)
 ->kcov_remote_lock
 ->&dev->power.lock
 ->fs_reclaim
 ->depot_lock
 ->free_vmap_area_lock
 ->vmap_area_lock
 ->&____s->seqcount
 ->init_mm.page_table_lock
 ->&zone->lock
 ->&rq->lock
 ->&obj_hash[i].lock
 ->&cfs_rq->removed.lock
 ->&kcov->lock

FD:    2 BD:  261 ..-.: kcov_remote_lock
 ->depot_lock

FD:   27 BD:  262 -...: &dev->power.lock
 ->&dev->power.lock/1
 ->&dev->power.wait_queue
 ->&obj_hash[i].lock
 ->&ws->lock

FD:   55 BD:  763 +.+.: fs_reclaim
 ->&rq->lock
 ->&cfs_rq->removed.lock
 ->&obj_hash[i].lock
 ->depot_lock
 ->&mapping->i_mmap_rwsem
 ->mmu_notifier_invalidate_range_start
 ->pgd_lock
 ->&cpuctx_lock
 ->rcu_node_0
 ->&rcu_state.expedited_wq

FD:    1 BD: 1266 ..-.: depot_lock

FD:    9 BD:  378 +.+.: free_vmap_area_lock
 ->&obj_hash[i].lock
 ->depot_lock
 ->init_mm.page_table_lock
 ->quarantine_lock
 ->&zone->lock
 ->&____s->seqcount

FD:    1 BD:  383 +.+.: vmap_area_lock

FD:    1 BD: 1114 ...-: &____s->seqcount

FD:    6 BD:  379 +.+.: init_mm.page_table_lock
 ->pgd_lock
 ->&obj_hash[i].lock
 ->&zone->lock

FD:    2 BD: 1071 ..-.: &zone->lock
 ->&____s->seqcount

FD:   19 BD: 1456 -.-.: &rq->lock
 ->&per_cpu_ptr(group->pcpu, cpu)->seq
 ->&base->lock
 ->&cfs_rq->removed.lock
 ->&rt_b->rt_runtime_lock
 ->&cp->lock
 ->&rt_rq->rt_runtime_lock
 ->tk_core.seq.seqcount
 ->&tsk->delays->lock
 ->&ctx->lock
 ->&rd->rto_lock
 ->&rq->lock/1

FD:    2 BD: 1617 -.-.: &obj_hash[i].lock
 ->pool_lock

FD:    1 BD: 1457 -.-.: &cfs_rq->removed.lock

FD:    3 BD:  260 ..-.: &kcov->lock
 ->kcov_remote_lock

