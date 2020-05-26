Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7421A1A71DE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 05:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404829AbgDNDfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 23:35:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55506 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404802AbgDNDfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:35:54 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9944925E1A5E1D16CDB4;
        Tue, 14 Apr 2020 11:35:50 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Tue, 14 Apr 2020 11:35:39 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] mm/usercopy: fix warning Comparison to bool
Date:   Tue, 14 Apr 2020 11:42:04 +0800
Message-ID: <1586835724-45738-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warnings reported by coccicheck

mm/usercopy.c:304:5-18: WARNING: Comparison to bool

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 mm/usercopy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index 660717a..04346cf 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -301,7 +301,7 @@ __setup("hardened_usercopy=", parse_hardened_usercopy);
 
 static int __init set_hardened_usercopy(void)
 {
-	if (enable_checks == false)
+	if (!enable_checks)
 		static_branch_enable(&bypass_usercopy_checks);
 	return 1;
 }
-- 
2.6.2

