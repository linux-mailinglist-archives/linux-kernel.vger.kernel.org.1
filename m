Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370291FCC26
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 13:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgFQLVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 07:21:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41322 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbgFQLVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:21:33 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 923AB7197DF9F5C1D05F;
        Wed, 17 Jun 2020 19:21:30 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 17 Jun 2020 19:21:22 +0800
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>
CC:     <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH] MAINTAINERS: Include drivers subdirs for ARM PMU PROFILING AND DEBUGGING entry
Date:   Wed, 17 Jun 2020 19:17:28 +0800
Message-ID: <1592392648-128331-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that the ARM PMU PROFILING AND DEBUGGING maintainers are included
for the HiSilicon PMU driver.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 68f21d46614c..24f377f1d76c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1425,7 +1425,7 @@ F:	arch/arm*/include/asm/perf_event.h
 F:	arch/arm*/kernel/hw_breakpoint.c
 F:	arch/arm*/kernel/perf_*
 F:	arch/arm/oprofile/common.c
-F:	drivers/perf/*
+F:	drivers/perf/
 F:	include/linux/perf/arm_pmu.h
 
 ARM PORT
-- 
2.26.2

