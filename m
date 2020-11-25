Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D972C48AE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 20:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgKYTqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 14:46:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29970 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728749AbgKYTqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606333562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e69pYqK6LdWzFPvgW/MsEcbIzlfutA0tPozCsp8JsBA=;
        b=Z5yLfhR/UyjAOAb+LalxmEM+GyGLj+jaQni/5BiUEwRoxnuxPIkylY4pGkB5vypsc3WrZo
        VCOhR2HBJgTOhcm6wZABH/57z6VrEu/Yn3/sN4oWjDNjsji1WHKpE2RRwlOsVEkTMnI7A5
        QsA6e5M8uSSRKUmSdTYp8LZ6OGr2sy0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-FUD3H0mYOLGrNuQgqdQ15w-1; Wed, 25 Nov 2020 14:46:01 -0500
X-MC-Unique: FUD3H0mYOLGrNuQgqdQ15w-1
Received: by mail-qk1-f200.google.com with SMTP id q25so3221068qkm.17
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e69pYqK6LdWzFPvgW/MsEcbIzlfutA0tPozCsp8JsBA=;
        b=KnFoL6i0vFRcNA/PXo/bAByI1hWmxPA+SBDfX3CC8Hiu9p8aUeTsVgX6tuq0quyTsr
         BlcM2exEW2rs/etayD3l5sDzVU+ZjV1ZMweFYuvR/s9KT5rOeni5k9YERNAoDzsexYHM
         6PHJe24+FG4WAxwIjuGa/YLrcqGAqkpYOxpnqs67wadqYWOOPj53blGvOn1MoZdYg1ko
         Z4XMbIzglP3rjZio/2P7bHLHJ8zk24Q4oQQXhCYDhgxCIWWke1ARkuuXchWgXG3fKbXc
         b1dkthTo0AGgTcHRFsBq1kvojycBq+4HVpl7uPUgplZJQ4YzLO/I1FPU/dgD7BKPwe4B
         g/Uw==
X-Gm-Message-State: AOAM533auyFNxNVFd6fh9pof02cdXHwpTi659uEt4hWXxFgYtJQETG45
        5aMIw872fYm9Opb4XzwBdsKFeDu5QthlqgWy5qCrStkebtm5bd+t4cUzH3SLnbh9wDZv0TOk3s4
        XAswxrs7+qsUf8GdMyG/GNzpe
X-Received: by 2002:a37:e40e:: with SMTP id y14mr512139qkf.356.1606333560285;
        Wed, 25 Nov 2020 11:46:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJpcF9jhzLh2FJKyoAjd88LJ5nR2LjSeUm7SVmZM9+VDLLKO7LmCId29U3QTbFbLzEqKyIfA==
X-Received: by 2002:a37:e40e:: with SMTP id y14mr512121qkf.356.1606333560000;
        Wed, 25 Nov 2020 11:46:00 -0800 (PST)
Received: from xps13 ([136.56.20.95])
        by smtp.gmail.com with ESMTPSA id h142sm337753qke.104.2020.11.25.11.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 11:45:59 -0800 (PST)
Date:   Wed, 25 Nov 2020 14:45:57 -0500
From:   Jeremy Cline <jcline@redhat.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm/nouveau: Add a dedicated mutex for the clients
 list
Message-ID: <20201125194557.GC20747@xps13>
References: <20201103194912.184413-1-jcline@redhat.com>
 <20201103194912.184413-3-jcline@redhat.com>
 <505be3af57c36222564d0790aa8a992b1ea4d287.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <505be3af57c36222564d0790aa8a992b1ea4d287.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 01:37:06PM -0500, Lyude Paul wrote:
> On Tue, 2020-11-03 at 14:49 -0500, Jeremy Cline wrote:
> > Rather than protecting the nouveau_drm clients list with the lock within
> > the "client" nouveau_cli, add a dedicated lock to serialize access to
> > the list. This is both clearer and necessary to avoid lockdep being
> > upset with us when we need to iterate through all the clients in the
> > list and potentially lock their mutex, which is the same class as the
> > lock protecting the entire list.
> > 
> > Signed-off-by: Jeremy Cline <jcline@redhat.com>
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_drm.c | 9 +++++----
> >  drivers/gpu/drm/nouveau/nouveau_drv.h | 5 +++++
> >  2 files changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c
> > b/drivers/gpu/drm/nouveau/nouveau_drm.c
> > index 4fe4d664c5f2..d182b877258a 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> > @@ -557,6 +557,7 @@ nouveau_drm_device_init(struct drm_device *dev)
> >                 nvkm_dbgopt(nouveau_debug, "DRM");
> >  
> >         INIT_LIST_HEAD(&drm->clients);
> > +       mutex_init(&drm->clients_lock);
> 
> Looks like you forgot to hook up mutex_destroy() somewhere. Note there's
> actually plenty of code in nouveau right now that forgets to do this, but at
> some point we should probably fix that and avoid adding more spots where there's
> no mutex_destroy().
> 

I'm guilty of having looked at the existing locking init code in nouveau
and modeling this work accordingly. I'll send out a fix for this shortly
and look at tidying up the rest of the locks in a separate series.
Thanks!

> >         spin_lock_init(&drm->tile.lock);
> >  
> >         /* workaround an odd issue on nvc1 by disabling the device's
> > @@ -1089,9 +1090,9 @@ nouveau_drm_open(struct drm_device *dev, struct drm_file
> > *fpriv)
> >  
> >         fpriv->driver_priv = cli;
> >  
> > -       mutex_lock(&drm->client.mutex);
> > +       mutex_lock(&drm->clients_lock);
> >         list_add(&cli->head, &drm->clients);
> > -       mutex_unlock(&drm->client.mutex);
> > +       mutex_unlock(&drm->clients_lock);
> >  
> >  done:
> >         if (ret && cli) {
> > @@ -1117,9 +1118,9 @@ nouveau_drm_postclose(struct drm_device *dev, struct
> > drm_file *fpriv)
> >                 nouveau_abi16_fini(cli->abi16);
> >         mutex_unlock(&cli->mutex);
> >  
> > -       mutex_lock(&drm->client.mutex);
> > +       mutex_lock(&drm->clients_lock);
> >         list_del(&cli->head);
> > -       mutex_unlock(&drm->client.mutex);
> > +       mutex_unlock(&drm->clients_lock);
> >  
> >         nouveau_cli_fini(cli);
> >         kfree(cli);
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h
> > b/drivers/gpu/drm/nouveau/nouveau_drv.h
> > index 9d04d1b36434..550e5f335146 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_drv.h
> > +++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
> > @@ -141,6 +141,11 @@ struct nouveau_drm {
> >  
> >         struct list_head clients;
> >  
> > +       /**
> > +        * @clients_lock: Protects access to the @clients list of &struct
> > nouveau_cli.
> > +        */
> > +       struct mutex clients_lock;
> > +
> >         u8 old_pm_cap;
> >  
> >         struct {
> 
> -- 
> Sincerely,
>    Lyude Paul (she/her)
>    Software Engineer at Red Hat
>    
> Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
> asked me a question, are waiting for a review/merge on a patch, etc. and I
> haven't responded in a while, please feel free to send me another email to check
> on my status. I don't bite!
> 

