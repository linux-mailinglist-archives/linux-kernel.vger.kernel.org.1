Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03D2288EDB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 18:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389792AbgJIQ2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 12:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389144AbgJIQ2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 12:28:01 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6B4C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 09:28:01 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id 4so2486672ooh.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FwD9qRck80aaS6hcwpVV+fGUUTa5tO1fSET+ZcHE9T8=;
        b=bQX4adCPHglu9tPk5eecC53IQeTGWv+EUOVCyYKo9uvRy4oEYH0nD+gAP2w+5nnP8B
         QlzdPV/9xf4H6eRw2kVrCXVQjh3aPSPtgDAAPdcSWJc1Spe5MOovBjYVYLXz0p3Oh4nT
         ofg2Zh9gTRaOVUMmYlegSOiljWKzfcI4G7PRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FwD9qRck80aaS6hcwpVV+fGUUTa5tO1fSET+ZcHE9T8=;
        b=qYbqe1Le35cOVC3hqCKkdPqoM6p36VZmW4c+LVvFd7N2ad9kHcjn+Mnu04V5dGr41S
         THeTAy5wLiuMxLwEYj7fbLr8I3pvJ122vA0MpumWKgMPodrVEX5d73QBQ+t4jiiIpEL2
         yBHQwqTwh/zgZyE24QVtZ1EZsO1f8J/WoVyUJqi0YslwcQf7wLtAqOXeXNaQGbZnAgJC
         V72fpxsQLMoYvhRWKuPTD+V6MbGvBOIAPjllMSy3LiUojvHirkh1yviHKdYT5Aj3pCxr
         2dSoAVL1xRrxUbSCOKa7Fce+TrLk+Wn1SXqYWyMSWN1bTWBGMcQZeUExcGNV0OTA7fOD
         ihgA==
X-Gm-Message-State: AOAM531Om/svRV9lsLJ3JVnnjc3Y9cPN+0HIJGqA8pwH4MvjphLKqWCl
        kpI/yKV50RmgikeiH+vaKyFBDBb2y9NQ0Jlm6PhpwA==
X-Google-Smtp-Source: ABdhPJzdQbwMUYb0ZFQJ3kLnpydd0XpR/r7Yz1OrUQs9NEMEBiryzok72FhSC53llTTytdAIzIrW3/i8SCIpf4/IZNY=
X-Received: by 2002:a4a:c011:: with SMTP id v17mr9630277oop.89.1602260880414;
 Fri, 09 Oct 2020 09:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201009150342.1979-1-christian.koenig@amd.com>
 <20201009150342.1979-6-christian.koenig@amd.com> <20201009162444.GO438822@phenom.ffwll.local>
In-Reply-To: <20201009162444.GO438822@phenom.ffwll.local>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 9 Oct 2020 18:27:49 +0200
Message-ID: <CAKMK7uHNEcXNHHiJZu=7+YK2OpFULSpo7pYNvOavzR6xXe0MAQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] drm/prime: document that use the page array is
 deprecated v2
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "Wilson, Chris" <chris@chris-wilson.co.uk>,
        Dave Airlie <airlied@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 9, 2020 at 6:24 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Fri, Oct 09, 2020 at 05:03:42PM +0200, Christian K=C3=B6nig wrote:
> > We have reoccurring requests on this so better document that
> > this approach doesn't work and dma_buf_mmap() needs to be used instead.
> >
> > v2: split it into two functions
> >
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Patches 3-5:
>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> This one looks good, but you have it on a strange baseline. This doesn't
> contain the sg walking fixes from Marek, so reintroduces the bugs.
> Probably need to request a backmerge chain, first of -rc8 into drm-next,
> and then that into drm-misc-next.

Marek's patch is in drm-next, so just needs a backmerge into drm-misc-next.

Thomas, can you pls do that? We need 0552daac2d18f

I'll wait for the next round for patches 1&2 since Jason seems to have
found a small issue with them.
-Daniel

>
> Everything else in here lgtm.
> -Daniel
>
>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  9 ++-
> >  drivers/gpu/drm/drm_prime.c                 | 67 +++++++++++++++------
> >  drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c |  3 +-
> >  drivers/gpu/drm/msm/msm_gem.c               |  2 +-
> >  drivers/gpu/drm/nouveau/nouveau_bo.c        |  5 +-
> >  drivers/gpu/drm/radeon/radeon_ttm.c         |  9 ++-
> >  drivers/gpu/drm/vgem/vgem_drv.c             |  3 +-
> >  drivers/gpu/drm/vkms/vkms_gem.c             |  2 +-
> >  drivers/gpu/drm/xen/xen_drm_front_gem.c     |  4 +-
> >  include/drm/drm_prime.h                     |  7 ++-
> >  10 files changed, 69 insertions(+), 42 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index ac463e706b19..6a65490de391 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -1011,8 +1011,8 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_b=
o_device *bdev,
> >               goto release_sg;
> >
> >       /* convert SG to linear array of pages and dma addresses */
> > -     drm_prime_sg_to_page_addr_arrays(ttm->sg, NULL, gtt->ttm.dma_addr=
ess,
> > -                                      ttm->num_pages);
> > +     drm_prime_sg_to_dma_addr_array(ttm->sg, gtt->ttm.dma_address,
> > +                                    ttm->num_pages);
> >
> >       return 0;
> >
> > @@ -1345,9 +1345,8 @@ static int amdgpu_ttm_tt_populate(struct ttm_bo_d=
evice *bdev,
> >                       ttm->sg =3D sgt;
> >               }
> >
> > -             drm_prime_sg_to_page_addr_arrays(ttm->sg, NULL,
> > -                                              gtt->ttm.dma_address,
> > -                                              ttm->num_pages);
> > +             drm_prime_sg_to_dma_addr_array(ttm->sg, gtt->ttm.dma_addr=
ess,
> > +                                            ttm->num_pages);
> >               ttm_tt_set_populated(ttm);
> >               return 0;
> >       }
> > diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> > index 4910c446db83..8b750c074494 100644
> > --- a/drivers/gpu/drm/drm_prime.c
> > +++ b/drivers/gpu/drm/drm_prime.c
> > @@ -954,27 +954,25 @@ struct drm_gem_object *drm_gem_prime_import(struc=
t drm_device *dev,
> >  EXPORT_SYMBOL(drm_gem_prime_import);
> >
> >  /**
> > - * drm_prime_sg_to_page_addr_arrays - convert an sg table into a page =
array
> > + * drm_prime_sg_to_page_array - convert an sg table into a page array
> >   * @sgt: scatter-gather table to convert
> > - * @pages: optional array of page pointers to store the page array in
> > - * @addrs: optional array to store the dma bus address of each page
> > - * @max_entries: size of both the passed-in arrays
> > + * @pages: array of page pointers to store the pages in
> > + * @max_entries: size of the passed-in array
> >   *
> > - * Exports an sg table into an array of pages and addresses. This is c=
urrently
> > - * required by the TTM driver in order to do correct fault handling.
> > + * Exports an sg table into an array of pages.
> >   *
> > - * Drivers can use this in their &drm_driver.gem_prime_import_sg_table
> > - * implementation.
> > + * This function is deprecated and strongly discouraged to be used.
> > + * The page array is only useful for page faults and those can corrupt=
 fields
> > + * in the struct page if they are not handled by the exporting driver.
> >   */
> > -int drm_prime_sg_to_page_addr_arrays(struct sg_table *sgt, struct page=
 **pages,
> > -                                  dma_addr_t *addrs, int max_entries)
> > +int __deprecated drm_prime_sg_to_page_array(struct sg_table *sgt,
> > +                                         struct page **pages,
> > +                                         int max_entries)
> >  {
> >       unsigned count;
> >       struct scatterlist *sg;
> >       struct page *page;
> >       u32 page_len, page_index;
> > -     dma_addr_t addr;
> > -     u32 dma_len, dma_index;
> >
> >       /*
> >        * Scatterlist elements contains both pages and DMA addresses, bu=
t
> > @@ -984,14 +982,11 @@ int drm_prime_sg_to_page_addr_arrays(struct sg_ta=
ble *sgt, struct page **pages,
> >        * described by the sg_dma_address(sg).
> >        */
> >       page_index =3D 0;
> > -     dma_index =3D 0;
> >       for_each_sg(sgt->sgl, sg, sgt->nents, count) {
> >               page_len =3D sg->length;
> >               page =3D sg_page(sg);
> > -             dma_len =3D sg_dma_len(sg);
> > -             addr =3D sg_dma_address(sg);
> >
> > -             while (pages && page_len > 0) {
> > +             while (page_len > 0) {
> >                       if (WARN_ON(page_index >=3D max_entries))
> >                               return -1;
> >                       pages[page_index] =3D page;
> > @@ -999,7 +994,43 @@ int drm_prime_sg_to_page_addr_arrays(struct sg_tab=
le *sgt, struct page **pages,
> >                       page_len -=3D PAGE_SIZE;
> >                       page_index++;
> >               }
> > -             while (addrs && dma_len > 0) {
> > +     }
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(drm_prime_sg_to_page_array);
> > +
> > +/**
> > + * drm_prime_sg_to_dma_addr_array - convert an sg table into a dma add=
r array
> > + * @sgt: scatter-gather table to convert
> > + * @addrs: array to store the dma bus address of each page
> > + * @max_entries: size of both the passed-in arrays
> > + *
> > + * Exports an sg table into an array of addresses.
> > + *
> > + * Drivers should use this in their &drm_driver.gem_prime_import_sg_ta=
ble
>
> s/should/can/
>
> There's no requirement, if your driver just handles everything as an sgt
> there's no conversion needed.
>
> > + * implementation.
> > + */
> > +int drm_prime_sg_to_dma_addr_array(struct sg_table *sgt, dma_addr_t *a=
ddrs,
> > +                                int max_entries)
> > +{
> > +     struct scatterlist *sg;
> > +     u32 dma_len, dma_index;
> > +     dma_addr_t addr;
> > +     unsigned count;
> > +
> > +     /*
> > +      * Scatterlist elements contains both pages and DMA addresses, bu=
t
> > +      * one shoud not assume 1:1 relation between them. The sg->length=
 is
> > +      * the size of the physical memory chunk described by the sg->pag=
e,
> > +      * while sg_dma_len(sg) is the size of the DMA (IO virtual) chunk
> > +      * described by the sg_dma_address(sg).
> > +      */
> > +     dma_index =3D 0;
> > +     for_each_sg(sgt->sgl, sg, sgt->nents, count) {
> > +             dma_len =3D sg_dma_len(sg);
> > +             addr =3D sg_dma_address(sg);
> > +
> > +             while (dma_len > 0) {
> >                       if (WARN_ON(dma_index >=3D max_entries))
> >                               return -1;
> >                       addrs[dma_index] =3D addr;
> > @@ -1010,7 +1041,7 @@ int drm_prime_sg_to_page_addr_arrays(struct sg_ta=
ble *sgt, struct page **pages,
> >       }
> >       return 0;
> >  }
> > -EXPORT_SYMBOL(drm_prime_sg_to_page_addr_arrays);
> > +EXPORT_SYMBOL(drm_prime_sg_to_dma_addr_array);
> >
> >  /**
> >   * drm_prime_gem_destroy - helper to clean up a PRIME-imported GEM obj=
ect
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/=
drm/etnaviv/etnaviv_gem_prime.c
> > index 135fbff6fecf..8c04b8e8054c 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> > @@ -133,8 +133,7 @@ struct drm_gem_object *etnaviv_gem_prime_import_sg_=
table(struct drm_device *dev,
> >               goto fail;
> >       }
> >
> > -     ret =3D drm_prime_sg_to_page_addr_arrays(sgt, etnaviv_obj->pages,
> > -                                            NULL, npages);
> > +     ret =3D drm_prime_sg_to_page_array(sgt, etnaviv_obj->pages, npage=
s);
> >       if (ret)
> >               goto fail;
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_ge=
m.c
> > index a71f42870d5e..616b87641740 100644
> > --- a/drivers/gpu/drm/msm/msm_gem.c
> > +++ b/drivers/gpu/drm/msm/msm_gem.c
> > @@ -1174,7 +1174,7 @@ struct drm_gem_object *msm_gem_import(struct drm_=
device *dev,
> >               goto fail;
> >       }
> >
> > -     ret =3D drm_prime_sg_to_page_addr_arrays(sgt, msm_obj->pages, NUL=
L, npages);
> > +     ret =3D drm_prime_sg_to_page_array(sgt, msm_obj->pages, npages);
> >       if (ret) {
> >               mutex_unlock(&msm_obj->lock);
> >               goto fail;
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nou=
veau/nouveau_bo.c
> > index e378bb491688..835edd74ef59 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
> > @@ -1299,9 +1299,8 @@ nouveau_ttm_tt_populate(struct ttm_bo_device *bde=
v,
> >               return 0;
> >
> >       if (slave && ttm->sg) {
> > -             drm_prime_sg_to_page_addr_arrays(ttm->sg, NULL,
> > -                                              ttm_dma->dma_address,
> > -                                              ttm->num_pages);
> > +             drm_prime_sg_to_dma_addr_array(ttm->sg, ttm_dma->dma_addr=
ess,
> > +                                            ttm->num_pages);
> >               ttm_tt_set_populated(ttm);
> >               return 0;
> >       }
> > diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/rade=
on/radeon_ttm.c
> > index 4b92cdbcd29b..7997e4564576 100644
> > --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> > +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> > @@ -474,8 +474,8 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_bo_=
device *bdev, struct ttm_tt *
> >       if (r)
> >               goto release_sg;
> >
> > -     drm_prime_sg_to_page_addr_arrays(ttm->sg, NULL, gtt->ttm.dma_addr=
ess,
> > -                                      ttm->num_pages);
> > +     drm_prime_sg_to_dma_addr_array(ttm->sg, gtt->ttm.dma_address,
> > +                                    ttm->num_pages);
> >
> >       return 0;
> >
> > @@ -642,9 +642,8 @@ static int radeon_ttm_tt_populate(struct ttm_bo_dev=
ice *bdev,
> >       }
> >
> >       if (slave && ttm->sg) {
> > -             drm_prime_sg_to_page_addr_arrays(ttm->sg, NULL,
> > -                                              gtt->ttm.dma_address,
> > -                                              ttm->num_pages);
> > +             drm_prime_sg_to_dma_addr_array(ttm->sg, gtt->ttm.dma_addr=
ess,
> > +                                            ttm->num_pages);
> >               ttm_tt_set_populated(ttm);
> >               return 0;
> >       }
> > diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vge=
m_drv.c
> > index ea0eecae5153..e505e5a291b3 100644
> > --- a/drivers/gpu/drm/vgem/vgem_drv.c
> > +++ b/drivers/gpu/drm/vgem/vgem_drv.c
> > @@ -356,8 +356,7 @@ static struct drm_gem_object *vgem_prime_import_sg_=
table(struct drm_device *dev,
> >       }
> >
> >       obj->pages_pin_count++; /* perma-pinned */
> > -     drm_prime_sg_to_page_addr_arrays(obj->table, obj->pages, NULL,
> > -                                     npages);
> > +     drm_prime_sg_to_page_array(obj->table, obj->pages, npages);
> >       return &obj->base;
> >  }
> >
> > diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vkms/vkm=
s_gem.c
> > index 19a0e260a4df..a2ff21f47101 100644
> > --- a/drivers/gpu/drm/vkms/vkms_gem.c
> > +++ b/drivers/gpu/drm/vkms/vkms_gem.c
> > @@ -256,6 +256,6 @@ vkms_prime_import_sg_table(struct drm_device *dev,
> >               return ERR_PTR(-ENOMEM);
> >       }
> >
> > -     drm_prime_sg_to_page_addr_arrays(sg, obj->pages, NULL, npages);
> > +     drm_prime_sg_to_page_array(sg, obj->pages, npages);
> >       return &obj->gem;
> >  }
> > diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/=
xen/xen_drm_front_gem.c
> > index f3830a0d1808..f4150ddfc5e2 100644
> > --- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
> > +++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> > @@ -220,8 +220,8 @@ xen_drm_front_gem_import_sg_table(struct drm_device=
 *dev,
> >
> >       xen_obj->sgt_imported =3D sgt;
> >
> > -     ret =3D drm_prime_sg_to_page_addr_arrays(sgt, xen_obj->pages,
> > -                                            NULL, xen_obj->num_pages);
> > +     ret =3D drm_prime_sg_to_page_array(sgt, xen_obj->pages,
> > +                                      xen_obj->num_pages);
> >       if (ret < 0)
> >               return ERR_PTR(ret);
> >
> > diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
> > index 093f760cc131..4bda9ab3a3bb 100644
> > --- a/include/drm/drm_prime.h
> > +++ b/include/drm/drm_prime.h
> > @@ -103,8 +103,9 @@ struct drm_gem_object *drm_gem_prime_import(struct =
drm_device *dev,
> >
> >  void drm_prime_gem_destroy(struct drm_gem_object *obj, struct sg_table=
 *sg);
> >
> > -int drm_prime_sg_to_page_addr_arrays(struct sg_table *sgt, struct page=
 **pages,
> > -                                  dma_addr_t *addrs, int max_pages);
> > -
> > +int drm_prime_sg_to_page_array(struct sg_table *sgt, struct page **pag=
es,
> > +                            int max_pages);
> > +int drm_prime_sg_to_dma_addr_array(struct sg_table *sgt, dma_addr_t *a=
ddrs,
> > +                                int max_pages);
> >
> >  #endif /* __DRM_PRIME_H__ */
> > --
> > 2.17.1
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
