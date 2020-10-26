Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BBA29938D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787487AbgJZRSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:18:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:43738 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1787481AbgJZRSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:18:37 -0400
IronPort-SDR: rMqG7d5Bu/jz2pEUFotv9e2OeEg6NfPSG7umQ2qxjBcLxGcGslMTOw4WPQXcNlRpAblUUsFmGL
 vJ115AtARb8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="252657765"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="252657765"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 10:18:36 -0700
IronPort-SDR: gYQg2NAKdYHHndReoDa8mM85MmxbIKmsUYjUTOTJAD77LsXERk3OGz3f07weRr8qVPuwY4bjbv
 tGm0uq1L5LBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="303612081"
Received: from tjmaciei-desk.jf.intel.com (HELO tjmaciei-ctnr.jf.intel.com) ([10.54.75.9])
  by fmsmga007.fm.intel.com with ESMTP; 26 Oct 2020 10:18:35 -0700
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        tglx@linutronix.de, luto@kernel.org,
        Andi Kleen <ak@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, corbet@lwn.net,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, shuah@kernel.org,
        gregkh@linuxfoundation.org, tony.luck@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH] x86/elf: Fix use of internal macro BIT in uapi header
Date:   Mon, 26 Oct 2020 10:18:35 -0700
Message-Id: <20201026171835.7412-1-thiago.macieira@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20200528201402.1708239-14-sashal@kernel.org>
References: <20200528201402.1708239-14-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This breaks the build in userspace since this macro is not available.

<stdin>:1:18: error: ‘BIT’ was not declared in this scope

Fixes: 742c45c3ecc9255e1 ("x86/elf: Enumerate kernel FSGSBASE capability in AT_HWCAP2")
Cc: Andi Kleen <ak@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thiago Macieira <thiago.macieira@intel.com>
---
 arch/x86/include/uapi/asm/hwcap2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/hwcap2.h b/arch/x86/include/uapi/asm/hwcap2.h
index 5fdfcb47000f..6d2175b43710 100644
--- a/arch/x86/include/uapi/asm/hwcap2.h
+++ b/arch/x86/include/uapi/asm/hwcap2.h
@@ -6,6 +6,6 @@
 #define HWCAP2_RING3MWAIT		(1 << 0)
 
 /* Kernel allows FSGSBASE instructions available in Ring 3 */
-#define HWCAP2_FSGSBASE			BIT(1)
+#define HWCAP2_FSGSBASE			(1 << 1)
 
 #endif
-- 
2.29.0

