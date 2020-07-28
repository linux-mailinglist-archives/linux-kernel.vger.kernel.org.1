Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83928231091
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 19:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbgG1RKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 13:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731070AbgG1RKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:10:15 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7641E20786;
        Tue, 28 Jul 2020 17:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595956215;
        bh=eY0XVnJ0SYt647E7e9pMXrHHZG9Mewsy1Rzw02B4jxI=;
        h=From:To:Cc:Subject:Date:From;
        b=dzBj8bGlxmyoSOTIfJRUz/7UtEBmkY46Aqtj2FEV3PtdT1hszIlyqM+75uJI1mFK7
         knZU6Vjq1hBipMeVn2Ix0fzZEgwxXTKkf7P5uHu041G5r3RJEeR59Bpp2SVpMmgTpk
         PJENndOKwwGw4YklJzqf1qrVU0pmmtxwXSZo5In8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] reset: Fix and extend kerneldoc
Date:   Tue, 28 Jul 2020 19:10:11 +0200
Message-Id: <20200728171011.28412-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 compile warnings (invalid kerneldoc):

    drivers/reset/core.c:50: warning: Function parameter or member 'array' not described in 'reset_control'
    drivers/reset/core.c:50: warning: Function parameter or member 'deassert_count' not described in 'reset_control'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/reset/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 01c0c7aa835c..a2df88e90011 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -32,7 +32,8 @@ static LIST_HEAD(reset_lookup_list);
  * @refcnt: Number of gets of this reset_control
  * @acquired: Only one reset_control may be acquired for a given rcdev and id.
  * @shared: Is this a shared (1), or an exclusive (0) reset_control?
- * @deassert_cnt: Number of times this reset line has been deasserted
+ * @array: Is this an array of reset controls (1)?
+ * @deassert_count: Number of times this reset line has been deasserted
  * @triggered_count: Number of times this reset line has been reset. Currently
  *                   only used for shared resets, which means that the value
  *                   will be either 0 or 1.
-- 
2.17.1

