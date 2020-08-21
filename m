Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C99724D222
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 12:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgHUKVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 06:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgHUKVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:21:44 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FB8C061387
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=BBFik8OMrjAaey9iGh+N20aQbFx55dJdJi3NrRTf+PY=; b=AzRbqRy3U2KTgLaqvmvlMqziBG
        xCNBWiYXKy36xiSiVg5Aqj18FYvkQvKiBeJyr5YIX87P7piZH79D0vCQUVRrWPr2HUS/b4IsjNDxq
        WbrAfS5n9vFwpRGF1jUo3jVLVeH10NcRiZuQZzDtB7PT5+sHQjxzUHVpqU5Sk/mEOJpPwYBT5Qyup
        Ol4FUTBkJ03BDRhcF+KwTHjdXiD7K1Oks9ND8ZNdYKbY6n7mdFNt+xmvXaglUoM4ZR8ayCmNFOPu+
        +HJQ+G18GXcF/y+AnV+Zjs27efkAhCu4xfOahKsh1NAqw3uPDnTn5tcLB5w2D3RegxEnORKLq//mx
        yuyYoJ+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k94An-0008GN-Qu; Fri, 21 Aug 2020 10:21:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 69A5C303271;
        Fri, 21 Aug 2020 12:21:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 54CA42C8FF366; Fri, 21 Aug 2020 12:21:24 +0200 (CEST)
Message-ID: <20200821102052.851667174@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Aug 2020 11:39:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 2/8] x86/debug: Sync BTF earlier
References: <20200821093912.815135402@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the BTF sync near the DR6 load, as this will be the only common
code guaranteed to run on every #DB.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/traps.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -749,6 +749,13 @@ static __always_inline unsigned long deb
 	/* Filter out all the reserved bits which are preset to 1 */
 	dr6 &= ~DR6_RESERVED;
 
+	/*
+	 * The SDM says "The processor clears the BTF flag when it
+	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
+	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
+	 */
+	clear_thread_flag(TIF_BLOCKSTEP);
+
 	return dr6;
 }
 
@@ -783,13 +790,6 @@ static void handle_debug(struct pt_regs
 	int si_code;
 
 	/*
-	 * The SDM says "The processor clears the BTF flag when it
-	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
-	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
-	 */
-	clear_thread_flag(TIF_BLOCKSTEP);
-
-	/*
 	 * If DR6 is zero, no point in trying to handle it. The kernel is
 	 * not using INT1.
 	 */


