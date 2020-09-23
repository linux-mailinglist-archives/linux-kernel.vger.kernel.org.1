Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE3C2759BE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgIWOSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:18:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbgIWOSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600870684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=00seU7d+SoucboqzE8lt6myQo/TE6faprIC1HbLkiSI=;
        b=N/E6Tb4GN1Y/at4ZfxzFhD4n8c1DcpR6F1yOnqSvXPmxiNEjSTXqiyOE+bHhyVG/w3v+mi
        Ctkf6DyAB+94bp1XfVL/mhjhx7glzzrB8xbF3JxqT4t1cwqemJhbgQUhmrRRj11DZ8YKmS
        F+qvsAOgQHSDi403mAHrqVvVqkYYLfQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-wA5f1xVwMy6nDaF9GKJqAQ-1; Wed, 23 Sep 2020 10:18:02 -0400
X-MC-Unique: wA5f1xVwMy6nDaF9GKJqAQ-1
Received: by mail-qt1-f197.google.com with SMTP id o13so19400219qtl.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 07:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=00seU7d+SoucboqzE8lt6myQo/TE6faprIC1HbLkiSI=;
        b=DJk7tjRD21UmNRk7z+ZQuGOo0GvDRApcj15CpVTDaiJKQE1k9t8QkHZNe4ygJOPGcV
         8+VinF5XmCB6EPg4UuJHl9tKwfKC2eEhe97N4QAt4q1dMzr1Dcldsx1UAAoomfCdbCIf
         4krHAjCmqPk/R0u6KWwZQpP1WdPH+/I6+59MCJWLCn//3yWa31i4Z76pOGBHfncR+2aG
         joziqVjGp+hc+fYtnEDPy1NSMnyZAlLI2nKg5r4p9EwH1ZijgH0vE3nY15WitGcXlnEh
         DYkF3YHksTdajfGCyNpyDOLfBvSpw5DUyB/U84n3zXizq0FstM6b2q/gTMFoGonkK2TA
         6v9w==
X-Gm-Message-State: AOAM532V2fVlo6h+h4ToWU8HuAr6jL0fLu3l9cHrq03N6fCpQzqodKuH
        VH0M6UA33oefiV+eamzQqH8JQPyTYmRDsQL2OYFIsQxtIRouFqIqBHEJTItjMaajduDKnKFC90l
        6KAEHA3WhLzstuVj7VlAUamdb
X-Received: by 2002:a05:620a:4c1:: with SMTP id 1mr86393qks.420.1600870681846;
        Wed, 23 Sep 2020 07:18:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwr8aM1veFfHsIXYesof9K7McKgBVEL/+koWqT2HvdqRjkvGc3XfUlnc5C1EEF1++R8E2Vfw==
X-Received: by 2002:a05:620a:4c1:: with SMTP id 1mr86371qks.420.1600870681535;
        Wed, 23 Sep 2020 07:18:01 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id d5sm15987312qtm.36.2020.09.23.07.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 07:18:00 -0700 (PDT)
Message-ID: <9a4f2216cb621f349aa393de5d64763e4a23bc2b.camel@redhat.com>
Subject: Re: [PATCH V4] drm/dp_mst: Retrieve extended DPCD caps for topology
 manager
From:   Lyude Paul <lyude@redhat.com>
To:     Koba Ko <koba.ko@canonical.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anthony Wong <anthony.wong@canonical.com>
Date:   Wed, 23 Sep 2020 10:17:59 -0400
In-Reply-To: <CAJB-X+U0M1YXUyAX2nDxddwwxnPygfkk47PFrFnvERh4fUBxiw@mail.gmail.com>
References: <20200922065313.4794-1-koba.ko@canonical.com>
         <7231e2199a19aa6c8ecbecf5e80725e2a1aded73.camel@redhat.com>
         <CAJB-X+U0M1YXUyAX2nDxddwwxnPygfkk47PFrFnvERh4fUBxiw@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-23 at 10:16 +0800, Koba Ko wrote:
> Thanks for the review.
> Sorry for that I thought the review tag should be appended by myself.
> One thing to confirm with you, will you or I push this patch to drm-misc-
> next ?

I already pushed it with the change, so everything is all set

> Thanks a lot.
> 
> On Wed, Sep 23, 2020 at 2:01 AM Lyude Paul <lyude@redhat.com> wrote:
> > One last change I realized we should do is print the name of the AUX
> > adapter
> > in question. I don't mind just adding that myself before I push it though
> > so
> > you don't need to send a respin.
> > 
> > Going to go push this to drm-misc-next, thanks!
> > 
> > On Tue, 2020-09-22 at 14:53 +0800, Koba Ko wrote:
> > > As per DP-1.3, First check DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT.
> > > If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 1,read the DP_DP13_DPCD_REV
> > > to
> > > get the faster capability.
> > > If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 0,read DP_DPCD_REV.
> > > 
> > > Signed-off-by: Koba Ko <koba.ko@canonical.com>
> > > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > > ---
> > >  drivers/gpu/drm/drm_dp_mst_topology.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > index e87542533640..63f8809b9aa4 100644
> > > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > @@ -3686,9 +3686,9 @@ int drm_dp_mst_topology_mgr_set_mst(struct
> > > drm_dp_mst_topology_mgr *mgr, bool ms
> > >               WARN_ON(mgr->mst_primary);
> > > 
> > >               /* get dpcd info */
> > > -             ret = drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, mgr->dpcd,
> > > DP_RECEIVER_CAP_SIZE);
> > > -             if (ret != DP_RECEIVER_CAP_SIZE) {
> > > -                     DRM_DEBUG_KMS("failed to read DPCD\n");
> > > +             ret = drm_dp_read_dpcd_caps(mgr->aux, mgr->dpcd);
> > > +             if (ret < 0) {
> > > +                     drm_dbg_kms(mgr->dev, "failed to read DPCD, ret
> > > %d\n",
> > > ret);
> > >                       goto out_unlock;
> > >               }
> > > 
> > --
> > Cheers,
> >         Lyude Paul (she/her)
> >         Software Engineer at Red Hat
> > 
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat

