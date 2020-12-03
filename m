Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A202CCBF1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 03:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgLCCDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 21:03:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgLCCDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:03:49 -0500
Date:   Thu, 3 Dec 2020 11:03:02 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606960988;
        bh=uJVG156LJ2Xk3EybB328xWcZ6wvKtQV2KDv5WfLuRLc=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=pPY/59Ns3ZPEFTSKguFAk5uuU4PuvB94Qmh3H51svOReB4jFBR/wF7W+dtFc9gVe1
         HM7znNlclMESLwzZNtjre0IfyaoZODgEsVSgVbzwq8lvdyJQrThMsc5mxlkqDIt8bW
         Pj0rwQDH3Hg4V5dk2/UZ7xHDlSs9ZVFBAPhVE2XUm1UfsO68x2rrlXuoP+qa/mr/J/
         NxJxYKqgPe3FV6NMdmcd9k5ciF2dsJ8db5xVzURJ/JlHQw5DIEViwBlckJcGQc02sm
         4IEAUB/khKXXLnb/l1gkCfeoZyie+8wYqdPuHcrf0ubtlDU8iPcIC8GqDtME78Jc8u
         2gbcRLkD+5AEQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jann Horn <jannh@google.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/sev-es: Fix not using prefixes.nbytes for loop
 over prefixes.bytes
Message-Id: <20201203110302.79bb318c885b4673d2b0be19@kernel.org>
In-Reply-To: <202012021104.0C38FB7FD@keescook>
References: <160689905099.3084105.7880450206184269465.stgit@devnote2>
        <160689906460.3084105.3134729514028168934.stgit@devnote2>
        <54417a56-241b-14f9-2540-11b23e40e2b2@amd.com>
        <202012021104.0C38FB7FD@keescook>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020 11:07:26 -0800
Kees Cook <keescook@chromium.org> wrote:

> On Wed, Dec 02, 2020 at 09:31:57AM -0600, Tom Lendacky wrote:
> > On 12/2/20 2:51 AM, Masami Hiramatsu wrote:
> > > Since the insn.prefixes.nbytes can be bigger than the size of
> > > insn.prefixes.bytes[] when a same prefix is repeated, we have to
> > > check whether the insn.prefixes.bytes[i] != 0 and i < 4 instead
> > > of insn.prefixes.nbytes.
> > > 
> > > Fixes: 25189d08e516 ("x86/sev-es: Add support for handling IOIO exceptions")
> > > Reported-by: Kees Cook <keescook@chromium.org>
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > ---
> > >   arch/x86/boot/compressed/sev-es.c |    2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
> > > index 954cb2702e23..6a7a3027c9ac 100644
> > > --- a/arch/x86/boot/compressed/sev-es.c
> > > +++ b/arch/x86/boot/compressed/sev-es.c
> > > @@ -36,7 +36,7 @@ static bool insn_has_rep_prefix(struct insn *insn)
> > >   	insn_get_prefixes(insn);
> > > -	for (i = 0; i < insn->prefixes.nbytes; i++) {
> > > +	for (i = 0; insn->prefixes.bytes[i] && i < 4; i++) {
> 
> You must test "i" before bytes[i] or you still do the out-of-bounds-read.

Oops, thanks.

> 
> > 
> > Wouldn't it be better to create a #define for the size rather than hard
> > coding 4 in the various files? That would protect everything should the
> > bytes array size ever change in the future.
> 
> Agreed, and perhaps instead of repeating the idiom in the for loop, add
> a helper like:
> 
> #define insn_prefix_valid(prefixes, i) (i >=0 && i < 4 && prefixes->bytes[i])
> 
> to be used like:
> 
> 	for (i = 0; insn_prefix_valid(&insn->prefixes, i); i++) {

Hm, for all of these usage, they are looping on the prefixes, so

for_each_insn_prefix(insn, idx, prefix) {
...
}

will be simpler.

Thank you,

> 
> > 
> > Thanks,
> > Tom
> > 
> > >   		insn_byte_t p = insn->prefixes.bytes[i];
> > >   		if (p == 0xf2 || p == 0xf3)
> > > 
> 
> -- 
> Kees Cook


-- 
Masami Hiramatsu <mhiramat@kernel.org>
