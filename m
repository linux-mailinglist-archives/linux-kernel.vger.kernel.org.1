Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C4D27692B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 08:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgIXGob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 02:44:31 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:61254 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIXGob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:44:31 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 9E06D4E17A5;
        Thu, 24 Sep 2020 14:44:28 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Wang Qing <wangqing@vivo.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound/soc/codecs: fix spelling typo in comments
Date:   Thu, 24 Sep 2020 14:43:59 +0800
Message-Id: <1600929860-28862-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUhOTxpJT0lNTUMeVkpNS0tCSUJDTUNCQ0xVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MxA6Vio5ND8oEgMSKhMQLk9C
        CDNPFDBVSlVKTUtLQklCQ01CSEJMVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKT0JINwY+
X-HM-Tid: 0a74bedb2c4b9376kuws9e06d4e17a5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the comment typo: "compliment" -> "complement".

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 sound/soc/codecs/ak4458.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4458.h b/sound/soc/codecs/ak4458.h
index f906215..e43144c
--- a/sound/soc/codecs/ak4458.h
+++ b/sound/soc/codecs/ak4458.h
@@ -49,7 +49,7 @@
 
 /* DIF2	1 0
  *  x	1 0 MSB justified  Figure 3 (default)
- *  x	1 1 I2S Compliment  Figure 4
+ *  x	1 1 I2S Complement  Figure 4
  */
 #define AK4458_DIF_SHIFT	1
 #define AK4458_DIF_MASK		GENMASK(3, 1)
-- 
2.7.4

