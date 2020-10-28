Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57BC29DB39
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388119AbgJ1XqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgJ1Xp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:45:56 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84860C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:45:56 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id f7so1431061oib.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p7ntHaHHOHrtggdb+F7Ufp0GAHOrhmhBnRrIBUPbXhk=;
        b=ev+XrUr0qiMTSh/ogxszH3mrbBkVB2ZcRUdzqG4tl6t+ACwmRwdOaVxpzhdz/JVM3c
         9c72OOjTQo/uchJXzQXrPirJ62yBqpnz+gnaV624ZyOJ4XHEArFS0ZNquiGoGxzO/rLq
         44+FsnHPp+Vv1Bov+OB6fCqg/VUgLPmDCfUeL16vhpkLBWNOBrDQq8dCi9kk2p0f1Nh1
         uc7PFXCIjAbkh9YG5/FZw/7fQ1po9cIroKzjV4efe3CsJq/wTSAqGJ0y9Zly2jptHFt2
         7QncknEvYmCVrnVFuudoG+VtizDw8eZhsCH9N8IpPfLAYoZQpdM/vmMrW+62n+lIIBLA
         cXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p7ntHaHHOHrtggdb+F7Ufp0GAHOrhmhBnRrIBUPbXhk=;
        b=INbxH2VC1WHx3aBZp0+zuzwi/OB5+IEaxm7HJxLvoDzm9VJUnBDbR7w/a7k9R2bryo
         OKOHQb4X0I1wNtXlRE4UjN17Kc3W1dD3nCw9gPInwbbn9SyiVHj6QrBPRHg4Mzd2x4wS
         XxFjOdvuQGqBxsQyflgHfobCFk+TR2ZVipOSzNo9bs75Z+KovKsxdj2/IaPZYpezjtGe
         25ODFOGaVdlgrNGNY1fsKNTAvl2aPw1CXQtmbNRgp2r9gsgVsPKG0NfcsaEsThjP0+uS
         Z02qKDP22g7D4G+nVxr3jXQbrgVeVhez138HNFW6rvsItzqFmXqaksxhzt0D3tjtujnt
         +05w==
X-Gm-Message-State: AOAM532NJZjzqu4KD+UiEdjeeJCARKK0B0iJT3usC4awz/6fWL/6gzWy
        l7DhitPv5bqWZ4pl4eLOx8RipGppkxIVmVPt
X-Google-Smtp-Source: ABdhPJzJLEEdVOdAJbzeZFkWpiGRDBvm/qlDQFnn98sJfb2o7rmHDtKAAx4A/4U2kShok2rVhESyLw==
X-Received: by 2002:a17:90a:4a95:: with SMTP id f21mr6012711pjh.223.1603887648448;
        Wed, 28 Oct 2020 05:20:48 -0700 (PDT)
Received: from Monkey.fios-router.home ([47.144.162.13])
        by smtp.gmail.com with ESMTPSA id a143sm6329137pfd.138.2020.10.28.05.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 05:20:47 -0700 (PDT)
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
Subject: [PATCH 5/8] sched: Add newline after declaration
Date:   Wed, 28 Oct 2020 05:19:14 -0700
Message-Id: <20201028121917.635203-6-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028121917.635203-1-jbwyatt4@gmail.com>
References: <20201028121917.635203-1-jbwyatt4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silences checkpatch warning.

Issue reported by checkpatch.

Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
 kernel/sched/coretag.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/coretag.c b/kernel/sched/coretag.c
index 11139dbed648..6d17d11cb46f 100644
--- a/kernel/sched/coretag.c
+++ b/kernel/sched/coretag.c
@@ -287,6 +287,7 @@ unsigned long cpu_core_get_group_cookie(struct task_group *tg)
 
 		if (tg->core_tagged) {
 			unsigned long cookie = ((unsigned long)tg << 8) | color;
+
 			cookie &= SCHED_CORE_GROUP_COOKIE_MASK;
 			return cookie;
 		}
-- 
2.28.0

