Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5422C22B5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbgKXKUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:20:16 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50342 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731863AbgKXKUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:20:10 -0500
Received: from zn.tnic (p200300ec2f0e360052021be21853ebf1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3600:5202:1be2:1853:ebf1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7422E1EC0258;
        Tue, 24 Nov 2020 11:20:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606213209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8bXJvGwXJ0S/8F5qrEfTDu1a5Q+Rd2aTQVU42AyDxHM=;
        b=MDRVw1Ij8aeyd6zvmeCYsGdSTgZR9kBgwcEvoi/gBhZEhkTBCxAovvdb6KIlriRDxdbw8p
        x3AuCKayh3w75tjJ6qtW0h2mPQYhya/t5Zvbc36vm6a2qc6u0idfgzJK4Qmm6jVIMHY57r
        vPdU/qG9x1UJwyWZAMTxQjE3buB8Ee8=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v0 13/19] x86/uprobes: Convert to insn_decode()
Date:   Tue, 24 Nov 2020 11:19:46 +0100
Message-Id: <20201124101952.7909-14-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201124101952.7909-1-bp@alien8.de>
References: <20201124101952.7909-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Simplify code, no functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/uprobes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 3fdaa042823d..e5759310f499 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -275,12 +275,12 @@ static bool is_prefix_bad(struct insn *insn)
 
 static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool x86_64)
 {
+	enum insn_mode m = x86_64 ? INSN_MODE_64 : INSN_MODE_32;
 	u32 volatile *good_insns;
+	int ret;
 
-	insn_init(insn, auprobe->insn, sizeof(auprobe->insn), x86_64);
-	/* has the side-effect of processing the entire instruction */
-	insn_get_length(insn);
-	if (!insn_complete(insn))
+	ret = insn_decode(insn, auprobe->insn, sizeof(auprobe->insn), m);
+	if (ret < 0)
 		return -ENOEXEC;
 
 	if (is_prefix_bad(insn))
-- 
2.21.0

