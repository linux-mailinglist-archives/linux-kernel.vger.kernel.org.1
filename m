Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E5826ADCA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgIOTlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:41:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36896 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgIOTkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:40:36 -0400
Received: from zn.tnic (p200300ec2f0e42009474dca2b756bdd4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4200:9474:dca2:b756:bdd4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 892F11EC01A8;
        Tue, 15 Sep 2020 21:40:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600198831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=65Fmx3+2+A5MgCyvYFK8ocEVfRnMH/n6i5Pxc2W9nec=;
        b=ogFTvH9uOhZIaeK6T7Iw2D7NjTIMr4bgoD0+nx3KsLzUE8SC1MRqcj2Wn8KD7HRfJxsbgj
        hpPpXqma8qJATsWNv8opgyTfsEVK+pXKr5YSylOHUSAnu5UdynZfQA0dr88MLQMiJ73PgI
        JgI7MApj05pQnnlvPj5ItQ6AL8iWc5I=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/mce: Annotate mce_rd/wrmsrl() with noinstr
Date:   Tue, 15 Sep 2020 21:40:20 +0200
Message-Id: <20200915194020.28807-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

They do get called from the #MC handler which is already marked
"noinstr".

Commit

  e2def7d49d08 ("x86/mce: Make mce_rdmsrl() panic on an inaccessible MSR")

already got rid of the instrumentation in the MSR accessors, fix the
annotation now too, in order to get rid of:

  vmlinux.o: warning: objtool: do_machine_check()+0x4a: call to mce_rdmsrl() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/core.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index a697baee9aa0..1ed14f67d13f 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -392,16 +392,25 @@ __visible bool ex_handler_rdmsr_fault(const struct exception_table_entry *fixup,
 }
 
 /* MSR access wrappers used for error injection */
-static u64 mce_rdmsrl(u32 msr)
+static noinstr u64 mce_rdmsrl(u32 msr)
 {
 	DECLARE_ARGS(val, low, high);
 
 	if (__this_cpu_read(injectm.finished)) {
-		int offset = msr_to_offset(msr);
+		int offset;
+		u64 ret;
 
+		instrumentation_begin();
+
+		offset = msr_to_offset(msr);
 		if (offset < 0)
-			return 0;
-		return *(u64 *)((char *)this_cpu_ptr(&injectm) + offset);
+			ret = 0;
+		else
+			ret = *(u64 *)((char *)this_cpu_ptr(&injectm) + offset);
+
+		instrumentation_end();
+
+		return ret;
 	}
 
 	/*
@@ -437,15 +446,21 @@ __visible bool ex_handler_wrmsr_fault(const struct exception_table_entry *fixup,
 	return true;
 }
 
-static void mce_wrmsrl(u32 msr, u64 v)
+static noinstr void mce_wrmsrl(u32 msr, u64 v)
 {
 	u32 low, high;
 
 	if (__this_cpu_read(injectm.finished)) {
-		int offset = msr_to_offset(msr);
+		int offset;
 
+		instrumentation_begin();
+
+		offset = msr_to_offset(msr);
 		if (offset >= 0)
 			*(u64 *)((char *)this_cpu_ptr(&injectm) + offset) = v;
+
+		instrumentation_end();
+
 		return;
 	}
 
-- 
2.21.0

