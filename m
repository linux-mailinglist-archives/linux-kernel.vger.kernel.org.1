Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57892E2011
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 18:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgLWRoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 12:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgLWRoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 12:44:04 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AA3C061248
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 09:42:51 -0800 (PST)
Received: from zn.tnic (p200300ec2f0de600b74d534b1676c98b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:e600:b74d:534b:1676:c98b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 365BC1EC04B9;
        Wed, 23 Dec 2020 18:42:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608745370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fms/cSkyvq6e7l0EUpGKreWH3nSqsG+/t272Cvtx7BI=;
        b=ZZk88GagquEoIHETFI5cWxDeY/lar/MY2qIo2WwB0SE7fa5r/lrahbgOJzipOT9Q8I5mcf
        l/6mVTepSRWXsrJ4ete1ZXVAYSZ99VacdDLT16AuKh/l8ScARDROBjPGCzjwpUUKuE9Nuu
        2REgQeQpLV3kq2j3hDnfMD97xOCfEsM=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 13/19] x86/uprobes: Convert to insn_decode()
Date:   Wed, 23 Dec 2020 18:42:27 +0100
Message-Id: <20201223174233.28638-14-bp@alien8.de>
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
 arch/x86/kernel/uprobes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index a2b413394917..b63cf8f7745e 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -276,12 +276,12 @@ static bool is_prefix_bad(struct insn *insn)
 
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
2.29.2

