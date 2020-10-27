Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B9829BE03
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1813519AbgJ0Quj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:50:39 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:50978 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1813389AbgJ0Qt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:49:57 -0400
Received: by mail-pf1-f202.google.com with SMTP id a27so1244654pfl.17
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nuxxs/Px/9QpRIlm7J+PyL0HWcASsbcWXqWCTDpjZLY=;
        b=SGQLLWiB+LUjaqR1TSdlpCpxrsi+POAiH2xjFLEZiQ/Wy8axJ7MQAwv6yJG4RQFjVH
         2Bde6HUbl3/5tLJBqO2GGocfLTNhD4piiEGuFcTE3tNlCR/vOkEweNCcRo8i7U2fOu0+
         UigavmfeQIAdOyfoCOq2wOlrR79bpk/B9bpd91hzS8apgFhVrwDZTlzlp/XoK5RIrc7U
         EgtcREjXUgluwLgZ/dBJ5fEwwxTQeMMERb5hdHFyDyg3jdX/f8TcLnKuVuBqHWDSO/Vf
         KMxOlowmn6ogA67Z+poRwIIIfbhDDnFdxm80hDvd3shtA5cXQWT1psAvvLBLUm4epcsX
         KbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nuxxs/Px/9QpRIlm7J+PyL0HWcASsbcWXqWCTDpjZLY=;
        b=hZMceAJvmOdHlEFZUPO9kmSOEdCrtHytCGpDFZxJcdVqZWvst8YKjfKfw5gqq/g++0
         qdXCfJ9OOG473rHKfSA9JhzRudTwSced5PpYONeyn9Gqegk2UHDqmPTr8qnVAecZVWuD
         JGDIbER8k+Dms6Sc25sA3+snDdSyD2x2lN5NUJmgQ6xaAWa6B4GXgT9FJa9kFqgbh2Hj
         duXhQBPSB9XQREN15oNSnSS4rGTB50UmUelItuG+KIM4G4zunON90imxcMKjo5RXNVAm
         uK0e3lPkBnn0eOAcTCHrLP+c3D/gPuntuQX/X2YzKANRuEUWJ0RJ5wQPoHvnzGovxlgS
         Dmbg==
X-Gm-Message-State: AOAM530QwxRGNnUiy7ffyXMYbqYlEsDgDOY3WDj5bUOMD+LXVe8EkuaZ
        jReMpB/V4pSMor7w+ewQDwENLPN04WSfnkyAxey/XCx13S5aPmwqe4/9RahKR1bkPvph/4pGfMy
        GhIjTO3F+oiGDEEnB+6KE3SpZEybxbPKQ4/4II47LSCfjSZGcixnxmF1VXhotcx6XgWNzJT6+
X-Google-Smtp-Source: ABdhPJzT7GGtUaXKyrFhHPKMnptHgg3JCdWq1CQfBl6a05IhJ1AanAbFiyvdLmOm1ZktrH0sdKOH1g5fzZjb
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a62:8097:0:b029:153:ce1d:c46 with SMTP id
 j145-20020a6280970000b0290153ce1d0c46mr3179460pfd.68.1603817395887; Tue, 27
 Oct 2020 09:49:55 -0700 (PDT)
Date:   Tue, 27 Oct 2020 09:49:49 -0700
In-Reply-To: <20201027164950.1057601-1-bgardon@google.com>
Message-Id: <20201027164950.1057601-2-bgardon@google.com>
Mime-Version: 1.0
References: <20201027164950.1057601-1-bgardon@google.com>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [PATCH 2/3] sched: Add needbreak for rwlocks
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Contention awareness while holding a spin lock is essential for reducing
latency when long running kernel operations can hold that lock. Add the
same contention detection interface for read/write spin locks.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 include/linux/sched.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 063cd120b4593..77179160ec3ab 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1870,6 +1870,23 @@ static inline int spin_needbreak(spinlock_t *lock)
 #endif
 }
 
+/*
+ * Check if a rwlock is contended.
+ * Returns non-zero if there is another task waiting on the rwlock.
+ * Returns zero if the lock is not contended or the system / underlying
+ * rwlock implementation does not support contention detection.
+ * Technically does not depend on CONFIG_PREEMPTION, but a general need
+ * for low latency.
+ */
+static inline int rwlock_needbreak(rwlock_t *lock)
+{
+#ifdef CONFIG_PREEMPTION
+	return rwlock_is_contended(lock);
+#else
+	return 0;
+#endif
+}
+
 static __always_inline bool need_resched(void)
 {
 	return unlikely(tif_need_resched());
-- 
2.29.0.rc2.309.g374f81d7ae-goog

