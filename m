Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5AD2630D0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 17:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgIIPol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 11:44:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11757 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729990AbgIIPmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:42:15 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EE0738C8ED968C64CCB5;
        Wed,  9 Sep 2020 21:42:08 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 21:42:00 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <thierry.reding@gmail.com>, <sam@ravnborg.org>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <linus.walleij@linaro.org>,
        <paul@crapouillou.net>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/panel: s6e63m0: Add missing MODULE_LICENSE
Date:   Wed, 9 Sep 2020 21:41:37 +0800
Message-ID: <20200909134137.32284-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kbuild warns when this file is built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/gpu/drm/panel/panel-samsung-s6e63m0.o

Add the missing license/author/description tags.

Fixes: b7b23e447687 ("drm/panel: s6e63m0: Break out SPI transport")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
index 044294aafe27..3eee67e2d86a 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
@@ -534,3 +534,7 @@ int s6e63m0_remove(struct device *dev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(s6e63m0_remove);
+
+MODULE_AUTHOR("Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>");
+MODULE_DESCRIPTION("s6e63m0 LCD Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1


