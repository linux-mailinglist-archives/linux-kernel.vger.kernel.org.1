Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DF11E28D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 19:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgEZR2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 13:28:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:26901 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbgEZR2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:28:07 -0400
IronPort-SDR: etK1ewcjgIuCNPdb3foguoktaV/uxLdhqLmgzcPZUZ0jzOsyOs5WK//wkVdj/GXvJ7kLE3o4nv
 xDVBQr0qLLkg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 10:28:06 -0700
IronPort-SDR: qb9dzuLpKdVY1btB3YXpyKlC3hjxoqruoGUWD6uXa6iwm601KVXZIDqdUhskdl/I1cJpG3vnWe
 LAiUr20S8W2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; 
   d="scan'208";a="468384377"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga005.fm.intel.com with ESMTP; 26 May 2020 10:28:06 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] x86/split_lock: Add Tigerlake CPU models
Date:   Tue, 26 May 2020 10:26:07 -0700
Message-Id: <1590513967-46432-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tigerlake CPUs support split lock detection. Enumerate the feature by
the split lock support bit in the CORE_CAPABILITIES MSR.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index a19a680542ce..0717b12d7f05 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1138,6 +1138,8 @@ static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	1),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	1),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	1),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		1),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		1),
 	{}
 };
 
-- 
2.19.1

