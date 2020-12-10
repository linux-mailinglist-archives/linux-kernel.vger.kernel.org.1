Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1C72D50EA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 03:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgLJCew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 21:34:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgLJCeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 21:34:25 -0500
From:   Stephen Boyd <sboyd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] spmi: Add driver shutdown support
Date:   Wed,  9 Dec 2020 18:33:43 -0800
Message-Id: <20201210023344.2838141-4-sboyd@kernel.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210023344.2838141-1-sboyd@kernel.org>
References: <20201210023344.2838141-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>

Add new shutdown() method.  Use it in the standard driver model style.

Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Link: https://lore.kernel.org/r/1603187810-30481-2-git-send-email-hsin-hsiung.wang@mediatek.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/spmi/spmi.c  | 9 +++++++++
 include/linux/spmi.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index 253340e10dab..51f5aeb65b3b 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -359,6 +359,14 @@ static int spmi_drv_remove(struct device *dev)
 	return 0;
 }
 
+static void spmi_drv_shutdown(struct device *dev)
+{
+	const struct spmi_driver *sdrv = to_spmi_driver(dev->driver);
+
+	if (sdrv && sdrv->shutdown)
+		sdrv->shutdown(to_spmi_device(dev));
+}
+
 static int spmi_drv_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	int ret;
@@ -375,6 +383,7 @@ static struct bus_type spmi_bus_type = {
 	.match		= spmi_device_match,
 	.probe		= spmi_drv_probe,
 	.remove		= spmi_drv_remove,
+	.shutdown	= spmi_drv_shutdown,
 	.uevent		= spmi_drv_uevent,
 };
 
diff --git a/include/linux/spmi.h b/include/linux/spmi.h
index 394a3f68bad5..729bcbf9f5ad 100644
--- a/include/linux/spmi.h
+++ b/include/linux/spmi.h
@@ -138,6 +138,7 @@ struct spmi_driver {
 	struct device_driver driver;
 	int	(*probe)(struct spmi_device *sdev);
 	void	(*remove)(struct spmi_device *sdev);
+	void	(*shutdown)(struct spmi_device *sdev);
 };
 
 static inline struct spmi_driver *to_spmi_driver(struct device_driver *d)
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

