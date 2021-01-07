Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FDB2ECAA8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 07:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbhAGGuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 01:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbhAGGuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 01:50:02 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF15C0612F5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 22:49:21 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cm17so6732167edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 22:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iluA/f+Nx9iV4l3x2XO+uEUXDpQareT2nFvYNJnsH5U=;
        b=r6tcrQG2/r/1bXPuM3no1kaZ76iN3GEwjWW/bK2ooP6Dysos6JF1c2RfN5OfXFqhLS
         K4daUnqvzUeN8ScOhnhRmY882C2r0ella8LhzTH6HqqZZZQdiUAM+Lc9rY8asQwizZxj
         4WTtRpysuaOKxbJXPlL4wlm7YxMxZlmdEpuvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iluA/f+Nx9iV4l3x2XO+uEUXDpQareT2nFvYNJnsH5U=;
        b=HNH+5SArf1blXrveVK2koHSlYd39kBITXvGHk1JTntSkYJPNBCwyDMpfF725Jh656o
         ddK9GOfJHlqMAWBrRFL3ex0Sz4+CXoF04oDOnFiJqOaBCkDz5aoLBoERMz1CIiG8zxiK
         AtmMSZ4wJumcpwGEVB+RhYSUQzeImYCqNnF2scH5BCZ2VMFAKV9kLiwx6wuFC5/uzfZ6
         ZHQoHCmhe66maseiFCCsHS5PDGrp7BgfhvRfSYfG0lC613igdgpiN6ZXYqmbMALrxhkD
         klV3F1BIkn7QBVS0CsCzDuRVghU4o2QizLUQ+xkCTY2xm7GKY4L0B9gECAtmtZVrGtYi
         1AWg==
X-Gm-Message-State: AOAM53344ByT9JEp9qXbyz25e+D9PT27vs9i8lbItPiZXhjFF5SAR1kg
        FhX4XskWjJicnnAWqqR3x21kll3c8Sg3QI1r3E25nR8d1fMf6Q==
X-Google-Smtp-Source: ABdhPJztcw6+ch3jIP1KsxwisrTgHXjVHJJf4yU30FjteHikhnzele/d/izfDLVgev1PeSNgdb48lclIc9s8z+pl29g=
X-Received: by 2002:a50:d80c:: with SMTP id o12mr558299edj.338.1610002159811;
 Wed, 06 Jan 2021 22:49:19 -0800 (PST)
MIME-Version: 1.0
References: <20201128125257.1626588-1-icenowy@aosc.io> <CAMty3ZCkEb9g5t6Hs5DN5yHXYvDhymriYqqV+6DZiC+Qb645ww@mail.gmail.com>
 <C1F366E9-0EDB-4679-BB93-92223F5B8C4A@aosc.io>
In-Reply-To: <C1F366E9-0EDB-4679-BB93-92223F5B8C4A@aosc.io>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 7 Jan 2021 12:19:08 +0530
Message-ID: <CAMty3ZBdQ=SipAPyQ0AKioYtW14BBgy0gZaq-F3x-Bhz4Wat6w@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: feiyang-fy07024di26a30d: cleanup if panel
 attaching failed
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 10:16 AM Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
>
> =E4=BA=8E 2021=E5=B9=B41=E6=9C=886=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=885=
:47:20, Jagan Teki <jagan@amarulasolutions.com> =E5=86=99=E5=88=B0:
> >On Sat, Nov 28, 2020 at 6:23 PM Icenowy Zheng <icenowy@aosc.io> wrote:
> >>
> >> Attaching the panel can fail, so cleanup work is necessary, otherwise
> >> a pointer to freed struct drm_panel* will remain in drm_panel code.
> >>
> >> Do the cleanup if panel attaching failed.
> >>
> >> Fixes: 69dc678abc2b ("drm/panel: Add Feiyang FY07024DI26A30-D
> >MIPI-DSI LCD panel")
> >
> >The fact that this has failed to probe due to recent changes in
> >sun6i_mipi_dsi.c I don't know how to put that into the commit message.
>
> It's not related, we shouldn't assume this panel driver will always
> be used with sunxi SoCs.

Well, I'm aware of it. What I'm trying to say is this panel has
referenced with one of exiting panel in a tree and that indeed return
mipi_dsi_attach and it verified with DSI host at that time.

>
> It's a panel driver bug that cannot deal with -EPROBE_DEFER well.

Yes, ie reason I have added Reviewed-by tag above.

Jagan.
