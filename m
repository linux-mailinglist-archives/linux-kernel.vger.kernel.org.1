Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBB41A759B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 10:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407071AbgDNINq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 04:13:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2369 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407062AbgDNINd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:13:33 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 28AE9C18D5CA8D2CD2A6;
        Tue, 14 Apr 2020 16:13:31 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 14 Apr 2020 16:13:24 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <takedakn@nttdata.co.jp>, <penguin-kernel@I-love.SAKURA.ne.jp>,
        <jmorris@namei.org>, <serge@hallyn.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] tomoyo: use true for bool variable
Date:   Tue, 14 Apr 2020 16:19:48 +0800
Message-ID: <1586852388-68249-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

security/tomoyo/common.c:1028:2-13: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 security/tomoyo/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 1b46738..c577525 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -1025,7 +1025,7 @@ static bool tomoyo_select_domain(struct tomoyo_io_buffer *head,
 	if (domain)
 		head->r.domain = &domain->list;
 	else
-		head->r.eof = 1;
+		head->r.eof = true;
 	tomoyo_io_printf(head, "# select %s\n", data);
 	if (domain && domain->is_deleted)
 		tomoyo_io_printf(head, "# This is a deleted domain.\n");
-- 
2.6.2

