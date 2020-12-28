Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF672E4199
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 16:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438556AbgL1OH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 09:07:59 -0500
Received: from m15114.mail.126.com ([220.181.15.114]:33077 "EHLO
        m15114.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437257AbgL1OHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 09:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=os0e7yDxDmr48itpSy
        k+PBXhkus/bZ75U22h9N7lIiM=; b=KriXCrmJ4jBzxqyHdjU456tv2wUl/LaY2r
        YyO0COWO43yiSt6OUby1LXKjXbsYmJQNn7AVyTA8o7qRXBrIDYbHsaMysF/iP4AT
        YW3pl9XH/g7hSMszou1/nnrp5oJQwZyl6l1+KiRldJuU/PDs0T9iHlHwaJj92AXT
        GM+YYy1us=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp7 (Coremail) with SMTP id DsmowACXmWnpO+lfZoqEMg--.33140S2;
        Mon, 28 Dec 2020 09:59:05 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     Defang Bo <bodefang@126.com>
Subject: [PATCH] kgdbts: Passing ekgdbts to command line causes panic
Date:   Mon, 28 Dec 2020 09:58:58 +0800
Message-Id: <1609120738-202321-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DsmowACXmWnpO+lfZoqEMg--.33140S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFW3Kr1UAF4xuF13Zry3CFg_yoW3urg_Ca
        y5XF1xX3yj9w1qg3W2y393ur9Fyanru3Z3XFn293yfCry5Cr1q9FWqvFZ5WF18XFsFyFsr
        ZrZIqrW09F1IqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjF4iUUUUUU==
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbikgkJ11pECFyxVAAAsq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit<1bd54d851f50>("kgdboc: Passing ekgdboc to command line causes panic"),
kgdbts_option_setup does not check input argument before passing it to strlen.
The argument would be a NULL pointer.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 drivers/misc/kgdbts.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
index 945701b..b077547 100644
--- a/drivers/misc/kgdbts.c
+++ b/drivers/misc/kgdbts.c
@@ -1057,6 +1057,11 @@ static void kgdbts_run_tests(void)
 
 static int kgdbts_option_setup(char *opt)
 {
+	if (!opt) {
+		pr_err("kgdbts: config string not provided\n");
+		return -EINVAL;
+	}
+
 	if (strlen(opt) >= MAX_CONFIG_LEN) {
 		printk(KERN_ERR "kgdbts: config string too long\n");
 		return -ENOSPC;
-- 
2.7.4

