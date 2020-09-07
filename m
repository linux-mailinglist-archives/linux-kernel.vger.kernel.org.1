Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B650260351
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 19:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbgIGRrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 13:47:47 -0400
Received: from foss.arm.com ([217.140.110.172]:42772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729418AbgIGRrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:47:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18855153B;
        Mon,  7 Sep 2020 10:47:35 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C21E3F66E;
        Mon,  7 Sep 2020 10:47:33 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com
Subject: [PATCH v6 2/3] firmware: arm_scmi: add SCMI System Power devname
Date:   Mon,  7 Sep 2020 18:46:56 +0100
Message-Id: <20200907174657.32466-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907174657.32466-1-cristian.marussi@arm.com>
References: <20200907174657.32466-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SCMI System Power device name to the core list of supported protocol
devices.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index f749af6e79fc..0a28d81927c8 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -732,6 +732,7 @@ struct scmi_prot_devnames {
 
 static struct scmi_prot_devnames devnames[] = {
 	{ SCMI_PROTOCOL_POWER,  { "genpd" },},
+	{ SCMI_PROTOCOL_SYSTEM,  { "syspower" },},
 	{ SCMI_PROTOCOL_PERF,   { "cpufreq" },},
 	{ SCMI_PROTOCOL_CLOCK,  { "clocks" },},
 	{ SCMI_PROTOCOL_SENSOR, { "hwmon" },},
-- 
2.17.1

