Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6AF2D34AA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 22:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgLHUyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:54:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:60730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729327AbgLHUyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:54:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1C5F8AD0E;
        Tue,  8 Dec 2020 19:03:33 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] driver: core: Fix list corruption after device_del()
Date:   Tue,  8 Dec 2020 20:03:26 +0100
Message-Id: <20201208190326.27531-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_links_purge() function (called from device_del()) tries to
remove the links.needs_suppliers list entry, but it's using
list_del(), hence it doesn't initialize after the removal.  This is OK
for normal cases where device_del() is called via device_destroy().
However, it's not guaranteed that the device object will be really
deleted soon after device_del().  In a minor case like HD-audio codec
reconfiguration that re-initializes the device after device_del(), it
may lead to a crash by the corrupted list entry.

As a simple fix, replace list_del() with list_del_init() in order to
make the list intact after the device_del() call.

Fixes: e2ae9bcc4aaa ("driver core: Add support for linking devices during device addition")
Cc: <stable@vger.kernel.org>
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=209207
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d661ada1518f..e8cb66093f21 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1386,7 +1386,7 @@ static void device_links_purge(struct device *dev)
 		return;
 
 	mutex_lock(&wfs_lock);
-	list_del(&dev->links.needs_suppliers);
+	list_del_init(&dev->links.needs_suppliers);
 	mutex_unlock(&wfs_lock);
 
 	/*
-- 
2.26.2

