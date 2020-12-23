Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691672E2012
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 18:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgLWRoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 12:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgLWRoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 12:44:04 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60089C061257
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 09:42:52 -0800 (PST)
Received: from zn.tnic (p200300ec2f0de600b74d534b1676c98b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:e600:b74d:534b:1676:c98b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E9A7B1EC054C;
        Wed, 23 Dec 2020 18:42:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608745371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GHls/O/EJX+cwlbUJjFb5UNshOjm1y3XildNZ9dteow=;
        b=esOufsf3lZentSvCe1sVYgDQmWoSFIZeAERVoWvFECDnLVhMefMKP9KjLL12+NT+/HCvLG
        ruxii0w9CGqQoRBSmsfjO4sMUsSbWFJc+r5bqS/SyAYspqhJc+lHxwQfAjfdOID76Z7ZS8
        NSmWUwawuYZ/vzwapa3x0MathHid87E=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 14/19] x86/tools/insn_decoder_test: Convert to insn_decode()
Date:   Wed, 23 Dec 2020 18:42:28 +0100
Message-Id: <20201223174233.28638-15-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201223174233.28638-1-bp@alien8.de>
References: <20201223174233.28638-1-bp@alien8.de>
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
2.29.2

