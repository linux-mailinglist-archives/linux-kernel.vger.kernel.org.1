Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F682C5FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 06:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbgK0Fy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 00:54:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbgK0Fy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 00:54:27 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C263B21D93;
        Fri, 27 Nov 2020 05:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606456467;
        bh=5ctbX89GWXFg+RtHS4br2VM3KwvqrpQgG1C845unqX8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ltyMqA4Obs5b5cOwSjBJenjNuBsKTADxIxAz3gz91mklZFBxginP9Tkhkv40iYOO6
         Gdc3h/TR7aXpUW1YRr5GegM8NTvjCCk9ehUWJHaFVgTY2Boif4nDeSWIE6c1rxeLyU
         pWid8dF0dYNonMeeqDoTHreJFF9YTKclpU9N2L6Q=
Date:   Fri, 27 Nov 2020 14:54:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v0 03/19] x86/insn: Add an insn_decode() API
Message-Id: <20201127145423.53415b1e90007355159d718d@kernel.org>
In-Reply-To: <20201126175011.GE31565@zn.tnic>
References: <20201124101952.7909-1-bp@alien8.de>
        <20201124101952.7909-4-bp@alien8.de>
        <20201126015333.fb0fb2b548013073ce72f19f@kernel.org>
        <20201125192553.GD9996@zn.tnic>
        <20201126103709.23d581fe2320f14a272a7dc5@kernel.org>
        <20201126175011.GE31565@zn.tnic>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 18:50:11 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Thu, Nov 26, 2020 at 10:37:09AM +0900, Masami Hiramatsu wrote:
> > BTW, the instruction validation depends on who needs it, because to
> > check the all invalid ops, we need more information in the x86-opcode-map.txt
> > and it will bloat up the table size and consumes more time to analysis.
> 
> Yes, the decoder is supposed to serve the kernel's needs, not be a
> general purpose one.
> 
> > (Moreover, it depends on the processor generation -- older processor will
> > not support VEX prefix, those are invalid)
> 
> Why does the processor VEX support matter? Isn't the decoder supposed to
> decode any instruction it knows about, regardless of the CPU it runs on?

Hm, you meant the "invalid" means "that can not be decoded" ?
Then it is OK. I Thought "invalid" means "the processor can not execute
(some exception will occur)".

> 
> > OK, then could you use -1 instead of 1? It may allow us to expand it
> > to return error code in the future.
> 
> Ok, sure.

Thanks!

> 
> > I think insn_get_prefixes() can be used independently, because x86
> > perfix bytes is very complex.
> 
> Yah, it all depends on what API interfaces we want to give to users and
> make those other helpers internal. Time and usecases will tell.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette


-- 
Masami Hiramatsu <mhiramat@kernel.org>
