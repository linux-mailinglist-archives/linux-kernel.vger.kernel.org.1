Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156BC29CB73
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 22:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505464AbgJ0Vpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 17:45:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:64054 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442558AbgJ0Vpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 17:45:36 -0400
IronPort-SDR: G3l3hjlDKDCO5D0js167JyXc/jUfVNS1BmMmYByH4OfO1T5AGGDb+i8rySqZMbAfNNtjqJfphG
 cYNh4TgEgxKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="232351165"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="232351165"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 14:45:35 -0700
IronPort-SDR: RkGFTuST7nnifjeRYaoyh9qYMXMI337t5xZ2s1iFzCtu1Hp4R+Xl8tTlElpp2VdqtR3fvL3zDa
 nK4INudzzjcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="303897794"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.160])
  by fmsmga008.fm.intel.com with ESMTP; 27 Oct 2020 14:45:35 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH] x86: Drop RDPID macro to discourage use of RDPID in the kernel
Date:   Tue, 27 Oct 2020 14:45:32 -0700
Message-Id: <20201027214532.1792-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the GAS-compatible RDPID macro as RDPID shouldn't be used in the
kernel, excepting the vDSO, which handcodes RDPID in inline asm.  RDPID
is unsafe in the kernel because KVM loads guest's TSC_AUX on VM-entry
and may not restore the host's value until the CPU returns to userspace.

See commit 6a3ea3e68b8a ("x86/entry/64: Do not use RDPID in paranoid
entry to accomodate KVM") for details.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/include/asm/inst.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/x86/include/asm/inst.h b/arch/x86/include/asm/inst.h
index bd7f02480ca1..438ccd4f3cc4 100644
--- a/arch/x86/include/asm/inst.h
+++ b/arch/x86/include/asm/inst.h
@@ -143,21 +143,6 @@
 	.macro MODRM mod opd1 opd2
 	.byte \mod | (\opd1 & 7) | ((\opd2 & 7) << 3)
 	.endm
-
-.macro RDPID opd
-	REG_TYPE rdpid_opd_type \opd
-	.if rdpid_opd_type == REG_TYPE_R64
-	R64_NUM rdpid_opd \opd
-	.else
-	R32_NUM rdpid_opd \opd
-	.endif
-	.byte 0xf3
-	.if rdpid_opd > 7
-	PFX_REX rdpid_opd 0
-	.endif
-	.byte 0x0f, 0xc7
-	MODRM 0xc0 rdpid_opd 0x7
-.endm
 #endif
 
 #endif
-- 
2.28.0

