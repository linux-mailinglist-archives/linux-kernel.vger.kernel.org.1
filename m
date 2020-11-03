Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA5A2A4FC0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 20:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgKCTNq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Nov 2020 14:13:46 -0500
Received: from aposti.net ([89.234.176.197]:41592 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgKCTNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:13:46 -0500
Date:   Tue, 03 Nov 2020 19:13:27 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 3/5] drm: Add and export =?UTF-8?Q?function=0D=0A?=
 drm_gem_cma_mmap_noncoherent
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-Id: <FQI8JQ.KNVZ9XZ67ZV41@crapouillou.net>
In-Reply-To: <20201103185058.GA20134@infradead.org>
References: <20201102220651.22069-1-paul@crapouillou.net>
        <20201102220651.22069-4-paul@crapouillou.net>
        <20201103185058.GA20134@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Le mar. 3 nov. 2020 à 18:50, Christoph Hellwig <hch@infradead.org> a 
écrit :
> On Mon, Nov 02, 2020 at 10:06:49PM +0000, Paul Cercueil wrote:
>>  This function can be used by drivers that need to mmap dumb buffers
>>  created with non-coherent backing memory.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/gpu/drm/drm_gem_cma_helper.c | 39 
>> ++++++++++++++++++++++++++++
>>   include/drm/drm_gem_cma_helper.h     |  2 ++
>>   2 files changed, 41 insertions(+)
>> 
>>  diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c 
>> b/drivers/gpu/drm/drm_gem_cma_helper.c
>>  index 3bdd67795e20..4ed63f4896bd 100644
>>  --- a/drivers/gpu/drm/drm_gem_cma_helper.c
>>  +++ b/drivers/gpu/drm/drm_gem_cma_helper.c
>>  @@ -387,6 +387,45 @@ int drm_gem_cma_mmap(struct file *filp, struct 
>> vm_area_struct *vma)
>>   }
>>   EXPORT_SYMBOL_GPL(drm_gem_cma_mmap);
>> 
>>  +/**
>>  + * drm_gem_cma_mmap_noncoherent - memory-map a CMA GEM object with
>>  + *     non-coherent cache attribute
>>  + * @filp: file object
>>  + * @vma: VMA for the area to be mapped
>>  + *
>>  + * Just like drm_gem_cma_mmap, but for a GEM object backed by 
>> non-coherent
>>  + * memory.
>>  + *
>>  + * Returns:
>>  + * 0 on success or a negative error code on failure.
>>  + */
>>  +int drm_gem_cma_mmap_noncoherent(struct file *filp, struct 
>> vm_area_struct *vma)
>>  +{
>>  +	struct drm_gem_cma_object *cma_obj;
>>  +	int ret;
>>  +
>>  +	ret = drm_gem_mmap(filp, vma);
>>  +	if (ret)
>>  +		return ret;
>>  +
>>  +	cma_obj = to_drm_gem_cma_obj(vma->vm_private_data);
>>  +
>>  +	/*
>>  +	 * Clear the VM_PFNMAP flag that was set by drm_gem_mmap(), and 
>> set the
>>  +	 * vm_pgoff (used as a fake buffer offset by DRM) to 0 as we want 
>> to map
>>  +	 * the whole buffer.
>>  +	 */
>>  +	vma->vm_flags &= ~VM_PFNMAP;
>>  +	vma->vm_pgoff = 0;
>>  +	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
>>  +
>>  +	return remap_pfn_range(vma, vma->vm_start,
>>  +			       cma_obj->paddr >> PAGE_SHIFT,
>>  +			       vma->vm_end - vma->vm_start,
>>  +			       vma->vm_page_prot);
> 
> Per patch 1 cma_obj->paddr is the dma address, while remap_pfn_range
> expects a physical address.  This does not work.

Ok, what would be the correct way to mmap_noncoherent?

-Paul


