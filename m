Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A56F2DC0E6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgLPNPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:15:03 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9455 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgLPNPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:15:02 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CwwYq0nbkzhrJC;
        Wed, 16 Dec 2020 21:13:51 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 16 Dec 2020 21:14:12 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] soc: soc-dapm: convert comma to semicolon
Date:   Wed, 16 Dec 2020 21:14:43 +0800
Message-ID: <20201216131443.14607-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7f87b449f950..2cf4c9057b14 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4764,7 +4764,7 @@ void snd_soc_dapm_init(struct snd_soc_dapm_context *dapm,
 
 	if (component) {
 		dapm->dev		= component->dev;
-		dapm->idle_bias_off	= !component->driver->idle_bias_on,
+		dapm->idle_bias_off	= !component->driver->idle_bias_on;
 		dapm->suspend_bias_off	= component->driver->suspend_bias_off;
 	} else {
 		dapm->dev		= card->dev;
-- 
2.22.0

