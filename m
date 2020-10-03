Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D1A2826A2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 22:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgJCUdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 16:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgJCUdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 16:33:23 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8DBC0613D0
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 13:33:21 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k8so3895931pfk.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 13:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WfQ+i+BxpbFQx3pen9QNH4hEFsBqsYjP8pLH9bs7mUw=;
        b=Bp+Of4EY8R7dq7agpxR3FH4RsGGGxOLR03sus0ezi4ewM034U1nkstuEpOVj0UVGK7
         6hxitcMpw5mM+Yfm8QmRVvQ2ih44rqmY7tM0a6O5kH6rq+4O1ht4+zHbFtpLfeX4qIeA
         z5vZtQkroTAmaYAlJrWPNNCQuQR73BWwS7ffYvVO56oo/BuBFW9sjwynLoi1Bnt9C8/c
         M3Eb1noqWQ62M6d528zW9GFdYwqdc6mqIJV7ckGNpVZiBzkHM6Wbh7v1xN8bN67c192N
         3ds6niFo6VLc2jzfdQIqD+25jngBKhwtdPKRacTKVKcJyxWfX3Di23WJERmL75EPPTFQ
         togA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WfQ+i+BxpbFQx3pen9QNH4hEFsBqsYjP8pLH9bs7mUw=;
        b=YCl0VxMB4SF/t1oFeiCqRN3ABKy7qUGcY5CQTn4IoYsYr+KxwC9N+xArLnQ+Ovzug+
         v7cFPVKWHJKJUMVBIDMDKkmY1Qn42j+hRk7qrI7+S7Ad44O4OpqYqGW+3XXL5Vq3PgGF
         87vdxGRm7HKnLcF/plB2CK5BzfiKJM/NrojEPiY/amj3swqn5p3jwGLGhsZTobv8Jo4S
         0KXpQLH48uJ9ujaG4iKLm8O00LGTsXyLbX2dfsbcsw+bSDPXMuwv7jNZKlDaZkK0OfNl
         dlR1h6s4gnv/O+ElLvYCSCQhCrDs9HdBhwJA1CAtecPLJYov/VExZkAk0x0lk+bwZhxp
         RcIQ==
X-Gm-Message-State: AOAM531FJAkiqjcyh0EZ9AI91sZm8DVDJghUQF4d4uRlHUwJrMpzrIii
        udNMcQzZgrF5qIfAjbVkebk=
X-Google-Smtp-Source: ABdhPJzHEcb0FuV1DCvKntiRgzf3Bf7lfi0p9EM/K5/fze9qprL346jRWeiUX+qn8g9puKzep7Jqag==
X-Received: by 2002:a62:3001:0:b029:142:2501:39e3 with SMTP id w1-20020a6230010000b0290142250139e3mr8528343pfw.50.1601757201024;
        Sat, 03 Oct 2020 13:33:21 -0700 (PDT)
Received: from localhost.localdomain ([45.118.167.204])
        by smtp.googlemail.com with ESMTPSA id v22sm5339736pff.159.2020.10.03.13.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 13:33:20 -0700 (PDT)
From:   Anmol Karn <anmol.karan123@gmail.com>
To:     dwmw2@infradead.org, richard@nod.at, viro@zeniv.linux.org.uk,
        sandeen@sandeen.net, dhowells@redhat.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, anmol.karan123@gmail.com,
        syzbot+9765367bb86a19d38732@syzkaller.appspotmail.com
Subject: [Linux-kernel-mentees] [PATCH] fs: jffs2: super: Fix null pointer dereference in jffs2_parse_param()
Date:   Sun,  4 Oct 2020 02:03:10 +0530
Message-Id: <20201003203310.494524-1-anmol.karan123@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtd is getting NULL dereferenced in jffs2_parse_param(), while checking condition
for pool size when, case: opt is Opt_rp_size hits.

- fs/jffs2/super.c
The bug seems to get triggered in this line:

if (opt > c->mtd->size)
	return invalf(fc, "jffs2: Too large reserve pool specified, max is %llu KB",
				      c->mtd->size / 1024);


Fix this by adding a NULL check for 'c->mtd' device and return invalf(); which wraps 
errorf() and returns -EINVAL for convenience, which allows userspace to collect them 
directly.

Reported-and-tested-by: syzbot+9765367bb86a19d38732@syzkaller.appspotmail.com 
Link: https://syzkaller.appspot.com/bug?extid=9765367bb86a19d38732 
Signed-off-by: Anmol Karn <anmol.karan123@gmail.com>
---
 fs/jffs2/super.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 05d7878dfad1..f4ce67ac8486 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -203,6 +203,10 @@ static int jffs2_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		if (result.uint_32 > UINT_MAX / 1024)
 			return invalf(fc, "jffs2: rp_size unrepresentable");
 		opt = result.uint_32 * 1024;
+
+		if (!c->mtd)
+			return invalf(fc, "jffs2: mtd device is NULL");
+
 		if (opt > c->mtd->size)
 			return invalf(fc, "jffs2: Too large reserve pool specified, max is %llu KB",
 				      c->mtd->size / 1024);
-- 
2.28.0
