Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1852CE6BC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 04:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgLDD40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 22:56:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgLDD40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 22:56:26 -0500
Date:   Fri, 4 Dec 2020 12:55:40 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607054145;
        bh=9L2MLHS6s+FXV6sunjkn8Ydk+p7xN+acVr1+aQ9eX2g=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=aPz+A4Kq67t8v7CWj+5TIqP+BdbXLD/Fth1leStgQw/iPt2IocULIeix56GslsAkN
         SjnJbNWJztqEGMSWyDhWV7qhJZwL/ZJbCbAg1V/NDFXarfP8tZPF3sxO5yXIMFeh4e
         WCIbylg9cg1jx5HsepjV0gQtJLZe0cG6s56j5NYJOJqCH2owVaiBsluEHLpulF/58s
         GQeeuxcvDuT3IJ/eLEJlWnxn823ogtElBahKmzY/KUkArRkER5OF768ILFFsCWrwjf
         O5e6mTQYXlM+HUIQjq0DILkkDLDz9Z3aTD1oyIFcFD+/EB08ORNxIo0YwaLXNDkgre
         FsCLTvN1tco0A==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jann Horn <jannh@google.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] x86/uprobes: Fix not using prefixes.nbytes for
 loop over prefixes.bytes
Message-Id: <20201204125540.246fc58c9ddbcd171189e620@kernel.org>
In-Reply-To: <20201204095653.c948106a294fd6e731df5594@kernel.org>
References: <160697102582.3146288.10127018634865687932.stgit@devnote2>
        <160697103739.3146288.7437620795200799020.stgit@devnote2>
        <20201203123757.GH3059@zn.tnic>
        <20201203124121.GI3059@zn.tnic>
        <20201203124820.GJ3059@zn.tnic>
        <1c1b265f-34e3-f5cc-0e7b-186dc26c94b7@amd.com>
        <20201203165420.GL3059@zn.tnic>
        <20201203170140.GM3059@zn.tnic>
        <d9b47fc6-6d9d-b966-30df-9ef8c83b46e3@amd.com>
        <20201203181712.GN3059@zn.tnic>
        <e7148653-0156-b895-714c-0d4cd580a2a8@amd.com>
        <20201204095653.c948106a294fd6e731df5594@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 09:56:53 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Thu, 3 Dec 2020 12:49:46 -0600
> Tom Lendacky <thomas.lendacky@amd.com> wrote:
> 
> > On 12/3/20 12:17 PM, Borislav Petkov wrote:
> > > On Thu, Dec 03, 2020 at 12:10:10PM -0600, Tom Lendacky wrote:
> > >> Since that struct is used in multiple places, I think basing it on the array
> > >> size is the best way to go. The main point of the check is just to be sure
> > >> you don't read outside of the array.
> > > 
> > > Well, what happens if someone increases the array size of:
> > > 
> > > struct insn_field {
> > > 	union {
> > > 		insn_byte_t bytes[4];
> > > 				^^^^
> > > 
> > > ?
> > 
> > I think we need to keep the parsing of the instruction separate from 
> > accessing the prefixes after (successfully) parsing it. This fix is merely 
> > making sure that we don't read outside the bounds of the array that 
> > currently holds the legacy prefixes.
> > 
> > > 
> > > That's why a separate array only for legacy prefixes would be better
> > > in the long run. The array size check is good as a short-term fix for
> > > stable.
> > > 
> > > I'd say.
> > 
> > According to Volume 3 of the AMD APM (Figure 1-2 on page 5), there could 
> > be as many as 5 legacy prefixes and it says that more than one prefix from 
> > each group is undefined behavior. The instruction parsing code doesn't 
> > seem to take into account the different prefix groups. So I agree with you 
> > that short term the array size check works, and long term, the legacy 
> > prefix support probably needs a closer look.
> 
> Hmm, there is a difference between Intel SDM and AMD APM.
> 
> Intel SDM vol.2
> 
> 2.1.1 Instruction Prefixes
> Instruction prefixes are divided into four groups, each with a set of allowable prefix codes. For each instruction, it
> is only useful to include up to one prefix code from each of the four groups (Groups 1, 2, 3, 4).
> 
> AMD APM vol.3
> 
> 1.2.1 Summary of Legacy Prefixes
> Table 1-1 on page 7 shows the legacy prefixes. The legacy prefixes are organized into five groups, as
> shown in the left-most column of Table 1-1. An instruction encoding may include a maximum of one
> prefix from each of the five groups.
> 
> So, Intel CPU doesn't accept LOCK-REP because those are in a same prefix
> group, but AMD says it is acceptable. Actually, insn.c only accepts the 
> prefix up to 4, so if there is any instruction which has 5 prefixes,
> it will fail to parse.


OK, I got it. AMD APM's explanation is misleading. Intel SDM groups
the legacy prefixes in 1) Lock/Repeat/Bound 2) Segment override/branch hints,
3) Operand-size override 4) Address-size override. On the other hand,
AMD APM makes it 5 groups(See Table 1-1), 1) Operand-Size Override
2) Address-Size Override 3) Segment Override 4) Lock 5) Repeat.

So the difference is whether the Lock and Repeat is a group or not.

However, I found we must not see LOCK-REP prefix in the same instruction,
because the available instruction for LOCK and REP are different.

AMD APM vol.3
---
1.2.5 Lock Prefix
...
The LOCK prefix can only be used with forms of the following instructions that write a memory
operand: ADC, ADD, AND, BTC, BTR, BTS, CMPXCHG, CMPXCHG8B, CMPXCHG16B, DEC,
INC, NEG, NOT, OR, SBB, SUB, XADD, XCHG, and XOR. An invalid-opcode exception occurs if
the LOCK prefix is used with any other instruction.

1.2.6 Repeat Prefixes
The repeat prefixes cause repetition of certain instructions that load, store, move, input, or output
strings. The prefixes should only be used with such string instructions.
...
REP. ... The prefix can be used with the INS, LODS, MOVS, OUTS, and STOS instructions.
...
The REPE and REPZ prefixes can be used with the CMPS, CMPSB, CMPSD, CMPSW, SCAS,
SCASB, SCASD, and SCASW instructions.
...
The REPNE and REPNZ prefixes can be used with the CMPS, CMPSB, CMPSD, CMPSW, SCAS,
SCASB, SCASD, and SCASW instructions.
---

Thus, I think the current expectation -- legacy prefix will consist
of 4 different groups -- is good. No need to take care of LOCK-REP
combination.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
