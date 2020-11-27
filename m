Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61C42C63ED
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 12:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgK0LcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 06:32:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44118 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgK0LcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 06:32:04 -0500
Received: from zn.tnic (p200300ec2f0ffb00d5ac34a4508c2f14.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:fb00:d5ac:34a4:508c:2f14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C8BD21EC0323;
        Fri, 27 Nov 2020 12:32:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606476722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ugdjThtrhUGuPIVjsesMvfGYF6EvCSTLiEMoM1kV7p0=;
        b=H3DZCuzv0GbI72+5hcncMOCBvU3bwbQjV3Xg05BJXfrUY9iAwMey2+iadrW0uv0ZNz8JVW
        H5tHbow1z7hsKPg3aLpNWsikw0IR8bez7Yd35BVVGZVFqwLMPfDKicMg1TIF3sq/9OMGYs
        yNNdq7lFily/ytxwflNIuveYBKeRHuc=
Date:   Fri, 27 Nov 2020 12:31:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, peterz@infradead.org,
        luto@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2 03/12] x86/pv: switch SWAPGS to ALTERNATIVE
Message-ID: <20201127113156.GB13163@zn.tnic>
References: <20201120114630.13552-1-jgross@suse.com>
 <20201120114630.13552-4-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201120114630.13552-4-jgross@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 12:46:21PM +0100, Juergen Gross wrote:
> SWAPGS is used only for interrupts coming from user mode or for
> returning to user mode. So there is no reason to use the PARAVIRT
> framework, as it can easily be replaced by an ALTERNATIVE depending
> on X86_FEATURE_XENPV.
> 
> There are several instances using the PV-aware SWAPGS macro in paths
> which are never executed in a Xen PV guest. Replace those with the
> plain swapgs instruction. For SWAPGS_UNSAFE_STACK the same applies.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Acked-by: Andy Lutomirski <luto@kernel.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/entry/entry_64.S             | 10 +++++-----
>  arch/x86/include/asm/irqflags.h       | 20 ++++++++------------
>  arch/x86/include/asm/paravirt.h       | 20 --------------------
>  arch/x86/include/asm/paravirt_types.h |  2 --
>  arch/x86/kernel/asm-offsets_64.c      |  1 -
>  arch/x86/kernel/paravirt.c            |  1 -
>  arch/x86/kernel/paravirt_patch.c      |  3 ---
>  arch/x86/xen/enlighten_pv.c           |  3 ---
>  8 files changed, 13 insertions(+), 47 deletions(-)

I love patches like this one! Give me more...

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
