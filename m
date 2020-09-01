Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5682585F9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 05:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgIADBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 23:01:36 -0400
Received: from smtp.h3c.com ([60.191.123.56]:37530 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbgIADBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 23:01:36 -0400
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam01-ex.h3c.com with ESMTPS id 08130va1020900
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Sep 2020 11:00:57 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 1 Sep 2020 11:00:58 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <ysato@users.sourceforge.jp>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>
CC:     <uclinux-h8-devel@lists.sourceforge.jp>,
        <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] clocksource: return negative error code
Date:   Tue, 1 Sep 2020 10:54:12 +0800
Message-ID: <20200901025412.39128-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 08130va1020900
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A negative error code should be returned

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 drivers/clocksource/h8300_timer8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/h8300_timer8.c b/drivers/clocksource/h8300_timer8.c
index 1d740a8c4..47114c2a7 100644
--- a/drivers/clocksource/h8300_timer8.c
+++ b/drivers/clocksource/h8300_timer8.c
@@ -169,7 +169,7 @@ static int __init h8300_8timer_init(struct device_node *node)
 		return PTR_ERR(clk);
 	}
 
-	ret = ENXIO;
+	ret = -ENXIO;
 	base = of_iomap(node, 0);
 	if (!base) {
 		pr_err("failed to map registers for clockevent\n");
-- 
2.17.1

