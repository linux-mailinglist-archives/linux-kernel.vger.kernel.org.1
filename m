Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7140C1B0FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 17:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgDTPXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 11:23:39 -0400
Received: from foss.arm.com ([217.140.110.172]:50902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgDTPXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:23:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACA8B11B3;
        Mon, 20 Apr 2020 08:23:31 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D21493F73D;
        Mon, 20 Apr 2020 08:23:30 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com
Subject: [PATCH 3/4] firmware: arm_scmi: Clear channel for delayed responses
Date:   Mon, 20 Apr 2020 16:23:14 +0100
Message-Id: <20200420152315.21008-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420152315.21008-1-cristian.marussi@arm.com>
References: <20200420152315.21008-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear channel properly when done processing a delayed response.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 31c6a89a6edd..07de196f15aa 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -256,10 +256,12 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 			   xfer->hdr.protocol_id, xfer->hdr.seq,
 			   msg_type);
 
-	if (msg_type == MSG_TYPE_DELAYED_RESP)
+	if (msg_type == MSG_TYPE_DELAYED_RESP) {
+		info->desc->ops->clear_channel(cinfo);
 		complete(xfer->async_done);
-	else
+	} else {
 		complete(&xfer->done);
+	}
 }
 
 /**
-- 
2.17.1

