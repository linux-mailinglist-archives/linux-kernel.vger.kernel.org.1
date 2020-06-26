Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C20C20B6E1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 19:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgFZRYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 13:24:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgFZRYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:24:35 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 219F620836;
        Fri, 26 Jun 2020 17:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593192275;
        bh=F/VWExg6XQ5+v2BiFiVfoHATO51UpO4eHrdk+RYhIUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tFtDTtZ/LsvC48ct+GASS5dYzV+oh45HDZLwn8W3k1fWIUdg+T/tBuo9ctlvzon06
         Gah/UFGCtmQKCa6W/wCzF1ENDGCXIKWCG8g/1NtKm0BUJ/I2JBiOlahJe7oBNreGSc
         Xks4oexOZg3SXRO/rGaWduGPDomsDDOCo7x4YXBU=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: [PATCH fsgsbase v2 4/4] x86/fsgsbase: Fix Xen PV support
Date:   Fri, 26 Jun 2020 10:24:30 -0700
Message-Id: <f07c08f178fe9711915862b656722a207cd52c28.1593192140.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1593192140.git.luto@kernel.org>
References: <cover.1593192140.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Xen PV, SWAPGS doesn't work.  Teach __rdfsbase_inactive() and
__wrgsbase_inactive() to use rdmsrl()/wrmsrl() on Xen PV.  The Xen
pvop code will understand this and issue the correct hypercalls.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/process_64.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index cb8e37d3acaa..457d02aa10d8 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -163,9 +163,13 @@ static noinstr unsigned long __rdgsbase_inactive(void)
 
 	lockdep_assert_irqs_disabled();
 
-	native_swapgs();
-	gsbase = rdgsbase();
-	native_swapgs();
+	if (!static_cpu_has(X86_FEATURE_XENPV)) {
+		native_swapgs();
+		gsbase = rdgsbase();
+		native_swapgs();
+	} else {
+		rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	}
 
 	return gsbase;
 }
@@ -182,9 +186,13 @@ static noinstr void __wrgsbase_inactive(unsigned long gsbase)
 {
 	lockdep_assert_irqs_disabled();
 
-	native_swapgs();
-	wrgsbase(gsbase);
-	native_swapgs();
+	if (!static_cpu_has(X86_FEATURE_XENPV)) {
+		native_swapgs();
+		wrgsbase(gsbase);
+		native_swapgs();
+	} else {
+		wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	}
 }
 
 /*
-- 
2.25.4

