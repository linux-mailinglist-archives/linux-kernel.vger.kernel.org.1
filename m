Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E302B7224
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgKQXUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbgKQXUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:20:36 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D364C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:36 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id v143so42468qkb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VPSOzxBuhrqOGihjbHgtv0qjD3UKBL0IUmAQYIlYK+c=;
        b=l9QxaTKdQwQA7Cl33JZIoIYsAumSeADU95QBkUMbq5wPzXh+6UQlr5FQ1sKxPHJ0N0
         f8VeKa+bTbQpkNOK4a7xcwuNYxGPPZHC2V4JvPn3kZiRRkhGIrnhh1Gw5GAMBas9weOG
         Y7K91HrDAqcGY016lYfXWW8sqEwswbaJr4n8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VPSOzxBuhrqOGihjbHgtv0qjD3UKBL0IUmAQYIlYK+c=;
        b=Sxn5ddHRDpsLHzt2iTrxRu9sV/AwPBwFU/yOkb40IdcCUxeLnRmPevLne0lhcDuZ9c
         qN+dDpoAx+jr8j/tl1M2IZb4Q+r/Oei/APBdemugZ/cYJBECYLe50hdJT+8oPALb7Btm
         ybcVo+YGns0W5qaZk3/gREWADQYLzYJ8IVoieOVg5pfRqExnGYKLf8DHqEon6mslsZfn
         GLqMxQriYIcaQCvf8nMyQTpVNJXCH7rIRpyBuU7Y3SENwFtEDaQwDfOv4rUNQrE1EO2Q
         EX8j9S3f/Qx9PXzfYJ5uDjoNmx5wdP9UST/igAL8xBlx6nNTzMqoBxaqUl2Fg+x4EWRV
         jJdg==
X-Gm-Message-State: AOAM531lbFGAthGNsr9UMfye3F4QU0EqZUjSyMNC61ndXgB4/Fm8J6ZY
        lH27/335PTeI8CpWoOocVtXRHQ==
X-Google-Smtp-Source: ABdhPJxIWErcjom4Cb5wck7QOzNI/jSgxRJJ8VGbZOeOXtr/Lm+ZEFXry60Dq5Ikiuiirh2+Mnz71Q==
X-Received: by 2002:a05:620a:148d:: with SMTP id w13mr2002772qkj.299.1605655235375;
        Tue, 17 Nov 2020 15:20:35 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:20:34 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH -tip 11/32] sched: Enqueue task into core queue only after vruntime is updated
Date:   Tue, 17 Nov 2020 18:19:41 -0500
Message-Id: <20201117232003.3580179-12-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A waking task may have its vruntime adjusted. However, the code right
now puts it into the core queue without the adjustment. This means the
core queue may have a task with incorrect vruntime, potentially a very
long one. This may cause a task to get artificially boosted during
picking.

Fix it by enqueuing into the core queue only after the class-specific
enqueue callback has been called. This ensures that for CFS tasks, the
updated vruntime value is used when enqueuing the task into the core
rbtree.

Reviewed-by: Vineeth Pillai <viremana@linux.microsoft.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 53af817740c0..6aa76de55ef2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1753,9 +1753,6 @@ static inline void init_uclamp(void) { }
 
 static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (sched_core_enabled(rq))
-		sched_core_enqueue(rq, p);
-
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
@@ -1766,6 +1763,9 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 
 	uclamp_rq_inc(rq, p);
 	p->sched_class->enqueue_task(rq, p, flags);
+
+	if (sched_core_enabled(rq))
+		sched_core_enqueue(rq, p);
 }
 
 static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
-- 
2.29.2.299.gdc1121823c-goog

