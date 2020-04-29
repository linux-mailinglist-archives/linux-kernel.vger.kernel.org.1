Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCBA1BD871
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 11:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgD2Ji1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 05:38:27 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:13556 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2Ji1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:38:27 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee45ea94af6929-add2e; Wed, 29 Apr 2020 17:37:58 +0800 (CST)
X-RM-TRANSID: 2ee45ea94af6929-add2e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.104.146.39])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65ea94af2f5a-e8bde;
        Wed, 29 Apr 2020 17:37:58 +0800 (CST)
X-RM-TRANSID: 2ee65ea94af2f5a-e8bde
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] ASoC: mxs-saif: Fix unused assignment
Date:   Wed, 29 Apr 2020 17:38:23 +0800
Message-Id: <20200429093823.1372-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete unused initialized value, because 'ret' will be assigined
by the function of_alias_get_id().

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/mxs/mxs-saif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 1e38ce858..dc197883e 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -733,7 +733,7 @@ static int mxs_saif_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct mxs_saif *saif;
-	int irq, ret = 0;
+	int irq, ret;
 	struct device_node *master;
 
 	if (!np)
-- 
2.20.1.windows.1



