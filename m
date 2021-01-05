Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9C82EB3B6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 20:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbhAETwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 14:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbhAETwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 14:52:35 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7248AC061795
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 11:51:55 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id j20so860599otq.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 11:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k3Wed7C5AkmR+TmCNihCRrXL8XkE/3Nb/NiiJKKADS4=;
        b=o+iBui5ryaYwfQUcHoheGHtT78Es5Q43DdFfNxd9PVOsue+A7HLQzD7xaWfG4s40Tg
         JGLhB09etbKdmpggn7NQB25KevkIxQQZXTElXoYNwglOoeY7Tll1+aEfeh7irNVm6pt5
         TGdClYgtSa0ItrwwhFbkfxR4+L4u7hxgSGYNSMblZlejdbl2FDxDL1HsQCXwTiuqHfX5
         BnmLYc+7tOl5DBMREkMP3ykD8KJ870aIYyTppobz2zaOLfyxoojL2EkmmzStYAfVHNJE
         6RpAZPZQ6a/QQlEs6UqsQnYFKY3VQDt0exk4Fy6OZ276cieHSuxUoUGHLgiIY6K2vk3x
         H6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k3Wed7C5AkmR+TmCNihCRrXL8XkE/3Nb/NiiJKKADS4=;
        b=KfF4GL9rPvl6b8o/zoKu9ArjTomVcMsJI/K62vV4mljWk5JKZa5LPZy3EsOJL+Wbso
         BR2G+CQnRbRmOZp4EtRSjVBNCV1wcvsiBthYPhLw4wp19/p42Tppj3ZzjVs4S3xCRVyZ
         SbmnnRheGpx57/dyYLpDb76ZZ6LshGImHng7ABbAJJFtWPmaLJpquEdKX574YL18aKjp
         FgGMmNNVkqKC999p/cND+hU5bU8OFVGWG0LAr8Eq/Tq58z6HAOROKLkE0CwJoWZuv+Bt
         VhhyUBvmoX4/Vx6BsgQVR+x1kD2W8XO+2DghXePdzAk3jjdCPmq39GfY23EnI3qJ6iYP
         EzaQ==
X-Gm-Message-State: AOAM5320lql8JbdYIdSx3SRF1plUsmBVz/3uWdY27/UY+FOCCRJHpUBN
        FsdrpeRKCEv2GEmRxiGyy5bTEP+RynP5SLX4WOvVe4SK
X-Google-Smtp-Source: ABdhPJw9f+l4RTDD4jWxywL0H48Wz9q+LVZFhWOjqWXLozDzKAVld3QYKHdAa8IGG/wOXcKkfxHlK2kVPPFj3nhz9aM=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr808909otl.311.1609876314804;
 Tue, 05 Jan 2021 11:51:54 -0800 (PST)
MIME-Version: 1.0
References: <1609862799-2549739-1-git-send-email-bodefang@126.com> <adf3a79f-9e17-da80-3c45-9aa72fb0b85d@amd.com>
In-Reply-To: <adf3a79f-9e17-da80-3c45-9aa72fb0b85d@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 5 Jan 2021 14:51:43 -0500
Message-ID: <CADnq5_NsMDFC6ZkHwHvnvACLx8JAqxDm2OQot-dq+Sg28mndgg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Add check to prevenet IH overflow
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Defang Bo <bodefang@126.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 11:49 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 05.01.21 um 17:06 schrieb Defang Bo:
> > Similar to commit <b82175750131>("drm/amdgpu: fix IH overflow on Vega10=
 v2").
> > When an ring buffer overflow happens the appropriate bit is set in the =
WPTR
> > register which is also written back to memory. But clearing the bit in =
the
> > WPTR doesn't trigger another memory writeback.
> >
> > So what can happen is that we end up processing the buffer overflow ove=
r and
> > over again because the bit is never cleared. Resulting in a random syst=
em
> > lockup because of an infinite loop in an interrupt handler.
> >
> > Signed-off-by: Defang Bo <bodefang@126.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Thanks for the help,
> Christian.

Applied.  Thanks!

Alex


>
> > ---
> > Changes since v1:
> > - Modify the subject and replace the wrong register.
> > ---
> > ---
> >   drivers/gpu/drm/amd/amdgpu/cz_ih.c      | 39 +++++++++++++++++++++---=
---------
> >   drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 36 +++++++++++++++++++-----=
------
> >   drivers/gpu/drm/amd/amdgpu/tonga_ih.c   | 37 ++++++++++++++++++++----=
-------
> >   3 files changed, 72 insertions(+), 40 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/cz_ih.c
> > index 1dca0cabc326..65361afb21ab 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> > @@ -190,22 +190,33 @@ static u32 cz_ih_get_wptr(struct amdgpu_device *a=
dev,
> >                         struct amdgpu_ih_ring *ih)
> >   {
> >       u32 wptr, tmp;
> > -
> > +
> >       wptr =3D le32_to_cpu(*ih->wptr_cpu);
> >
> > -     if (REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW)) {
> > -             wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> > -             /* When a ring buffer overflow happen start parsing inter=
rupt
> > -              * from the last not overwritten vector (wptr + 16). Hope=
fully
> > -              * this should allow us to catchup.
> > -              */
> > -             dev_warn(adev->dev, "IH ring buffer overflow (0x%08X, 0x%=
08X, 0x%08X)\n",
> > -                     wptr, ih->rptr, (wptr + 16) & ih->ptr_mask);
> > -             ih->rptr =3D (wptr + 16) & ih->ptr_mask;
> > -             tmp =3D RREG32(mmIH_RB_CNTL);
> > -             tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEA=
R, 1);
> > -             WREG32(mmIH_RB_CNTL, tmp);
> > -     }
> > +     if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> > +             goto out;
> > +
> > +     /* Double check that the overflow wasn't already cleared. */
> > +     wptr =3D RREG32(mmIH_RB_WPTR);
> > +
> > +     if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> > +             goto out;
> > +
> > +     wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> > +
> > +     /* When a ring buffer overflow happen start parsing interrupt
> > +      * from the last not overwritten vector (wptr + 16). Hopefully
> > +      * this should allow us to catchup.
> > +      */
> > +     dev_warn(adev->dev, "IH ring buffer overflow (0x%08X, 0x%08X, 0x%=
08X)\n",
> > +             wptr, ih->rptr, (wptr + 16) & ih->ptr_mask);
> > +     ih->rptr =3D (wptr + 16) & ih->ptr_mask;
> > +     tmp =3D RREG32(mmIH_RB_CNTL);
> > +     tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> > +     WREG32(mmIH_RB_CNTL, tmp);
> > +
> > +
> > +out:
> >       return (wptr & ih->ptr_mask);
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/=
amd/amdgpu/iceland_ih.c
> > index a13dd9a51149..8e4dae8addb9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> > @@ -193,19 +193,29 @@ static u32 iceland_ih_get_wptr(struct amdgpu_devi=
ce *adev,
> >
> >       wptr =3D le32_to_cpu(*ih->wptr_cpu);
> >
> > -     if (REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW)) {
> > -             wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> > -             /* When a ring buffer overflow happen start parsing inter=
rupt
> > -              * from the last not overwritten vector (wptr + 16). Hope=
fully
> > -              * this should allow us to catchup.
> > -              */
> > -             dev_warn(adev->dev, "IH ring buffer overflow (0x%08X, 0x%=
08X, 0x%08X)\n",
> > -                      wptr, ih->rptr, (wptr + 16) & ih->ptr_mask);
> > -             ih->rptr =3D (wptr + 16) & ih->ptr_mask;
> > -             tmp =3D RREG32(mmIH_RB_CNTL);
> > -             tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEA=
R, 1);
> > -             WREG32(mmIH_RB_CNTL, tmp);
> > -     }
> > +     if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> > +             goto out;
> > +
> > +     /* Double check that the overflow wasn't already cleared. */
> > +     wptr =3D RREG32(mmIH_RB_WPTR);
> > +
> > +     if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> > +             goto out;
> > +
> > +     wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> > +     /* When a ring buffer overflow happen start parsing interrupt
> > +      * from the last not overwritten vector (wptr + 16). Hopefully
> > +      * this should allow us to catchup.
> > +      */
> > +     dev_warn(adev->dev, "IH ring buffer overflow (0x%08X, 0x%08X, 0x%=
08X)\n",
> > +             wptr, ih->rptr, (wptr + 16) & ih->ptr_mask);
> > +     ih->rptr =3D (wptr + 16) & ih->ptr_mask;
> > +     tmp =3D RREG32(mmIH_RB_CNTL);
> > +     tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> > +     WREG32(mmIH_RB_CNTL, tmp);
> > +
> > +
> > +out:
> >       return (wptr & ih->ptr_mask);
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/am=
d/amdgpu/tonga_ih.c
> > index e40140bf6699..2ba1ce323b6d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> > @@ -195,19 +195,30 @@ static u32 tonga_ih_get_wptr(struct amdgpu_device=
 *adev,
> >
> >       wptr =3D le32_to_cpu(*ih->wptr_cpu);
> >
> > -     if (REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW)) {
> > -             wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> > -             /* When a ring buffer overflow happen start parsing inter=
rupt
> > -              * from the last not overwritten vector (wptr + 16). Hope=
fully
> > -              * this should allow us to catchup.
> > -              */
> > -             dev_warn(adev->dev, "IH ring buffer overflow (0x%08X, 0x%=
08X, 0x%08X)\n",
> > -                      wptr, ih->rptr, (wptr + 16) & ih->ptr_mask);
> > -             ih->rptr =3D (wptr + 16) & ih->ptr_mask;
> > -             tmp =3D RREG32(mmIH_RB_CNTL);
> > -             tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEA=
R, 1);
> > -             WREG32(mmIH_RB_CNTL, tmp);
> > -     }
> > +     if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> > +             goto out;
> > +
> > +     /* Double check that the overflow wasn't already cleared. */
> > +     wptr =3D RREG32(mmIH_RB_WPTR);
> > +
> > +     if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> > +             goto out;
> > +
> > +     wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> > +
> > +     /* When a ring buffer overflow happen start parsing interrupt
> > +      * from the last not overwritten vector (wptr + 16). Hopefully
> > +      * this should allow us to catchup.
> > +      */
> > +
> > +     dev_warn(adev->dev, "IH ring buffer overflow (0x%08X, 0x%08X, 0x%=
08X)\n",
> > +             wptr, ih->rptr, (wptr + 16) & ih->ptr_mask);
> > +     ih->rptr =3D (wptr + 16) & ih->ptr_mask;
> > +     tmp =3D RREG32(mmIH_RB_CNTL);
> > +     tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> > +     WREG32(mmIH_RB_CNTL, tmp);
> > +
> > +out:
> >       return (wptr & ih->ptr_mask);
> >   }
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
