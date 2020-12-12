Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D722D89C1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 20:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407792AbgLLTex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 14:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407785AbgLLTec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 14:34:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AFCC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 11:33:52 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607801630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fsSEGJCAwuZxgOgaIzYfbINvJnUoQRBOk4nJ9KS5zqw=;
        b=NPplzLLHXnjuxlUJddCik8rZvWZ2eDXuF5ZhnOnr9WUhwcgUxKEdfBfbehHSP9I//Q89nv
        DstD9SuOTAipJ62nPEAm70+2xV7aa47DAijthAIAskqxDEyf0av2shdrxIvcIw09ky/ukX
        NE2CmVbppA6LbFxmwqeJU5TMdDg/DCzmYVSZaAjcv9FGiicePATzAN6MKiX1ISKhC3Jk81
        kaOLkUjAKJLRFW/pf5dSAcT0vL7OvgBLc3LGOtA6QPzenM+9yb56X8RBt7zr3UT7g5WhYd
        pfOchoxuSXGNxpmo+QmaixjFJowxYUS/UOms0h9C556FD14d9SuG2uzewzGsTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607801630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fsSEGJCAwuZxgOgaIzYfbINvJnUoQRBOk4nJ9KS5zqw=;
        b=0SHOMmvfnaM4Pw+HX4mcE1J1227oSps+1P7BwpG2xlwYHrdaTZLnTARPDodwEMNfAMvdjk
        HHt+jwCL19w5OfDA==
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     "x86\@kernel.org" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: common_interrupt: No irq handler for vector
In-Reply-To: <9741d93c-3cd1-c4ef-74bb-7f635231c778@linuxfoundation.org>
References: <9741d93c-3cd1-c4ef-74bb-7f635231c778@linuxfoundation.org>
Date:   Sat, 12 Dec 2020 20:33:50 +0100
Message-ID: <87im96g6ox.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11 2020 at 13:41, Shuah Khan wrote:

> I am debugging __common_interrupt: 1.55 No irq handler for vector
> messages and noticed comments and code don't agree:

I bet that's on an AMD system with broken AGESA BIOS.... Good luck
debugging it :) BIOS updates are on the way so I'm told.

> arch/x86/kernel/apic/msi.c: msi_set_affinity() says:
>
>
>   * If the vector is in use then the installed device handler will
>   * denote it as spurious which is no harm as this is a rare event
>   * and interrupt handlers have to cope with spurious interrupts
>   * anyway. If the vector is unused, then it is marked so it won't
>   * trigger the 'No irq handler for vector' warning in
>   * common_interrupt().
>
> common_interrupt() prints message if vector is unused: VECTOR_UNUSED
>
> ack_APIC_irq();
>
> if (desc == VECTOR_UNUSED) {
>      pr_emerg_ratelimited("%s: %d.%u No irq handler for vector\n",
>                            __func__, smp_processor_id(), vector);
> }
>
> Something wrong here?

No. It's perfectly correct in the MSI code. See further down.

	if (IS_ERR_OR_NULL(this_cpu_read(vector_irq[cfg->vector])))
		this_cpu_write(vector_irq[cfg->vector], VECTOR_RETRIGGERED);

Thanks,

        tglx
