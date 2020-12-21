Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558DD2E0223
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 22:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgLUVli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 16:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLUVli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 16:41:38 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2279C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 13:40:57 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id w5so7102794pgj.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 13:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3gJZe//5sJh25MpZhQ1REVhY7oVTDWIfW5HcKPRa3M=;
        b=anaAo0CvzqKj02Fa03pkqAr+BFdxDc+SQY5ZBR3VB7Gr3C1d+JaMzVhqgsbAjuOXFl
         34eQfHpdSX6PplROD/ltj2GjJPG//KbvDvYKoZwqcjjqIBjSyWZg/EKTd55iqilvohbu
         UM+juvg3zrPPeT1lfHB6UpWAdeolNj81s0osJGs9rvQ4H2xrJvtuVFKLSGZQzYxK/Klp
         N8xpmmRZz+GrhltdJ1ZjHLnCqxtq7G5+9shCdUmOKJ6qH/n3TF02gG6OOM7uBO4hV4wx
         hUjSRlvUg8i+x29M7PU0zsxnbV6QlX+azTujmmX7Du6lYSJ06Ov35+5nVnTezhRSg3D0
         Q92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3gJZe//5sJh25MpZhQ1REVhY7oVTDWIfW5HcKPRa3M=;
        b=o86Q63Qmhew/vL4o1zKQ59jjFnfEMfgw1mzlZXyU9/MAYT8iXQCVwMtzol4SbP04Op
         HrB62dubTO3d8Z/97mgsGqoEpEsapOCGj2OI+wqalInMQwrkMokuuf9kfYiwDFwyhVWD
         dIlB20trNQXyjwbFJKX5yB/iSqPcNCr2ytnVUIGPKIyeF7VLuyDEofor3EmynT9ohPoJ
         LzFUIPrsLOmZXzx8iBhX5sVJyOMo0WSpVXrmr07l0SIe/wjHtQN6gfLfTSGNeMug8ktA
         9EuV9pBgJQzNNhK3H+MacnTuWd4nqhktIPDSCaQTnok/3qVVkKS25fQWUpdTSFafbA6p
         sEIw==
X-Gm-Message-State: AOAM532XHpmGHvtZkUCZ32i5iQFDUP5DEHta7NUQHHARH3jmO3CjZqhp
        NVmk/q+Q/JqKrkFj8r1aUg1y9xLytqfqQToa3bNU/Q==
X-Google-Smtp-Source: ABdhPJyRPSBNZ2IppG017l4A3VMnps5Fgkc58GBua9TJc7tpxoP7ZgtYM99ll8/OzZtRdEb8iEbHYnTA1cfriIAGTU0=
X-Received: by 2002:a62:1896:0:b029:197:491c:be38 with SMTP id
 144-20020a6218960000b0290197491cbe38mr17155484pfy.15.1608586856748; Mon, 21
 Dec 2020 13:40:56 -0800 (PST)
MIME-Version: 1.0
References: <20200903023056.3914690-1-nivedita@alum.mit.edu>
 <CAKwvOdm8qUpueOdO7e-rQotO5UynrgU2TZ9DEe=O4f9eU5EY0g@mail.gmail.com> <X+ESNP6HdYQpd7g3@rani.riverdale.lan>
In-Reply-To: <X+ESNP6HdYQpd7g3@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 21 Dec 2020 13:40:44 -0800
Message-ID: <CAKwvOd=y7J8ehoEaFBLwS0UdC_mPbACenfRL9ssSy+UPUFGwTQ@mail.gmail.com>
Subject: Re: [PATCH] x86/cmdline: Disable jump tables for cmdline.c
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 1:23 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Mon, Dec 21, 2020 at 11:14:39AM -0800, Nick Desaulniers wrote:
> > On Wed, Sep 2, 2020 at 7:31 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > When CONFIG_RETPOLINE is disabled, Clang uses a jump table for the
> > > switch statement in cmdline_find_option (jump tables are disabled when
> > > CONFIG_RETPOLINE is enabled). This function is called very early in boot
> > > from sme_enable() if CONFIG_AMD_MEM_ENCRYPT is enabled. At this time,
> >
> > Hi Arvind, sorry I missed this when you first sent it.  I'm going
> > through and mass deleting my inbox (email bankruptcy) but noticed
> > this.  I couldn't reproduce jump tables in cmdline_find_option with
> > CONFIG_RETPOLINE disabled but CONFIG_AMD_MEM_ENCRYPT on today's
> > linux-next. Can you please confirm that this is still an issue? I will
> > reread the disassembly, but it looks like a bunch of cmp/test+jumps.
> >
>
> The patch got merged and is in v5.10 -- are you testing with it reverted
> or just plain linux-next?

Oh, sorry, I missed any email that it was merged (and didn't look in
git log).  Just linux-next, so no wonder I didn't see any jump tables.
:^P

-- 
Thanks,
~Nick Desaulniers
