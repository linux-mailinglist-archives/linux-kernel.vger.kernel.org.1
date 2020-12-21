Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437CD2DFD24
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 16:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgLUPBS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Dec 2020 10:01:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58116 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgLUPBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 10:01:18 -0500
Received: from mail-lf1-f71.google.com ([209.85.167.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1krMfr-0001kB-1p
        for linux-kernel@vger.kernel.org; Mon, 21 Dec 2020 15:00:35 +0000
Received: by mail-lf1-f71.google.com with SMTP id o16so11003114lfo.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 07:00:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2HrR4BVYQUvAjQoPfFaQYFukLKKNtMzMHVbjOUtWsik=;
        b=VrVt4Qx2a4VbzyHkqhL5exVu/DCB9hiZrc+5a0ReiHaknDI5G5lh8N385gX8GU1nTG
         HrTleFeQtYI7zZSBexxZn854XU2gpUddG7mIObI20I4wOde8iVXtUQ8j1g335rGGNIwm
         7E/HOnMrdTmEiTb9QXAECgX5N4uMJ98d0JAjx5ebi8hqIIsMnXW+m5ePNIn7NOZm5wK1
         EN8LK6Ksy1Rsnvvmr6dmssBPdyjPvwqqCoidOfqGEf0GrKiZMSHw3fvf2Bqwemi0BwZ0
         NFMVreQAdOCcV2fvTpxWte9xivgPKJPWtJsCP1Kt2TlVO+jBwpK6Yi0Lm54ESK3mTMek
         NNwg==
X-Gm-Message-State: AOAM530120oc14ArpS5PpywJENYnxZndmSghlofhIZOQBXXBHXG1GoiT
        6q56rPTyUJieoJ0AJLPDixOh1SctmPcETzgDl9XEoWOAaFXnvXS8zfrtx0bvQ7ZTpQjyqsY68El
        u2IdIB+AcaZW0ZhPYW/8pRw9bvvyJjw5rEWe0R6ZeNw4kHnxpPo/rocpNPA==
X-Received: by 2002:a19:c211:: with SMTP id l17mr6580973lfc.194.1608562834374;
        Mon, 21 Dec 2020 07:00:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx50x1wx97kIAOj7t2hLJfegJ6FqWVIBRMbXVvLJ3tTGGTBIikjyhrOMcur5cI0CsEFRRSdmp2dSZ8JNi8tmko=
X-Received: by 2002:a19:c211:: with SMTP id l17mr6580948lfc.194.1608562834034;
 Mon, 21 Dec 2020 07:00:34 -0800 (PST)
MIME-Version: 1.0
References: <20201221135206.17671-1-kai.heng.feng@canonical.com> <20e74dc1-1f1d-6dee-19a7-e9a975b66606@linaro.org>
In-Reply-To: <20e74dc1-1f1d-6dee-19a7-e9a975b66606@linaro.org>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 21 Dec 2020 23:00:22 +0800
Message-ID: <CAAd53p5WRVMgSquOC69Yq3DO+itSR44273bLWiF7wXUxFZMDhg@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: int340x: Add critical callback to override
 default shutdown behavior
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>, amitk@kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Matthew Garrett <mjg59@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
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

On Mon, Dec 21, 2020 at 9:59 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 21/12/2020 14:52, Kai-Heng Feng wrote:
> > We are seeing thermal shutdown on Intel based mobile workstations, the
> > shutdown happens during the first trip handle in
> > thermal_zone_device_register():
> > kernel: thermal thermal_zone15: critical temperature reached (101 C), shutting down
> >
> > However, we shouldn't do a thermal shutdown here, since
> > 1) We may want to use a dedicated daemon, Intel's thermald in this case,
> > to handle thermal shutdown.
> >
> > 2) For ACPI based system, _CRT doesn't mean shutdown unless it's inside
> > ThermalZone namespace. ACPI Spec, 11.4.4 _CRT (Critical Temperature):
> > "... If this object it present under a device, the device’s driver
> > evaluates this object to determine the device’s critical cooling
> > temperature trip point. This value may then be used by the device’s
> > driver to program an internal device temperature sensor trip point."
> >
> > So a "critical trip" here merely means we should take a more aggressive
> > cooling method.
> >
> > As int340x device isn't present under ACPI ThermalZone, override the
> > default .critical callback to prevent surprising thermal shutdown.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> I'll submit those changes for v5.11-rc1 and change the subject by:
>
> thermal: int340x: Fix unexpected shutdown at critical temperature
> thermal: pch: Fix unexpected shutdown at critical temperature
>
> Sounds good ?

Sounds good to me. Thanks!

Kai-Heng

>
> > ---
> >  drivers/thermal/intel/int340x_thermal/int3400_thermal.c     | 6 ++++++
> >  .../thermal/intel/int340x_thermal/int340x_thermal_zone.c    | 6 ++++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > index 823354a1a91a..9778a6dba939 100644
> > --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > @@ -431,9 +431,15 @@ static int int3400_thermal_change_mode(struct thermal_zone_device *thermal,
> >       return result;
> >  }
> >
> > +static void int3400_thermal_critical(struct thermal_zone_device *thermal)
> > +{
> > +     dev_dbg(&thermal->device, "%s: critical temperature reached\n", thermal->type);
> > +}
> > +
> >  static struct thermal_zone_device_ops int3400_thermal_ops = {
> >       .get_temp = int3400_thermal_get_temp,
> >       .change_mode = int3400_thermal_change_mode,
> > +     .critical = int3400_thermal_critical,
> >  };
> >
> >  static struct thermal_zone_params int3400_thermal_params = {
> > diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> > index 6e479deff76b..d1248ba943a4 100644
> > --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> > +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> > @@ -146,12 +146,18 @@ static int int340x_thermal_get_trip_hyst(struct thermal_zone_device *zone,
> >       return 0;
> >  }
> >
> > +static void int340x_thermal_critical(struct thermal_zone_device *zone)
> > +{
> > +     dev_dbg(&zone->device, "%s: critical temperature reached\n", zone->type);
> > +}
> > +
> >  static struct thermal_zone_device_ops int340x_thermal_zone_ops = {
> >       .get_temp       = int340x_thermal_get_zone_temp,
> >       .get_trip_temp  = int340x_thermal_get_trip_temp,
> >       .get_trip_type  = int340x_thermal_get_trip_type,
> >       .set_trip_temp  = int340x_thermal_set_trip_temp,
> >       .get_trip_hyst =  int340x_thermal_get_trip_hyst,
> > +     .critical       = int340x_thermal_critical,
> >  };
> >
> >  static int int340x_thermal_get_trip_config(acpi_handle handle, char *name,
> >
>
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
