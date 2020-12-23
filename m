Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86C12E2017
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 18:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgLWRoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 12:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbgLWRoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 12:44:05 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9D7C0611C5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 09:42:53 -0800 (PST)
Received: from zn.tnic (p200300ec2f0de600b74d534b1676c98b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:e600:b74d:534b:1676:c98b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 70BC91EC052A;
        Wed, 23 Dec 2020 18:42:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608745372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kf0H8mDQF+47NuL6tad9Wm/4WM+YXbO7iTXxnB2lviM=;
        b=sDUbDnVc3UJfMX0o8ddakd5iLrJIlUmeb9EC8D1b0rwBcAWPQQuZB7p5rIeMDD5Bbq+wO8
        QqF8Wn6Wjmge33upRlegnUfCVDcB566Pez7H+2FarqG3bKiucU8hNJZ0lCOY1rAygCd36b
        KrOzt3SNQo+lKZFvkGtnc+V1BtKGpd0=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 16/19] x86/tools/insn_sanity: Convert to insn_decode()
Date:   Wed, 23 Dec 2020 18:42:30 +0100
Message-Id: <20201223174233.28638-17-bp@alien8.de>
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
2.29.2

