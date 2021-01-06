Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176E32EBA4A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 08:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbhAFHAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 02:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbhAFHAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 02:00:45 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D7FC06135A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 23:00:04 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id r17so2216020ilo.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 23:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvAtj6g3Q+bFh2gqVmkNrIV1rKAULT0R8CK6XxEOGiQ=;
        b=FBsrHN6rOndEcUakiNZaNyhbcqU/eoPuQlebyjI/hoSV0QJygMaSfWtoubM84cSgPG
         Y+mw8GQwZT5MZ4ih+Cv5yxc+Em7aVeu7GPIU3Y2Pfe+WpAfJA8jB0+gnwe+1iXNeNtD7
         6hBEaIzk1IuzgvGSdcUF2b6Dt99Q8BKq2vGm3bkzkISfc4Wn+EJjWUH6Hd3g+b/F7sPO
         G7bKIHaLFVtXQqKpz6yQHHOn5LtAwYEqLxRvnNT/NZXxatgb5VTmlSPHLvLYOvpKJMHw
         jpHEAw16420EL0BUgs3jtWojeEyn3NUrSVmbrS+eybrYlRTgFl2REO26Xagr6HYwRLLX
         khOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvAtj6g3Q+bFh2gqVmkNrIV1rKAULT0R8CK6XxEOGiQ=;
        b=VPQM3OwVv3VAk9rQ3A2XhfJu+I8QrrSx0D0JgXuxZ+KCvnx64CZti099EFsBWX8GjC
         jyNtCQBTYNc5rlrwo2y39wG7Ee9dcm8DcxZ8SrWGADTbek6IHiGTr1kgpknjqQtm/A0Q
         FnXzSzPrAY03G92vYJ0x48JzSIzAxedIESOFw+1p+p3lMX7bja75wakwYDHJCWLt+kL/
         Mo/RX3VNXIaimVT+WX0Ob6CCdWlfdmEjUYAz1Ow9NImQeq+PE0eccUxzRg65MAMem5PF
         ejevbDMMdsaEL8y78WKDFjgwsv/yPPOe1n5zQPdGkKxxuh9GRFL2UHbpD0E3WOsec2i1
         AUVA==
X-Gm-Message-State: AOAM531PHi1RU/s9zopFqcAn0nNHMR/5yiuSQFTIyR76Tfg5bTbKOvPM
        5Q07C7oTY40Ujy+PglXMX4kRIRcRyEyxrWVJdDE=
X-Google-Smtp-Source: ABdhPJzBuHuyVoQmfezTuT6CGi0WyqbUkNQhnqtW4ffAeO1KIGMYfSbYW4hul2ED3qDzPFgcY+pk0PFLNNmzsHe9xGI=
X-Received: by 2002:a05:6e02:12e4:: with SMTP id l4mr3000362iln.252.1609916403987;
 Tue, 05 Jan 2021 23:00:03 -0800 (PST)
MIME-Version: 1.0
References: <20210106004850.GA11682@paulmck-ThinkPad-P72> <20210106004956.11961-3-paulmck@kernel.org>
In-Reply-To: <20210106004956.11961-3-paulmck@kernel.org>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 5 Jan 2021 22:59:52 -0800
Message-ID: <CAAH8bW_-TVmfXspHXgW8MkcacZUiVYA+RTC72R0WookJUW=1SA@mail.gmail.com>
Subject: Re: [PATCH RFC cpumask 3/5] cpumask: Add a "none" alias to complement "all"
To:     paulmck@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 4:49 PM <paulmck@kernel.org> wrote:
>
> From: Paul Gortmaker <paul.gortmaker@windriver.com>
>
> With global support for a CPU list alias of "all", it seems to just make
> sense to also trivially extend support for an opposite "none" specifier.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.rst | 6 ++++++
>  lib/cpumask.c                                   | 5 +++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
> index cdf4e81..7dd1224 100644
> --- a/Documentation/admin-guide/kernel-parameters.rst
> +++ b/Documentation/admin-guide/kernel-parameters.rst
> @@ -76,6 +76,12 @@ is equivalent to "foo_cpus=0-N" -- where "N" is the numerically last CPU on
>  the system, thus avoiding looking up the value in "/sys/devices/system/cpu"
>  in advance on each deployed system.
>
> +        foo_cpus=none
> +
> +will provide an empty/cleared cpu mask for the associated boot argument.
> +
> +Note that "all" and "none" are not necessarily valid/sensible input values
> +for each available parameter expecting a CPU list.
>
>  This document may not be entirely up to date and comprehensive. The command
>  "modinfo -p ${modulename}" shows a current list of all parameters of a loadable
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index 9f8ff72..7fbcab8 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -110,6 +110,11 @@ int cpulist_parse(const char *buf, struct cpumask *dstp)
>                 return 0;
>         }
>
> +       if (!strcmp(buf, "none")) {
> +               cpumask_clear(dstp);
> +               return 0;
> +       }

Same comment as to the patch 2. Also, what if a user wants to stack ranges
like 'all, 1-3, none'? As far as I understand current implementation,
cpu_parselist
will pass new keywords to bitmap_parselist() which will fail to parse it.

If you think of new extensions as special case keywords which should not be
mixed with traditional region descriptors, I'm OK with that. But it should be
explained in documentation. I think it's better to handle 'all' and 'none' in
bitmap_parse_region().

The parselist() supports partially used groups with the notation like:
0-1023:2/256 ==> 0,1,256,257,512,513,768,769
I think it's worth making sure that new keywords work with groups smoothly,
otherwise mention in documentation that they don't.

>         return bitmap_parselist(buf, cpumask_bits(dstp), nr_cpumask_bits);
>  }
>  EXPORT_SYMBOL(cpulist_parse);
> --
> 2.9.5
>
