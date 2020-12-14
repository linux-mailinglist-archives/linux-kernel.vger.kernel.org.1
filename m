Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5932D9E1F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408663AbgLNRng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:43:36 -0500
Received: from foss.arm.com ([217.140.110.172]:50518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408639AbgLNRjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:39:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19A6F147A;
        Mon, 14 Dec 2020 09:38:09 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D55BF3F66E;
        Mon, 14 Dec 2020 09:38:07 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, jonathan.zhouwen@huawei.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 18/25] coresight: etm4x: Expose trcdevarch via trcidr
Date:   Mon, 14 Dec 2020 17:37:24 +0000
Message-Id: <20201214173731.302520-19-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201214173731.302520-1-suzuki.poulose@arm.com>
References: <20201214173731.302520-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the TRCDEVARCH register via the sysfs for component
detection. Given that the TRCIDR1 may not completely identify
the ETM component and instead need to use TRCDEVARCH, expose
this via sysfs for tools to use it for identification.

Cc: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 009818675928..277fd5bff811 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2395,6 +2395,7 @@ coresight_etm4x_cross_read(trcidr10, TRCIDR10);
 coresight_etm4x_cross_read(trcidr11, TRCIDR11);
 coresight_etm4x_cross_read(trcidr12, TRCIDR12);
 coresight_etm4x_cross_read(trcidr13, TRCIDR13);
+coresight_etm4x_cross_read(trcdevarch, TRCDEVARCH);
 
 static struct attribute *coresight_etmv4_trcidr_attrs[] = {
 	&dev_attr_trcidr0.attr,
@@ -2410,6 +2411,7 @@ static struct attribute *coresight_etmv4_trcidr_attrs[] = {
 	&dev_attr_trcidr11.attr,
 	&dev_attr_trcidr12.attr,
 	&dev_attr_trcidr13.attr,
+	&dev_attr_trcdevarch.attr,
 	NULL,
 };
 
-- 
2.24.1

