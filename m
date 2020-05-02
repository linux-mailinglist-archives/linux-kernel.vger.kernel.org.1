Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976A71C25B8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 15:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgEBNfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 May 2020 09:35:05 -0400
Received: from foss.arm.com ([217.140.110.172]:52324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbgEBNfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 09:35:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7985E30E;
        Sat,  2 May 2020 06:35:04 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.71.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 410693F68F;
        Sat,  2 May 2020 06:35:01 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 03/16] arm64/cpufeature: Make doublelock a signed feature in ID_AA64DFR0
Date:   Sat,  2 May 2020 19:03:52 +0530
Message-Id: <1588426445-24344-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588426445-24344-1-git-send-email-anshuman.khandual@arm.com>
References: <1588426445-24344-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Double lock feature can have the following possible values.

0b0000 - Double lock implemented
0b1111 - Double lock not implemented

But in case of a conflict the safe value should be 0b1111. Hence this must
be a signed feature instead. Also change FTR_EXACT to FTR_LOWER_SAFE.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 51386dade423..cba43e4a5c79 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -338,7 +338,7 @@ static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, 36, 28, 0),
+	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 36, 28, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR0_PMSVER_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_CTX_CMPS_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_WRPS_SHIFT, 4, 0),
-- 
2.20.1

