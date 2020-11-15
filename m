Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B6A2B34BC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 12:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgKOLvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 06:51:07 -0500
Received: from aposti.net ([89.234.176.197]:40412 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgKOLvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 06:51:07 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     od@zcrc.me, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] remoteproc: Add module parameter 'auto_boot'
Date:   Sun, 15 Nov 2020 11:50:56 +0000
Message-Id: <20201115115056.83225-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now the remoteproc core would always default to trying to boot the
remote processor at startup. The various remoteproc drivers could
however override that setting.

Whether or not we want the remote processor to boot, really depends on
the nature of the processor itself - a processor built into a WiFi chip
will need to be booted for the WiFi hardware to be usable, for instance,
but a general-purpose co-processor does not have any predeterminated
function, and as such we cannot assume that the OS will want the
processor to be booted - yet alone that we have a single do-it-all
firmware to load.

Add a 'auto_boot' module parameter that instructs the remoteproc whether
or not it should auto-boot the remote processor, which will default to
"true" to respect the previous behaviour.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/remoteproc/remoteproc_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index dab2c0f5caf0..687b1bfd49db 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -44,6 +44,11 @@
 
 #define HIGH_BITS_MASK 0xFFFFFFFF00000000ULL
 
+static bool auto_boot = true;
+module_param(auto_boot, bool, 0400);
+MODULE_PARM_DESC(auto_boot,
+		 "Auto-boot the remote processor [default=true]");
+
 static DEFINE_MUTEX(rproc_list_mutex);
 static LIST_HEAD(rproc_list);
 static struct notifier_block rproc_panic_nb;
@@ -2176,7 +2181,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 		return NULL;
 
 	rproc->priv = &rproc[1];
-	rproc->auto_boot = true;
+	rproc->auto_boot = auto_boot;
 	rproc->elf_class = ELFCLASSNONE;
 	rproc->elf_machine = EM_NONE;
 
-- 
2.29.2

