Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086A52E7FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 13:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgLaMEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 07:04:48 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10100 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgLaMEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 07:04:47 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D66H91P6LzMChy;
        Thu, 31 Dec 2020 20:03:01 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Thu, 31 Dec 2020 20:04:01 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] vt: use flexible-array member instead of zero-length array
Date:   Thu, 31 Dec 2020 20:04:00 +0800
Message-ID: <1609416240-35298-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use flexible-array member introduced in C99 instead of zero-length
array. Most of zero-length array was already taken care in previous
patch [1]. Now modified few more cases which were not handled earlier.

[1]. https://patchwork.kernel.org/patch/11394197/

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/tty/vt/vt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index d04a162..86b4c5f 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -332,7 +332,7 @@ typedef uint32_t char32_t;
  * scrolling only implies some pointer shuffling.
  */
 struct uni_screen {
-	char32_t *lines[0];
+	char32_t *lines[];
 };
 
 static struct uni_screen *vc_uniscr_alloc(unsigned int cols, unsigned int rows)
-- 
2.7.4

