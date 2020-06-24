Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26C920762D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 16:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404055AbgFXO4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 10:56:00 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40280 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403931AbgFXO4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:56:00 -0400
Received: by mail-oi1-f194.google.com with SMTP id t25so2060208oij.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+sk9R2kZOJxwPKjhGy5eQURJ6u1u2IjgStnunJ+u8Vg=;
        b=V/T2excaFLJWF8U1Jqu0oXKyUtZpWOG89KgjTHDGpfyJte97C4ZFOm7BM7jsPJ3FUM
         VXuDgugWLhwsJ6ceUHVlQ+d40LGs/Jyu8abycCua01IhPm0JA5XTrYMv8ceD9VXBG1U2
         jEakGiyyvWXviCgvdY0RnbJtkfJoyQAEgr8vYKdsHCDBsa0se0RzDnXUmG/rHtAcjlTF
         VcEbQxORqsY+RerwIcd6NFMPIPUqCFVCkZCm0VBCYLmXuviIEC1FGFSM2uhTLBjscIiq
         AuuZPP0UT1HK5s4AZ3/kgRSU/ne+3E5rOA2jz5p6kX8gAfb8CcfXVegg6vu3tJnp9viG
         2zBw==
X-Gm-Message-State: AOAM532WWgbiWhrPT0+/rwY/pdOijohuaR0V/2wsbRZ6HMybTA09l/3t
        owFctFoC2eSHKmqqqBdtz8XNymCsVpzEw7zOdo3gtw==
X-Google-Smtp-Source: ABdhPJzTeOBdPMvDRCz7RJI7KYiAeYGV5KLYB14SeNajPpHs7iz64SW8yis8WWbLDg2GfSHkl+OTc/iGJIpmOpN8/0g=
X-Received: by 2002:a05:6808:99b:: with SMTP id a27mr2709013oic.68.1593010558890;
 Wed, 24 Jun 2020 07:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200624114136eucas1p1c84f81b1d78e2dbad7ac1b762f0a4b4f@eucas1p1.samsung.com>
 <20200624114127.3016-1-a.hajda@samsung.com> <20200624114127.3016-4-a.hajda@samsung.com>
 <CAJZ5v0i7mU3dGGZv3sUwG2_2OCRP3=bPB7a8sstj0qLwmiwhog@mail.gmail.com> <345c10ba-b047-3ef4-0129-0ef494c8f812@samsung.com>
In-Reply-To: <345c10ba-b047-3ef4-0129-0ef494c8f812@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Jun 2020 16:55:47 +0200
Message-ID: <CAJZ5v0gGaAgjJ_xc6etE-e_ctOiWOmbE6=P4Sb80vS0VZi39pQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 3/5] drivers core: allow probe_err accept
 integer and pointer types
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 4:44 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
>
> On 24.06.2020 14:14, Rafael J. Wysocki wrote:
> > On Wed, Jun 24, 2020 at 1:41 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> >> Many resource acquisition functions return error value encapsulated in
> >> pointer instead of integer value. To simplify coding we can use macro
> >> which will accept both types of error.
> >> With this patch user can use:
> >>          probe_err(dev, ptr, ...)
> >> instead of:
> >>          probe_err(dev, PTR_ERR(ptr), ...)
> >> Without loosing old functionality:
> >>          probe_err(dev, err, ...)
> >>
> >> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> > The separation of this change from patch [1/5] looks kind of artificial to me.
> >
> > You are introducing a new function anyway, so why not to make it what
> > you want right away?
>
>
> Two reasons:
>
> 1.This patch is my recent idea, I didn't want to mix it with already
> reviewed code.
>
> 2. This patch could be treated hacky by some devs due to macro
> definition and type-casting.

Fair enough.

There is some opposition against the $subject one, so I guess it may
be dropped even.

Thanks!
