Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF442F9AC9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 08:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733100AbhARHrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 02:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbhARHrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 02:47:05 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5C0C061575
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 23:46:25 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id q205so16791620oig.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 23:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l+LSWdfCYn1btsVCSU91NdRUd3kcTfJ/C+5NiKfK6SI=;
        b=W0cnYh/jL15j51JJaDQSLKs4Fw3EBt1PqoGtgqfgQc4uMMbvLVH5MOGTqhXJvtMqe0
         y7UcWh3NJCHn3lEaLBn78RWuaiCU2kEegm49FfX2h0wMjfl9S6/gW5MnkKpjZgF+z9Pa
         uMYWfZClKmvC6eBfO8HLDJOnGgjw4YwZFgvPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l+LSWdfCYn1btsVCSU91NdRUd3kcTfJ/C+5NiKfK6SI=;
        b=DZjOj/ldWxewqmOtm8TLhdSfht8TrQDtPiVFgZy/kTx9rWPrVj3SK58QUkV23QJOqG
         Bv8TxHgZrjuMfOY6P6MNnoQdkIhLXAROePRIfuKQOtiJ31jayN/ouaEVoIrlf+Q37Pmm
         KzRXErQGZWXt6W6gpgte8VHu96JzHrb+BZP6+9nEhCjwLJhHDApmkdTlcPXCwQEej20u
         ZZuceKu3/Wv1Mkm3SSROFn/mgmSV7XzLQCY/yNRiV/eVZU3nAvxO72KDhx5xT1yVfbbE
         gCukFNoHt9JLGaQ0lZFpYbSCTI7hhHdQ/NLzJHksfZt84U5zAKMwkWgI9PB92Tatvn+e
         aZfQ==
X-Gm-Message-State: AOAM53153WvShajF6eCFtna6YHsVH13BRwSPYXnomuGzo28w1WyMl9ci
        v+7iXJucjB5FUe4GdXR69nVjTmQ63HwGPamQkE9whA==
X-Google-Smtp-Source: ABdhPJwNF8zbOxc9vhWr1zvlpelmYS7pUhb2t2qRoI5vRhVEntkQXVrg8oZGjA2VthlKaMTEowMZinUyAzwxHEoLrt4=
X-Received: by 2002:aca:ad92:: with SMTP id w140mr1117924oie.128.1610955985196;
 Sun, 17 Jan 2021 23:46:25 -0800 (PST)
MIME-Version: 1.0
References: <20210118012246.1858892-1-zhangzhijie@loongson.cn> <fd296f78-86df-e933-78ff-4b66e978e730@suse.de>
In-Reply-To: <fd296f78-86df-e933-78ff-4b66e978e730@suse.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 18 Jan 2021 08:46:14 +0100
Message-ID: <CAKMK7uHsRS3e2CSnHMw=LKyxVBuL88i7a677F_zPwOLyJ76Org@mail.gmail.com>
Subject: Re: [PATCH v3] drm: Improve the output_poll_changed description
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     "ZhiJie.Zhang" <zhangzhijie@loongson.cn>,
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

On Mon, Jan 18, 2021 at 7:53 AM Thomas Zimmermann <tzimmermann@suse.de> wro=
te:
>
> Hi
>
> Am 18.01.21 um 02:22 schrieb ZhiJie.Zhang:
> > From: zhangzhijie <zhangzhijie@loongson.cn>
> >
> > this callback was used by drm_kms_helper_hotplug_event()
> >
> > V2: (Thanks for Daniel's suggestions)
> > - remove the FIXME below.since with the drm_client
> > - infrastructure and the generic fbdev emulation we've
> > - resolved this all very neatly now.
> >
> > V3: Add comments that This hook is deprecated
> > - new implementation methods instead of this hook
> >
> > Signed-off-by: zhangzhijie <zhangzhijie@loongson.cn>
> > Signed-off-by: ZhiJie.Zhang <zhangzhijie@loongson.cn>
> > ---
> >   include/drm/drm_mode_config.h | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_confi=
g.h
> > index ab424ddd7665..a084482d579a 100644
> > --- a/include/drm/drm_mode_config.h
> > +++ b/include/drm/drm_mode_config.h
> > @@ -103,14 +103,14 @@ struct drm_mode_config_funcs {
> >        * Callback used by helpers to inform the driver of output config=
uration
> >        * changes.
> >        *
> > -      * Drivers implementing fbdev emulation with the helpers can call
> > -      * drm_fb_helper_hotplug_changed from this hook to inform the fbd=
ev
> > +      * Drivers implementing fbdev emulation with the helpers. Drivers=
 use
> > +      * drm_kms_helper_hotplug_event() to call this hook to inform the=
 fbdev
>
> I don't understand this. Maybe it's "Drivers implementing fbdev
> emulation use drm_kms_helper_hotplug_event() to call ..." ?

Yeah this just doesn't make sense now, this is not the interesting
information. Removing the hint that this should be implemented using
drm_fb_helper_hotplug_changed is really not good.
-Daniel

>
> Best regards
> Thomas
>
> >        * helper of output changes.
> >        *
> > -      * FIXME:
> > -      *
> > -      * Except that there's no vtable for device-level helper callback=
s
> > -      * there's no reason this is a core function.
> > +      * This hook is deprecated, drivers should instead use
> > +      * drm_fbdev_generic_setup() which takes care of any necessary
> > +      * hotplug event forwarding already without further involvement b=
y
> > +      * the driver.
> >        */
> >       void (*output_poll_changed)(struct drm_device *dev);
> >
> >
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
