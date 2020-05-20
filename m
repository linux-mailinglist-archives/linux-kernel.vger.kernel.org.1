Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4C11DA9E1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 07:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgETF3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 01:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgETF3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 01:29:14 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41465C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:29:14 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id z5so2479075qtz.16
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oOKvTis22eNP85Mz9uA/OFT+qhsmJnOFthnsf9VGQzY=;
        b=viUE7Q+662+IkzFyahnIaYCnJOcXUlVMMDblrHEottDjc4iw8rS5qp3VqL4d9yk4Vl
         iLsXOlQhtl3Ni8WVCgiTZAXlThHQbBvCRAruZTCadGC5QNJOhYhwVNk58yb7zQWAZpQN
         m8ea7beMEQVkgnGQE8Kw6TLPJN7uFnreHrikVsiGxB1medgieO5mUY71oBVYYFXFEw1R
         Qa/W2numx5WhO4pGHeSPhIJZA38/obPSutq/xKAvxx2hwi7DQ8F7U8hqjk85lLb++Wae
         8kn2/mNtLie+rrR4TFWKimt/EH4874ceN9jQNTeozxR3hAL//stq/IC+ACWdKSdQQzRI
         wB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oOKvTis22eNP85Mz9uA/OFT+qhsmJnOFthnsf9VGQzY=;
        b=FLOd3Whx9PMRNEsNcpY4sO58UHrRFNRVKKcu/3/j5ocH+FMGMAS3+Uou9QalNRkO1M
         KzdeVxA5wV0nBrcwyM8feUIRK9d7sXDCU51aQgwJtWH1mDAmbggXTfwlyW77kGLPJjWi
         bqIUMjoFlXNKGc1QazJmhlb1FmoekHnIU6EkAk2M1OExYqLYoJzEuoajKbLsN9zyz68u
         6aDVeCXUXWmUFlbQ2tn3efZPNYI4pPrtGQBjRT7vjxOozakn06NfEoy1EEE6vkMNhxS0
         X0S6UmtzqWbFf2kKg3Qcq4bWum+ioNMZWugp/JYCZCdOTeBFABv9iytunMYQofQp44Eb
         wlXQ==
X-Gm-Message-State: AOAM530VFsewAeTmTG/Zw1dAypBxErf9Hn05KMN/MvDKi8cB762Wsdej
        sI7HyY0gSWbYPPOnJaqDv3FUXYqsUMI=
X-Google-Smtp-Source: ABdhPJxHdmAtEVnKOxk3BiJr7dFV6qDRiCtdOzttrQ1X4xOxgL+hGpFSTwe8fs+Y0mMKYecBu0kd59Z48Fg=
X-Received: by 2002:a05:6214:1248:: with SMTP id q8mr3157078qvv.130.1589952553394;
 Tue, 19 May 2020 22:29:13 -0700 (PDT)
Date:   Tue, 19 May 2020 22:28:57 -0700
In-Reply-To: <20200520052908.204642-1-walken@google.com>
Message-Id: <20200520052908.204642-2-walken@google.com>
Mime-Version: 1.0
References: <20200520052908.204642-1-walken@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v6 01/12] mmap locking API: initial implementation as rwsem wrappers
From:   Michel Lespinasse <walken@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michel Lespinasse <walken@google.com>,
        Davidlohr Bueso <dbueso@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change wraps the existing mmap_sem related rwsem calls into a new
mmap locking API. There are two justifications for the new API:

- At first, it provides an easy hooking point to instrument mmap_sem
  locking latencies independently of any other rwsems.

- In the future, it may be a starting point for replacing the rwsem
  implementation with a different one, such as range locks.

Signed-off-by: Michel Lespinasse <walken@google.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h        |  1 +
 include/linux/mmap_lock.h | 54 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 include/linux/mmap_lock.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5a323422d783..051ec782bdbb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -15,6 +15,7 @@
 #include <linux/atomic.h>
 #include <linux/debug_locks.h>
 #include <linux/mm_types.h>
+#include <linux/mmap_lock.h>
 #include <linux/range.h>
 #include <linux/pfn.h>
 #include <linux/percpu-refcount.h>
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
new file mode 100644
index 000000000000..97ac53b66052
--- /dev/null
+++ b/include/linux/mmap_lock.h
@@ -0,0 +1,54 @@
+#ifndef _LINUX_MMAP_LOCK_H
+#define _LINUX_MMAP_LOCK_H
+
+static inline void mmap_init_lock(struct mm_struct *mm)
+{
+	init_rwsem(&mm->mmap_sem);
+}
+
+static inline void mmap_write_lock(struct mm_struct *mm)
+{
+	down_write(&mm->mmap_sem);
+}
+
+static inline int mmap_write_lock_killable(struct mm_struct *mm)
+{
+	return down_write_killable(&mm->mmap_sem);
+}
+
+static inline bool mmap_write_trylock(struct mm_struct *mm)
+{
+	return down_write_trylock(&mm->mmap_sem) != 0;
+}
+
+static inline void mmap_write_unlock(struct mm_struct *mm)
+{
+	up_write(&mm->mmap_sem);
+}
+
+static inline void mmap_write_downgrade(struct mm_struct *mm)
+{
+	downgrade_write(&mm->mmap_sem);
+}
+
+static inline void mmap_read_lock(struct mm_struct *mm)
+{
+	down_read(&mm->mmap_sem);
+}
+
+static inline int mmap_read_lock_killable(struct mm_struct *mm)
+{
+	return down_read_killable(&mm->mmap_sem);
+}
+
+static inline bool mmap_read_trylock(struct mm_struct *mm)
+{
+	return down_read_trylock(&mm->mmap_sem) != 0;
+}
+
+static inline void mmap_read_unlock(struct mm_struct *mm)
+{
+	up_read(&mm->mmap_sem);
+}
+
+#endif /* _LINUX_MMAP_LOCK_H */
-- 
2.26.2.761.g0e0b3e54be-goog

