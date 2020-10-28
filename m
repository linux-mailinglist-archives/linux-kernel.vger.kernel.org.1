Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6B429DAAA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390360AbgJ1X21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390217AbgJ1X2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:28:14 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC9AC0613CF;
        Wed, 28 Oct 2020 16:28:14 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b1so932193lfp.11;
        Wed, 28 Oct 2020 16:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tFcezZaUjVtB4OlYd/0j5lQJ4Uiz++vw/9S3zS/Ui5Y=;
        b=pqGwKkpki+kIC7fupDyAg9eTU8i8Kg6eOdm5GLTOMRyO+4ZIGSl13nwOvLixydxc1e
         eE6NNNKcbGASf/tlYMCr99mEkavE/kiXcME8PFK7W+Rz7vK2mIaqtzCBqqbeglAsK+LU
         fZnMFOAhutiZR4w7RekLQt6WRSA+KZ9u9XvnVgd4ZuT4nTyGoBxivs4Dbck6ECImMkja
         qT6qk7PncQkEr3IsES0Z0SdEYrGM1yiK6YiIh/TrzzDBlGY2MpTgsx6ZmGZKP9AaNqCB
         PM1hNo6C6pUZ8dBLQvF3uUcoyrWr5Em8Ik/JTLn9PGQu2m0Uptij8WW0vpFNQlDeEMoP
         XSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tFcezZaUjVtB4OlYd/0j5lQJ4Uiz++vw/9S3zS/Ui5Y=;
        b=pdVHlBkHlbF8kiAAhwnDeAPSXX1R9+1AHmXWdkuaWgfhU1F9lNz2HXnGyKp46+2joZ
         NnT5LcYQOKMDlIKl1KCft8/PtK0pmvoCKdyjzo+B2Z/iscC4HnvEBTBnQHoaJTn+Rm3Q
         EalJBv6DSH5HxFriqQSvdCP+DjBeGGpTTjxT9/APs9/VB2uERDEnd1tnRT4tZ326gFP+
         ZccxCkB7eINkerBySQqEbpgY/Buu40tDkPram5eDNA34T5Iy/SNsbaXZK2kz50PUfC30
         hXxxSAMqd3XUU/wlJevowiM3kNlkDCoX8b9OjidfjkYuN6zv8OX+82UtyJ5sKMd0ZKty
         JnhQ==
X-Gm-Message-State: AOAM532jFhgWQgE1xpIezxNh2hc2ZNAVmuO/66TX6nVibAXW/m7CyF7J
        BM29qrKqVO8ageTkcfKJIQQcEZ+0NL8AxcJ6
X-Google-Smtp-Source: ABdhPJxSuYssdPMtBWkuONYEQ4ri3P/nvlWFvD8Nuuh8fE+81I5PE3HVmES2M3wcpNv0Nxewlr9mPw==
X-Received: by 2002:a17:907:40eb:: with SMTP id nn19mr7715572ejb.240.1603890362912;
        Wed, 28 Oct 2020 06:06:02 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d7a:200:a915:6596:e9b0:4f60])
        by smtp.gmail.com with ESMTPSA id j3sm2977928edh.25.2020.10.28.06.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 06:06:02 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrey Ignatov <rdna@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-safety@lists.elisa.tech,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] kernel/hung_task.c: make type annotations consistent
Date:   Wed, 28 Oct 2020 14:05:41 +0100
Message-Id: <20201028130541.20320-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
removed various __user annotations from function signatures as part of its
refactoring.

It also removed the __user annotation for proc_dohung_task_timeout_secs()
at its declaration in ./sched/sysctl.h, but not at its definition in
./kernel/hung_task.c.

Hence, sparse complains:

  kernel/hung_task.c:271:5: error: \
  symbol 'proc_dohung_task_timeout_secs' redeclared with different type \
  (incompatible argument 3 (different address spaces))

Adjust the annotation at the definition fitting to that refactoring to make
sparse happy again, which also resolves this warning from sparse:

  kernel/hung_task.c:277:52: warning: incorrect type in argument 3 \
    (different address spaces)
  kernel/hung_task.c:277:52:    expected void *
  kernel/hung_task.c:277:52:    got void [noderef] __user *buffer

No functional change. No change in object code.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201028

Christoph, can I get quick ack from you on a fix to your refactoring?
Andrew, please pick this minor non-urgent clean-up patch.

 kernel/hung_task.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index a672db830a94..bb2e3e15c84c 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -269,8 +269,7 @@ static long hung_timeout_jiffies(unsigned long last_checked,
  * Process updating of timeout sysctl
  */
 int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
-				  void __user *buffer,
-				  size_t *lenp, loff_t *ppos)
+				  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
 
-- 
2.17.1

