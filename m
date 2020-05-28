Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93E41E6C26
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 22:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407034AbgE1UOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 16:14:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407003AbgE1UOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:14:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF9A0214D8;
        Thu, 28 May 2020 20:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590696857;
        bh=+eYS9oHOKcd0uUUZbrhUmgVDl9ydhKQO6aeYAXoVQa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2fokc3SqHVJKnZSQZakWKTq7Mi6E+maaDqDadOByPsBWo3pm40b70Y8C293DqO2fk
         iXCtuGDS74oC7yQ6CLJS1Oxbi6LzbP8d3nyL8+zy0kNkh/90P3DDvq22jPg6TOEYzl
         VcjqhwbDYqnqLLY+H6u++w+AaKGMH6R3xTnZnfb0=
From:   Sasha Levin <sashal@kernel.org>
To:     tglx@linutronix.de, luto@kernel.org, ak@linux.intel.com
Cc:     corbet@lwn.net, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        shuah@kernel.org, gregkh@linuxfoundation.org, tony.luck@intel.com,
        chang.seok.bae@intel.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v13 03/16] x86/fsgsbase/64: Add intrinsics for FSGSBASE instructions
Date:   Thu, 28 May 2020 16:13:49 -0400
Message-Id: <20200528201402.1708239-4-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528201402.1708239-1-sashal@kernel.org>
References: <20200528201402.1708239-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

[ luto: Rename the variables from FS and GS to FSBASE and GSBASE and
  make <asm/fsgsbase.h> safe to include on 32-bit kernels. ]

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1557309753-24073-6-git-send-email-chang.seok.bae@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/fsgsbase.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index bca4c743de77..fdd1177499b4 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -19,6 +19,36 @@ extern unsigned long x86_gsbase_read_task(struct task_struct *task);
 extern void x86_fsbase_write_task(struct task_struct *task, unsigned long fsbase);
 extern void x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase);
 
+/* Must be protected by X86_FEATURE_FSGSBASE check. */
+
+static __always_inline unsigned long rdfsbase(void)
+{
+	unsigned long fsbase;
+
+	asm volatile("rdfsbase %0" : "=r" (fsbase) :: "memory");
+
+	return fsbase;
+}
+
+static __always_inline unsigned long rdgsbase(void)
+{
+	unsigned long gsbase;
+
+	asm volatile("rdgsbase %0" : "=r" (gsbase) :: "memory");
+
+	return gsbase;
+}
+
+static __always_inline void wrfsbase(unsigned long fsbase)
+{
+	asm volatile("wrfsbase %0" :: "r" (fsbase) : "memory");
+}
+
+static __always_inline void wrgsbase(unsigned long gsbase)
+{
+	asm volatile("wrgsbase %0" :: "r" (gsbase) : "memory");
+}
+
 /* Helper functions for reading/writing FS/GS base */
 
 static inline unsigned long x86_fsbase_read_cpu(void)
-- 
2.25.1

