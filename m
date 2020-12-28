Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632342E359E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 11:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgL1J7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 04:59:03 -0500
Received: from mail-m963.mail.126.com ([123.126.96.3]:44784 "EHLO
        mail-m963.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgL1J7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 04:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=7Talz/lFvusOYa6P4c
        tOD4KbtRRHAT+PHWA9WD6jOe0=; b=hFoOEthnViifPN/PZLFjX3MmqjQL2I87YM
        ZPDySn9fLcuY9ek8QT3FQJqGd7NHkdDHanw+9YsSw9krG58Sdz+vYapKmYpbxq0A
        k/xsOZOZGP8yS6Bm45P7FB4Wr/mC/cc1iMOyiNw4NyQ5FgV805fIb8Fcsdm+5yfu
        fCN8Yf3NY=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp8 (Coremail) with SMTP id NORpCgBHVqbJOulfiL6OBA--.38746S2;
        Mon, 28 Dec 2020 09:54:18 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     Defang Bo <bodefang@126.com>
Subject: [PATCH] kgdbts: Passing ekgdbts to command line causes panic
Date:   Mon, 28 Dec 2020 09:54:10 +0800
Message-Id: <1609120450-199726-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: NORpCgBHVqbJOulfiL6OBA--.38746S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFW3Kr1UAF4xuF13Zry3CFg_yoW3urX_Ca
        y5XF1xX3yj9w1qg3W2y393Zr9Fya17u3Z3XFn293yfCry5Cr4q9FWqvFs5WF18XFsFyFsr
        ZrZIvrW09F1IqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRoqcUUUUUU==
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbi4woJ11pD81jTKwAAs9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit<1bd54d851f50>(("kgdboc: Passing ekgdboc to command line causes panic"),
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

