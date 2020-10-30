Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687C72A07AC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgJ3OSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:18:22 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:60303 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgJ3OSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:18:22 -0400
X-Originating-IP: 93.29.109.196
Received: from localhost.localdomain (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 81C884000D;
        Fri, 30 Oct 2020 14:18:20 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH] mfd: core: Restore error-free return for dt-disabled devices
Date:   Fri, 30 Oct 2020 15:18:06 +0100
Message-Id: <20201030141806.1272650-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding devices via mfd (mfd_add_device), a check on the device-tree
status of the device was performed to gracefully handle disabled devices
without errors.

This was done with a check using of_device_is_available, that was recently
moved to the mfd_match_of_node_to_dev function (by returning -ENODEV).
However, no specific case was added to handle -ENODEV, so it was handled
like any error.

At the end of the day, this causes the mfd_add_devices process to fail as
soon as one device is marked disabled. This is quite problematic and
definitely not what we want.

Introduce a special case to handle -ENODEV gracefully and restore original
behavior.

Fixes: 466a62d7642f ("mfd: core: Make a best effort attempt to match
devices with the correct of_nodes")

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/mfd/mfd-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index c3651f06684f..be9900866f2d 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -215,6 +215,13 @@ static int mfd_add_device(struct device *parent, int id,
 				ret = mfd_match_of_node_to_dev(pdev, np, cell);
 				if (ret == -EAGAIN)
 					continue;
+
+				/* Ignore 'disabled' devices error free */
+				if (ret == -ENODEV) {
+					ret = 0;
+					goto fail_alias;
+				}
+
 				if (ret)
 					goto fail_alias;
 
-- 
2.28.0

