Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B05427767E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgIXQTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:19:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgIXQTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:19:50 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03DC52311B;
        Thu, 24 Sep 2020 16:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600964389;
        bh=r00IuGK5X4M7N6a9KOcuaC8vPlLWVqhKALShVxiGX1k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J8IIsKYi2Sg1I974iLW774RlXPH4NpiJIHTCb40J2Kg5XuyCH70i3/2ElWkQC4dLl
         VIa/s7z3oKL0Y5ZO2WHgzdjvS81cW4H3GK23R4h3sBFEHcd939hMI6uFOA04s4haSp
         xuoTdJh0UgzRKbYb/hnhHLcmAQRNY8PysRdFdkfI=
Received: by mail-lf1-f41.google.com with SMTP id w11so4615496lfn.2;
        Thu, 24 Sep 2020 09:19:48 -0700 (PDT)
X-Gm-Message-State: AOAM531fY8mjW4vt2oAwjn/poTUstmpQCHyb/pmecbxYJTYLwKTZrLrT
        tqa2A8KnxL2mDfylRnMofLPJk8ekAH6j+lYcIPA=
X-Google-Smtp-Source: ABdhPJxK14YFyUBWy6SgCJIl22YZISDj8RkvTJ370I4zSII4adfInU3jERuIkf/bpKmN5pFlCasStitlaM5OzKK+AJg=
X-Received: by 2002:ac2:5e99:: with SMTP id b25mr82111lfq.248.1600964387152;
 Thu, 24 Sep 2020 09:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <1593266228-61125-1-git-send-email-guoren@kernel.org>
 <1593266228-61125-2-git-send-email-guoren@kernel.org> <20200911204512.GA2705@aurel32.net>
 <CAJF2gTQiLV8sDE5cnvP=aBog4zaiMvMeieg_JtXwRODky1u3Hg@mail.gmail.com>
 <20200914103836.GB2705@aurel32.net> <87lfgzeidk.fsf@igel.home>
In-Reply-To: <87lfgzeidk.fsf@igel.home>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 25 Sep 2020 00:19:35 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ8ONde3GRhQgx2Nqvb5X20nTmW8jZEemZKhezRDzP3aQ@mail.gmail.com>
Message-ID: <CAJF2gTQ8ONde3GRhQgx2Nqvb5X20nTmW8jZEemZKhezRDzP3aQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] riscv: Fixup static_obj() fail
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Nick Hu <nickhu@andestech.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How about this, revert the commit and don't free INIT_DATA_SECTION. I
think the solution is safe enough, but wast a little memory.

diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index f3586e3..34d00d9 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -22,13 +22,11 @@ SECTIONS
        /* Beginning of code and text segment */
        . = LOAD_OFFSET;
        _start = .;
-       _stext = .;
        HEAD_TEXT_SECTION
        . = ALIGN(PAGE_SIZE);

        __init_begin = .;
        INIT_TEXT_SECTION(PAGE_SIZE)
-       INIT_DATA_SECTION(16)
        . = ALIGN(8);
        __soc_early_init_table : {
                __soc_early_init_table_start = .;
@@ -55,6 +53,7 @@ SECTIONS
        . = ALIGN(SECTION_ALIGN);
        .text : {
                _text = .;
+               _stext = .;
                TEXT_TEXT
                SCHED_TEXT
                CPUIDLE_TEXT
@@ -67,6 +66,8 @@ SECTIONS
                _etext = .;
        }

+       INIT_DATA_SECTION(16)
+
        /* Start of data section */
        _sdata = .;
        RO_DATA(SECTION_ALIGN)

On Thu, Sep 24, 2020 at 3:36 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Sep 14 2020, Aurelien Jarno wrote:
>
> > How should we proceed to get that fixed in time for 5.9? For the older
> > branches where it has been backported (so far 5.7 and 5.8), should we
> > just get that commit reverted instead?
>
> Can this please be resolved ASAP?
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
