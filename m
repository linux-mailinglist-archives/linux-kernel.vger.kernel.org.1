Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A8C2A8DA0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 04:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgKFDkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 22:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKFDkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 22:40:20 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20498C0613CF;
        Thu,  5 Nov 2020 19:40:20 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id s25so5722465ejy.6;
        Thu, 05 Nov 2020 19:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v31c+3qUzm/Jl9mhtRELjufMUcxhfj6Qpk0Egg0rkIc=;
        b=G2sPbaKVWlctWWt9dQqnUUZ26kWvTx4lqpzkKvDn9D1DxhleQxkvLOaOHnbPnk3raT
         Lk7PdtiqqtRFkDpPM2JXWduU85jDrg8SZreWZlATMqd6zdcLaz9YfcKnq7bEGGA+m9cX
         8Oz+j9tVEk9imS/i1TzoJ0qXuejfUX/yDNMCKzUwGWr58yJWgUTUfe9hp5NueEa+RI+Y
         6gaq/n+nbQqqV2c7zT3zd3ZZmmU9CYkeTmw9KfZYMsomje/mKrNiMdHr/4c3Kgl4RCWC
         bzLptOP6jsqvjY2KAAtprDXXZqNIVxX7p8Mpl0josoGZXcroSDGO+j5lCF40P9Qmte1l
         qniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v31c+3qUzm/Jl9mhtRELjufMUcxhfj6Qpk0Egg0rkIc=;
        b=jLUkkbyO98doxMqo7lS7kLNE79Bc13eeqi9rdNULIS89aIZbV/fB/MYqoQHFIOEWJh
         Byrdgeuog6BwGpIJPpZiuO2xSf6RKNGO94jm79q+i6XwWrLZHfH4pWjX1KIRewe5+ukJ
         v0ewICR5geq65dBIdSG2w1mDPha02fiGLr/C7cPZHK5WMHABIUaScKaIe3aDGqiDpM1X
         01qd/U+IEiAv7DjO/wF4xdko0MRNHQxx3fhNLo01VurHySfD+qf6QIGhd9EX6fOgZDOB
         56Vby4DeVM4HnmdryGtQcQY3pRvQH4mBmkDtroFjl+htEubmJFgAxUe85lMPZD7STCiL
         kA8Q==
X-Gm-Message-State: AOAM533tnjTYNJfjbzn9FR+P2kthn3eUOEK/lnYaGJ3ZXA2E4i5mYqyT
        NcmsqFMzvM+hOLaePWnS5RA=
X-Google-Smtp-Source: ABdhPJxdlgrDr75OUdeerY4h/FD+9Z7XvLQL8XO5mZ2NUVm/pGUpKmrXgCq2czkobGG4KNQiERvrOA==
X-Received: by 2002:a17:906:6a57:: with SMTP id n23mr55277ejs.315.1604634018857;
        Thu, 05 Nov 2020 19:40:18 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d20:9d00:b87b:b644:61a3:6870])
        by smtp.gmail.com with ESMTPSA id z23sm2103337ejb.4.2020.11.05.19.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:40:18 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] printk: remove unneeded dead-store assignment
Date:   Fri,  6 Nov 2020 04:40:05 +0100
Message-Id: <20201106034005.18822-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make clang-analyzer on x86_64 defconfig caught my attention with:

  kernel/printk/printk_ringbuffer.c:885:3: warning:
  Value stored to 'desc' is never read [clang-analyzer-deadcode.DeadStores]
                desc = to_desc(desc_ring, head_id);
                ^

Commit b6cf8b3f3312 ("printk: add lockless ringbuffer") introduced
desc_reserve() with this unneeded dead-store assignment.

As discussed with John Ogness privately, this is probably just some minor
left-over from previous iterations of the ringbuffer implementation. So,
simply remove this unneeded dead assignment to make clang-analyzer happy.

As compilers will detect this unneeded assignment and optimize this anyway,
the resulting object code is identical before and after this change.

No functional change. No change to object code.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201105

John, please ack.
Petr, please pick this minor non-urgent clean-up patch.

 kernel/printk/printk_ringbuffer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 6b1525685277..74e25a1704f2 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -882,8 +882,6 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
 	head_id = atomic_long_read(&desc_ring->head_id); /* LMM(desc_reserve:A) */
 
 	do {
-		desc = to_desc(desc_ring, head_id);
-
 		id = DESC_ID(head_id + 1);
 		id_prev_wrap = DESC_ID_PREV_WRAP(desc_ring, id);
 
-- 
2.17.1

