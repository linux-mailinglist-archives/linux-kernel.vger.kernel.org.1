Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E060B26EA3C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 03:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIRBFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 21:05:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13276 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbgIRBFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 21:05:02 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C2AF9CA8AC8CBD995789;
        Fri, 18 Sep 2020 09:05:00 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 09:04:52 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <b.zolnierkie@samsung.com>, <gregkh@linuxfoundation.org>,
        <daniel.vetter@ffwll.ch>, <ndesaulniers@google.com>,
        <gustavoars@kernel.org>, <jirislaby@kernel.org>,
        <george.kennedy@oracle.com>, <natechancellor@gmail.com>,
        <peda@axentia.se>, <krzysztof.h1@wp.pl>,
        <akpm@linux-foundation.org>, <adaplas@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jingxiangfeng@huawei.com>
Subject: [PATCH v2] fbcon: Remove the superfluous break
Date:   Fri, 18 Sep 2020 09:05:21 +0800
Message-ID: <20200918010521.69950-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the superfluous break, as there is a 'return' before it.

Fixes: bad07ff74c32 ("fbcon: smart blitter usage for scrolling")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
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

