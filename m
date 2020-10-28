Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2C729D793
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbgJ1WZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732875AbgJ1WZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:25:22 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB055C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:25:21 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r10so670076pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eJ1V3tCuvn8ST7G3ZcYlk0W7nK8w2D1rXN+h7L0y6o8=;
        b=h0iXQ0l4q0nPJDq670JnQ4J+ClH6f1b3TyMH15um0jeipZnwzH6FAxcHL0KNlkoR0z
         1XEQo6VEg9YtFHx36dMW8/wxAk8xceMPCpqKy+lnnHarmbEBeiMb3Wsc94XR5T9eK1eq
         qWMiGjMDqi0ZCuLZ1qImxHoSwu6iNWiTuInfMoURETZnqzyDtw+51RSn9zpDJ18PIdRc
         PSb3m54nlR9sbRwDYmqW8hJX0AiwT8lis/hhVYbVXCouqgXlXrcWF1hHI/bvl1DHrSr2
         bloOyecvj2VexbvcV6Q6QYIWBPPiurzqVbUhMuQFdbS43ZRkf/YF+LzngKWDVNkNB2UK
         kGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eJ1V3tCuvn8ST7G3ZcYlk0W7nK8w2D1rXN+h7L0y6o8=;
        b=YciCjx1xHo2fGyT2F4EyQQXF4jNw6DiL/kxXMC6m/N5VdrwDRBL53L1mwF6d/refRb
         G0tan5M9xr8lg4ZHUH9GU1whc5mu04xGn4JZ3/ihZDoxOfSp5bbD57ukXa+p7pVG2C4P
         LyO8JZlcSBVyoh7bKbBW0QOFkMifDYmBgMDZ2yvmHJ2NaRyoU08bnQ7ES5g+/PGAwfNB
         6qHm8VJhrhQlviIxsFt9icAUBbXWNt8GuJbKYX1fXl5ksY30liwq4zToFAoqScTWa4jd
         2jvttTMrxHYAWK9nepv8vXfj30s0Ruw0wTJOob5DVe+/ZGNOdqaNTnXHZvtThk7ptKc9
         DEjQ==
X-Gm-Message-State: AOAM531lt5al0aG07WXwfIyyhWNTEdQLL3XcnghxHYyf199x1W05sqyP
        uBPbZlDvo6QAVANorZr5sgf9BceOflCiEVXm
X-Google-Smtp-Source: ABdhPJyQOSjWPETHJYgKo9xwEd+On/Dtv0xlpcTUKQEEdwWbiUI8Bb1NGLpdzTBpnCOVpxyI4WKKDA==
X-Received: by 2002:a62:32c5:0:b029:158:7361:58d3 with SMTP id y188-20020a6232c50000b0290158736158d3mr7218608pfy.75.1603887637676;
        Wed, 28 Oct 2020 05:20:37 -0700 (PDT)
Received: from Monkey.fios-router.home ([47.144.162.13])
        by smtp.gmail.com with ESMTPSA id a143sm6329137pfd.138.2020.10.28.05.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 05:20:37 -0700 (PDT)
From:   "John B. Wyatt IV" <jbwyatt4@gmail.com>
To:     "' Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
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
        chris.hyser@oracle.com, Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen ' <tim.c.chen@intel.com>
Cc:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Subject: [PATCH 1/8] sched: Correct misspellings in core-scheduling.rst
Date:   Wed, 28 Oct 2020 05:19:10 -0700
Message-Id: <20201028121917.635203-2-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028121917.635203-1-jbwyatt4@gmail.com>
References: <20201028121917.635203-1-jbwyatt4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'priorty', 'guarenteed', 'guarentee' should be: priority, guaranteed,
guarantee.

Issue reported by checkpatch.

Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
 Documentation/admin-guide/hw-vuln/core-scheduling.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
index eacafbb8fa3f..638d0f3c1c09 100644
--- a/Documentation/admin-guide/hw-vuln/core-scheduling.rst
+++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
@@ -161,7 +161,7 @@ priority task is not trusted with respect to the core wide highest priority
 task.  If a sibling does not have a trusted task to run, it will be forced idle
 by the scheduler(idle thread is scheduled to run).
 
-When the highest priorty task is selected to run, a reschedule-IPI is sent to
+When the highest priority task is selected to run, a reschedule-IPI is sent to
 the sibling to force it into idle. This results in 4 cases which need to be
 considered depending on whether a VM or a regular usermode process was running
 on either HT::
@@ -223,9 +223,9 @@ Also this does nothing about syscall entries.
 3. Kernel Address Space Isolation
 #################################
 System calls could run in a much restricted address space which is
-guarenteed not to leak any sensitive data. There are practical limitation in
+guaranteed not to leak any sensitive data. There are practical limitation in
 implementing this - the main concern being how to decide on an address space
-that is guarenteed to not have any sensitive data.
+that is guaranteed to not have any sensitive data.
 
 4. Limited cookie-based protection
 ##################################
@@ -251,7 +251,7 @@ outside. Tasks outside the group also don't trust tasks within.
 
 Limitations
 -----------
-Core scheduling tries to guarentee that only trusted tasks run concurrently on a
+Core scheduling tries to guarantee that only trusted tasks run concurrently on a
 core. But there could be small window of time during which untrusted tasks run
 concurrently or kernel could be running concurrently with a task not trusted by
 kernel.
-- 
2.28.0

