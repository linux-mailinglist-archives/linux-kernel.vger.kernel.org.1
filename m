Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A1F2DFC27
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 14:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgLUNDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 08:03:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9633 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgLUNDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 08:03:08 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D003S72SKz15h0q;
        Mon, 21 Dec 2020 21:01:40 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Mon, 21 Dec 2020 21:02:12 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <johan@kernel.org>, <elder@kernel.org>,
        <gregkh@linuxfoundation.org>, <greybus-dev@lists.linaro.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] greybus/audio_helper: Add missing unlock to avoid mismatched lock
Date:   Mon, 21 Dec 2020 21:02:46 +0800
Message-ID: <20201221130246.1807-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a missing unlock in the error branch.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
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
2.22.0

