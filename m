Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB972CE58E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 03:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgLDCI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 21:08:58 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8940 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgLDCI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 21:08:58 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CnGLy0DCnzhlb8;
        Fri,  4 Dec 2020 10:07:54 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 4 Dec 2020
 10:08:10 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <johan@kernel.org>, <elder@kernel.org>,
        <gregkh@linuxfoundation.org>, <dan.carpenter@oracle.com>,
        <aibhav.sr@gmail.com>
CC:     <greybus-dev@lists.linaro.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: greybus: audio: Add missing unlock in gbaudio_dapm_free_controls()
Date:   Fri, 4 Dec 2020 10:13:50 +0800
Message-ID: <20201204021350.28182-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing unlock before return from function
gbaudio_dapm_free_controls() in the error handling case.

Fixes: 510e340efe0c ("staging: greybus: audio: Add helper APIs for dynamic audio module")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/staging/greybus/audio_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
index 237531ba60f3..293675dbea10 100644
--- a/drivers/staging/greybus/audio_helper.c
+++ b/drivers/staging/greybus/audio_helper.c
@@ -135,6 +135,7 @@ int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
 		if (!w) {
 			dev_err(dapm->dev, "%s: widget not found\n",
 				widget->name);
+			mutex_unlock(&dapm->card->dapm_mutex);
 			return -EINVAL;
 		}
 		widget++;
-- 
2.17.1

