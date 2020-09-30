Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F88E27DE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 04:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgI3CN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 22:13:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:21945 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbgI3CNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 22:13:25 -0400
IronPort-SDR: 2WEv/sCmOI1qsrTJIG9Z7GaRyZl6HoY27nXvQ1FSONilzfQnFzw00oZHiLzPFUWf8eCHtCet2V
 /VnS+hNrbnLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="149992005"
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="149992005"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 19:13:21 -0700
IronPort-SDR: FJyrZEh6ZOMuNPm60Wg/zUHGX/lDG+r8ko7tfeHGWasqKzo0338pD0NjMhdPz6R3FaJy2bG72E
 D2E6sNIAe9eA==
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="457486650"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 19:13:21 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Youquan Song <youquan.song@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86/mce: Drop AMD specific "DEFERRED" case from Intel severity rule list
Date:   Tue, 29 Sep 2020 19:13:13 -0700
Message-Id: <20200930021313.31810-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200930021313.31810-1-tony.luck@intel.com>
References: <20200927221917.GB4746@zn.tnic>
 <20200930021313.31810-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Way back in v3.19 Intel and AMD shared the same machine check severity
grading code. So it made sense to add a case for AMD DEFERRED errors in
commit e3480271f592 ("x86, mce, severity: Extend the the mce_severity mechanism to handle UCNA/DEFERRED error")

But later in v4.2 AMD switched to a separate grading function in
commit bf80bbd7dcf5 ("x86/mce: Add an AMD severities-grading function")

Belatedly drop the DEFERRED case from the Intel rule list.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/severity.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 567ce09a0286..e0722461bb57 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -96,10 +96,6 @@ static struct severity {
 		PANIC, "In kernel and no restart IP",
 		EXCP, KERNEL_RECOV, MCGMASK(MCG_STATUS_RIPV, 0)
 		),
-	MCESEV(
-		DEFERRED, "Deferred error",
-		NOSER, MASK(MCI_STATUS_UC|MCI_STATUS_DEFERRED|MCI_STATUS_POISON, MCI_STATUS_DEFERRED)
-		),
 	MCESEV(
 		KEEP, "Corrected error",
 		NOSER, BITCLR(MCI_STATUS_UC)
-- 
2.21.1

