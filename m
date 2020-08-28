Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60316255FB8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 19:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgH1R30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 13:29:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:15760 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgH1R3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 13:29:22 -0400
IronPort-SDR: ury83vbA2OJfevhVbytD8wNZpbidO5E0G4YVOutUkaBXj1m+jQ6TaVGyQ218TE0k103i1BU87P
 VAxJ+I2AGvrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="157730109"
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="157730109"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 10:29:21 -0700
IronPort-SDR: tEcH0QwSGjjrgA+NxuBtdSRIxGZh74g8MJc1DJR6NlQPm6i5CO5qPeqx/XhLMAW8aK2UhcLsds
 zfBj01pQBAug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="337561445"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Aug 2020 10:29:20 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/2] perf/x86/msr: Add Jasper Lake support
Date:   Fri, 28 Aug 2020 10:27:10 -0700
Message-Id: <1598635630-148489-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598635630-148489-1-git-send-email-kan.liang@linux.intel.com>
References: <1598635630-148489-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The Jasper Lake processor is also a Tremont microarchitecture. From the
perspective of perf MSR, there is nothing changed compared with
Elkhart Lake.
Share the code path with Elkhart Lake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index a949f6f..4be8f9c 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -78,6 +78,7 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 	case INTEL_FAM6_ATOM_TREMONT_D:
 	case INTEL_FAM6_ATOM_TREMONT:
+	case INTEL_FAM6_ATOM_TREMONT_L:
 
 	case INTEL_FAM6_XEON_PHI_KNL:
 	case INTEL_FAM6_XEON_PHI_KNM:
-- 
2.7.4

