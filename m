Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE852E3157
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 14:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgL0Np4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 08:45:56 -0500
Received: from m15113.mail.126.com ([220.181.15.113]:41493 "EHLO
        m15113.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgL0Np4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 08:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=Rqb+wRh62Gki33C+j9
        ZCew9NAJiKb5+CJW7yy9XRjhY=; b=fjaKvN1YQc0lSBIKMAQ/1q6t89qxp5LsR4
        mCH/M3evdqKNacRYoOHe3ceWvmPVRy85BfLepzAoP8BnqwY4H81pACn0H8fJo9tj
        q2E0BqTtm6QhXU0hq59HVvkUFbivpt3nfTVYvRmFzmUb/Xto7YbjPYMgW6RccjZB
        iQitk4mUU=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp3 (Coremail) with SMTP id DcmowADX3wNwj+hf+_j6NA--.4703S2;
        Sun, 27 Dec 2020 21:43:13 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        arnd@arndb.de
Cc:     dianders@chromium.org, gregkh@linuxfoundation.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Defang Bo <bodefang@126.com>
Subject: [PATCH] kgdbts: Passing ekgdbts to command line causes panic
Date:   Sun, 27 Dec 2020 21:43:05 +0800
Message-Id: <1609076585-4010725-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DcmowADX3wNwj+hf+_j6NA--.4703S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF13KFyrZFy3tF4rXFWDurg_yoW3Gwc_Ga
        45Xr1xJrWY9w1qg3W2v3yfZry7Aa17W3WfJFn2kw4fCry5ur1qkFWqvFZ5GF18Jr4vyFsr
        XrsIqrW09F12yjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRoqcUUUUUU==
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbikhEI11pECFooHQAAsl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit<1bd54d85>,kgdbts_option_setup does not check input argument
before passing it to strlen. The argument would be a NULL pointer.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 drivers/misc/kgdbts.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
index 945701b..99d9795 100644
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

