Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CBF263788
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 22:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgIIUfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 16:35:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:23663 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbgIIUfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 16:35:50 -0400
IronPort-SDR: AT4+6uzKQn1KlYVy2+/iyBzpzee2w8H8CHMbFMPxLstrugnArYCM6PpebdL0pisp5x3HmFPAZK
 2OkkRgT5Ke3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="176477990"
X-IronPort-AV: E=Sophos;i="5.76,410,1592895600"; 
   d="scan'208";a="176477990"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 13:35:50 -0700
IronPort-SDR: rUkI05IhT43299trTrqDqsM4iTavdOBJN/CEDnUMB0rH1DaScsLqehNmizGfpb8AA2mGDfyE6N
 Cpg4IuKPX+Nw==
X-IronPort-AV: E=Sophos;i="5.76,410,1592895600"; 
   d="scan'208";a="377977014"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 13:35:49 -0700
Date:   Wed, 9 Sep 2020 13:37:48 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Jacob Pan <jacob.pan.linux@gmail.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Wu Hao <hao.wu@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 6/9] iommu/ioasid: Introduce notification APIs
Message-ID: <20200909133748.3b6682aa@jacob-builder>
In-Reply-To: <20200825102617.GD3252704@myrica>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1598070918-21321-7-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200825102617.GD3252704@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020 12:26:17 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Fri, Aug 21, 2020 at 09:35:15PM -0700, Jacob Pan wrote:
> > Relations among IOASID users largely follow a publisher-subscriber
> > pattern. E.g. to support guest SVA on Intel Scalable I/O
> > Virtualization (SIOV) enabled platforms, VFIO, IOMMU, device
> > drivers, KVM are all users of IOASIDs. When a state change occurs,
> > VFIO publishes the change event that needs to be processed by other
> > users/subscribers.
> > 
> > This patch introduced two types of notifications: global and per
> > ioasid_set. The latter is intended for users who only needs to
> > handle events related to the IOASID of a given set.
> > For more information, refer to the kernel documentation at
> > Documentation/ioasid.rst.
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/ioasid.c | 280
> > ++++++++++++++++++++++++++++++++++++++++++++++++-
> > include/linux/ioasid.h |  70 +++++++++++++ 2 files changed, 348
> > insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> > index c0aef38a4fde..6ddc09a7fe74 100644
> > --- a/drivers/iommu/ioasid.c
> > +++ b/drivers/iommu/ioasid.c
> > @@ -9,8 +9,35 @@
> >  #include <linux/spinlock.h>
> >  #include <linux/xarray.h>
> >  #include <linux/ioasid.h>
> > +#include <linux/sched/mm.h>
> >  
> >  static DEFINE_XARRAY_ALLOC(ioasid_sets);
> > +/*
> > + * An IOASID could have multiple consumers where each consumeer
> > may have  
> 
> consumer
> 
got it

> > + * hardware contexts associated with IOASIDs.
> > + * When a status change occurs, such as IOASID is being freed,
> > notifier chains
> > + * are used to keep the consumers in sync.
> > + * This is a publisher-subscriber pattern where publisher can
> > change the
> > + * state of each IOASID, e.g. alloc/free, bind IOASID to a device
> > and mm.
> > + * On the other hand, subscribers gets notified for the state
> > change and
> > + * keep local states in sync.
> > + *
> > + * Currently, the notifier is global. A further optimization could
> > be per
> > + * IOASID set notifier chain.  
> 
> The patch adds both
> 
right, the comment is old. I will remove the paragraph since it is in
the doc.

> > + */
> > +static ATOMIC_NOTIFIER_HEAD(ioasid_chain);  
> 
> "ioasid_notifier" may be clearer
> 
will do.

> > +
> > +/* List to hold pending notification block registrations */
> > +static LIST_HEAD(ioasid_nb_pending_list);
> > +static DEFINE_SPINLOCK(ioasid_nb_lock);
> > +struct ioasid_set_nb {
> > +	struct list_head	list;
> > +	struct notifier_block	*nb;
> > +	void			*token;
> > +	struct ioasid_set	*set;
> > +	bool			active;
> > +};
> > +
> >  enum ioasid_state {
> >  	IOASID_STATE_INACTIVE,
> >  	IOASID_STATE_ACTIVE,
> > @@ -394,6 +421,7 @@ EXPORT_SYMBOL_GPL(ioasid_find_by_spid);
> >  ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
> > ioasid_t max, void *private)
> >  {
> > +	struct ioasid_nb_args args;
> >  	struct ioasid_data *data;
> >  	void *adata;
> >  	ioasid_t id = INVALID_IOASID;
> > @@ -445,8 +473,14 @@ ioasid_t ioasid_alloc(struct ioasid_set *set,
> > ioasid_t min, ioasid_t max, goto exit_free;
> >  	}
> >  	set->nr_ioasids++;
> > -	goto done_unlock;
> > +	args.id = id;
> > +	/* Set private ID is not attached during allocation */
> > +	args.spid = INVALID_IOASID;
> > +	args.set = set;  
> 
> args.pdata is uninitialized
> 
right, it should be
args.pdata = data->private;

> > +	atomic_notifier_call_chain(&set->nh, IOASID_ALLOC,
> > &args);  
> 
> No global notification?
> 
There hasn't been a need since the only global notifier listener is
vt-d driver which cares about FREE event only.

> >  
> > +	spin_unlock(&ioasid_allocator_lock);
> > +	return id;
> >  exit_free:
> >  	kfree(data);
> >  done_unlock:
> > @@ -479,6 +513,7 @@ static void ioasid_do_free(struct ioasid_data
> > *data) 
> >  static void ioasid_free_locked(struct ioasid_set *set, ioasid_t
> > ioasid) {
> > +	struct ioasid_nb_args args;
> >  	struct ioasid_data *data;
> >  
> >  	data = xa_load(&active_allocator->xa, ioasid);
> > @@ -491,7 +526,16 @@ static void ioasid_free_locked(struct
> > ioasid_set *set, ioasid_t ioasid) pr_warn("Cannot free IOASID %u
> > due to set ownership\n", ioasid); return;
> >  	}
> > +
> >  	data->state = IOASID_STATE_FREE_PENDING;
> > +	/* Notify all users that this IOASID is being freed */
> > +	args.id = ioasid;
> > +	args.spid = data->spid;
> > +	args.pdata = data->private;
> > +	args.set = data->set;
> > +	atomic_notifier_call_chain(&ioasid_chain, IOASID_FREE,
> > &args);
> > +	/* Notify the ioasid_set for per set users */
> > +	atomic_notifier_call_chain(&set->nh, IOASID_FREE, &args);
> >  
> >  	if (!refcount_dec_and_test(&data->users))
> >  		return;
> > @@ -514,6 +558,28 @@ void ioasid_free(struct ioasid_set *set,
> > ioasid_t ioasid) }
> >  EXPORT_SYMBOL_GPL(ioasid_free);
> >  
> > +static void ioasid_add_pending_nb(struct ioasid_set *set)
> > +{
> > +	struct ioasid_set_nb *curr;
> > +
> > +	if (set->type != IOASID_SET_TYPE_MM)
> > +		return;
> > +
> > +	/*
> > +	 * Check if there are any pending nb requests for the
> > given token, if so
> > +	 * add them to the notifier chain.
> > +	 */
> > +	spin_lock(&ioasid_nb_lock);
> > +	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
> > +		if (curr->token == set->token && !curr->active) {
> > +			atomic_notifier_chain_register(&set->nh,
> > curr->nb);
> > +			curr->set = set;
> > +			curr->active = true;
> > +		}
> > +	}
> > +	spin_unlock(&ioasid_nb_lock);
> > +}
> > +
> >  /**
> >   * ioasid_alloc_set - Allocate a new IOASID set for a given token
> >   *
> > @@ -601,6 +667,13 @@ struct ioasid_set *ioasid_alloc_set(void
> > *token, ioasid_t quota, int type) sdata->quota = quota;
> >  	sdata->sid = id;
> >  	refcount_set(&sdata->ref, 1);
> > +	ATOMIC_INIT_NOTIFIER_HEAD(&sdata->nh);
> > +
> > +	/*
> > +	 * Check if there are any pending nb requests for the
> > given token, if so
> > +	 * add them to the notifier chain.
> > +	 */
> > +	ioasid_add_pending_nb(sdata);
> >  
> >  	/*
> >  	 * Per set XA is used to store private IDs within the set,
> > get ready @@ -617,6 +690,30 @@ struct ioasid_set
> > *ioasid_alloc_set(void *token, ioasid_t quota, int type) }
> >  EXPORT_SYMBOL_GPL(ioasid_alloc_set);
> >  
> > +
> > +/*
> > + * ioasid_find_mm_set - Retrieve IOASID set with mm token
> > + * Take a reference of the set if found.
> > + */
> > +static struct ioasid_set *ioasid_find_mm_set(struct mm_struct
> > *token) +{
> > +	struct ioasid_set *sdata, *set = NULL;
> > +	unsigned long index;
> > +
> > +	spin_lock(&ioasid_allocator_lock);
> > +
> > +	xa_for_each(&ioasid_sets, index, sdata) {
> > +		if (sdata->type == IOASID_SET_TYPE_MM &&
> > sdata->token == token) {
> > +			refcount_inc(&sdata->ref);
> > +			set = sdata;
> > +			goto exit_unlock;  
> 
> Or just break
> 
right, but I missed set = NULL outside xa_for_each(). so I have to
keep this goto, i.e.

	spin_lock(&ioasid_allocator_lock);

	xa_for_each(&ioasid_sets, index, set) {
		if (set->type == IOASID_SET_TYPE_MM && set->token ==
token) {
			refcount_inc(&set->ref);
			goto exit_unlock;
		}
	}
	set = NULL;
exit_unlock:
	spin_unlock(&ioasid_allocator_lock);
	return set;


> > +		}
> > +	}
> > +exit_unlock:
> > +	spin_unlock(&ioasid_allocator_lock);
> > +	return set;
> > +}
> > +
> >  void ioasid_set_get_locked(struct ioasid_set *set)
> >  {
> >  	if (WARN_ON(xa_load(&ioasid_sets, set->sid) != set)) {
> > @@ -638,6 +735,8 @@ EXPORT_SYMBOL_GPL(ioasid_set_get);
> >  
> >  void ioasid_set_put_locked(struct ioasid_set *set)
> >  {
> > +	struct ioasid_nb_args args = { 0 };
> > +	struct ioasid_set_nb *curr;
> >  	struct ioasid_data *entry;
> >  	unsigned long index;
> >  
> > @@ -673,8 +772,24 @@ void ioasid_set_put_locked(struct ioasid_set
> > *set) done_destroy:
> >  	/* Return the quota back to system pool */
> >  	ioasid_capacity_avail += set->quota;
> > -	kfree_rcu(set, rcu);
> >  
> > +	/* Restore pending status of the set NBs */
> > +	spin_lock(&ioasid_nb_lock);
> > +	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
> > +		if (curr->token == set->token) {
> > +			if (curr->active)
> > +				curr->active = false;
> > +			else
> > +				pr_warn("Set token exists but not
> > active!\n");
> > +		}
> > +	}
> > +	spin_unlock(&ioasid_nb_lock);
> > +
> > +	args.set = set;
> > +	atomic_notifier_call_chain(&ioasid_chain, IOASID_SET_FREE,
> > &args); +
> > +	kfree_rcu(set, rcu);
> > +	pr_debug("Set freed %d\n", set->sid);  
> 
> set might have been freed
> 
right, will delete this.

> >  	/*
> >  	 * Token got released right away after the ioasid_set is
> > freed.
> >  	 * If a new set is created immediately with the newly
> > released token, @@ -927,6 +1042,167 @@ void *ioasid_find(struct
> > ioasid_set *set, ioasid_t ioasid, }
> >  EXPORT_SYMBOL_GPL(ioasid_find);
> >  
> > +int ioasid_register_notifier(struct ioasid_set *set, struct
> > notifier_block *nb)  
> 
> Maybe add a bit of documentation on the difference with the _mm
> variant, as well as the @set parameter.
> 
> Will this be used by anyone at first?  We could introduce only the _mm
> functions for now.
> 
We do need both variants, VT-d driver registers global notifier with
set=NULL, KVM registers notifier on the mm_struct pointer.
How about the following comments:
/**
 * ioasid_register_notifier_mm - Register a notifier block on the
IOASID set
 *                               created by the mm_struct pointer as
the token *
 * @mm: the mm_struct token of the ioasid_set
 * @nb: notfier block to be registered on the ioasid_set
 *
 * This a variant of ioasid_register_notifier() where the caller
intends to
 * listen to IOASID events belong the ioasid_set created under the same
 * process. Caller is not aware of the ioasid_set, no need to hold
reference
 * of the ioasid_set.
 */

> > +{
> > +	if (set)
> > +		return atomic_notifier_chain_register(&set->nh,
> > nb);
> > +	else
> > +		return
> > atomic_notifier_chain_register(&ioasid_chain, nb); +}
> > +EXPORT_SYMBOL_GPL(ioasid_register_notifier);
> > +
> > +void ioasid_unregister_notifier(struct ioasid_set *set,
> > +				struct notifier_block *nb)
> > +{
> > +	struct ioasid_set_nb *curr;
> > +
> > +	spin_lock(&ioasid_nb_lock);
> > +	/*
> > +	 * Pending list is registered with a token without an
> > ioasid_set,
> > +	 * therefore should not be unregistered directly.
> > +	 */
> > +	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
> > +		if (curr->nb == nb) {
> > +			pr_warn("Cannot unregister NB from pending
> > list\n");
> > +			spin_unlock(&ioasid_nb_lock);
> > +			return;
> > +		}
> > +	}
> > +	spin_unlock(&ioasid_nb_lock);
> > +
> > +	if (set)
> > +		atomic_notifier_chain_unregister(&set->nh, nb);
> > +	else
> > +		atomic_notifier_chain_unregister(&ioasid_chain,
> > nb); +}
> > +EXPORT_SYMBOL_GPL(ioasid_unregister_notifier);
> > +
> > +int ioasid_register_notifier_mm(struct mm_struct *mm, struct
> > notifier_block *nb) +{
> > +	struct ioasid_set_nb *curr;
> > +	struct ioasid_set *set;
> > +	int ret = 0;
> > +
> > +	if (!mm)
> > +		return -EINVAL;
> > +
> > +	spin_lock(&ioasid_nb_lock);
> > +
> > +	/* Check for duplicates, nb is unique per set */
> > +	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
> > +		if (curr->token == mm && curr->nb == nb) {
> > +			ret = -EBUSY;
> > +			goto exit_unlock;
> > +		}
> > +	}
> > +
> > +	/* Check if the token has an existing set */
> > +	set = ioasid_find_mm_set(mm);  
> 
> Seems to be a deadlock here, as ioasid_find_mm_set() grabs
> ioasid_allocator_lock while holding ioasid_nb_lock, and
> ioasid_set_put/get_locked() grabs ioasid_nb_lock while holding
> ioasid_allocator_lock.
> 
Good catch, I will move the nb_lock before allocator lock in
ioasid_set_put.

> > +	if (IS_ERR_OR_NULL(set)) {  
> 
> Looks a bit off, maybe we can check !set since ioasid_find_mm_set()
> doesn't return errors.
> 
will do.

> > +		/* Add to the rsvd list as inactive */
> > +		curr->active = false;  
> 
> curr isn't valid here
>
This is the case where the IOASID set has not been created yet, so we
just put the NB on the pending list. Am I missing your point?
The use case is that when a guest with assigned devices is launched, KVM
and VFIO can be initialized in any order. If KVM starts before VFIO,
which creates the IOASID set, the KVM notifier block will be registered
on the pending list as inactive.

> > +	} else {
> > +		/* REVISIT: Only register empty set for now. Can
> > add an option
> > +		 * in the future to playback existing PASIDs.
> > +		 */
> > +		if (set->nr_ioasids) {
> > +			pr_warn("IOASID set %d not empty\n",
> > set->sid);
> > +			ret = -EBUSY;
> > +			goto exit_unlock;
> > +		}
> > +		curr = kzalloc(sizeof(*curr), GFP_ATOMIC);  
> 
> As a side-note, I think there's too much atomic allocation in this
> file, I'd like to try and rework the locking once it stabilizes and I
> find some time. Do you remember why ioasid_allocator_lock needed to
> be a spinlock?
> 
The spinlock was needed for calling ioasid_free from mmu notifier and
mm_drop().

> > +		if (!curr) {
> > +			ret = -ENOMEM;
> > +			goto exit_unlock;
> > +		}
> > +		curr->token = mm;
> > +		curr->nb = nb;
> > +		curr->active = true;
> > +		curr->set = set;
> > +
> > +		/* Set already created, add to the notifier chain
> > */
> > +		atomic_notifier_chain_register(&set->nh, nb);
> > +		/*
> > +		 * Do not hold a reference, if the set gets
> > destroyed, the nb
> > +		 * entry will be marked inactive.
> > +		 */
> > +		ioasid_set_put(set);
> > +	}
> > +
> > +	list_add(&curr->list, &ioasid_nb_pending_list);
> > +
> > +exit_unlock:
> > +	spin_unlock(&ioasid_nb_lock);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_register_notifier_mm);
> > +
> > +void ioasid_unregister_notifier_mm(struct mm_struct *mm, struct
> > notifier_block *nb) +{
> > +	struct ioasid_set_nb *curr;
> > +
> > +	spin_lock(&ioasid_nb_lock);
> > +	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
> > +		if (curr->token == mm && curr->nb == nb) {
> > +			list_del(&curr->list);
> > +			goto exit_free;
> > +		}
> > +	}
> > +	pr_warn("No ioasid set found for mm token %llx\n",
> > (u64)mm);
> > +	goto done_unlock;
> > +
> > +exit_free:
> > +	if (curr->active) {
> > +		pr_debug("mm set active, unregister %llx\n",
> > +			(u64)mm);  
> 
> %px shows raw pointers, but I would drop this altogether or use %p.
> 
will drop.

> > +		atomic_notifier_chain_unregister(&curr->set->nh,
> > nb);
> > +	}
> > +	kfree(curr);
> > +done_unlock:
> > +	spin_unlock(&ioasid_nb_lock);
> > +	return;
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_unregister_notifier_mm);
> > +
> > +/**
> > + * ioasid_notify - Send notification on a given IOASID for status
> > change.
> > + *                 Used by publishers when the status change may
> > affect
> > + *                 subscriber's internal state.
> > + *
> > + * @ioasid:	The IOASID to which the notification will send
> > + * @cmd:	The notification event
> > + * @flags:	Special instructions, e.g. notify with a set or
> > global  
> 
> Describe valid values for @cmd and @flags?  I guess this function
> shouldn't accept IOASID_ALLOC, IOASID_FREE etc
> 
Good point. only IOASID_BIND and IOASID_UNBIND are allowed.
Will add a check
	/* IOASID_FREE/ALLOC are internal events emitted by IOASID core only */
	if (cmd <= IOASID_FREE)
		return -EINVAL;
And comment:
 * @cmd:	Notification event sent by IOASID external users, can be
 *		IOASID_BIND or IOASID_UNBIND.
 *		
 * @flags:	Special instructions, e.g. notify within a set or global by
 *		IOASID_NOTIFY_SET or IOASID_NOTIFY_ALL flags

> > + */
> > +int ioasid_notify(ioasid_t ioasid, enum ioasid_notify_val cmd,
> > unsigned int flags) +{
> > +	struct ioasid_data *ioasid_data;
> > +	struct ioasid_nb_args args = { 0 };
> > +	int ret = 0;
> > +
> > +	spin_lock(&ioasid_allocator_lock);
> > +	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> > +	if (!ioasid_data) {
> > +		pr_err("Trying to notify unknown IOASID %u\n",
> > ioasid);
> > +		spin_unlock(&ioasid_allocator_lock);
> > +		return -EINVAL;
> > +	}
> > +
> > +	args.id = ioasid;
> > +	args.set = ioasid_data->set;
> > +	args.pdata = ioasid_data->private;
> > +	args.spid = ioasid_data->spid;
> > +	if (flags & IOASID_NOTIFY_ALL) {
> > +		ret = atomic_notifier_call_chain(&ioasid_chain,
> > cmd, &args);
> > +	} else if (flags & IOASID_NOTIFY_SET) {
> > +		ret =
> > atomic_notifier_call_chain(&ioasid_data->set->nh,
> > +						 cmd, &args);
> > +	}  
> 
> else ret = -EINVAL?
> What about allowing both flags?
> 
both flags should be allowed. Let me add a check for valid flags
upfront, then remove the else.

> > +	spin_unlock(&ioasid_allocator_lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_notify);
> > +
> >  MODULE_AUTHOR("Jean-Philippe Brucker
> > <jean-philippe.brucker@arm.com>"); MODULE_AUTHOR("Jacob Pan
> > <jacob.jun.pan@linux.intel.com>"); MODULE_DESCRIPTION("IO Address
> > Space ID (IOASID) allocator"); diff --git a/include/linux/ioasid.h
> > b/include/linux/ioasid.h index d4b3e83672f6..572111cd3b4b 100644
> > --- a/include/linux/ioasid.h
> > +++ b/include/linux/ioasid.h
> > @@ -23,6 +23,7 @@ enum ioasid_set_type {
> >   * struct ioasid_set - Meta data about ioasid_set
> >   * @type:	Token types and other features
> >   * @token:	Unique to identify an IOASID set
> > + * @nh:		Notifier for IOASID events within the set
> >   * @xa:		XArray to store ioasid_set private IDs, can
> > be used for
> >   *		guest-host IOASID mapping, or just a private
> > IOASID namespace.
> >   * @quota:	Max number of IOASIDs can be allocated within
> > the set @@ -32,6 +33,7 @@ enum ioasid_set_type {
> >   */
> >  struct ioasid_set {
> >  	void *token;
> > +	struct atomic_notifier_head nh;
> >  	struct xarray xa;
> >  	int type;
> >  	int quota;
> > @@ -56,6 +58,49 @@ struct ioasid_allocator_ops {
> >  	void *pdata;
> >  };
> >  
> > +/* Notification data when IOASID status changed */
> > +enum ioasid_notify_val {
> > +	IOASID_ALLOC = 1,
> > +	IOASID_FREE,
> > +	IOASID_BIND,
> > +	IOASID_UNBIND,
> > +	IOASID_SET_ALLOC,
> > +	IOASID_SET_FREE,
> > +};  
> 
> May be nicer to prefix these with IOASID_NOTIFY_
> 
yes, good idea. also add FLAG_ to the flags below

> > +
> > +#define IOASID_NOTIFY_ALL BIT(0)
> > +#define IOASID_NOTIFY_SET BIT(1)
> > +/**
> > + * enum ioasid_notifier_prios - IOASID event notification order
> > + *
> > + * When status of an IOASID changes, users might need to take
> > actions to
> > + * reflect the new state. For example, when an IOASID is freed due
> > to
> > + * exception, the hardware context in virtual CPU, DMA device, and
> > IOMMU
> > + * shall be cleared and drained. Order is required to prevent life
> > cycle
> > + * problems.
> > + */
> > +enum ioasid_notifier_prios {
> > +	IOASID_PRIO_LAST,
> > +	IOASID_PRIO_DEVICE,
> > +	IOASID_PRIO_IOMMU,
> > +	IOASID_PRIO_CPU,
> > +};  
> 
> Not used by this patch, can be added later
> 
will do

> > +
> > +/**
> > + * struct ioasid_nb_args - Argument provided by IOASID core when
> > notifier
> > + * is called.
> > + * @id:		The IOASID being notified
> > + * @spid:	The set private ID associated with the IOASID
> > + * @set:	The IOASID set of @id
> > + * @pdata:	The private data attached to the IOASID
> > + */
> > +struct ioasid_nb_args {
> > +	ioasid_t id;
> > +	ioasid_t spid;
> > +	struct ioasid_set *set;
> > +	void *pdata;
> > +};
> > +
> >  #if IS_ENABLED(CONFIG_IOASID)
> >  void ioasid_install_capacity(ioasid_t total);
> >  ioasid_t ioasid_get_capacity(void);
> > @@ -75,8 +120,16 @@ void *ioasid_find(struct ioasid_set *set,
> > ioasid_t ioasid, bool (*getter)(void * int
> > ioasid_attach_data(ioasid_t ioasid, void *data); int
> > ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid); ioasid_t
> > ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid); +
> > +int ioasid_register_notifier(struct ioasid_set *set,
> > +			struct notifier_block *nb);
> > +void ioasid_unregister_notifier(struct ioasid_set *set,
> > +				struct notifier_block *nb);
> > +
> >  int ioasid_register_allocator(struct ioasid_allocator_ops
> > *allocator); void ioasid_unregister_allocator(struct
> > ioasid_allocator_ops *allocator); +
> > +int ioasid_notify(ioasid_t ioasid, enum ioasid_notify_val cmd,
> > unsigned int flags); void ioasid_is_in_set(struct ioasid_set *set,
> > ioasid_t ioasid); int ioasid_get(struct ioasid_set *set, ioasid_t
> > ioasid); int ioasid_get_locked(struct ioasid_set *set, ioasid_t
> > ioasid); @@ -85,6 +138,9 @@ void ioasid_put_locked(struct
> > ioasid_set *set, ioasid_t ioasid); int
> > ioasid_set_for_each_ioasid(struct ioasid_set *sdata, void
> > (*fn)(ioasid_t id, void *data), void *data);
> > +int ioasid_register_notifier_mm(struct mm_struct *mm, struct
> > notifier_block *nb); +void ioasid_unregister_notifier_mm(struct
> > mm_struct *mm, struct notifier_block *nb);  
> 
> These need stubs for !CONFIG_IOASID
> 
got it

> > +
> >  #else /* !CONFIG_IOASID */
> >  static inline void ioasid_install_capacity(ioasid_t total)
> >  {
> > @@ -124,6 +180,20 @@ static inline void *ioasid_find(struct
> > ioasid_set *set, ioasid_t ioasid, bool (* return NULL;
> >  }
> >  
> > +static inline int ioasid_register_notifier(struct notifier_block
> > *nb)  
> 
> Missing set argument
> 
got it


Thanks a lot!
> Thanks,
> Jean
> 
> > +{
> > +	return -ENOTSUPP;
> > +}
> > +
> > +static inline void ioasid_unregister_notifier(struct
> > notifier_block *nb) +{
> > +}
> > +
> > +static inline int ioasid_notify(ioasid_t ioasid, enum
> > ioasid_notify_val cmd, unsigned int flags) +{
> > +	return -ENOTSUPP;
> > +}
> > +
> >  static inline int ioasid_register_allocator(struct
> > ioasid_allocator_ops *allocator) {
> >  	return -ENOTSUPP;
> > -- 
> > 2.7.4
> >   
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

[Jacob Pan]
