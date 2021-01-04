Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428352E8FA5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 04:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbhADDqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 22:46:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbhADDqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 22:46:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8ADA20E65;
        Mon,  4 Jan 2021 03:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609731962;
        bh=w4bVRJDOwpQaqSHjiisHZSkL0QByWmv5cw2AZVOJ+a0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uL1CAhx9Jdn4+dyul36KvZnaC8UALLmcJ8WbCgyipQlogM2DO27Alww4COmfMu945
         /QVNR23qH7NYQJ8oFUs2FyFr06yQ7AhpcCPI/S1TufwLV6crocLMivnvGAaeGEQDMH
         +BcUHfY+lbZMvwkOiekXxBUZ6MviUEZrxfMri8EULexX52azqcDDzUgx6rHyMvmK0Y
         05uuJU3uDYKYZpuf6Bi+FUon4E4EVCQ9JpCbcMQx9LOcCFGQ/mO24qyKnwBy35hG0P
         hMtfisvBpCY+xdEtsyVl1NEsDE9ITjV7tHNiUR4CFhudrIUW+GGik0jb4H3LPHPFvC
         qlhfWXSbhbaUQ==
Date:   Mon, 4 Jan 2021 12:45:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>, x86@kernel.org
Subject: Re: [PATCH -tip v2] x86/kprobes: Do not decode opcode in
 resume_execution()
Message-Id: <20210104124558.7c89fb6fa305507c098f0d85@kernel.org>
In-Reply-To: <20201231160923.GB4504@zn.tnic>
References: <20201218214432.b025656de019c64a8f4e2da5@kernel.org>
        <160830072561.349576.3014979564448023213.stgit@devnote2>
        <20201231160923.GB4504@zn.tnic>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Dec 2020 17:09:23 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Dec 18, 2020 at 11:12:05PM +0900, Masami Hiramatsu wrote:
> > @@ -467,8 +489,8 @@ static int arch_copy_kprobe(struct kprobe *p)
> >  	 */
> >  	len = prepare_boost(buf, p, &insn);
> >  
> > -	/* Check whether the instruction modifies Interrupt Flag or not */
> > -	p->ainsn.if_modifier = is_IF_modifier(buf);
> > +	/* Analyze the opcode and set resume flags */
> > +	set_resume_flags(p, &insn);
> 
> So this function wants to be called something like analyze_insn() or so
> then? set_resume_flags() is kinda misleading as a name.

Hrm, I meant setting the flags used in the resume_execution() afterwards.
Since the instruction itself (not only opcode but also oprands) was
also analyzed in other places, so I like the set_resume_flags() for it.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
