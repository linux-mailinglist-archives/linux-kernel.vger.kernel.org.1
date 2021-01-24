Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD21301A36
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 07:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbhAXGeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 01:34:44 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:41365 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbhAXGej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 01:34:39 -0500
Received: from localhost.localdomain ([92.131.99.25])
        by mwinf5d58 with ME
        id LWYv240050Ys01Y03WYvDf; Sun, 24 Jan 2021 07:32:56 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 24 Jan 2021 07:32:56 +0100
X-ME-IP: 92.131.99.25
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, saravanak@google.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] driver core: Fix a reource leak in 'fw_devlink_create_devlink()'
Date:   Sun, 24 Jan 2021 07:32:53 +0100
Message-Id: <20210124063253.720637-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 'fw_devlink_create_devlink()', all exit paths, successful or not,
release the reference taken on 'sup_dev'.
All but this one.

Use the existing error handling case to call the missing 'put_device()'.

Fixes: f9aa460672c9c ("driver core: Refactor fw_devlink feature")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Speculative and compile tested only
---
 drivers/base/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index e08d376631cc..8775717a6bf7 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1623,8 +1623,10 @@ static int fw_devlink_create_devlink(struct device *con,
 	 * cycles. So cycle detection isn't necessary and shouldn't be
 	 * done.
 	 */
-	if (flags & DL_FLAG_SYNC_STATE_ONLY)
-		return -EAGAIN;
+	if (flags & DL_FLAG_SYNC_STATE_ONLY) {
+		ret = -EAGAIN;
+		goto out;
+	}
 
 	/*
 	 * If we can't find the supplier device from its fwnode, it might be
-- 
2.27.0

