Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE9C51A0CA2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 13:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgDGLNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 07:13:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42482 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgDGLNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 07:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=jKJXZpzzDrrjmwLNRHLcBZgkJJqiHAXwqSXGUdiOBYo=; b=0j+dqzCwYKeCySGxRekkKqS18I
        Ci4hvKzYPKjEPtpr0yDYoOQfLkgInKK5Am6VbHyjnWE+6tpIXnkM++yfH69CFy+71eKW0wOLC15EM
        mGUfAbvj14OTkzee+xcIuGyRFMTgOF1sOzUhvQTCqHlgi6mh3Nmqd1Mkv1N2wiijcwvjjIfEsPut9
        meT/gty9dwvqxnuuGuK4n8ZnF2tQvNjMvv04Q8Z595cDgt0rF3ckoUIpnvHZEvJcT8vT3VgJNc8ew
        4oVAMlOUcslek5ZWl43n7ciUgQp1chuZYE6BI0o52KWcC1c1GVM5X+ZmFJ5EkMGTD34EdVgEPW9BD
        55DFhRVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLm9m-0007DP-Oh; Tue, 07 Apr 2020 11:12:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4E45D30604B;
        Tue,  7 Apr 2020 13:12:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 25ACF29C96F21; Tue,  7 Apr 2020 13:12:36 +0200 (CEST)
Message-Id: <20200407111007.429362016@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 07 Apr 2020 13:02:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, peterz@infradead.org, jeyu@kernel.org,
        rasmus.villemoes@prevas.dk, pbonzini@redhat.com,
        fenghua.yu@intel.com, xiaoyao.li@intel.com, nadav.amit@gmail.com,
        thellstrom@vmware.com, tony.luck@intel.com, rostedt@goodmis.org,
        gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
Subject: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
References: <20200407110236.930134290@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we now have infrastructure to analyze module text, disallow
modules that write to CRn and DRn registers.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/module.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -266,6 +266,22 @@ static bool insn_is_vmx(struct insn *ins
 	return false;
 }
 
+static bool insn_is_mov_CRn(struct insn *insn)
+{
+	if (insn->opcode.bytes[0] == 0x0f && insn->opcode.bytes[1] == 0x22)
+		return true;
+
+	return false;
+}
+
+static bool insn_is_mov_DRn(struct insn *insn)
+{
+	if (insn->opcode.bytes[0] == 0x0f && insn->opcode.bytes[1] == 0x23)
+		return true;
+
+	return false;
+}
+
 static int decode_module(struct module *mod, void *text, void *text_end, bool sld_safe)
 {
 	bool allow_vmx = sld_safe || !split_lock_enabled();
@@ -285,6 +301,11 @@ static int decode_module(struct module *
 			return -ENOEXEC;
 		}
 
+		if (insn_is_mov_CRn(&insn) || insn_is_mov_DRn(&insn)) {
+			pr_err("Module writes to CRn or DRn, please use the proper accessors: %s\n", mod->name);
+			return -ENOEXEC;
+		}
+
 		text += insn.length;
 	}
 


