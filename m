Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B27D2CD829
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 14:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbgLCNrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 08:47:55 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:63131 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbgLCNry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 08:47:54 -0500
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0B3DlAeW039858;
        Thu, 3 Dec 2020 22:47:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp);
 Thu, 03 Dec 2020 22:47:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0B3DlAXP039853
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Dec 2020 22:47:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] lockdep: Allow tuning tracing capacity constants.
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CACT4Y+ZJNkssAQLuwfcKPTTKLZhHRAo0POGOMVsGFGizoHaNMg@mail.gmail.com>
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
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <4b8f7a57-fa20-47bd-48a0-ae35d860f233@i-love.sakura.ne.jp>
Date:   Thu, 3 Dec 2020 22:47:07 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Z=eEHz-MCf8GNxhx8f4asytfQ+2QUhA_0G+zbH2_D2Sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 22, 2020 at 2:56 AM Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
> Peter, you guessed that the culprit is sysfs at
> https://lkml.kernel.org/r/20200916115057.GO2674@hirez.programming.kicks-ass.net , but
> syzbot reported at https://syzkaller.appspot.com/text?tag=MachineInfo&x=99b8f2b092d9714f
> that "BUG: MAX_LOCKDEP_ENTRIES too low!" can occur on a VM with only 2 CPUs.
> Is your guess catching the culprit?
>
> We could improve a few locks, but as a whole we won't be able to afford keeping
> sum of individual dependencies under current threshold. Therefore, allow lockdep to
> tune the capacity and allow syzkaller to dump when reaching the capacity will be
> the way to go.

An example dump from a VM with only 2 CPUs
( https://syzkaller.appspot.com/text?tag=CrashLog&x=12016d55500000 ) had
a chain with more than kn->active#number 150 entries.

kn->active#number is initialized by __kernfs_create_file() but it is not
deinitialized (there is no method for erasing lockdep map?) by kernfs_put().
Since syzkaller continues object creation/deletion via fuzz testing until
kernel crashes, __kernfs_create_file() are called for so many times?



struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
                                         const char *name,
                                         umode_t mode, kuid_t uid, kgid_t gid,
                                         loff_t size,
                                         const struct kernfs_ops *ops,
                                         void *priv, const void *ns,
                                         struct lock_class_key *key)
{
(...snipped...)
        kn = kernfs_new_node(parent, name, (mode & S_IALLUGO) | S_IFREG,
                             uid, gid, flags);
        if (!kn)
                return ERR_PTR(-ENOMEM);

        kn->attr.ops = ops;
        kn->attr.size = size;
        kn->ns = ns;
        kn->priv = priv;

#ifdef CONFIG_DEBUG_LOCK_ALLOC
        if (key) {
                lockdep_init_map(&kn->dep_map, "kn->active", key, 0);
                kn->flags |= KERNFS_LOCKDEP;
        }
#endif
(...snipped...)
}

void kernfs_put(struct kernfs_node *kn)
{
(...snipped...)
        kmem_cache_free(kernfs_node_cache, kn);
(...snipped...)
}



FD:  919 BD:   59 +.+.: rtnl_mutex
 ->fs_reclaim
 ->depot_lock
 ->pcpu_alloc_mutex
 ->&x->wait#6
 ->&obj_hash[i].lock
 ->gdp_mutex
 ->&k->list_lock
 ->lock#2
 ->kernfs_mutex
 ->bus_type_sem
 ->sysfs_symlink_target_lock
 ->&____s->seqcount
 ->&dev->power.lock
 ->dpm_list_mtx
 ->uevent_sock_mutex
 ->&zone->lock
 ->running_helpers_waitq.lock
 ->subsys mutex#17
 ->dev_hotplug_mutex
 ->dev_base_lock
 ->input_pool.lock
 ->nl_table_lock
 ->nl_table_wait.lock
 ->net_rwsem
 ->&tbl->lock
 ->sysctl_lock
 ->&rq->lock
 ->krc.lock
 ->cpu_hotplug_lock
 ->kthread_create_lock
 ->&p->pi_lock
 ->&cfs_rq->removed.lock
 ->&x->wait
 ->&p->alloc_lock
 ->&cpuset_rwsem
 ->wq_pool_mutex
 ->&crng->lock
 ->rcu_node_0
 ->&rcu_state.expedited_wq
 ->&n->list_lock
 ->&pool->lock
 ->pool_lock
 ->lweventlist_lock
 ->rtnl_mutex.wait_lock
 ->proc_subdir_lock
 ->proc_inum_ida.xa_lock
 ->&k->k_lock
 ->pcpu_lock
 ->param_lock
 ->logbuf_lock
 ->(console_sem).lock
 ->subsys mutex#52
 ->pin_fs_lock
 ->&sb->s_type->i_mutex_key#3
 ->&local->iflist_mtx
 ->&wdev->mtx
 ->subsys mutex#53
 ->&sdata->sec_mtx
 ->&local->iflist_mtx#2
 ->lock#6
 ->net_dm_mutex
 ->failover_lock
 ->&tn->lock
 ->&cn->lock
 ->&ndev->lock
 ->&idev->mc_lock
 ->&mc->mca_lock
 ->&base->lock
 ->j1939_netdev_lock
 ->&pnettable->lock
 ->&vn->sock_lock
 ->&reg_requests_lock
 ->&reg_pending_beacons_lock
 ->&reg_indoor_lock
 ->_xmit_LOOPBACK
 ->(inetaddr_validator_chain).rwsem
 ->(inetaddr_chain).rwsem
 ->&in_dev->mc_tomb_lock
 ->&im->lock
 ->fib_info_lock
 ->cbs_list_lock
 ->taprio_list_lock
 ->(inet6addr_validator_chain).rwsem
 ->addrconf_hash_lock
 ->&ifa->lock
 ->&tb->tb6_lock
 ->rlock-AF_NETLINK
 ->_xmit_ETHER
 ->noop_qdisc.q.lock
 ->quarantine_lock
 ->kernfs_mutex.wait_lock
 ->x25_neigh_list_lock
 ->&mm->mmap_lock#2
 ->free_vmap_area_lock
 ->vmap_area_lock
 ->&ul->lock
 ->&n->lock
 ->&pn->hash_lock
 ->init_mm.page_table_lock
 ->&nr_netdev_addr_lock_key
 ->listen_lock
 ->&r->consumer_lock
 ->batched_entropy_u32.lock
 ->(switchdev_blocking_notif_chain).rwsem
 ->&br->hash_lock
 ->nf_hook_mutex
 ->console_owner_lock
 ->console_owner
 ->&bat_priv->tvlv.handler_list_lock
 ->&bat_priv->tvlv.container_list_lock
 ->&bat_priv->softif_vlan_list_lock
 ->key#14
 ->&bat_priv->tt.changes_list_lock
 ->tk_core.seq.seqcount
 ->&wq->mutex
 ->init_lock
 ->deferred_lock
 ->target_list_lock
 ->&br->lock
 ->&dev_addr_list_lock_key/1
 ->team->team_lock_key
 ->&hard_iface->bat_iv.ogm_buff_mutex
 ->ptype_lock
 ->&hsr->list_lock
 ->&rnp->exp_wq[1]
 ->&rnp->exp_wq[2]
 ->&rnp->exp_wq[3]
 ->&xa->xa_lock#7
 ->&dev_addr_list_lock_key#3/1
 ->req_lock
 ->&x->wait#9
 ->subsys mutex#74
 ->&devlink_port->type_lock
 ->pgd_lock
 ->&dev->tx_global_lock
 ->&rnp->exp_wq[0]
 ->&sch->q.lock
 ->(&tbl->proxy_timer)
 ->class
 ->bpf_devs_lock
 ->devnet_rename_sem
 ->&net->nft.commit_mutex
 ->&ent->pde_unload_lock
 ->team->team_lock_key#2
 ->&wg->device_update_lock
 ->_xmit_SIT
 ->&bridge_netdev_addr_lock_key/1
 ->team->team_lock_key#3
 ->_xmit_NONE
 ->_xmit_TUNNEL
 ->_xmit_IPGRE
 ->mount_lock
 ->team->team_lock_key#4
 ->_xmit_TUNNEL6
 ->team->team_lock_key#5
 ->&dev_addr_list_lock_key#2/1
 ->team->team_lock_key#6
 ->_xmit_ETHER/1
 ->&nn->netlink_tap_lock
 ->&batadv_netdev_addr_lock_key/1
 ->&vlan_netdev_addr_lock_key/1
 ->&macvlan_netdev_addr_lock_key/1
 ->&br->multicast_lock
 ->&macsec_netdev_addr_lock_key/1
 ->key#18
 ->&bat_priv->tt.commit_lock
 ->&sb->s_type->i_lock_key#8
 ->k-slock-AF_INET/1
 ->k-slock-AF_INET#2
 ->k-sk_lock-AF_INET
 ->k-slock-AF_INET6
 ->k-sk_lock-AF_INET6
 ->&ul->lock#2
 ->&____s->seqcount#5
 ->&nf_conntrack_locks[i]
 ->&wdev->event_lock
 ->&wdev->mgmt_registrations_lock
 ->&local->key_mtx
 ->&dentry->d_lock
 ->&sb->s_type->i_lock_key#7
 ->&s->s_inode_list_lock
 ->&xa->xa_lock#4
 ->&rfkill->lock
 ->&local->chanctx_mtx
 ->&data->mutex
 ->&local->queue_stop_reason_lock
 ->&sch->seqlock
 ->&cpuctx_lock
 ->act_mod_lock
 ->&tn->idrinfo->lock
 ->vmap_purge_lock
 ->cpa_lock
 ->&fp->aux->used_maps_mutex
 ->&p->tcfa_lock
 ->slock-AF_INET6
 ->sk_lock-AF_INET6
 ->__ip_vs_mutex
 ->flowtable_lock
 ->&net->xdp.lock
 ->mirred_list_lock
 ->&pnn->pndevs.lock
 ->&pnn->routes.lock
 ->kn->active#164
 ->kn->active#165
 ->kernfs_idr_lock
 ->kn->active#166
 ->kn->active#167
 ->kn->active#168
 ->kn->active#169
 ->kn->active#170
 ->kn->active#171
 ->kn->active#172
 ->kn->active#173
 ->kn->active#174
 ->kn->active#175
 ->dev_pm_qos_sysfs_mtx
 ->kn->active#80
 ->kn->active#81
 ->kn->active#82
 ->kn->active#83
 ->kn->active#84
 ->kn->active#2
 ->kn->active#176
 ->kn->active#177
 ->kn->active#178
 ->kn->active#179
 ->kn->active#180
 ->kn->active#181
 ->kn->active#182
 ->kn->active#183
 ->kn->active#184
 ->kn->active#185
 ->kn->active#186
 ->kn->active#187
 ->kn->active#188
 ->kn->active#189
 ->kn->active#190
 ->kn->active#191
 ->kn->active#192
 ->kn->active#193
 ->kn->active#194
 ->kn->active#195
 ->kn->active#196
 ->kn->active#197
 ->kn->active#198
 ->kn->active#199
 ->kn->active#200
 ->kn->active#53
 ->kn->active#201
 ->kn->active#64
 ->kn->active#63
 ->kn->active#62
 ->kn->active#55
 ->kn->active#56
 ->kn->active#202
 ->kn->active#203
 ->kn->active#54
 ->kn->active#204
 ->kn->active#205
 ->kn->active#206
 ->kn->active#207
 ->kn->active#208
 ->kn->active#209
 ->kn->active#210
 ->kn->active#211
 ->kn->active#212
 ->kn->active#213
 ->kn->active#214
 ->kn->active#215
 ->kn->active#216
 ->kn->active#217
 ->kn->active#218
 ->kn->active#65
 ->kn->active#219
 ->kn->active#220
 ->kn->active#221
 ->kn->active#222
 ->deferred_probe_mutex
 ->wfs_lock
 ->device_links_lock
 ->qdisc_mod_lock
 ->dev->qdisc_running_key ?: &qdisc_running_key
 ->(&q->adapt_timer)
 ->&block->lock
 ->&block->cb_lock
 ->(&q->adapt_timer)#2
 ->&chain->filter_chain_lock
 ->cls_mod_lock
 ->&head->masks_lock
 ->&tp->lock
 ->&tn->idrinfo->lock#2
 ->&block->proto_destroy_lock
 ->lock#10
 ->&tun->lock
 ->wlock-AF_UNSPEC
 ->elock-AF_UNSPEC
 ->kn->active#343
 ->kn->active#344
 ->kn->active#345
 ->pcpu_alloc_mutex.wait_lock
 ->rcu_state.exp_mutex.wait_lock
 ->&rnp->exp_lock
 ->(&fnew->perturb_timer)
 ->ematch_mod_lock
 ->&pn->all_ppp_mutex
 ->&ppp->rlock
 ->&ppp->wlock
 ->&dev_addr_list_lock_key#4
 ->&pf->rwait
 ->&macvlan_netdev_addr_lock_key/2
 ->kn->active#71
 ->&dev->devres_lock
 ->kn->active#346
 ->kn->active#347
 ->kn->active#348
 ->kn->active#349
 ->rcu_state.exp_mutex
 ->&tn->idrinfo->lock#3
 ->netdev_unregistering_wq.lock
 ->&(&net->nexthop.notifier_chain)->rwsem
 ->&caifn->caifdevs.lock
 ->&net->rules_mod_lock
 ->(&mrt->ipmr_expire_timer)
 ->&ht->mutex
 ->nf_connlabels_lock
 ->&tn->idrinfo->lock#4
 ->zones_mutex
 ->uevent_sock_mutex.wait_lock
 ->napi_hash_lock
 ->kn->active#356
 ->kn->active#357
 ->kn->active#358
 ->kn->active#359
 ->kn->active#360
 ->kn->active#361
 ->kn->active#362
 ->kn->active#363
 ->kn->active#364
 ->kn->active#365
 ->kn->active#366
 ->kn->active#367
 ->kn->active#368
 ->kn->active#369
 ->kn->active#370
 ->kn->active#371
 ->kn->active#372
 ->kn->active#373
 ->kn->active#374
 ->kn->active#375
 ->kn->active#376
 ->kn->active#377
 ->kn->active#378
 ->kn->active#379
 ->kn->active#380
 ->kn->active#381
 ->kn->active#382
 ->kn->active#383
 ->kn->active#384
 ->kn->active#385
 ->kn->active#386
 ->kn->active#387
 ->kn->active#388
 ->kn->active#389
 ->kn->active#390
 ->kn->active#391
 ->kn->active#392
 ->kn->active#393
 ->kn->active#394
 ->kn->active#395
 ->kn->active#396
 ->kn->active#397
 ->kn->active#398
 ->kn->active#399
 ->kn->active#400
 ->kn->active#401
 ->&bridge_netdev_addr_lock_key
 ->rcu_state.barrier_mutex
 ->&app->lock#2
 ->(&app->join_timer)#2
 ->(&app->periodic_timer)
 ->&list->lock#13
 ->(&app->join_timer)
 ->&app->lock
 ->&list->lock#12
 ->&tn->idrinfo->lock#5
 ->ife_mod_lock
 ->_xmit_NETROM#2
 ->&this->info_list_lock
 ->&local->mtx
 ->&lock->wait_lock
 ->&list->lock#2
 ->(&port->multicast_router_timer)
 ->kn->active#404
 ->kn->active#405
 ->kn->active#406
 ->kn->active#407
 ->kn->active#408
 ->kn->active#409
 ->kn->active#410
 ->kn->active#411
 ->kn->active#412
 ->kn->active#413
 ->kn->active#414
 ->kn->active#415
 ->kn->active#416
 ->kn->active#417
 ->kn->active#418
 ->kn->active#419
 ->kn->active#420
 ->kn->active#421
 ->kn->active#422
 ->kn->active#423
 ->kn->active#424
 ->kn->active#425
 ->kn->active#426
 ->kn->active#427
 ->kn->active#428
 ->kn->active#429
 ->kn->active#430
 ->kn->active#431
 ->kn->active#432
 ->kn->active#433
 ->kn->active#434
 ->&tn->idrinfo->lock#6
 ->&local->sta_mtx
 ->acaddr_hash_lock
 ->(&br->hello_timer)
 ->(&br->topology_change_timer)
 ->(&br->tcn_timer)
 ->(&br->multicast_router_timer)
 ->(&br->ip4_other_query.timer)
 ->(&br->ip4_own_query.timer)
 ->(&br->ip6_other_query.timer)
 ->(&br->ip6_own_query.timer)
 ->slock-AF_CAN
 ->sk_lock-AF_CAN
 ->&list->lock#16
 ->&wg->socket_update_lock
 ->&table->hash[i].lock
 ->k-clock-AF_INET
 ->k-clock-AF_INET6
 ->&mc_lst->sflock
 ->&tn->idrinfo->lock#7
 ->_xmit_AX25
 ->&bridge_netdev_addr_lock_key/2
 ->fastmap_lock
