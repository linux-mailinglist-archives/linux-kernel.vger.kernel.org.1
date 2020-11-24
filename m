Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A832C22BC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbgKXKUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:20:33 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50462 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731894AbgKXKUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:20:11 -0500
Received: from zn.tnic (p200300ec2f0e360052021be21853ebf1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3600:5202:1be2:1853:ebf1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 244431EC0537;
        Tue, 24 Nov 2020 11:20:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606213211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tNubvoHkuGyr1aDlAWLeVt/MEJM9R53/4lTaxWezvhA=;
        b=b9MI79V6bTWq8/TKTojZAChUJM9trRPGuIPZQGfg9mTWNRFmGbDD62bv6GbaTlM/5tTGZL
        ve3cNXaljltp+WQVuO4JHEuJXlqfyyqeUlgbvDBq4ofj/i7uNjRbafe5PI4tMP2EHT4SA6
        W/3UIUpjpawHpr+fWatAogKgQbzGEOQ=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v0 15/19] tools/objtool: Convert to insn_decode()
Date:   Tue, 24 Nov 2020 11:19:48 +0100
Message-Id: <20201124101952.7909-16-bp@alien8.de>
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
 tools/objtool/arch/x86/decode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index cde9c36e40ae..67ee8d2a9e5c 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -90,7 +90,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			    struct list_head *ops_list)
 {
 	struct insn insn;
-	int x86_64, sign;
+	int x86_64, sign, ret;
 	unsigned char op1, op2, rex = 0, rex_b = 0, rex_r = 0, rex_w = 0,
 		      rex_x = 0, modrm = 0, modrm_mod = 0, modrm_rm = 0,
 		      modrm_reg = 0, sib = 0;
@@ -101,10 +101,9 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 	if (x86_64 == -1)
 		return -1;
 
-	insn_init(&insn, sec->data->d_buf + offset, maxlen, x86_64);
-	insn_get_length(&insn);
-
-	if (!insn_complete(&insn)) {
+	ret = insn_decode(&insn, sec->data->d_buf + offset, maxlen,
+			  x86_64 ? INSN_MODE_64 : INSN_MODE_32);
+	if (ret < 0) {
 		WARN("can't decode instruction at %s:0x%lx", sec->name, offset);
 		return -1;
 	}
-- 
2.21.0

