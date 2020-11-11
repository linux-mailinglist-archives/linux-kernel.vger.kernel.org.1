Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49E52AFA32
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 22:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgKKVKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 16:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgKKVKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 16:10:46 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841AEC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 13:10:44 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id ec16so1694897qvb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 13:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9R/Pa8NNo4ywGaBUbUuK+3FrXWVJKG/glnSDMHfk+R4=;
        b=SovQwhuwKEKB57uvFYyzOgNnioRQGluOrHKwP/8+Dp4aEJl2/Pk3m+CSyu3/vMC8Kc
         OyDX4LF4sSvsfsOouuuz6U7jSO1B5Nh14eAlmem1RmukHdcsNbGq0DueN+AiYu7xy991
         eEZGFAJLsmYStrxMrhnHwZJpdxN2GL2JHUZbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9R/Pa8NNo4ywGaBUbUuK+3FrXWVJKG/glnSDMHfk+R4=;
        b=NaHMNfckUB6DdZ4Z3rZqBm0mcSpAQY4PUKzxCFT9IIMAmq+KcEWGw54PfvFTEafiz+
         BIgfPN2MNsOlXca44z5o84FkYpacOL0U4SSs+ZWTK58Z+HCjmhhlcDlefcdXhg0s7ULH
         VBAUgEMrtkhYNUEKY7mO42Ar0HU6My6QGK00bCRBd8XvKxJyi5CyW7iKO5Ef+Z9g5wOx
         tEwaAm1chyV6VZwDWzqTrf6zo5BHvSnFSA1HnnsbhrQHAe43X/vmSdATFeZBt5sY97l3
         No+l/174HHpfSz8KyuLQdKQVbR/9fBVT/aoicFhhA0+Gbs2wAW0cFjDY8O9gR8Yd/odG
         opYA==
X-Gm-Message-State: AOAM531BYewcS4jmtqwTJGZJ/lzreWVH6huYgm/O56Hgcs6MCBkajx0M
        aPb3DevMLl4CgEgeifzF7+oB/w==
X-Google-Smtp-Source: ABdhPJzweHC+xrQqB3fgT6ZvYBHb2b4YzCN/eQV8auGy+GrlIciHvlXrhOHXdRJaTP7EZwg3jlKtkw==
X-Received: by 2002:a0c:a5a2:: with SMTP id z31mr27905708qvz.15.1605129043813;
        Wed, 11 Nov 2020 13:10:43 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d66sm2112389qke.132.2020.11.11.13.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 13:10:43 -0800 (PST)
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
        amistry@google.com, Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Mike Rapoport <rppt@kernel.org>,
        thomas.lendacky@amd.com, Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [RFC 2/2] sched/debug: Add debug information about whether coresched is enabled
Date:   Wed, 11 Nov 2020 16:10:11 -0500
Message-Id: <20201111211011.1381848-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
In-Reply-To: <20201111211011.1381848-1-joel@joelfernandes.org>
References: <20201111211011.1381848-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is useful to see whether coresched is enabled or not, especially in
devices that don't need it. Add information about the same to
/proc/sched_debug.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/debug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 88bf45267672..935b68be18cd 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -782,6 +782,10 @@ static void sched_debug_header(struct seq_file *m)
 		"sysctl_sched_tunable_scaling",
 		sysctl_sched_tunable_scaling,
 		sched_tunable_scaling_names[sysctl_sched_tunable_scaling]);
+#ifdef CONFIG_SCHED_CORE
+	SEQ_printf(m, "  .%-40s: %d\n", "core_sched_enabled",
+		   !!static_branch_likely(&__sched_core_enabled));
+#endif
 	SEQ_printf(m, "\n");
 }
 
-- 
2.29.2.222.g5d2a92d10f8-goog

