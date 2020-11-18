Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BD72B7DB4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 13:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgKRMiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 07:38:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46418 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgKRMiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 07:38:09 -0500
Received: from zn.tnic (p200300ec2f0caf0066ae0a9db02cf7f4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:af00:66ae:a9d:b02c:f7f4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 582021EC01A8;
        Wed, 18 Nov 2020 13:38:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605703088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=Lp/HVhwf+M2mga5RrTHsoMi/pE660ypJ9Gtt1WQeiAs=;
        b=PooAoSAe4FwG0KMLjGGYfhA5Foek7bo98dBqiCPrALl6EtiVvggfgNuXmXtBxCqg/6zL3a
        CoffaTXyvlNsN7KF+YPFfAmIKQSJRESkSAQA67W1o265dL6bsb3/vjxmWolWJ/DHVNrjdq
        HSFCHReD8ln6brFz1hZcKBTRThwTXkA=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/msr: Downgrade unrecognized MSR message
Date:   Wed, 18 Nov 2020 13:38:06 +0100
Message-Id: <20201118123806.19672-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

It is a warning and not an error so use pr_warn().

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/msr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index b1147862730c..95e6b97b7d8b 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -99,8 +99,8 @@ static int filter_write(u32 reg)
 	if (!__ratelimit(&fw_rs))
 		return 0;
 
-	pr_err("Write to unrecognized MSR 0x%x by %s (pid: %d). Please report to x86@kernel.org.\n",
-	       reg, current->comm, current->pid);
+	pr_warn("Write to unrecognized MSR 0x%x by %s (pid: %d). Please report to x86@kernel.org.\n",
+	        reg, current->comm, current->pid);
 
 	return 0;
 }
-- 
2.21.0

