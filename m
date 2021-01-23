Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274B73011F1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 02:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbhAWBRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 20:17:22 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11574 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbhAWBQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 20:16:55 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DMypX03KwzMMkg;
        Sat, 23 Jan 2021 09:14:44 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Sat, 23 Jan 2021
 09:16:04 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <christian.brauner@ubuntu.com>, <sfr@canb.auug.org.au>,
        <masahiroy@kernel.org>, <keescook@chromium.org>,
        <ktkhai@virtuozzo.com>, <linux-kernel@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] init/version.c: remove unused including <linux/version.h>
Date:   Sat, 23 Jan 2021 09:22:19 +0800
Message-ID: <20210123012219.3791999-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix follow warning:
init/version.c:16:1: unused including <linux/version.h>

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 init/version.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/init/version.c b/init/version.c
index 92afc782b043..b1329f16c6b6 100644
--- a/init/version.c
+++ b/init/version.c
@@ -13,7 +13,6 @@
 #include <linux/uts.h>
 #include <linux/utsname.h>
 #include <generated/utsrelease.h>
-#include <linux/version.h>
 #include <linux/proc_ns.h>
 
 struct uts_namespace init_uts_ns = {
-- 
2.25.4

