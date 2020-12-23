Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFC52E200A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 18:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgLWRnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 12:43:31 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39558 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728295AbgLWRna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 12:43:30 -0500
Received: from zn.tnic (p200300ec2f0de600b74d534b1676c98b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:e600:b74d:534b:1676:c98b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 752DF1EC0537;
        Wed, 23 Dec 2020 18:42:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608745369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xl8xByQrWUMA3sL12737zQ6r+TW7/Wj4FbpXBYNjGDE=;
        b=BGC9321mTEoh3B4tl5iJ72h1eNruhmrHBqlmOUxrBDOdffqtWlJYQZ6Z+kY7hRwaTh+gSk
        h5Rkvbc4WZHTLwavJrwFWeb0WB8y2xWMkzmDovLjePcDGqXw7RCtPj479Qq9+sTO/5R83R
        8jZVVh5dunDY57ajog+UyJvpAPfGMDQ=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 12/19] x86/traps: Convert to insn_decode()
Date:   Wed, 23 Dec 2020 18:42:26 +0100
Message-Id: <20201223174233.28638-13-bp@alien8.de>
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
 arch/x86/kernel/traps.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index fb55981f2a0d..861962e1b6e8 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -497,14 +497,15 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 {
 	u8 insn_buf[MAX_INSN_SIZE];
 	struct insn insn;
+	int ret;
 
 	if (copy_from_kernel_nofault(insn_buf, (void *)regs->ip,
 			MAX_INSN_SIZE))
 		return GP_NO_HINT;
 
-	kernel_insn_init(&insn, insn_buf, MAX_INSN_SIZE);
-	insn_get_modrm(&insn);
-	insn_get_sib(&insn);
+	ret = insn_decode(&insn, insn_buf, MAX_INSN_SIZE, INSN_MODE_KERN);
+	if (ret < 0)
+		return GP_NO_HINT;
 
 	*addr = (unsigned long)insn_get_addr_ref(&insn, regs);
 	if (*addr == -1UL)
-- 
2.29.2

