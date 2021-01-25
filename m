Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEC330306D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 00:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbhAYXqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 18:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732103AbhAYXpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 18:45:35 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB05C061788
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 15:44:23 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id z21so10043955pgj.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 15:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=wSE2xzNZ7Okvy4mNLHpOXd6TUiHMFkj0cWnGwjBCvlw=;
        b=d/IXYYVzCP+JAXnPfOX5o0n8GYa7pJt/b0visFkHgDAGjiUwDqy36JA6QAct++bdLb
         4J5y8vz0RGYtvHpnRkVVfQ0cbi8sHmnlgjzNyuRAvWkmkcUObqYWbOja0GHa8G8L0juB
         Cvm7vfkGUxoBGM325qT/AjXNzQMCIp9DZKxLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=wSE2xzNZ7Okvy4mNLHpOXd6TUiHMFkj0cWnGwjBCvlw=;
        b=P6rM0hODe6No08ij7m4M4nx9a2JZ7UchXyvMBYVUcGW+Q3OtQIVMW5fTApDiq6RGWb
         gwNz/ObzWvHT98aaL4GQYeTGjES97sIfNP3Su2eQQdKvA51DogwsJE78ZJf4684LHfSx
         cq6FNBS5ZHtOHgYZ2Ee/acHMINmqjly3wRUP2WqYgxavSlmTb2HioFRSaicDntKJeM/d
         2VuQyZh3CbvvMotqetOLHm9XX5+hE/uBme8+eTaNSImVqPA67dayRZyVE+/eVaU8IIRL
         ENZbml4hLRi6GKOVe6feym4TZBEAlh8G6Ih+X3mxIJRpJxAqwB/EaKQJNR4R/oGgwb5W
         yscQ==
X-Gm-Message-State: AOAM532CtJR3A4MnTByL2N4OyKAqLO6TJAKEzFWpiRON8ntT5VgzR8nF
        q+48kheauSlIF4hfFJPsNgnzUw==
X-Google-Smtp-Source: ABdhPJxBtq5aRKrlvYJue6c7FAdKPJMUi64cwtoToa0PaSxu0ndehcMYyt/SdCDxCurjAG2DFNmuKQ==
X-Received: by 2002:a63:2903:: with SMTP id p3mr2811736pgp.11.1611618262851;
        Mon, 25 Jan 2021 15:44:22 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:1066:b437:97cd:2278])
        by smtp.gmail.com with ESMTPSA id h8sm453488pjc.2.2021.01.25.15.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 15:44:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPUE2uu555NT1=u=1Nb8WExT7RvK8mj5kBiDfGymHiAmoj2WCg@mail.gmail.com>
References: <20210122225443.186184-1-swboyd@chromium.org> <20210122225443.186184-4-swboyd@chromium.org> <20210124173820.4528b9c9@archlinux> <CAPUE2uuQsa7=pjw+D=r0QtLGTd1kQa7X6VBVa73=gx47Vf7KDA@mail.gmail.com> <161160076017.76967.4467861058817044169@swboyd.mtv.corp.google.com> <CAPUE2uu555NT1=u=1Nb8WExT7RvK8mj5kBiDfGymHiAmoj2WCg@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: proximity: Add a ChromeOS EC MKBP proximity driver
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 25 Jan 2021 15:44:20 -0800
Message-ID: <161161826068.76967.15170332425672601158@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gwendal Grignou (2021-01-25 14:28:46)
> On Mon, Jan 25, 2021 at 10:52 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Gwendal Grignou (2021-01-24 13:41:44)
> > > On Sun, Jan 24, 2021 at 9:38 AM Jonathan Cameron <jic23@kernel.org> w=
rote:
> > > >
> > > > On Fri, 22 Jan 2021 14:54:43 -0800
> > > > Stephen Boyd <swboyd@chromium.org> wrote:
> > > > > +     if (event_type =3D=3D EC_MKBP_EVENT_SWITCH) {
> > > > > +             data =3D container_of(nb, struct cros_ec_proximity_=
data, notifier);
> > > > > +             indio_dev =3D data->indio_dev;
> > > > > +
> > > > > +             mutex_lock(&data->lock);
> > > > > +             if (data->enabled) {
> > > > > +                     timestamp =3D iio_get_time_ns(indio_dev);
> > > For Android, given the timestamp must be time it happens, not reported
> > > [https://source.android.com/devices/sensors/sensors-hal2] """The
> > > timestamp must be accurate and correspond to the time at which the
> > > event physically happened, not the time it was reported.""", consider
> > > using ec_dev->last_event_time and apply a delta if the iio clock base
> > > is different from CLOCK_BOOTTIME.
> >
> > Ah alright. Is there a reason why cros_ec_get_time_ns() is using
> > boottime instead of plain ktime_get(), i.e. CLOCK_MONOTONIC? Otherwise I
> > suppose some sort of cros_ec API should be exposed to convert the
> > last_event_time to whatever clock base is desired. Does that exist?
> CLOCK_BOOTTIME was chosen to be Android compliant, as it includes
> suspend time and match elapsedRealtime() [see
> https://developer.android.com/reference/android/os/SystemClock#elapsedRea=
ltime()]
> Chromebook set iio clock reference for all sensor to CLOCK_BOOTTIME
> (see https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/mems_s=
etup/configuration.cc#127).
> In case the iio device clock_id is not CLOCK_BOOTTIME/"bootime", we
> need to add a delta, like in cros_ec_sensors_push_data()
> [https://elixir.bootlin.com/linux/latest/source/drivers/iio/common/cros_e=
c_sensors/cros_ec_sensors_core.c#L210]

The delta may help but what if the clock is adjusted in the time between
the event is timestamped and this driver reading the timestamp? That
could lead to some odd behavior where the timestamp is in the future
because we don't know what sort of adjustment was made, e.g. the
realtime clock being moved back in time.

I'd rather have a way to request that cros_ec core timestamp the event
with some clock base that this driver desires, instead of having to do
an offset after the fact. For now I'll use ec_dev->last_event_time
because this is only used on chromeos and that should work until
userspace is changed, but in the future I think we'll need to have a way
for this IIO device to be notified when the clock base changes in
iio_device_set_clock() and then have this driver call into cros_ec to
request that such a timestamp be made when this event is seen. Or even
better have a way to request that cros_ec timestamp the event itself on
the EC side, but I don't know if that's possible.

> > > > > +static const struct of_device_id cros_ec_proximity_of_match[] =
=3D {
> > > > > +     { .compatible =3D "google,cros-ec-proximity" },
> > > > > +     {}
> > > > > +};
> > > > > +MODULE_DEVICE_TABLE(of, cros_ec_proximity_of_match);
> > > > > +#endif
> > > > > +
> > > > > +static struct platform_driver cros_ec_proximity_driver =3D {
> > > > > +     .driver =3D {
> > > > > +             .name =3D "cros-ec-proximity",
> > > > > +             .of_match_table =3D of_match_ptr(cros_ec_proximity_=
of_match),
> > > Add a ACPI match table to match.
> >
> > I don't have an ACPI system in hand. What should the ACPI table look
> > like? Can ACPI use the of_match_table logic?
> AFAIK, ACPI uses .acpi_match_table, see
> drivers/iio/magnetometer/ak8975.c for a simple example.

Ok. I'm leaning towards punting on this. I don't have an ACPI system to
test and I don't know what the ACPI match table should have in it. If
you can tell me what to put in the acpi_match_table then I can add it.
