Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1301128DD2C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgJNJWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731175AbgJNJV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:21:56 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA4DC014B23
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 18:21:01 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e22so2451640ejr.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 18:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WXuyKKLXCqER0qiq8dEKjvLqiC2JwcKFo8wUFhLVXXU=;
        b=OlSx2JyLc3ZRSaS4Ush40RMl6iu1oAuZL44sPnos7VI6GgTpIlVBcu4SeP04Wb00iP
         fjmZElvM54tmZk76lQJRvczhdM9Ynjtx+kdckBXgqP0tGfLDsdkXMM45PsJWyh3GZA0E
         Ee3o/wZP1eWqCAXlOdn9kDOOVqLYYxtPiROehkrcCsPAAm09cZutlXA9BwpCPEkZtSVL
         MIBilxrb4v4MR5ExbSAdNrTMNw/Mv5Y3+lEHaAuT7uUprXPRq1QjzTfv91klKRsesQjF
         SYFI/UkKVWDwYSY2zms4LlEdsutRZjgb0VB5hZnN4m7RNQFTuq6wBmhdD2DZ18FiG4PA
         UMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WXuyKKLXCqER0qiq8dEKjvLqiC2JwcKFo8wUFhLVXXU=;
        b=MdP18dQntqfU7sO/P+3tf4E3o9+9yv+WQRW2z/Ey/0soyR0UPi33pZTzfX2/wEiBn5
         6Cw35ZLiPJ65Wv4AJKiwZLZKtbcxK4a+/3Ty0IvXCaN5vyfxGkoRbIajJuCHjB0JLBdt
         lpNRjJN4W0Zjsz75/8PdSb01PRZ9Mw8MBfk8lR+eXl88UoYlASmRYsewo0Qb9+Yk7Qke
         6hzfjfarIkgyA16Ct5oc3+8IGU97/fGH7ANaYPLF0JmRpj+eT+vw7ifAiOqtfaZqor0X
         fn1wSEahcTyUeX4L2fRyJNi79HXMz0Dfcvy1ntOEVXM93U0+JKdSJIvkT9mzj2j9cBfa
         Jvdg==
X-Gm-Message-State: AOAM531BbpPr7JZpXz7qQSy812slFu9rhveiJutSaIAHo/IE17qNIg5y
        QJ74QG1QulaQNXGl432CFzdAb6UwwaKxQKuyi1bVGg==
X-Google-Smtp-Source: ABdhPJxOLC3V5GhsZMjTnGSD3kKfhedcEUNthv9S6Bb6G58zxDEcxUDNyO0K2ysIawYcu27qC5i1mFEmxzBFOyDQ9VA=
X-Received: by 2002:a17:906:9396:: with SMTP id l22mr2751325ejx.36.1602638460222;
 Tue, 13 Oct 2020 18:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201009211344.2358688-1-atish.patra@wdc.com> <20201009211344.2358688-5-atish.patra@wdc.com>
 <CAHCEehJvMv=CYD1+QXb0uB36Hv4pvO36BAKSLOcxTXvmADZFbA@mail.gmail.com>
 <CAOnJCUKPjkm_=5eHn6=GjVGr67okZkVzqP7-ciphn986BQoc9w@mail.gmail.com>
 <CAOnJCULZMRu+sHmnjoBwtvaB3BjmCiZLzYxNOeWZmoYLKG+wTw@mail.gmail.com>
 <CAHCEehJJmLQ6W5AdH+hEZSJxpDC8HG0UN=EGt9M0Tp5NTfQnaw@mail.gmail.com> <CAOnJCUJN-XMZ+N5w+RbVhJag9D_dey7DAopb0Q35GDfXptyMjA@mail.gmail.com>
In-Reply-To: <CAOnJCUJN-XMZ+N5w+RbVhJag9D_dey7DAopb0Q35GDfXptyMjA@mail.gmail.com>
From:   Jim Wilson <jimw@sifive.com>
Date:   Tue, 13 Oct 2020 18:20:49 -0700
Message-ID: <CAFyWVaYORWYZTXyXOWiY6xK-SFTvsUxDNDqKQnhVUwzc5N045Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] RISC-V: Protect .init.text & .init.data
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Greentime Hu <greentime.hu@sifive.com>,
        Kito Cheng <kito.cheng@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Anup Patel <anup@brainfault.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Michel Lespinasse <walken@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 3:25 PM Atish Patra <atishp@atishpatra.org> wrote:
> This happens only when copy_from_user is called from function that is
> annotated with __init.
> Adding Kito & Jim for their input
>
> @kito, @Jim: Please let me know if I should create a issue in
> riscv-gnu-toolchain repo or somewhere else.

I can't do anything useful without a testcase that I can use to
reproduce the problem.  The interactions here are complex, so pointing
at lines of code or kernel config options doesn't give me any useful
info.

Relaxation can convert calls to a jal.  I don't know of any open bugs
in this area that can generate relocation errors.  if it is a
relaxation error then turning off relaxation should work around the
problem as you suggested.

A kernel build problem is serious.  I think this is worth a bug
report.  FSF binutils or riscv-gnu-toolchain is fine.

Jim
