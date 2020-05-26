Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F4C1A6785
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 16:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbgDMOGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 10:06:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39446 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730285AbgDMOG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:06:29 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DAA1B5009B9C567DB427;
        Mon, 13 Apr 2020 22:06:25 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 13 Apr 2020
 22:06:17 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] drm/radeon: remove defined but not used 'dte_data_tahiti_le'
Date:   Mon, 13 Apr 2020 22:32:45 +0800
Message-ID: <20200413143245.23107-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/gpu/drm/radeon/si_dpm.c:255:33: warning: ‘dte_data_tahiti_le’
defined but not used [-Wunused-const-variable=]
 static const struct si_dte_data dte_data_tahiti_le =

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/gpu/drm/radeon/si_dpm.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index 2cb85dbe728f..a167e1c36d24 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -252,24 +252,6 @@ static const struct si_dte_data dte_data_tahiti =
 	false
 };
 
-static const struct si_dte_data dte_data_tahiti_le =
-{
-	{ 0x1E8480, 0x7A1200, 0x2160EC0, 0x3938700, 0 },
-	{ 0x7D, 0x7D, 0x4E4, 0xB00, 0 },
-	0x5,
-	0xAFC8,
-	0x64,
-	0x32,
-	1,
-	0,
-	0x10,
-	{ 0x78, 0x7C, 0x82, 0x88, 0x8E, 0x94, 0x9A, 0xA0, 0xA6, 0xAC, 0xB0, 0xB4, 0xB8, 0xBC, 0xC0, 0xC4 },
-	{ 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700 },
-	{ 0x2AF8, 0x2AF8, 0x29BB, 0x27F9, 0x2637, 0x2475, 0x22B3, 0x20F1, 0x1F2F, 0x1D6D, 0x1734, 0x1414, 0x10F4, 0xDD4, 0xAB4, 0x794 },
-	85,
-	true
-};
-
 static const struct si_dte_data dte_data_tahiti_pro =
 {
 	{ 0x1E8480, 0x3D0900, 0x989680, 0x2625A00, 0x0 },
-- 
2.21.1

