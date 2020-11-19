Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6682B9871
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgKSQqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:46:30 -0500
Received: from foss.arm.com ([217.140.110.172]:34610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729256AbgKSQq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:46:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92A8F15DB;
        Thu, 19 Nov 2020 08:46:26 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 217633F718;
        Thu, 19 Nov 2020 08:46:24 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        jonathan.zhouwen@huawei.com, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 18/25] coresight: etm4x: Expose trcdevarch via trcidr
Date:   Thu, 19 Nov 2020 16:45:40 +0000
Message-Id: <20201119164547.2982871-19-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201119164547.2982871-1-suzuki.poulose@arm.com>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
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
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
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

