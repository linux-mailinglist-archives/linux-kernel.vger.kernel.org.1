Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1946A24D0EA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 10:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgHUIzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 04:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbgHUIzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:55:16 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D58C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 01:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=f1hM3gm8CscKg7FnT79+/7u4LVsL5XQlazXrZ7YhNtg=; b=wrIzxS3J/nfYZtBg2qP5h9dOQm
        AC2XMGbpsVcpH6dZfrcSX2kfmrbzb5ZozkIYwwOSp804V2CLbZKrXeZGvjKLUx0uS6PmhXDJLL/Ja
        /Z3VmNhKBOPCClidNPxaWrdrjTXs8IaBKk0wfWRvKj9JJLC3FrgqidRiGutzyPNMfg23JXhKihKx8
        JLjlhETD4MvI5YLdI3mllFBSXZfqKqC4KAcV9RIA4WN+dcDbeMABhBjGjhJymoiVMKWeeapLY/gzQ
        ysigxFHHOreI31KBEBA5Oy0+0tzfpyu+Fuod579Xfwf9aPZ0O+1u28FhejnbbKKh5ZE9S6Bj5Av6Y
        xq58p93Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k92p6-0008V3-CD; Fri, 21 Aug 2020 08:54:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D6981307691;
        Fri, 21 Aug 2020 10:54:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0292B2B64991B; Fri, 21 Aug 2020 10:54:49 +0200 (CEST)
Message-ID: <20200821085348.604899379@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Aug 2020 10:47:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org
Cc:     npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        peterz@infradead.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: [PATCH v2 08/11] nds32: Implement arch_irqs_disabled()
References: <20200821084738.508092956@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Cc: Nick Hu <nickhu@andestech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Marco Elver <elver@google.com>
---
 arch/nds32/include/asm/irqflags.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/nds32/include/asm/irqflags.h
+++ b/arch/nds32/include/asm/irqflags.h
@@ -34,3 +34,8 @@ static inline int arch_irqs_disabled_fla
 {
 	return !flags;
 }
+
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}


