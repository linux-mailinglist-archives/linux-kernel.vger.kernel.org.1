Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0602F39CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392745AbhALTO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:14:26 -0500
Received: from foss.arm.com ([217.140.110.172]:51642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbhALTOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:14:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3F681042;
        Tue, 12 Jan 2021 11:13:39 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 066C53F66E;
        Tue, 12 Jan 2021 11:13:38 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] firmware: arm_scmi: fix call site of notifications exit
Date:   Tue, 12 Jan 2021 19:13:26 +0000
Message-Id: <20210112191326.29091-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call scmi_notification_exit() only when SCMI platform driver instance has
been really successfully removed.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
A small fix spotted by code inspection, applies on for-next/scmi
n top of:

commit 6054d97ab512 ("MAINTAINERS: Update ARM SCMI entry")
---
 drivers/firmware/arm_scmi/driver.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 5392e1fc6b4e..dd65fb1c453c 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -848,13 +848,13 @@ static int scmi_remove(struct platform_device *pdev)
 	struct scmi_info *info = platform_get_drvdata(pdev);
 	struct idr *idr = &info->tx_idr;
 
-	scmi_notification_exit(&info->handle);
-
 	mutex_lock(&scmi_list_mutex);
-	if (info->users)
+	if (info->users) {
 		ret = -EBUSY;
-	else
+	} else {
+		scmi_notification_exit(&info->handle);
 		list_del(&info->node);
+	}
 	mutex_unlock(&scmi_list_mutex);
 
 	if (ret)
-- 
2.17.1

