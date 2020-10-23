Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15836297863
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 22:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756295AbgJWUmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 16:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756266AbgJWUmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 16:42:52 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20B0C20BED
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 20:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603485772;
        bh=Fk71VNnpG9mPOHqXxWhqfVK24UDAqMPprfF4A9wGV5s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R+l99qoyzsqml9wORw+7aeHGQ8iEWi7TOQoVrQd7BnBuUqU79Jxgzn/P85uwdU8Fu
         ASigjKT9LMHwW52ZLFo5ZyOdUQBHZ/U5+JJbNc6bA7VppmnJ2+lkLAqVX8nPB1dZj7
         OKIcHvqnbRJCDLOyoP5mWrK53/FBERrBOAmU+LB8=
Received: by mail-wm1-f49.google.com with SMTP id d3so3468277wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 13:42:52 -0700 (PDT)
X-Gm-Message-State: AOAM533CE2euwFigLGKbMUroaQbhtg2N2aKdsyvCSlChdadb0imrS7cQ
        So9WoyR8NYoImVXSPlwpq1qi7VI+uH122tqRwEj0wg==
X-Google-Smtp-Source: ABdhPJx9NAuv8RFi6FX6awEeSvLmO0kBiBByqi38GuPuavVBNlmyR4Z/5bZyJ0d5tSG1B60Y+3H9j8RjmbAGn4ZhdEE=
X-Received: by 2002:a05:600c:2241:: with SMTP id a1mr4254477wmm.49.1603485770484;
 Fri, 23 Oct 2020 13:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201023203154.27335-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20201023203154.27335-1-linux@rasmusvillemoes.dk>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 23 Oct 2020 13:42:39 -0700
X-Gmail-Original-Message-ID: <CALCETrV2rzowdWqhEG7v-hmbUOpNHsBz-hR1RdxBFKuwU6rDTA@mail.gmail.com>
Message-ID: <CALCETrV2rzowdWqhEG7v-hmbUOpNHsBz-hR1RdxBFKuwU6rDTA@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: fix code generation in put_user()
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 1:32 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> Quoting
> https://gcc.gnu.org/onlinedocs/gcc/Local-Register-Variables.html:
>
>   You can define a local register variable and associate it with a
>   specified register...
>
>   The only supported use for this feature is to specify registers for
>   input and output operands when calling Extended asm (see Extended
>   Asm). This may be necessary if the constraints for a particular
>   machine don't provide sufficient control to select the desired
>   register.
>
> On 32-bit x86, this is used to ensure that gcc will put an 8-byte
> value into the %edx:%eax pair, while all other cases will just use the
> single register %eax (%rax on x86-64). While the _ASM_AX actually just
> expands to "%eax", note this comment next to get_user() which does
> something very similar:
>
>  * The use of _ASM_DX as the register specifier is a bit of a
>  * simplification, as gcc only cares about it as the starting point
>  * and not size: for a 64-bit value it will use %ecx:%edx on 32 bits
>  * (%ecx being the next register in gcc's x86 register sequence), and
>  * %rdx on 64 bits.
>
> However, getting this to work requires that there is no code between
> the assignment to the local register variable and its use as an input
> to the asm() which can possibly clobber any of the registers involved
> - including evaluation of the expressions making up other inputs.

This looks like the patch is an improvement, but this is still IMO
likely to be very fragile.  Can we just do the size-dependent "a" vs
"A" selection method instead?  Sure, it's a little more code, but it
will be Obviously Correct.  As it stands, I can easily see our code
failing on some gcc or clang version and the compiler authors telling
us that we're relying on unsupportable behavior.
