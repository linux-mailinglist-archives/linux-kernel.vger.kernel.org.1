Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8931C2B5272
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbgKPUY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgKPUY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:24:29 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B3AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:24:29 -0800 (PST)
Received: from zn.tnic (p200300ec2f07680009538f4f478c319e.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:6800:953:8f4f:478c:319e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 06B701EC0434;
        Mon, 16 Nov 2020 21:24:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605558267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wnameQ+gJBbPwVHj8aSpOnIXxQgEOlszbgYAWvG5dpA=;
        b=M1wYxsGD/l8ZS/fQ4pPHL8kl2liReA6OWN9Z7LCWNdm0azbYXtwlBuL8NaktPveTtBfscS
        UzERMF3zs0gZnDxxlrFdmgiKCV41etJB4PZqCuceRdEAiGO7vpJNS+n8wa+IcmvsuXsB9i
        uH8ljGhotC72I0TWil110b0zqpMrTvg=
Date:   Mon, 16 Nov 2020 21:24:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, junaids@google.com, oweisse@google.com,
        rppt@linux.vnet.ibm.com, graf@amazon.de, mgross@linux.intel.com,
        kuzuno@gmail.com
Subject: Re: [RFC][PATCH v2 00/21] x86/pti: Defer CR3 switch to C code
Message-ID: <20201116202426.GF1131@zn.tnic>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 03:47:36PM +0100, Alexandre Chartre wrote:
> Deferring CR3 switch to C code means that we need to run more of the
> kernel entry code with the user page-table. To do so, we need to:
> 
>  - map more syscall, interrupt and exception entry code into the user
>    page-table (map all noinstr code);
> 
>  - map additional data used in the entry code (such as stack canary);
> 
>  - run more entry code on the trampoline stack (which is mapped both
>    in the kernel and in the user page-table) until we switch to the
>    kernel page-table and then switch to the kernel stack;

So PTI was added exactly to *not* have kernel memory mapped in the user
page table. You're partially reversing that...

>  - have a per-task trampoline stack instead of a per-cpu trampoline
>    stack, so the task can be scheduled out while it hasn't switched
>    to the kernel stack.

per-task? How much more memory is that per task?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
