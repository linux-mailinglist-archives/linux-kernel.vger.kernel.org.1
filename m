Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1575F2C22AF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbgKXKUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:20:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50298 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731551AbgKXKUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:20:02 -0500
Received: from zn.tnic (p200300ec2f0e360052021be21853ebf1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3600:5202:1be2:1853:ebf1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6AA971EC0258;
        Tue, 24 Nov 2020 11:20:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606213201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Wv35TDRv00HluIFQYfNHbq2ifcdB/WqVOCOaknQ4EU=;
        b=YXvbSkxDqbgewP5a9z/RJ5XSvuQwdKLY7aNuyrhlJoQdMuODaNy0wLibbqjRpbDdStwo4n
        JtNXlpWVXc53duKXkTRVVcVx5Vqgoi+QNt74M5+Puh+HCjSfFGXCn/A2NvCPv/fFqS8rcR
        bXKgKe53v1kh78DjFx1Xfo7nTBeaxYs=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v0 02/19] x86/insn: Add @buf_len param to insn_init() kernel-doc comment
Date:   Tue, 24 Nov 2020 11:19:35 +0100
Message-Id: <20201124101952.7909-3-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201124101952.7909-1-bp@alien8.de>
References: <20201124101952.7909-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

It wasn't documented so add it. No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/lib/insn.c       | 1 +
 tools/arch/x86/lib/insn.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 404279563891..1ba994862b56 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -37,6 +37,7 @@
  * insn_init() - initialize struct insn
  * @insn:	&struct insn to be initialized
  * @kaddr:	address (in kernel memory) of instruction (or copy thereof)
+ * @buf_len:	length of the insn buffer at @kaddr
  * @x86_64:	!0 for 64-bit kernel or 64-bit app
  */
 void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 0151dfc6da61..f3277d6e4ef2 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -37,6 +37,7 @@
  * insn_init() - initialize struct insn
  * @insn:	&struct insn to be initialized
  * @kaddr:	address (in kernel memory) of instruction (or copy thereof)
+ * @buf_len:	length of the insn buffer at @kaddr
  * @x86_64:	!0 for 64-bit kernel or 64-bit app
  */
 void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
-- 
2.21.0

