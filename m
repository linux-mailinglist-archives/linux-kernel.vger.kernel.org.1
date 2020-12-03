Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B043E2CCDD6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 05:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgLCEVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 23:21:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgLCEVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 23:21:19 -0500
Date:   Thu, 3 Dec 2020 13:20:32 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606969238;
        bh=hPQQVmuQd7VmGzIYfkhMqANTM9k5cWKXQchSIWSDRLw=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=KOFfET2teJ0Xcqqb1Q5Fdcqzo0+OXLhMjnpwCxf2VyPejgxGTN9w0WulzWs8xSHrx
         O1UnQJ2/tU3NKg8yMbB0f7Ym4qMjneoYQh1YhctReKigB3rexwEd8ePxu3RnDbRHE2
         ESDbb5uQM+IsXDH7dUC11lM2aneuQ8PBibG6oCcM4uP3HVMObHDFuWNrke21qt20Li
         rOEuwKcy9zwLqsW9stTgqauA7QJNWgRI++B+3N4H2hXeWzNmhU5b/K3Hr6qYPrgy3P
         zGt7icb7HEo/OAc/NHj14vZEV2HnX0w9cPHFi0niMQYBeP1fE3/YXM24En0rgsHTo8
         SCu56a3nyQ7rg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jann Horn <jannh@google.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/uprobes: Fix not using prefixes.nbytes for loop
 over prefixes.bytes
Message-Id: <20201203132032.392d7dce940ed89c34341169@kernel.org>
In-Reply-To: <20201202145135.GF528281@linux.vnet.ibm.com>
References: <160689905099.3084105.7880450206184269465.stgit@devnote2>
        <160689907597.3084105.18019089399087866918.stgit@devnote2>
        <20201202145135.GF528281@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020 20:21:35 +0530
Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:

> * Masami Hiramatsu <mhiramat@kernel.org> [2020-12-02 17:51:16]:
> 
> > Since the insn.prefixes.nbytes can be bigger than the size of
> > insn.prefixes.bytes[] when a same prefix is repeated, we have to
> > check whether the insn.prefixes.bytes[i] != 0 and i < 4 instead
> > of insn.prefixes.nbytes.
> > 
> > Fixes: 2b1444983508 ("uprobes, mm, x86: Add the ability to install and remove uprobes breakpoints")
> > Cc: stable@vger.kernel.org
> > Reported-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Looks good to me.
> 
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Thanks Srikar!


> 
> > ---
> >  arch/x86/kernel/uprobes.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index 3fdaa042823d..bb3ea3705b99 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -257,7 +257,7 @@ static bool is_prefix_bad(struct insn *insn)
> >  {
> >  	int i;
> > 
> > -	for (i = 0; i < insn->prefixes.nbytes; i++) {
> > +	for (i = 0; insn->prefixes.bytes[i] && i < 4; i++) {
> >  		insn_attr_t attr;
> > 
> >  		attr = inat_get_opcode_attribute(insn->prefixes.bytes[i]);
> > @@ -746,7 +746,7 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
> >  	 * Intel and AMD behavior differ in 64-bit mode: Intel ignores 66 prefix.
> >  	 * No one uses these insns, reject any branch insns with such prefix.
> >  	 */
> > -	for (i = 0; i < insn->prefixes.nbytes; i++) {
> > +	for (i = 0; insn->prefixes.bytes[i] && i < 4; i++) {
> >  		if (insn->prefixes.bytes[i] == 0x66)
> >  			return -ENOTSUPP;
> >  	}
> > 
> 
> -- 
> Thanks and Regards
> Srikar Dronamraju


-- 
Masami Hiramatsu <mhiramat@kernel.org>
