Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A179224995E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 11:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgHSJcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 05:32:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55016 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726634AbgHSJcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 05:32:01 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 63D26D47EC33B1E43250;
        Wed, 19 Aug 2020 17:31:58 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 17:31:49 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <rmk+kernel@armlinux.org.uk>
CC:     <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] fs/adfs: Convert to use the preferred fallthrough macro
Date:   Wed, 19 Aug 2020 05:30:44 -0400
Message-ID: <20200819093044.38639-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the uses of fallthrough comments to fallthrough macro.

Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/adfs/dir_f.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/adfs/dir_f.c b/fs/adfs/dir_f.c
index 30d526fecc3f..b9e271595d32 100644
--- a/fs/adfs/dir_f.c
+++ b/fs/adfs/dir_f.c
@@ -18,11 +18,11 @@ static inline unsigned int adfs_readval(unsigned char *p, int len)
 
 	switch (len) {
 	case 4:		val |= p[3] << 24;
-			/* fall through */
+			fallthrough;
 	case 3:		val |= p[2] << 16;
-			/* fall through */
+			fallthrough;
 	case 2:		val |= p[1] << 8;
-			/* fall through */
+			fallthrough;
 	default:	val |= p[0];
 	}
 	return val;
@@ -32,11 +32,11 @@ static inline void adfs_writeval(unsigned char *p, int len, unsigned int val)
 {
 	switch (len) {
 	case 4:		p[3] = val >> 24;
-			/* fall through */
+			fallthrough;
 	case 3:		p[2] = val >> 16;
-			/* fall through */
+			fallthrough;
 	case 2:		p[1] = val >> 8;
-			/* fall through */
+			fallthrough;
 	default:	p[0] = val;
 	}
 }
-- 
2.19.1

