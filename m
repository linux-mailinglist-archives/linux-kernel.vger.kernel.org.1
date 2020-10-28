Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5221129E247
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387858AbgJ2CMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgJ1Vg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:36:27 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940CBC0613D5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:36:27 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 471CE4C4; Wed, 28 Oct 2020 09:38:21 +0100 (CET)
Date:   Wed, 28 Oct 2020 09:38:19 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Martin Radev <martin.b.radev@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] x86/boot/compressed/64: Check SEV encryption in
 64-bit boot-path
Message-ID: <20201028083819.GC18723@8bytes.org>
References: <20201021123938.3696-1-joro@8bytes.org>
 <20201021123938.3696-4-joro@8bytes.org>
 <20201027110812.GC15580@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027110812.GC15580@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 12:08:12PM +0100, Borislav Petkov wrote:
> On Wed, Oct 21, 2020 at 02:39:36PM +0200, Joerg Roedel wrote:
> > diff --git a/arch/x86/kernel/sev_verify_cbit.S b/arch/x86/kernel/sev_verify_cbit.S
> > new file mode 100644
> > index 000000000000..5075458ecad0
> > --- /dev/null
> > +++ b/arch/x86/kernel/sev_verify_cbit.S
> 
> Why a separate file? You're using it just like verify_cpu.S and this is
> kinda verifying CPU so you could simply add the functionality there...

verify_cpu.S is also used on 32bit and this function is 64bit code. It
can be made working with some #ifdef'fery but I think it is cleaner to
just keep it in a separate file, also given that sev_verify_cbit() is
not needed at every place verify_cpu() is called.

> Yeah, can you please use the callee-clobbered registers in the order as
> they're used by the ABI, see arch/x86/entry/calling.h.
> 
> Because I'm looking at this and wondering are rsi, rdx and rcx somehow
> live here and you're avoiding them...

Makes sense, will update the function.

Regards,

	Joerg

