Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EA72BA707
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgKTKGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgKTKGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:06:04 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE73C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:06:03 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id y3so2094940ooq.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FwZrZS2M8g80LqzTW2fm5Yrg4YpqArqxdpfJQU9jQQI=;
        b=HqdItk8eAfJ9g+K3HI5aMiUQzrvGRJOPlE6kLNI2lMu9ILhZMbvZZ6f8p9gmeEJne4
         zXq2974oLAywa/J335ISMg7Ntoqxln9e1JXz8qEiWYzK2Vyqj7OtjpeTBqm+Cdcs1QDt
         yKC7n5pCkW0BHszGjfK6qu4I1SzoqAQq/6Hcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FwZrZS2M8g80LqzTW2fm5Yrg4YpqArqxdpfJQU9jQQI=;
        b=SGi+jYbHWgrZOS36A689TuTkowOJDrt8AwpX+9lq0ywyG9Wh7Fsws9ZyBDpTD0pxR2
         QT10gTJ6ZuNBXNQaYbqGCB3hYewHI3Q/rfguCBhwcU6og+ZqH5C+S4wxPZ9QZJ2EPtgj
         1Omj/ebF7j0k8IrZa1kW4UjOfYZl4xnAZ9MQeXndoGAjNjbrNx/7rI59I+ZTich3dhW2
         pvBug5rEZZwh0SglcguaFfAe2DKmWWL9IbQw5DpSAmb1Gb84MHxV8GUyzo6IAEwRQjSQ
         wI1uTg5cAA+leJORsPbjo71VrXX6IF7YxaGHecC80YzlVctUAU3dUPEK0zzF75nf1+ZX
         yb+w==
X-Gm-Message-State: AOAM5336YzEY44MyB7tEjum4cuekC/ezDqQLR+jr09IqkFLPo72fXkhK
        PwgqMPFfPgo92O+VX/oMrAM38BQS1cr5hTGEyq6E0Q==
X-Google-Smtp-Source: ABdhPJyiON5L6xidYOyeZLAbz9U5Xis7bE3rvrWx7XK/ftrOp96yOttrxffYvb2YlOPVDvtJGHev197hecR9SxdWVzc=
X-Received: by 2002:a4a:8582:: with SMTP id t2mr13256498ooh.89.1605866761624;
 Fri, 20 Nov 2020 02:06:01 -0800 (PST)
MIME-Version: 1.0
References: <20201120095445.1195585-1-daniel.vetter@ffwll.ch>
 <20201120095445.1195585-5-daniel.vetter@ffwll.ch> <26a62dfb-02e4-1707-c833-a3c8d5cbe828@amd.com>
In-Reply-To: <26a62dfb-02e4-1707-c833-a3c8d5cbe828@amd.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 20 Nov 2020 11:05:50 +0100
Message-ID: <CAKMK7uHnYGiBsBLeyGA8sZXmAiaHaym9jnLKN_xY4VAtKJjG5A@mail.gmail.com>
Subject: Re: [PATCH] drm/ttm: don't set page->mapping
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Brian Paul <brianp@vmware.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 11:04 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 20.11.20 um 10:54 schrieb Daniel Vetter:
> > Random observation while trying to review Christian's patch series to
> > stop looking at struct page for dma-buf imports.
> >
> > This was originally added in
> >
> > commit 58aa6622d32af7d2c08d45085f44c54554a16ed7
> > Author: Thomas Hellstrom <thellstrom@vmware.com>
> > Date:   Fri Jan 3 11:47:23 2014 +0100
> >
> >      drm/ttm: Correctly set page mapping and -index members
> >
> >      Needed for some vm operations; most notably unmap_mapping_range() =
with
> >      even_cows =3D 0.
> >
> >      Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> >      Reviewed-by: Brian Paul <brianp@vmware.com>
> >
> > but we do not have a single caller of unmap_mapping_range with
> > even_cows =3D=3D 0. And all the gem drivers don't do this, so another
> > small thing we could standardize between drm and ttm drivers.
> >
> > Plus I don't really see a need for unamp_mapping_range where we don't
> > want to indiscriminately shoot down all ptes.
> >
> > Cc: Thomas Hellstrom <thellstrom@vmware.com>
> > Cc: Brian Paul <brianp@vmware.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
>
> This is still a NAK as long as we can't come up with a better way to
> track TTMs page allocations.
>
> Additional to that page_mapping() is used quite extensively in the mm
> code and I'm not sure if that isn't needed for other stuff as well.

Apologies, I'm honestly not quite sure how this lone patch here ended
up in this submission. I didn't want to send it out.
-Daniel

>
> Regards,
> Christian.
>
> > ---
> >   drivers/gpu/drm/ttm/ttm_tt.c | 12 ------------
> >   1 file changed, 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.=
c
> > index da9eeffe0c6d..5b2eb6d58bb7 100644
> > --- a/drivers/gpu/drm/ttm/ttm_tt.c
> > +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> > @@ -284,17 +284,6 @@ int ttm_tt_swapout(struct ttm_bo_device *bdev, str=
uct ttm_tt *ttm)
> >       return ret;
> >   }
> >
> > -static void ttm_tt_add_mapping(struct ttm_bo_device *bdev, struct ttm_=
tt *ttm)
> > -{
> > -     pgoff_t i;
> > -
> > -     if (ttm->page_flags & TTM_PAGE_FLAG_SG)
> > -             return;
> > -
> > -     for (i =3D 0; i < ttm->num_pages; ++i)
> > -             ttm->pages[i]->mapping =3D bdev->dev_mapping;
> > -}
> > -
> >   int ttm_tt_populate(struct ttm_bo_device *bdev,
> >                   struct ttm_tt *ttm, struct ttm_operation_ctx *ctx)
> >   {
> > @@ -313,7 +302,6 @@ int ttm_tt_populate(struct ttm_bo_device *bdev,
> >       if (ret)
> >               return ret;
> >
> > -     ttm_tt_add_mapping(bdev, ttm);
> >       ttm->page_flags |=3D TTM_PAGE_FLAG_PRIV_POPULATED;
> >       if (unlikely(ttm->page_flags & TTM_PAGE_FLAG_SWAPPED)) {
> >               ret =3D ttm_tt_swapin(ttm);
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
