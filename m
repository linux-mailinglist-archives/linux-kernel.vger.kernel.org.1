Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E3521871F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 14:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgGHMXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 08:23:16 -0400
Received: from foss.arm.com ([217.140.110.172]:36678 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbgGHMXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:23:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA5E11063;
        Wed,  8 Jul 2020 05:23:06 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 114E53F68F;
        Wed,  8 Jul 2020 05:23:05 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com
Subject: [PATCH 3/4] firmware: arm_scmi: Fix scmi_event_header fields typing
Date:   Wed,  8 Jul 2020 13:22:47 +0100
Message-Id: <20200708122248.52771-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708122248.52771-1-cristian.marussi@arm.com>
References: <20200708122248.52771-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop size_t in favour of fixed size u32 for consistency and shuffle
around fields definitions to minimize implicit padding.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/notify.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 752415367305..f441da28d91f 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -254,10 +254,10 @@ struct events_queue {
  * queueing it on the related &struct events_queue.
  */
 struct scmi_event_header {
-	u64	timestamp;
-	u8	evt_id;
-	size_t	payld_sz;
-	u8	payld[];
+	u64 timestamp;
+	u32 payld_sz;
+	u8 evt_id;
+	u8 payld[];
 };
 
 struct scmi_registered_event;
-- 
2.17.1

