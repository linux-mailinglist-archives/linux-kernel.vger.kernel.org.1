Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6012CFB03
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 11:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgLEKhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 05:37:01 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8945 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729186AbgLEKdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 05:33:52 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cp5Vj3PsRzhmyr;
        Sat,  5 Dec 2020 18:32:29 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Sat, 5 Dec 2020
 18:32:49 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <johan@kernel.org>, <vaibhav.sr@gmail.com>
CC:     <elder@kernel.org>, <gregkh@linuxfoundation.org>,
        <dan.carpenter@oracle.com>, <aibhav.sr@gmail.com>,
        <greybus-dev@lists.linaro.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: greybus: audio: Fix possible leak free widgets in gbaudio_dapm_free_controls
Date:   Sat, 5 Dec 2020 18:38:27 +0800
Message-ID: <20201205103827.31244-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gbaudio_dapm_free_controls(), if one of the widgets is not found, an error
will be returned directly, which will cause the rest to be unable to be freed,
resulting in leak.

This patch fixes the bug. If if one of them is not found, just skip and free the others.

Fixes: 510e340efe0c ("staging: greybus: audio: Add helper APIs for dynamic audio module")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/staging/greybus/audio_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
index 237531ba60f3..3011b8abce38 100644
--- a/drivers/staging/greybus/audio_helper.c
+++ b/drivers/staging/greybus/audio_helper.c
@@ -135,7 +135,8 @@ int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
 		if (!w) {
 			dev_err(dapm->dev, "%s: widget not found\n",
 				widget->name);
-			return -EINVAL;
+			widget++;
+			continue;
 		}
 		widget++;
 #ifdef CONFIG_DEBUG_FS
-- 
2.17.1

