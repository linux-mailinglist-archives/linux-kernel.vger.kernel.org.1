Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9640428E2CE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388550AbgJNPHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:07:33 -0400
Received: from foss.arm.com ([217.140.110.172]:50968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731662AbgJNPHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:07:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 868BA1424;
        Wed, 14 Oct 2020 08:07:12 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEA493F71F;
        Wed, 14 Oct 2020 08:07:10 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 10/11] [DEBUG] firmware: arm_scmi: add custom_dummy SCMI devname
Date:   Wed, 14 Oct 2020 16:05:44 +0100
Message-Id: <20201014150545.44807-11-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014150545.44807-1-cristian.marussi@arm.com>
References: <20201014150545.44807-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add custom_dummy SCMI devname.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 55df134c2338..5c39a738866a 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -993,6 +993,7 @@ static struct scmi_prot_devnames devnames[] = {
 	{ SCMI_PROTOCOL_CLOCK,  { "clocks" },},
 	{ SCMI_PROTOCOL_SENSOR, { "hwmon" },},
 	{ SCMI_PROTOCOL_RESET,  { "reset" },},
+	{ SCMI_PROTOCOL_CUSTOM_DUMMY,  { "custom_dummy" },},
 };
 
 static inline void
-- 
2.17.1

