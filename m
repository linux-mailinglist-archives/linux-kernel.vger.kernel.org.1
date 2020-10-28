Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE4A29DA65
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390208AbgJ1XVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbgJ1XTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:19:42 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04046C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:19:42 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w65so751613pfd.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xg57KUmN634wOly6nL89XU9gsH2m48A0iDZqjX+5yQs=;
        b=VzO+KbtFvhZFihPl+Fk9WG+YxUuVglZBNm15uHZgP4kEtHAHfFjv/mga4cJKMFsy1D
         nIBFcneZYZjp12Pth+qzWgacdGE6PonY0QzyMYkKQjeq67AQSG5ffr64NamRKo/eXcv3
         4o8RMD+rOVNqhef6fbJsE29sVFupnPWUsnpAdd/RD6+uG1YEJjtz7GN6+js1PUIQ2B8k
         RsQGHFzgg39LGQYxDv9i6f9B6s8HDbC/pWlB4nGr4GUdOiPUUaffpFcjxwkZf2EfdenL
         Etgd/kFbA+J2SVHDBrD4mKHrGKsCJnl+eBLdVqqkvLuKScESgSvCaPT0kBrccUezwVYd
         1H6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xg57KUmN634wOly6nL89XU9gsH2m48A0iDZqjX+5yQs=;
        b=PcTksBhiTBT8H8J5EMQPdsd7dHW+nAJHMZbJp6Qu93U6AXzP6pNSHd2V5WP6fog/Yo
         r8m8XeC4kkN5velB17Y9GybPyb35/a5MUP0l1DQ7YIECyId+pY9ZIAQdaeaKJ8lCKRb8
         /jutaueQOexahxSNiM8NCzhWSyca3GPhYP3vK3JwxmEzPiG7do4lAlPjHdIOEsM5hjEN
         HBT4n4hjkwXKvIMt/f/x30jaYjEbi8Z1AchkeNE7KCAqulS0QsAwNHQGj2M4t5yHBWgH
         XawxRHx8rj7/tKtuwDTRFLULC+5ijWfGJpWRFy6KxCPOOd39aUYv1W4ARpejNXpTADE6
         Zr9A==
X-Gm-Message-State: AOAM530j0e6JO2iEKcjkYzLhgE/IKrxwDwPwVV/oSBxr8k13MwFBvhGE
        vpJuCfMNdofh1Ych2OgfYmxTERTj6XItJ9gK
X-Google-Smtp-Source: ABdhPJw0j7PoPu4pgeSAV+hnCESE+7s9TazchA9vHW2bC/BTkL2Eo+uzdv7kK82qQsSKxBi4EKxUdg==
X-Received: by 2002:a17:902:8c8b:b029:d2:42fe:370a with SMTP id t11-20020a1709028c8bb02900d242fe370amr7033341plo.83.1603887634931;
        Wed, 28 Oct 2020 05:20:34 -0700 (PDT)
Received: from Monkey.fios-router.home ([47.144.162.13])
        by smtp.gmail.com with ESMTPSA id a143sm6329137pfd.138.2020.10.28.05.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 05:20:34 -0700 (PDT)
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
Subject: [PATCH 0/8] Style and small fixes for core-scheduling
Date:   Wed, 28 Oct 2020 05:19:09 -0700
Message-Id: <20201028121917.635203-1-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patchset of style and small fixes for the 8th iteration of the
Core-Scheduling feature.

Style fixes include changing spaces to tabs, inserting new lines before
declarations, removing unused braces, and spelling.

Two small fixes involving changing a main() to main(void) and removing an
unused 'else'.

All issues were reported by checkpatch.

I am a new Linux kernel developer interning with the Outreachy project.

Please feel free to advise on any corrections or improvements that can be
made.

John B. Wyatt IV (8):
  sched: Correct misspellings in core-scheduling.rst
  sched: Fix bad function definition
  sched: Fix some style issues in test_coresched.c
  sched: Remove unused else
  sched: Add newline after declaration
  sched: Remove unneeded braces
  sched: Replace spaces with tabs
  sched: Add newlines after declarations

 Documentation/admin-guide/hw-vuln/core-scheduling.rst | 8 ++++----
 arch/x86/include/asm/thread_info.h                    | 4 ++--
 kernel/sched/core.c                                   | 6 ++++--
 kernel/sched/coretag.c                                | 3 ++-
 tools/testing/selftests/sched/test_coresched.c        | 8 ++++----
 5 files changed, 16 insertions(+), 13 deletions(-)

-- 
2.28.0

