Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438732D59FD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 13:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbgLJMGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 07:06:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9490 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgLJMGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:06:35 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CsCKX3VtyzhplM;
        Thu, 10 Dec 2020 20:05:20 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Dec 2020 20:05:47 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <keescook@chromium.org>, <akpm@linux-foundation.org>,
        <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] lib/ubsan.c: Mark type_check_kinds with static keyword
Date:   Thu, 10 Dec 2020 20:17:18 +0800
Message-ID: <1607602638-79584-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

lib/ubsan.c:20:12: warning: symbol 'type_check_kinds' was not declared. Should it be static?

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 lib/ubsan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index cb9af3f6..3cfe902 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -17,7 +17,7 @@
 
 #include "ubsan.h"
 
-const char *type_check_kinds[] = {
+static const char *type_check_kinds[] = {
 	"load of",
 	"store to",
 	"reference binding to",
-- 
2.6.2

