Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158012FF13C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbhAURAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:00:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42588 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732032AbhAUQ7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:59:39 -0500
Received: from zn.tnic (p200300ec2f1575008f111d19c272cab6.dip0.t-ipconnect.de [IPv6:2003:ec:2f15:7500:8f11:1d19:c272:cab6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ECC551EC05C2;
        Thu, 21 Jan 2021 17:58:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611248331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aAowCgPKnj8lJNpLWRHPtz+od612hKZl8mosyJYxxbc=;
        b=PgrGVRVA3VMNJUCpJ6bPgsHll8aCYW8clLpzyFLNiDJMVMBToIhgFobxNQ/gmXDhXKfduJ
        vVrS86Fbs63253wBH6T8TMp/Cc1Pve1xB7XVN27UxbERSrTBADQA50Yha8/KCzcUle6Jpm
        ce/OcJE+Jx1sG02qNi/2nZLU+QUe3ME=
Date:   Thu, 21 Jan 2021 17:58:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kernel test robot <lkp@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 11/19] x86/sev-es: Convert to insn_decode()
Message-ID: <20210121165845.GD32060@zn.tnic>
References: <20201223174233.28638-12-bp@alien8.de>
 <202012251838.G6eufP3Q-lkp@intel.com>
 <20201225123334.GA5874@zn.tnic>
 <X+ouv0PN6dmva92i@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X+ouv0PN6dmva92i@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 11:15:11AM -0800, Sean Christopherson wrote:
> Alternatively, could the kernel case use insn_decode_regs()?  If
> vc_fetch_insn_kernel() were also modified to mirror insn_fetch_from_user(), the
> two code paths could be unified except for the the fetch and the PFEC.  E.g.

Personal Firearms Eligibility Check?

In any case, I prefer simple, easy to follow code at a quick glance.
Stuff like...

> 
> static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
> 				unsigned char *buffer)
> {
> 	if (copy_from_kernel_nofault(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE))
> 		return 0;
> 
> 	return MAX_INSN_SIZE;
> }
> 
> static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
> {
> 	char buffer[MAX_INSN_SIZE];
> 	int nbytes;
> 
> 	if (user_mode(ctxt->regs))
> 		nbytes = insn_fetch_from_user(ctxt->regs, buffer);
> 	else
> 		nbytes = vc_fetch_insn_kernel(ctxt, buffer);
> 
> 	if (!nbytes) {
> 		ctxt->fi.vector     = X86_TRAP_PF;
> 		ctxt->fi.error_code = X86_PF_INSTR;
> 		if (user_mode(ctxt->regs))

... this second repeated check here is not what I would call that.

But this is my personal preference only so it's up for a vote now.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
