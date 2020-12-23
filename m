Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4712E19E6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgLWIYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgLWIYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:24:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1197CC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 00:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tp7btXv5fh0AyxUwJtWbQ5xEJ3yfKa4NDNQ6BNO/2ng=; b=TGg8zFcVOyxLssxq0mWWJF9vL2
        auT1KvIGFQ8vDcWwa5fqMu2YZGrUbUOuzn7c4BK1Rt/v3sW+kOED+QFHTrH/DECvQ+wL6wTr4xhpi
        cIpIPaPcSjXANE2ConOihMtjC3UDX3rQRDl3lW6dIP2EcKP8wHN+7JGSWcpCwUGg7mpJTSuONjQOy
        mMa2xFqOmmPlJjKFp8h0moomSP9ySLaVMswZRa83N49Ab6NO4+tSDf3Jve/twS2uZtSobqnVTX1MY
        33qF4PcRp+siS1mIDTTuHoFiej+sBluSdX44XiqL5l1u4d/o9H3NPlHQB/Asj8PI6c+UpMZmnMj72
        MWL5ja+w==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krzRE-0006Zm-LA; Wed, 23 Dec 2020 08:24:04 +0000
Date:   Wed, 23 Dec 2020 08:24:04 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Andreas Schwab <schwab@suse.de>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH] riscv: return -ENOSYS for syscall -1
Message-ID: <20201223082404.GB24581@infradead.org>
References: <mvma6u6vkkv.fsf@suse.de>
 <20201222162219.GA710211@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222162219.GA710211@cisco>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 09:22:19AM -0700, Tycho Andersen wrote:
> On Mon, Dec 21, 2020 at 11:52:00PM +0100, Andreas Schwab wrote:
> > Properly return -ENOSYS for syscall -1 instead of leaving the return value
> > uninitialized.  This fixes the strace teststuite.
> > 
> > Fixes: 5340627e3fe0 ("riscv: add support for SECCOMP and SECCOMP_FILTER")
> > Signed-off-by: Andreas Schwab <schwab@suse.de>
> > ---
> >  arch/riscv/kernel/entry.S | 9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index 524d918f3601..d07763001eb0 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -186,14 +186,7 @@ check_syscall_nr:
> >  	 * Syscall number held in a7.
> >  	 * If syscall number is above allowed value, redirect to ni_syscall.
> >  	 */
> > -	bge a7, t0, 1f
> > -	/*
> > -	 * Check if syscall is rejected by tracer, i.e., a7 == -1.
> > -	 * If yes, we pretend it was executed.
> > -	 */
> > -	li t1, -1
> > -	beq a7, t1, ret_from_syscall_rejected
> > -	blt a7, t1, 1f
> > +	bgeu a7, t0, 1f
> 
> IIUC, this is all dead code anyway for the path where seccomp actually
> rejects the syscall, since it should do the rejection directly in
> handle_syscall_trace_enter(), which is called above this hunk. So it
> seems good to me.

That change really needs to be documented in the commit log, or even
better split into a separate patch (still documented of course!).
