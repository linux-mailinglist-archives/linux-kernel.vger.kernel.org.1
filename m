Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5B929DFA9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbgJ2BDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:03:35 -0400
Received: from foss.arm.com ([217.140.110.172]:39114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730470AbgJ1WKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:10:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E6E01764;
        Wed, 28 Oct 2020 15:10:13 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 69C6D3F73C;
        Wed, 28 Oct 2020 15:10:12 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 11/26] coresight: etm4x: Always read the registers on the host CPU
Date:   Wed, 28 Oct 2020 22:09:30 +0000
Message-Id: <20201028220945.3826358-13-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201028220945.3826358-1-suzuki.poulose@arm.com>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are about to add support for sysreg access to ETM4.4+ components,
make sure that we read the registers only on the host CPU.

Cc: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-etm4x-sysfs.c         | 23 ++++++++-----------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 989ce7b8ade7..c4781d4e5886 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2344,23 +2344,20 @@ static u32 etmv4_cross_read(const struct device *dev, u32 offset)
 	return reg.data;
 }
 
-#define coresight_etm4x_reg(name, offset)			\
-	coresight_simple_reg32(struct etmv4_drvdata, name, offset)
-
 #define coresight_etm4x_cross_read(name, offset)			\
 	coresight_simple_func(struct etmv4_drvdata, etmv4_cross_read,	\
 			      name, offset)
 
-coresight_etm4x_reg(trcpdcr, TRCPDCR);
-coresight_etm4x_reg(trcpdsr, TRCPDSR);
-coresight_etm4x_reg(trclsr, TRCLSR);
-coresight_etm4x_reg(trcauthstatus, TRCAUTHSTATUS);
-coresight_etm4x_reg(trcdevid, TRCDEVID);
-coresight_etm4x_reg(trcdevtype, TRCDEVTYPE);
-coresight_etm4x_reg(trcpidr0, TRCPIDR0);
-coresight_etm4x_reg(trcpidr1, TRCPIDR1);
-coresight_etm4x_reg(trcpidr2, TRCPIDR2);
-coresight_etm4x_reg(trcpidr3, TRCPIDR3);
+coresight_etm4x_cross_read(trcpdcr, TRCPDCR);
+coresight_etm4x_cross_read(trcpdsr, TRCPDSR);
+coresight_etm4x_cross_read(trclsr, TRCLSR);
+coresight_etm4x_cross_read(trcauthstatus, TRCAUTHSTATUS);
+coresight_etm4x_cross_read(trcdevid, TRCDEVID);
+coresight_etm4x_cross_read(trcdevtype, TRCDEVTYPE);
+coresight_etm4x_cross_read(trcpidr0, TRCPIDR0);
+coresight_etm4x_cross_read(trcpidr1, TRCPIDR1);
+coresight_etm4x_cross_read(trcpidr2, TRCPIDR2);
+coresight_etm4x_cross_read(trcpidr3, TRCPIDR3);
 coresight_etm4x_cross_read(trcoslsr, TRCOSLSR);
 coresight_etm4x_cross_read(trcconfig, TRCCONFIGR);
 coresight_etm4x_cross_read(trctraceid, TRCTRACEIDR);
-- 
2.24.1

