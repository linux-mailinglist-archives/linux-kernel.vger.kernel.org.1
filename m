Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538A32F4126
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 02:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbhAMBX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 20:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbhAMBX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 20:23:56 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D2BC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 17:23:15 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id w124so437422oia.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 17:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ftDS6LJvKcuupUK2HTpTwWJJm0o4zAXyt2XBFRBfiB8=;
        b=GgS835YI4alinTp8g6T5BF0BVLpt2qeTxrUjdDgdPUokl/aqTGBkqsiVQn53DaOPmJ
         FRmWfu+9+6viyfctTPQyXkWEYZZDrhcf1KqISQ7SJwdEMKCEtUqcgA7pZoVbB0OD/D0D
         QLuA/rr/vviM3GjiFaiEm2m31rOoz+/1Om38Um3eQTF81YrrVTFqyotPQuUs8WpohWhC
         VJluCVY3vy5cxXabhTr+u+JGnq4JZiHOVqIHvYS3SObKum7Go8ZqRMFrOxsdKoKFVEgk
         idC4bafDiNrKyAewNbIXoBOtrx8p0GwGf+5Nkh+ZQdGTjBCNvStMFO74XpFYL/oMeMoK
         UQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ftDS6LJvKcuupUK2HTpTwWJJm0o4zAXyt2XBFRBfiB8=;
        b=mnS1lrFb8+G3GL09qQf1tSQ60CIpqZYcN81s1dz+HlhkNDC1OLK/0BTGPLneNxf2/H
         er2LJARGV1Se/WoX8JM/EsO19npYXTJcsGhUGr7+3ptz461ZLeinpkGOTkHVssf4+EUM
         tvd7kZ6ubfa9yHRYA0/F63V399YhmX8BAPrpVik7qXLotDyupV13gt3GxZFkdwMZthix
         czA6p7YczYKpkoOWfjz0HLrtnuowcQybEsGNe/7YYxYhxLNZpOlN3osCpJ+6LqvTcRtV
         FeidMBb454oi7uCt61DjbLOBpvhFmH5aXjlPVz/QNjqjTHs1r92ZpdpXvcJ6baiYMfsi
         NgpA==
X-Gm-Message-State: AOAM5322tklY5LIAGeQFVOu3AeR5aEg6zt1osaLAUQqG/IInz9//Net9
        vRy5JD/wVGq1Ep1PUBQzFJwGY6SYuLl/r0xo4kgbW9szoDeT8w==
X-Google-Smtp-Source: ABdhPJyeQF7SeqlcjskyirEM0E/F9YB1gpWpXlnjMpiWSCheBuS1ltb9OsF72K5nHsejgaJH7AIqqd9i2/0SIumTmPY=
X-Received: by 2002:aca:1110:: with SMTP id 16mr252695oir.12.1610500995010;
 Tue, 12 Jan 2021 17:23:15 -0800 (PST)
MIME-Version: 1.0
References: <20201201213019.1558738-1-furquan@google.com> <e77e0569-568a-f7fb-9f0d-e64943b467f0@gmail.com>
 <CAJZ5v0jhniqG43F6hCqXdxQiQZRc67GdkdP0BXcRut=P7k7BVQ@mail.gmail.com> <X/2fzghPXnuDNBPU@kroah.com>
In-Reply-To: <X/2fzghPXnuDNBPU@kroah.com>
From:   Furquan Shaikh <furquan@google.com>
Date:   Tue, 12 Jan 2021 17:22:57 -0800
Message-ID: <CAEGmHFEpPTuRuWFt0ba022BmGfaDmSTAgEApW9EzAa5CitmtbA@mail.gmail.com>
Subject: Re: [PATCH] drivers: core: Detach device from power domain on shutdown
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 5:09 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 12, 2021 at 01:45:25PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Jan 12, 2021 at 10:55 AM Dmitry Osipenko <digetx@gmail.com> wro=
te:
> > >
> > > 02.12.2020 00:30, Furquan Shaikh =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > > When the system is powered off or rebooted, devices are not detache=
d
> > > > from their PM domain. This results in ACPI PM not being invoked and
> > > > hence PowerResouce _OFF method not being invoked for any of the
> > > > devices. Because the ACPI power resources are not turned off in cas=
e
> > > > of poweroff and reboot, it violates the power sequencing requiremen=
ts
> > > > which impacts the reliability of the devices over the lifetime of t=
he
> > > > platform. This is currently observed on all Chromebooks using ACPI.
> > > >
> > > > In order to solve the above problem, this change detaches a device
> > > > from its PM domain whenever it is shutdown. This action is basicall=
y
> > > > analogous to ->remove() from driver model perspective. Detaching th=
e
> > > > device from its PM domain ensures that the ACPI PM gets a chance to
> > > > turn off the power resources for the device thus complying with its
> > > > power sequencing requirements.
> > > >
> > > > Signed-off-by: Furquan Shaikh <furquan@google.com>
> > > > ---
> > > >  drivers/base/core.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > index d661ada1518f..5823f1d719e1 100644
> > > > --- a/drivers/base/core.c
> > > > +++ b/drivers/base/core.c
> > > > @@ -23,6 +23,7 @@
> > > >  #include <linux/of_device.h>
> > > >  #include <linux/genhd.h>
> > > >  #include <linux/mutex.h>
> > > > +#include <linux/pm_domain.h>
> > > >  #include <linux/pm_runtime.h>
> > > >  #include <linux/netdevice.h>
> > > >  #include <linux/sched/signal.h>
> > > > @@ -4057,6 +4058,8 @@ void device_shutdown(void)
> > > >                       dev->driver->shutdown(dev);
> > > >               }
> > > >
> > > > +             dev_pm_domain_detach(dev, true);
> > > > +
> > > >               device_unlock(dev);
> > > >               if (parent)
> > > >                       device_unlock(parent);
> > > >
> > >
> > > This patch broke system shutdown on NVIDIA Tegra using today's
> > > linux-next because power domain can't be turned off until device driv=
ers
> > > handed control over device resets to the power domain of Power
> > > Management controller on Tegra. This patch introduced the wrong
> > > behaviour, apparently it should be made specific to ACPI only.
> > >
> > > Please fix, thanks in advance.

Sorry about the breakage. I am working on an alternate solution that
Rafael suggested.

> >
> > OK, so Greg please drop it.
>
> Now reverted, thanks.

Thanks Greg!

>
> greg k-h
