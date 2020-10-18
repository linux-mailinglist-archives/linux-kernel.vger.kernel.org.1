Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A106291809
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 17:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgJRPXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 11:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgJRPXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 11:23:50 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E95AC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 08:23:48 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id b8so9977463ioh.11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 08:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pq2cCgFfAlIaF+/VLMFX1e8QfeRpmNnZdqE+CnQe2SU=;
        b=tAvpFy7jIz1zxAY+hqkFJfB9toH6vNuqj5d/iV4hRsqTj/0uFUS2gnCy3kDMjep0ds
         BTmvjlrELM6fnN+AN8oFVbxrQ1hyyfx80GfW2s4JkPEB+pgufvh08EljOHAzikUaNztR
         xWvwM/9RBa/tDEbsSk0LXJwlu3nMUXDFV5zz/kk74FRYX9HzVB1abIm/U1PxYmvPZ7sZ
         RNBvhoIWxSU1Z6i0Qdcu5xqgm70dusZWNq+UhiIlA3aX0t6BO0Xhh+th6za2ClJVJDHa
         1ljYJl3lO5NbhVlmm5sRkxPX9LAX6wyv8qi0sVFePSccloH63lxy8EOJSFzMOkgIpD9M
         312w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pq2cCgFfAlIaF+/VLMFX1e8QfeRpmNnZdqE+CnQe2SU=;
        b=Rb8CEgFAwqFMK5jml5HFQtksKbNprApIc1xiQD0WyEMFfMOxnHbzRMg1HvhmyyodWg
         8mK9uqKpB05NubXJbcQ5YEXekyTKpmMa+G4XM/o5RZKTJnqSNPHmaOkgFWxBMIr31jGd
         VQM0tH0DWNHamVTdVxmO2qPNlxqrqq7LBmpS4+2AK3R3awZowL7rP/2UCp7H/E7BkyVR
         Qt8rqaYetIMAiIlJ6nmWteux+7ewcXnnalIsC8b9pvKGn0unnRv/a5OgJ49FKelgFERn
         sWXnS4a5rV2WHv1V2FER8JToH8g5BP1Kmer/8aR4B48qzK6pK55yN+PfY3zG3p631hfy
         44EA==
X-Gm-Message-State: AOAM53104zW+oHNgyOeX+xaJnp0L3Q2SWNX4/3adnGUNCfaXHjA5nJTR
        HrDJXUNDXvLso0qIfVuxsCnUKYbD5SEr3oPGOnEB
X-Google-Smtp-Source: ABdhPJzDh2HYF2MkopPq0IP02CbEU1LreS/yV9unO6dAXxEl63mPEr/hOTpksUJUZANJitN9TUp/dh/RfdD4Ppuh2rA=
X-Received: by 2002:a6b:9108:: with SMTP id t8mr846700iod.206.1603034627798;
 Sun, 18 Oct 2020 08:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201018033142.GA27793@ubuntu> <20201018123334.5a8bb5ac@archlinux>
In-Reply-To: <20201018123334.5a8bb5ac@archlinux>
From:   Vaishnav M A <vaishnav@beagleboard.org>
Date:   Sun, 18 Oct 2020 20:53:36 +0530
Message-ID: <CALudOK5KOgPy6wfi7nsXSgEtNsjaFy6faf_wqL_2TxJJZKugmw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: proximity: vl53l0x-i2c add i2c_device_id
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     songqiang1304521@gmail.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        =?UTF-8?Q?Ivan_Rajkovi=C4=87?= <rajkovic@mikroe.com>,
        Wolfram Sang <wsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 18, 2020 at 5:03 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 18 Oct 2020 09:01:42 +0530
> Vaishnav M A <vaishnav@beagleboard.org> wrote:
>
> > add i2c_device_id for the vl53l0x-i2c driver so
> > that the device can be instantiated using i2c_new_client_device
> > or from userspace, useful in cases where device tree based description
> > is not possible now(Eg. a device on a gbphy i2c
> > adapter created by greybus).
> >
> > Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
>
> Please fix the description as mentioned in other patches.
>
Thank you Jonathan for your review, I have sent a v3 patch with fixed
description : https://lore.kernel.org/patchwork/patch/1322196/
understand your concern about the redundant device_id(s), it will be nice to see
of_match_table reused in such cases as you suggested.

> The code change is fine, but it does raise the question of whether we want to think
> about providing a means to register such devices using the of_match_table.
> It's somewhat irritating to need to provide both (I'd rather not
> just provide the non-dt version rely on the old hack that drops the
> vendor ID for matching).
>
> +CC Wolfram.
>
> > ---
> >  v2:
> >       - fix commit message
> >  drivers/iio/proximity/vl53l0x-i2c.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> > index 5fbda9475ba9..7c29d4cae24a 100644
> > --- a/drivers/iio/proximity/vl53l0x-i2c.c
> > +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> > @@ -143,6 +143,12 @@ static int vl53l0x_probe(struct i2c_client *client)
> >       return devm_iio_device_register(&client->dev, indio_dev);
> >  }
> >
> > +static const struct i2c_device_id vl53l0x_id[] = {
> > +     { "vl53l0x", 0},
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, vl53l0x_id);
> > +
> >  static const struct of_device_id st_vl53l0x_dt_match[] = {
> >       { .compatible = "st,vl53l0x", },
> >       { }
> > @@ -155,6 +161,7 @@ static struct i2c_driver vl53l0x_driver = {
> >               .of_match_table = st_vl53l0x_dt_match,
> >       },
> >       .probe_new = vl53l0x_probe,
> > +     .id_table = vl53l0x_id,
> >  };
> >  module_i2c_driver(vl53l0x_driver);
> >
>
