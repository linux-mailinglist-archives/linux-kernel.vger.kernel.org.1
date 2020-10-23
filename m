Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68548296E49
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 14:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463550AbgJWMTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 08:19:44 -0400
Received: from verein.lst.de ([213.95.11.211]:55867 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S463540AbgJWMTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 08:19:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5262967373; Fri, 23 Oct 2020 14:19:41 +0200 (CEST)
Date:   Fri, 23 Oct 2020 14:19:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Auld <matthew.auld@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Fix a crash in shmem_pin_map() error handling
Message-ID: <20201023121941.GB18499@lst.de>
References: <20201023113401.GG282278@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023113401.GG282278@mwanda>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 02:34:01PM +0300, Dan Carpenter wrote:
> There is a signedness bug in shmem_pin_map() error handling because "i"
> is unsigned.  The "while (--i >= 0)" will loop forever until the system
> crashes.

I actually sent a patch to Andrew before the end of the merge window
to use a for loop with a new j iterator to fix this based on your
automated report, but it looks like that didn't go in.

> Fixes: bfed6708d6c9 ("drm/i915: use vmap in shmem_pin_map")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/gpu/drm/i915/gt/shmem_utils.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/shmem_utils.c b/drivers/gpu/drm/i915/gt/shmem_utils.c
> index f011ea42487e..7eb542018219 100644
> --- a/drivers/gpu/drm/i915/gt/shmem_utils.c
> +++ b/drivers/gpu/drm/i915/gt/shmem_utils.c
> @@ -52,8 +52,9 @@ struct file *shmem_create_from_object(struct drm_i915_gem_object *obj)
>  void *shmem_pin_map(struct file *file)
>  {
>  	struct page **pages;
> -	size_t n_pages, i;
> +	size_t n_pages;
>  	void *vaddr;
> +	int i;
>  
>  	n_pages = file->f_mapping->host->i_size >> PAGE_SHIFT;
>  	pages = kvmalloc_array(n_pages, sizeof(*pages), GFP_KERNEL);

This assumes we never have more than INT_MAX worth of pages before
a failure. 
