Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838732F68C5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbhANSCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:02:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728263AbhANSCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:02:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610647264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FapA4vhg2rDn9t+L/1ayUWQaLzRkhjrbLFI4BlKxiy8=;
        b=BCe/pDv9UZftDydJGAlmUH97JcaJH925u08R4ta9PGTYNFkp9vnx0LdCnGbtK/0Ughpp/l
        w1xAmn8gLVrC1pU9ddpdmsUeW1He+jDAicC69y6YDOI6KDq2hDPvhaoGmMsIIg2Cc41o19
        j+sGQWEsBNcTpAKD9SdY3AI8XDaa8a4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-ab4WPfZ1NJ-ecKvoY9DOnw-1; Thu, 14 Jan 2021 13:01:02 -0500
X-MC-Unique: ab4WPfZ1NJ-ecKvoY9DOnw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D47B2904A8E;
        Thu, 14 Jan 2021 18:00:50 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 671D712D7E;
        Thu, 14 Jan 2021 18:00:50 +0000 (UTC)
Date:   Thu, 14 Jan 2021 13:00:49 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v3 3/6] dm: add support for passing through inline crypto
 support
Message-ID: <20210114180049.GA26410@redhat.com>
References: <20201229085524.2795331-1-satyat@google.com>
 <20201229085524.2795331-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229085524.2795331-4-satyat@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29 2020 at  3:55am -0500,
Satya Tangirala <satyat@google.com> wrote:

> Update the device-mapper core to support exposing the inline crypto
> support of the underlying device(s) through the device-mapper device.
> 
> This works by creating a "passthrough keyslot manager" for the dm
> device, which declares support for encryption settings which all
> underlying devices support.  When a supported setting is used, the bio
> cloning code handles cloning the crypto context to the bios for all the
> underlying devices.  When an unsupported setting is used, the blk-crypto
> fallback is used as usual.
> 
> Crypto support on each underlying device is ignored unless the
> corresponding dm target opts into exposing it.  This is needed because
> for inline crypto to semantically operate on the original bio, the data
> must not be transformed by the dm target.  Thus, targets like dm-linear
> can expose crypto support of the underlying device, but targets like
> dm-crypt can't.  (dm-crypt could use inline crypto itself, though.)
> 
> A DM device's table can only be changed if the "new" inline encryption
> capabilities are a (*not* necessarily strict) superset of the "old" inline
> encryption capabilities.  Attempts to make changes to the table that result
> in some inline encryption capability becoming no longer supported will be
> rejected.
> 
> For the sake of clarity, key eviction from underlying devices will be
> handled in a future patch.
> 
> Co-developed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  drivers/md/dm.c                 | 164 +++++++++++++++++++++++++++++++-
>  include/linux/device-mapper.h   |   6 ++
>  include/linux/keyslot-manager.h |   8 ++
>  3 files changed, 177 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index b3c3c8b4cb42..13b9c8e2e21b 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -28,6 +28,7 @@
>  #include <linux/refcount.h>
>  #include <linux/part_stat.h>
>  #include <linux/blk-crypto.h>
> +#include <linux/keyslot-manager.h>
>  
>  #define DM_MSG_PREFIX "core"
>  
> @@ -1718,6 +1719,8 @@ static const struct dax_operations dm_dax_ops;
>  
>  static void dm_wq_work(struct work_struct *work);
>  
> +static void dm_destroy_inline_encryption(struct request_queue *q);
> +
>  static void cleanup_mapped_device(struct mapped_device *md)
>  {
>  	if (md->wq)
> @@ -1739,8 +1742,10 @@ static void cleanup_mapped_device(struct mapped_device *md)
>  		put_disk(md->disk);
>  	}
>  
> -	if (md->queue)
> +	if (md->queue) {
> +		dm_destroy_inline_encryption(md->queue);
>  		blk_cleanup_queue(md->queue);
> +	}
>  
>  	cleanup_srcu_struct(&md->io_barrier);
>  
> @@ -1937,6 +1942,150 @@ static void event_callback(void *context)
>  	dm_issue_global_event();
>  }
>  
> +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> +
> +struct dm_keyslot_manager {
> +	struct blk_keyslot_manager ksm;
> +	struct mapped_device *md;
> +};
> +
> +static int device_intersect_crypto_modes(struct dm_target *ti,
> +					 struct dm_dev *dev, sector_t start,
> +					 sector_t len, void *data)
> +{
> +	struct blk_keyslot_manager *parent = data;
> +	struct blk_keyslot_manager *child = bdev_get_queue(dev->bdev)->ksm;
> +
> +	blk_ksm_intersect_modes(parent, child);
> +	return 0;
> +}
> +
> +static void dm_destroy_keyslot_manager(struct blk_keyslot_manager *ksm)
> +{
> +	struct dm_keyslot_manager *dksm = container_of(ksm,
> +						       struct dm_keyslot_manager,
> +						       ksm);
> +
> +	if (!ksm)
> +		return;
> +
> +	blk_ksm_destroy(ksm);
> +	kfree(dksm);
> +}
> +
> +/*
> + * Constructs and returns a keyslot manager that represents the crypto
> + * capabilities of the devices described by the dm_table. However, if the
> + * constructed keyslot manager does not support a superset of the crypto
> + * capabilities supported by the current keyslot manager of the mapped_device,
> + * it returns an error instead, since we don't support restricting crypto
> + * capabilities on table changes. Finally, if the constructed keyslot manager
> + * doesn't actually support any crypto modes at all, it just returns NULL.
> + */
> +static struct blk_keyslot_manager *
> +dm_construct_keyslot_manager(struct mapped_device *md, struct dm_table *t)
> +{
> +	struct dm_keyslot_manager *dksm;
> +	struct blk_keyslot_manager *ksm;
> +	struct dm_target *ti;
> +	unsigned int i;
> +	bool ksm_is_empty = true;
> +
> +	dksm = kmalloc(sizeof(*dksm), GFP_KERNEL);
> +	if (!dksm)
> +		return ERR_PTR(-ENOMEM);
> +	dksm->md = md;
> +
> +	ksm = &dksm->ksm;
> +	blk_ksm_init_passthrough(ksm);
> +	ksm->max_dun_bytes_supported = UINT_MAX;
> +	memset(ksm->crypto_modes_supported, 0xFF,
> +	       sizeof(ksm->crypto_modes_supported));
> +
> +	for (i = 0; i < dm_table_get_num_targets(t); i++) {
> +		ti = dm_table_get_target(t, i);
> +
> +		if (!dm_target_passes_crypto(ti->type)) {
> +			blk_ksm_intersect_modes(ksm, NULL);
> +			break;
> +		}
> +		if (!ti->type->iterate_devices)
> +			continue;
> +		ti->type->iterate_devices(ti, device_intersect_crypto_modes,
> +					  ksm);
> +	}
> +
> +	if (!blk_ksm_is_superset(ksm, md->queue->ksm)) {
> +		DMWARN("Inline encryption capabilities of new DM table were more restrictive than the old table's. This is not supported!");
> +		dm_destroy_keyslot_manager(ksm);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	/*
> +	 * If the new KSM doesn't actually support any crypto modes, we may as
> +	 * well represent it with a NULL ksm.
> +	 */
> +	ksm_is_empty = true;
> +	for (i = 0; i < ARRAY_SIZE(ksm->crypto_modes_supported); i++) {
> +		if (ksm->crypto_modes_supported[i]) {
> +			ksm_is_empty = false;
> +			break;
> +		}
> +	}
> +
> +	if (ksm_is_empty) {
> +		dm_destroy_keyslot_manager(ksm);
> +		ksm = NULL;
> +	}
> +
> +	return ksm;
> +}
> +
> +static void dm_update_keyslot_manager(struct request_queue *q,
> +				      struct blk_keyslot_manager *ksm)
> +{
> +	if (!ksm)
> +		return;
> +
> +	/* Make the ksm less restrictive */
> +	if (!q->ksm) {
> +		blk_ksm_register(ksm, q);
> +	} else {
> +		blk_ksm_update_capabilities(q->ksm, ksm);
> +		dm_destroy_keyslot_manager(ksm);
> +	}
> +}
> +
> +static void dm_destroy_inline_encryption(struct request_queue *q)
> +{
> +	if (!q->ksm)
> +		return;
> +	dm_destroy_keyslot_manager(q->ksm);
> +}
> +
> +#else /* CONFIG_BLK_INLINE_ENCRYPTION */
> +
> +static inline struct blk_keyslot_manager *
> +dm_construct_keyslot_manager(struct mapped_device *md, struct dm_table *t)
> +{
> +	return NULL;
> +}
> +
> +static void dm_update_keyslot_manager(struct request_queue *q,
> +				      struct blk_keyslot_manager *ksm)
> +{
> +}
> +
> +static void dm_destroy_keyslot_manager(struct blk_keyslot_manager *ksm)
> +{
> +}
> +
> +static inline void dm_destroy_inline_encryption(struct request_queue *q)
> +{
> +}
> +
> +#endif /* !CONFIG_BLK_INLINE_ENCRYPTION */
> +
>  /*
>   * Returns old map, which caller must destroy.
>   */
> @@ -2332,6 +2481,7 @@ struct dm_table *dm_swap_table(struct mapped_device *md, struct dm_table *table)
>  {
>  	struct dm_table *live_map = NULL, *map = ERR_PTR(-EINVAL);
>  	struct queue_limits limits;
> +	struct blk_keyslot_manager *ksm;
>  	int r;
>  
>  	mutex_lock(&md->suspend_lock);
> @@ -2361,7 +2511,19 @@ struct dm_table *dm_swap_table(struct mapped_device *md, struct dm_table *table)
>  		}
>  	}
>  
> +	ksm = dm_construct_keyslot_manager(md, table);
> +	if (IS_ERR(ksm)) {
> +		map = ERR_CAST(ksm);
> +		goto out;
> +	}
> +

The work done in dm_construct_keyslot_manager() is inappropriate to do
at this point in the DM core code.

This should be split into 2 phases:
1) allocation/setup of ksm in dm-table.c:dm_table_complete()
2) quick install of ksm in dm.c:__bind()

Memory allocation should be done as part of dm_table_complete().
Meaning I think the ksm should be allocated on demand as part of
dm_table creation. Then if in dm_swap_table()'s __bind() table->ksm
isn't NULL, dm_update_keyslot_manager() is called.
dm_update_keyslot_manager() should be updated to take dm_table rather
than ksm (and table->ksm is set to NULL at end).

But if DM table creation's validation of ksm fails, then any newly
allocated ksm (stored in table->ksm) should be destroyed as part of
dm_table_destroy().  This should also eliminate the need for an
intermediate 'struct dm_keyslot_manager'

Mike

>  	map = __bind(md, table, &limits);
> +
> +	if (IS_ERR(map))
> +		dm_destroy_keyslot_manager(ksm);
> +	else
> +		dm_update_keyslot_manager(md->queue, ksm);
> +
>  	dm_issue_global_event();
>  
>  out:
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index 61a66fb8ebb3..0d5794a0a89a 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -257,6 +257,12 @@ struct target_type {
>  #define DM_TARGET_NOWAIT		0x00000080
>  #define dm_target_supports_nowait(type) ((type)->features & DM_TARGET_NOWAIT)
>  
> +/*
> + *
> + */
> +#define DM_TARGET_PASSES_CRYPTO		0x00000100
> +#define dm_target_passes_crypto(type) ((type)->features & DM_TARGET_PASSES_CRYPTO)
> +
>  struct dm_target {
>  	struct dm_table *table;
>  	struct target_type *type;
> diff --git a/include/linux/keyslot-manager.h b/include/linux/keyslot-manager.h
> index 164568f52be7..9164c1c72288 100644
> --- a/include/linux/keyslot-manager.h
> +++ b/include/linux/keyslot-manager.h
> @@ -11,6 +11,8 @@
>  
>  struct blk_keyslot_manager;
>  
> +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> +
>  /**
>   * struct blk_ksm_ll_ops - functions to manage keyslots in hardware
>   * @keyslot_program:	Program the specified key into the specified slot in the
> @@ -114,4 +116,10 @@ bool blk_ksm_is_superset(struct blk_keyslot_manager *ksm_superset,
>  void blk_ksm_update_capabilities(struct blk_keyslot_manager *target_ksm,
>  				 struct blk_keyslot_manager *reference_ksm);
>  
> +#else /* CONFIG_BLK_INLINE_ENCRYPTION */
> +
> +static inline void blk_ksm_destroy(struct blk_keyslot_manager *ksm) { }
> +
> +#endif /* CONFIG_BLK_INLINE_ENCRYPTION */
> +
>  #endif /* __LINUX_KEYSLOT_MANAGER_H */
> -- 
> 2.29.2.729.g45daf8777d-goog
> 

