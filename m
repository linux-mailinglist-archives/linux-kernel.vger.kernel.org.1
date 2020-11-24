Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D342C22BD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbgKXKUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:20:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50314 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731891AbgKXKUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:20:11 -0500
Received: from zn.tnic (p200300ec2f0e360052021be21853ebf1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3600:5202:1be2:1853:ebf1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 28E461EC0535;
        Tue, 24 Nov 2020 11:20:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606213210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TE43OBjRFKRV/fdNUgMMdLKwnxouvBpc+mpuZM8X2gA=;
        b=YDKQ8M0yIe5HzIyoyz5fyQSsDGpvxJqOvhyXRo32LyLj+r0wewcdsPm01t3qM317ov9byD
        QG+nrr/74r5cRtJYfCorWIXtK7WfcB3D/OvJXGyQVYA0+XqUu6+y4Vt3bur3vycAGaFJbt
        lzf2p2u7zzFxDNPGMoJkyMFWCmhroyw=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v0 14/19] x86/tools/insn_decoder_test: Convert to insn_decode()
Date:   Tue, 24 Nov 2020 11:19:47 +0100
Message-Id: <20201124101952.7909-15-bp@alien8.de>
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
 arch/x86/tools/insn_decoder_test.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
index 34eda63c124b..472540aeabc2 100644
--- a/arch/x86/tools/insn_decoder_test.c
+++ b/arch/x86/tools/insn_decoder_test.c
@@ -120,7 +120,7 @@ int main(int argc, char **argv)
 
 	while (fgets(line, BUFSIZE, stdin)) {
 		char copy[BUFSIZE], *s, *tab1, *tab2;
-		int nb = 0;
+		int nb = 0, ret;
 		unsigned int b;
 
 		if (line[0] == '<') {
@@ -148,10 +148,12 @@ int main(int argc, char **argv)
 			} else
 				break;
 		}
+
 		/* Decode an instruction */
-		insn_init(&insn, insn_buff, sizeof(insn_buff), x86_64);
-		insn_get_length(&insn);
-		if (insn.length != nb) {
+		ret = insn_decode(&insn, insn_buff, sizeof(insn_buff),
+				  x86_64 ? INSN_MODE_64 : INSN_MODE_32);
+
+		if (ret < 0 || insn.length != nb) {
 			warnings++;
 			pr_warn("Found an x86 instruction decoder bug, "
 				"please report this.\n", sym);
-- 
2.21.0

