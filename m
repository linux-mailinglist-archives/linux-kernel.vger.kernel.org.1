Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0792F19F3CC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 12:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgDFKqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 06:46:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgDFKqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 06:46:23 -0400
Received: from linux-8ccs (p3EE2C7AC.dip0.t-ipconnect.de [62.226.199.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E0512072A;
        Mon,  6 Apr 2020 10:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586169982;
        bh=VeFFXsuWR9uPnSwDIxLT71XI7ZXHdNrRVMRE7hUENAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mJZCbwkbRogcgKRxcNXZSbRnvT9QZHFNAxjiSFYxhNorCHA1rUD8O4fgrVgumj6rG
         B1zu+ds1Fy+WIm8V6c39ZkyoQmwmHHeJ48uqi61gWhJcP/7Z4VWlE1ufTIkoK2MZT2
         E2cLhUEUhqSxw9nQRr0gSgGCZ69kh/CGEt+ge1Ts=
Date:   Mon, 6 Apr 2020 12:46:17 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        keescook@chromium.org
Subject: Re: [PATCH] module: Harden STRICT_MODULE_RWX
Message-ID: <20200406104615.GA9629@linux-8ccs>
References: <20200403163716.GV20730@hirez.programming.kicks-ass.net>
 <20200403165631.hrxxm3pnzqa4vxln@treble>
 <alpine.LSU.2.21.2004061146590.26870@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2004061146590.26870@pobox.suse.cz>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Miroslav Benes [06/04/20 11:55 +0200]:
>On Fri, 3 Apr 2020, Josh Poimboeuf wrote:
>
>> On Fri, Apr 03, 2020 at 06:37:16PM +0200, Peter Zijlstra wrote:
>> > +{
>> > +	int i;
>> > +
>> > +	for (i = 0; i < hdr->e_shnum; i++) {
>> > +		if (sechdrs[i].sh_flags & (SHF_EXECINSTR|SHF_WRITE))
>> > +			return -ENOEXEC;
>>
>> I think you only want the error when both are set?
>>
>> 		if (sechdrs[i].sh_flags & (SHF_EXECINSTR|SHF_WRITE) == (SHF_EXECINSTR|SHF_WRITE))
>
>A section with SHF_EXECINSTR and SHF_WRITE but without SHF_ALLOC would be
>strange though, no? It wouldn't be copied to the final module later
>anyway.

That's right - move_module() ignores !SHF_ALLOC sections and does not
copy them over to their final location. So I think we want to look for
SHF_EXECINSTR|SHF_WRITE|SHF_ALLOC here..

>Looking at layout_sections()... a section with
>SHF_EXECINSTR|SHF_WRITE|SHF_ALLOC would not be counted at all.

Also correct, a section with SHF_EXECINSTR|SHF_WRITE|SHF_ALLOC would
be ignored as it matches none of the masks listed in
layout_sections() - its section->sh_entsize will stay ~0UL.

>However,
>move_module() later copies everything with SHF_ALLOC flag to the final
>module. If there is WXA section, there would be a bug because the
>allocation there would not get the correct size. In that case it is
>important to error out early as you're proposing.

That would be a bug indeed, - we'd get a completely wrong offset to
copy into since sh_entsize was never initialized. Actually, there
should probably be a check for that in move_module() :-/

>Am I missing something?

Nope, thanks for double checking everything!

Jessica
