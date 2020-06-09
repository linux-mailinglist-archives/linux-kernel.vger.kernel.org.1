Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BDA1F42A4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 19:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbgFIRng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 13:43:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56073 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbgFIRng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:43:36 -0400
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <cascardo@canonical.com>)
        id 1jiiHe-0004lb-1P; Tue, 09 Jun 2020 17:43:34 +0000
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        John Johansen <john.johansen@canonical.com>,
        Steve Beattie <sbeattie@ubuntu.com>
Subject: [PATCH] x86/speculation/srbds: do not try to turn mitigation off when not supported
Date:   Tue,  9 Jun 2020 14:43:13 -0300
Message-Id: <20200609174313.2600320-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SRBDS is mitigated by TSX OFF, update_srbds_msr will still read and
write to MSR_IA32_MCU_OPT_CTRL even when that is not supported by the
microcode.

Checking for X86_FEATURE_SRBDS_CTRL as a CPU feature available makes more
sense than checking for SRBDS_MITIGATION_UCODE_NEEDED as the found
"mitigation".

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Acked-by: John Johansen <john.johansen@canonical.com>
Acked-by: Steve Beattie <sbeattie@ubuntu.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b6f887be440c..ee5bdca7fd30 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -432,7 +432,7 @@ void update_srbds_msr(void)
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		return;
 
-	if (srbds_mitigation == SRBDS_MITIGATION_UCODE_NEEDED)
+	if (!boot_cpu_has(X86_FEATURE_SRBDS_CTRL))
 		return;
 
 	rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
-- 
2.25.1

