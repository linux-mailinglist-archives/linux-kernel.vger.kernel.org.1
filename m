Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4149F2B9B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 20:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgKSTP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 14:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgKSTP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 14:15:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C99C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 11:15:56 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605813355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=00LmCFiCkBZbXLGMYseLaPYtcySGGBCwlb2kLV7GY1I=;
        b=jAVD3OkvzqvxyRLv4106msrFRJ6SYfVkSZUMfijm+1WcKcCOEo3W3KhGt1QGdDb3CX1LbH
        vehhiYsUrADO4baFifdSHPYTpDZWqDswAj36agg1V3IJ2hpz8+IuU7tkW1nBcotFTXGhJe
        8RbpihVMVyh3B4+QSP0oCZqZZa8V9YuYrA/RwsmUjOspfQ+NgU/KyLllP/re2fGeLAWm8C
        h8qBNqqa4tA8zNdjnEcPCOufVBWECRMdmwY6QumUJ98pO9MA6MmmW//rpr7Sf9loRn06Md
        9Aw8rq+KXwoJtVid/FOQOOnicBnBYJuSvS5kX7iibYfoer0HvaTiKsWl3R94wQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605813355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=00LmCFiCkBZbXLGMYseLaPYtcySGGBCwlb2kLV7GY1I=;
        b=+uewI+pz8Igij7JLcjUM5y/o1+0t4ajNpE2N6gXlpSlAO4YXPf9yziRpmKRM5KaDtWckg4
        UQaefyqPvgRf2FCw==
To:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        jan.setjeeilers@oracle.com, Junaid Shahid <junaids@google.com>,
        oweisse@google.com, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alexander Graf <graf@amazon.de>, mgross@linux.intel.com,
        kuzuno@gmail.com
Subject: Re: [RFC][PATCH v2 11/21] x86/pti: Extend PTI user mappings
In-Reply-To: <d4be0149-1a28-24e8-7821-e8c96f98a7ac@oracle.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com> <20201116144757.1920077-12-alexandre.chartre@oracle.com> <CALCETrXoykRjRPYPfZr6gBKoMnHuRYiJTDOcFYMq8GLef00j1A@mail.gmail.com> <820278dc-5f8e-6224-71b4-7c61819f68d1@oracle.com> <CALCETrXYP13pPcRfDDkwetLgzA3quYOBg7OTo5nbpLpPfSqaLw@mail.gmail.com> <d4be0149-1a28-24e8-7821-e8c96f98a7ac@oracle.com>
Date:   Thu, 19 Nov 2020 20:15:54 +0100
Message-ID: <87d009p385.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17 2020 at 09:42, Alexandre Chartre wrote:
> On 11/17/20 12:06 AM, Andy Lutomirski wrote:
> The PTI stack does have guard pages because it maps only a part of the task
> stack into the user page-table, so pages around the PTI stack are not mapped
> into the user-pagetable (the page below is the task stack guard, and the page
> above is part of the kernel-only stack so it's never mapped into the user
> page-table).
>
> + *   +-------------+
> + *   |             | ^                       ^
> + *   | kernel-only | | KERNEL_STACK_SIZE     |
> + *   |    stack    | |                       |
> + *   |             | V                       |
> + *   +-------------+ <- top of kernel stack  | THREAD_SIZE
> + *   |             | ^                       |
> + *   | kernel and  | | KERNEL_STACK_SIZE     |
> + *   | PTI stack   | |                       |
> + *   |             | V                       v
> + *   +-------------+ <- top of stack

Well, the PTI stack might have guard pages, but the kernel stack can now
underflow into the PTI stack. Not good.

Thanks,

        tglx


