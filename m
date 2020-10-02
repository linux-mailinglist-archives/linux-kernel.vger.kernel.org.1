Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07175281C06
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 21:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387602AbgJBT2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 15:28:09 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:36262 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388321AbgJBT2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 15:28:08 -0400
Received: from localhost.localdomain ([92.140.225.106])
        by mwinf5d73 with ME
        id b7U22300E2JMhn8037U3Ne; Fri, 02 Oct 2020 21:28:06 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 02 Oct 2020 21:28:06 +0200
X-ME-IP: 92.140.225.106
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, dmurphy@ti.com, robh@kernel.org,
        grandmaster@al2klimov.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ASoC: tlv320adcx140: Fix a typo in a comment
Date:   Fri,  2 Oct 2020 21:28:01 +0200
Message-Id: <20201002192801.639743-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is likely that this header file is about the TLV320ADCX140. (0 and 4
swapped)
While at it fix a missing "H" in a comment related to the include guard.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/codecs/tlv320adcx140.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320adcx140.h b/sound/soc/codecs/tlv320adcx140.h
index eedbc1d7221f..cafcbc0dd5fd 100644
--- a/sound/soc/codecs/tlv320adcx140.h
+++ b/sound/soc/codecs/tlv320adcx140.h
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-// TLV320ADCX104 Sound driver
+// TLV320ADCX140 Sound driver
 // Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
 
 #ifndef _TLV320ADCX140_H
@@ -145,4 +145,4 @@
 #define ADCX140_GPO_CFG_MAX		4
 #define ADCX140_GPO_DRV_MAX		5
 
-#endif /* _TLV320ADCX140_ */
+#endif /* _TLV320ADCX140_H */
-- 
2.25.1

