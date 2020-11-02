Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D8E2A2B32
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgKBNGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 08:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgKBNGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:06:09 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0761C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 05:06:08 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id l36so4499266ota.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 05:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2/hjiFH0B9Q3ykrTLKDujEfwlflwsnnMdf4eXbqtBq0=;
        b=kqLlBbdBLdM9E9l4Z/tAufCYUu0NkXVfjfIVXJ9n7LJwtkh3I493LbGY6zgMAyeQHi
         PQ+vXlcxdxV25WHxZ0hbgxaGi201PXbcKakIglAKSd7TUu1W8bll0kfo8xgPccXlLOwU
         84GDyWx6jTzt+yW7m5QndjJl+ow23aU1ty9Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2/hjiFH0B9Q3ykrTLKDujEfwlflwsnnMdf4eXbqtBq0=;
        b=edL4x04kHPMgI61h7fB5H16ML8vWOSKWpBMBEb59GZ67SQlmfP9OMi2jB9FGREuC9n
         JhEg8PU/nhZRraDshxXhDWVAX3y9xl3CAW14ds94ESmUCmaIcYNe6zwTUKAvUPMZd1v+
         4XJUyRvFLhuHaQ4Pq9HP/oSlSaPpWPNw8Y6JbeYoqD6ljsZ/FrdI6CaPckO1f8XlTEno
         Imc65x6drBebVFttgIIvXU6GtzUcBr3/VXk8jZZAqQxWp9zGLHSOqJmutdN/P7zJsV+T
         QqFmJoMkImzH92zxIihKcfYfsVHLY639IdKupyuiY9yFQFcCHswQE4Pms4smfUXnJSDo
         J+cQ==
X-Gm-Message-State: AOAM531PqM4bXapkb4mEBiXKKjXv5yUfODXmuv0O9JW7N08uDyVAjSMz
        iEr5OTiZ9MEklXaT3F+wEGTYamiN7Ms0XAI7UhxqmA==
X-Google-Smtp-Source: ABdhPJw8HtpII5BMuhTclMxahYAuNFjFns0/EtzQP3saIy9P3gjs1R0sy/x48y4BR+lCGaC+jX1/f/DGBrzsBBL394I=
X-Received: by 2002:a9d:6e81:: with SMTP id a1mr11389339otr.303.1604322368373;
 Mon, 02 Nov 2020 05:06:08 -0800 (PST)
MIME-Version: 1.0
References: <1604320685-14995-1-git-send-email-tiantao6@hisilicon.com> <7a06d5ba-27c6-0762-662c-fee1f8ddbc2e@suse.de>
In-Reply-To: <7a06d5ba-27c6-0762-662c-fee1f8ddbc2e@suse.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 2 Nov 2020 14:05:56 +0100
Message-ID: <CAKMK7uF2+D0ZxwnxuQ9NOhSH5g96zyCiEw4Nc-4j54eTf+9wKg@mail.gmail.com>
Subject: Re: [PATCH] drm/irq: Modify the return value type of drm_irq_uninstall
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

On Mon, Nov 2, 2020 at 1:48 PM Thomas Zimmermann <tzimmermann@suse.de> wrot=
e:
>
> Hi
>
> Am 02.11.20 um 13:38 schrieb Tian Tao:
> > There is no driver to use the return value of drm_irq_uninstal,
> > so modify the return value type of drm_irq_uninstal to void.
> >
> > Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> > ---
> >  drivers/gpu/drm/drm_irq.c | 13 ++++++-------
> >  include/drm/drm_irq.h     |  2 +-
> >  2 files changed, 7 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_irq.c b/drivers/gpu/drm/drm_irq.c
> > index 7537a3d..45e6471 100644
> > --- a/drivers/gpu/drm/drm_irq.c
> > +++ b/drivers/gpu/drm/drm_irq.c
> > @@ -166,14 +166,14 @@ EXPORT_SYMBOL(drm_irq_install);
> >   * Returns:
> >   * Zero on success or a negative error code on failure.
> >   */
> > -int drm_irq_uninstall(struct drm_device *dev)
> > +void drm_irq_uninstall(struct drm_device *dev)
> >  {
> >       unsigned long irqflags;
> >       bool irq_enabled;
> >       int i;
> >
> >       if (!dev->irq_enabled || !dev)
> > -             return 0;
> > +             return;
> >
> >       irq_enabled =3D dev->irq_enabled;
> >       dev->irq_enabled =3D false;
> > @@ -200,8 +200,8 @@ int drm_irq_uninstall(struct drm_device *dev)
> >               spin_unlock_irqrestore(&dev->vbl_lock, irqflags);
> >       }
> >
> > -     if (!irq_enabled)
> > -             return -EINVAL;
> > +     if (!drm_WARN_ON(dev, !irq_enabled))
> > +             return;
> >
> >       DRM_DEBUG("irq=3D%d\n", dev->irq);
> >
> > @@ -213,7 +213,6 @@ int drm_irq_uninstall(struct drm_device *dev)
> >
> >       free_irq(dev->irq, dev);
> >
> > -     return 0;
> >  }
> >  EXPORT_SYMBOL(drm_irq_uninstall);
> >
> > @@ -250,10 +249,10 @@ int drm_legacy_irq_control(struct drm_device *dev=
, void *data,
> >               return ret;
> >       case DRM_UNINST_HANDLER:
> >               mutex_lock(&dev->struct_mutex);
> > -             ret =3D drm_irq_uninstall(dev);
> > +             drm_irq_uninstall(dev);
>
> Oh, there actually is a user of this result! I grep'ed for this but
> didn't see it. I'm sorry for misleading you here.
>
> This is ioctl code and who which program depends on it.So we cannot
> actually drop the result code.
>
> I'll just ack your original patch, or you could add the managed
> interface that I described and convert hibmc to it. Your choice, let me
> know.

It's old UMS gunk, no one cares :-)

If you're paranoid, make an internal __drm_irq_uninstall function
which keeps the return value. But what we probably want here is to
just split this up into 2 functions, drm_legacy_irq_uninstall, which
does the validation and additional check, and then calls
drm_irq_uninstall, which is for kms drivers, and which just has a
WARN_ON(!dev->irq_installed) or so to catch driver bugs.
-Daniel

>
> Best regards
> Thomas
>
> >               mutex_unlock(&dev->struct_mutex);
> >
> > -             return ret;
> > +             return 0;
> >       default:
> >               return -EINVAL;
> >       }
> > diff --git a/include/drm/drm_irq.h b/include/drm/drm_irq.h
> > index d77f6e6..d9f6ec0 100644
> > --- a/include/drm/drm_irq.h
> > +++ b/include/drm/drm_irq.h
> > @@ -27,6 +27,6 @@
> >  struct drm_device;
> >
> >  int drm_irq_install(struct drm_device *dev, int irq);
> > -int drm_irq_uninstall(struct drm_device *dev);
> > +void drm_irq_uninstall(struct drm_device *dev);
> >
> >  #endif
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
