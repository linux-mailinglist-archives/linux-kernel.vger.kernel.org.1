Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AD42A2B05
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgKBMwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 07:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbgKBMwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:52:06 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F479C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 04:52:04 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id m26so12436951otk.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 04:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fMkq/VIu6fd+U26qy11bcn48l177zp7DNZNLDcC8+t4=;
        b=NDVwt/pVYEC750UTJE0s4J6JfMRuJGuZ5axCjsm/867iyTvOIQA71kEJ7rOwvA2uJK
         h2YIoyHvvyTzzEIOxqYrJJgzjB+hrNaFdipkdkPZ8SY+qC4/fqqKc90SaigG6BmW48bt
         tYRZIBm/F4Qpu5EDpooS+V6HzkMoBTCfnWFOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fMkq/VIu6fd+U26qy11bcn48l177zp7DNZNLDcC8+t4=;
        b=CFv5DSJp1f9ac/0fBflWYNQGKcochq1c87Ami7sPqyUWBrWQG0ak11azcl0T7+7Z4k
         98FUdAtLw0stcRflwmNRjjxYq+VyT3Qcad0mvGA4GpwUidhgy5TyZj77Aw9odBogl4b1
         NVEK7zQdEAC2Kcam7grKQkr+ufbvuMZeh4x9Bih+rOnoamE1el+LMTs2E4ycz26oQm1Q
         bbXT97/pI2QAY3TahQ4YcftFvg4xQuReOILsj2H2kGTL24mI5EbHv3xDLDZDmTNeNkk+
         /xTiPrLVhHyJkYFXa3MnQYoC28yrVTBBttboVE9gdzJxlGUkT5YpWNr/2ScfL2kWXZp6
         ATOQ==
X-Gm-Message-State: AOAM532d1+AKb8Agd6JKrka+xqtS8d2aljEbC1I0uyx2Qnm7qpdO5Rk7
        GrbTChY5/wtVi93gZ6V4cwrB6AZUF17KyerowX9ByQ==
X-Google-Smtp-Source: ABdhPJxyDuZkJAdOD9FOb99eLulTDZ7+rc12p+EOcj7msBdtsbwaHMm6Xwq+c7U/0m8FTtQO3fwxi/+WRsLRIJ6Ic54=
X-Received: by 2002:a9d:6e81:: with SMTP id a1mr11349917otr.303.1604321523932;
 Mon, 02 Nov 2020 04:52:03 -0800 (PST)
MIME-Version: 1.0
References: <1604315990-56787-1-git-send-email-tiantao6@hisilicon.com>
 <8a76d144-f8ba-bbbc-9177-53088f6dc73a@suse.de> <d0b8c494-0d08-11ae-c0e9-988dbf9ecd35@suse.de>
In-Reply-To: <d0b8c494-0d08-11ae-c0e9-988dbf9ecd35@suse.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 2 Nov 2020 13:51:52 +0100
Message-ID: <CAKMK7uHBjV8nEw9xW_MkGMeDrRSo9wuqCawdhw5D5t=JhVD5DA@mail.gmail.com>
Subject: Re: [PATCH] drm/irq: Add irq as false detection
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Tian Tao <tiantao6@hisilicon.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 1:40 PM Thomas Zimmermann <tzimmermann@suse.de> wrot=
e:
>
> Hi
>
> Am 02.11.20 um 13:09 schrieb Thomas Zimmermann:
> > Hi
> >
> > Am 02.11.20 um 12:19 schrieb Tian Tao:
> >> Add the detection of false for irq, so that the EINVAL is not
> >> returned when dev->irq_enabled is false.
> >>
> >> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> >> ---
> >>  drivers/gpu/drm/drm_irq.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/drm_irq.c b/drivers/gpu/drm/drm_irq.c
> >> index 09d6e9e..7537a3d 100644
> >> --- a/drivers/gpu/drm/drm_irq.c
> >> +++ b/drivers/gpu/drm/drm_irq.c
> >> @@ -172,6 +172,9 @@ int drm_irq_uninstall(struct drm_device *dev)
> >>      bool irq_enabled;
> >>      int i;
> >>
> >> +    if (!dev->irq_enabled || !dev)
> >> +            return 0;
> >> +
> >
> > Dereferencing a pointer before NULL-checking it, is Yoda programming. :=
)
> > I'd just drop the test for !dev and assume that dev is always valid.
> >
> > I suggest to change the int return value to void and return nothing.
> >
> > Re-reading the actual implementation of this function, this location
> > might be too early. Further below there already is a test for
> > irq_enabled. Put a drm_WARN_ON around it and it should be fine. This wa=
y
> > the vblank handlers will be disabled and erroneous callers will see a
> > warning in the kernel's log.
>
> In addition to these changes, you could also add a managed
> implementation of drm_irq_install(). The canonical name should be
> devm_drm_irq_install(). The function would call drm_irq_install() and
> register a cleanup handler via devm_add_action(). Example code is at [1].
>
> KMS drivers, such as hibmc, would then not have to bother about
> uninstalling the DRM irq.

Yup, devm_ is the right fix here imo, not trying to make the uninstall
hook resilient against drivers which can't keep track of stuff. So if
that's all there is, imo this patch is a bad idea, since we have
proper tools to make driver unloading easier on driver author's
nowadays.
-Daniel

> Best regards
> Thomas
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/gpu/drm/drm_drv.c#n664
>
>
> >
> > Best regards
> > Thomas
> >
> >>      irq_enabled =3D dev->irq_enabled;
> >>      dev->irq_enabled =3D false;
> >>
> >>
> >
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
