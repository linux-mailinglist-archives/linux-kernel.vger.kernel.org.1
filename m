Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818FF232731
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 23:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgG2Vzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 17:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Vzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:55:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0420BC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 14:55:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k8so4409107wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 14:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TiiQwPk5+wOcxrYMTcSS5MR4bewjoZWHQZN/jXHtdiY=;
        b=gKqQtSncl3aZQrpCwzujZGt/kEYgdOrn7K97OchbFtV6qAJ+AerT2QZqhONhgsO/BU
         z+eftmao4cxw//G57++dPfV1FINhUppAQQhsT/QrFjwtFMpp0cbQ4Zi23vy1lOABTSfj
         DzemwfZLHraQOvZsxJbCJkPlK9Ony3NEQ3qaXfkuESwBjY9Iq7Bs3wpIq1xs9FgYubT7
         tGqLmMzUrrdj4wIkU08sVubHzFgyX5R57qpvcSNPBUk904JItj1EfOSZ1VlkIXYDUnqF
         bl/Ew4Jtn9PCNpDGKyrYbSdgFV+iWzNy1G+Wj3EKEpi+WNyhKLt/DjD+c7afiDOu4c2v
         5GEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TiiQwPk5+wOcxrYMTcSS5MR4bewjoZWHQZN/jXHtdiY=;
        b=jvTFLLBXRgIBtbiyHUX0ugfcI0w+uO4/QITDpe0ezx0MKEintO4rnrMuOtsJNKRydp
         SMqcY2FtrqAPf1MkadbLgt18Rn4PAk/2N4vJ1IhSrss4b8eDeptKlInfXA/H3PkC21Ke
         jzfiXnQXmOgRmh9L6DJFcgc5dwn5KkmMetT4DDb5S+SXTSwssUrOcI3MQXkfvGVBmGOw
         oAOcwqwiiOlKmPcQmImDEwm01AkOJlGmakRYuyhpGJ5s/4NrZZSXVRZDPWX89/seRuwC
         V4TgLwgMbimbtV0T8XicALy6wCaPb1yGJUjndCKA0MoRtBxnvvuuO5sHhgBTyRycq2pm
         hHAw==
X-Gm-Message-State: AOAM530Julmm1HtXVVz2WchX7wBaKn0mfW/nr92uQNW7X9thOlp8VfRl
        DGt7A7qB8eZwZrjc/mo2DvYpOx6Tzqu0ni9cfYg=
X-Google-Smtp-Source: ABdhPJy6xeXbe287qC13KOwKNKQS5Im4azlgXn6R3Xvzb5UezGM3otbEEztVP2ILmuILeliBoMojwbe/rnAUjzLzlrs=
X-Received: by 2002:a1c:2:: with SMTP id 2mr10798884wma.79.1596059753614; Wed,
 29 Jul 2020 14:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200728192924.441570-1-yepeilin.cs@gmail.com> <30b2a31f-77c2-56c1-ecde-875c6eea99d5@gmail.com>
In-Reply-To: <30b2a31f-77c2-56c1-ecde-875c6eea99d5@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 29 Jul 2020 17:55:42 -0400
Message-ID: <CADnq5_Pzz5A4kRyF061K+0hjsBEe7GT6j3zrfKZUrbjGcy1GBQ@mail.gmail.com>
Subject: Re: [Linux-kernel-mentees] [PATCH] drm/amdgpu: Prevent
 kernel-infoleak in amdgpu_info_ioctl()
To:     Christian Koenig <christian.koenig@amd.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Leo Liu <leo.liu@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
        Hans de Goede <hdegoede@redhat.com>, Trek <trek00@inbox.ru>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Evan Quan <evan.quan@amd.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Jul 29, 2020 at 4:11 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 28.07.20 um 21:29 schrieb Peilin Ye:
> > Compiler leaves a 4-byte hole near the end of `dev_info`, causing
> > amdgpu_info_ioctl() to copy uninitialized kernel stack memory to usersp=
ace
> > when `size` is greater than 356.
> >
> > In 2015 we tried to fix this issue by doing `=3D {};` on `dev_info`, wh=
ich
> > unfortunately does not initialize that 4-byte hole. Fix it by using
> > memset() instead.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: c193fa91b918 ("drm/amdgpu: information leak in amdgpu_info_ioctl=
()")
> > Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> I can't count how many of those we have fixed over the years.
>
> At some point we should probably document that using "=3D {}" or "=3D { 0=
 }"
> in the kernel is a really bad idea and should be avoided.
>
> Thanks,
> Christian.
>
> > ---
> > $ pahole -C "drm_amdgpu_info_device" drivers/gpu/drm/amd/amdgpu/amdgpu_=
kms.o
> > struct drm_amdgpu_info_device {
> >       __u32                      device_id;            /*     0     4 *=
/
> >       __u32                      chip_rev;             /*     4     4 *=
/
> >       __u32                      external_rev;         /*     8     4 *=
/
> >       __u32                      pci_rev;              /*    12     4 *=
/
> >       __u32                      family;               /*    16     4 *=
/
> >       __u32                      num_shader_engines;   /*    20     4 *=
/
> >       __u32                      num_shader_arrays_per_engine; /*    24=
     4 */
> >       __u32                      gpu_counter_freq;     /*    28     4 *=
/
> >       __u64                      max_engine_clock;     /*    32     8 *=
/
> >       __u64                      max_memory_clock;     /*    40     8 *=
/
> >       __u32                      cu_active_number;     /*    48     4 *=
/
> >       __u32                      cu_ao_mask;           /*    52     4 *=
/
> >       __u32                      cu_bitmap[4][4];      /*    56    64 *=
/
> >       /* --- cacheline 1 boundary (64 bytes) was 56 bytes ago --- */
> >       __u32                      enabled_rb_pipes_mask; /*   120     4 =
*/
> >       __u32                      num_rb_pipes;         /*   124     4 *=
/
> >       /* --- cacheline 2 boundary (128 bytes) --- */
> >       __u32                      num_hw_gfx_contexts;  /*   128     4 *=
/
> >       __u32                      _pad;                 /*   132     4 *=
/
> >       __u64                      ids_flags;            /*   136     8 *=
/
> >       __u64                      virtual_address_offset; /*   144     8=
 */
> >       __u64                      virtual_address_max;  /*   152     8 *=
/
> >       __u32                      virtual_address_alignment; /*   160   =
  4 */
> >       __u32                      pte_fragment_size;    /*   164     4 *=
/
> >       __u32                      gart_page_size;       /*   168     4 *=
/
> >       __u32                      ce_ram_size;          /*   172     4 *=
/
> >       __u32                      vram_type;            /*   176     4 *=
/
> >       __u32                      vram_bit_width;       /*   180     4 *=
/
> >       __u32                      vce_harvest_config;   /*   184     4 *=
/
> >       __u32                      gc_double_offchip_lds_buf; /*   188   =
  4 */
> >       /* --- cacheline 3 boundary (192 bytes) --- */
> >       __u64                      prim_buf_gpu_addr;    /*   192     8 *=
/
> >       __u64                      pos_buf_gpu_addr;     /*   200     8 *=
/
> >       __u64                      cntl_sb_buf_gpu_addr; /*   208     8 *=
/
> >       __u64                      param_buf_gpu_addr;   /*   216     8 *=
/
> >       __u32                      prim_buf_size;        /*   224     4 *=
/
> >       __u32                      pos_buf_size;         /*   228     4 *=
/
> >       __u32                      cntl_sb_buf_size;     /*   232     4 *=
/
> >       __u32                      param_buf_size;       /*   236     4 *=
/
> >       __u32                      wave_front_size;      /*   240     4 *=
/
> >       __u32                      num_shader_visible_vgprs; /*   244    =
 4 */
> >       __u32                      num_cu_per_sh;        /*   248     4 *=
/
> >       __u32                      num_tcc_blocks;       /*   252     4 *=
/
> >       /* --- cacheline 4 boundary (256 bytes) --- */
> >       __u32                      gs_vgt_table_depth;   /*   256     4 *=
/
> >       __u32                      gs_prim_buffer_depth; /*   260     4 *=
/
> >       __u32                      max_gs_waves_per_vgt; /*   264     4 *=
/
> >       __u32                      _pad1;                /*   268     4 *=
/
> >       __u32                      cu_ao_bitmap[4][4];   /*   272    64 *=
/
> >       /* --- cacheline 5 boundary (320 bytes) was 16 bytes ago --- */
> >       __u64                      high_va_offset;       /*   336     8 *=
/
> >       __u64                      high_va_max;          /*   344     8 *=
/
> >       __u32                      pa_sc_tile_steering_override; /*   352=
     4 */
> >
> >       /* XXX 4 bytes hole, try to pack */
> >
> >       __u64                      tcc_disabled_mask;    /*   360     8 *=
/
> >
> >       /* size: 368, cachelines: 6, members: 49 */
> >       /* sum members: 364, holes: 1, sum holes: 4 */
> >       /* last cacheline: 48 bytes */
> > };
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_kms.c
> > index a8c47aecd342..0047da06041f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -707,9 +707,10 @@ static int amdgpu_info_ioctl(struct drm_device *de=
v, void *data, struct drm_file
> >               return n ? -EFAULT : 0;
> >       }
> >       case AMDGPU_INFO_DEV_INFO: {
> > -             struct drm_amdgpu_info_device dev_info =3D {};
> > +             struct drm_amdgpu_info_device dev_info;
> >               uint64_t vm_size;
> >
> > +             memset(&dev_info, 0, sizeof(dev_info));
> >               dev_info.device_id =3D dev->pdev->device;
> >               dev_info.chip_rev =3D adev->rev_id;
> >               dev_info.external_rev =3D adev->external_rev_id;
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
