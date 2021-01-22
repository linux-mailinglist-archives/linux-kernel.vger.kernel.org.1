Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCC12FFEB9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbhAVIw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbhAVItu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:49:50 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29067C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 00:48:56 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id t17so3602115qtq.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 00:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jXtRz5P5W/sNW2EZxMRI+yoTb+xsvaED2GKSt1Q7BVw=;
        b=jBpP2O73AEtP8nQVJSXRU+oSvt0/GrLKn1SbytOVVXdVHbOwe0PkA9TNJ351FX/inC
         VIaVzMxtJqdA+U22h4KMr9o6I7yHYaV9fWaKGusV1enZtd7qTINNVRADSawIOnKk+j4h
         QTPwKSRhw739qy3ys9dP7XfZzW2xo0yqj6OoQR3nQ6n18bHgRyc8mgTBIEu/fL0dwP7h
         WQonC5V5pXHMAPprkvPPwPIrqBcSKI6QaYOxHyUOxeGsoqPBIbpYH4TmQ/regDBzCt+p
         xiYhVdCVrD3SMgnCZeRoJ3iHwYQATC71og7hpx9gOEOk3ms5bPnZLmhM0ZfZV2D89pgj
         Mixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jXtRz5P5W/sNW2EZxMRI+yoTb+xsvaED2GKSt1Q7BVw=;
        b=sdr2h+nLh0+BaQ36jT+bcwhEm+2pfuNF60AuJiKii5OvS9iVSxlsb6rSQIQoWmaXwU
         E8QSN5ng+qEVuJ8/UgNmqFHLSVduuJ8UAqlThX0V3Vr/P1O6VzOEg7U6pJnDGLPAaV7k
         /ymfWt29pXv8Zi5gWalZRSUec1Obr0xYlli41iD2fExrVxUBUWfM1ypFvj0f700MgNFX
         WM5tqojaJYmAavtSw6AqHyGdUQoPJq7FSiONO0A2G3GIiEXCscFDpFb1G8sIijUjqOX5
         JLX2625k2MOILtUHO+c0IYLse/NTGPlpq/YlgJ0+ptTF4DPX1H8brqfc052uyaW2nap0
         VDqA==
X-Gm-Message-State: AOAM530PA4ezpzTN9/CA02g56lkSrUyYkPxa9mtOL6X44qPLfuZSVPVi
        Eij5s0EN+AwRqqwNHAJ8v1yHEMiDhD5UZqSQ2cmBUA==
X-Google-Smtp-Source: ABdhPJynK/7lvwzYrLI1tkD5vMSNBlB7FasW6wV0uEQO7f4f8jYa6ZB55MUZqGMuD3aW4fT9nYrka3/ULmYNqZT/Bnk=
X-Received: by 2002:ac8:7111:: with SMTP id z17mr3354297qto.369.1611305335121;
 Fri, 22 Jan 2021 00:48:55 -0800 (PST)
MIME-Version: 1.0
References: <1610963802-11042-1-git-send-email-vjitta@codeaurora.org>
In-Reply-To: <1610963802-11042-1-git-send-email-vjitta@codeaurora.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 22 Jan 2021 09:48:43 +0100
Message-ID: <CAG_fn=V8NMcCNof5mekitjAepEZUb4zPHXNNYF+SSiuknuy-BQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] lib: stackdepot: Add support to configure STACK_HASH_SIZE
To:     Vijayanand Jitta <vjitta@codeaurora.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dan.j.williams@intel.com, broonie@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ylal@codeaurora.org,
        vinmenon@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 10:57 AM <vjitta@codeaurora.org> wrote:
>
> From: Yogesh Lal <ylal@codeaurora.org>
>
> Use CONFIG_STACK_HASH_ORDER to configure STACK_HASH_SIZE.
>
> Aim is to have configurable value for  STACK_HASH_SIZE,
> so depend on use case one can configure it.
>
> One example is of Page Owner, default value of
> STACK_HASH_SIZE lead stack depot to consume 8MB of static memory.
> Making it configurable and use lower value helps to enable features like
> CONFIG_PAGE_OWNER without any significant overhead.
>
> Signed-off-by: Yogesh Lal <ylal@codeaurora.org>
> Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
>  lib/Kconfig      | 9 +++++++++
>  lib/stackdepot.c | 3 +--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index b46a9fd..96ee125 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -651,6 +651,15 @@ config STACKDEPOT
>         bool
>         select STACKTRACE
>
> +config STACK_HASH_ORDER
> +       int "stack depot hash size (12 =3D> 4KB, 20 =3D> 1024KB)"
> +       range 12 20
> +       default 20
> +       depends on STACKDEPOT
> +       help
> +        Select the hash size as a power of 2 for the stackdepot hash tab=
le.
> +        Choose a lower value to reduce the memory impact.
> +
>  config SBITMAP
>         bool
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 2caffc6..dff8521 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -142,8 +142,7 @@ static struct stack_record *depot_alloc_stack(unsigne=
d long *entries, int size,
>         return stack;
>  }
>
> -#define STACK_HASH_ORDER 20
> -#define STACK_HASH_SIZE (1L << STACK_HASH_ORDER)
> +#define STACK_HASH_SIZE (1L << CONFIG_STACK_HASH_ORDER)
>  #define STACK_HASH_MASK (STACK_HASH_SIZE - 1)
>  #define STACK_HASH_SEED 0x9747b28c
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member=
 of Code Aurora Forum, hosted by The Linux Foundation
> 2.7.4
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
