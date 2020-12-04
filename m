Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5DF2CE4A5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 01:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbgLDA5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 19:57:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbgLDA5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 19:57:39 -0500
Date:   Fri, 4 Dec 2020 09:56:53 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607043418;
        bh=I70sZb+GFxuM858yM3SdnXf8YH2Ws5GPPACtMQ+ZcvY=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=f152A+vwZdZ6S+U8k0BRC/KONO2Omi5DN541LRhLoTfaff7X8JpTsae0oTa2x3tc7
         lGk8yiQE+eddqQI1qg4WPFQwDB1LPKfIiTu1U8eh1698jew4aEyCVLyZusp42RqbwB
         apzmR+51J9lG2LNCvBx4Q4cIkpVuyaAo23rwnNLoYAjb4T96B8rPHFVg3zyUMBsSNk
         RLVSuBtEr+neSE96xNUDSlRAVkl/JPIqviw6GUE3tR/MrnbuR7xDFErkaCPHRrf/gt
         uEZht8f6sbJv+JtnPzQGAGoWm1SxozGTKlUu3lSfAsGg82Mu62AMpDw9cdbFiGgZGr
         xqBkadSzPNzFQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
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
Message-Id: <20201204095653.c948106a294fd6e731df5594@kernel.org>
In-Reply-To: <e7148653-0156-b895-714c-0d4cd580a2a8@amd.com>
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
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020 12:49:46 -0600
Tom Lendacky <thomas.lendacky@amd.com> wrote:

> On 12/3/20 12:17 PM, Borislav Petkov wrote:
> > On Thu, Dec 03, 2020 at 12:10:10PM -0600, Tom Lendacky wrote:
> >> Since that struct is used in multiple places, I think basing it on the array
> >> size is the best way to go. The main point of the check is just to be sure
> >> you don't read outside of the array.
> > 
> > Well, what happens if someone increases the array size of:
> > 
> > struct insn_field {
> > 	union {
> > 		insn_byte_t bytes[4];
> > 				^^^^
> > 
> > ?
> 
> I think we need to keep the parsing of the instruction separate from 
> accessing the prefixes after (successfully) parsing it. This fix is merely 
> making sure that we don't read outside the bounds of the array that 
> currently holds the legacy prefixes.
> 
> > 
> > That's why a separate array only for legacy prefixes would be better
> > in the long run. The array size check is good as a short-term fix for
> > stable.
> > 
> > I'd say.
> 
> According to Volume 3 of the AMD APM (Figure 1-2 on page 5), there could 
> be as many as 5 legacy prefixes and it says that more than one prefix from 
> each group is undefined behavior. The instruction parsing code doesn't 
> seem to take into account the different prefix groups. So I agree with you 
> that short term the array size check works, and long term, the legacy 
> prefix support probably needs a closer look.

Hmm, there is a difference between Intel SDM and AMD APM.

Intel SDM vol.2

2.1.1 Instruction Prefixes
Instruction prefixes are divided into four groups, each with a set of allowable prefix codes. For each instruction, it
is only useful to include up to one prefix code from each of the four groups (Groups 1, 2, 3, 4).

AMD APM vol.3

1.2.1 Summary of Legacy Prefixes
Table 1-1 on page 7 shows the legacy prefixes. The legacy prefixes are organized into five groups, as
shown in the left-most column of Table 1-1. An instruction encoding may include a maximum of one
prefix from each of the five groups.

So, Intel CPU doesn't accept LOCK-REP because those are in a same prefix
group, but AMD says it is acceptable. Actually, insn.c only accepts the 
prefix up to 4, so if there is any instruction which has 5 prefixes,
it will fail to parse.

Note that anyway the same prefix can be repeated, we can see a good example
in K8_NOP*.

/* Opteron 64bit nops
   1: nop
   2: osp nop
   3: osp osp nop
   4: osp osp osp nop
*/

In this case, insn.c just store the 1 osp in the prefixes.bytes[], and
just increment prefixes.nbytes for the repeated prefixes.

Anyway, if there is LOCK-REP prefix combination, I have to introduce new
insn_field for legacy prefix.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
