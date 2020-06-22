Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68157204110
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 22:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbgFVUII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 16:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbgFVUIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:08:05 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACCCC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:08:05 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n24so20757271lji.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O1iewzZxKxZsHCFE1IpIKZAcHdEXX0k0VhJhMjCxJRk=;
        b=jxiFrV3w0j5aLn+vYERXrsFANe18BmkW8WhpfbwrqvZCR3QlASLHN+s0dvUKCC7S0Z
         HHlQLoUjWeB77nDpLPWTX2cD+NqKKStkAUVgrU+ZbFo1WfJUCp3PbvnavLvRJJfywm9B
         PS8KIdxPs6dMefugAy/F3KfgHucAWcr7w9gXuUdcHllmvBB4qZe8A4Bp1EsirM9H8PWJ
         v3uvp+OkmO1pC5tsQ4XX81pf9YCj8Gokg9OWfBfubRYEyWUdvxonrCWsPW+wes77jqgR
         h6ape1nNvKoIrkpKbq7TDwpAj4bHv9zDGppyQfT3YxAm8q0kqdPmVMD48RqJ0ih/c0dw
         +hLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O1iewzZxKxZsHCFE1IpIKZAcHdEXX0k0VhJhMjCxJRk=;
        b=j+5WmGtb8NeCDZ3tITGZUZJePnjShqIB+uvhyGov4CM4mk3OT2kUw10dJXH9lnKF0e
         9QxTGbnlocJ7+1xSNBYflNI/9Dtw5zzcCLGY1/5IluUpoincro2QB6Pe5SeFRzpysg6H
         aY1XmVr8P6kWGJg+W3zUFIXrZ6cSvTGj9qrrJxYQqduyWxCdXkA9vaeI+oCFMCdhEc9h
         kFUCRZnnPMbBDwjz10yL8bp1jTqhq7glF0UL2PG5+mBgQS5U03a96A5WWY4Xnli6BjTK
         mlv7ITQfL6zh095dp1rKOcsOED/s5tDct7hd26hCOXz44ec/qwNzJa4hSpMN5jnmtw+S
         lbUA==
X-Gm-Message-State: AOAM532lMOUkOPOZXJij5IUmOF0TD9DojIEl1n/PCiLo0dsyXfeIwe2Z
        n2ri7Zy7HnmO6whOKZZEy2bdig5hBg5Oi0xSmS+3KA==
X-Google-Smtp-Source: ABdhPJy5dWzQBSNi9Zt/usqkY9agJUTDidKHpdWxCl7nmtqE+I17wPTUgLZYCHA4VjDO1Von9AZ6ddnuU6GBJyOUNKU=
X-Received: by 2002:a2e:9a44:: with SMTP id k4mr9089871ljj.139.1592856483831;
 Mon, 22 Jun 2020 13:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200622193146.2985288-1-keescook@chromium.org> <20200622193146.2985288-4-keescook@chromium.org>
In-Reply-To: <20200622193146.2985288-4-keescook@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 22 Jun 2020 22:07:37 +0200
Message-ID: <CAG48ez0pRtMZs3Hc3R2+XGHRwt9nZAGZu6vDpPBMbE+Askr_+Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] stack: Optionally randomize kernel stack offset
 each syscall
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 9:31 PM Kees Cook <keescook@chromium.org> wrote:
> This provides the ability for architectures to enable kernel stack base
> address offset randomization. This feature is controlled by the boot
> param "randomize_kstack_offset=on/off", with its default value set by
> CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT.
[...]
> +#define add_random_kstack_offset() do {                                        \
> +       if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT, \
> +                               &randomize_kstack_offset)) {            \
> +               u32 offset = this_cpu_read(kstack_offset);              \
> +               u8 *ptr = __builtin_alloca(offset & 0x3FF);             \
> +               asm volatile("" : "=m"(*ptr));                          \
> +       }                                                               \
> +} while (0)

clang generates better code here if the mask is stack-aligned -
otherwise it needs to round the stack pointer / the offset:

$ cat alloca_align.c
#include <alloca.h>
void callee(void);

void alloca_blah(unsigned long rand) {
  asm volatile(""::"r"(alloca(rand & MASK)));
  callee();
}
$ clang -O3 -c -o alloca_align.o alloca_align.c -DMASK=0x3ff
$ objdump -d alloca_align.o
[...]
   0: 55                    push   %rbp
   1: 48 89 e5              mov    %rsp,%rbp
   4: 81 e7 ff 03 00 00    and    $0x3ff,%edi
   a: 83 c7 0f              add    $0xf,%edi
   d: 83 e7 f0              and    $0xfffffff0,%edi
  10: 48 89 e0              mov    %rsp,%rax
  13: 48 29 f8              sub    %rdi,%rax
  16: 48 89 c4              mov    %rax,%rsp
  19: e8 00 00 00 00        callq  1e <alloca_blah+0x1e>
  1e: 48 89 ec              mov    %rbp,%rsp
  21: 5d                    pop    %rbp
  22: c3                    retq
$ clang -O3 -c -o alloca_align.o alloca_align.c -DMASK=0x3f0
$ objdump -d alloca_align.o
[...]
   0: 55                    push   %rbp
   1: 48 89 e5              mov    %rsp,%rbp
   4: 48 89 e0              mov    %rsp,%rax
   7: 81 e7 f0 03 00 00    and    $0x3f0,%edi
   d: 48 29 f8              sub    %rdi,%rax
  10: 48 89 c4              mov    %rax,%rsp
  13: e8 00 00 00 00        callq  18 <alloca_blah+0x18>
  18: 48 89 ec              mov    %rbp,%rsp
  1b: 5d                    pop    %rbp
  1c: c3                    retq
$

(From a glance at the assembly, gcc seems to always assume that the
length may be misaligned.)

Maybe this should be something along the lines of
__builtin_alloca(offset & (0x3ff & ARCH_STACK_ALIGN_MASK)) (with
appropriate definitions of the stack alignment mask depending on the
architecture's choice of stack alignment for kernel code).
