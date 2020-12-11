Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BD92D7F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 20:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391943AbgLKTEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 14:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388371AbgLKTEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 14:04:25 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AA6C061793;
        Fri, 11 Dec 2020 11:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=S+jtij8QKdcMrVXPjy1P0lRBwGZKK+vNiu+x7dVZf5I=; b=Vgt1XqSgW2nruy+iDjzPSXHeh7
        Mijl75nBMZZXOaFiolCNDwOOz7rL+AuW1E6KYBkzUXrBL+zZ2Xne6MUXtqp6i4AVsKY0sSXB66+za
        8sUErxMwE4ha4FNO7azlR4CS7g5J5UJ4EgsFb8RhYxW05/NJ53Pu59xNZS4wta4Wm4hs2bS5+nyfF
        Et5L+Fre+WZ0tzZ426vB7kQgjyfBwEMb8evL8g8gicZBnSlyRNmjROyRNLuPQE3IyODYVofk2yrmS
        wvnnVXTuggmV4ogceYZF9Jb9aDq8nsiKO26dRYjHmHEXZfKM9QDb2PlK2mqQ18A+im7juE+Awp4W3
        a4+KW0wQ==;
Received: from [2601:1c0:6280:3f0::1494] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knnhe-0003qV-2f; Fri, 11 Dec 2020 19:03:43 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH -next] platform: surface: fix non-PM_SLEEP build warnings
Date:   Fri, 11 Dec 2020 11:03:35 -0800
Message-Id: <20201211190335.16501-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build warnings when CONFIG_PM_SLEEP is not enabled and these
functions are not used:

../drivers/platform/surface/surface_gpe.c:189:12: warning: ‘surface_gpe_resume’ defined but not used [-Wunused-function]
 static int surface_gpe_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~~~
../drivers/platform/surface/surface_gpe.c:184:12: warning: ‘surface_gpe_suspend’ defined but not used [-Wunused-function]
 static int surface_gpe_suspend(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~

Fixes: 274335f1c557 ("platform/surface: Add Driver to set up lid GPEs on MS Surface device")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: platform-driver-x86@vger.kernel.org
---
 drivers/platform/surface/surface_gpe.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20201210.orig/drivers/platform/surface/surface_gpe.c
+++ linux-next-20201210/drivers/platform/surface/surface_gpe.c
@@ -181,6 +181,7 @@ static int surface_lid_enable_wakeup(str
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int surface_gpe_suspend(struct device *dev)
 {
 	return surface_lid_enable_wakeup(dev, true);
@@ -190,6 +191,7 @@ static int surface_gpe_resume(struct dev
 {
 	return surface_lid_enable_wakeup(dev, false);
 }
+#endif
 
 static SIMPLE_DEV_PM_OPS(surface_gpe_pm, surface_gpe_suspend, surface_gpe_resume);
 
