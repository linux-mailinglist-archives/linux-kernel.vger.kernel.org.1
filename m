Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61ECE3042EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392662AbhAZPsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730427AbhAZPq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:46:59 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0344CC0698C0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:46:19 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id y205so10646847pfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N52hj6g6rIC9pzwZmjxHFzRAevniWVRNfuFelric0us=;
        b=V1+GqalLJ3NSkGYkTMKAjHlbUC+VGDyScNgN7GHlACX0UP3WgoTTe8M3tNgVVtik4f
         zrI0tVRB4F/tV+e18JntF8e0tIvnCApn68xaqOn8s1XcLL4LvHza73C4YYqs/U4fIsvA
         iw6foExrUPAyTFjb+E376rVNSkQiJgE8s3xYES41HojBc6Qe4IRyJb1+0f3srw5WStM6
         ysUCwo8Uac0LrUmZSCc1WqFI7bXGhRSu7sZo6tRDkUEAd/Nt8fXdW2WVLmsX361Kj64F
         WpOCf/sIh0ViRDYlrfh3Z8VFbB6tBunq2HUZTWYnCFmWZj7C+4GDUDdfQO8qiblQ9Fcr
         mYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N52hj6g6rIC9pzwZmjxHFzRAevniWVRNfuFelric0us=;
        b=To7xbtSqEjyvDRKP3EpRYKTxHF7o+fEwX2ymaYQzTgtTPnRJiqXGlWLnXCGO4Ep+S6
         3bGqxzHW/YvoIbGkkE6eIVtPs8iLbFdXLhaJxqN+Fy61Yn4K+rfpUJfnrHa2ZHL0pRjf
         xkQBTbMloR6efEBC3SwD05Zih459I6z/aWwmFyi6z/Z/oXZch6DsaKt7jwuAqZ6pzkrr
         xgXK9bhctfKFiCXmEw1kcxCam7o/FAcfOXfxLY/LxZlfwzs6tf360zcn4V7NpBday8Sn
         5Dv/C5uY4yhyqc6dMBfhqZq5Ryp1at3RdidUp6tFrWDzFiQ6qyDkrZbHw09+i2dRL+oW
         xhnA==
X-Gm-Message-State: AOAM5326F442A23NfrWHq7z7s9ioWMHKICqSJOgTtV+aURp/0QEmrKQq
        bA5klq1fWbs7iAfmXOdx7S1CNMmEhmRBwCHZqGGDzA==
X-Google-Smtp-Source: ABdhPJzOsEReVeyf+iZA1Bk7JXLJBk0DKvW/xwox6cZ5LDbvqaLYkGfXAUB/pCbbBN9Kp6+QJq5K/w2vQKW3FKPVqVI=
X-Received: by 2002:a65:64da:: with SMTP id t26mr6114578pgv.145.1611675978415;
 Tue, 26 Jan 2021 07:46:18 -0800 (PST)
MIME-Version: 1.0
References: <20210123014247.989368-1-lma@semihalf.com> <20210125171846.GA31929@roeck-us.net>
In-Reply-To: <20210125171846.GA31929@roeck-us.net>
From:   =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@semihalf.com>
Date:   Tue, 26 Jan 2021 16:46:07 +0100
Message-ID: <CAFJ_xboNDcp-XrxfbrBjqTWjLZUdVWe1OJi4KK==ij+yivFeHA@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis: Add missing start/stop_tpm_chip calls
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko, Guenter

Yes, here are the logs when failure occurs -
https://gist.github.com/semihalf-majczak-lukasz/1575461f585f1e7fb1e9366b8ec=
eaab9
Look for a phrase "TPM returned invalid status"

Guenter - good suggestion - I will try to keep it as tight as possible.

Best regards,
Lukasz

pon., 25 sty 2021 o 18:18 Guenter Roeck <linux@roeck-us.net> napisa=C5=82(a=
):
>
> Hi Lukasz,
>
> On Sat, Jan 23, 2021 at 02:42:47AM +0100, Lukasz Majczak wrote:
> > There is a missing call to start_tpm_chip before the call to
> > the tpm_get_timeouts() and tpm_tis_probe_irq_single(). As the current
> > approach maight work for tpm2, it fails for tpm1.x - in that case
> > call to tpm_get_timeouts() or tpm_tis_probe_irq_single() tries to
> > transmit TPM commands on a disabled chip what what doesn't succeed
>
> s/what what/what/
>
> > and in turn causes tpm_tis_core_init() to fail.
> > Tested on Samsung Chromebook Pro (Caroline).
> >
> > Signed-off-by: Lukasz Majczak <lma@semihalf.com>
> > ---
> >  drivers/char/tpm/tpm_tis_core.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis=
_core.c
> > index 92c51c6cfd1b..ff0e5fe46a9d 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -1063,12 +1063,16 @@ int tpm_tis_core_init(struct device *dev, struc=
t tpm_tis_data *priv, int irq,
> >       init_waitqueue_head(&priv->read_queue);
> >       init_waitqueue_head(&priv->int_queue);
> >       if (irq !=3D -1) {
> > +             rc =3D tpm_chip_start(chip);
>
> Unless I am missing something, the underlying problem seems to be
> the calls to tpm1_getcap(). From other code calling this function,
> it looks like it may only require tpm_clk_enable() to work.
>
> With that in mind, would it possibly be better to call tpm_clk_enable()
> and tpm_clk_disable() around the calls to tpm1_getcap(), ie in
> tpm1_get_timeouts() and in tpm_tis_gen_interrupt() ?
>
> This would avoid the unnecessary calls to tpm_chip_start() and
> tpm_chip_stop() for tpm2 chips.
>
> Thanks,
> Guenter
>
>
> > +             if (rc)
> > +                     goto out_err;
> >               /* Before doing irq testing issue a command to the TPM in=
 polling mode
> >                * to make sure it works. May as well use that command to=
 set the
> >                * proper timeouts for the driver.
> >                */
> >               if (tpm_get_timeouts(chip)) {
> >                       dev_err(dev, "Could not get TPM timeouts and dura=
tions\n");
> > +                     tpm_chip_stop(chip);
> >                       rc =3D -ENODEV;
> >                       goto out_err;
> >               }
> > @@ -1085,6 +1089,7 @@ int tpm_tis_core_init(struct device *dev, struct =
tpm_tis_data *priv, int irq,
> >               } else {
> >                       tpm_tis_probe_irq(chip, intmask);
> >               }
> > +             tpm_chip_stop(chip);
> >       }
> >
> >       rc =3D tpm_chip_register(chip);
