Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE3E2CCBF0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 03:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgLCCBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 21:01:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgLCCBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:01:07 -0500
Date:   Thu, 3 Dec 2020 11:00:20 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606960826;
        bh=3iF79jS1BGCz5KFp+WuduvSthZJzVhhFE7SqWb7dt6o=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=a4brG3EQUWez3SMTMBbV7St5didHXwkEHNJHJ2V8LK9XUldWc/D4He4iqrkyc3MK2
         2l1wZlo7OmgJ1BmloCycNvyjLZzuMff2Ez8TGh78/W+8D9PqApei2IPkcuP/gNRPud
         qZ2A3DyY2920cQmI6r03eDm5xwO+HSFMpRckMDzDGgvfu2oPTNz0GcXyUxRcFumb0D
         F6mQHLBvB95LJvQ3xRBmmIVGajLE8MfKX6fUINx7DVG8oF1qeH8vE3b5CLVvsp1UMc
         4YLfqcu63cs9Oorbw0diEBlaeDP5xi7ncxdthFFNF8587cW1a4mjhq8BL7cOVcC7rn
         oGbfD7dYJRx4Q==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jann Horn <jannh@google.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/uprobes: Fix not using prefixes.nbytes for loop
 over prefixes.bytes
Message-Id: <20201203110020.372154fb7d9303e0869cf1da@kernel.org>
In-Reply-To: <202012021103.5A8030BF7A@keescook>
References: <160689905099.3084105.7880450206184269465.stgit@devnote2>
        <160689907597.3084105.18019089399087866918.stgit@devnote2>
        <202012021103.5A8030BF7A@keescook>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020 11:04:41 -0800
Kees Cook <keescook@chromium.org> wrote:

> On Wed, Dec 02, 2020 at 05:51:16PM +0900, Masami Hiramatsu wrote:
> > Since the insn.prefixes.nbytes can be bigger than the size of
> > insn.prefixes.bytes[] when a same prefix is repeated, we have to
> > check whether the insn.prefixes.bytes[i] != 0 and i < 4 instead
> > of insn.prefixes.nbytes.
> > 
> > Fixes: 2b1444983508 ("uprobes, mm, x86: Add the ability to install and remove uprobes breakpoints")
> > Cc: stable@vger.kernel.org
> > Reported-by: Kees Cook <keescook@chromium.org>
> 
> This should probably be:
> 
> Reported-by: syzbot+9b64b619f10f19d19a7c@syzkaller.appspotmail.com
> Debugged-by: Kees Cook <keescook@chromium.org>

OK, let me fix it.

Thank you,

> 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
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
> 
> -- 
> Kees Cook


-- 
Masami Hiramatsu <mhiramat@kernel.org>
