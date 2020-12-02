Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB682CB7DD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbgLBI4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgLBI4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:56:20 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC907C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 00:55:40 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id w8so825955ilg.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 00:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ng7YtwJ5R2LWWptsHqLLFcOkHU9olZq7Ir42a3ujD90=;
        b=kqoVC2j0WI2lo3rPt9tydpfuxb2NmAb38A+3mU+pOAX+cBZh9MAgyhqGHslFHlD7/5
         OAt5RsmK764HSEowZjbbGBLwgt0B4Jci4OZ5w12QBpt6f3n/1Wb6bIJfaQY8EseUQcig
         W+nHppw7yhfOLIVjHB1jjhh2JBQFuHJM+0ICLGOz6WOpzp6thUeMzn6eLTcGp7YyHSe4
         esALJzuAmvk+W6s2GxfP9v6PgFi6C29wOgyfJ1d9wU3aaCOu84ddwnfywEeqax7P7X/p
         DJelhBOpXlc8/7ADpauqSvnwpt75yhg9DWhzg7gzxOpqWesEkFe7JqY2c8rVkQjbDIEn
         m6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ng7YtwJ5R2LWWptsHqLLFcOkHU9olZq7Ir42a3ujD90=;
        b=ExHu47o+Yegw2R1NmcaDiw4XsYS1MyDPVoYbeI+i2CiHSiUEACMxL57XEVWVUhaQ9r
         XDbw10Wo/eD+Z7xifvT9JkFNfUG6VlKYGPgawhdKDYrOaZNmgEH1k3u0MbPxduARv86a
         k/nf8V9q1CxGsFQ8bfFl9pHBd+ApqL9hlkJD1+D7IAqj8RNaq6CtSwByNXtGkvD9Jm4A
         mP47E6Ok9x0FAA2Idu9CDWPufv+kjflAiULL1O0mv8nAXYIcKKv8DcIJ0wFx46RTcZOI
         EoVZjenNSKv02SsvDNTQjE4WJ3UAgV+ZtYND8pXtRu3vU/c9fz9rDkHGov3fgM/tQJpd
         Pqug==
X-Gm-Message-State: AOAM531ILTi8fNA3NlX9S4bTCtFWE0QpILxKqtvzx4221+bfyr+OmCwd
        oaTFS7L6tCTeFHB3No3imzI/IX2J3spdvIUZ9XA=
X-Google-Smtp-Source: ABdhPJymXxiQFTDL1ZloNVucOtizhf7mByI2z5gQ4/6kAJ0IgExbnrYJtc2RRarjLE0Fc5fOhUgAGEVf7oR8mnA3lNg=
X-Received: by 2002:a05:6e02:689:: with SMTP id o9mr1453522ils.47.1606899340118;
 Wed, 02 Dec 2020 00:55:40 -0800 (PST)
MIME-Version: 1.0
References: <20201130152516.2387-1-jiangshanlai@gmail.com> <0766416e-bab5-c8e7-9466-a72e965fdb8a@intel.com>
In-Reply-To: <0766416e-bab5-c8e7-9466-a72e965fdb8a@intel.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 2 Dec 2020 16:55:29 +0800
Message-ID: <CAJhGHyAPE4JSUr6za5HJe9ePhRmAgAXX-yLhAqEHWvRWs+1Upg@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/mm/pti: Check unaligned address for pmd clone in pti_clone_pagetable()
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 1:43 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 11/30/20 7:25 AM, Lai Jiangshan wrote:
> > The commit 825d0b73cd752("x86/mm/pti: Handle unaligned address gracefully
> > in pti_clone_pagetable()") handles unaligned address well for unmapped
> > PUD/PMD etc. But unaligned address for pmd_large() or PTI_CLONE_PMD is also
> > needed to be aware.
>
> That 825d0b73cd752 changelog says:
>
> >     pti_clone_pmds() assumes that the supplied address is either:
> >
> >      - properly PUD/PMD aligned
> >     or
> >      - the address is actually mapped which means that independently
> >        of the mapping level (PUD/PMD/PTE) the next higher mapping
> >        exists.
>
> ... and that was the root of the bug.  If there was a large, unmapped
> area, it would skip a PUD_SIZE or PMD_SIZE *area* instead of skipping to
> the *next* pud/pmd.
>
> The case being patched here is from a *present* PTE/PMD, so it's a
> mapped area, not a hole.
>
> That said, I think the previous changelog was wrong.  An unaligned
> address to a mapped, large (2M) region followed by a smaller (4k) region
> would skip too far into the 4k region.
>
> That said, I'm not sure I like this fix.  If someone is explicitly
> asking to clone a PMD (which pti_clone_pgtable() forces you to do), they
> better align the address.

Hello, Dave

I think I got what you mean more or less, but I don't think I can
update the patch to address all your concerns and requirements.

I know very little about the area.

Could you make new patches to replace mine.

Thanks
Lai.
