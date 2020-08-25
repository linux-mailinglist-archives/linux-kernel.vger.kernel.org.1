Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1567250D41
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 02:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgHYAbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 20:31:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728386AbgHYAbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:31:11 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D7A620882
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 00:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598315470;
        bh=tq8BpZywkVUDyXkA8BuG2zK2VdJBulYjB7aXNUE6TAA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QPla5ImzONRb+P8ymGn9z0BfaEu5OG7pVsmt9F9Sj8YwbJlHjRpc4wLh1Ds0Ea8ks
         2mBCru4/9A2H/ilPXRWIx/x/FB71V+jahaZZ6j85xes/nk6nRh16VzD9M11GzXaXpu
         7WUgbAe8DpOgpoUqiinpjXLmeQj1fawBmKB2Etck=
Received: by mail-wm1-f53.google.com with SMTP id c19so577453wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 17:31:10 -0700 (PDT)
X-Gm-Message-State: AOAM530JM1XZbj8a+Buv0102pGiSXIjvFnDD8jpBp4KUSEXqkq+ArDMA
        D8CPBHVhIUz73ENQtA6SkCOSJURipvigB361+eh/Tw==
X-Google-Smtp-Source: ABdhPJwQU/50KlTcm3C++CenvRFvRN3reFoNWQGtl7uOO2GHic8WTU5uhpWYRNgy0SzE5T1V2XI8q7lSfPOeHYOqBso=
X-Received: by 2002:a1c:4c06:: with SMTP id z6mr1611443wmf.21.1598315468706;
 Mon, 24 Aug 2020 17:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAOp6jLYrwMqV=7hmxgdZUdDZ2aeUB27TTHm=j6cQT7C10Muhww@mail.gmail.com>
 <7DF88F22-0310-40C9-9DA6-5EBCB4877933@amacapital.net> <CALCETrUrvrQNw6dPau_rtHjA_YuCVdCTWYd4dsdcvcGsOaspmg@mail.gmail.com>
 <b0813ec5-b163-cc11-bfc9-e9d08c9c4ff2@zytor.com>
In-Reply-To: <b0813ec5-b163-cc11-bfc9-e9d08c9c4ff2@zytor.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 24 Aug 2020 17:30:56 -0700
X-Gmail-Original-Message-ID: <CALCETrXvgb257CWnaA1NgUUp3x08+gJBEOQh4o9OYkB-RvAo1A@mail.gmail.com>
Message-ID: <CALCETrXvgb257CWnaA1NgUUp3x08+gJBEOQh4o9OYkB-RvAo1A@mail.gmail.com>
Subject: Re: [REGRESSION] x86/cpu fsgsbase breaks TLS in 32 bit rr tracees on
 a 64 bit system
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Robert O'Callahan" <robert@ocallahan.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Kyle Huey <me@kylehuey.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 4:52 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 2020-08-24 14:10, Andy Lutomirski wrote:
> >
> > PTRACE_READ_SEGMENT_DESCRIPTOR to read a segment descriptor.
> >
> > PTRACE_SET_FS / PTRACE_SET_GS: Sets FS or GS and updates the base accordingly.
> >
> > PTRACE_READ_SEGMENT_BASE: pass in a segment selector, get a base out.
> > You would use this to populate the base fields.
> >
> > or perhaps a ptrace SETREGS variant that tries to preserve the old
> > base semantics and magically sets the bases to match the selectors if
> > the selectors are nonzero.
> >
> > Do any of these choices sound preferable to any of you?
> >
>
> My suggestion would be to export the GDT and LDT as a (readonly or mostly
> readonly) regset(s) rather than adding entirely new operations. We could allow
> the LDT and the per-thread GDT entries to be written, subject to the same
> limitations as the corresponding system calls.
>

That seems useful, although we'd want to do some extensive
sanitization of the GDT.  But maybe it's obnoxious to ask Kyle and
Robert to parse the GDT, LDT, and selector just to emulate the
demented pre-5.9 ptrace() behavior.

--Andy
