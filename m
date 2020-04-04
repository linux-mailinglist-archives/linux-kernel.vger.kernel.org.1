Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D45FB19E342
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Apr 2020 09:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgDDHaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Apr 2020 03:30:23 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33095 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDDHaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 03:30:23 -0400
Received: by mail-vs1-f67.google.com with SMTP id y138so6504597vsy.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 00:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rLKw0j4e8cM++VecaXqVoyCRWYlR8riFPH4j0L9GKm8=;
        b=yrPXX12NU33LLRZX0I+Lkdx8HCZl7h2xps4J7Zxw1zVIdbv0I13PhJzDq+iN+/m8YI
         7H7Np4soI9q3hXbEouKI6BYaEw01pjYHwpYL3gSBxdYt01BPYNnGf2FvmjsujzqCuLGG
         zX9Qt/BoadI+avXcZDNtU0gDYLf6nx+uEYCuVqQP4GZMhypayG0c5kotCV/TwLTKAJp2
         YP1AbpkMzMpUez4Yis+n/bHOiQ6WJ0quaPIwU4NRdforJBgQPHkOMrLxcMGrgNkG08gL
         m85BXQ8VgZQvrzvvMWbT4+FOOjK0q+tGLJf1393vCCVhlNEMuXov1J9BPwwvp2Ua+Gtp
         IbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rLKw0j4e8cM++VecaXqVoyCRWYlR8riFPH4j0L9GKm8=;
        b=OoVWWv5TO57bOtNFx7Ndbir+ryGaKozWsWvR/G7Cli3KQ0n9QbYvWLwxaTaZ6AsHEB
         SGYHyn5mfGFoW+w1vA1Nbm3nXIYCATfMJ7aWk+0xcma4CxNe7dSQC5lu8dzVrK+mXH9K
         cLHKpWChjUbMLFb1PLJJJ8HY7zuD0f71NAbyN0wQKzDUzuJG8eYMTq7AyHkwwoVfg7VB
         hhGFKHlgM54ICdLGlPFczjEOxsZ3Dcy/6S1jJPf9W3WAFsAqWOcIR7SDsdbhX3JDLiB9
         ukzuOLel9wlswgiBtwcjj4UGsdFauMj9Xln2XNnXACHtMSl6xwOb8L3Ha3LvVaZ3GVAH
         aW/A==
X-Gm-Message-State: AGi0PuZUN3ljBROTNVrVJSg2eGAvNNeV/V2RxjrWXkUspetDeUDSK5iy
        ifd8vHT+ozeWIanvkVe66otFRk0yIE8Grl9xoAMx7w==
X-Google-Smtp-Source: APiQypJGdsYZ/Q7gvsr3gin/7kgyODfutYwezf//4l99Pcky8HuoNRacQVMTbNUEtaXsc45eyd8Gcx4m8mSfIaTuZLo=
X-Received: by 2002:a67:b147:: with SMTP id z7mr9273804vsl.27.1585985420583;
 Sat, 04 Apr 2020 00:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200402142747.8307-1-daniel.lezcano@linaro.org> <20200402142747.8307-9-daniel.lezcano@linaro.org>
In-Reply-To: <20200402142747.8307-9-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Sat, 4 Apr 2020 13:00:00 +0530
Message-ID: <CAHLCerOmjUZ_H+99hDP6Pi=2Bo3Rnt5KLmeZRt0kYuV=cTtUYg@mail.gmail.com>
Subject: Re: [PATCH V2 9/9] thermal: Remove thermal_zone_device_update() stub
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 7:58 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> All users of the function depends on THERMAL, no stub is
> needed. Remove it.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  include/linux/thermal.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 7b3dbfe15b59..216185bb3014 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -426,9 +426,6 @@ static inline struct thermal_zone_device *thermal_zone_device_register(
>  static inline void thermal_zone_device_unregister(
>         struct thermal_zone_device *tz)
>  { }
> -static inline void thermal_zone_device_update(struct thermal_zone_device *tz,
> -                                             enum thermal_notify_event event)
> -{ }
>  static inline struct thermal_cooling_device *
>  thermal_cooling_device_register(char *type, void *devdata,
>         const struct thermal_cooling_device_ops *ops)
> --
> 2.17.1
>
