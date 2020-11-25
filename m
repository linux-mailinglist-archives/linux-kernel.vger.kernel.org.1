Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487072C47DA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 19:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbgKYSok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 13:44:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31634 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730418AbgKYSoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 13:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606329877;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x1ubu375lGfWf+fNMoowlNZQheWo8nCoKoLO42VQKgo=;
        b=byTO2RxCfES9vw/ZaCUP4Me28cd73xm5pOECJbnJZ6aJnKcaacKyZoDs10scboH70CPyIT
        gTTEMEI7dt6YUZYNWA0rRqRPwDQBHvHbB/2jYdbVzlv8Fz8nPeqL/LdNOJTaq/bXGMXU76
        JEbQKd+B185ZslGaIQvHZ7Xbkh6L0v0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-Z4pjQ2gjPyGtrqsvKFfKmw-1; Wed, 25 Nov 2020 13:44:35 -0500
X-MC-Unique: Z4pjQ2gjPyGtrqsvKFfKmw-1
Received: by mail-qv1-f72.google.com with SMTP id e13so3075537qvl.19
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 10:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=x1ubu375lGfWf+fNMoowlNZQheWo8nCoKoLO42VQKgo=;
        b=hAHnK4hmDmbMQpmKVqb0DypiXfI9jKgHp9zm6GyXRjaieGce72gFXsOhl6yYGvv+6d
         /b1hPv5Lqage4p92wXnZ3HByAtCEseYsLYFb/u2XIvuGeAtvFHLm+iXYi+ZdFuPwOZ6Z
         UMB512XH5DqSiSAk/+dkm9T3LeQpIZaU374ClSsTh6vvJmUA7XKM4eRCz3HT39Vo5ahm
         8wo4yrgN/XE/HXiqDzdm8uFpjpR204Q2DzGzmDeY+2RG9DUurk912aheckwwFvzxjpRE
         0+CwDBabPynGYDmliRIbQ4sOuxjOg/l6woxAEY/H97bEklWeyHudBFJJhixtjN41MMLK
         tPyw==
X-Gm-Message-State: AOAM5318jX1umQIpGmUqgqDDseCIhQUeS+WdbMZzWH8xiQ8iK5BxlN6U
        nHClB0OWDUmxlFBwva3FbzDnADWUuzuQsLZJ1tGQjDctpIdd8/81Pu2qsB21YTbpUS4UJXWC9yh
        16VMXByQH6mx5oA265V+7PVzs
X-Received: by 2002:ac8:5ccc:: with SMTP id s12mr195446qta.309.1606329874745;
        Wed, 25 Nov 2020 10:44:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzLx16k8efwRH46Ve2ZUincydna+PXAmWaLbjuq+TU99Q4eAY/6w1KEdyS1xpQrPPQbk9WbQ==
X-Received: by 2002:ac8:5ccc:: with SMTP id s12mr195423qta.309.1606329874483;
        Wed, 25 Nov 2020 10:44:34 -0800 (PST)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id b4sm137447qtt.52.2020.11.25.10.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 10:44:33 -0800 (PST)
Message-ID: <3b1bf645662bc81d9c93ad0c74826d8f87d740cc.camel@redhat.com>
Subject: Re: [PATCH 3/3] drm/nouveau: clean up all clients on device removal
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Jeremy Cline <jcline@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Cc:     Karol Herbst <kherbst@redhat.com>, David Airlie <airlied@linux.ie>,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 25 Nov 2020 13:44:33 -0500
In-Reply-To: <20201103194912.184413-4-jcline@redhat.com>
References: <20201103194912.184413-1-jcline@redhat.com>
         <20201103194912.184413-4-jcline@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-11-03 at 14:49 -0500, Jeremy Cline wrote:
> The postclose handler can run after the device has been removed (or the
> driver has been unbound) since userspace clients are free to hold the
> file open the file as long as they want. Because the device removal
            ^
         typo

> callback frees the entire nouveau_drm structure, any reference to it in
> the postclose handler will result in a use-after-free.
> 
> To reproduce this, one must simply open the device file, unbind the
> driver (or physically remove the device), and then close the device
> file. This was found and can be reproduced easily with the IGT
> core_hotunplug tests.
> 
> To avoid this, all clients are cleaned up in the device finialization
> rather than deferring it to the postclose handler, and the postclose
> handler is protected by a critical section which ensures the
> drm_dev_unplug() and the postclose handler won't race.
> 
> This is not an ideal fix, since as I understand the proposed plan for
> the kernel<->userspace interface for hotplug support, destroying the
> client before the file is closed will cause problems. However, I believe
> to properly fix this issue, the lifetime of the nouveau_drm structure
> needs to be extended to match the drm_device, and this proved to be a
> rather invasive change. Thus, I've broken this out so the fix can be
> easily backported.

JFYI - if the intent is for this to be backported, you should add:

Cc: stable@vger.kernel.org 
> Signed-off-by: Jeremy Cline <jcline@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_drm.c | 30 +++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c
> b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index d182b877258a..74fab777f4d0 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -628,6 +628,7 @@ nouveau_drm_device_init(struct drm_device *dev)
>  static void
>  nouveau_drm_device_fini(struct drm_device *dev)
>  {
> +       struct nouveau_cli *cli, *temp_cli;
>         struct nouveau_drm *drm = nouveau_drm(dev);
>  
>         if (nouveau_pmops_runtime()) {
> @@ -652,6 +653,24 @@ nouveau_drm_device_fini(struct drm_device *dev)
>         nouveau_ttm_fini(drm);
>         nouveau_vga_fini(drm);
>  
> +       /*
> +        * There may be existing clients from as-yet unclosed files. For now,
> +        * clean them up here rather than deferring until the file is closed,
> +        * but this likely not correct if we want to support hot-unplugging
> +        * properly.
> +        */
> +       mutex_lock(&drm->clients_lock);
> +       list_for_each_entry_safe(cli, temp_cli, &drm->clients, head) {
> +               list_del(&cli->head);
> +               mutex_lock(&cli->mutex);
> +               if (cli->abi16)
> +                       nouveau_abi16_fini(cli->abi16);
> +               mutex_unlock(&cli->mutex);
> +               nouveau_cli_fini(cli);
> +               kfree(cli);
> +       }
> +       mutex_unlock(&drm->clients_lock);
> +
>         nouveau_cli_fini(&drm->client);
>         nouveau_cli_fini(&drm->master);
>         nvif_parent_dtor(&drm->parent);
> @@ -1110,6 +1129,16 @@ nouveau_drm_postclose(struct drm_device *dev, struct
> drm_file *fpriv)
>  {
>         struct nouveau_cli *cli = nouveau_cli(fpriv);
>         struct nouveau_drm *drm = nouveau_drm(dev);
> +       int dev_index;
> +
> +       /*
> +        * The device is gone, and as it currently stands all clients are
> +        * cleaned up in the removal codepath. In the future this may change
> +        * so that we can support hot-unplugging, but for now we immediately
> +        * return to avoid a double-free situation.
> +        */
> +       if (!drm_dev_enter(dev, &dev_index))
> +               return;
>  
>         pm_runtime_get_sync(dev->dev);
>  
> @@ -1126,6 +1155,7 @@ nouveau_drm_postclose(struct drm_device *dev, struct
> drm_file *fpriv)
>         kfree(cli);
>         pm_runtime_mark_last_busy(dev->dev);
>         pm_runtime_put_autosuspend(dev->dev);
> +       drm_dev_exit(dev_index);
>  }
>  
>  static const struct drm_ioctl_desc

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

