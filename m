Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC1A2B5F35
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgKQMer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:34:47 -0500
Received: from foss.arm.com ([217.140.110.172]:55454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbgKQMep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:34:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C55411FB;
        Tue, 17 Nov 2020 04:34:45 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5ED403F719;
        Tue, 17 Nov 2020 04:34:43 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        Jonathan.Cameron@Huawei.com, broonie@kernel.org, robh@kernel.org,
        satyakim@qti.qualcomm.com, etienne.carriere@linaro.org,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v5 2/5] firmware: arm_scmi: add SCMI Voltage Domain devname
Date:   Tue, 17 Nov 2020 12:34:12 +0000
Message-Id: <20201117123415.55105-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117123415.55105-1-cristian.marussi@arm.com>
References: <20201117123415.55105-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SCMI Voltage Domain device name to the core list of supported protocol
devices.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index ada35e63feae..5392e1fc6b4e 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -743,6 +743,7 @@ static struct scmi_prot_devnames devnames[] = {
 	{ SCMI_PROTOCOL_CLOCK,  { "clocks" },},
 	{ SCMI_PROTOCOL_SENSOR, { "hwmon" },},
 	{ SCMI_PROTOCOL_RESET,  { "reset" },},
+	{ SCMI_PROTOCOL_VOLTAGE,  { "regulator" },},
 };
 
 static inline void
-- 
2.17.1

