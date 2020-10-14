Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5C228DC52
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgJNJEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJNJEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:04:36 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E610BC045859
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:25:01 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id l16so3697977ilt.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HalJUEgFIroij+eVjjsAaxpPGCzHis17qTK2euMmLBY=;
        b=Yf93tejX2acPPVAbX3fnj9NQ+N4grno48CwAjUD2YEfuAK8dXqW7uVhkBgvOXsaRng
         2oWEHB+FYe0fJogNf8rlXPfWs4AjufA9G4rrbELfmtk0hPm0XX7c3DWLOXiNiBZYLlpT
         lv4ka4i0CCQSHRxSKjbcQeKWaxNbAdvUceJBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HalJUEgFIroij+eVjjsAaxpPGCzHis17qTK2euMmLBY=;
        b=VGdDSVggqD0L3TcNUuE4BMOlTolpebVbJTdDZIe+glRb6rc5Jzajpsh4OGpX5GTAga
         lmI7eq8BBLcvusXAavhRuEFPDUw1xBrrh8Oz3kADdsXZIVWOoHHZRrKxqsuccYJemgz9
         mbGn7qmPRxocNRcUN5vAszmnqmFUCldTMsAAy+K9RYN3lp/fV7+T9t5tPKpNpZIx6clL
         5Z890QpUw+uYyOePYnRw6Ws9fNPw92wuEOtV1DtnUcPzkY9hBcNnKcMtNC3EneWUViJT
         VgYyOMKj5e0GioYrWbCMWs+zm5CiYnl34CIaNrbfRgnOCNM/k2/RQnS2KZwUeo0Lav8m
         fgtw==
X-Gm-Message-State: AOAM531PHkhaw9V/QNChLnxCgF/Xg49WeNTerKRRxzqY6AxviMyp3AF4
        boDn+WY020MWK8d1UWo+PBvHvv5IIRfIJG9jia2x
X-Google-Smtp-Source: ABdhPJwf5ma2+TlQJuxWd0JmN6mHEFluk9xAS3AZTnyBzNZQxJhicG5AlpYDoDF2Efr0i5KblnAPSIvNbm5CBVdBb7E=
X-Received: by 2002:a92:91db:: with SMTP id e88mr2506931ill.126.1602653100856;
 Tue, 13 Oct 2020 22:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201009211344.2358688-1-atish.patra@wdc.com> <20201009211344.2358688-5-atish.patra@wdc.com>
 <CAHCEehJvMv=CYD1+QXb0uB36Hv4pvO36BAKSLOcxTXvmADZFbA@mail.gmail.com>
 <CAOnJCUKPjkm_=5eHn6=GjVGr67okZkVzqP7-ciphn986BQoc9w@mail.gmail.com>
 <CAOnJCULZMRu+sHmnjoBwtvaB3BjmCiZLzYxNOeWZmoYLKG+wTw@mail.gmail.com>
 <CAHCEehJJmLQ6W5AdH+hEZSJxpDC8HG0UN=EGt9M0Tp5NTfQnaw@mail.gmail.com>
 <CAOnJCUJN-XMZ+N5w+RbVhJag9D_dey7DAopb0Q35GDfXptyMjA@mail.gmail.com> <CAFyWVaYORWYZTXyXOWiY6xK-SFTvsUxDNDqKQnhVUwzc5N045Q@mail.gmail.com>
In-Reply-To: <CAFyWVaYORWYZTXyXOWiY6xK-SFTvsUxDNDqKQnhVUwzc5N045Q@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 13 Oct 2020 22:24:49 -0700
Message-ID: <CAOnJCU+3xFyFW4ATCdYAv5zVyBSLE0mTevrJLCXW7HDgy4D4EQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] RISC-V: Protect .init.text & .init.data
To:     Jim Wilson <jimw@sifive.com>
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

On Tue, Oct 13, 2020 at 6:21 PM Jim Wilson <jimw@sifive.com> wrote:
>
> On Tue, Oct 13, 2020 at 3:25 PM Atish Patra <atishp@atishpatra.org> wrote:
> > This happens only when copy_from_user is called from function that is
> > annotated with __init.
> > Adding Kito & Jim for their input
> >
> > @kito, @Jim: Please let me know if I should create a issue in
> > riscv-gnu-toolchain repo or somewhere else.
>
> I can't do anything useful without a testcase that I can use to
> reproduce the problem.  The interactions here are complex, so pointing
> at lines of code or kernel config options doesn't give me any useful
> info.
>
> Relaxation can convert calls to a jal.  I don't know of any open bugs
> in this area that can generate relocation errors.  if it is a
> relaxation error then turning off relaxation should work around the
> problem as you suggested.
>
> A kernel build problem is serious.  I think this is worth a bug
> report.  FSF binutils or riscv-gnu-toolchain is fine.
>

I have created an issue with detailed descriptions and reproduction steps.
Please let me know if you need anything else.

> Jim



-- 
Regards,
Atish
