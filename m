Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682782775C3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgIXPs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgIXPs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:48:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43CFC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 08:48:55 -0700 (PDT)
Date:   Thu, 24 Sep 2020 17:48:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600962532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=xaY2+HjTSKqN94B8ygX+wilHy1PVYUZux5iZUZOa2FI=;
        b=0X2h41+0LObRVZ1V23+hPqkqUBU7ZH2wUl5QRw9qDlJT4R5ft0UcL/Rwt/IGqDLxsHRg7L
        y1czAQI133nTsDAdcAjcUZP78TACJdC/E7X3IyMnqpmFX0sCNv+WSiSNKX32f+Hvi9hDBh
        A/HjfZ9T3ttoEtNdEG7nVQjlE6TV9yxOGvIc5rexeRuVaMCiNJAXxyTkri+59ZjBeF8cBb
        kTIsqpaYQECbZwCE/CJoWP3A94pNMcTJCv/893e5lq+zVOS09/+ABXtZiODiy6ZNy2WHLv
        43lq/uTOX7g2HCnXXOPwXwN3EiCpTnUlghTmICblMbrabFn9kMVmKaimu82JgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600962532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=xaY2+HjTSKqN94B8ygX+wilHy1PVYUZux5iZUZOa2FI=;
        b=gqMgh/vPbiDThyNKgZBBG6l1N7wTEqo6uHswle8DmXMbQPdYIJDbSRwExpc/smf/MeYvMO
        zAVM9dJWUAnIYoAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] locking/seqlock: Tweak DEFINE_SEQLOCK() kernel doc
Message-ID: <20200924154851.skmswuyj322yuz4g@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ctags creates a warning:
|ctags: Warning: include/linux/seqlock.h:738: null expansion of name pattern "\2"

The DEFINE_SEQLOCK() macro is passed to ctags and being told to expect
an argument.

Add a dummy argument to keep ctags quiet.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/seqlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 962d9768945f0..4a69e74dc7ce9 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -735,7 +735,7 @@ typedef struct {
 	} while (0)
 
 /**
- * DEFINE_SEQLOCK() - Define a statically allocated seqlock_t
+ * DEFINE_SEQLOCK(sl) - Define a statically allocated seqlock_t
  * @sl: Name of the seqlock_t instance
  */
 #define DEFINE_SEQLOCK(sl) \
-- 
2.28.0

