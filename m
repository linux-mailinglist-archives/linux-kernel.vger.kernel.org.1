Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00A228FAD4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 23:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbgJOVrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 17:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbgJOVrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 17:47:42 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CE7C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 14:47:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h7so317783wre.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 14:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5n2ViAxkOJ8MzqeT90Ga+BE3OTB74Nc8+OlP3bMobw=;
        b=S3NXkkUSeE+YddJbqE23kY8baPLaCk2a0Pkdm3RQkVFj1ir8kVer0O8dYcGtP7Rp6M
         4zuJMPbu1P5IYbgL6/YNYe9azzBFpQlgnw6N1cTWHFdcxEMdGWdKWX1Afde7L6txiMUj
         U3OXp4MQmAQmUPiCISZA3yzlop3fRmgnaTapHNpa194d5WAA6DY4ZPHWKCr5RwteQsV2
         GdNifYFKzSkcnwxb8mJKefEV6fZItkpejpxGwmZFwtOK6X50mr5EXhdQqeJPAFxwlDQI
         zR6yL3wRGY2QfZ8NGsLE8UPhmRu3mabXMRqLgrPDLGSnkXoZGAHa49mYPHloTOqT4dkH
         gQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5n2ViAxkOJ8MzqeT90Ga+BE3OTB74Nc8+OlP3bMobw=;
        b=XtDmP0QGtFb7V4WA4oDgxkEAvrecNbk6p6S0wDoH072XCRwz+/Na3+CLdVBWo3GokR
         toGMfiCfbjXN4dhM8kLR6oMXnRI96AShY4f77s40jfLi6aZGBPALu0NJm/jGjWmmFx1l
         hGq3qVWtC7MS6WAhYVEBgQJscQS80CgJsX9lCcZnqyaJTrsIfTN5vfo3S6qhTiKdUCR7
         AYyQA0Cdj4hbtTlv+ewRoUbWeheFqHHgZ9+0x+Gl/gJneoVjfXhbRBtsXJukkBFmNrWC
         pT/pZ5c1nQgEJE5wzA4e9R3SdTg57KAxRQ0hqt8RIOUgxCT0gg3ah2Iw9n7wMrfY80vv
         C6xQ==
X-Gm-Message-State: AOAM533rFL65jcwwKfwrVb8cMCxXnO2qN6is3F2RbjDko9WJdGdMita/
        6I1FJBSW5hL/jgOOVi3Z9vF9RWYUtLAQZ6O8UdKulw==
X-Google-Smtp-Source: ABdhPJydJV5T1VbRwS3Y3meNbngihAvrNPY1i9mXSsuOz4J3uQ+zw4w8pfnA5KRpj7V8s5GNzOmKMV51naXPwaRaFW8=
X-Received: by 2002:adf:b19c:: with SMTP id q28mr293012wra.119.1602798460653;
 Thu, 15 Oct 2020 14:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201015161216.1563600-1-irogers@google.com> <5E711F64-A9BF-48EC-83A3-3C644D80F848@zytor.com>
In-Reply-To: <5E711F64-A9BF-48EC-83A3-3C644D80F848@zytor.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 15 Oct 2020 14:47:28 -0700
Message-ID: <CAP-5=fXRBLwui9wdDvqrB0p4TaWVSth4cuH+2TwXTq5TtgL_NQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/insn, tools/x86: Fix some potential undefined behavior.
To:     hpa@zytor.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86 <x86@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Numfor Mbiziwo-Tiapo <nums@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 2:35 PM <hpa@zytor.com> wrote:
>
> On October 15, 2020 9:12:16 AM PDT, Ian Rogers <irogers@google.com> wrote:
> >From: Numfor Mbiziwo-Tiapo <nums@google.com>
> >
> >Don't perform unaligned loads in __get_next and __peek_nbyte_next as
> >these are forms of undefined behavior.
> >
> >These problems were identified using the undefined behavior sanitizer
> >(ubsan) with the tools version of the code and perf test. Part of this
> >patch was previously posted here:
> >https://lore.kernel.org/lkml/20190724184512.162887-4-nums@google.com/
> >
> >v2. removes the validate_next check and merges the 2 changes into one
> >as
> >requested by Masami Hiramatsu <mhiramat@kernel.org>
> >
> >Signed-off-by: Ian Rogers <irogers@google.com>
> >Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> >---
> > arch/x86/lib/insn.c       | 4 ++--
> > tools/arch/x86/lib/insn.c | 4 ++--
> > 2 files changed, 4 insertions(+), 4 deletions(-)
> >
> >diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
> >index 404279563891..be88ab250146 100644
> >--- a/arch/x86/lib/insn.c
> >+++ b/arch/x86/lib/insn.c
> >@@ -20,10 +20,10 @@
> >       ((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
> >
> > #define __get_next(t, insn)   \
> >-      ({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); r; })
> >+      ({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte +=
> >sizeof(t); r; })
> >
> > #define __peek_nbyte_next(t, insn, n) \
> >-      ({ t r = *(t*)((insn)->next_byte + n); r; })
> >+      ({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); r; })
> >
> > #define get_next(t, insn)     \
> >       ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out;
> >__get_next(t, insn); })
> >diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
> >index 0151dfc6da61..92358c71a59e 100644
> >--- a/tools/arch/x86/lib/insn.c
> >+++ b/tools/arch/x86/lib/insn.c
> >@@ -20,10 +20,10 @@
> >       ((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
> >
> > #define __get_next(t, insn)   \
> >-      ({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); r; })
> >+      ({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte +=
> >sizeof(t); r; })
> >
> > #define __peek_nbyte_next(t, insn, n) \
> >-      ({ t r = *(t*)((insn)->next_byte + n); r; })
> >+      ({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); r; })
> >
> > #define get_next(t, insn)     \
> >       ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out;
> >__get_next(t, insn); })
>
> Wait, what?
>
> You are taking about x86-specific code, and on x86 unaligned memory accesses are supported, well-defined, and ubiquitous.

On why this is undefined behavior:
https://lore.kernel.org/lkml/CAP-5=fU2XBoOa2=00VCuWYqsLUzMSMzUXY63ZJt9rz-NJ+vYwA@mail.gmail.com/

> This is B.S. at best, and unless the compiler turns the memcpy() right back into what you started with, deleterious for performance.

On performance, the memcpys are fixed size and so lowered to loads on
x86 by any reasonable compiler. See the thread above.

> If you have a *very* good reason for this kind of churn, wrap it in the unaligned access macros, but using memcpy() is insane. All you are doing is making the code worse.

The decoder is a shared code and using unaligned macros makes life
hard for the other users of the code. Memcpy is the "standard"
workaround for this kind of undefined behavior.
https://lore.kernel.org/lkml/e4269cb2-d8e6-da26-6afd-a9df72d4be36@intel.com/

For motivation, beyond just having perf be sanitizer clean, see discussion here:
https://lore.kernel.org/lkml/CAP-5=fUoSGy3NAzTSbF3YLEPABSs7oPsxLkCx36XkEzzm341yw@mail.gmail.com/
https://lore.kernel.org/lkml/160208761921.7002.1321765913567405137.tip-bot2@tip-bot2/

Thanks,
Ian

> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
