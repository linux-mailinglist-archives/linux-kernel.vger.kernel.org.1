Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D502DF868
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 05:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgLUEwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 23:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgLUEwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 23:52:24 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D41C061282
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 20:51:05 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id w6so5802737pfu.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 20:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFwj2LZf4TLQNNH65N7opFkGsQwhxBKDS8aHDIPcOm8=;
        b=Nx1V9KdO5Yrw/1AStKJgg12eyjQZaE/VM2l4IUPDMCSpTpVMKRmXM0iFPUktL57Pe/
         I3mGg6dBvaiJTbJtwP7lrCK0+R19rnLx+61KDrFPv5E8wQEabMMoJwJoFBC/KPZXem/g
         E2ekJgj5EI4SJ4fdSSzm4kPBp+h7+IVYOwoFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFwj2LZf4TLQNNH65N7opFkGsQwhxBKDS8aHDIPcOm8=;
        b=gBXiQirsQ20jti23yKHfiQR6p5C+2hvaqm/btvI6AUEmCo2fJL93dTAzbtff16PMOF
         Wf/bfOkgzqAoXg0kRtDz1tTuYqsHFDqeUoRJb6DFOEj9gRmDWcoWkiopASq+evmhBXBZ
         QK6NVudcrn2id+8coNLQTS7kOX2nD6aMq/7lxj4ArK4EUaRRXcQ2ggJWTwnN2H9nlsRB
         NtOcrFk/3hLpdScVp9hJQDn2Ga3tV2+6/z3bH/kj81CH03QKAJ/cdX/6pJ01tyCH5KuB
         NE8ATNwBS0NIun62crUaqeqX6eaPCAxdfnWrQbdbe6e3ONnDFvqgBaZLxNKsjlvmxV6+
         JgiA==
X-Gm-Message-State: AOAM5321+9ObRMQ9Y7HEQDoGk7PcUnx7xOe45IIHaSqgPJqHwFDD5kGB
        l81Mt8JQ+Pl0s3/M4Ose2w9/fBCG/E0cs3vG8YRaFtZ6aYc=
X-Google-Smtp-Source: ABdhPJw4EvQ8YAcdeno25kx2F7wcU4ii766MTfu6d3ULxpmbq85YOz8LMcEk6T+b8ZRQRDbyOIdk9NUQmpGglZn606I=
X-Received: by 2002:a05:6e02:102f:: with SMTP id o15mr13978956ilj.142.1608501928572;
 Sun, 20 Dec 2020 14:05:28 -0800 (PST)
MIME-Version: 1.0
References: <20201220015057.107246-1-maxwell.leiter@gmail.com>
In-Reply-To: <20201220015057.107246-1-maxwell.leiter@gmail.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 20 Dec 2020 14:05:17 -0800
Message-ID: <CAJCx=gm2hbfRePezjEh14a=DENX2dj8gc+SW8T-1NDWQY4eSTg@mail.gmail.com>
Subject: Re: [PATCH] iio:light:apds9960 add detection for MSHW0184 ACPI device
 in apds9960 driver
To:     Max Leiter <maxwell.leiter@gmail.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        blaz@mxxn.io, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 19, 2020 at 5:51 PM Max Leiter <maxwell.leiter@gmail.com> wrote:
>
> The device is used in the Microsoft Surface Book 3 and Surface Pro 7
>
> Signed-off-by: Max Leiter <maxwell.leiter@gmail.com>

Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  drivers/iio/light/apds9960.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index 9afb3fcc74e6..20719141c03a 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -8,6 +8,7 @@
>   * TODO: gesture + proximity calib offsets
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> @@ -1113,6 +1114,12 @@ static const struct i2c_device_id apds9960_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, apds9960_id);
>
> +static const struct acpi_device_id apds9960_acpi_match[] = {
> +       { "MSHW0184" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, apds9960_acpi_match);
> +
>  static const struct of_device_id apds9960_of_match[] = {
>         { .compatible = "avago,apds9960" },
>         { }
> @@ -1124,6 +1131,7 @@ static struct i2c_driver apds9960_driver = {
>                 .name   = APDS9960_DRV_NAME,
>                 .of_match_table = apds9960_of_match,
>                 .pm     = &apds9960_pm_ops,
> +               .acpi_match_table = apds9960_acpi_match,
>         },
>         .probe          = apds9960_probe,
>         .remove         = apds9960_remove,
> --
> 2.29.2
>
