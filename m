Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA94426DC9B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgIQNPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:15:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33708 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726478AbgIQNPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:15:02 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 948F8699CE1CC840A75F;
        Thu, 17 Sep 2020 21:15:00 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 21:14:52 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <b.zolnierkie@samsung.com>, <gregkh@linuxfoundation.org>,
        <daniel.vetter@ffwll.ch>, <jirislaby@kernel.org>,
        <ndesaulniers@google.com>, <natechancellor@gmail.com>,
        <george.kennedy@oracle.com>, <peda@axentia.se>
CC:     <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jingxiangfeng@huawei.com>
Subject: [PATCH] fbcon: Remove the superfluous break
Date:   Thu, 17 Sep 2020 21:15:15 +0800
Message-ID: <20200917131515.147029-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the superfuous break, as there is a 'return' before it.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/video/fbdev/core/fbcon.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 0b49b0f44edf..623359aadd1e 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1727,7 +1727,6 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 				    vc->vc_video_erase_char,
 				    vc->vc_size_row * count);
 			return true;
-			break;
 
 		case SCROLL_WRAP_MOVE:
 			if (b - t - count > 3 * vc->vc_rows >> 2) {
@@ -1818,7 +1817,6 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 				    vc->vc_video_erase_char,
 				    vc->vc_size_row * count);
 			return true;
-			break;
 
 		case SCROLL_WRAP_MOVE:
 			if (b - t - count > 3 * vc->vc_rows >> 2) {
-- 
2.17.1

