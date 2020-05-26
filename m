Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAF71AC8E3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 17:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394996AbgDPPQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 11:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2395072AbgDPPMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:12:18 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4287EC0610D5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9MwTIMpdaC4VygWnq1XRJh2I8O/EbbREN7voJhdd838=; b=REe17TcBlezyGYkTFxpl06sEVD
        COBJ1rTV/OvT+Av5oNHPDbrbn3FC5ZrffRNxo6E1Ro7YSTubSgsPEStPA6nzlG0nJJd5HbIicXyOR
        FKQnqPMqoVGIrelhqBR4E2r9hwVPiT0qZAjOvcSnT46InCkkyvmwLrsW3i6YGzjpPDR+Y50ad4n5Q
        brxNokmHtiMV8T9qUOeDZHMeHUBsRPaflrmKRIyiIrfeoubcGtL8xYCJDNF2AfmKap/BiLYHosdzy
        MPfGJLLTE3EFskGVgxYLaQnjMuLPk1fNzZC2dIN0OZUOIOJG6KYTanYswkUhXu6xd+0rcppp0LgdY
        BCq2yWMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP6BH-00046c-L6; Thu, 16 Apr 2020 15:11:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 235A63071D5;
        Thu, 16 Apr 2020 17:11:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 01F952B0DE4BC; Thu, 16 Apr 2020 17:11:54 +0200 (CEST)
Message-Id: <20200416151024.825863887@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 17:07:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 2/7] objtool: UNWIND_HINT_RET_OFFSET should not check registers
References: <20200416150752.569029800@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Chartre <alexandre.chartre@oracle.com>

UNWIND_HINT_RET_OFFSET will adjust a modified stack. However if a
callee-saved register was pushed on the stack then the stack frame
will still appear modified. So stop checking registers when
UNWIND_HINT_RET_OFFSET is used.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200407073142.20659-3-alexandre.chartre@oracle.com
---
 tools/objtool/check.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1513,6 +1513,14 @@ static bool has_modified_stack_frame(str
 	if (cfi->stack_size != initial_func_cfi.cfa.offset + ret_offset)
 		return true;
 
+	/*
+	 * If there is a ret offset hint then don't check registers
+	 * because a callee-saved register might have been pushed on
+	 * the stack.
+	 */
+	if (ret_offset)
+		return false;
+
 	for (i = 0; i < CFI_NUM_REGS; i++) {
 		if (cfi->regs[i].base != initial_func_cfi.regs[i].base ||
 		    cfi->regs[i].offset != initial_func_cfi.regs[i].offset)


