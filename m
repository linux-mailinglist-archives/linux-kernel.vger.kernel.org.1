Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBFB2B242C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 20:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgKMTAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 14:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMTAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 14:00:03 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5386C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 11:00:03 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id b190so2358091vka.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 11:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AdFWpr+0TwT4NKTwwnmNlVObIW5dr9OLKBEuc6XzPXg=;
        b=fR0+aD32vUzZbB7HCVVfLX/8yVGcdrQwDDRXyL6KSMyOeZn2VeZ1pjHWUk8efIrN9f
         qXyd0bN+VuIasUceNfu7a3wWYWciHiAL3ljb4V2lWGFkKD55BQw80ButQ1agKT6tu+64
         Ikd2SW9rhqCgYFpGRd5lp/MbYqlq2eEpAimjSB+u38rDMTkIomg/Z7FP3/KRMOE8Rx02
         A4urlzzhgs4yViqCD8KigJWcvP7UarzIVLmFnFnJZ25Q8JQ0w3u6th0Y0M8I6aNiyQfF
         sCA5/+I/RSWR8giHBIrswYUEf4UEGakj0dKBa7Pf1pc0rYLfwiwqadlKC6fSrXcRp3MJ
         xNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AdFWpr+0TwT4NKTwwnmNlVObIW5dr9OLKBEuc6XzPXg=;
        b=pI66cf/Af3d9QN270XEntCaHN+M1FnpeEF4ygGmiPsAPvddr1p6w1k4/lWoX6Regih
         aB0LNxEMtnhxCh234dg1FGtxcq44S6W6etHaA/Z/7VY7eq1iseMwjPlVzpKlc6wdMkwy
         ntaQaoBxkiiRh9PUAt06NpeRA35SyFtrwHwNKDVADGc42W3LQutNXuNBnEoO7gTEzIYI
         P3etChCTIrZOvugH3ZKbBTRSZhlYaCS5Vw8AcjGwIVhZ5cb26fZMkzvxIYX0BmwXEk85
         wPwowxEvKPX9kmhUCHTcaqaycxWe+KlVPe/LflLX/ttDTj0menkBUlnweqNfSqfgwse2
         s1Uw==
X-Gm-Message-State: AOAM533gPiykPYjwmueyKGYSsSopc7wjNM/u889RPIJgHa5Q3GflSARc
        VGPkXoJxWukRc3xz3rB3dDSlQ0dcSCCcomjYQJak2w==
X-Google-Smtp-Source: ABdhPJw1XmqoRM7/wNEhMNAhSy4jGcLKJJgY9HTXKxvbHIwfFjlKwsysVA6WhQdMTVXiuiUbw0samNh4Sj0yn5MvJRk=
X-Received: by 2002:a1f:a0cf:: with SMTP id j198mr2274357vke.3.1605294002539;
 Fri, 13 Nov 2020 11:00:02 -0800 (PST)
MIME-Version: 1.0
References: <20201113182654.967462-1-samitolvanen@google.com> <95513107-5aa4-5e42-467f-f9a415eb9f3f@infradead.org>
In-Reply-To: <95513107-5aa4-5e42-467f-f9a415eb9f3f@infradead.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 13 Nov 2020 10:59:51 -0800
Message-ID: <CABCJKueALv=zBf3MYwN-EaeGxN3py-tReb3sVaqe9caCt8cJwA@mail.gmail.com>
Subject: Re: [PATCH] x86/e820: fix the function type for e820__mapped_all
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 10:35 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 11/13/20 10:26 AM, Sami Tolvanen wrote:
> > e820__mapped_all is passed as a callback to is_mmconf_reserved, which
> > expects a function of type:
> >
> >   typedef bool (*check_reserved_t)(u64 start, u64 end, unsigned type);
> >
> > This trips indirect call checking with Clang's Control-Flow Integrity
> > (CFI). Change the last argument from enum e820_type to unsigned to fix
> > the type mismatch.
>
> Hi,
>
> Kernel style is no raw unsigned -- use unsigned int or unsigned long, please.
>
> checkpatch should or could have found that issue.

It did, but the existing type definition for the callback in
pci/mmconfig-shared.c uses raw unsigned. I can add a patch to change
that to unsigned int as well, if you prefer.

Sami
