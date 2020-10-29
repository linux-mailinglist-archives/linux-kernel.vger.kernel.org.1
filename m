Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E65029EB3E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgJ2ME6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2ME6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:04:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B12C0613CF;
        Thu, 29 Oct 2020 05:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o687iw3cdVKlrtAY0hVT9GT6GWB0dk8OiWOKpnhjMLg=; b=gmyldzWAHEGGIUSuub4fO2AJRD
        fw2n5JKinmfwX7At1VNZ4KOnNc+s0IuOygjNrKCv2KRVKgk2MjEgEEKTbqywbjtZJoDLyHJcCZ+lC
        kgcs595Vkzz0fm4FGm1Ef5VLREFs6X5QKsEpsN9B55cOiFepPXSy72O9q6xVm9dVI0JxavG1jukxD
        5f/vaz/af4YiQJa1/SwPon5BEJngXOHSXb3e+AhWW8trfR1Nf2DdgbeQPmqSQ4H1n5kF2GmwNqTyX
        x8Zzy6KZS9vqf/T3OvLPxkUU22vIbLnl7Glq+07ShxZ3TEaIDOPeB604e0qpr9rkmFED4AJNGZPwf
        sfNg+BdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kY6fc-0008AP-QD; Thu, 29 Oct 2020 12:04:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 104023012C3;
        Thu, 29 Oct 2020 13:04:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EEB212B772B22; Thu, 29 Oct 2020 13:04:42 +0100 (CET)
Date:   Thu, 29 Oct 2020 13:04:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Walter Harms <wharms@bfs.de>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-safety@lists.elisa.tech" <linux-safety@lists.elisa.tech>
Subject: Re: [PATCH] x86/unwind: remove unneeded initialization
Message-ID: <20201029120442.GP2628@hirez.programming.kicks-ass.net>
References: <20201028122102.24202-1-lukas.bulwahn@gmail.com>
 <a28022479f594650a6d98adac3c4a6f0@bfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a28022479f594650a6d98adac3c4a6f0@bfs.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 11:49:50AM +0000, Walter Harms wrote:
> this looks like a reimplementation of bsearch()
> perhaps the maintainer can add a comment why the 
> kernel implementation is not suitable here ?

If you look carefully it doesn't do an exact match, which is what
bsearch() does.

bsearch() also isn't stable in the precense of duplicates.
