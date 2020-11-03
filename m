Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEBF2A4F65
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgKCSvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgKCSvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:51:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DFFC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 10:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GlWsb7PWBsYhiCP9lpzWE6ufMPsuCzixYv4qLK6TTBY=; b=ZVrkIhH1ZF3z5Fr9vfeGkc2TsM
        ycxrrwTER/1HQIUFQ9zndsrGTpo0NlFPWAtnEUzdz5Ax9MeehO+bPS2WW5a7bblP/v1ZvUHH14xdE
        DmHObug4yS7Zz0rSWFLupUs6HgMzY6kZqIv8JNW45nWJY6mT6Vjl/46cX6aHxh5TKlMiW3W2xaLnK
        9lOlUIZlujViBIZagTJSmTN14fuADVODaBXRefNchb0HnD6obYTSqxd+NI3JKVTFvjyjPyEg57TZj
        CI3X2J2AD3SJMF+gch0giXHrP6gw672QnbeINQJcwjJZeyCGlo7qBfMv0bNQETOqy6UqReBd8Ay5W
        iD3fGWHA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ka1OU-0005Ms-IT; Tue, 03 Nov 2020 18:50:58 +0000
Date:   Tue, 3 Nov 2020 18:50:58 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] drm: Add and export function
 drm_gem_cma_mmap_noncoherent
Message-ID: <20201103185058.GA20134@infradead.org>
References: <20201102220651.22069-1-paul@crapouillou.net>
 <20201102220651.22069-4-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102220651.22069-4-paul@crapouillou.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 10:06:49PM +0000, Paul Cercueil wrote:
> This function can be used by drivers that need to mmap dumb buffers
> created with non-coherent backing memory.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/gpu/drm/drm_gem_cma_helper.c | 39 ++++++++++++++++++++++++++++
>  include/drm/drm_gem_cma_helper.h     |  2 ++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
> index 3bdd67795e20..4ed63f4896bd 100644
> --- a/drivers/gpu/drm/drm_gem_cma_helper.c
> +++ b/drivers/gpu/drm/drm_gem_cma_helper.c
> @@ -387,6 +387,45 @@ int drm_gem_cma_mmap(struct file *filp, struct vm_area_struct *vma)
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_cma_mmap);
>  
> +/**
> + * drm_gem_cma_mmap_noncoherent - memory-map a CMA GEM object with
> + *     non-coherent cache attribute
> + * @filp: file object
> + * @vma: VMA for the area to be mapped
> + *
> + * Just like drm_gem_cma_mmap, but for a GEM object backed by non-coherent
> + * memory.
> + *
> + * Returns:
> + * 0 on success or a negative error code on failure.
> + */
> +int drm_gem_cma_mmap_noncoherent(struct file *filp, struct vm_area_struct *vma)
> +{
> +	struct drm_gem_cma_object *cma_obj;
> +	int ret;
> +
> +	ret = drm_gem_mmap(filp, vma);
> +	if (ret)
> +		return ret;
> +
> +	cma_obj = to_drm_gem_cma_obj(vma->vm_private_data);
> +
> +	/*
> +	 * Clear the VM_PFNMAP flag that was set by drm_gem_mmap(), and set the
> +	 * vm_pgoff (used as a fake buffer offset by DRM) to 0 as we want to map
> +	 * the whole buffer.
> +	 */
> +	vma->vm_flags &= ~VM_PFNMAP;
> +	vma->vm_pgoff = 0;
> +	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
> +
> +	return remap_pfn_range(vma, vma->vm_start,
> +			       cma_obj->paddr >> PAGE_SHIFT,
> +			       vma->vm_end - vma->vm_start,
> +			       vma->vm_page_prot);

Per patch 1 cma_obj->paddr is the dma address, while remap_pfn_range
expects a physical address.  This does not work.
