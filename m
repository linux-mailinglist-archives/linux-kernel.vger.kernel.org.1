Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D062F6EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 00:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbhANXQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 18:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730885AbhANXQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 18:16:06 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FD4C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 15:15:25 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id q4so3706543plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 15:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gRIC6O4nkHE4jc0kCvdEP4J6Eft1RJEkfiFDwAbXSfg=;
        b=Lkm7efB+7IlCmWzqWmETDZ05oX3RJ2vRNIV3UrVqBoBOmCAJCMBKHrynDfrSyJgWpV
         l7FkPYQH1+isNZn9TaJvDZSMiDRsT8Amq7X0CGNH0MXfka6XY++kKWoiv750PumvgYG4
         afjpIXDrd2abr8j9GwxEdKRkwgCfx9nuWrZDX1tYAS8NWiwur5Wrc+WKTc3k+aAzjBi6
         eY3A170fxNHQThS4Ketobj0+kZ/cag2u4vKxKNJdTUjmyyzSHoU6Rw0Dr/m91hhf+SIX
         XJNc+08GiuJj6+8gbLBAbC0WbIRmvIN1+e13YvZZS+LDbL1gsJU25uidLpzcI4Eodwef
         Vx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gRIC6O4nkHE4jc0kCvdEP4J6Eft1RJEkfiFDwAbXSfg=;
        b=J65k12aHKZzF7C9VqVhbRwlpr1aA7peK1r0qqLr3o4fHaY4iSFA40occ3dvUl1oZJu
         T9il6cIlSs/qfPFTvC/AqUAE0eKuFxGsPhzoLwXwRa6W0RMZ+SE3xlkvvfnd0lpluY09
         13ERsB+Oj56ItH055utWa68omlYUOrndz/w7p1SIfdlSnhUApWfBuB+oNErcofKpBatF
         FOUITywZQGBKNcVeXFoWZ5Z0PvLdJ+nsa29vbyRefv9D8AFEZGfAgTFFR7hZE5QDPocP
         y1M9JF8jdNET14mR2F967+36Dn4zPDEhWg3+LDCscaN9iXZ73xRplcsO7LbiWaLLfgVp
         9QoA==
X-Gm-Message-State: AOAM531Kbd3eB2l/MvFT1h/KB/BrVuMUsspXwjWO5kmK1QcOm7Da24dp
        UQnDSu/XUlwyMaeAybqh6uSsWpQQQt0=
X-Google-Smtp-Source: ABdhPJxCfQcg1EiUHOKeF4u2XRWPnzNzNFdZv/6gS6+8dI2K0s/42rY8WBeRERScjA6WbAeVxWWAfw==
X-Received: by 2002:a17:90a:7142:: with SMTP id g2mr7431013pjs.92.1610666124166;
        Thu, 14 Jan 2021 15:15:24 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c24sm6134436pgi.71.2021.01.14.15.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 15:15:23 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     opendmb@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Barret Rhoden <brho@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] initramfs: Panic with memory information
Date:   Thu, 14 Jan 2021 15:15:16 -0800
Message-Id: <20210114231517.1854379-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems with large amounts of reserved memory we may fail to
successfully complete unpack_to_rootfs() and be left with:

 Kernel panic - not syncing: write error

this is not too helpful to understand what happened, so let's wrap the
panic() calls with a surrounding show_mem() such that we have a chance
of understanding the memory conditions leading to these allocation
failures.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 init/initramfs.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 55b74d7e5260..9dafda6a401b 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -11,6 +11,7 @@
 #include <linux/utime.h>
 #include <linux/file.h>
 #include <linux/memblock.h>
+#include <linux/mm.h>
 #include <linux/namei.h>
 #include <linux/init_syscalls.h>
 
@@ -45,6 +46,11 @@ static void __init error(char *x)
 		message = x;
 }
 
+#define panic_show_mem(...) {	\
+	show_mem(0, NULL);	\
+	panic(__VA_ARGS__);	\
+}
+
 /* link hash */
 
 #define N_ALIGN(len) ((((len) + 1) & ~3) + 2)
@@ -80,7 +86,7 @@ static char __init *find_link(int major, int minor, int ino,
 	}
 	q = kmalloc(sizeof(struct hash), GFP_KERNEL);
 	if (!q)
-		panic("can't allocate link hash entry");
+		panic_show_mem("can't allocate link hash entry");
 	q->major = major;
 	q->minor = minor;
 	q->ino = ino;
@@ -125,7 +131,7 @@ static void __init dir_add(const char *name, time64_t mtime)
 {
 	struct dir_entry *de = kmalloc(sizeof(struct dir_entry), GFP_KERNEL);
 	if (!de)
-		panic("can't allocate dir_entry buffer");
+		panic_show_mem("can't allocate dir_entry buffer");
 	INIT_LIST_HEAD(&de->list);
 	de->name = kstrdup(name, GFP_KERNEL);
 	de->mtime = mtime;
@@ -460,7 +466,7 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	name_buf = kmalloc(N_ALIGN(PATH_MAX), GFP_KERNEL);
 
 	if (!header_buf || !symlink_buf || !name_buf)
-		panic("can't allocate buffers");
+		panic_show_mem("can't allocate buffers");
 
 	state = Start;
 	this_header = 0;
@@ -607,7 +613,7 @@ static int __init populate_rootfs(void)
 	/* Load the built in initramfs */
 	char *err = unpack_to_rootfs(__initramfs_start, __initramfs_size);
 	if (err)
-		panic("%s", err); /* Failed to decompress INTERNAL initramfs */
+		panic_show_mem("%s", err); /* Failed to decompress INTERNAL initramfs */
 
 	if (!initrd_start || IS_ENABLED(CONFIG_INITRAMFS_FORCE))
 		goto done;
-- 
2.25.1

