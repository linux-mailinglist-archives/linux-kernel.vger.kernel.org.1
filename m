Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5091C274EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 04:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgIWCQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 22:16:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34176 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgIWCQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 22:16:48 -0400
Received: from mail-oi1-f198.google.com ([209.85.167.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <koba.ko@canonical.com>)
        id 1kKuKr-0007Ju-UE
        for linux-kernel@vger.kernel.org; Wed, 23 Sep 2020 02:16:46 +0000
Received: by mail-oi1-f198.google.com with SMTP id w200so8572206oie.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 19:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8KnY5LD0NHhoP43zjX0d7M1I3RNfGZr68FzzWqbIXA=;
        b=VSL17r3xTQI+xk4pu68B5TR776sTw2gD+e9w/vsi/IvBGaAFNEg2jvut2Bk/6RiyOW
         eK4XrPbbL/VubezJ6J4Hhh33lb3wYCqet3/cy+B2lz31QpZ8VO26T24kCAIqrr66Z+zG
         4OeRiIczRsu4v4ZVPoRc9yQB9l2cwTxP0ir8cikQqjfqVLmoFJUqNqLAv4MiRKK0JXFO
         6DY2mJuWQQcVnwdxkO3847xyJBZh+qijWHWievC9Z+Sk3OuXt1+KWaIgUk7O5bDofwNI
         8PySQ8feTxykPyGgpkSl2ZEUl9n4J+4QwWt0g8YBT/g/8BhBvWSbe3G77k2uS8ijgmt3
         em/w==
X-Gm-Message-State: AOAM531IKg61k9RIot783uXE8f6pTLCSZGgteftdOiaFulSn/ygboM+B
        uhtfhONAu1SsIWwxMkZQzNEZR7WyuLgmLTdhmVsYLuf1aCEpy5MSU61j2pW/rM6dAC7YrYt/35x
        IHwbONjuOAN2NwC7IxKeL8vBpGV3wBsn59LSzI1EbpKqqcB1AiAJksYEMyQ==
X-Received: by 2002:a9d:6491:: with SMTP id g17mr4419892otl.326.1600827404800;
        Tue, 22 Sep 2020 19:16:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNu3+Q2WaRNqHQicrUqSqPPGJLJGS/Wbrczh0WSxJi0/l5DO7fl633zoEHsWNGUXegasqKvoowP0DcxiurA40=
X-Received: by 2002:a9d:6491:: with SMTP id g17mr4419879otl.326.1600827404471;
 Tue, 22 Sep 2020 19:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200922065313.4794-1-koba.ko@canonical.com> <7231e2199a19aa6c8ecbecf5e80725e2a1aded73.camel@redhat.com>
In-Reply-To: <7231e2199a19aa6c8ecbecf5e80725e2a1aded73.camel@redhat.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Wed, 23 Sep 2020 10:16:33 +0800
Message-ID: <CAJB-X+U0M1YXUyAX2nDxddwwxnPygfkk47PFrFnvERh4fUBxiw@mail.gmail.com>
Subject: Re: [PATCH V4] drm/dp_mst: Retrieve extended DPCD caps for topology manager
To:     Lyude Paul <lyude@redhat.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anthony Wong <anthony.wong@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review.
Sorry for that I thought the review tag should be appended by myself.
One thing to confirm with you, will you or I push this patch to drm-misc-next ?

Thanks a lot.

On Wed, Sep 23, 2020 at 2:01 AM Lyude Paul <lyude@redhat.com> wrote:
>
> One last change I realized we should do is print the name of the AUX adapter
> in question. I don't mind just adding that myself before I push it though so
> you don't need to send a respin.
>
> Going to go push this to drm-misc-next, thanks!
>
> On Tue, 2020-09-22 at 14:53 +0800, Koba Ko wrote:
> > As per DP-1.3, First check DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT.
> > If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 1,read the DP_DP13_DPCD_REV to
> > get the faster capability.
> > If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 0,read DP_DPCD_REV.
> >
> > Signed-off-by: Koba Ko <koba.ko@canonical.com>
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index e87542533640..63f8809b9aa4 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -3686,9 +3686,9 @@ int drm_dp_mst_topology_mgr_set_mst(struct
> > drm_dp_mst_topology_mgr *mgr, bool ms
> >               WARN_ON(mgr->mst_primary);
> >
> >               /* get dpcd info */
> > -             ret = drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, mgr->dpcd,
> > DP_RECEIVER_CAP_SIZE);
> > -             if (ret != DP_RECEIVER_CAP_SIZE) {
> > -                     DRM_DEBUG_KMS("failed to read DPCD\n");
> > +             ret = drm_dp_read_dpcd_caps(mgr->aux, mgr->dpcd);
> > +             if (ret < 0) {
> > +                     drm_dbg_kms(mgr->dev, "failed to read DPCD, ret %d\n",
> > ret);
> >                       goto out_unlock;
> >               }
> >
> --
> Cheers,
>         Lyude Paul (she/her)
>         Software Engineer at Red Hat
>
