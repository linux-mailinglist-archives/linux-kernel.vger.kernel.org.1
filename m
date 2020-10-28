Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F3429D2F4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbgJ1VkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbgJ1Vjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:39:47 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98A9C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:39:46 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id e3so383153vsr.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CnGd0myaGbrgCsckEbhxfAYv+vOjDrh9eSSRfyxpk2I=;
        b=c2yfBekdm6PlkIPU7fgQMYHaICdliVF4WCcOVe9eK+JjB4GxYMiWaHeEX8dcq6vBG0
         rKZ+0OzoEN0HL/qbvLEXmh/axfVlKsnfhqFbV7FqsP37QJG26JS7byOvmjc+4W33402B
         q7dW/p6i8yiRrGPF238aGpIid4A05Z9z1BZ/It9LoHjRqIf10+JRQBFgcAzdpFKxte+/
         d7x2V8OoITjpTLSbYy1GtjrfXUnTa370JZ4u3iLr/QZAjBB4iTTqRh7zTCD++yFo2zgK
         xkvvk1MDMavsIN1OMfi4s1NwRmaitx6Y+bvpTEZlr3WZZMeO9or2Bp5emk9OnZdNJZBA
         KzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CnGd0myaGbrgCsckEbhxfAYv+vOjDrh9eSSRfyxpk2I=;
        b=TZjxiD/EMBEhBi8uLjouK1AqAYLf1tnRForvw1jx/bUHFrxJqsHzLD5/sTkLqX5nnc
         Q3qEjDj16Vt4OPd2s42+MVR3LDe5sp6UWpIHlSKoutJ2voPCN/+PhXGshK+RTv1GAr9y
         WGOmA9vC2iMUqpL/6l0CcmzuTfMOKFRc9EortfeQ1WASeVZ3T/MGBJCrXTa5o5nPjB2g
         oqI0AhdXhUbtKAcqSyzotbObM7YlpP8Ztic0zv2eZ3fA+z1HT3lWqvfoXwtZj0Vbfa/U
         UHarjBp3lL1MWwviqxe4632Kftt2TRQHzMpVPmmzdVurUX0H0e8HTxDMk/ls9bBYQGT4
         7ipQ==
X-Gm-Message-State: AOAM532bXp/eJ3yaFC3KHqsJZhWxZW8cjtAmt4WobsHJBcTYZKkIjUOJ
        I8u41ZMZRnbVOabcO4SzPvwbvd5fc1imXp+u
X-Google-Smtp-Source: ABdhPJx0ZEbc59P22w/IWoDfPC81ya5y4VjSU5yhWH21ZL+g+Jsh6+mKF6ExAhxIGweGK7qalmv/PQ==
X-Received: by 2002:a17:902:6bc4:b029:d5:ef85:1a63 with SMTP id m4-20020a1709026bc4b02900d5ef851a63mr6985982plt.73.1603887653906;
        Wed, 28 Oct 2020 05:20:53 -0700 (PDT)
Received: from Monkey.fios-router.home ([47.144.162.13])
        by smtp.gmail.com with ESMTPSA id a143sm6329137pfd.138.2020.10.28.05.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 05:20:53 -0700 (PDT)
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
Subject: [PATCH 7/8] sched: Replace spaces with tabs
Date:   Wed, 28 Oct 2020 05:19:16 -0700
Message-Id: <20201028121917.635203-8-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028121917.635203-1-jbwyatt4@gmail.com>
References: <20201028121917.635203-1-jbwyatt4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matches the convention of the surrounding code.

Issue reported by checkpatch.

Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
 arch/x86/include/asm/thread_info.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 45b6dbdf116e..c29b62ff7701 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -99,7 +99,7 @@ struct thread_info {
 #define TIF_SPEC_FORCE_UPDATE	23	/* Force speculation MSR update in context switch */
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
-#define TIF_UNSAFE_RET   	26	/* On return to process/guest, perform safety checks. */
+#define TIF_UNSAFE_RET		26	/* On return to process/guest, perform safety checks. */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
 #define TIF_SYSCALL_TRACEPOINT	28	/* syscall tracepoint instrumentation */
 #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
@@ -130,7 +130,7 @@ struct thread_info {
 #define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
 #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
-#define _TIF_UNSAFE_RET 	(1 << TIF_UNSAFE_RET)
+#define _TIF_UNSAFE_RET		(1 << TIF_UNSAFE_RET)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_ADDR32		(1 << TIF_ADDR32)
-- 
2.28.0

