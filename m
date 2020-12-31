Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BE42E812C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 17:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgLaQKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 11:10:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47584 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgLaQKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 11:10:07 -0500
Received: from zn.tnic (p200300ec2f124d008f1c57a43de040ac.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:4d00:8f1c:57a4:3de0:40ac])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 48C0F1EC0118;
        Thu, 31 Dec 2020 17:09:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609430966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NWKl8aw9bup8LBwv6TIkptNUm5HA5kJuYn5BURCXhCo=;
        b=gEtTQc6FQGAjmKlciVskTYCiOuOFvR7vOX76XxMfgkShgI1X3kVtJZYrhbyY45yNa8Ma78
        i9L8nCqApH+cDTofecjb3QbKPT3fH4MluV/Zp5uhM4AJsOBPX6TLijbIYubDGgRiwWUXaC
        RtRwAED05M6tWBu8H4BvZDOK15N6Rvg=
Date:   Thu, 31 Dec 2020 17:09:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>, x86@kernel.org
Subject: Re: [PATCH -tip v2] x86/kprobes: Do not decode opcode in
 resume_execution()
Message-ID: <20201231160923.GB4504@zn.tnic>
References: <20201218214432.b025656de019c64a8f4e2da5@kernel.org>
 <160830072561.349576.3014979564448023213.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <160830072561.349576.3014979564448023213.stgit@devnote2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 11:12:05PM +0900, Masami Hiramatsu wrote:
> @@ -467,8 +489,8 @@ static int arch_copy_kprobe(struct kprobe *p)
>  	 */
>  	len = prepare_boost(buf, p, &insn);
>  
> -	/* Check whether the instruction modifies Interrupt Flag or not */
> -	p->ainsn.if_modifier = is_IF_modifier(buf);
> +	/* Analyze the opcode and set resume flags */
> +	set_resume_flags(p, &insn);

So this function wants to be called something like analyze_insn() or so
then? set_resume_flags() is kinda misleading as a name.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
