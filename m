Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409D62FACD3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 22:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394805AbhARVin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 16:38:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389445AbhARKDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:03:19 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5551F229C7;
        Mon, 18 Jan 2021 10:00:24 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l1R6v-008RhD-Q2; Mon, 18 Jan 2021 09:46:09 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: [PATCH v4 14/21] arm64: Honor VHE being disabled from the command-line
Date:   Mon, 18 Jan 2021 09:45:26 +0000
Message-Id: <20210118094533.2874082-15-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118094533.2874082-1-maz@kernel.org>
References: <20210118094533.2874082-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, dbrazdil@google.com, alexandru.elisei@arm.com, ardb@kernel.org, jingzhangos@google.com, pajay@qti.qualcomm.com, psodagud@codeaurora.org, sramana@codeaurora.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finally we can check whether VHE is disabled on the command line,
and not enable it if that's the user's wish.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/hyp-stub.S | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 59820f9b8522..bbab2148a2a2 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -77,13 +77,24 @@ SYM_CODE_END(el1_sync)
 SYM_CODE_START_LOCAL(mutate_to_vhe)
 	// Sanity check: MMU *must* be off
 	mrs	x0, sctlr_el2
-	tbnz	x0, #0, 1f
+	tbnz	x0, #0, 2f
 
 	// Needs to be VHE capable, obviously
 	mrs	x0, id_aa64mmfr1_el1
 	ubfx	x0, x0, #ID_AA64MMFR1_VHE_SHIFT, #4
-	cbz	x0, 1f
+	cbz	x0, 2f
 
+	// Check whether VHE is disabled from the command line
+	adr_l	x1, id_aa64mmfr1_val
+	ldr	x0, [x1]
+	adr_l	x1, id_aa64mmfr1_mask
+	ldr	x1, [x1]
+	ubfx	x0, x0, #ID_AA64MMFR1_VHE_SHIFT, #4
+	ubfx	x1, x1, #ID_AA64MMFR1_VHE_SHIFT, #4
+	cbz	x1, 1f
+	and	x0, x0, x1
+	cbz	x0, 2f
+1:
 	// Engage the VHE magic!
 	mov_q	x0, HCR_HOST_VHE_FLAGS
 	msr	hcr_el2, x0
@@ -152,7 +163,7 @@ skip_spe:
 	orr	x0, x0, x1
 	msr	spsr_el1, x0
 
-1:	eret
+2:	eret
 SYM_CODE_END(mutate_to_vhe)
 
 .macro invalid_vector	label
-- 
2.29.2

