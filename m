Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFB62AD029
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 08:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbgKJHAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 02:00:15 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:54920 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731423AbgKJHAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 02:00:15 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.5359312|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_social|0.0174216-0.0114112-0.971167;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.IupJS0N_1604991604;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IupJS0N_1604991604)
          by smtp.aliyun-inc.com(10.147.41.137);
          Tue, 10 Nov 2020 15:00:10 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     tiny.windzz@gmail.com, linux-kernel@vger.kernel.org,
        Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH] MAINTAINERS: Add myself as arm sunxi soc maintainer
Date:   Tue, 10 Nov 2020 15:00:02 +0800
Message-Id: <20201110070002.14546-1-frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

Add myself to sunxi maintainer so the mail can cc me.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 94ac10a153c7..0ddaf9641546 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1545,6 +1545,7 @@ F:	drivers/clk/sunxi/
 
 ARM/Allwinner sunXi SoC support
 M:	Maxime Ripard <mripard@kernel.org>
+M:      Yangtao Li <tiny.windzz@gmail.com>
 M:	Chen-Yu Tsai <wens@csie.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.28.0

