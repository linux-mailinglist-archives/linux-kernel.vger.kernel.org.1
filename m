Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294F529DB4F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389245AbgJ1Xsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387852AbgJ1WrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:47:14 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6966FC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:47:14 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id x7so1151503ili.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sLx58vhNmLq+EFy2FlcUubbzsOTaAnkslh9sh0qutO4=;
        b=A+MTF58zSFVG6nT6ySbF31/8fNhQjzNKhi3JTlIlunbnEgTBLIYnJit0Yu1Oyy+lce
         okVbg0pCeCBaswyyx3oUu6FTGDFOTx5QjqLhM/w+hA6ASCiNrkugQ7hJPm/MVcP9/7PG
         j25ouO93ryR/qvcOKt6/tCk6tcvTBHhU4CsoN2551cVk786wdITjt6anRMPUpuBMXeaK
         AqwOMFT/yqOzGKXz0B6UKL+QQobQPd4eEQojFxMuM3o6VM1CNnSULrVWrb1SGrYppUeZ
         B2TEKhS/mTXGCRR6RL6IOZ4imw0cotwEZRpUDydZ5dyLFts6DXxUgUC1slMAzjYEU8Bj
         W92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sLx58vhNmLq+EFy2FlcUubbzsOTaAnkslh9sh0qutO4=;
        b=oI/E1jAUG8XsGvGTkRG1OVuOda5CG+AJ4v9GvSx/RESEyRrY4apQ0hWB5G21A/yo29
         GSlH5qTDeZ6ABOPpi9UUzSvEZKZvMVbrMMILjPeS5wuGWxKHeJeLiI+mYK22OEICxbAJ
         FFl358a6S8qtULToj+UEMpn8X1Gxj/+7MPZ0tdUAPF6dfAp2t9Zt7NmNySQXjS51m+kk
         wvSJkn+2V5Oljh3IIvGo8yy/an3CxfdaVAUQB6phQ6TuL/ih/F9/fdoF92P7+Ie+egle
         DW/H3oEUIkGF1W99MVJSVQFul8NrzeMcRtelrQRvyKaAkRu3G/9S8Xfyh+HWcUmVH90s
         AhOA==
X-Gm-Message-State: AOAM5315KBIIsIHmHOlWeXCEByMfiuOgaqow4y00ruGrOElTUWkZDrnq
        EN57x5zPV0n05fRfba/og4OvE2gP3IJ+/6D5
X-Google-Smtp-Source: ABdhPJx6KGpdfeX0iCzpdcEAInTzW0McwKJysWzrt733ogN1ko9wOAlrEfW+1LcNjTQ1ZSDs6UtDLg==
X-Received: by 2002:a63:ab45:: with SMTP id k5mr6138549pgp.240.1603887651169;
        Wed, 28 Oct 2020 05:20:51 -0700 (PDT)
Received: from Monkey.fios-router.home ([47.144.162.13])
        by smtp.gmail.com with ESMTPSA id a143sm6329137pfd.138.2020.10.28.05.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 05:20:50 -0700 (PDT)
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
Subject: [PATCH 6/8] sched: Remove unneeded braces
Date:   Wed, 28 Oct 2020 05:19:15 -0700
Message-Id: <20201028121917.635203-7-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028121917.635203-1-jbwyatt4@gmail.com>
References: <20201028121917.635203-1-jbwyatt4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded braces and the spaces for the bottom brace to silence
checkpatch warnings.

Issue reported by checkpatch.

Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 61758b5478d8..7bf20110fdf5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3588,9 +3588,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	if (current->core_task_cookie) {
 
 		/* If it is not CLONE_THREAD fork, assign a unique per-task tag. */
-		if (!(clone_flags & CLONE_THREAD)) {
+		if (!(clone_flags & CLONE_THREAD))
 			return sched_core_share_tasks(p, p);
-               }
+
 		/* Otherwise share the parent's per-task tag. */
 		return sched_core_share_tasks(p, current);
 	}
-- 
2.28.0

