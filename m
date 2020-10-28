Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABCF29D88D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388328AbgJ1WdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388566AbgJ1WdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:33:02 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DF0C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:33:02 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d24so937792ljg.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJ4wXj2K7lJdOYLrd0jjyxtKvvbExzYsZz6tEJ6wk7o=;
        b=mM89ZJBbiOM2uifaVqXNKqSvyE2s1UPxX02cbg2psjG2RIj0UXsi1Jjgz1Oryq1Qpm
         nNtWV/Lrq7xaMOk1nJUvpvDcRkMIdXEYqEEPQNx0EvW2fb18AxSruEfievimQTV2NSfy
         d0ZLC0dIboHF2NU3uV6aWrN39eLuYFOWlQFDS8HE82cJyQv58B1iQYh8FUIVQimKPUBs
         MLmpU9GAuvttzfyZH62cYrJkwYEM6/nTI48cqRrX/HBH394+76DrhzeIYjoGxOMY6O/1
         WuTtGpzaeuJe62Yr9yIyeS1BzuZq3pkYhGrezT1vDZgBDsXXtyz4klkHdsp/3vDFLiQ4
         ehDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJ4wXj2K7lJdOYLrd0jjyxtKvvbExzYsZz6tEJ6wk7o=;
        b=oU1/XyeD2uUFrumrTo4qf8H0HmrQkmOvSV5gTiCN7Vu8XhR4zIUPxJAfmjpMGLNCDe
         QH8za6x72NG1laXUZOkvIO9ifzmCTQKnoz/A9X4sUlj3GghX0OI23ROtPTC2Kf2emZyb
         IdaElcry7t4MECJmdZ/zGOukjc/JzzgE3TnG/55tBbONSeQr+4xp/6WIC8SN7x82NRSg
         cd5RGutSLA7rGiMaJqCIs5RSid9Ms1ZoHs+vpaB4ntv4UrfLzDqVW00bQYgFN3qXQv69
         h4RsLUOalFRRa2/c3YDlR9f4jW9Yq5naq2og7bwIXpgNvD7Dmnmcy3Ijmfe6z2H2K0IH
         DDeg==
X-Gm-Message-State: AOAM5307SlrbEGMyMGChjpJE+fmdjl05/BpvbtDohDvcLgCPNQ7LrxUX
        EXOSX2Rp9sOcdoWAhN+gw5yWabeuoiXZ9FiHaWG+N8GC+H9i/ZV7
X-Google-Smtp-Source: ABdhPJx8co+572PLantQaUV7Gqe51Vag+Xsh6dam5kO2twasvje9+9Se8vxhWJ1wtDg0J7s2tzvkIaPm0Y/N1NL42uQ=
X-Received: by 2002:a2e:8706:: with SMTP id m6mr3509012lji.129.1603896102594;
 Wed, 28 Oct 2020 07:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201026194110.3817470-1-arnd@kernel.org> <20201026194110.3817470-4-arnd@kernel.org>
 <20201027093350.GI401619@phenom.ffwll.local> <CAMeQTsZ9rBh2W_y8W4aaGJR3v5CA4g2BLmr-wAvcoKjOQtL68g@mail.gmail.com>
 <CAK8P3a35i9Z7sfFfVk_COotmyKVN6jcXadhaHu-BbbWCy_8ypQ@mail.gmail.com>
In-Reply-To: <CAK8P3a35i9Z7sfFfVk_COotmyKVN6jcXadhaHu-BbbWCy_8ypQ@mail.gmail.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Wed, 28 Oct 2020 15:41:31 +0100
Message-ID: <CAMeQTsbATjR2KZ9ML8OsmXgZpbSEsWU3FjYArG8enPtY=yoQww@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/gma500: avoid Woverride-init warning
To:     Arnd Bergmann <arnd@kernel.org>
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

On Tue, Oct 27, 2020 at 5:50 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Oct 27, 2020 at 10:54 AM Patrik Jakobsson
> <patrik.r.jakobsson@gmail.com> wrote:
> > On Tue, Oct 27, 2020 at 10:33 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > On Mon, Oct 26, 2020 at 08:41:04PM +0100, Arnd Bergmann wrote:
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > gcc -Wextra notices that one of the fields in psbfb_roll_ops has two
> > > > initializers:
> > > >
> > > > drivers/gpu/drm/gma500/framebuffer.c:185:20: warning: initialized field overwritten [-Woverride-init]
> > > >
> > > > Open-code this instead, leaving out the extraneous initializers for
> > > > .fb_pan_display.
> > > >
> > > > Fixes: 3da6c2f3b730 ("drm/gma500: use DRM_FB_HELPER_DEFAULT_OPS for fb_ops")
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Scrollback is dead, so I'm not sure it's even worth to keep all this. I'd
> > > just garbage-collect this, maybe als the entire accelerator code and just
> > > leave psbfb_unaccel_ops behind ...
> > > -Daniel
> >
> > That's been my idea for quite some time. The gtt roll code is also
> > broken in multi display setups.
> >
> > Arnd, I can take care of this unless you feel an urge to do it yourself.
>
> That would be good, thanks

Should be fixed with:
https://patchwork.freedesktop.org/patch/397482/?series=83153&rev=1

>
> I have no specific interest in the drm drivers, this is just part of a
> larger work to enable more of the W=1 options across the kernel
> by default, after all the existing warnings are addressed.
>
>        Arnd
