Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8722B552A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 00:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgKPXiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 18:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgKPXiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 18:38:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B00C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 15:38:02 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605569878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8OefT95E+juRmGEV5SggOLfq6zFjKC+jmvYROztnl1c=;
        b=CK1aV41u6ajjJ5Jx7htyBJ8AFtFRYFX1EJB3L+tCBkgfblOTLIFeU+ijxKh2hWYyh4X44/
        4gBEdtIL0bn61o2K3D22tf4dwkk6VCjpUorz/bpgKjf6KimmJjRkWBv619uBFC17VMBfp4
        D1MXEZ+woHLKOx8rYP+5ly7571c0yGkCVfA+hTranmfxfLMVKfyVZjNzi6suyIb/Mv8KnF
        YOSr04AavSRS3xZIk4ndgiAnpMyRcwV/e6vUb37EhVcrDFJypC//Q6yCy3ShPMDIbJhwPL
        M/gxoR22TFGZR11MuIVT4m1V6jhtfBpdK58lmF/pvINvQeH+V2Y9+CITykdx/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605569878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8OefT95E+juRmGEV5SggOLfq6zFjKC+jmvYROztnl1c=;
        b=SorRIQfCDbuLskoZtgFCU/9PyP4zUUadxNeIhtkSZOsN4P/eAMzTysGD0H6FpdMaEkhgHc
        3YXVBr64OGg9fcDQ==
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Borislav Petkov <bp@alien8.de>, Oleg Nesterov <oleg@redhat.com>,
        Mark Mossberg <mark.mossberg@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jann Horn <jannh@google.com>,
        kyin@redhat.com
Subject: Re: [PATCH v2] x86/dumpstack: Fix misleading instruction pointer error message
In-Reply-To: <CALCETrW+Jek_t51RyqxO=HUA_PJ4APwS9hJQWsXyc426cgf0wA@mail.gmail.com>
References: <20201002042915.403558-1-mark.mossberg@gmail.com> <20201103125034.GA30391@redhat.com> <20201103171537.GC4111@zn.tnic> <20201103174744.GB23992@redhat.com> <20201103175237.GD4111@zn.tnic> <20201103181114.GC23992@redhat.com> <20201103182018.GE4111@zn.tnic> <87blfxx8ps.fsf@nanos.tec.linutronix.de> <CALCETrW+Jek_t51RyqxO=HUA_PJ4APwS9hJQWsXyc426cgf0wA@mail.gmail.com>
Date:   Tue, 17 Nov 2020 00:37:58 +0100
Message-ID: <878sb0yisp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16 2020 at 15:04, Andy Lutomirski wrote:

> On Mon, Nov 16, 2020 at 2:01 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>  arch/x86/kernel/dumpstack.c |   23 +++++++++++++++++++----
>>  1 file changed, 19 insertions(+), 4 deletions(-)
>>
>> --- a/arch/x86/kernel/dumpstack.c
>> +++ b/arch/x86/kernel/dumpstack.c
>> @@ -78,6 +78,9 @@ static int copy_code(struct pt_regs *reg
>>         if (!user_mode(regs))
>>                 return copy_from_kernel_nofault(buf, (u8 *)src, nbytes);
>>
>> +       /* The user space code from other tasks cannot be accessed. */
>> +       if (regs != task_pt_regs(current))
>> +               return -EPERM;
>
> Depending on exactly where this gets called, this may not be
> sufficient.  You should also check nmi_uaccess_okay().

which is what copy_from_user_nmi() already does.
