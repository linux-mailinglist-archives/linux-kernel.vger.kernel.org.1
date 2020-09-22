Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD606273B04
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 08:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgIVGjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 02:39:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57058 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbgIVGjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 02:39:55 -0400
Received: from mail-oo1-f71.google.com ([209.85.161.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <koba.ko@canonical.com>)
        id 1kKbxw-0003BE-BQ
        for linux-kernel@vger.kernel.org; Tue, 22 Sep 2020 06:39:52 +0000
Received: by mail-oo1-f71.google.com with SMTP id p6so8142879ooo.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 23:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IpZ9NNf3JzpitwTHfm+igFTBUGXT+UKNE1QHrd1BCyY=;
        b=dWKxuCaDdMm1iuI5MoV3j9eSlw2Z9qp+EVcEhrwwxTIw2rOCm8lJ+c+mD6LmCDUmYU
         ERbofpYjiJ9njo5t4Bu3AjLu2E5HkRDN5EyjaqQFmPfs5ArRn6lJsrgSgjc4iy34kFxx
         CqHTMiqH8YxM8c3PH8Q97vuBkF+gRy3hFCsmGm+QiNTsjO3KI5Exh8+VnAPG5znOPOhr
         l4SGGVMOtp/nwU9IAOSNaGlsea/ojPt4di6PLu/CUbbBCQDcEttg3E7mJkNXMSMNU1pu
         pz2ygfse3HQLEJ5Oko0oOMJdithK3XiprijTK7asF1WKyczSMPbrf86ue6RZ4Va9moqg
         wk0g==
X-Gm-Message-State: AOAM533NfoXRCNYP4y9oKRlBwwJduFqScezpqU8Me8C+rKOLyUjjSugX
        TB0suoP+U36y8ZRDik+rwq1Qek5f1T5Tp/Ggi3UA4A/ai4d6FUzfVyq34USD9St2lItD5V0CHBj
        5ZPZriusWKY+F+9SPSHgusQGYvcjvCQudLN+Us5SOamsOAkiOJwxqrVoZWg==
X-Received: by 2002:aca:4fce:: with SMTP id d197mr1862539oib.17.1600756791151;
        Mon, 21 Sep 2020 23:39:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdbipZHJRZBHWlDsRwdIKYYUDV0qa8clnrwwEhL0wykwua1ij4eJ8ISgRtInsHSQiNgMspyGx+Ij/djkdNQ0o=
X-Received: by 2002:aca:4fce:: with SMTP id d197mr1862529oib.17.1600756790905;
 Mon, 21 Sep 2020 23:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200911034431.29059-1-koba.ko@canonical.com> <5f99b65c8a092df343c68249f2bce62e4cd0abff.camel@redhat.com>
In-Reply-To: <5f99b65c8a092df343c68249f2bce62e4cd0abff.camel@redhat.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Tue, 22 Sep 2020 14:39:40 +0800
Message-ID: <CAJB-X+VQH9yAhqkWJzAgiQzKtDStB3of2nCnQC02f079nMzcdA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/dp_mst: Retrieve extended DPCD caps for topology manager
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

On Tue, Sep 22, 2020 at 2:11 AM Lyude Paul <lyude@redhat.com> wrote:
>
> Hi, sorry I lost track of this until just now. Comments down below:
Sorry, the wrong base. I will modify it based on v2 and will send  v4.
>
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
