Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847C0281871
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388068AbgJBQ7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:59:14 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:28558 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725995AbgJBQ7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:59:14 -0400
Received: from localhost.localdomain ([93.22.36.20])
        by mwinf5d76 with ME
        id b4z92300c0S4PiM034zA6k; Fri, 02 Oct 2020 18:59:12 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 02 Oct 2020 18:59:12 +0200
X-ME-IP: 93.22.36.20
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ASoC: wm8523: Fix a typo in a comment
Date:   Fri,  2 Oct 2020 18:59:08 +0200
Message-Id: <20201002165908.637809-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is likely that this header file is about the WM8523.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/codecs/wm8523.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8523.h b/sound/soc/codecs/wm8523.h
index 79afbf1e4f1a..5f9bb3df1866 100644
--- a/sound/soc/codecs/wm8523.h
+++ b/sound/soc/codecs/wm8523.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * wm8523.h  --  WM8423 ASoC driver
+ * wm8523.h  --  WM8523 ASoC driver
  *
  * Copyright 2009 Wolfson Microelectronics, plc
  *
-- 
2.25.1

