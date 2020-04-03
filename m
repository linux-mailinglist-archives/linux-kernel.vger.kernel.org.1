Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 426D219DC75
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 19:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390910AbgDCRNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 13:13:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49922 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgDCRNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=jv9Yf7cQCjMobtLa9/No1kE+P61DSmIa48Wq8z5iHcI=; b=BHzwZZovpp1Jkmqku0nupezxv5
        IgyOcoOt6ZwXcDyaavQROpQU6N9/O/KIC91FiiaaKEAtkyQPzeWvh/+Va3qoUK8Tk6iK2DYiOSR2l
        QsCCEvPl11kbipf0xEqUmNCn24YAqgQiTinb3gkG3xnb0O0X4Qc3oeo1a7SyJhRy9up+2oavIeyBF
        tH9MQLug1ROCSisewPft92IoZj/Vp1sNPrrB3tvWvhOjxpmdCS5KHiK9m97aX1tkY3Nn63VOmkOrZ
        8iyNHZ0s+ZNliRrey8DpfrAaLhZmFQvdZsRyEQl7KSrysGlPnpKXHpsxuhu0d+UUeaJaBoKr6oj55
        otM7PcFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKPsO-0003oN-Ct; Fri, 03 Apr 2020 17:13:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 394F53060FD;
        Fri,  3 Apr 2020 19:13:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 250C12B125211; Fri,  3 Apr 2020 19:13:03 +0200 (CEST)
Date:   Fri, 3 Apr 2020 19:13:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jeyu@kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        keescook@chromium.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200403171303.GK20760@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


We're very close to enforcing W^X memory, refuse to load modules that
violate this principle per construction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/module.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2044,9 +2044,29 @@ static void module_enable_x(const struct
 	frob_text(&mod->core_layout, set_memory_x);
 	frob_text(&mod->init_layout, set_memory_x);
 }
+
+static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
+				       char *secstrings, struct module *mod)
+{
+	const unsigned long shf_wx = SHF_WRITE|SHF_EXECINSTR;
+	int i;
+
+	for (i = 0; i < hdr->e_shnum; i++) {
+		if ((sechdrs[i].sh_flags & shf_wx) == shf_wx)
+			return -ENOEXEC;
+	}
+
+	return 0;
+}
+
 #else /* !CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
 static void module_enable_nx(const struct module *mod) { }
 static void module_enable_x(const struct module *mod) { }
+static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
+				       char *secstrings, struct module *mod)
+{
+	return 0;
+}
 #endif /* CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
 
 
@@ -3378,6 +3398,11 @@ static struct module *layout_and_allocat
 	if (err < 0)
 		return ERR_PTR(err);
 
+	err = module_enforce_rwx_sections(info->hdr, info->sechdrs,
+					  info->secstrings, info->mod);
+	if (err < 0)
+		return ERR_PTR(err);
+
 	/* We will do a special allocation for per-cpu sections later. */
 	info->sechdrs[info->index.pcpu].sh_flags &= ~(unsigned long)SHF_ALLOC;
 
