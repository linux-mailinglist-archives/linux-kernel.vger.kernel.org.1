Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DB92135E0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 10:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgGCIKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 04:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGCIKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:10:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAABDC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 01:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qyNKhWWtlbghyMESKDS3JubVL54HiFWDnruxbzE7Xw8=; b=XawvvmmpHuGQQlPhfd1bcRl64S
        IWJBcd0ypywV6TYO+lFH6oKsQ+P+3/iwA40JeKlPJ+8iwnf1T6FutzijP06qAChmz3Eu8ygjQ1Rlr
        Mg1wYMUWBrG8NrXuuWDIqF3RvzxPrRitbYzGmOcuQtiveC++clYPSkSVOpGb0m83nys4OGfXAcUDk
        Q5yMHFddnVxVchyKN9s/DgiHrEATeEbhrKVX5qUD31wcDf1Y3FhxIKwTaf1tGFfas9do+haihsAGx
        7cDSnzmj1rckIkexXTiSBdlBbO3E9I89aGpVcqAh9AnWGmD5sGo3u0usDv4gddFMf7tYTkPx8LYm+
        p2BpcMGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrGlo-0000He-Ds; Fri, 03 Jul 2020 08:10:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1782F30377D;
        Fri,  3 Jul 2020 10:10:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BFEF3236502FC; Fri,  3 Jul 2020 10:10:00 +0200 (CEST)
Date:   Fri, 3 Jul 2020 10:10:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 04/18] x86/ftrace: Do not jump to direct code
 in created trampolines
Message-ID: <20200703081000.GT4800@hirez.programming.kicks-ass.net>
References: <20200702215812.428188663@goodmis.org>
 <20200702215832.049969400@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702215832.049969400@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 05:58:16PM -0400, Steven Rostedt wrote:

> +	/* No need to test direct calls on created trampolines */
> +	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
> +		/* NOP the jnz 1f; but make sure it's a 2 byte jnz */
> +		ip = trampoline + (jmp_offset - start_offset);
> +		if (WARN_ON(*(char *)ip != 0x75))
> +			goto fail;
> +		ret = copy_from_kernel_nofault(ip, ideal_nops[2], 2);

I really don't get this paranoia, what's wrong with memcpy() ?

> +		if (ret < 0)
> +			goto fail;
> +	}

How about something like this?

--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -359,17 +359,11 @@ create_trampoline(struct ftrace_ops *ops
 	npages = DIV_ROUND_UP(*tramp_size, PAGE_SIZE);
 
 	/* Copy ftrace_caller onto the trampoline memory */
-	ret = copy_from_kernel_nofault(trampoline, (void *)start_offset, size);
-	if (WARN_ON(ret < 0))
-		goto fail;
-
-	ip = trampoline + size;
+	memcpy(trampoline, (void *)start_offset, size);
 
 	/* The trampoline ends with ret(q) */
-	retq = (unsigned long)ftrace_stub;
-	ret = copy_from_kernel_nofault(ip, (void *)retq, RET_SIZE);
-	if (WARN_ON(ret < 0))
-		goto fail;
+	ip = trampoline + size;
+	memcpy(ip, text_gen_insn(RET_INSN_OPCODE, NULL, NULL), RET_INSN_SIZE);
 
 	/* No need to test direct calls on created trampolines */
 	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
@@ -377,9 +371,7 @@ create_trampoline(struct ftrace_ops *ops
 		ip = trampoline + (jmp_offset - start_offset);
 		if (WARN_ON(*(char *)ip != 0x75))
 			goto fail;
-		ret = copy_from_kernel_nofault(ip, ideal_nops[2], 2);
-		if (ret < 0)
-			goto fail;
+		memcpy(ip, ideal_nops[2], 2);
 	}
 
 	/*
