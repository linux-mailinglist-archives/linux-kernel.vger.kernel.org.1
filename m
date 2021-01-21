Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A6C2FF799
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbhAUVu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:50:58 -0500
Received: from mga03.intel.com ([134.134.136.65]:18550 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbhAUVuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:50:54 -0500
IronPort-SDR: jFVK7ZQCJ2IhNN2FNtjapuyAVl0WIZiv5xja/hiCEMVOrC9T0simR3Q6sZ47M/RfnjWGvB33tL
 9GRVDSt8am2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="179437017"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="179437017"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 13:50:12 -0800
IronPort-SDR: i/uIFBuFY59qjWbUbW8Bu9tf/bDBDTmNUxy7MrUvY54cI/YoHbcaNiPDCWG1xQomrPp2cN0dEv
 9266M6KfUgew==
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="356671916"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 13:50:12 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/cpu: Add another Alder Lake CPU to the Intel family
Date:   Thu, 21 Jan 2021 13:50:04 -0800
Message-Id: <20210121215004.11618-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

Add Alder Lake mobile CPU model number to Intel family.

Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---

Boris: As usual, getting the CPU model number in first makes
life simpler for the different teams adding model specific code
to perf, power, etc. subsystems. Please apply. Thanks.

 arch/x86/include/asm/intel-family.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 5e658ba2654a..9abe842dbd84 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -97,6 +97,7 @@
 
 #define	INTEL_FAM6_LAKEFIELD		0x8A
 #define INTEL_FAM6_ALDERLAKE		0x97
+#define INTEL_FAM6_ALDERLAKE_L		0x9A
 
 /* "Small Core" Processors (Atom) */
 
-- 
2.21.1

