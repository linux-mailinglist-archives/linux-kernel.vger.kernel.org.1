Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A322D4052
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgLIKvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 05:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgLIKvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:51:03 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D012C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 02:50:23 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id h18so872779otq.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 02:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MX94nPIGSLB0DB1OT3/FAuNxRnHj49zF47rxa5iMU8o=;
        b=W7Tqu+ygMoLsbJuO8fIJ3Z4pUGKQ2nCjJL/PMN6uV27pkBIEghs5/4aKrZkPIhxlnE
         tYU9pi13MA2tIpLp65o3E+DOUWuw9ZneMAFSav0QKfw7sBoxe+CPDwX/iOtU/nwGB4by
         n+g51nPMhIgQ05m5INhaLTDqXHcZyviSwwFkeuOkJEcW9A6zC9Yn8ukI5fDwVMk2QqMT
         41N8GA8j/K0ahPhpMmNqbuMGiK584SloMWNp57GQaNaiCG/vPOhLzPC/NXYfFDnq1K/l
         3jkj8xtceGt8gojg6AGzP98X70ZQozsZJTZ9sW73QqG1YwdLURteTj/kzL5PUHiN4q/s
         Z7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MX94nPIGSLB0DB1OT3/FAuNxRnHj49zF47rxa5iMU8o=;
        b=dvQOjaKI+FGAzpHcOkykc53L3FhCZ8p5Cmlvmgo7tqA12RzhxYOolmLflc1WBGzagY
         b4FvBZdSfcSzn673icUfcJqGIqfyk81Ss7/VDno7Od3bPzaMRb5FWW/eXJXUiV+AGgiA
         N4fDFCIc6dtT3gUC3ScKFKpa+FZOHrB23t7VTlagC0FdJY1wISwPB3ttuv0zMh13/XoD
         IpefvY1Tcaxv1BqtvTTTeLaFTeov7QlbBWXIO5SF9O/W1kgl/OZ6d3htk5FqXoUhUlZv
         TcQ1bLwAinlBxLq4e1ncyhy8NjkNOknGWzF8I5PzrG38aCXxUsXIGqPd+zADFGm8mgkC
         753g==
X-Gm-Message-State: AOAM5333tEewiLosUSciZp3YZw+z9fLuwMhZQyImpevEZf2YYVedyn0z
        5r5O0e6cishuN1dDa2Vnum2W3hoz5XacZujzngiv8A==
X-Google-Smtp-Source: ABdhPJwYF4a+AnOIU1i+Ui7MeZtCnCDQDRBoESBnuKWFpsyVHgeWmSWYC8U7DsgT974c6UPATBxTWO98mTgDzhaBjLg=
X-Received: by 2002:a9d:7cc8:: with SMTP id r8mr1180342otn.233.1607511022660;
 Wed, 09 Dec 2020 02:50:22 -0800 (PST)
MIME-Version: 1.0
References: <20201209100152.2492072-1-dvyukov@google.com>
In-Reply-To: <20201209100152.2492072-1-dvyukov@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 9 Dec 2020 11:50:11 +0100
Message-ID: <CANpmjNNpZWAKeeWSwkNX6=Ngr9W0bk3oEdpHN2i41BHzc7LkpQ@mail.gmail.com>
Subject: Re: [PATCH] kcov: don't instrument with UBSAN
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Dec 2020 at 11:01, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Both KCOV and UBSAN use compiler instrumentation. If UBSAN detects a bug
> in KCOV, it may cause infinite recursion via printk and other common
> functions. We already don't instrument KCOV with KASAN/KCSAN for this
> reason, don't instrument it with UBSAN as well.
>
> As a side effect this also resolves the following gcc warning:
>
> conflicting types for built-in function '__sanitizer_cov_trace_switch';
> expected 'void(long unsigned int,  void *)' [-Wbuiltin-declaration-mismatch]
>
> It's only reported when kcov.c is compiled with any of the sanitizers
> enabled. Size of the arguments is correct, it's just that gcc uses 'long'
> on 64-bit arches and 'long long' on 32-bit arches, while kernel type is
> always 'long long'.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>

Acked-by: Marco Elver <elver@google.com>


> ---
>  kernel/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/Makefile b/kernel/Makefile
> index aac15aeb9d69..efa42857532b 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -34,8 +34,11 @@ KCOV_INSTRUMENT_extable.o := n
>  KCOV_INSTRUMENT_stacktrace.o := n
>  # Don't self-instrument.
>  KCOV_INSTRUMENT_kcov.o := n
> +# If sanitizers detect any issues in kcov, it may lead to recursion
> +# via printk, etc.
>  KASAN_SANITIZE_kcov.o := n
>  KCSAN_SANITIZE_kcov.o := n
> +UBSAN_SANITIZE_kcov.o := n
>  CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack) -fno-stack-protector
>
>  obj-y += sched/
> --
> 2.29.2.576.ga3fc446d84-goog
>
