Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201672DFE92
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 18:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgLUQ7o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Dec 2020 11:59:44 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60429 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgLUQ7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 11:59:41 -0500
Received: from mail-lf1-f70.google.com ([209.85.167.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1krOWQ-0001hO-Ra
        for linux-kernel@vger.kernel.org; Mon, 21 Dec 2020 16:58:58 +0000
Received: by mail-lf1-f70.google.com with SMTP id i21so11265811lfe.14
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 08:58:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mrI0NOhbwzArwu7CQoQtAICpbAp0ocXR0WvQgJQ+Flk=;
        b=U02Yc249Xh48y0VTbFmE/Z3/wKtQ8gSUMpcmZqXJQiswDyGi7NRsG/Wd+BRi9uKUd2
         ygpNijixsHWAPfVfx6xbvTzyVegy2qYVzNKxPtTECE61prckbFtoNDM5ZNLXvsFxc7u3
         FnIThS+x32JaW2M5rKwmA3YqIqJXz4JF3w0RnNSwkqU90iaOBwvMe7d77a6ihOGndMk3
         gaWMQOfTXK1xrPyfB199vFisX4EGMb7E/lz+GyWDGT3FOUd3yok8++BRx80emseVsaHu
         aWqpE3X7SIFviJkwTDemeLfBbSqcQZULJBmeSq98eXYusm/OsEZQhhl1W+jhjjfZUPuP
         J7pA==
X-Gm-Message-State: AOAM533y+6oEAp3dc0OUKjGJka50rSLn9t8Duiu18YQTmHX9bG3GrHEl
        0qcweiujJIOo693B+hdATj4vTm76I+wtsmCBKBMhCzgID5YLTJNdzhdXqJOjOxJ0iHrQ0j8leSE
        SVrhwuvudj0EIhHEP0NHBsoir0HZ95fVo55DSt0G6GqElZLd6kh+uCeQ/lg==
X-Received: by 2002:a19:dc5:: with SMTP id 188mr7303000lfn.513.1608569938239;
        Mon, 21 Dec 2020 08:58:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJycZVbLtKL7UefqYSh4S/gU0q1mtELJm0Ffj9ryUAVPRgmsEx0C2FEpw3uxOfSl7I47RO1cKqSSFXALq82T/yI=
X-Received: by 2002:a19:dc5:: with SMTP id 188mr7302992lfn.513.1608569937971;
 Mon, 21 Dec 2020 08:58:57 -0800 (PST)
MIME-Version: 1.0
References: <20201221135206.17671-1-kai.heng.feng@canonical.com> <b761af6e0725a204d869a277af68aa4293be0e99.camel@linux.intel.com>
In-Reply-To: <b761af6e0725a204d869a277af68aa4293be0e99.camel@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 22 Dec 2020 00:58:46 +0800
Message-ID: <CAAd53p7Q4+5JWzhhTrOvjrqf-bND3xVuwTX9-8PsSkaGq7yoQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: int340x: Add critical callback to override
 default shutdown behavior
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Matthew Garrett <mjg59@google.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Peter Kaestle <peter@piie.net>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 12:55 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2020-12-21 at 21:52 +0800, Kai-Heng Feng wrote:
> > We are seeing thermal shutdown on Intel based mobile workstations,
> > the
> > shutdown happens during the first trip handle in
> > thermal_zone_device_register():
> > kernel: thermal thermal_zone15: critical temperature reached (101 C),
> > shutting down
> >
> > However, we shouldn't do a thermal shutdown here, since
> > 1) We may want to use a dedicated daemon, Intel's thermald in this
> > case,
> > to handle thermal shutdown.
> >
> > 2) For ACPI based system, _CRT doesn't mean shutdown unless it's
> > inside
> > ThermalZone namespace. ACPI Spec, 11.4.4 _CRT (Critical Temperature):
> > "... If this object it present under a device, the device’s driver
> > evaluates this object to determine the device’s critical cooling
> > temperature trip point. This value may then be used by the device’s
> > driver to program an internal device temperature sensor trip point."
> >
> > So a "critical trip" here merely means we should take a more
> > aggressive
> > cooling method.
> >
> > As int340x device isn't present under ACPI ThermalZone, override the
> > default .critical callback to prevent surprising thermal shutdown.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/thermal/intel/int340x_thermal/int3400_thermal.c     | 6
> > ++++++
> >  .../thermal/intel/int340x_thermal/int340x_thermal_zone.c    | 6
> > ++++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > index 823354a1a91a..9778a6dba939 100644
> > --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > @@ -431,9 +431,15 @@ static int int3400_thermal_change_mode(struct
> > thermal_zone_device *thermal,
> >         return result;
> >  }
> >
> > +static void int3400_thermal_critical(struct thermal_zone_device
> > *thermal)
> > +{
> > +       dev_dbg(&thermal->device, "%s: critical temperature
> > reached\n", thermal->type);
> > +}
> > +
> >  static struct thermal_zone_device_ops int3400_thermal_ops = {
> >         .get_temp = int3400_thermal_get_temp,
> >         .change_mode = int3400_thermal_change_mode,
> > +       .critical = int3400_thermal_critical,
> >  };
>
> You don't need for int3400 device. This is a fake sensor.

Thanks. Let me send a v2.

Kai-Heng

>
> >
> >  static struct thermal_zone_params int3400_thermal_params = {
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> > b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> > index 6e479deff76b..d1248ba943a4 100644
> > --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> > +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> > @@ -146,12 +146,18 @@ static int int340x_thermal_get_trip_hyst(struct
> > thermal_zone_device *zone,
> >         return 0;
> >  }
> >
> > +static void int340x_thermal_critical(struct thermal_zone_device
> > *zone)
> > +{
> > +       dev_dbg(&zone->device, "%s: critical temperature reached\n",
> > zone->type);
> > +}
> > +
> >  static struct thermal_zone_device_ops int340x_thermal_zone_ops = {
> >         .get_temp       = int340x_thermal_get_zone_temp,
> >         .get_trip_temp  = int340x_thermal_get_trip_temp,
> >         .get_trip_type  = int340x_thermal_get_trip_type,
> >         .set_trip_temp  = int340x_thermal_set_trip_temp,
> >         .get_trip_hyst =  int340x_thermal_get_trip_hyst,
> > +       .critical       = int340x_thermal_critical,
> >  };
> >
> >  static int int340x_thermal_get_trip_config(acpi_handle handle, char
> > *name,
>
> Thanks,
> Srinivas
>
>
