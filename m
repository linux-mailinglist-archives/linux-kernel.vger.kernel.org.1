Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33CB29CD03
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 02:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgJ1Bil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 21:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1833019AbgJ0Xe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 19:34:28 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89DCE2223C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 23:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603841667;
        bh=RJE//DOx71HHeDbmWqHEDCCZ1JmcRm3imz22F8k1pfE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GQrhz4iCo0j56Nr0YQFZ/2CvT+gzp7FG1lAovFekCdG+r8TDN8tOmCRN+QO2jObN1
         NbdTeUXvdFQTyZ3f2N9eTJ57mwm2R9sX+1FpJsRTjhDSg7YEgKtxOi/DDHf8rx2SY7
         QEDFNwV/t0YqaG/voFyY/XFr53DPDQcDeGBwNxVA=
Received: by mail-qk1-f178.google.com with SMTP id x20so2995800qkn.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 16:34:27 -0700 (PDT)
X-Gm-Message-State: AOAM530BRZW/J7lLI2QeVtQh/Qhd0mCfTVjvNVS7YOaeqR5GhYNScojT
        P+gmFPqh8Jyz8VO1h2XKpPOOi/0hko5IqZfc0ZA=
X-Google-Smtp-Source: ABdhPJytnSIjjmEQ3hcWAqSf8MdLVA8KvV6NGCBBRKW/7FL9m93RfmtuNb8lsgi92TWbvASHw3Qf9mBVNYwIDpWQsI0=
X-Received: by 2002:a05:620a:22c9:: with SMTP id o9mr4873444qki.286.1603841666683;
 Tue, 27 Oct 2020 16:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201026165044.3722931-1-arnd@kernel.org> <20201026165805.GS2594@hirez.programming.kicks-ass.net>
In-Reply-To: <20201026165805.GS2594@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 28 Oct 2020 00:34:10 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3wDEKSn307UXbc33+Uqu-NDV2V=0dDKbYJpAtgZjDNkQ@mail.gmail.com>
Message-ID: <CAK8P3a3wDEKSn307UXbc33+Uqu-NDV2V=0dDKbYJpAtgZjDNkQ@mail.gmail.com>
Subject: Re: [PATCH] seqlock: avoid -Wshadow warnings
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 5:58 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Oct 26, 2020 at 05:50:38PM +0100, Arnd Bergmann wrote:
>
> > -     unsigned seq;                                                   \
> > +     unsigned __seq;                                                 \
>
> > -     unsigned seq = __read_seqcount_begin(s);                        \
> > +     unsigned _seq = __read_seqcount_begin(s);                       \
>
> > -     unsigned seq = __seqcount_sequence(s);                          \
> > +     unsigned __seq = __seqcount_sequence(s);                        \
>
> Can we have a consistent number of leading '_' ?

Not really ;-)

The warning comes from raw_read_seqcount_begin() calling
__read_seqcount_begin() and both using the same variable
name. I could rename one of them  and use double-underscores
for both, but I haven't come up with a good alternative name
that wouldn't make it less consistent in the process.

> Also, I suppose you're going to find the explicit shadow in
> ___wait_event(), that one's not going to be trivial to fix.

I have this patch in my tree at the moment but did not send that yet
because that caused a regression on powerpc:

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 57ccf26d3b96..5d00a6fb7154 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -265,7 +265,11 @@ extern void init_wait_entry(struct
wait_queue_entry *wq_entry, int flags);
 ({
         \
        __label__ __out;
         \
        struct wait_queue_entry __wq_entry;
         \
-       long __ret = ret;       /* explicit shadow */
         \
+       __diag_push()
         \
+       __diag_ignore(GCC, 8, "-Wshadow", "explicit shadow")
         \
+       __diag_ignore(CLANG, 9, "-Wshadow", "explicit shadow")
         \
+       long __ret = ret;
         \
+       __diag_pop();
         \

         \
        init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE :
0);        \
        for (;;) {
         \


Still looking at alternative approaches.

      Arnd
