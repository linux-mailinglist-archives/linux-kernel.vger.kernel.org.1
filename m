Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F452C2DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390323AbgKXRHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390255AbgKXRHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:07:09 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7AAC061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:07:07 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y10so7396750ljc.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZBvHvzP+9o8/Uf4hbLg51E6jDSRQAkhWemb0Me9MezE=;
        b=p8NsNIxBBnZy2eUEOISROXe3cZDJXTooL+7OKlBIBBEwerKvASfRv3Z+BalyhTTE0L
         Nj6QKn3NM+qm7O7APifQO6dVMDhP1/9OH8Tq96BFAmoasRftP0/EkeahBcss/fA3kPVR
         QtTsWBXLSNLzhcZRk1SypgtNdqpdhqOzwGAWwUrhBn+YL2ibEamP/Y0ezy3RPXPIpvjg
         grGT3IqlE93NJCnv0vtc5O/8qyrXbPx4552Js/h956h21KJpdvb8nI0+5pPMQXFy6LU7
         vCooPNZoJB2cEqLC3oZd60t+MzLUDoWirK6Uz1Rl6hBxNmre+p5ngKJqJ2PsqS2NdeLF
         nrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZBvHvzP+9o8/Uf4hbLg51E6jDSRQAkhWemb0Me9MezE=;
        b=IqmSoGA/t4lBlp5CtIcMxYW7Kwta9ZK5H9ZY/VIQ/Vvff5HwyHcPe7WT2/c+4WONp+
         OacbUVJsGpWWugnwnzH4be4umkL9rzbrBfIxxBKskzTN3bw5saDffqnr43DFhIKrBiPZ
         UaNj++tloWw/9ATPpVoC0dOXXhP0ufHzLE/St1PmIRakLVTbwLd/x0POPQ981Dzw1z3s
         C0IL6sF2gY2HnRxy8zGFbKfdkFFDu4Nmz9m2sZJW6W5lxl+ip31vsgZCx+ZO7FOMrvdr
         FU+8A5pPz2Vzl+AaCpOKnh1rPzFeohS7IMI+GB2PG6g/MYqyUNmV7Y3gC7axeake09Y2
         k5Ag==
X-Gm-Message-State: AOAM533ARAlCHMbU4jpSGggVeogAZthP/d3BhRDvq0E2CPSOabngtWkr
        HZHlKbd/pqdSQ/k0ZsoiCYIrPpGFKHcVYcxesG6QIw==
X-Google-Smtp-Source: ABdhPJxIPTrFaAh9lpUZyV93kcGfCqDWjDKDo36A9pWmpafCk5awnNtM+yIUmG0jgOWTMiMoCiFR65TMaMdR8PG2L5o=
X-Received: by 2002:a2e:9216:: with SMTP id k22mr2160034ljg.138.1606237625645;
 Tue, 24 Nov 2020 09:07:05 -0800 (PST)
MIME-Version: 1.0
References: <87lfer2c0b.fsf@oldenburg2.str.redhat.com> <20201124122639.x4zqtxwlpnvw7ycx@wittgenstein>
 <878saq3ofx.fsf@oldenburg2.str.redhat.com> <dcffcbacbc75086582ea3f073c9e6a981a6dd27f.camel@klomp.org>
 <20201124164546.GA14094@infradead.org>
In-Reply-To: <20201124164546.GA14094@infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 24 Nov 2020 18:06:38 +0100
Message-ID: <CAG48ez2ZHPavVU3_2VnRADFQstOM1s+3GwfWsRaEjAA1jYcHDg@mail.gmail.com>
Subject: Re: [PATCH] syscalls: Document OCI seccomp filter interactions & workaround
To:     Christoph Hellwig <hch@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Cc:     Mark Wielaard <mark@klomp.org>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        dev@opencontainers.org, Jonathan Corbet <corbet@lwn.net>,
        "Carlos O'Donell" <carlos@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+seccomp maintainers/reviewers
[thread context is at
https://lore.kernel.org/linux-api/87lfer2c0b.fsf@oldenburg2.str.redhat.com/
]

On Tue, Nov 24, 2020 at 5:49 PM Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Nov 24, 2020 at 03:08:05PM +0100, Mark Wielaard wrote:
> > For valgrind the issue is statx which we try to use before falling back
> > to stat64, fstatat or stat (depending on architecture, not all define
> > all of these). The problem with these fallbacks is that under some
> > containers (libseccomp versions) they might return EPERM instead of
> > ENOSYS. This causes really obscure errors that are really hard to
> > diagnose.
>
> So find a way to detect these completely broken container run times
> and refuse to run under them at all.  After all they've decided to
> deliberately break the syscall ABI.  (and yes, we gave the the rope
> to do that with seccomp :().

FWIW, if the consensus is that seccomp filters that return -EPERM by
default are categorically wrong, I think it should be fairly easy to
add a check to the seccomp core that detects whether the installed
filter returns EPERM for some fixed unused syscall number and, if so,
prints a warning to dmesg or something along those lines...
