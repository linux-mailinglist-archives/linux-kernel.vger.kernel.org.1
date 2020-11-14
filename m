Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B792F2B2C2E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 09:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgKNIp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 03:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgKNIp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 03:45:59 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AC2C0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 00:45:59 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id v92so10981633ybi.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 00:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=op2C800ARp9sbr32nwbThxJcHlPPHMUogYW3FSfyNUI=;
        b=jdx4Oq3I1C41TMBGJPOCec85dAdnbM+NlyiyForMxVFAzjRKl4mVnSfK9AAIhLPbcR
         jtIN+BWgEBOzOTp7CFWwG2fWbIRAlzrygC4eXDxqROZ0pSbN+RnAjWEtA71KErqnirLX
         cAF3sM9ozkBvaEw+BSXknb1huXBZDFVRWHXkluhVrCTHH0KJloo/daOdw7Z8ShpSa3ss
         qDmR/HXDumNVli/XoZ5SwwmhtgWWd/+LelnDFqHwoXBbowx10wHOgreXzw367Jvf3rsj
         CfpDxGn5tFpGsbOMDQFZ8jpuzQ4Th6mT5pJKnvzk9dOwrF7HZD03cfEarornN5S/JPje
         aNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=op2C800ARp9sbr32nwbThxJcHlPPHMUogYW3FSfyNUI=;
        b=UYN1gXUlBAAzOXrPkxbv5y4jDdxuBBTreJG9ZYQAyc9s/HXvmSQsXtlROxl1bB4EHr
         VI9j5pHV4Aty7SeZgeDnzQc/auC2PwnfYYbd0h1+AV+cE+Zj2Ebtgihex/sRdR93QRO0
         DCNOVpoOCdfoMUuMDT3tNhzSl6Bn1/0+jy1S5U5b7sfeaO/JUyaGD2C993JHgn+l3PpO
         bNujGmWwRME07g17K5R9h0sAgaKcNVQIXn8c0OIij3Wj16ktjbnc6juvtMkZB9NAlghe
         9418slyDrsfb6s1sCONcXaXozxbNBSqBGxqadkCNRxkM1YUtXwXc5yYreGStrBE+GZKT
         dkZQ==
X-Gm-Message-State: AOAM533vr3vJC3DxxYRq0vfrmiCbpZgnZUHE6vn+7J2+F+ckX7+xvrh0
        OoiyE2NEGm/X8BkUluC/+Gww3nlWEX1XbxjLxIbFkWcvxcW5dA==
X-Google-Smtp-Source: ABdhPJxOJUFMn/HQCSd01O/yEMb4wtNixVoRONUbiD3lvgK47SfLlkZzVyj+VJeSzTzNRYvZzLsoOhMwfb/37bgqADc=
X-Received: by 2002:a25:bcc7:: with SMTP id l7mr7316590ybm.115.1605343558506;
 Sat, 14 Nov 2020 00:45:58 -0800 (PST)
MIME-Version: 1.0
References: <20201114000803.909530-1-irogers@google.com>
In-Reply-To: <20201114000803.909530-1-irogers@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 14 Nov 2020 09:45:47 +0100
Message-ID: <CANiq72m=OK2bF2Nc-ht=ibNa2m6RcBCjFuhrv9kyoxE6yaMqVA@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix dwarf unwind for optimized builds.
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 1:08 AM 'Ian Rogers' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> To ensure the stack frames are on the stack tail calls optimizations
> need to be inhibited. If your compiler supports an attribute use it,
> otherwise use an asm volatile barrier.
>
> The barrier fix was suggested here:
> https://lore.kernel.org/lkml/20201028081123.GT2628@hirez.programming.kicks-ass.net/
>
> Fixes: 9ae1e990f1ab ("perf tools: Remove broken __no_tail_call
>        attribute")
> ---
>  tools/perf/tests/dwarf-unwind.c | 39 +++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
> index 83638097c3bc..c8ce86bceea8 100644
> --- a/tools/perf/tests/dwarf-unwind.c
> +++ b/tools/perf/tests/dwarf-unwind.c
> @@ -24,6 +24,23 @@
>  /* For bsearch. We try to unwind functions in shared object. */
>  #include <stdlib.h>
>
> +/*
> + * The test will assert frames are on the stack but tail call optimizations lose
> + * the frame of the caller. Clang can disable this optimization on a called
> + * function but GCC currently (11/2020) lacks this attribute. The barrier is
> + * used to inhibit tail calls in these cases.
> + */

It would be nice to put the GCC version rather than the date.

> +#ifdef __has_attribute
> +#if __has_attribute(disable_tail_calls)
> +#define NO_TAIL_CALL_ATTRIBUTE __attribute__((disable_tail_calls))
> +#define NO_TAIL_CALL_BARRIER
> +#endif
> +#endif
> +#ifndef NO_TAIL_CALL_ATTRIBUTE
> +#define NO_TAIL_CALL_ATTRIBUTE
> +#define NO_TAIL_CALL_BARRIER __asm__ __volatile__("" : : : "memory");
> +#endif

I would try avoid this nest of conditions and instead do it like in
`compiler_attributes.h`, i.e. make use of `__has_attribute`
unconditional by making sure it works for all versions/compilers, and
then just:

    #if __has_attribute(disable_tail_calls)
    # define NO_TAIL_CALL_ATTRIBUTE __attribute__((disable_tail_calls))
    # define NO_TAIL_CALL_BARRIER
    #else
    # define NO_TAIL_CALL_ATTRIBUTE
    # define NO_TAIL_CALL_BARRIER __asm__ __volatile__("" : : : "memory");
    #endif

In fact, I think it would be best to simply have a mimic of
`compiler_attributes.h` suitable for `tools/`.

Cheers,
Miguel
