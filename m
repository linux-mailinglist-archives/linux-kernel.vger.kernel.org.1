Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF54273F47
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgIVKMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:12:38 -0400
Received: from foss.arm.com ([217.140.110.172]:32930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgIVKMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:12:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2168512FC;
        Tue, 22 Sep 2020 03:12:34 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 242653F718;
        Tue, 22 Sep 2020 03:12:32 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] arm64: spe: Allow new bits in SPE filter register
Date:   Tue, 22 Sep 2020 11:12:21 +0100
Message-Id: <20200922101225.183554-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922101225.183554-1-andre.przywara@arm.com>
References: <20200922101225.183554-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARMv8.3-SPE extension adds some new bits for the event filter.

Remove bits 11, 17 and 18 from the RES0 mask, so they can be used
correctly.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 554a7e8ecb07..efca4ee28671 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -281,7 +281,7 @@
 #define SYS_PMSFCR_EL1_ST_SHIFT		18
 
 #define SYS_PMSEVFR_EL1			sys_reg(3, 0, 9, 9, 5)
-#define SYS_PMSEVFR_EL1_RES0		0x0000ffff00ff0f55UL
+#define SYS_PMSEVFR_EL1_RES0		0x0000ffff00f90755UL
 
 #define SYS_PMSLATFR_EL1		sys_reg(3, 0, 9, 9, 6)
 #define SYS_PMSLATFR_EL1_MINLAT_SHIFT	0
-- 
2.17.1

