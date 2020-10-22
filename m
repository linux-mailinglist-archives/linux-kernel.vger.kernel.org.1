Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B292959CC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509226AbgJVIEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509219AbgJVIEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:04:11 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DE2C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 01:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DRwURuIBlVcNh1Xd/0SVQ6zdBWlHXMl/FyFsUAu3tcw=; b=XFIsD1PnTAy1Xr9PoUrK5+XzqA
        4aVum3GudJAIvd4GFhXNmWpSGUEa67WL2ZYVELX0e7U0vFmT+2PYvZiFAHoPvgxeOCnJBfmF/8o+B
        sEyesE5NGTFXeyEwrKjuUe+eEH2H7qf7+bY9/l7SRXA1/gRp3t/9gp5Ooss5A8mN3T3YJN+y4Mny3
        n1hQk78VIBOf8mwIZ3XvDMAHDILyCnUCwOrQ2mQqqrXbq3e+88gZd0eGCJFQT9abCkk+RpQfQ4UfX
        y9R1wzkaizAFA8tIgsRzZV5Dy+AEwZxa04GnIpzv6oYbaGdCXCO7yXmO3do8KjKo/eY/19hzMP14k
        zRAZhDDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVVZu-0008Pa-Lj; Thu, 22 Oct 2020 08:04:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6712130377D;
        Thu, 22 Oct 2020 10:04:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5621C2B7802F0; Thu, 22 Oct 2020 10:04:05 +0200 (CEST)
Date:   Thu, 22 Oct 2020 10:04:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, x86-ml <x86@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-ID: <20201022080405.GS2628@hirez.programming.kicks-ass.net>
References: <20201020120232.GD11583@zn.tnic>
 <20201020232700.5510c236d810b7f8a66779e2@kernel.org>
 <20201020143746.GG11583@zn.tnic>
 <20201021095013.d82637f84af564ae4363189d@kernel.org>
 <20201021092750.GA4050@zn.tnic>
 <20201021232613.e40c1daef4b567e0e29044a4@kernel.org>
 <20201021164558.GB4050@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021164558.GB4050@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 06:45:58PM +0200, Borislav Petkov wrote:
> On Wed, Oct 21, 2020 at 11:26:13PM +0900, Masami Hiramatsu wrote:
> > Hmm, I meant someone might think it can be used for filtering the
> > instruction something like,
> > 
> > insn_init(insn, buf, buflen, 1);
> > ret = insn_get_length(insn);
> > if (!ret) {
> > 	/* OK, this is safe */
> > 	patch_text(buf, trampoline);
> > }
> > 
> > No, we need another validator for such usage.
> 
> Well, I think calling insn_get_length() should give you only the
> *length* of the insn and nothing else - I mean that is what the function
> is called. And I believe current use is wrong.
> 
> Examples:
> 
> arch/x86/kernel/kprobes/core.c:
>                 insn_get_length(&insn);
> 
>                 /*
>                  * Another debugging subsystem might insert this breakpoint.
>                  * In that case, we can't recover it.
>                  */
>                 if (insn.opcode.bytes[0] == INT3_INSN_OPCODE)
> 
> So this has called get_length but it is far from clear that after that
> call, the opcode bytes in insn.opcode.bytes are there.

Given the trainwreck called x86-instruction-encoding, it's impossible to
not have decoded the opcode and still know the length. Therefore, if you
know the length, you also have the opcode. Hm?
