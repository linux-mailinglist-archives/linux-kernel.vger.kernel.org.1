Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C194028FA53
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 22:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389170AbgJOU7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 16:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732684AbgJOU7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 16:59:14 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF48C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 13:59:12 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gm14so121473pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 13:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1qXJfImignGw1wL5PV6z2YsiCLHwApNbU3MNfvNx9M=;
        b=AWVmH1e1V/GQJoTC1BfctRlJEENyBbEv+qJp6kVoqSbq2E9eLJxiXxkTpTIdR4u/v0
         zUVCkrgF2zhfQFXLqbvfpG0zvLL4uGl15nmpzj2jXPihhYI5rgch3nqChR0dPU8s8rTk
         m34xR8kkS7pSWZ3vSRpdLLtFTPqPO1AUGjxLHEcmwXfu18NluYc+3w939NAtpQKonMBi
         Eo4fYDLqn2t9GiQbTuFlGpbL48hVIl5/zZZ7n0Jpl+ZsmGOFy7jaqYHzXGhGRGTKtq25
         kFWNafqq1azyC/pSnyL2SH/fSqcImrTJX0zEzsjf5xxMfGcxnjcX0iQWMXlOqIaiNM/T
         IigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1qXJfImignGw1wL5PV6z2YsiCLHwApNbU3MNfvNx9M=;
        b=XPPl5pa02oC9u1xZbxof8sL5BgUs2SJDzNh4istitjlcOnAQnQFXTyhlYG+aC5w/TF
         tzrUu5iBu1h6+rPnr2yNbTjFN8PjEvqZeHfRszA7dL6JH5V+qMTO1e87HuDwm3lpeBFc
         m7QRFGv0o0/f9prUHEwHJpsakrHDw0MNH/IwB6oiGe2v5WlanepgWX89ZJ0KvtP1Ia73
         baLYn3Y5Njy8f3Z0sDwzsiFOTQu4Ljf9uY2TA1DVRz223MEsdj32soDbRygP48GbGo1A
         gWb9qiTzlj+VtbfMNV7NBy5Swxi/Q3A8ceKBAs8gFoTZTXbITGK4dAJpjKU02Jl0wOOz
         B71g==
X-Gm-Message-State: AOAM532It5rdcGH79BNHrCuQteYdD0ff/cqWM6szpgFsVCCcI1TGJjDU
        GTDvauPR/4f+ZH4DrGImJs/DvxW+4yqX2Pyy+yaviA==
X-Google-Smtp-Source: ABdhPJwSscU4ZmMyA8lU16OhsJSSW+elxe7OP6RVZHrq776WNa2n0roRm+jO2G+FjtjulAhizQWPBfyUmw4RqMzxo5U=
X-Received: by 2002:a17:90a:6b04:: with SMTP id v4mr546998pjj.101.1602795551749;
 Thu, 15 Oct 2020 13:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20201008071628epcas5p24d196a6023a47a3b0bfa7b7f231ec811@epcas5p2.samsung.com>
 <1602141333-17822-1-git-send-email-maninder1.s@samsung.com> <20201008083015.GK1551@shell.armlinux.org.uk>
In-Reply-To: <20201008083015.GK1551@shell.armlinux.org.uk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 15 Oct 2020 13:59:00 -0700
Message-ID: <CAKwvOdnyFGWLpyBWX1nAY4veQucmzL509XqfqHj896hS+YJfYw@mail.gmail.com>
Subject: Re: [PATCH 0/3] IRQ stack support for ARM
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Maninder Singh <maninder1.s@samsung.com>,
        Jian Cai <caij2003@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Will Deacon <will@kernel.org>, a.sahrawat@samsung.com,
        v.narang@samsung.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 8, 2020 at 1:30 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Oct 08, 2020 at 12:45:30PM +0530, Maninder Singh wrote:
> > Observed Stack Overflow on 8KB kernel stack on ARM specially
> > incase on network interrupts, which results in undeterministic behaviour.
> > So there is need for per cpu dedicated IRQ stack for ARM.
> >
> > As ARm does not have extra co-processor register
> > to save thread info pointer, IRQ stack will be at some
> > performance cost, so code is under CONFIG_IRQ_STACK.
> >
> > and we don't have much knowledge and set up for CLANG
> > and ARM_UNWIND, so dependency added for both cases.
> >
> > Tested patch set with QEMU for latest kernel
> > and 4.1 kernel for ARM target with same patch set.
>
> You need to investigate and show where and why this is happening. My
> guess is you have a network driver that uses a lot of kernel stack
> space, which itself would be a bug.
>
> Note that there are compiler versions out there that mis-optimise and
> eat stack space - the kernel build should be warning if a function
> uses a large amount of stack.

For tracking down those not-super-helpful compiler warnings, I wrote a
tool where if you rebuild with debug info, and give it the object file
and string of the function the compiler warned about it will parse the
DWARF to tell you the size of each local variable, and if it came from
an inline frame.  Generally, it's possible to stack allocate something
that's way too big; instead those should be allocated on the heap.
https://github.com/ClangBuiltLinux/frame-larger-than
(I haven't had time to sit down and use it to resolve all outstanding
issues, but it has worked well for me in the past)
-- 
Thanks,
~Nick Desaulniers
