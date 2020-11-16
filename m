Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F3F2B524A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732647AbgKPURT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:17:19 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51690 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729723AbgKPURS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:17:18 -0500
Received: from zn.tnic (p200300ec2f07680009538f4f478c319e.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:6800:953:8f4f:478c:319e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5B1C71EC0434;
        Mon, 16 Nov 2020 21:17:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605557837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UXwBqxMoOVm+q/zWSu79fGxJWf6w8xkUF3690yPTXZ0=;
        b=lv4oxCjDn9K396REguIW00FqwYg5HZTtgGx1W6Eh247dUTvYcbULnNYwMeIEMUk2IDrMjt
        azCbeW5Uq40ay3+BjKl9kC4Obk1cvl4fBJckanDHB04uN2AK8hSYw23XSOEjt1pD8IcrnS
        diwiGnYZkh8iAC3gkZOqx09AYAUGEGo=
Date:   Mon, 16 Nov 2020 21:17:11 +0100
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
Message-ID: <20201116201711.GE1131@zn.tnic>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 03:47:36PM +0100, Alexandre Chartre wrote:
> This RFC proposes to defer the PTI CR3 switch until we reach C code.
> The benefit is that this simplifies the assembly entry code, and make
> the PTI CR3 switch code easier to understand. This also paves the way
> for further possible projects such an easier integration of Address
> Space Isolation (ASI), or the possibilily to execute some selected
> syscall or interrupt handlers without switching to the kernel page-table

What for? What is this going to be used for in the end?

> (and thus avoid the PTI page-table switch overhead).

Overhead of how much? Why do we care?

What is the big picture justfication for this diffstat

>  21 files changed, 874 insertions(+), 314 deletions(-)

and the diffstat for the ASI enablement?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
