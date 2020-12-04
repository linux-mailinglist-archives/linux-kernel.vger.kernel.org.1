Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404592CEA24
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgLDIsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgLDIsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:48:00 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB58FC061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 00:47:19 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id r9so4986432ioo.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 00:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=DvPQA/uQeL6Rk0gYvzQsgXI18A8EQMbRpx95m9ssMqk=;
        b=VWEVimGeTDcaF8fbWcD38wteBMf1qOntGfzCu4SsshUnxRONaSfH+t1BJJ6X/QrDNA
         qXQk8ypwDmMbAgEFYrr6kdMNDn6NHqPB1dtkpDRl/EgMf620p7IbHXAl1/eR3LokgIpe
         vs1xECtP4FMjmiZId65sKy9A6nvMBldDE7atJfJRBUT2VqnNZW0NfNhQh68OIZZGgNxC
         mzG6QQXJKTWEnfGfQ52w1/OiCv4WANeTc+Db0x+wDwTBxTNsaeCg/wV7rvLauTOEc2VV
         J0J9MNzAuPR/v3QF8jcr+4d/Q6wTWmj+yj/0tGm4mw3BvZ6U4yw1j+ycQrNNeNezCE3g
         Z3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=DvPQA/uQeL6Rk0gYvzQsgXI18A8EQMbRpx95m9ssMqk=;
        b=Y8ecJZjmF1j+x9MKLESTiixD5JkY1TMBqBypH6euaEQ9T+ZvfwM+/lPQsmPduVF3d9
         ajnfJ1OQbPNxC3DR7HzAgd2DqEX9zYlUBAOcJQTM7ki+Ravfg+TCz4h/it3J9465f/Zh
         3qUniPfUCWoZAAn+vBEUS/YH4Wn+vVphjE2uWvOrOq9WvEhLQBCRHMqpnK1bttSvHiZi
         6mtycZnojPtKCK4Top3+spX+SIXef1DPr9xQz7Et6GJbVQkw0c0XH7dNAWOx6JsN/duy
         4d1YrASraks/G4YUBA95f2B9fejCH0Jnb/D0+KOpeA2f04zpSqZLKIt70LpP8ihjr8jQ
         gqaA==
X-Gm-Message-State: AOAM532wc2RGBh6GtTrTVumc/eRmh6kGpHyXYEg25u10erBY2cPV1Jc4
        qMrFAUEa0YHpbOhI6Jkp+Xc5tDN+IP00hPq8YuxSuY0MuDWeow==
X-Google-Smtp-Source: ABdhPJyhqgBalkzvsxp0+BbqniRARvCd6hhowjiA8zcuj4TuOgndVrShxnRcm5CBb7tq7MEGTsoJmj+FrDsCuqjsRBE=
X-Received: by 2002:a6b:3118:: with SMTP id j24mr4851268ioa.171.1607071639162;
 Fri, 04 Dec 2020 00:47:19 -0800 (PST)
MIME-Version: 1.0
References: <20201130193900.456726-1-samitolvanen@google.com> <202012021139.FC8F149@keescook>
In-Reply-To: <202012021139.FC8F149@keescook>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 4 Dec 2020 09:47:08 +0100
Message-ID: <CA+icZUUowgV6dj0=EeDzD9i7a2o_8wyK_Cinb6J7Gmb5JM2eKg@mail.gmail.com>
Subject: Re: [PATCH v3] x86/pci: fix the function type for check_reserved_t
To:     Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 8:39 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Nov 30, 2020 at 11:39:00AM -0800, Sami Tolvanen wrote:
> > e820__mapped_all is passed as a callback to is_mmconf_reserved,
> > which expects a function of type:
> >
> > typedef bool (*check_reserved_t)(u64 start, u64 end, unsigned type);
> >
> > However, e820__mapped_all accepts enum e820_type as the last
> > argument and this type mismatch trips indirect call checking with
> > Clang's Control-Flow Integrity (CFI).
> >
> > As is_mmconf_reserved only passes enum e820_type values for the
> > type argument, change the typedef and the unused type argument in
> > is_acpi_reserved to enum e820_type to fix the type mismatch.
> >
> > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Suggested-by: Borislav Petkov <bp@alien8.de>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>

Hi Sami,

Back from a time-out...

Please add my:

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

I have some other patches which I had reported when testing Clang-CFI
against Linux v5.9 which misses my Tested-by.
I know we did all that reporting and testing via private email, so it
is as it is.
Reported-by is half-done...

Thanks.

Regards,
- Sedat -
