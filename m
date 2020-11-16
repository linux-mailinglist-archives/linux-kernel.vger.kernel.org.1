Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B81E2B4215
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 12:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgKPLD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 06:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgKPLD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 06:03:26 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BFAC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:03:26 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id t33so15310105ybd.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6uB+yM5X+cpFMIOOauK5UvxV9OyukgFk1sQ27iEWLu4=;
        b=oSemWkKR+FHUD7wOZBYzfb0tXdOX0I7CNsIQQhNhaLUBzgtfbPdtQ93GSNefKJbgB3
         R4z3hD9QNtXJUxFoRV4E0UxYY37BKcfe1XsWWgsEzvkqJp+zxJm4tErwz/YcMieTleQ0
         oZvGNnMhXSHf4uRSCUN9JTr60uKMSTgoppGu0pe/pvHQUbZ4OsD6RGvDE0MCikNhkjpI
         ECFTfN8ObOnllHvI7pTEq6M+67jRtBOF27fQT9+Zy7p7AAIppuDAqFXAThFSVtg6B0xn
         bqQrt7MV8mrBUltkYjjzoo4w9csuIEtiHNLjP0tQdoGwIxKBjnSmc4L//OLsPzR3wQBg
         qZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6uB+yM5X+cpFMIOOauK5UvxV9OyukgFk1sQ27iEWLu4=;
        b=V8BnSz3EuR11Ougd4pOtSTYqbqZ70WfPQ7a/RUuKAWTMExMevu4DDUILOU8FDZ3iyD
         u9UUPwMN57iz19xgqwKzRlbOYRRQrWxKXS0GE75yI5tv0qd8pSQHZeSAxHVASEQpCOi8
         X9siyiLdcpu7YDGpGGSbdjPnJQP+eTICPWHDefvqJMRhBfA/qygreo9nt5XcK4bzuG2G
         gJK0/BTtWn8cgPbHN86elA55TwfDe3Kd4Dlm592fFS+QbiDAZN8FUkoPcseaai4jBBaV
         pLdZNcIKztcHmSpcqXegfdP6P3WI5riY0mTLanPIe5+LfPDykQ4VMZe4u4dgmTkicSre
         BV3g==
X-Gm-Message-State: AOAM5336pXI0DFbbNu+xe6Z1AOTh6xg3YcdPtZ4b5pCmpBzpyug91klP
        rUYX8Fw79Z8YhQzjQrtPV0tUgCu1RWZkS5Mrwts=
X-Google-Smtp-Source: ABdhPJxAZNvvD6VqGha3oWgp9MwuhBjD/k6Gy3W5vXakCnQBI/MwhJWSifsVjvpD9AF47EZQ5D+W0CusWe0SM++H2l4=
X-Received: by 2002:a25:bcc7:: with SMTP id l7mr17377499ybm.115.1605524605331;
 Mon, 16 Nov 2020 03:03:25 -0800 (PST)
MIME-Version: 1.0
References: <20201114000803.909530-1-irogers@google.com> <CANiq72m=OK2bF2Nc-ht=ibNa2m6RcBCjFuhrv9kyoxE6yaMqVA@mail.gmail.com>
 <CAP-5=fV0xe-8GEbnrh8Y4C8nWK2E2mGo1iiNpRCs+590VwJVEA@mail.gmail.com>
 <CANiq72kV-hcmf17_rzywuKXe5U0kwCOb52SihwZHUK0z0AsECA@mail.gmail.com> <CAP-5=fU1RM-O4=OGGLkn2+jF4B=m+yhwqo3hE2EHSWRxQnGBOg@mail.gmail.com>
In-Reply-To: <CAP-5=fU1RM-O4=OGGLkn2+jF4B=m+yhwqo3hE2EHSWRxQnGBOg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 16 Nov 2020 12:03:14 +0100
Message-ID: <CANiq72=MYsucFkCtBZMN1VGVpRtMAwV2TpTvwXgeckwwa_7T=g@mail.gmail.com>
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
        Stephane Eranian <eranian@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 7:48 AM Ian Rogers <irogers@google.com> wrote:
>
> GCC [0-9]+ :-) Perhaps just a reference to the GCC bug rather than a date=
.

That would be very good.

> In linux/compiler_attributes.h add:
> #define __GCC4_has_attribute_disable_tail_calls 0
> to the #ifndef __has_attribute block. We can't do this locally here as af=
ter that #include __has_attribute will be defined.

As far as I know, `tools/` use their own `compiler*` files, which is
why I was suggesting creating the equivalent there.

> In terms of lines of code, there's not much difference. Arguably there is=
 a bit more cognitive load from the #include and that disable_tail_call nee=
ds the funny handling that's here but won't obviously be hinted at by placi=
ng it in a shared header. I'm a little concerned that someone will come acr=
oss this in shared code and then go and break this test again with well int=
entioned cleanup.

Fewer lines, fewer conditions :-) The `#include` is hardly important
given kernel developers already know and use compiler attributes in
many places (they are included in the majority of compilation units).

Actually, we can simplify further. The attribute itself should be
pulled from the `compiler_attributes.h` (a `tools/` one, if needed),
and the barrier should likely be the `barrier()` macro (ditto).

Then, we just need:

    #if __has_attribute(disable_tail_calls)
    # define NO_TAIL_CALL_BARRIER
    #else
    # define NO_TAIL_CALL_BARRIER barrier()
    #endif

because using the attribute directly just works -- the only special
thing here is the conditional barrier.

And this conditional barrier should probably be shared, too, defining
it wherever `barrier()` (or equivalent) is defined for `tools/`. And
the name could be `barrier_for_tail_call()` or something like that.

Of course, we don't need to do all this for this patch, but we should
always attempt to minimize/simplify the diffs later on -- that is why
I suggested using the unconditional `__has_attribute` as if it was
already properly defined (we had to untangle similar stuff when I
added `compiler_attributes.h`).

Cheers,
Miguel
