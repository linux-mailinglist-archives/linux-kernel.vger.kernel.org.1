Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5049329BE88
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1813542AbgJ0Quw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1813405AbgJ0QuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:50:03 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 424B022264
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 16:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603817402;
        bh=LK0eeKt23UpuFjbRlp+Jq07QMdu86YPGTmyXrkIQ3/A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d8JE+lqyb+lc6WGFb7I32gYf037C2ol6q3hMeot+T6ESBkeZ32okx70sWcNt5JnUU
         dH700IJde4PU6R0Ly2j/DH00tOiKOus5NDkTJlwzjBLDDnUTup2dcPGV5pBqA2p0zp
         IVzbL1MBAcdZ5O7ySaE2bU1JgLGds4FwwOyJy8Hs=
Received: by mail-qt1-f174.google.com with SMTP id f93so1467141qtb.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 09:50:02 -0700 (PDT)
X-Gm-Message-State: AOAM5306Eg20Fob1GhJGoF8SE4IvVZGN5TOVqDhsvuRojwORwAZt+nZk
        BCDUmjaIEkLRJeJS7VVhv/wEs/j/6xPUc3jFh5c=
X-Google-Smtp-Source: ABdhPJxSYiplkttX2Lr+S81J9ygH4nT2v7pKasxinSA2ZjbjgLslLpRipHcImpdX7w5F6n46UUC2rqVZSZnz+By90m0=
X-Received: by 2002:aed:26c2:: with SMTP id q60mr2515948qtd.7.1603817401292;
 Tue, 27 Oct 2020 09:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201026194110.3817470-1-arnd@kernel.org> <20201026194110.3817470-4-arnd@kernel.org>
 <20201027093350.GI401619@phenom.ffwll.local> <CAMeQTsZ9rBh2W_y8W4aaGJR3v5CA4g2BLmr-wAvcoKjOQtL68g@mail.gmail.com>
In-Reply-To: <CAMeQTsZ9rBh2W_y8W4aaGJR3v5CA4g2BLmr-wAvcoKjOQtL68g@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 27 Oct 2020 17:49:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a35i9Z7sfFfVk_COotmyKVN6jcXadhaHu-BbbWCy_8ypQ@mail.gmail.com>
Message-ID: <CAK8P3a35i9Z7sfFfVk_COotmyKVN6jcXadhaHu-BbbWCy_8ypQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/gma500: avoid Woverride-init warning
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        Stefan Christ <contact@stefanchrist.eu>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.velikov@collabora.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 10:54 AM Patrik Jakobsson
<patrik.r.jakobsson@gmail.com> wrote:
> On Tue, Oct 27, 2020 at 10:33 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Mon, Oct 26, 2020 at 08:41:04PM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > gcc -Wextra notices that one of the fields in psbfb_roll_ops has two
> > > initializers:
> > >
> > > drivers/gpu/drm/gma500/framebuffer.c:185:20: warning: initialized field overwritten [-Woverride-init]
> > >
> > > Open-code this instead, leaving out the extraneous initializers for
> > > .fb_pan_display.
> > >
> > > Fixes: 3da6c2f3b730 ("drm/gma500: use DRM_FB_HELPER_DEFAULT_OPS for fb_ops")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Scrollback is dead, so I'm not sure it's even worth to keep all this. I'd
> > just garbage-collect this, maybe als the entire accelerator code and just
> > leave psbfb_unaccel_ops behind ...
> > -Daniel
>
> That's been my idea for quite some time. The gtt roll code is also
> broken in multi display setups.
>
> Arnd, I can take care of this unless you feel an urge to do it yourself.

That would be good, thanks

I have no specific interest in the drm drivers, this is just part of a
larger work to enable more of the W=1 options across the kernel
by default, after all the existing warnings are addressed.

       Arnd
