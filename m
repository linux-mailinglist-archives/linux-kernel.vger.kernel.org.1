Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9064B19F9FF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 18:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgDFQSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 12:18:46 -0400
Received: from serv1.kernkonzept.com ([159.69.200.6]:57691 "EHLO
        mx.kernkonzept.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgDFQSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:18:45 -0400
Received: from muedsl-82-207-238-172.citykom.de ([82.207.238.172] helo=x1c.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
        id 1jLUSN-0000KQ-Ou; Mon, 06 Apr 2020 18:18:39 +0200
From:   Benjamin Lamowski <benjamin.lamowski@kernkonzept.com>
To:     xiaoyao.li@intel.com
Cc:     bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        nivedita@alum.mit.edu, pbonzini@redhat.com, peterz@infradead.org,
        philipp.eppelt@kernkonzept.com, sean.j.christopherson@intel.com,
        tglx@linutronix.de, tony.luck@intel.com, x86@kernel.org,
        Benjamin Lamowski <benjamin.lamowski@kernkonzept.com>
Subject: [PATCH v3 1/1] x86/split_lock: check split lock support on initialization
Date:   Mon,  6 Apr 2020 18:17:37 +0200
Message-Id: <20200406161737.258840-1-benjamin.lamowski@kernkonzept.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406160247.208004-1-benjamin.lamowski@kernkonzept.com>
References: <20200406160247.208004-1-benjamin.lamowski@kernkonzept.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the sld setup code is run only if the TEST_CTRL MSR is available,
the current sld initialization code unconditionally resets it even on
systems where this architectural MSR is not available.

This commit introduces a new default sld state sld_unsupported, which is
changed in split_lock_setup() only if sld is available; and checks for
split lock detect support before initializing it.

Fixes: dbaba47085b0c ("x86/split_lock: Rework the initialization flow of split lock detection")
Signed-off-by: Benjamin Lamowski <benjamin.lamowski@kernkonzept.com>
Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 9a26e972cdea..de45ba1089c1 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -34,17 +34,18 @@
 #endif
 
 enum split_lock_detect_state {
-	sld_off = 0,
+	sld_unsupported = 0,
+	sld_off,
 	sld_warn,
 	sld_fatal,
 };
 
 /*
- * Default to sld_off because most systems do not support split lock detection
- * split_lock_setup() will switch this to sld_warn on systems that support
- * split lock detect, unless there is a command line override.
+ * Default to sld_unsupported because most systems do not support split lock
+ * detection. split_lock_setup() will switch this to sld_warn on systems that
+ * support split lock detect, unless there is a command line override.
  */
-static enum split_lock_detect_state sld_state __ro_after_init = sld_off;
+static enum split_lock_detect_state sld_state __ro_after_init = sld_unsupported;
 static u64 msr_test_ctrl_cache __ro_after_init;
 
 /*
@@ -1033,6 +1034,9 @@ static void __init split_lock_setup(void)
 	case sld_fatal:
 		pr_info("sending SIGBUS on user-space split_locks\n");
 		break;
+	case sld_unsupported:
+		/* Can't happen, just to keep the compiler happy */
+		break;
 	}
 
 	rdmsrl(MSR_TEST_CTRL, msr_test_ctrl_cache);
@@ -1063,7 +1067,8 @@ static void sld_update_msr(bool on)
 
 static void split_lock_init(void)
 {
-	split_lock_verify_msr(sld_state != sld_off);
+	if (sld_state != sld_unsupported)
+		split_lock_verify_msr(sld_state != sld_off);
 }
 
 bool handle_user_split_lock(struct pt_regs *regs, long error_code)
-- 
2.25.1

