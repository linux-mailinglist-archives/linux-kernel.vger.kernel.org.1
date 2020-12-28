Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C362E33AD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 03:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgL1ClY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 21:41:24 -0500
Received: from m15113.mail.126.com ([220.181.15.113]:48729 "EHLO
        m15113.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgL1ClY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 21:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=BXrHzeLTan3It0wc8w
        SiY/+u4jNmCcHGkkhyTwC6xps=; b=a+UveFrfJ6Jy5Z4At8bK+ZbHwQWlzbUmtG
        7sRwzuYySc7pz/xslHsnKVIu6SbF4eU3fr/0TwLt2F5VPkLgkDfCD9TVQtEsk5jH
        +Kwg8uwuoKOMD6KMEJCPlYvMIa2ZCvGsicmTCzJq6C2otDxuzvhWTaQNFzGUDJqs
        aiQ5P9Fuc=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp3 (Coremail) with SMTP id DcmowABHSOT4PelfhzASNQ--.3440S2;
        Mon, 28 Dec 2020 10:07:53 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     gerg@linux-m68k.org, geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Defang Bo <bodefang@126.com>
Subject: [PATCH] m68k: let clk_enable() return immediately if clk is NULL
Date:   Mon, 28 Dec 2020 10:07:45 +0800
Message-Id: <1609121265-207018-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DcmowABHSOT4PelfhzASNQ--.3440S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZryDAryxGry3Cw1xuFWkXrb_yoWxKwc_Ka
        1fC3yvkF1fXrn7Za1DAFsxAF93C395Zr4fWanIvr45tryvqay5JrWIqw18uF12gF42yFWr
        Zwn5Zry3Cr40qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUahF3UUUUU==
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbitRoJ11pECvvmtQAAsN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit<742859adc721>("m68k: let clk_disable() return immediately if clk is NULL").
there should be a check for clk to prevent NULL pointer dereference.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 arch/m68k/coldfire/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c
index 7bc666e..6decd11 100644
--- a/arch/m68k/coldfire/clk.c
+++ b/arch/m68k/coldfire/clk.c
@@ -90,6 +90,9 @@ EXPORT_SYMBOL(clk_get);
 int clk_enable(struct clk *clk)
 {
 	unsigned long flags;
+	if (!clk)
+		return -EINVAL;
+
 	spin_lock_irqsave(&clk_lock, flags);
 	if ((clk->enabled++ == 0) && clk->clk_ops)
 		clk->clk_ops->enable(clk);
-- 
2.7.4

