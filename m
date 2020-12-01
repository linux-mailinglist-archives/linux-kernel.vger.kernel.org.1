Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504F72CA8AC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389280AbgLAQsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388131AbgLAQsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:48:38 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC24C061A47
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 08:47:24 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id j21so2140353otp.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 08:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X9vfkPsuHdDlbRy5N2BDdCLRGG9QdnGsjUUpVaTO710=;
        b=VQRxBEWJdSffbR1qYHdXDQFAhH0L3/Itxchu5Px/jUiqzaFxez0CtWOIOvHB2t1PoK
         x0iA19xxkiH04keW+TpqcYYqjGWo/vX3vr/oqd+uptPB4IO1oc/ldKXNDBoR10v1Df9a
         cOGagtePbDIT/C+kjBlX1MzS1HXnah/R2zthw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X9vfkPsuHdDlbRy5N2BDdCLRGG9QdnGsjUUpVaTO710=;
        b=LPrWZLRi84PkiPhshVmfuVWHQFTyOz5oyn42afopnRHVjDCql96Fev+LjtGlfa13T3
         wnJ0KYZzyqoGhkl4jYU/M+aeh7JPiL3N80wDb24qhXXMhIJ2KpbnxfxZuxnYdxdL42JS
         BurUB84lXL9oxyQVG7WKiXXlm3b8rCbdhfE1Qo+fexq+UuOGKTU6BHW6E7RAQAmygJcy
         mg4HP/5UGMhgBqzwk13m4yUuZZ7A6A6UnQSKTV3zY0lPutZSpK7uqFcNXVcdUdR1jeT2
         dL9CyTY5fP1rrg6tKjyERn0nTVSRSQ3DoYsQQgRn4NvtDO5C5BgtOfpZDTvRXiG88g00
         tlxQ==
X-Gm-Message-State: AOAM530xfLynARu/EQTg2vcWOu3fGopywha+rh4sI54PqB8HFtz8bIlU
        SoK51gmOInjG+3m5xKvFZM6r1LM9CGDRzxSa6OxggAhLLXk=
X-Google-Smtp-Source: ABdhPJy7N24WXPqNe9dLY6S3RVDRbNEgT/BYxDzmq3nNhXjLJe6MUlxCqkIvtPu1sVvwQ2OAbRBEBv/Ep/oLkmebcVI=
X-Received: by 2002:a9d:4e08:: with SMTP id p8mr2542426otf.188.1606841243839;
 Tue, 01 Dec 2020 08:47:23 -0800 (PST)
MIME-Version: 1.0
References: <20201201084647.751612010@linuxfoundation.org> <20201201084648.982712007@linuxfoundation.org>
 <20201201154332.GB23661@amd>
In-Reply-To: <20201201154332.GB23661@amd>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 1 Dec 2020 17:47:12 +0100
Message-ID: <CAKMK7uHw8gJEGQcCwR-MSEpndRKDZwO2BsveDThBSACxZfxLrw@mail.gmail.com>
Subject: Re: [PATCH 4.19 11/57] drm/atomic_helper: Stop modesets on
 unregistered connectors harder
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, Lyude Paul <lyude@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 4:43 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > From: Lyude Paul <lyude@redhat.com>
> >
> > commit de9f8eea5a44b0b756d3d6345af7f8e630a3c8c0 upstream.
>
> So this says protected by mutex:
>
> >       /**
> > -      * @registered: Is this connector exposed (registered) with userspace?
> > +      * @registration_state: Is this connector initializing, exposed
> > +      * (registered) with userspace, or unregistered?
> > +      *
> >        * Protected by @mutex.
> >        */
> > -     bool registered;
> > +     enum drm_connector_registration_state registration_state;
> >
> >       /**
> >        * @modes:
> > @@ -1165,6 +1214,24 @@ static inline void drm_connector_unrefer
> >       drm_connector_put(connector);
> >  }
> >
> > +/**
> > + * drm_connector_is_unregistered - has the connector been unregistered from
> > + * userspace?
> > + * @connector: DRM connector
> > + *
> > + * Checks whether or not @connector has been unregistered from userspace.
> > + *
> > + * Returns:
> > + * True if the connector was unregistered, false if the connector is
> > + * registered or has not yet been registered with userspace.
> > + */
> > +static inline bool
> > +drm_connector_is_unregistered(struct drm_connector *connector)
> > +{
> > +     return READ_ONCE(connector->registration_state) ==
> > +             DRM_CONNECTOR_UNREGISTERED;
> > +}
>
>
> But this uses READ_ONCE() for protection, and corresponding
> WRITE_ONCE() is nowhere to be seen. Should this take the mutex, too?

The read once here doesn't protect against any races, but just against
creative compilers doing funny stuff that might really break code
logic. I guess for symmetry we could throw the WRITE_ONCE on the write
side, but it really shouldn't matter, the entire thing is racy by
design. We0d also only ever need the write once on the unregister
call.
-Daniel

>
> Best regards,
>                                                                 Pavel
> --
> http://www.livejournal.com/~pavelmachek



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
