Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC70E2B9B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 20:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgKSTcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 14:32:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35606 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgKSTcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 14:32:45 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605814363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1nEiuqX8D0Hjh49w7YgahfQzlRwYTomndSpFA0ZJvps=;
        b=Y25WU2VG/1hnFuBZRBYGMNOzLjY56C7Zjf2LBbgYu/AuZ8qppdvAQSfjxX9rpU5G2Z9hsm
        crWxEJB4d9AS9Zga6wOiY4mjLENKCuUJfi+MX6X7cOJxqURlPgV8Bu4U9/x3Ls8LoU+yW7
        cH1KiJIcWM3l39Ie1MPW5RWqtf/OZwQnjGorXG7esov/tqyFW1zUMv+KmdgTpfcC+s2DAl
        dSphrHUGrAGYRRby9dn6/NXjnIXSWBYVWh3R6bAV1JfoHJUbviPWn5on3BNDiKCX11qKXx
        GWsJbKzzzb7/d6vRXKTyUxzfKnPveIQmGFXXzABfTcJ365A7kAdN6F7wJ3z93A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605814363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1nEiuqX8D0Hjh49w7YgahfQzlRwYTomndSpFA0ZJvps=;
        b=Yttwd3PPzvJap/9bPlXWHLsi05ynqDcWEKomY3HiJ0AtEldJAvzadBu+kBCr4T7opulLiK
        uNds7+EHDN8DSiAQ==
To:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        jroedel@suse.de, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, junaids@google.com, oweisse@google.com,
        rppt@linux.vnet.ibm.com, graf@amazon.de, mgross@linux.intel.com,
        kuzuno@gmail.com
Subject: Re: [RFC][PATCH v2 00/21] x86/pti: Defer CR3 switch to C code
In-Reply-To: <692599af-53c8-7881-2bc7-8898085400cd@oracle.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com> <20201116202426.GF1131@zn.tnic> <692599af-53c8-7881-2bc7-8898085400cd@oracle.com>
Date:   Thu, 19 Nov 2020 20:32:42 +0100
Message-ID: <87a6vdp2g5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17 2020 at 09:19, Alexandre Chartre wrote:
> On 11/16/20 9:24 PM, Borislav Petkov wrote:
>> On Mon, Nov 16, 2020 at 03:47:36PM +0100, Alexandre Chartre wrote:
>> So PTI was added exactly to *not* have kernel memory mapped in the user
>> page table. You're partially reversing that...
>
> We are not reversing PTI, we are extending it.

You widen the exposure surface without providing an argument why it is safe.

> PTI removes all kernel mapping from the user page-table. However there's
> no issue with mapping some kernel data into the user page-table as long as
> these data have no sensitive information.

Define sensitive information. 

> Actually, PTI is already doing that but with a very limited scope. PTI adds
> into the user page-table some kernel mappings which are needed for userland
> to enter the kernel (such as the kernel entry text, the ESPFIX, the
> CPU_ENTRY_AREA_BASE...).
>
> So here, we are extending the PTI mapping so that we can execute more kernel
> code while using the user page-table; it's a kind of PTI on steroids.

Let's just look at a syscall:

noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
{
	long ret;

	enter_from_user_mode(regs);
          lockdep_hardirqs_off();
          user_exit_irqoff();
          trace_hardirqs_off_finish();

So just looking at the 3 calls above, how are you going to guarantee
that everything these callchains touch is mapped into user space?

Not to talk about everything which comes after that.

Thanks,

        tglx


