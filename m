Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326B228561B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 03:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgJGBQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 21:16:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgJGBQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 21:16:23 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15E7E207EA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 01:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602033382;
        bh=larqh/Ss0SS1K6WLUhcJSM7WQfj+/MkCFwSauHcYI30=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IPIkDm/YmZl+Zli/+slyQg7Xb0SXOC8Pj+XOdIxNQRxIGPes77SessZzdxSbaa3w5
         1GNMaqJZVzQduHpgZuY/2Hm4uincpHlUaaRgC8aPSVtZVOUudp52UYHBv808e5Gyi/
         bbQ+TD1MhCttbMRD6aItBbPcvh4EE7qpvUcHpWqU=
Received: by mail-wr1-f49.google.com with SMTP id t10so262665wrv.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 18:16:22 -0700 (PDT)
X-Gm-Message-State: AOAM530Y5q6AEc4u7+FhaXYuIFxrvb7Momw9fTsVtTH6TNal1BQ3yTo4
        8Xl0cMK4eKs+QrzKoX+yHQ2/1rwthQCV60i2E7TAOQ==
X-Google-Smtp-Source: ABdhPJz8FM/uMEtB1LjafBVpbEgvN8M+AHJZ5Aw7WZ1OMaLTJTfrFm6GbWju6C6yaFjZQtVXqY8kt8pGPOj2H+hwcdQ=
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr616084wrb.70.1602033380467;
 Tue, 06 Oct 2020 18:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601925251.git.luto@kernel.org> <4b3b4fbf8e9806840135e95cef142a0adefc3455.1601925251.git.luto@kernel.org>
 <CAMzpN2iTceq90wMU7O5jDDq4KH_AWF-AbajNowp_xvkGWxuwCw@mail.gmail.com>
In-Reply-To: <CAMzpN2iTceq90wMU7O5jDDq4KH_AWF-AbajNowp_xvkGWxuwCw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 6 Oct 2020 18:16:07 -0700
X-Gmail-Original-Message-ID: <CALCETrXcFDZ4U_nkDK=r4WBmWtM954roGzNY_vBxippUiBTjTg@mail.gmail.com>
Message-ID: <CALCETrXcFDZ4U_nkDK=r4WBmWtM954roGzNY_vBxippUiBTjTg@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/stackprotector/32: Make the canary into a regular
 percpu variable
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 6, 2020 at 10:14 AM Brian Gerst <brgerst@gmail.com> wrote:
>
> On Mon, Oct 5, 2020 at 3:31 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On 32-bit kernels, the stackprotector canary is quite nasty -- it is
> > stored at %gs:(20), which is nasty because 32-bit kernels use %fs for
> > percpu storage.  It's even nastier because it means that whether %gs
> > contains userspace state or kernel state while running kernel code
> > sepends on whether stackprotector is enabled (this is
> > CONFIG_X86_32_LAZY_GS), and this setting radically changes the way
> > that segment selectors work.  Supporting both variants is a
> > maintenance and testing mess.
> >
> > Merely rearranging so that percpu and the stack canary
> > share the same segment would be messy as the 32-bit percpu address
> > layout isn't currently compatible with putting a variable at a fixed
> > offset.
> >
> > Fortunately, GCC 8.1 added options that allow the stack canary to be
> > accessed as %fs:stack_canary, effectively turning it into an ordinary
> > percpu variable.  This lets us get rid of all of the code to manage
> > the stack canary GDT descriptor and the CONFIG_X86_32_LAZY_GS mess.
> >
> > This patch forcibly disables stackprotector on older compilers that
> > don't support the new options and makes the stack canary into a
> > percpu variable.
>
> This doesn't consider !SMP builds, where per-cpu variable are just
> normal variables, and the FS segment is disabled.  Unfortunately,
> -mstack-protector-guard-reg=ds is not accepted.  The simplest fix
> would be to define  __KERNEL_PERCPU when either SMP or STACKPROTECTOR
> are enabled.

I don't love this because it breaks the "stack canary is just a
regular PERCPU variable" idea.  GCC accepts
-mstack-protector-guard=global to get rid of the segment override, but
then it ignores -mstack-protector-guard-offset=stack_canary.  So I
could do this:

#ifdef CONFIG_SMP
EXPORT_PER_CPU_SYMBOL(stack_canary);
#else
/*
 * GCC can't use a symbol called 'stack_canary' as the stack canary with
 * an FS or GS segment override, and SMP=n percpu variables are just normal
 * variables.  But GCC can use '__stack_chk_guard'.
 */
extern unsigned long __attribute__((alias("stack_canary"))) __stack_chk_guard;
EXPORT_SYMBOL(__stack_chk_guard);
#endif

Or I suppose I could just rename the thing __stack_chk_guard.  The
only downside of the latter seems to be that an accidental mix of SMP
and !SMP object files (or modules!) would crash, but I suppose they
likely crash anyway.
