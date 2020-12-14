Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146A42DA432
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 00:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgLNXep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 18:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgLNXeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 18:34:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C92AC06179C;
        Mon, 14 Dec 2020 15:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=hraofpOuWzIXGImiJHJWbG5Ve52fCHjUfq7BbL2K84A=; b=LiXN/KRHRkOI7SzNbP3wduhPQw
        Uaj9lqGBsBcsDR7w+QfElBwPCfJf1kxm2++xxmo74SKUCLzuzQnUDBDbRS183SYN9M7yrzvDb4cm0
        iwS6QCy35K+Dt+KEw8Ar8ZzaLowMFtyFNY2d0drCYeFyKZ4ovchmZahLDmQsV76iGJIAuaeHtnNo3
        msSe/ubhKpymqo6dY3LmOEY5EuKoMvm/G6gxQC3jH8nOLe3NHE0tXOg8SpsJoFqXAU4Fnnv0XCA6n
        vf4srEwsTtOxQoR7uZ9Fktsm8KzAYwM9RDjUfJe6aMRe5HC/5NIxBbcvEPAyxFudZflUXe9vm9Fnc
        dNMd5NDA==;
Received: from [2601:1c0:6280:3f0::1494] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1koxLY-0007db-At; Mon, 14 Dec 2020 23:33:40 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 -next] platform: surface: fix non-PM_SLEEP build warnings
Date:   Mon, 14 Dec 2020 15:33:36 -0800
Message-Id: <20201214233336.19782-1-rdunlap@infradead.org>
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
v2: dropped Maximilian's RVB tag since the patch changed
    use preferred __maybe_unused instead of ifdeffery:
      https://lore.kernel.org/patchwork/patch/732981/

 drivers/platform/surface/surface_gpe.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20201214.orig/drivers/platform/surface/surface_gpe.c
+++ linux-next-20201214/drivers/platform/surface/surface_gpe.c
@@ -181,12 +181,12 @@ static int surface_lid_enable_wakeup(str
 	return 0;
 }
 
-static int surface_gpe_suspend(struct device *dev)
+static int __maybe_unused surface_gpe_suspend(struct device *dev)
 {
 	return surface_lid_enable_wakeup(dev, true);
 }
 
-static int surface_gpe_resume(struct device *dev)
+static int __maybe_unused surface_gpe_resume(struct device *dev)
 {
 	return surface_lid_enable_wakeup(dev, false);
 }
