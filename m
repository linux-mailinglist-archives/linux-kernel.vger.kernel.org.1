Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670932C815A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgK3JrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgK3JrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:47:00 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21075C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 01:46:14 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id h19so10734074otr.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 01:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=saU5YHYiO2GIaSl/3Zw11N1b7GsRSTY1ffZgL4esVvs=;
        b=el7JSSV5QZxIfijqbbnl11ib4rMEFtqwxoz/6xtKh3VzxaNLdQxv8Trhvyffall+mc
         /hzCHxbPBY8l0qi7Lm3gA7XSx5YxrCRsEqYkUPV4cAVKL8qhOPrHfXusY4l/WT58/XH1
         XRSU7uLwSJYeomMFOWb88ExDLdIpgYP/f2FdchcUfS3mQeX6Zxd2yxwLX+RwmvK+WQK0
         YPssSvCZyQMZtU6aSSVksl0wOSovIOUOimW5/SUQ6bPTb5DvwRgX1jEMtlkZ9uc5kbBA
         nWJXnv5j69i0NYjALq53Sdhxptjql86KLDBnlHY24ERGQnLalioGKg8B8B4LPHbYJasR
         6/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=saU5YHYiO2GIaSl/3Zw11N1b7GsRSTY1ffZgL4esVvs=;
        b=opvRdajxFkLreLKMDDP2ihXZE8F3vrn0OntMjS8HX6L3Fex42ysyLkcrrL3oNnQOo4
         JLddIf8uAtG+JGMp807WAztxrssB3dCsM6/KV5wSpQhq3o6ti5a5Zz+cwMvTRa1Hu3DH
         IxLWYpZwTEQgiGzXZqLcn1+/hsHwnCHZdcNkUQ3BhcjMGDsIe+rHh1/w/zswt6xWfm4n
         w3kiyte79GRwVoHcEMERxY38pvV/HKajhbiyTWtGIuN7otrfdWxwnKHMKT9bvbQPq4Z1
         eXcUzi9kATEvIrSaLSMsrCFRowHjV/FidKvRBQxHCcal1XQ3Vj2ITbpvSfDOZHW9V3ye
         U6/g==
X-Gm-Message-State: AOAM533jZr9yN01TkZ/I5vrURtECEdJ4MO3dnlZU4cXWjGH4UZ1/yebm
        rsMqwCK/1p7jvOP5bIUwV2BgVD379dMRJNpPwrkpFA==
X-Google-Smtp-Source: ABdhPJworGpcKcN2zxtTdOslqa5S1l40qXVdU08nh5mHV3UOA+O6m/LY77ZyYtejjvXAnrn4vN1O2C6WlJEjh+FV3Zo=
X-Received: by 2002:a9d:7d92:: with SMTP id j18mr16060269otn.17.1606729573128;
 Mon, 30 Nov 2020 01:46:13 -0800 (PST)
MIME-Version: 1.0
References: <35126.1606402815@turing-police>
In-Reply-To: <35126.1606402815@turing-police>
From:   Marco Elver <elver@google.com>
Date:   Mon, 30 Nov 2020 10:46:01 +0100
Message-ID: <CANpmjNObtKCG3PPdDRrFczHU3wUnybTqp-F2tMx4CB1T+bThwg@mail.gmail.com>
Subject: Re: [PATCH] kasan, mm: fix build issue with asmlinkage
To:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 at 16:00, Valdis Kl=C4=93tnieks <valdis.kletnieks@vt.ed=
u> wrote:
> commit 2df573d2ca4c1ce6ea33cb7849222f771e759211
> Author: Andrey Konovalov <andreyknvl@google.com>
> Date:   Tue Nov 24 16:45:08 2020 +1100
>
>     kasan: shadow declarations only for software modes
>
> introduces a build failure when it removed an include for linux/pgtable.h
> It actually only needs linux/linkage.h
>
> Test builds on both x86_64 and arm build cleanly
>
> Fixes:   2df573d2ca4c ("kasan: shadow declarations only for software mode=
s")
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

Reviewed-by: Marco Elver <elver@google.com>

Probably want to add

  Link: https://lore.kernel.org/linux-arm-kernel/24105.1606397102@turing-po=
lice/

for more context, too.

Thanks,
-- Marco



> ---
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 83860aa4e89c..5e0655fb2a6f 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -12,6 +12,7 @@ struct task_struct;
>
>  #ifdef CONFIG_KASAN
>
> +#include <linux/linkage.h>
>  #include <asm/kasan.h>
>
>  /* kasan_data struct is used in KUnit tests for KASAN expected failures =
*/
>
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/35126.1606402815%40turing-police.
