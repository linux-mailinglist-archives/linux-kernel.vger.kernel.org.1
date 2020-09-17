Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D6226DDD1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgIQORW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:17:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51550 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727315AbgIQOL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:11:26 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 278EDF9982682377EC19;
        Thu, 17 Sep 2020 21:52:26 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 21:52:16 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>
CC:     <linux-kernel@vger.kernel.org>, <houtao1@huawei.com>,
        <rcu@vger.kernel.org>
Subject: [PATCH 1/2] locktorture: doesn't check nreaders_stress when no readlock support
Date:   Thu, 17 Sep 2020 21:59:09 +0800
Message-ID: <20200917135910.137389-2-houtao1@huawei.com>
X-Mailer: git-send-email 2.25.0.4.g0ad7144999
In-Reply-To: <20200917135910.137389-1-houtao1@huawei.com>
References: <20200917135910.137389-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ensure there is always at least one locking thread.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/locking/locktorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 9cfa5e89cff7f..bebdf98e6cd78 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -868,7 +868,8 @@ static int __init lock_torture_init(void)
 		goto unwind;
 	}
 
-	if (nwriters_stress == 0 && nreaders_stress == 0) {
+	if (nwriters_stress == 0 &&
+	    (!cxt.cur_ops->readlock || nreaders_stress == 0)) {
 		pr_alert("lock-torture: must run at least one locking thread\n");
 		firsterr = -EINVAL;
 		goto unwind;
-- 
2.25.0.4.g0ad7144999

