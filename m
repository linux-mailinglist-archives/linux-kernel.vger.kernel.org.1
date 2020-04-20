Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8DF1B0CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 15:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgDTNit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 09:38:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55452 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbgDTNit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:38:49 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D9D35C83490D24E12002;
        Mon, 20 Apr 2020 21:34:56 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Apr 2020
 21:34:49 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <gregkh@linuxfoundation.org>, <matthias.bgg@gmail.com>,
        <nishkadg.linux@gmail.com>, <devel@driverdev.osuosl.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v3] staging: mt7621-pinctrl: Use correct pointer type argument for sizeof
Date:   Mon, 20 Apr 2020 21:34:16 +0800
Message-ID: <20200420133416.3087-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c:223:14-36: WARNING: Use
correct pointer type argument for sizeof

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 v2->v3: Add this description of v1->v2.
 v1->v2: Use sizeof(*p->func) instead of sizeof(struct rt2880_pmx_func *) suggested by Dan Carpenter.

 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
index d0f06790d38f..caaf9e34f1ee 100644
--- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
+++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
@@ -220,7 +220,7 @@ static int rt2880_pinmux_index(struct rt2880_priv *p)
 	/* allocate our function and group mapping index buffers */
 	f = p->func = devm_kcalloc(p->dev,
 				   p->func_count,
-				   sizeof(struct rt2880_pmx_func),
+				   sizeof(*p->func),
 				   GFP_KERNEL);
 	gpio_func.groups = devm_kcalloc(p->dev, p->group_count, sizeof(int),
 					GFP_KERNEL);
-- 
2.21.1

