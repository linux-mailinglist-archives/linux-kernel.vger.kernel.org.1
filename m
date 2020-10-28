Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1632C29DB9E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390294AbgJ2AHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731614AbgJ2AHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:07:21 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF90C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:07:20 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id v18so1354874ilg.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k2CwR8ggCRj6gUkZT+xqJS/dAer7jwXLMOKWPbtQ2WM=;
        b=SsYKHEbGb1isOsxn5Kyw/oAnoU7YkkwpphGqld5TodbUsr9Sdg/BMQOPQtnavpxViz
         zEokObyVY8zXwcqkzpqKuc5KNukjZk1vxC1n0RN5jmKdvGVbs9MvIb5rEmKEwbU2CZNJ
         o4u6lp/Jk7bdPGJu/TxyiS3JTjYcYDDMkN0CrKxCNhPeFPSKS8CFrmwVNTD5GiidEhH5
         5MZDiOla5lhLp4y/zw/EnbKBV9NlmQorTWUQRPBvdwnkrUMJeHC/RBmsqYgqHFj1zNJe
         SY/Exp1aLfgCE7K7ZOfPLoFQnIezdUCS2trqqd8pMYaWWN8dk253JIu5DxbRTWr4+rRU
         MyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k2CwR8ggCRj6gUkZT+xqJS/dAer7jwXLMOKWPbtQ2WM=;
        b=HDX4QrARiF7pRpMdIrBc196t6m4UtFOXe+lWWKB7dfUE2+UKGJzqzr/p3HZPdfG/29
         6UupBIuGadRo1CDWVZxYlT0OtisacNki/depfY6w8NRFN0qWrbW7R4F4E+Dgc5QBA9st
         j3495xbnYD7TuarCeeCIGJJEw2U3kluWyaRpgc/i+TyxAyKmRrB2pjs82OS5BKQfZiI/
         mieg9IcUNGWclEQD8os2kqZWxLyq2rGYxkC2S9s0O/Z6Qdqx/DitWHiAzgAzfi8FojXP
         BfZUlQj6gxJmrlHsTxiy6XVgL7wK0tC4B8EjEqHG2ba/CrLVdsQNcCFlsPkMLElVLYLy
         OhQQ==
X-Gm-Message-State: AOAM5309rsdYviiLqPCwGV51v+4he4lqvQWmTeBnyMqDpURTF9HpZ0SA
        6fTaOsmGxyA5x3ah7mLcqB9dtTgRiSGokK+A
X-Google-Smtp-Source: ABdhPJyD8NFKCUgIZUuGUARXr+28hW419Ha6dTnrL3zjRQv0Xcb+wIxwMJFLS0wUFDuWBp350AX7gg==
X-Received: by 2002:a63:af4c:: with SMTP id s12mr6001553pgo.395.1603887645761;
        Wed, 28 Oct 2020 05:20:45 -0700 (PDT)
Received: from Monkey.fios-router.home ([47.144.162.13])
        by smtp.gmail.com with ESMTPSA id a143sm6329137pfd.138.2020.10.28.05.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 05:20:45 -0700 (PDT)
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
Subject: [PATCH 4/8] sched: Remove unused else
Date:   Wed, 28 Oct 2020 05:19:13 -0700
Message-Id: <20201028121917.635203-5-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028121917.635203-1-jbwyatt4@gmail.com>
References: <20201028121917.635203-1-jbwyatt4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silences suspect code warning.

Issue reported by checkpatch.

Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
 kernel/sched/coretag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/coretag.c b/kernel/sched/coretag.c
index 3333c9b0afc5..11139dbed648 100644
--- a/kernel/sched/coretag.c
+++ b/kernel/sched/coretag.c
@@ -146,7 +146,7 @@ int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
 		}
 		wr.tasks[0] = t1;
 		wr.cookies[0] = cookie;
-	} else
+	}
 	/*
 	 * 		t1		joining		t2
 	 * CASE 1:
-- 
2.28.0

