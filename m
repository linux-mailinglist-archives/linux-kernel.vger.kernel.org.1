Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AB12C8964
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgK3QZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:25:56 -0500
Received: from foss.arm.com ([217.140.110.172]:57494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgK3QZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:25:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E02C1042;
        Mon, 30 Nov 2020 08:25:10 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.27.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 01FC33F718;
        Mon, 30 Nov 2020 08:25:08 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Grant <al.grant@arm.com>, Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH] drivers/perf: Enable PID_IN_CONTEXTIDR with SPE
Date:   Mon, 30 Nov 2020 18:24:54 +0200
Message-Id: <20201130162454.28255-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PID_IN_CONTEXTIDR by default when Arm SPE is enabled.
This flag is required to get PID data in the SPE trace. Without
it the perf tool will report 0 for PID which isn't very useful,
especially when doing system wide profiling or profiling
applications that fork.

There is a small performance overhead when enabling
PID_IN_CONTEXTIDR, but SPE itself is optional and not enabled by
default so the impact is minimised.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Al Grant <al.grant@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: John Garry <john.garry@huawei.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/perf/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 130327ff0b0e..47ede46c3d57 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -125,6 +125,7 @@ config XGENE_PMU
 config ARM_SPE_PMU
 	tristate "Enable support for the ARMv8.2 Statistical Profiling Extension"
 	depends on ARM64
+	select PID_IN_CONTEXTIDR
 	help
 	  Enable perf support for the ARMv8.2 Statistical Profiling
 	  Extension, which provides periodic sampling of operations in
-- 
2.28.0

