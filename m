Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 229E81A1C71
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 09:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgDHHSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 03:18:14 -0400
Received: from vkten.in ([104.244.73.96]:45190 "EHLO vkten.in"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgDHHSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:18:14 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Apr 2020 03:18:13 EDT
Received: (qmail 4649 invoked from network); 8 Apr 2020 07:11:31 -0000
Received: from unknown (HELO localhost) (vkor@vkten.in@117.219.207.72)
  de/crypted with TLSv1.3: TLS_AES_256_GCM_SHA384 [256/256] DN=none
  by vkten with ESMTPSA; 8 Apr 2020 07:11:31 -0000
From:   R Veera Kumar <vkor@vkten.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     R Veera Kumar <vkor@vkten.in>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-pinctrl: Use correct pointer type argument for sizeof
Date:   Wed,  8 Apr 2020 12:41:12 +0530
Message-Id: <20200408071112.11578-1-vkor@vkten.in>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use correct pointer type argument for sizeof.
Found using coccinelle.

Signed-off-by: R Veera Kumar <vkor@vkten.in>
---
 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
index d0f06790d38f..62babad5ee0b 100644
--- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
+++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
@@ -220,7 +220,7 @@ static int rt2880_pinmux_index(struct rt2880_priv *p)
 	/* allocate our function and group mapping index buffers */
 	f = p->func = devm_kcalloc(p->dev,
 				   p->func_count,
-				   sizeof(struct rt2880_pmx_func),
+				   sizeof(rt2880_pmx_func),
 				   GFP_KERNEL);
 	gpio_func.groups = devm_kcalloc(p->dev, p->group_count, sizeof(int),
 					GFP_KERNEL);
-- 
2.20.1

