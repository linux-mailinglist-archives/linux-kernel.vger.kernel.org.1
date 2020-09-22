Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042F9273C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbgIVHht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:37:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58287 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729906AbgIVHhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:37:47 -0400
Received: from mail-oi1-f198.google.com ([209.85.167.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <koba.ko@canonical.com>)
        id 1kKcrx-0006Gw-3D
        for linux-kernel@vger.kernel.org; Tue, 22 Sep 2020 07:37:45 +0000
Received: by mail-oi1-f198.google.com with SMTP id v21so7620780oif.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 00:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdoGIl1yU6ytmBIfhkEKpDjTjVXRjNQ+L3QzfJwexIY=;
        b=T2EbVNZjWw6h4Ali6qMVBXAiDpXhgKk6P3Cl0Ntq3eHGxge+I4AoN8M26WXC2xFzPD
         j2iaLSKsEWJO4LCUXvjqoI41EYosTY7gZpMS2NyfnawMRe5pitpSoHbdn6IQ0LIoB70b
         IPyYILZDmS4BC7dV9WZ1kn/4JiN5WkIQNO+ZE9DXSFS1FnSLP59QgF6dvElBHEa6ju86
         EhMBtZ8eymm6V2vKYqYDQfOSbaGNLZqjmD7r72MnvrI0Hxh2TxpsaUid5hIOU4jSpxYo
         uB0HiLlLx/hfNg/scxjdQuJMA/0+6ukH9GNU9u2UQ9cqHlCICPXEAyAvz7ancxJjq76S
         ITbA==
X-Gm-Message-State: AOAM531zM6xQuez6AJ7Zk8CwSYYTJz2Hn/Xktalmr58Yxgiql1rDjRb9
        tom7IODKO7RWvmN/KMOJbkwzwkZkVhg/S4bqlGNMla9/8AeMoVTwNBztGNQPbeaRvuB4M53rVly
        aM3FzeqP6CNYsM4C3C/1ury9KcU7MGfOIePoQvlrDE5YGxCVXVPeyzR+Cjw==
X-Received: by 2002:aca:603:: with SMTP id 3mr1880713oig.49.1600760263786;
        Tue, 22 Sep 2020 00:37:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDowMCJZmD1z8PQlqQGJLpOU6i5dqO2/P4MprMH+CP5yRJLk0CxFmkY7hPwXWFWcEySoIoM9DTtDGhS+tkrH8=
X-Received: by 2002:aca:603:: with SMTP id 3mr1880697oig.49.1600760263461;
 Tue, 22 Sep 2020 00:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200911034431.29059-1-koba.ko@canonical.com> <5f99b65c8a092df343c68249f2bce62e4cd0abff.camel@redhat.com>
In-Reply-To: <5f99b65c8a092df343c68249f2bce62e4cd0abff.camel@redhat.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Tue, 22 Sep 2020 15:37:32 +0800
Message-ID: <CAJB-X+W4uUpcBH6mD-oZASCMjJ2LALQ0LAX_2aCZy5STQpEquQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/dp_mst: Retrieve extended DPCD caps for topology manager
To:     Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Anthony Wong <anthony.wong@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 2:11 AM Lyude Paul <lyude@redhat.com> wrote:
>
> Hi, sorry I lost track of this until just now. Comments down below:
>
Sorry, the wrong base. I will modify it based on v2 and will send  v4.
> On Fri, 2020-09-11 at 11:44 +0800, Koba Ko wrote:
> > As per DP-1.3, First check DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT.
> > If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 1, read the DP_DP13_DPCD_REV to
> > get the faster capability.
> > If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 0, read DP_DPCD_REV.
> >
> > Signed-off-by: Koba Ko <koba.ko@canonical.com>
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > ---
> > Changelog:
> > 1. Adjust the commit message.
> > 2. use drm_dbg_kms instead and print the return code.
> > ---
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 14 +++-----------
> >  1 file changed, 3 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index 7753c718ddf9..63f8809b9aa4 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -3671,8 +3671,6 @@ EXPORT_SYMBOL(drm_dp_read_mst_cap);
> >  int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr,
> > bool mst_state)
> >  {
> >       int ret = 0;
> > -     u8 dpcd_ext = 0;
> > -     unsigned int dpcd_offset = 0;
> >       struct drm_dp_mst_branch *mstb = NULL;
> >
> >       mutex_lock(&mgr->payload_lock);
> > @@ -3686,17 +3684,11 @@ int drm_dp_mst_topology_mgr_set_mst(struct
> > drm_dp_mst_topology_mgr *mgr, bool ms
> >               struct drm_dp_payload reset_pay;
> >
> >               WARN_ON(mgr->mst_primary);
> > -             drm_dp_dpcd_read(mgr->aux,
> > -                              DP_TRAINING_AUX_RD_INTERVAL,
> > -                              &dpcd_ext, sizeof(dpcd_ext));
> > -
> > -             dpcd_offset =
> > -                     ((dpcd_ext & DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT)
> > ?  DP_DP13_DPCD_REV : DP_DPCD_REV);
>
>
> Uh, are you sure you formatted this patch correctly? None of these hunks are present upstream, this looks like it's a diff for the previous version of this patch that you sent out
> >
> >               /* get dpcd info */
> > -             ret = drm_dp_dpcd_read(mgr->aux, dpcd_offset, mgr->dpcd,
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
