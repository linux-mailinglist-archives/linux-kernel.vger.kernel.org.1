Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021AD27F5A3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbgI3XDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730307AbgI3XDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:03:39 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB31C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:03:38 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 34so2232295pgo.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1qp3UfALwxeAkbBnOuUerX7dWpuQSQY7BSRCIH5z6dw=;
        b=MRZTPRpgiLd4dVo5yTkwFJrkJWJlwV1/Ezu7hIJ7Rs59u2t/dqz8e00FFVEDetPozz
         aQ6imer5vWRCnbV6wLq2YWB2w5P39mAy7li/GgpuxmnbWKoykyGMCqIlKa2bWy2kET/8
         L/MyhQWSOovNqkrAEJ2e43CZq1U3ek+y2etGG2+Eu2ERHPBYEgLmCGAwSaAawfHkhuwz
         F78WlOn7b1307xFpv/seXC/bjszTNQyOetB8iXFcIBs6nk4xrEp0URmgonq76kjLlh8o
         mR5t7CGRCkY/rRjBb4gEuqL7VHhXjekm3+BeoVxpgKakUH/xZJ+fSVpYpIOevV/28v/V
         ScUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qp3UfALwxeAkbBnOuUerX7dWpuQSQY7BSRCIH5z6dw=;
        b=IBM1be5vIGUPCbmIuT3Ok/B/zuKPQeZ+6oleiEKrFm6bcfMmjtW8TRXl3qy+K5Ic+L
         W8XvXXvkaBgRHq7nAaKfPAIHa4yKtmP8Z1AlA5RiUN5TaayaANs4490UAxQddxECOB8X
         wkXHHkG8l5GcgcClKRHT5U18b25xF6S8wuKSaxvUHG+T7A/cK7jVS2ibY1sV7zHBtxT+
         ZtHilDMHfHxCA4LfkcjdrX6bW186G3tms5+iJ9CHPqTTZ23qee/FXK9Z10Y/i8dcqlht
         Ftuk+u7KY068aUfJtuDptZjnTAWFaexxATGk5isw+clf2uUaNDFLXKw8GzAX0UU+xlGu
         5C+w==
X-Gm-Message-State: AOAM533V7c71l0LoXQMz2eWyJacXWG0Rq+pZwyhPxpn3joNCY3iMS699
        lrADH3ASCU8MpK7inzx8IfVChXqLDS5zY8FuB5Wq3A==
X-Google-Smtp-Source: ABdhPJyhsf7xgXoZCwes3Wso6sNqelOwWRnGZknPTFob1tIYQqEMLBUree89qUifxh5a278FlT9ON5/JJAYto1X3Vqw=
X-Received: by 2002:a17:902:8509:b029:d3:89e2:7931 with SMTP id
 bj9-20020a1709028509b02900d389e27931mr531392plb.51.1601507017712; Wed, 30 Sep
 2020 16:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200930222130.4175584-1-kaleshsingh@google.com>
 <20200930223207.5xepuvu6wr6xw5bb@black.fi.intel.com> <CA+EESO5ABYANQuynOs57UGYMcOaMjKN9TQdv4T2PObY5ng_1nw@mail.gmail.com>
 <CAJWu+oo7R6qQWz0_TnrTk_tmCfK2LgvLM-3PvhHv1wq2EyD_qg@mail.gmail.com>
In-Reply-To: <CAJWu+oo7R6qQWz0_TnrTk_tmCfK2LgvLM-3PvhHv1wq2EyD_qg@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 30 Sep 2020 19:03:26 -0400
Message-ID: <CAC_TJvcmYQxcPTqRpsP=8QgjAC5Sj8P7=xFsoCKVa6QbTbqM0Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] Speed up mremap on large regions
To:     Joel Fernandes <joelaf@google.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Zhenyu Ye <yezhenyu2@huawei.com>, Jia He <justin.he@arm.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mina Almasry <almasrymina@google.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        SeongJae Park <sjpark@amazon.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 6:47 PM Joel Fernandes <joelaf@google.com> wrote:
>
> On Wed, Sep 30, 2020 at 6:42 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> >
> > On Wed, Sep 30, 2020 at 3:32 PM Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > On Wed, Sep 30, 2020 at 10:21:17PM +0000, Kalesh Singh wrote:
> > > > mremap time can be optimized by moving entries at the PMD/PUD level if
> > > > the source and destination addresses are PMD/PUD-aligned and
> > > > PMD/PUD-sized. Enable moving at the PMD and PUD levels on arm64 and
> > > > x86. Other architectures where this type of move is supported and known to
> > > > be safe can also opt-in to these optimizations by enabling HAVE_MOVE_PMD
> > > > and HAVE_MOVE_PUD.
> > > >
> > > > Observed Performance Improvements for remapping a PUD-aligned 1GB-sized
> > > > region on x86 and arm64:
> > > >
> > > >     - HAVE_MOVE_PMD is already enabled on x86 : N/A
> > > >     - Enabling HAVE_MOVE_PUD on x86   : ~13x speed up
> > > >
> > > >     - Enabling HAVE_MOVE_PMD on arm64 : ~ 8x speed up
> > > >     - Enabling HAVE_MOVE_PUD on arm64 : ~19x speed up
> > > >
> > > >           Altogether, HAVE_MOVE_PMD and HAVE_MOVE_PUD
> > > >           give a total of ~150x speed up on arm64.
> > >
> > > Is there a *real* workload that benefit from HAVE_MOVE_PUD?
> > >
> > We have a Java garbage collector under development which requires
> > moving physical pages of multi-gigabyte heap using mremap. During this
> > move, the application threads have to be paused for correctness. It is
> > critical to keep this pause as short as possible to avoid jitters
> > during user interaction. This is where HAVE_MOVE_PUD will greatly
> > help.
>
> And that detail should totally have gone into the commit message :-/
Hi Joel,
The patch that introduces HAVE_MOVE_PUD in the series mentions the
Android garbage collection use case. I can add these details there in
the next version.
Thanks,
Kalesh
>
> Thanks,
>
>  - Joel
