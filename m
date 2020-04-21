Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D05B1B29A7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 16:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgDUO3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 10:29:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729159AbgDUO3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:29:48 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5080C20724;
        Tue, 21 Apr 2020 14:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587479387;
        bh=vq62htzQrEGkXQgbmBIdb3flO+yGFZQ1M31v4/nKJRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hu8zjX8bct2a6eO9hoEe3hbPq+qhKJA3kLRvPBvyROaRtSdHsc0csp7/E9Jx7ZGCG
         gdbzQa31ODGBaEHFBB36vsimK/YYtIJ4KspcGBQq0hDjrjdUA2efBGuHIjQtGW1zwh
         uRyDvXHtb5D44+ytNrHc8bdNyUXfK2g4OVH++ZP8=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>, kernel-team@android.com
Subject: [PATCH v2 8/8] arm64: cpufeature: Add an overview comment for the cpufeature framework
Date:   Tue, 21 Apr 2020 15:29:22 +0100
Message-Id: <20200421142922.18950-9-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421142922.18950-1-will@kernel.org>
References: <20200421142922.18950-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that Suzuki isn't within throwing distance, I thought I'd better add
a rough overview comment to cpufeature.c so that it doesn't take me days
to remember how it works next time.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 50 ++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d63653d7c5d0..c1d44d127baa 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3,6 +3,56 @@
  * Contains CPU feature definitions
  *
  * Copyright (C) 2015 ARM Ltd.
+ *
+ * A note for the weary kernel hacker: the code here is confusing and hard to
+ * follow! That's partly because it's solving a nasty problem, but also because
+ * there's a little bit of over-abstraction that tends to obscure what's going
+ * on behind a maze of helper functions and macros.
+ *
+ * The basic problem is that hardware folks have started gluing together CPUs
+ * with distinct architectural features; in some cases even creating SoCs where
+ * user-visible instructions are available only on a subset of the available
+ * cores. We try to address this by snapshotting the feature registers of the
+ * boot CPU and comparing these with the feature registers of each secondary
+ * CPU when bringing them up. If there is a mismatch, then we update the
+ * snapshot state to indicate the lowest-common denominator of the feature,
+ * known as the "safe" value. This snapshot state can be queried to view the
+ * "sanitised" value of a feature register.
+ *
+ * The sanitised register values are used to decide which capabilities we
+ * have in the system. These may be in the form of traditional "hwcaps"
+ * advertised to userspace or internal "cpucaps" which are used to configure
+ * things like alternative patching and static keys. While a feature mismatch
+ * may result in a TAINT_CPU_OUT_OF_SPEC kernel taint, a capability mismatch
+ * may prevent a CPU from being onlined at all.
+ *
+ * Some implementation details worth remembering:
+ *
+ * - Mismatched features are *always* sanitised to a "safe" value, which
+ *   usually indicates that the feature is not supported.
+ *
+ * - A mismatched feature marked with FTR_STRICT will cause a "SANITY CHECK"
+ *   warning when onlining an offending CPU and the kernel will be tainted
+ *   with TAINT_CPU_OUT_OF_SPEC.
+ *
+ * - Features marked as FTR_VISIBLE have their sanitised value visible to
+ *   userspace. FTR_VISIBLE features in registers that are only visible
+ *   to EL0 by trapping *must* have a corresponding HWCAP so that late
+ *   onlining of CPUs cannot lead to features disappearing at runtime.
+ *
+ * - A "feature" is typically a 4-bit register field. A "capability" is the
+ *   high-level description derived from the sanitised field value.
+ *
+ * - Read the Arm ARM (DDI 0487F.a) section D13.1.3 ("Principles of the ID
+ *   scheme for fields in ID registers") to understand when feature fields
+ *   may be signed or unsigned (FTR_SIGNED and FTR_UNSIGNED accordingly).
+ *
+ * - KVM exposes its own view of the feature registers to guest operating
+ *   systems regardless of FTR_VISIBLE. This is typically driven from the
+ *   sanitised register values to allow virtual CPUs to be migrated between
+ *   arbitrary physical CPUs, but some features not present on the host are
+ *   also advertised and emulated. Look at sys_reg_descs[] for the gory
+ *   details.
  */
 
 #define pr_fmt(fmt) "CPU features: " fmt
-- 
2.26.1.301.g55bc3eb7cb9-goog

