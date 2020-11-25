Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF102C3A72
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 09:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgKYIDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 03:03:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:54706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgKYIDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 03:03:14 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4305206E0;
        Wed, 25 Nov 2020 08:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606291393;
        bh=C9d5xGXDNAU59dVlYWlP0XCIr6e+igQvLHL4OJJstVg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I5QBlGwAG+yZ7qvbfCkl/XZCBYUiG3qX5OLJ/csghtw3uRS0L5wWDqfqt5iufOgHO
         OxNaXiUA3Ke562BQIlYJEi/26JvCG6PrkI+mBR66MOYc7Y3cAI3Yl2XEE4NNPaQNfA
         3lO2CHbD7Atoj2dMaeUJ5Fr1XLSJgveqDiPTYIPM=
Date:   Wed, 25 Nov 2020 17:03:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v0 00/19] x86/insn: Add an insn_decode() API
Message-Id: <20201125170310.aa4cd1722b05288612fd9c84@kernel.org>
In-Reply-To: <20201124174647.GI4009@zn.tnic>
References: <20201124101952.7909-1-bp@alien8.de>
        <20201124174647.GI4009@zn.tnic>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020 18:46:47 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Nov 24, 2020 at 11:19:33AM +0100, Borislav Petkov wrote:
> > In any case, at least the case where I give it
> > 
> > 0x48 0xcf 0x48 0x83
> > 
> > and say that buf size is 4, should return an error because the second
> > insn is incomplete. So I need to go look at that now.
> 
> Ok, got it:
> 
> ./arch/x86/tools/insn_sanity: Success: decoded and checked 10000 random instructions with 0 errors (seed:0x826fdf9c)
> insn buffer:
> 0x48 0xcf 0x48 0x83 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 
> supplied buf size: 15, ret 0
> supplied buf size: 2, ret 0
> supplied buf size: 3, ret 0
> supplied buf size: 4, ret 0
> supplied buf size: 1, ret -22
> 
> the current decoder simply decodes the *first* insn in the buffer it
> encounters and that's it.

Yes, currently the buf_size is only for checking the maximum length of
the buffer, because we expect the user doesn't know the actual length of
the instruction before calling insn_get_length().
But yes, for the insn_sanity.c, the return length should be compared.

Thank you,

> 
> When you give it a buffer of size smaller than the first instruction:
> 
> supplied buf size: 1, ret -22
> 
> while the first insn is 2 bytes long:
> 
> 0x48 0xcf (IRETQ)
> 
> then it signals an error.
> 
> Andy, does that work for your use cases?
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette


-- 
Masami Hiramatsu <mhiramat@kernel.org>
