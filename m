Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DFA2A4482
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 12:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgKCLri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 06:47:38 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7582 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgKCLrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 06:47:37 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CQSh40ZV9zLt6T;
        Tue,  3 Nov 2020 19:47:32 +0800 (CST)
Received: from DESKTOP-2DH7KI2.china.huawei.com (10.67.101.108) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 19:47:34 +0800
From:   Chengsong Ke <kechengsong@huawei.com>
To:     <richard@nod.at>, <s.hauer@pengutronix.de>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ubifs: Remove useless code in bytes_str_to_int
Date:   Tue, 3 Nov 2020 19:47:33 +0800
Message-ID: <20201103114733.16424-1-kechengsong@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.101.108]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: k00524021 <kechengsong@huawei.com>

As a local variable, "endp" is neither refered nor returned
after this line "endp += 2", it looks like a useless code,
suggest to remove it.

Signed-off-by: Chengsong Ke <kechengsong@huawei.com>
---
 drivers/mtd/ubi/build.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index e85b04e9716b..46a6dd75e533 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1351,8 +1351,6 @@ static int bytes_str_to_int(const char *str)
 		fallthrough;
 	case 'K':
 		result *= 1024;
-		if (endp[1] == 'i' && endp[2] == 'B')
-			endp += 2;
 	case '\0':
 		break;
 	default:
-- 
2.12.3

