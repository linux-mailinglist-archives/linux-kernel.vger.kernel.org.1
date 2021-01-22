Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC0B3004A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbhAVNzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbhAVNzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:55:43 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F3CC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:55:02 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id q205so5974104oig.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXLHixBiJpq4dDQEs6Gtzm6NcpCMBkU8X2Af5+47SP8=;
        b=fRMpTwPjIHUaiFQn3JWCshKMbvL/9jw9UTg2r5aLKcTL6wI8i5Aeh+fcc5fL/Qw2dr
         5mbSk7k9MXRDR/3PFkmwZsS9bakHodMpF6ufpYOGwwr3Kkxpe7KZY5pWhLhMuKeqOhYu
         Jj0Eb+R39koAF7xKwpPGpp19H95FqvvjmmP2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXLHixBiJpq4dDQEs6Gtzm6NcpCMBkU8X2Af5+47SP8=;
        b=ESe0TTrEbn4K05q0bsl5HkXfVtK2kr4CVXH4iy0IyOhioxjNlpDs+oCm7R4MqwdkX8
         Q2vB68NZa9jrKoOHAqfpynNqw4+/klTti6SyYzawV6LpG+v2atnKDodrkhpAQwMTD8Up
         t5lP9hofw67QlHSUrJPoK1wddYKQfzSA+ZkP1DHPOxuMyipOlDB69MfuKPl6SuyroUj+
         nK1/Bs3zeXUPyem2ZTxkyfiqf2Ax0MU9NVNlRRujo4G0wlOccSuM1tov2lqG1AzU02yp
         XVxqDtWlXauQXnIwXQ5BrbZi1Ojnctk5FxGm5pwB9ScDrcujt7SkYWR+rB+mYgEIHtz/
         0/tA==
X-Gm-Message-State: AOAM531mTTNdVzMQJpBdCoz83do3hmygCpCm5uDJjWszlI7VPWvgn/A0
        Z12dmmize08jarLnWTYiZcLSOK/me92046S5WSxhwg==
X-Google-Smtp-Source: ABdhPJwW4KEp6S+mGGfS/0Lx+8OAYX5f6OO9aCFkx+hayuV7D2MQb1meuWL+LmKrJUAXW2513f7/HixYeilJ9rFPIxk=
X-Received: by 2002:aca:1906:: with SMTP id l6mr3220663oii.101.1611323702207;
 Fri, 22 Jan 2021 05:55:02 -0800 (PST)
MIME-Version: 1.0
References: <20210120111240.2509679-1-kraxel@redhat.com> <20210120111240.2509679-3-kraxel@redhat.com>
 <a4187459-1dbd-e799-fba4-bf7021de831b@suse.de> <20210122133545.acloe4ytgp6r4iql@sirius.home.kraxel.org>
In-Reply-To: <20210122133545.acloe4ytgp6r4iql@sirius.home.kraxel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 22 Jan 2021 14:54:51 +0100
Message-ID: <CAKMK7uHeQt6VPkm0ufuVVxdGQkmq3+1vrDERzZS54rtcVhJRAw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] drm/qxl: unpin release objects
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        Dave Airlie <airlied@redhat.com>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 2:35 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Fri, Jan 22, 2021 at 09:13:42AM +0100, Thomas Zimmermann wrote:
> > Hi
> >
> > Am 20.01.21 um 12:12 schrieb Gerd Hoffmann:
> > > Balances the qxl_create_bo(..., pinned=true, ...);
> > > call in qxl_release_bo_alloc().
> > >
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > ---
> > >   drivers/gpu/drm/qxl/qxl_release.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
> > > index 0fcfc952d5e9..add979cba11b 100644
> > > --- a/drivers/gpu/drm/qxl/qxl_release.c
> > > +++ b/drivers/gpu/drm/qxl/qxl_release.c
> > > @@ -166,6 +166,7 @@ qxl_release_free_list(struct qxl_release *release)
> > >             entry = container_of(release->bos.next,
> > >                                  struct qxl_bo_list, tv.head);
> > >             bo = to_qxl_bo(entry->tv.bo);
> > > +           bo->tbo.pin_count = 0; /* ttm_bo_unpin(&bo->tbo); */
> >
> > This code looks like a workaround or a bug.
> >
> > AFAICT the only place with pre-pinned BO is qdev->dumb_shadow_bo. Can you
> > remove the pinned flag entirely and handle pinning as part of
> > dumb_shadow_bo's code.
>
> No, the release objects are pinned too, and they must be
> pinned (qxl commands are in there, and references are
> placed in the qxl rings, so allowing them to roam is
> a non-starter).
>
> > if (pin_count)
> >     ttm_bo_unpin();
> > WARN_ON(pin_count); /* should always be 0 now */
>
> Well, the pin_count is 1 at this point.
> No need for the if().
>
> Just calling ttm_bo_unpin() here makes lockdep unhappy.

How does that one splat? But yeah if that's a problem should be
explained in the comment. I'd then also only do a pin_count--; to make
sure you can still catch other pin leaks if you have them. Setting it
to 0 kinda defeats the warning.
-Daniel

>
> Not calling ttm_bo_unpin() makes ttm_bo_release() throw
> a WARN() because of the pin.
>
> Clearing pin_count (which is how ttm fixes things up
> in the error path) works.
>
> I'm open to better ideas.
>
> take care,
>   Gerd
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
