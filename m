Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A276F2F1AC9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388904AbhAKQTT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Jan 2021 11:19:19 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48767 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388317AbhAKQTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:19:18 -0500
Received: from mail-lf1-f72.google.com ([209.85.167.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kyztr-0006IC-DQ
        for linux-kernel@vger.kernel.org; Mon, 11 Jan 2021 16:18:35 +0000
Received: by mail-lf1-f72.google.com with SMTP id j10so38356lfr.17
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 08:18:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QSqkKRZu26GCq17LFYjiY2ul8ARiOTfBagByL2HFx3g=;
        b=Tx1TpX6gCpQE4fdYsa1w7nVQjFxuUUuaITJx3qpdu4TgzfOLMoC+F8dOaYFJdXijp1
         E1uHd36FOHv5II6o0pSQtdxFFN73gncGcL9Ymp9EP0lCdZeo5Z7IUSkZE+afhjh+e0yF
         gYkzyA3lyFe6nLIWPtfEVhfL06RvM5WC7U8O0ACSV+6k4sN5Iuxx+g5tsoUh0tvssRHj
         Xvd9hZLFe2B5i1+jcVTEH8q9bL+tUfJi66jYVFlYE4PmnK1xiAtaOgVo+zU+LlJbh/nT
         4SD9rzvZvou2m3Q2q2idj15/hz+kb2n+x61/YtQmGy0R2G87MA9rH0qStoRUxbTfJAzC
         q80w==
X-Gm-Message-State: AOAM530TSt9029QFkj8yEYEoxm5Rk19bPKdnrC+kgE6TQbaRhd/gTYtg
        +4KXEHaozXh5U8joDRkvNJbcIQcrgY1u0ierQv1Jh0wnilVCHOhKE3E645KMf/8DK0VDF+k/XDC
        OO/RfLyq38FuTxBJrTPEZTiO33tC2HYuBrJ2dR9WbrYxN/84VMr72HUHJ5Q==
X-Received: by 2002:a19:8316:: with SMTP id f22mr162678lfd.10.1610381914744;
        Mon, 11 Jan 2021 08:18:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsdHIjLUFOwRzaXVfJOE36S6JTG6SqT0SD/RsPIbwTIGbbcEjPtyJw3wGgwjs/zd4YWX4cKrfdEakC/yNfvAw=
X-Received: by 2002:a19:8316:: with SMTP id f22mr162664lfd.10.1610381914451;
 Mon, 11 Jan 2021 08:18:34 -0800 (PST)
MIME-Version: 1.0
References: <20201221172345.36976-1-kai.heng.feng@canonical.com>
In-Reply-To: <20201221172345.36976-1-kai.heng.feng@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 12 Jan 2021 00:18:23 +0800
Message-ID: <CAAd53p6Yn2n-oBVk026nf3oZ7y+_7NFtywQe3PBhTr=3Lo7-Bg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] thermal: int340x: Fix unexpected shutdown at
 critical temperature
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Matthew Garrett <mjg59@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 1:23 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> We are seeing thermal shutdown on Intel based mobile workstations, the
> shutdown happens during the first trip handle in
> thermal_zone_device_register():
> kernel: thermal thermal_zone15: critical temperature reached (101 C), shutting down
>
> However, we shouldn't do a thermal shutdown here, since
> 1) We may want to use a dedicated daemon, Intel's thermald in this case,
> to handle thermal shutdown.
>
> 2) For ACPI based system, _CRT doesn't mean shutdown unless it's inside
> ThermalZone namespace. ACPI Spec, 11.4.4 _CRT (Critical Temperature):
> "... If this object it present under a device, the device’s driver
> evaluates this object to determine the device’s critical cooling
> temperature trip point. This value may then be used by the device’s
> driver to program an internal device temperature sensor trip point."
>
> So a "critical trip" here merely means we should take a more aggressive
> cooling method.
>
> As int340x device isn't present under ACPI ThermalZone, override the
> default .critical callback to prevent surprising thermal shutdown.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

A gentle ping...

> ---
> v2:
>  - Amend subject.
>  - Remove int3400 device.
>
>  .../thermal/intel/int340x_thermal/int340x_thermal_zone.c    | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> index 6e479deff76b..d1248ba943a4 100644
> --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> @@ -146,12 +146,18 @@ static int int340x_thermal_get_trip_hyst(struct thermal_zone_device *zone,
>         return 0;
>  }
>
> +static void int340x_thermal_critical(struct thermal_zone_device *zone)
> +{
> +       dev_dbg(&zone->device, "%s: critical temperature reached\n", zone->type);
> +}
> +
>  static struct thermal_zone_device_ops int340x_thermal_zone_ops = {
>         .get_temp       = int340x_thermal_get_zone_temp,
>         .get_trip_temp  = int340x_thermal_get_trip_temp,
>         .get_trip_type  = int340x_thermal_get_trip_type,
>         .set_trip_temp  = int340x_thermal_set_trip_temp,
>         .get_trip_hyst =  int340x_thermal_get_trip_hyst,
> +       .critical       = int340x_thermal_critical,
>  };
>
>  static int int340x_thermal_get_trip_config(acpi_handle handle, char *name,
> --
> 2.29.2
>
