Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63782C47BF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 19:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733120AbgKYShN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 13:37:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35665 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733018AbgKYShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 13:37:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606329430;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EJkyuZXR06RwPbFHnHYe7mM4XfSI6mqJjT0lQPEIAPY=;
        b=NddnLJqLEin+nLS6/F+sZ3r/0f+LFTGlJyleKasu+3KIrGfrfx40XobbY68TpFPrC/66D8
        uaifQpCgjfPo7aZqoNvozmG5Y2RwjSU7l9f3Kz0XZp4WR0fvLfIkNbfy//+w3s9XQ9GVmS
        nr5rR62ok4fvjOAux17moIMUkgsYSiQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-4ExBvVR6MGysiogkL05Apw-1; Wed, 25 Nov 2020 13:37:09 -0500
X-MC-Unique: 4ExBvVR6MGysiogkL05Apw-1
Received: by mail-qk1-f197.google.com with SMTP id g28so3182918qka.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 10:37:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=EJkyuZXR06RwPbFHnHYe7mM4XfSI6mqJjT0lQPEIAPY=;
        b=ihq1pppKl2eSp56jWAfgKFEdG2rlYZKpuY/tt/Pg/QcdMBzseBBDCIi8YglREObbX4
         Ddl/vaFOWhkcnbWA5u2dMnqzkFF69iqH1iyWVwM9t4vFguyF4mEAZVSugJr3wVuOL2j/
         FnPR4gUA68rzI8zANnAZ7Z8urGuvvS1CdM2dniGCW+wY+bRMAoPhLfUwbvAM1zqTmLyC
         t/nQHd4Gyav9y3vP2AkrMP1Ia4Uy4IEXRi/UktunQoJyP1kTSffF0LrW2g2YsmcTLSXY
         fECuGRJaqZfm5A9tIQ3hBaPZ3c0Ph12E357oUXb56B9mZAdTwNO6piLTR3OIYNqO2C+6
         uj3g==
X-Gm-Message-State: AOAM531QGal9z336WfMPhbGKf2H+iMQfcv9DaApeOyeUZhIzBsNzPyCV
        A2HKzw+E3cIAsOE2xeoqcy2fMwiNB5N3oUa9p3MEurgqNQVBJTSSQkT2oxLcKBUPN+FvQNIaxfK
        FpVhnEbVCkzKDMiP9ix2BAK2k
X-Received: by 2002:aed:3ff1:: with SMTP id w46mr180296qth.83.1606329428709;
        Wed, 25 Nov 2020 10:37:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwq57UBIs3NHQEECAhbFbsnJGxdoiR0N5IgQQuxbOJr8SUKpOdW3DtqMTZ9p7kt2BufNBas3Q==
X-Received: by 2002:aed:3ff1:: with SMTP id w46mr180272qth.83.1606329428487;
        Wed, 25 Nov 2020 10:37:08 -0800 (PST)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id t56sm139681qth.27.2020.11.25.10.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 10:37:07 -0800 (PST)
Message-ID: <505be3af57c36222564d0790aa8a992b1ea4d287.camel@redhat.com>
Subject: Re: [PATCH 2/3] drm/nouveau: Add a dedicated mutex for the clients
 list
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Jeremy Cline <jcline@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Cc:     Karol Herbst <kherbst@redhat.com>, David Airlie <airlied@linux.ie>,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 25 Nov 2020 13:37:06 -0500
In-Reply-To: <20201103194912.184413-3-jcline@redhat.com>
References: <20201103194912.184413-1-jcline@redhat.com>
         <20201103194912.184413-3-jcline@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-11-03 at 14:49 -0500, Jeremy Cline wrote:
> Rather than protecting the nouveau_drm clients list with the lock within
> the "client" nouveau_cli, add a dedicated lock to serialize access to
> the list. This is both clearer and necessary to avoid lockdep being
> upset with us when we need to iterate through all the clients in the
> list and potentially lock their mutex, which is the same class as the
> lock protecting the entire list.
> 
> Signed-off-by: Jeremy Cline <jcline@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_drm.c | 9 +++++----
>  drivers/gpu/drm/nouveau/nouveau_drv.h | 5 +++++
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c
> b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index 4fe4d664c5f2..d182b877258a 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -557,6 +557,7 @@ nouveau_drm_device_init(struct drm_device *dev)
>                 nvkm_dbgopt(nouveau_debug, "DRM");
>  
>         INIT_LIST_HEAD(&drm->clients);
> +       mutex_init(&drm->clients_lock);

Looks like you forgot to hook up mutex_destroy() somewhere. Note there's
actually plenty of code in nouveau right now that forgets to do this, but at
some point we should probably fix that and avoid adding more spots where there's
no mutex_destroy().

>         spin_lock_init(&drm->tile.lock);
>  
>         /* workaround an odd issue on nvc1 by disabling the device's
> @@ -1089,9 +1090,9 @@ nouveau_drm_open(struct drm_device *dev, struct drm_file
> *fpriv)
>  
>         fpriv->driver_priv = cli;
>  
> -       mutex_lock(&drm->client.mutex);
> +       mutex_lock(&drm->clients_lock);
>         list_add(&cli->head, &drm->clients);
> -       mutex_unlock(&drm->client.mutex);
> +       mutex_unlock(&drm->clients_lock);
>  
>  done:
>         if (ret && cli) {
> @@ -1117,9 +1118,9 @@ nouveau_drm_postclose(struct drm_device *dev, struct
> drm_file *fpriv)
>                 nouveau_abi16_fini(cli->abi16);
>         mutex_unlock(&cli->mutex);
>  
> -       mutex_lock(&drm->client.mutex);
> +       mutex_lock(&drm->clients_lock);
>         list_del(&cli->head);
> -       mutex_unlock(&drm->client.mutex);
> +       mutex_unlock(&drm->clients_lock);
>  
>         nouveau_cli_fini(cli);
>         kfree(cli);
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h
> b/drivers/gpu/drm/nouveau/nouveau_drv.h
> index 9d04d1b36434..550e5f335146 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drv.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
> @@ -141,6 +141,11 @@ struct nouveau_drm {
>  
>         struct list_head clients;
>  
> +       /**
> +        * @clients_lock: Protects access to the @clients list of &struct
> nouveau_cli.
> +        */
> +       struct mutex clients_lock;
> +
>         u8 old_pm_cap;
>  
>         struct {

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

