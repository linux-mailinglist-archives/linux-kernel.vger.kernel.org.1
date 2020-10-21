Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B938C2948A0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 09:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437100AbgJUHKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 03:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436982AbgJUHKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 03:10:52 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1A1C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 00:10:51 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id m128so1085301oig.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 00:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t/G7MIqK+NBHfqzH6rZ1PdmS1knHg5JTFYQufZDq68M=;
        b=LSs4yKI9wS65l8r8fpRxqXk5x07ZeLSm6fAhoYh0RxmCH+roM+bIJshNV/QY9/tD7L
         ERh26aii8sdn80nguZIZuQICgo/J+KpYu3Ps/A1i3AzR+cl857JamiOfDaSD/hBp9gMn
         7vddbVaRtybJ5oLylMFCBsf0lXbeHxNV2PRLKcE6V0Xq9sCNTpQtNjHrAWmTB394TGm6
         qFnILdP/sfK51Mp87ZGveAkQN6wTob/ne2aCmKTbMxqtRSRvOWOAbzD2K6KJvwV13IbJ
         NXnx6FA+Q0906q7UshpIfkIEzYiQrxtJ6YmPmExcJwE31U7Hpty9AdUTa8NycmvrXn/+
         Q3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/G7MIqK+NBHfqzH6rZ1PdmS1knHg5JTFYQufZDq68M=;
        b=hOs9jhoJwTOO/ZObvvO2X6nt8cwblcwRsraJSPRu1UKnWQKk1UnX7oUH66V+CQxwTn
         8DI0oz+KlNWymFWWEekVuTkO8jFSIYADxD45oyAxEP4pQV2mGdBV+TpI+cuGMROdlbeC
         JYuDsr/QQCfoMs/8AhD0+ZdeGUjnPtXSEwWO/rCCmqSGQERMx+5SOMspXZBG4IhdiG0h
         AaH54XjK2OsS6XE9KoA1lrELDwB2o51FoBX9A/nrd5Sh4xhlDubx6yFg79D5lFaoFGxS
         FQql3FMJlJvMAgHQgfIPa2A65Fx+SsEHTGs1+YHKuMLkyeAwOyWgmOmypr7KsFFAyD/L
         PHzA==
X-Gm-Message-State: AOAM533MCz2qfRPjm7SI//AWEGv0X7+wvxwvoqR3LRF0AVsgUlMMt/7F
        bqOArdYSGBi3RZlrJdi/IBcjRXo3/OyoNFw/4kPlDg==
X-Google-Smtp-Source: ABdhPJz+Y36Nw9siV5fFGt0r0s5z3699GS0nBv6WffR9icsOv4oaCCCbH/Hl5XfvqWi9X/hf4w8a6lsYKcKjEMQd3Vk=
X-Received: by 2002:aca:54c3:: with SMTP id i186mr1216632oib.35.1603264251105;
 Wed, 21 Oct 2020 00:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <1602918377-23573-1-git-send-email-guoren@kernel.org>
 <1602918377-23573-10-git-send-email-guoren@kernel.org> <CAOnJCU+oTRcJ2p8WQDX5P-EsOHmkn3kP9s54VQa+iw2wXDvzkg@mail.gmail.com>
 <CAJF2gTSU+M+b+bn5zH_EyE7Ksh=5+ZkO8LkAn=Tm-p45CgYW1w@mail.gmail.com> <20201020164121.32626e45@gandalf.local.home>
In-Reply-To: <20201020164121.32626e45@gandalf.local.home>
From:   Zong Li <zong.li@sifive.com>
Date:   Wed, 21 Oct 2020 15:10:39 +0800
Message-ID: <CANXhq0pc5STcmZRP5HZXZ_SxqSRq=izStMV0VQyPNM1ayEzszg@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] riscv: Fixup lockdep_assert_held(&text_mutex) in patch_insn_write
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Guo Ren <guoren@kernel.org>, Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alan Kao <alankao@andestech.com>,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 4:41 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 20 Oct 2020 19:18:01 +0800
> Guo Ren <guoren@kernel.org> wrote:
>
> > > What platform are you testing ? We are seeing a crash while enabling
> > > any of the tracers multiple times
> > > on Qemu/HiFive Unleashed.
> > I use qemu for testing. I've changed dynamic ftrace mechanism from
> > mcount to -fpatchable-entry.
> >
> > The problem is made by the lockdep checking of text_mutex.
>
> If you are switching to "patchable-entry" you shouldn't need to use
> stop_machine for the updates. No?
>
> -- Steve

Hi all,

I'm going to send the patch to fix the problem. Ftrace was broken from
v5.3 kernel version, and only happen on SMP. The problem is caused by
the following two patches:

Commit 4ecf0a43e729a7e641d800c294faabe87378fc05 ("processor: get rid
of cpu_relax_yield")
and
Commit 366237e7b0833faa2d8da7a8d7d7da8c3ca802e5 ("stop_machine:
Provide RCU quiescent state in multi_cpu_stop()")

We have to mark these two functions as notrace. The stopped CPUs
cannot make function calls to traceable functions on RISC-V, the
function call instruction pattern needs two instructions (auipc,
jalr), so there is a change to execute the (auipc + nop) or (nop,
jalr) when patching code.

There is a similar fix as follow:
Commit cb9d7fd51d9fbb329d182423bd7b92d0f8cb0e01 ("watchdog: Mark
watchdog touch functions as notrace")

I have verified my patches, and I'm going to send it to the mailing
list these few days.
