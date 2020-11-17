Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8AE2B6AC0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgKQQzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgKQQzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:55:51 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE2DC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 08:55:51 -0800 (PST)
Received: from zn.tnic (p200300ec2f1013008aaa2b5438c9ced9.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:1300:8aaa:2b54:38c9:ced9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6913B1EC027D;
        Tue, 17 Nov 2020 17:55:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605632146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HBIh7i4QOSKbMiy/F85oAnmMMn6JecinNCtNPwE55Ys=;
        b=pM+1B0P14Tao4sR2Dupvt/SEA0WTo+Yq9v74kHKTwZ0XUl/autGuWhaxNqCQ7uTp2I+MGt
        iu3gGjLNeZAl6KMC/Oubof2x+/k3hr3m9CYsYILsgiub3L8bmvveflFYgssnpVBoRUR5nf
        ElqDwUr8+Vi80vfzPFPKT3ppClPgd8k=
Date:   Tue, 17 Nov 2020 17:55:39 +0100
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
Message-ID: <20201117165539.GG5719@zn.tnic>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116201711.GE1131@zn.tnic>
 <44a88648-738a-4a4b-9c25-6b70000e037c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44a88648-738a-4a4b-9c25-6b70000e037c@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 08:56:23AM +0100, Alexandre Chartre wrote:
> The main goal of ASI is to provide KVM address space isolation to
> mitigate guest-to-host speculative attacks like L1TF or MDS.

Because the current L1TF and MDS mitigations are lacking or why?

> Current proposal of ASI is plugged into the CR3 switch assembly macro
> which make the code brittle and complex. (see [1])
>
> I am also expected this might help with some other ideas like having
> syscall (or interrupt handler) which can run without switching the
> page-table.

I still fail to see why we need all that. I read, "this does this and
that" but I don't read "the current problem is this" and "this is our
suggested solution for it".

So what is the issue which needs addressing in the current kernel which
is going to justify adding all that code?

> PTI has a measured overhead of roughly 5% for most workloads, but it can
> be much higher in some cases.

"it can be"? Where? Actual use case?

> The latest ASI RFC (RFC v4) is here [1]. This RFC has ASI plugged
> directly into the CR3 switch assembly macro. We are working on a new
> implementation, based on these changes which avoid having to deal with
> assembly code and makes the implementation more robust.

This still doesn't answer my questions. I read a lot of "could be used
for" formulations but I still don't know why we need that. So what is
the problem that the kernel currently has which you're trying to address
with this?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
