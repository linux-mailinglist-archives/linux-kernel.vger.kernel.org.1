Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB982E922E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 09:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbhADIzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 03:55:05 -0500
Received: from verein.lst.de ([213.95.11.211]:56919 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbhADIzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 03:55:05 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 29C8B6736F; Mon,  4 Jan 2021 09:54:22 +0100 (CET)
Date:   Mon, 4 Jan 2021 09:54:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] block: manage bio slab cache by xarray
Message-ID: <20210104085421.GA28949@lst.de>
References: <20201230003255.3450874-1-ming.lei@redhat.com> <20201230003255.3450874-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230003255.3450874-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 08:32:50AM +0800, Ming Lei wrote:
> Managing bio slab cache via xarray by using slab cache size as xarray index, and

Overly long line in the commit log above.

> +static struct bio_slab *create_bio_slab(unsigned int size)
> +{
> +	struct bio_slab *bslab = kzalloc(sizeof(*bslab), GFP_KERNEL);
> +	if (!bslab)
> +		return NULL;

Missing whitespace after the variable declaration.

> +
> +	snprintf(bslab->name, sizeof(bslab->name), "bio-%d", size);
> +	bslab->slab = kmem_cache_create(bslab->name, size,
> +			ARCH_KMALLOC_MINALIGN, SLAB_HWCACHE_ALIGN, NULL);
> +	if (bslab->slab) {
> +		bslab->slab_ref = 1;
> +		bslab->slab_size = size;
> +	} else {
> +		kfree(bslab);
> +		bslab = NULL;
> +	}
> +	return bslab;
> +}

I'd simply this to:

	if (!bslab->slab) {
		kfree(bslab);
		return NULL;
	}

	bslab->slab_ref = 1;
	bslab->slab_size = size;
	return bslab;
}

>  
>  static struct kmem_cache *bio_find_or_create_slab(unsigned int extra_size)
>  {
>  	unsigned int sz = sizeof(struct bio) + extra_size;
>  	struct kmem_cache *slab = NULL;
> +	struct bio_slab *bslab;
>  
>  	mutex_lock(&bio_slab_lock);
> +	bslab = xa_load(&bio_slabs, sz);
> +	if (bslab) {
> +		slab = bslab->slab;
> +		bslab->slab_ref++;
> +	} else {
> +		bslab = create_bio_slab(sz);
> +		if(bslab && !xa_err(xa_store(&bio_slabs, sz, bslab,
> +						GFP_KERNEL)))

Missing whitespace after the "if"

But more importantly, I'd expect the xa_store to go into create_bio_slab
to make the code a little more readable and to consolidate the error
handling.  Also we really shouldn't need the slab local variable in
this function.

>  static void bio_put_slab(struct bio_set *bs)
>  {
>  	struct bio_slab *bslab = NULL;
> +	unsigned int slab_size = bs->front_pad + sizeof(struct bio) +
> +		BIO_INLINE_VECS * sizeof(struct bio_vec);

This calculation would look nice factored out into a little helper with
a comment explaining it.
