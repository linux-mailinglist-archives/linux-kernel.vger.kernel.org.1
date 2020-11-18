Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D842B81EC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgKRQ32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:29:28 -0500
Received: from foss.arm.com ([217.140.110.172]:58876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgKRQ31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:29:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FAF41534;
        Wed, 18 Nov 2020 08:29:27 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 932D63F719;
        Wed, 18 Nov 2020 08:29:25 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        Jonathan.Cameron@Huawei.com, egranata@google.com,
        jbhayana@google.com, peter.hilber@opensynergy.com,
        mikhail.golubev@opensynergy.com, Igor.Skalkin@opensynergy.com,
        cristian.marussi@arm.com
Subject: [PATCH v3 3/6] hwmon: scmi: update hwmon internal scale data type
Date:   Wed, 18 Nov 2020 16:29:02 +0000
Message-Id: <20201118162905.10439-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201118162905.10439-1-cristian.marussi@arm.com>
References: <20201118162905.10439-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use an int to calculate scale values inside scmi_hwmon_scale() to match
the updated scale data type in struct scmi_sensor_info.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/hwmon/scmi-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index 09ce30cba54b..17d064e58938 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -30,7 +30,7 @@ static inline u64 __pow10(u8 x)
 
 static int scmi_hwmon_scale(const struct scmi_sensor_info *sensor, u64 *value)
 {
-	s8 scale = sensor->scale;
+	int scale = sensor->scale;
 	u64 f;
 
 	switch (sensor->type) {
-- 
2.17.1

