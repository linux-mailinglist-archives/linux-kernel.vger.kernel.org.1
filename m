Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD8C2EAB9C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbhAENLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:11:09 -0500
Received: from foss.arm.com ([217.140.110.172]:54290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729920AbhAENLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:11:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59ADB101E;
        Tue,  5 Jan 2021 05:10:20 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEE623F719;
        Tue,  5 Jan 2021 05:10:18 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        Jonathan.Cameron@Huawei.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, robh@kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v4 1/2] firmware: arm_scmi: Add System Power utility macro
Date:   Tue,  5 Jan 2021 13:09:44 +0000
Message-Id: <20210105130945.8192-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a trivial macro to check the kind of SCMI SystemPower request.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 include/linux/scmi_protocol.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index ecb3aad1a964..a666a152d1eb 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -738,6 +738,7 @@ struct scmi_power_state_changed_report {
 struct scmi_system_power_state_notifier_report {
 	ktime_t		timestamp;
 	unsigned int	agent_id;
+#define SCMI_SYSPOWER_IS_REQUEST_GRACEFUL(flags)	((flags) & BIT(0))
 	unsigned int	flags;
 	unsigned int	system_state;
 };
-- 
2.17.1

