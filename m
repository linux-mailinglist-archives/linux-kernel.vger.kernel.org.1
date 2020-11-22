Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6ED2BC433
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 06:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgKVFto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 00:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgKVFto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 00:49:44 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EB6C0613CF;
        Sat, 21 Nov 2020 21:49:44 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id t8so11833762pfg.8;
        Sat, 21 Nov 2020 21:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B+QbogMBfaUGeB6MGCFWgG2hcO8GovdZprHyRdvsoIw=;
        b=VjWvs0+iwIJf0NAK8ZXjcVXmZLEzj0yLxRNNvA9HEMl24M4GTZV5t0p8JeA939HEXv
         aSzMIlhZAbZc4YPV6zge/HSjE3IcqIQACK7iT6lzqkXrWxvFml1V0NxdbII596xHlGTA
         X5btd/nQzBZT1fq9ja0htcUBHk4t91qIoEnYlLr9xNvCaijER6pEQ7Y5cleBXrXf1oYO
         wiQFUJeSIIYeatLZTr29GsLnCQjgIJ5uBbBe4c4CnJvB9a7Z5rrCTuvjNPS5xGobC48X
         rq+RrEabi/mp89o7RZcn9pkTqaBtps9u1WQQCoHXq9ibybJ8yy2VSyvc929UeTFuOj5v
         7cVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B+QbogMBfaUGeB6MGCFWgG2hcO8GovdZprHyRdvsoIw=;
        b=TimYqAntGMZY0K/y2245LrU6X4PwzDiVw8VFkZHJJU7QaEHJJmiOxK3U4m4KoWMalK
         GuRCmfDqmLrpsNBx16AwvWnf3jeP+pkp34hbzelV/XCSQxR7rl6kfpbkfPjC7kHwimyu
         NTa87qOs8IJzfrBU7PBrx7w646Prv+isjWitF/knG9dVqsO6ieogxKybVSyNh+3fDPIQ
         tQnMGxJxCaHLgPnb5QDTavYJyvLI8VsAgO1PyksbmODtTPJcCRu39wXeS0w2/5DigROD
         nB4kRNqfPJkB8dmI41MuRg1qUoMuT0uJ8SAOpeJ8+7TDrxnh4SrmEtVHlIlE5ad8tI+8
         VrMg==
X-Gm-Message-State: AOAM531FCghXO5BexsE3qdsfOFhZZs8bBkYvnLfq3ODp4nralEUmg2fm
        v891hd7GfvCsZlujo0h8TQ==
X-Google-Smtp-Source: ABdhPJwMMebdcFe+t1FCJLBnToOuIGwvLXNqOnrceAUSTQdZGnG9Jrg9J6OJFKGj6Hs/4E/U/l+cgQ==
X-Received: by 2002:a17:90b:1098:: with SMTP id gj24mr5436101pjb.195.1606024183602;
        Sat, 21 Nov 2020 21:49:43 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id o1sm7110505pgk.60.2020.11.21.21.49.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Nov 2020 21:49:42 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     coproscefalo@gmail.com, hdegoede@redhat.com, mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] platform/x86: toshiba_acpi: Fix the wrong variable assignment
Date:   Sun, 22 Nov 2020 13:49:37 +0800
Message-Id: <1606024177-16481-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The commit 78429e55e4057 ("platform/x86: toshiba_acpi: Clean up
variable declaration") cleans up variable declaration in
video_proc_write(). Seems it does the variable assignment in the
wrong place, this results in dead code and changes the source code
logic. Fix it by doing the assignment at the beginning of the funciton.

Fixes: 78429e55e4057 ("platform/x86: toshiba_acpi: Clean up variable declaration")
Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 drivers/platform/x86/toshiba_acpi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index e557d757c647..fa7232ad8c39 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -1478,7 +1478,7 @@ static ssize_t video_proc_write(struct file *file, const char __user *buf,
 	struct toshiba_acpi_dev *dev = PDE_DATA(file_inode(file));
 	char *buffer;
 	char *cmd;
-	int lcd_out, crt_out, tv_out;
+	int lcd_out = -1, crt_out = -1, tv_out = -1;
 	int remain = count;
 	int value;
 	int ret;
@@ -1510,7 +1510,6 @@ static ssize_t video_proc_write(struct file *file, const char __user *buf,
 
 	kfree(cmd);
 
-	lcd_out = crt_out = tv_out = -1;
 	ret = get_video_status(dev, &video_out);
 	if (!ret) {
 		unsigned int new_video_out = video_out;
-- 
2.20.0

