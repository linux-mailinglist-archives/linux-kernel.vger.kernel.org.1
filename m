Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C0E2C22B9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731939AbgKXKU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731897AbgKXKUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:20:13 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A72FC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:20:13 -0800 (PST)
Received: from zn.tnic (p200300ec2f0e360052021be21853ebf1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3600:5202:1be2:1853:ebf1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CD5A61EC0531;
        Tue, 24 Nov 2020 11:20:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606213211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wo4FjvW11Hc6jRo2dt78TwfxgWMKML5VZdnYfgtsWMQ=;
        b=ByP2+PGDp3C53hyO66N4yj/vLbhtsK4w8W3uflpIXKkdSiyBeZK3ZlZEdO3O3kJi4b9uyH
        XJiwvD0wDYmQisuEnExET4zkQArg4Px6+6+Wcas7rrOlGd1OmSLlksEKgCIhJqlSfdo8eQ
        i1nuQtAao+N39a2VtmULPDSunJERkEs=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v0 16/19] x86/tools/insn_sanity: Convert to insn_decode()
Date:   Tue, 24 Nov 2020 11:19:49 +0100
Message-Id: <20201124101952.7909-17-bp@alien8.de>
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
 arch/x86/tools/insn_sanity.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/tools/insn_sanity.c b/arch/x86/tools/insn_sanity.c
index 185ceba9d289..51309df285b4 100644
--- a/arch/x86/tools/insn_sanity.c
+++ b/arch/x86/tools/insn_sanity.c
@@ -222,8 +222,8 @@ static void parse_args(int argc, char **argv)
 
 int main(int argc, char **argv)
 {
+	int insns = 0, ret;
 	struct insn insn;
-	int insns = 0;
 	int errors = 0;
 	unsigned long i;
 	unsigned char insn_buff[MAX_INSN_SIZE * 2];
@@ -241,15 +241,15 @@ int main(int argc, char **argv)
 			continue;
 
 		/* Decode an instruction */
-		insn_init(&insn, insn_buff, sizeof(insn_buff), x86_64);
-		insn_get_length(&insn);
+		ret = insn_decode(&insn, insn_buff, sizeof(insn_buff),
+				  x86_64 ? INSN_MODE_64 : INSN_MODE_32);
 
 		if (insn.next_byte <= insn.kaddr ||
 		    insn.kaddr + MAX_INSN_SIZE < insn.next_byte) {
 			/* Access out-of-range memory */
 			dump_stream(stderr, "Error: Found an access violation", i, insn_buff, &insn);
 			errors++;
-		} else if (verbose && !insn_complete(&insn))
+		} else if (verbose && ret < 0)
 			dump_stream(stdout, "Info: Found an undecodable input", i, insn_buff, &insn);
 		else if (verbose >= 2)
 			dump_insn(stdout, &insn);
-- 
2.21.0

