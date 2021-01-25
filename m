Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E655303998
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 10:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391757AbhAZJzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 04:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731264AbhAYSxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:53:23 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137C0C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:52:43 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id m6so8930353pfm.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=PyFIQTDz1+7uxusIMsa/H38XD+IyWyEJp5nLEM5ZZd8=;
        b=dQKkjj9DVQim0K/skB4pCoM6XlszO8t5AesFN6sHJRGiAG1sl9X1rhfUGPH7DBMxps
         4FSvluOvSFM9pROoZdXZ5TRGBGWr6NuUWocrI6Pe4RxpCXQAz2LslgoL2SJhZGRwcgKC
         Y+lgwAzzBAgPOTNPN4tUJdbI8H7lj8ha7oyBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=PyFIQTDz1+7uxusIMsa/H38XD+IyWyEJp5nLEM5ZZd8=;
        b=i+86cHcCymdRifhnGj4TDKanUmQ5GF3Q1ikoPTeKqfIlDnDj/xghAObqZqYDtXWC1v
         6PnZY0FZjUmFXpTBqH9Y3nrYOIExKL0/H8X8qourSzqV18Sx4+/Ckn309wT9wKvC/9N9
         olKACIRIwok0GTmBjVAipIbFaisAhZoc6yCcyQYtb7vvPjvIJLZ3dxXvGf3Gdf5eD2r0
         8MwadIgXXM9XPSDoUvb2IVTxR8FOFt4mxTfpG11GG3UGmo1h98azMo3vAjraBqUmBYyx
         lE8Sg3IxuG6tNmk5ye6c9fxGdmX5bVbSHy2upVTt/xgJMioe7DK5FCOGd6VueO8VOT6L
         xu7w==
X-Gm-Message-State: AOAM533LunSvQdeNIIEU6fEmWGnMPo+PeazMSj83hJKRO6iNuxaoIjnT
        54qpAofVXQ7jfQdN/4VuzjTdKkjGxSM3dA==
X-Google-Smtp-Source: ABdhPJy8Q5bX833NbF6fj+EubnPYe5iTDhajBtTDYN4FLQd3stBRSYm16E9qQmbb4bme8Tn7JzfBbQ==
X-Received: by 2002:a63:4d52:: with SMTP id n18mr1872928pgl.237.1611600762258;
        Mon, 25 Jan 2021 10:52:42 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:1066:b437:97cd:2278])
        by smtp.gmail.com with ESMTPSA id a37sm16168315pgm.79.2021.01.25.10.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 10:52:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPUE2uuQsa7=pjw+D=r0QtLGTd1kQa7X6VBVa73=gx47Vf7KDA@mail.gmail.com>
References: <20210122225443.186184-1-swboyd@chromium.org> <20210122225443.186184-4-swboyd@chromium.org> <20210124173820.4528b9c9@archlinux> <CAPUE2uuQsa7=pjw+D=r0QtLGTd1kQa7X6VBVa73=gx47Vf7KDA@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: proximity: Add a ChromeOS EC MKBP proximity driver
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
To:     Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>
Date:   Mon, 25 Jan 2021 10:52:40 -0800
Message-ID: <161160076017.76967.4467861058817044169@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gwendal Grignou (2021-01-24 13:41:44)
> On Sun, Jan 24, 2021 at 9:38 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Fri, 22 Jan 2021 14:54:43 -0800
> > Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > > ---
> > >  drivers/iio/proximity/Kconfig             |  11 +
> > >  drivers/iio/proximity/Makefile            |   1 +
> > >  drivers/iio/proximity/cros_ec_proximity.c | 252 ++++++++++++++++++++=
++

I suppose I'll change this to cros_ec_mkbp_proximity as well.

> > > diff --git a/drivers/iio/proximity/cros_ec_proximity.c b/drivers/iio/=
proximity/cros_ec_proximity.c
> > > new file mode 100644
> > > index 000000000000..a3aef911e3cc
> > > --- /dev/null
> > > +++ b/drivers/iio/proximity/cros_ec_proximity.c
> > > @@ -0,0 +1,252 @@
[...]
> > > +
> > > +static int cros_ec_proximity_query(struct cros_ec_device *ec_dev, in=
t *state)
> > > +{
> > > +     struct ec_params_mkbp_info *params;
> > > +     struct cros_ec_command *msg;
> > > +     int ret;
> > > +
> > > +     msg =3D kzalloc(sizeof(*msg) + max(sizeof(u32), sizeof(*params)=
),
> > > +                   GFP_KERNEL);
> >
> > Given this is known at build time, perhaps better to add it to the
> > iio_priv() accessed structure and avoid having to handle allocations
> > separately.
> As Jonathan said, it can be preallocated in iio private structure. We
> can also use the stack, given the response size is known beforehand.
> See cros_ec_cec_set_log_addr() or cros_ec_pwm_get_duty() for example.

I suppose stack is even simpler. I'll try that.

> > > +
> > > +static int cros_ec_proximity_notify(struct notifier_block *nb,
> > > +                          unsigned long queued_during_suspend, void =
*_ec)
> > > +{
> > > +     struct cros_ec_proximity_data *data;
> > > +     struct cros_ec_device *ec =3D _ec;
> > > +     u8 event_type =3D ec->event_data.event_type & EC_MKBP_EVENT_TYP=
E_MASK;
> > > +     void *switches =3D &ec->event_data.data.switches;
> > > +     struct iio_dev *indio_dev;
> > > +     s64 timestamp;
> > > +     int state, dir;
> > > +     u64 ev;
> > > +
> > > +     if (event_type =3D=3D EC_MKBP_EVENT_SWITCH) {
> > > +             data =3D container_of(nb, struct cros_ec_proximity_data=
, notifier);
> > > +             indio_dev =3D data->indio_dev;
> > > +
> > > +             mutex_lock(&data->lock);
> > > +             if (data->enabled) {
> > > +                     timestamp =3D iio_get_time_ns(indio_dev);
> For Android, given the timestamp must be time it happens, not reported
> [https://source.android.com/devices/sensors/sensors-hal2] """The
> timestamp must be accurate and correspond to the time at which the
> event physically happened, not the time it was reported.""", consider
> using ec_dev->last_event_time and apply a delta if the iio clock base
> is different from CLOCK_BOOTTIME.

Ah alright. Is there a reason why cros_ec_get_time_ns() is using
boottime instead of plain ktime_get(), i.e. CLOCK_MONOTONIC? Otherwise I
suppose some sort of cros_ec API should be exposed to convert the
last_event_time to whatever clock base is desired. Does that exist?

> > > +static int cros_ec_proximity_probe(struct platform_device *pdev)
> > > +{
> > > +     struct device *dev =3D &pdev->dev;
> > > +     struct cros_ec_device *ec =3D dev_get_drvdata(dev->parent);
> > > +     struct iio_dev *indio_dev;
> > > +     struct cros_ec_proximity_data *data;
> > > +     int ret;
> > > +
> > > +     indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> > > +     if (!indio_dev)
> > > +             return -ENOMEM;
> > > +
> > > +     data =3D iio_priv(indio_dev);
> > > +     data->ec =3D ec;
> > > +     data->indio_dev =3D indio_dev;
> > > +     mutex_init(&data->lock);
> > > +     platform_set_drvdata(pdev, data);
> > > +
> > > +     indio_dev->name =3D "cros_ec_proximity";
> Define a constant CROS_EC_[MKBP_]PROXIMITY_DRIVER_NAME and use it here
> and in struct platform_driver cros_ec_proximity_driver.

I used dev->driver->name instead. Yay for no define!

> > > +     indio_dev->dev.parent =3D dev;
> Not needed, done by iio_device_alloc(), called by devm_iio_device_alloc().

Ok.

> > > +static const struct of_device_id cros_ec_proximity_of_match[] =3D {
> > > +     { .compatible =3D "google,cros-ec-proximity" },
> > > +     {}
> > > +};
> > > +MODULE_DEVICE_TABLE(of, cros_ec_proximity_of_match);
> > > +#endif
> > > +
> > > +static struct platform_driver cros_ec_proximity_driver =3D {
> > > +     .driver =3D {
> > > +             .name =3D "cros-ec-proximity",
> > > +             .of_match_table =3D of_match_ptr(cros_ec_proximity_of_m=
atch),
> Add a ACPI match table to match.

I don't have an ACPI system in hand. What should the ACPI table look
like? Can ACPI use the of_match_table logic?

> > > +     },
> > > +     .probe =3D cros_ec_proximity_probe,
> > > +     .remove =3D cros_ec_proximity_remove,
> > > +};
