Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE8C2F6FB4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 01:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbhAOAuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 19:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbhAOAt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 19:49:59 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38ADC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 16:49:18 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id b3so4434149pft.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 16:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K9nC3QQZLVZ4Wv/SC3g8XKvTcDq2HllT/OIRGR+DemI=;
        b=eoaDMyvE9hEGLi2P02/5G7fMeSOZtY36oU4zD9eUgtpQQVNoNoLUIGrkTCNYjt0LVZ
         s032TNq6guNr9fdkr83bKlDcglJZO9xDsySf4Np+3+rirZPYEtrBwhWE/hU1Ggm1FaCc
         6a97Tyqe0uZC5A4Iyxz/zyoabFAP8bnGR0PagYQE+tVQFT0c9jpuzRjRrC+TKyCs/3y2
         D+Lr3L1Tc4iiuxmru4pwsxtQj8BXTsfvMyhOq3MjSUgjLuLJ/nOqcVOYxR7eeBnhFjcI
         Qv3utxK9onXvCKYUeylDHXP5ePqUcLe9wlp1mCnmh4VmfuUK0jUQFfgm8TS07/0RWfM/
         +oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K9nC3QQZLVZ4Wv/SC3g8XKvTcDq2HllT/OIRGR+DemI=;
        b=PXCl8A7WcBd38cA3nZEGfez1+nwy0g1hIpfQmRkv3baCMswCA3wlK2ABL0IEfXc66f
         i+Zy1mbKAoKAKkMvQsLMXyeO9uqjh/cqr0sOIhDC0q4S3h5vEdB6ksEiDOJOVcW+ZkJ+
         Hf2LwmgUmshzi7C+wA0Xt2uog3BTQpEG3kfRxwjO6SBSnkOGYwJYHKPAV6rFdXsJFspz
         qQBmYWCqxxOOT8fuhGAXe2FylVTWgyW9xcDCNXEk3ngMmwROHzWYowKI9CIE7CKMoKjP
         DrqMGfyQ1QODRCkhlnl3Ua/9BtPWldSebfcnw4emdMTujv2C68mgr5Aaa6woq6Zk+rJ0
         5cTA==
X-Gm-Message-State: AOAM532zG3L8XC5gWAswdYLNePvhIPE45jKFa/MavMp+XJ2z5nDkaMJ3
        XLpRy9ifZcf0MqLwQxPdHFgMsY3VdDPtfSmaI+6A4A==
X-Google-Smtp-Source: ABdhPJyQfgK3ShGyhXp9/MtVdv3b081GHz5Y1Zj3YyZ0kTUGqOCRcf/Sb56ACCdH0EAe/aHSwusTPq6Oxw2VVTbk4tA=
X-Received: by 2002:a63:1f47:: with SMTP id q7mr10150136pgm.10.1610671758192;
 Thu, 14 Jan 2021 16:49:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610652862.git.jpoimboe@redhat.com> <CABCJKudgPc5FFAD5BKX2dK7BJYs_Dpa_JRFgKgGh8b2Xs6khUA@mail.gmail.com>
In-Reply-To: <CABCJKudgPc5FFAD5BKX2dK7BJYs_Dpa_JRFgKgGh8b2Xs6khUA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Jan 2021 16:49:07 -0800
Message-ID: <CAKwvOd=J9LykjdzRLZ73uzd_BJaZUhO7uhNgF=FOHL4uDaRjHg@mail.gmail.com>
Subject: Re: [PATCH 00/21] objtool: vmlinux.o and CLANG LTO support
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Miroslav Benes <mbenes@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 4:41 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> I can confirm that all the warnings I previously saw are now fixed,
> but I'm seeing a few new ones:
>
> vmlinux.o: warning: objtool: balance_leaf_when_delete()+0x17d4: stack
> state mismatch: cfa1=7+192 cfa2=7+176
> vmlinux.o: warning: objtool: internal_move_pointers_items()+0x9f7:
> stack state mismatch: cfa1=7+160 cfa2=7+176
> vmlinux.o: warning: objtool: strncpy_from_user()+0x181: call to
> do_strncpy_from_user() with UACCESS enabled
> vmlinux.o: warning: objtool: strnlen_user()+0x12b: call to
> do_strnlen_user() with UACCESS enabled
> vmlinux.o: warning: objtool: i915_gem_execbuffer2_ioctl()+0x390: call
> to __ubsan_handle_negate_overflow() with UACCESS enabled

^ https://github.com/ClangBuiltLinux/linux/issues/1246, FWIW

> vmlinux.o: warning: objtool: .text.snd_trident_free_voice: unexpected
> end of section
>
> I haven't had a chance to take a closer look yet, but some of these
> are probably related to
> https://github.com/ClangBuiltLinux/linux/issues/1192. However, I can
> reproduce these also with ToT Clang, not just with Clang 11.
>
> Sami



-- 
Thanks,
~Nick Desaulniers
