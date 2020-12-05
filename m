Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF4E2CF7FF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 01:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbgLEA3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 19:29:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57664 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbgLEA3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 19:29:14 -0500
Received: from zn.tnic (p200300ec2f12b10072f1dc97378a5926.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:b100:72f1:dc97:378a:5926])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 501551EC03E3;
        Sat,  5 Dec 2020 01:28:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607128113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=xJP6JmlgBydA88wi424lhafFwoggVfh+3OdHkD+Ot7I=;
        b=QLRw1KXWbWGJmB16R7x3Y6YyDc9i67W+U5Ro6m85VfIZ3HOu/wbt+Kzcq1WtJ8uz0kSa17
        U+AJro8Yp+e1oq6wDQj3ZUEsQceo/KHdv8QD6f/vQQ+dlvtMPgmRwa5nf/ZHxKvsFcshgC
        wAON3a/+0YQTJsLbaJh6GkrSBA79mZU=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/msr: Add a pointer to an URL which contains further details
Date:   Sat,  5 Dec 2020 01:28:25 +0100
Message-Id: <20201205002825.19107-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

After having collected the majority of reports about MSRs being written
by userspace tools and what tools those are, and all newer reports
mostly repeating, add an URL where detailed information is gathered and
kept up-to-date.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/msr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 95e6b97b7d8b..8a67d1fa8dc5 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -99,8 +99,9 @@ static int filter_write(u32 reg)
 	if (!__ratelimit(&fw_rs))
 		return 0;
 
-	pr_warn("Write to unrecognized MSR 0x%x by %s (pid: %d). Please report to x86@kernel.org.\n",
+	pr_warn("Write to unrecognized MSR 0x%x by %s (pid: %d).\n",
 	        reg, current->comm, current->pid);
+	pr_warn("See https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/about for details.\n");
 
 	return 0;
 }
-- 
2.21.0

