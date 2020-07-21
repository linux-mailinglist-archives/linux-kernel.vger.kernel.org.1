Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C408E227F14
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 13:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgGULi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 07:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbgGULiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:38:55 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65A2C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:38:55 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id l63so16871857oih.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XOhre4ZHelqkJXjHEO2dPt7iyuhKP/1N5Dw7QY91fhU=;
        b=JHsLseT2lcOz/wruVfkrp8wMLl+43nlJXYK7JdegsYA+RVPY6H0Jio3fPGB98+EagD
         m/0Ni/9S2R2Ji6aP1KQoUFflkAW1BmIIF5lqKw4XKW8TJhKtk48jkv++Bp1iNgQSCc8J
         joC2vl/h9vcChIhQh20daK93PZzlYdG2Uoy3lKecQfltGAihu4GsDXV0CcQjRqmwC3Ib
         EQCS//pZBun3NARTZyMPHxAvhqXJheNkA01TrAnu6dc4MyIWuBRlimpyn+5qq8N2QgEY
         KTXVt3Wpq0uBhuDh4RHQvVETUZvFxu00ef8QIrJXEY1qQB2sO8OD/R5I1Q06UDA7PaHt
         yI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XOhre4ZHelqkJXjHEO2dPt7iyuhKP/1N5Dw7QY91fhU=;
        b=Lb50hhkocEfSnCuHyeTZvmzIWrgypc0K/3SqsmUPSDUvO2p9jfUcgumhhN5ayhlMtA
         0Nu33M7tAGVpm0UN67D6N63wA/B0XcTiK8e5mVyRwdPZrAc2axzhGOnHNTAq90yiF0pV
         l6AcO7hoyQX1rfk7d6d/RoD6FDIFVPVAdsHmo9BiYPF/j+OGmnh6yV5SulUl3oVM8LZP
         KYSwJpYKC45r//tkcJT/UwGdRnaTJLa6QVgLrzZaYOG/HqX4UC0tMj5iGXqszg/cJwJM
         g4sTWUTGXbXKtjVE0wefdIXEoxjhGQeUIlIT47Me3Vu+RdF6gZ7+ZFdnDZlVIhqtPDy2
         CZIg==
X-Gm-Message-State: AOAM531ZICDZYgIAr/BqLH5DLNbzGVzLdJwW9q4rZbiQxk1v5GdWKBKe
        ZXh6wh9xs5ssO86l5Lp0Swc7YcjLvRtkeG9Me0F8FKyKbl8=
X-Google-Smtp-Source: ABdhPJxFwYu6SrIg4V12JQtp21MW3IZ5RBPtuiqb6W7CwGZo2dqkCKnw0N6uPxlLenEN/goCufv9QU+rne1xWRgmz+Y=
X-Received: by 2002:aca:5007:: with SMTP id e7mr2706577oib.70.1595331534816;
 Tue, 21 Jul 2020 04:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <14089ca5568d214295b2028b59fcd630c7adb0e2.1595331056.git.andreyknvl@google.com>
In-Reply-To: <14089ca5568d214295b2028b59fcd630c7adb0e2.1595331056.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 21 Jul 2020 13:38:43 +0200
Message-ID: <CANpmjNOTPLzRoODvg7zab-tkOH0B67OiDj61x4J-33zBbBtWgw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add KCOV section
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 at 13:34, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> To link KCOV to the kasan-dev@ mailing list.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d53db30d1365..eec0b687eb08 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9305,6 +9305,15 @@ F:       Documentation/kbuild/kconfig*
>  F:     scripts/Kconfig.include
>  F:     scripts/kconfig/
>
> +KCOV
> +R:     Dmitry Vyukov <dvyukov@google.com>
> +R:     Andrey Konovalov <andreyknvl@google.com>
> +L:     kasan-dev@googlegroups.com
> +S:     Maintained
> +F:     Documentation/dev-tools/kcov.rst
> +F:     include/linux/kcov.h
> +F:     kernel/kcov.c

I think this is missing:

F: include/uapi/linux/kcov.h
F: scripts/Makefile.kcov

Thanks,
-- Marco
