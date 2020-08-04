Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EB423BA42
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 14:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgHDMYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 08:24:49 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:53814 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgHDMYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 08:24:44 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k2vzl-00AS1k-HE; Tue, 04 Aug 2020 06:24:41 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k2vzk-0006XU-EV; Tue, 04 Aug 2020 06:24:41 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     christian.brauner@ubuntu.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
References: <159644958332.604812.13004003379291842292.stgit@localhost.localdomain>
        <159644977635.604812.1319877322927063560.stgit@localhost.localdomain>
Date:   Tue, 04 Aug 2020 07:21:26 -0500
In-Reply-To: <159644977635.604812.1319877322927063560.stgit@localhost.localdomain>
        (Kirill Tkhai's message of "Mon, 03 Aug 2020 13:16:16 +0300")
Message-ID: <875z9ysit5.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k2vzk-0006XU-EV;;;mid=<875z9ysit5.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19R9qaaQxeRvzEEEsWme4GTLCIFWCXZ+jc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kirill Tkhai <ktkhai@virtuozzo.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 679 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.6%), b_tie_ro: 10 (1.4%), parse: 1.06
        (0.2%), extract_message_metadata: 17 (2.6%), get_uri_detail_list: 3.2
        (0.5%), tests_pri_-1000: 20 (2.9%), tests_pri_-950: 0.97 (0.1%),
        tests_pri_-900: 0.81 (0.1%), tests_pri_-90: 104 (15.4%), check_bayes:
        102 (15.1%), b_tokenize: 11 (1.7%), b_tok_get_all: 10 (1.5%),
        b_comp_prob: 2.1 (0.3%), b_tok_touch_all: 75 (11.1%), b_finish: 1.06
        (0.2%), tests_pri_0: 512 (75.4%), check_dkim_signature: 0.89 (0.1%),
        check_dkim_adsp: 11 (1.6%), poll_dns_idle: 1.16 (0.2%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 6 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/8] ns: Add common refcount into ns_common add use it as counter for net_ns
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Tkhai <ktkhai@virtuozzo.com> writes:

> Currently, every type of namespaces has its own counter,
> which is stored in ns-specific part. Say, @net has
> struct net::count, @pid has struct pid_namespace::kref, etc.
>
> This patchset introduces unified counter for all types
> of namespaces, and converts net namespace to use it first.

And the other refcounts on struct net?

How do they play into what you are trying to do?

For the lack of an explanation.

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>


> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  include/linux/ns_common.h     |    3 +++
>  include/net/net_namespace.h   |   11 ++++-------
>  net/core/net-sysfs.c          |    6 +++---
>  net/core/net_namespace.c      |    6 +++---
>  net/ipv4/inet_timewait_sock.c |    4 ++--
>  net/ipv4/tcp_metrics.c        |    2 +-
>  6 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
> index 5fbc4000358f..0f1d024bd958 100644
> --- a/include/linux/ns_common.h
> +++ b/include/linux/ns_common.h
> @@ -2,12 +2,15 @@
>  #ifndef _LINUX_NS_COMMON_H
>  #define _LINUX_NS_COMMON_H
>  
> +#include <linux/refcount.h>
> +
>  struct proc_ns_operations;
>  
>  struct ns_common {
>  	atomic_long_t stashed;
>  	const struct proc_ns_operations *ops;
>  	unsigned int inum;
> +	refcount_t count;
>  };
>  
>  #endif
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index 2ee5901bec7a..cb4b33d7834b 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -60,9 +60,6 @@ struct net {
>  	refcount_t		passive;	/* To decide when the network
>  						 * namespace should be freed.
>  						 */
> -	refcount_t		count;		/* To decided when the network
> -						 *  namespace should be shut down.
> -						 */
>  	spinlock_t		rules_mod_lock;
>  
>  	unsigned int		dev_unreg_count;
> @@ -245,7 +242,7 @@ void __put_net(struct net *net);
>  
>  static inline struct net *get_net(struct net *net)
>  {
> -	refcount_inc(&net->count);
> +	refcount_inc(&net->ns.count);
>  	return net;
>  }
>  
> @@ -256,14 +253,14 @@ static inline struct net *maybe_get_net(struct net *net)
>  	 * exists.  If the reference count is zero this
>  	 * function fails and returns NULL.
>  	 */
> -	if (!refcount_inc_not_zero(&net->count))
> +	if (!refcount_inc_not_zero(&net->ns.count))
>  		net = NULL;
>  	return net;
>  }
>  
>  static inline void put_net(struct net *net)
>  {
> -	if (refcount_dec_and_test(&net->count))
> +	if (refcount_dec_and_test(&net->ns.count))
>  		__put_net(net);
>  }
>  
> @@ -275,7 +272,7 @@ int net_eq(const struct net *net1, const struct net *net2)
>  
>  static inline int check_net(const struct net *net)
>  {
> -	return refcount_read(&net->count) != 0;
> +	return refcount_read(&net->ns.count) != 0;
>  }
>  
>  void net_drop_ns(void *);
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 9de33b594ff2..655a88b0071c 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -1025,7 +1025,7 @@ net_rx_queue_update_kobjects(struct net_device *dev, int old_num, int new_num)
>  	while (--i >= new_num) {
>  		struct kobject *kobj = &dev->_rx[i].kobj;
>  
> -		if (!refcount_read(&dev_net(dev)->count))
> +		if (!refcount_read(&dev_net(dev)->ns.count))
>  			kobj->uevent_suppress = 1;
>  		if (dev->sysfs_rx_queue_group)
>  			sysfs_remove_group(kobj, dev->sysfs_rx_queue_group);
> @@ -1603,7 +1603,7 @@ netdev_queue_update_kobjects(struct net_device *dev, int old_num, int new_num)
>  	while (--i >= new_num) {
>  		struct netdev_queue *queue = dev->_tx + i;
>  
> -		if (!refcount_read(&dev_net(dev)->count))
> +		if (!refcount_read(&dev_net(dev)->ns.count))
>  			queue->kobj.uevent_suppress = 1;
>  #ifdef CONFIG_BQL
>  		sysfs_remove_group(&queue->kobj, &dql_group);
> @@ -1850,7 +1850,7 @@ void netdev_unregister_kobject(struct net_device *ndev)
>  {
>  	struct device *dev = &ndev->dev;
>  
> -	if (!refcount_read(&dev_net(ndev)->count))
> +	if (!refcount_read(&dev_net(ndev)->ns.count))
>  		dev_set_uevent_suppress(dev, 1);
>  
>  	kobject_get(&dev->kobj);
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index dcd61aca343e..5f658cbedd34 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -44,7 +44,7 @@ static struct key_tag init_net_key_domain = { .usage = REFCOUNT_INIT(1) };
>  #endif
>  
>  struct net init_net = {
> -	.count		= REFCOUNT_INIT(1),
> +	.ns.count	= REFCOUNT_INIT(1),
>  	.dev_base_head	= LIST_HEAD_INIT(init_net.dev_base_head),
>  #ifdef CONFIG_KEYS
>  	.key_domain	= &init_net_key_domain,
> @@ -248,7 +248,7 @@ int peernet2id_alloc(struct net *net, struct net *peer, gfp_t gfp)
>  {
>  	int id;
>  
> -	if (refcount_read(&net->count) == 0)
> +	if (refcount_read(&net->ns.count) == 0)
>  		return NETNSA_NSID_NOT_ASSIGNED;
>  
>  	spin_lock(&net->nsid_lock);
> @@ -328,7 +328,7 @@ static __net_init int setup_net(struct net *net, struct user_namespace *user_ns)
>  	int error = 0;
>  	LIST_HEAD(net_exit_list);
>  
> -	refcount_set(&net->count, 1);
> +	refcount_set(&net->ns.count, 1);
>  	refcount_set(&net->passive, 1);
>  	get_random_bytes(&net->hash_mix, sizeof(u32));
>  	net->dev_base_seq = 1;
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
> index c411c87ae865..437afe392e66 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -272,14 +272,14 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
>  				continue;
>  			tw = inet_twsk(sk);
>  			if ((tw->tw_family != family) ||
> -				refcount_read(&twsk_net(tw)->count))
> +				refcount_read(&twsk_net(tw)->ns.count))
>  				continue;
>  
>  			if (unlikely(!refcount_inc_not_zero(&tw->tw_refcnt)))
>  				continue;
>  
>  			if (unlikely((tw->tw_family != family) ||
> -				     refcount_read(&twsk_net(tw)->count))) {
> +				     refcount_read(&twsk_net(tw)->ns.count))) {
>  				inet_twsk_put(tw);
>  				goto restart;
>  			}
> diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
> index 279db8822439..39710c417565 100644
> --- a/net/ipv4/tcp_metrics.c
> +++ b/net/ipv4/tcp_metrics.c
> @@ -887,7 +887,7 @@ static void tcp_metrics_flush_all(struct net *net)
>  		pp = &hb->chain;
>  		for (tm = deref_locked(*pp); tm; tm = deref_locked(*pp)) {
>  			match = net ? net_eq(tm_net(tm), net) :
> -				!refcount_read(&tm_net(tm)->count);
> +				!refcount_read(&tm_net(tm)->ns.count);
>  			if (match) {
>  				*pp = tm->tcpm_next;
>  				kfree_rcu(tm, rcu_head);
