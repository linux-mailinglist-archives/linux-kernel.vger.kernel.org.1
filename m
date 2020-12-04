Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EC92CF4A8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 20:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbgLDTVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 14:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgLDTV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 14:21:29 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493E5C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 11:20:49 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id z16so3870512vsp.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 11:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3RfmsOD4R8FThIOERGPH+DqSWdV2gOeuwbTDc0BCACk=;
        b=ED+Yl2tvlFfU7xMIOOS47zHVQLtV6INZZvh0HH4yw3SWBHzU4MNC4rXbzHM74kG9XR
         ZbMTZuU01dpnUQoaIPQ4jp4DxhYBqUy6YSa2lSiV5e7KaadOuv9DX5WExV5QLyD1+xVI
         t7pP0QhkyrRZgM0PgtgIA9asldGrwLJB3gyatruE0iDpoVWVyQWb4WpwEA6OpOjQ7r7W
         O8/doy3IHvTaswQkkK2DdJdjTY3MHBe7FBbhVTULX0yQuwmsP7d6Lbo/5hthSTlEYqKj
         eSz+5Qwdv8NWKzfHNTgp97QES+8Y9kdQd2+XsngGpRfAIK3Ac8j2BGZRCemAbfAll7HF
         NrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3RfmsOD4R8FThIOERGPH+DqSWdV2gOeuwbTDc0BCACk=;
        b=TA8gwX22q+y713uTBslLrx/VslN70WLT2vvfd75xwaknsipr/fgAQTp+weNtAC1NOg
         2l9rJc+LOyFlwwXMMa903yDRwPi9AQeI7PsSPUfC+suPF8Jr0iclbPylq/zRRpVMp81g
         tM8gMumAawQgmzqVnDRmaZmYoJbjPEhg0bU6Tuck6HfrWa0JfQwq+wKkLONg5pKqtOqU
         gZPeH9WV13pi61S/8XaA41XM52XD9cRs8kbnDxuyQpv1ChmFIxQJkih/2RfTBj3kJoqC
         c8JE8TxBfX3xFp+dgHnNq5COJwpRjmPClTRO+lzcu00jCk8vYbHXonHBuotMXRgvEck4
         Ejlw==
X-Gm-Message-State: AOAM532xqp80bYAqcky5AcDPxItdz2mQg3J93idFajnt+NigkBIE6WPQ
        8Nxc2riD5TqGXNfSi4dOjrMbUBUa23m3hbOtbvY=
X-Google-Smtp-Source: ABdhPJwqY8Cz8zt67T3BVJvNnRhGnl8wOKMvKKSfumPMETzn1knT8+JsYs3DxXmbQCcxhs6RK/0aE+HMmFZIhWrNP7o=
X-Received: by 2002:a67:d204:: with SMTP id y4mr5725128vsi.60.1607109648459;
 Fri, 04 Dec 2020 11:20:48 -0800 (PST)
MIME-Version: 1.0
References: <20201204035318.332419-1-jim.cromie@gmail.com> <20201204035318.332419-2-jim.cromie@gmail.com>
 <X8pY/H512EMR3bUX@intel.com>
In-Reply-To: <X8pY/H512EMR3bUX@intel.com>
From:   jim.cromie@gmail.com
Date:   Fri, 4 Dec 2020 12:20:21 -0700
Message-ID: <CAJfuBxysOxnm846u71f0rQCH9NX-7AMe4brmiD0vqfGeQKuVOw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] drm: RFC add choice to use dynamic debug in drm-debug
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Jason Baron <jbaron@akamai.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 8:42 AM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Thu, Dec 03, 2020 at 08:53:17PM -0700, Jim Cromie wrote:
> > drm's debug system uses distinct categories of debug messages, mapped
> > to bits in drm.debug.  Currently, code does a lot of unlikely bit-mask
> > checks on drm.debug (in drm_debug_enabled), we can use dynamic debug
> > instead, and get all that jump_label goodness.
>
> whatis jump_label?

Sorry, I should have at least capitalized that, and spelled it differently

kernel/Makefile
118:obj-$(CONFIG_JUMP_LABEL) +=3D jump_label.o

it is the hot-patching substrate underneath it all.
static-key, static-call, etc?
dynamic-debug uses static-key directly.



>
> One thing that bugs me about the current drm_dbg() stuff is that
> it's a function, and thus we pay the cost of setting up the
> arguments even when debugs are not enabled. I played around a bit
> with making it a macro again with the unlikely bit check moved
> into the macro. That did seem to make some of the asm a bit nicer
> where the debug stuff got shoved out the main codepath, but
> it did result in a slight net increase in code size. What I didn't
> have time to do is check if this has any measurable speed effect
> on eg. TEST_ONLY commits.
>
> And while doing that I started to ponder if we could use something
> like the alternate() instruction stuff to patch the code at runtime
> in order to turn all those debug checks into nops when debugging
> is not enabled. But I couldn't immediately find any generic
> infrastructure for it. So now I wonder if this jump_label is something
> like that?
>

this is the droid youre looking for ;-)

> >

> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
