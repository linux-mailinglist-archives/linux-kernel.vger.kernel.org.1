Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDFE2D8A07
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 21:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407898AbgLLUuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 15:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgLLUuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 15:50:17 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D2BC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 12:49:36 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id 11so11759557oty.9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 12:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qvg8DysIc20JGS6nMXk0s1ErrTh7lALYmrvJfAIvCB0=;
        b=RM8kNOBLyCgaih1FoRgTAqG+dvcpw8Fsg21Hfjslr4kCCfclCFXmHmSra3zTexXxTE
         BttyXdQpVkmUYSHSvCR2HECH0+qAfUNir75jZge9A6w6vaHCa6i07EuiBmREhindk907
         YXhtGZIZ5CRnafTbwJH+mYRM5IpQ9tHKrzj/4+h8fAx0FH2bLoYAzkdCDXjuYeUA8CJM
         WwNXc7q2Avs/jD6+5cMpbxy1wgs4xEJ+a3xWycij7MXGN7ToO6fodstPa47Pz9df0CoK
         rOrltugoWd9aLdVuW0LbuULGry78CQXHiT1cYss0DkuAEm29vpJXYc6Q634C2MNVh48L
         Orzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qvg8DysIc20JGS6nMXk0s1ErrTh7lALYmrvJfAIvCB0=;
        b=ntfECsjvnydhan/jcuOUh0ABJlImOyS54BuUwv5+uaMqYzdUMI61TCt4/SkwSZFbif
         tVJqcoMXGlKq95mP1Ljbc031eoVdNrcMxxTT7vFRvliE6YfUpyj9UdYEDSSH/YTUiyYf
         a4rX528fq9Hk1LO4Z5W21FI6nA5VhOTSZXr154hM51YRz+xxxQUg9MdfoC6CIDotvusu
         Plp96/dpMjQnRfs7TGetkKVzMWeknI0Aciij3FOS922EVWhmoNJl4TFPa5CN0mYpz4ZM
         sjPinIqIhjYLUMu/IV8e3PXz9sSN/3pOgB5tBqPQSvg1l9G5B1nDKAC9drUSgU0dTBRb
         rDiw==
X-Gm-Message-State: AOAM533SK64/EFy+I4GlkimquZGF5+4q02CtnkjL9WbBQ1Dbc38r4NUJ
        fzpjJrRFeDtdFnEjehTR/XlU2pnP/I5X2MYytfuz2Q==
X-Google-Smtp-Source: ABdhPJx58qgPYwe3m7F9FJq/KpaT3JxzHXF7yrO6Jhgu6lhKosWu6sPGnxrGOEDM+xI2EHeRW9xplhYwpSdtreLOeGU=
X-Received: by 2002:a9d:3d06:: with SMTP id a6mr13941007otc.368.1607806176150;
 Sat, 12 Dec 2020 12:49:36 -0800 (PST)
MIME-Version: 1.0
References: <20201212011426.163071-1-dmitry.baryshkov@linaro.org>
 <X9SsbBfL81PmcJXH@kroah.com> <20201212153929.yn47oz4fm37ysrry@pengutronix.de>
In-Reply-To: <20201212153929.yn47oz4fm37ysrry@pengutronix.de>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 12 Dec 2020 23:49:26 +0300
Message-ID: <CAA8EJpqwJKwYS=9o5Vtqwmi5qGd33woK_q4NO5h6mh-f3G+NtA@mail.gmail.com>
Subject: Re: [PATCH] driver core: platform: don't oops on unbound devices
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, 12 Dec 2020 at 18:39, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Sat, Dec 12, 2020 at 12:41:32PM +0100, Greg Kroah-Hartman wrote:
> > On Sat, Dec 12, 2020 at 04:14:26AM +0300, Dmitry Baryshkov wrote:
> > > Platform code stopped checking if the device is bound to the actual
> > > platform driver, thus calling non-existing drv->shutdown(). Verify th=
at
> > > _dev->driver is not NULL before calling remove/shutdown callbacks.
> > >
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > Fixes: 9c30921fe799 ("driver core: platform: use bus_type functions")
> > > ---
> > >  drivers/base/platform.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > > index 0358dc3ea3ad..93f44e69b472 100644
> > > --- a/drivers/base/platform.c
> > > +++ b/drivers/base/platform.c
> > > @@ -1342,7 +1342,7 @@ static int platform_remove(struct device *_dev)
> > >     struct platform_device *dev =3D to_platform_device(_dev);
> > >     int ret =3D 0;
> > >
> > > -   if (drv->remove)
> > > +   if (_dev->driver && drv->remove)
> > >             ret =3D drv->remove(dev);
> > >     dev_pm_domain_detach(_dev, true);
> >
> > I don't object to this, but it always feels odd to be doing pointer mat=
h
> > on a NULL value, wait until the static-checkers get ahold of this and
> > you get crazy emails saying you are crashing the kernel (hint, they are
> > broken).
>
> I think you refer to the line
>
>         struct platform_driver *drv =3D to_platform_driver(_dev->driver);
>
> which when _dev->driver is NULL results in drv being something really
> big?!

Yes. To remove pointer math on NULL value I can move the check for
_dev->driver before calculating drv.

>
> Accoding to my understanding platform_remove() shouldn't be called if
> the device isn't bound to a driver.
>
> > But, I don't see why this check is needed?  If a driver is not bound to
> > a device, shouldn't this whole function just not be called?  Or error
> > out at the top?
> >
> > Uwe, I'd really like your review/ack of this before taking it.
>
> So I agree and have the same question. So I wonder: @Dmitry, did you see
> a crash? When did it happen?

The crash happens in the platform_shutdown() function, which gets
called for unbound devices after commit 9c30921fe ("driver core:
platform: use bus_type functions").
I can include crash trace into v2.

I added a check to platform_remove() as a safety measure. All current
calls for dev->bus->remove() in dd.c seem to happen only when
dev->driver is set, but I thought that it might be a good check. I can
drop it if you'd like.


>
> For one of the bus types I changed recently
> (arch/powerpc/platforms/ps3/system-bus.c) the bus's shutdown function
> does:
>
>         if (drv->shutdown)
>                 drv->shutdown(dev);
>         else if (drv->remove) {
>                 dev_dbg(&dev->core, ...
>                 drv->remove(dev);
>         } ...
>
> but for the platform bus I'm not aware that remove is used in absence of
> a shutdown callback.
>
> Relevant callers of bus->remove are all in drivers/base/dd.c, and for
> all of them dev->driver should be set.
>
> I look forward to an explaination about why this patch was created.

Here is an explanation: the 3d6a0000.gmu device is not bound to a
driver, causing a crash during reboot.

[   57.832972] platform 3d6a000.gmu: shutdown
[   57.837778] Unable to handle kernel paging request at virtual
address ffffffffffffffe8
[   57.846391] Mem abort info:
[   57.849704]   ESR =3D 0x96000004
[   57.853286]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[   57.859177]   SET =3D 0, FnV =3D 0
[   57.862751]   EA =3D 0, S1PTW =3D 0
[   57.866415] Data abort info:
[   57.869801]   ISV =3D 0, ISS =3D 0x00000004
[   57.874171]   CM =3D 0, WnR =3D 0
[   57.877634] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000a16460=
00
[   57.884937] [ffffffffffffffe8] pgd=3D0000000000000000, p4d=3D00000000000=
00000
[   57.892323] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[   57.898471] Modules linked in:
[   57.902022] CPU: 7 PID: 387 Comm: reboot Tainted: G        W
 5.10.0-rc7-next-20201211-13328-gb9e15b9c1940-dirty #1270
[   57.914043] Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
[   57.921340] pstate: 60400005 (nZCv daif +PAN -UAO -TCO BTYPE=3D--)
[   57.927930] pc : platform_shutdown+0x8/0x34
[   57.932661] lr : device_shutdown+0x158/0x32c
[   57.937483] sp : ffff800010773c70
[   57.941319] x29: ffff800010773c70 x28: ffff14f80c41c600
[   57.947208] x27: 0000000000000000 x26: ffff14f80129c490
[   57.953100] x25: ffffaa6264ece398 x24: 0000000000000008
[   57.958990] x23: ffffaa62655be030 x22: ffffaa6265671600
[   57.964875] x21: ffff14f80122b010 x20: ffff14f80129c410
[   57.970765] x19: ffff14f80129c418 x18: 0000000000000030
[   57.976665] x17: 0000000000000000 x16: 0000000000000001
[   57.982590] x15: 0000000000000004 x14: 000000000000019f
[   57.988478] x13: 0000000000000000 x12: 0000000000000000
[   57.994394] x11: 0000000000000000 x10: 00000000000009b0
[   58.000297] x9 : ffff800010773920 x8 : ffff14f80c41d010
[   58.006205] x7 : ffff14f976ff59c0 x6 : 0000000000000192
[   58.012112] x5 : 0000000000000000 x4 : ffff14f976feb920
[   58.018023] x3 : ffff14f976ff2878 x2 : 0000000000000000
[   58.023940] x1 : 0000000000000000 x0 : ffff14f80129c410
[   58.029871] Call trace:
[   58.032849]  platform_shutdown+0x8/0x34
[   58.037256]  kernel_restart+0x40/0xa0
[   58.041485]  __do_sys_reboot+0x228/0x250
[   58.045975]  __arm64_sys_reboot+0x28/0x34
[   58.050571]  el0_svc_common+0x7c/0x1a0
[   58.054886]  do_el0_svc+0x28/0x94
[   58.058754]  el0_svc+0x14/0x20
[   58.062371]  el0_sync_handler+0x1a4/0x1b0
[   58.066951]  el0_sync+0x174/0x180
[   58.070822] Code: d503201f d503201f d503245f f9403401 (f85e8021)
[   58.077532] ---[ end trace 26b521c0dca4c8d0 ]---


--
With best wishes
Dmitry
