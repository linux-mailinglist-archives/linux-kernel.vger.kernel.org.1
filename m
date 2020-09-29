Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7B827C815
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 13:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbgI2L6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 07:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730384AbgI2L6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:58:34 -0400
Received: from smtp2-2.goneo.de (smtp2.goneo.de [IPv6:2001:1640:5::8:33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6486C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 04:58:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id E9ECC23FE2D;
        Tue, 29 Sep 2020 13:58:29 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.999
X-Spam-Level: 
X-Spam-Status: No, score=-2.999 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.099, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SFliODkuL7_x; Tue, 29 Sep 2020 13:58:29 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp2.goneo.de (Postfix) with ESMTPA id D39A723EE9F;
        Tue, 29 Sep 2020 13:58:28 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH] driver core: Remove double assignment
Date:   Tue, 29 Sep 2020 13:58:08 +0200
Message-Id: <20200929115808.2815382-1-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

This removes an assignment in device_add. It assigned the parent
kobject to the kobject of the  new device. This is not necessary,
because the call to kobject_add a few lines later also does this same
assignment.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/base/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index bb5806a2bd4c..03b5396cd192 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2847,8 +2847,6 @@ int device_add(struct device *dev)
 		error = PTR_ERR(kobj);
 		goto parent_error;
 	}
-	if (kobj)
-		dev->kobj.parent = kobj;
 
 	/* use parent numa_node */
 	if (parent && (dev_to_node(dev) == NUMA_NO_NODE))
@@ -2856,7 +2854,7 @@ int device_add(struct device *dev)
 
 	/* first, register with generic layer. */
 	/* we require the name to be set before, and pass NULL */
-	error = kobject_add(&dev->kobj, dev->kobj.parent, NULL);
+	error = kobject_add(&dev->kobj, kobj, NULL);
 	if (error) {
 		glue_dir = get_glue_dir(dev);
 		goto Error;
-- 
2.28.0

