Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD556253B76
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 03:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgH0Bgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 21:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgH0Bgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 21:36:52 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9B5C0617BD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:36:51 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h12so2168562pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CbA3Rnsp/zWIorGwrpuLC/H7e9R5Yxv/yrqTY8GRZRY=;
        b=DnmLbIUrM6RQCzMp/7eaz7+Lj3X//WX2mgBDzOk8sQBjW/DoBlHcp2uSmA94Qyv1bC
         dH6y/AHzevyS07BJsv0zZas/h/clYd3qsLemleiUG4frQ3IWOXboC7115dWmLkX3AeKV
         U/5yKszZ0kxgWCzvhKPVP3HD/0KEuAgZ3yZHZk7nlxttC282lJzeW85KecOBVvnY1dfi
         qNlIx8Vvh/LUToL35wOH3OuU9jnT5rOOmpv0nl6sklU4T+xhj000pSRPVRyilpSMncJa
         oB1IIxB+gbpNYx+qgcAdZSvD5rFmjpCRhu5a5Dz3ZjnusyWpJH5zM9bgHjOeIU/9oXal
         tkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CbA3Rnsp/zWIorGwrpuLC/H7e9R5Yxv/yrqTY8GRZRY=;
        b=PQNHkcKQEHK+qWv4jrsefkG3ZHkIXYqnQPf802hr1eMlnudhdl7kr7sSLmr43e/fcU
         qwOfFQg8GmsEc0EKDQLnoj4ZrSed7eVoQWBjJTc8QHXcPmzlEvSTUpC8T2eXZTocYzhX
         nXqpK0X6+ggaTgp8cfrp8qGmLPQEqVqnTUc90tGPWsaw4hOe5X59RzqF/O9mLNjsB4Xc
         JIjYOZcmTW6Kqz1KqF/OTCj0+V3gCtNo4ERxfwFVgVvsp6L4mDHpdIIiqmmDOyDHmJTw
         61qDzak8YXQ8F7/Pd5vV0/0Z8CezChx0e0s9uyP9Q2my1osl3oEQ8vuEqpzv9LB2JlHQ
         cgqg==
X-Gm-Message-State: AOAM531sHc8EK26YkcfxWBGzNyUHtNHFJ7oYhoBcGxW2TchSeE/gQZIG
        AhbH2HcSOpSSwTkjca1zBPU=
X-Google-Smtp-Source: ABdhPJyYV8H72Lv1j/K6ULxdWegzk4WO/jSTLRfVpcDgdxeromM1bwtNvqCo/FZtD/xz0L4Tlb8dcg==
X-Received: by 2002:a65:5302:: with SMTP id m2mr12589422pgq.185.1598492211324;
        Wed, 26 Aug 2020 18:36:51 -0700 (PDT)
Received: from localhost.localdomain ([49.207.195.64])
        by smtp.gmail.com with ESMTPSA id s129sm478353pfb.39.2020.08.26.18.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 18:36:50 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] linux/kernel.h: add container_from()
Date:   Thu, 27 Aug 2020 07:06:36 +0530
Message-Id: <20200827013636.149307-1-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce container_from() as a generic helper instead of
sub-systems defining a private from_* API
(Eg: from_tasklets recently introduced in
12cc923f1ccc: Tasklet: Introduce new initialization API)

The helper is similar to container_of() in argument order
with the difference of naming the containing structure instead
of having to specify its type.

Suggested-by: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 include/linux/kernel.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 500def620d8f..9d446324a8be 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -1019,6 +1019,15 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
 			 "pointer type mismatch in container_of()");	\
 	IS_ERR_OR_NULL(__mptr) ? ERR_CAST(__mptr) :			\
 		((type *)(__mptr - offsetof(type, member))); })
+/**
+ * container_from - cast a member of a structure out to the containing structure
+ * @ptr:	the pointer to the member.
+ * @container:	the type of the container struct.
+ * @member:	the name of the member within the struct.
+ *
+ */
+#define container_from(ptr, container, member)	\
+	container_of(ptr, typeof(*container), member)
 
 /* Rebuild everything on CONFIG_FTRACE_MCOUNT_RECORD */
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
-- 
2.25.1

