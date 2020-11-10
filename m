Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799452AD24A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 10:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbgKJJUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 04:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730774AbgKJJUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 04:20:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22561C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 01:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vZFMNhjhPWjL/0GaxK9LIuP9627bSGwtvL7soQpbxTU=; b=O4UqSnhc6h0rScQ4vXsf7s7tF9
        1jqumvWJhlzcM/qG7GlQ/ETLT9ZJmaXeItCalkdL61C6nbAWkfekWAScL8lKZdbUHW5Di0tkKZtKm
        DA0uW+W5vZwXsfHASKMnytmix0VR8sYtKkUSPsSWxvyvutWIuyATi+3UUZlCnW0qRl9cesI5B5JgF
        E7Ei4XHfB+/F7tNbE9Ohsw1d5OLCDd2Q7oB+uv2heNQQN4rep3aIMrqeGvlPyJ1YbJwqTQNcCrbIX
        wPO0qziHi0Ya6TjOOy+jPKC99WiKkoB5ZsIb3YHANLMMjOZT5y2FsYB93s/0XiBvsFjCzqM30Gwev
        Vn6IG0dw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcPoq-0001cm-O4; Tue, 10 Nov 2020 09:20:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B72D300238;
        Tue, 10 Nov 2020 10:20:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E5DBB2C09A80F; Tue, 10 Nov 2020 10:20:03 +0100 (CET)
Date:   Tue, 10 Nov 2020 10:20:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 2/3 v4] ftrace/x86: Allow for arguments to be passed in
 to ftrace_regs by default
Message-ID: <20201110092003.GX2594@hirez.programming.kicks-ass.net>
References: <20201106214234.618790276@goodmis.org>
 <20201106214403.328699055@goodmis.org>
 <20201109111043.GD2594@hirez.programming.kicks-ass.net>
 <20201109181610.1b3f7d9f@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109181610.1b3f7d9f@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 06:16:10PM -0500, Steven Rostedt wrote:
> ftrace_caller:
> 	[..]
> 	movq $0, CS(%rsp) <- loads zero into pt_regs->cs for internal use only.
> 	[..]

Argh, I missed that. I failed to spot it in the patch. No worries then.
