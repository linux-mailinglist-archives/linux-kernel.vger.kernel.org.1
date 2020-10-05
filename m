Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9E0282EC4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 04:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgJECLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 22:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgJECLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 22:11:43 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC14C0613E9
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 19:11:43 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s7so4541354qkh.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 19:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Wo+VVS05SJfb/lGrce8kONJ0+ZjW+Qw+ub5hCYDws8=;
        b=flyFCTjcoKiGY8teOGCLQEtCmmdwZqrCG8CtbKxKXz3X0oDtteVryqGhKg5Sc+zL0o
         /b2u1bIe73bfY2JydNKMWRIJZS/h3ftO7VoiSE2MCQP8WZaVBL7EBH+De9Igj1miojgU
         +Lx/+tCy3ayuo3eSmDh3b1psuoTQylb2H2PtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Wo+VVS05SJfb/lGrce8kONJ0+ZjW+Qw+ub5hCYDws8=;
        b=JImrfYoSrp+HRgB5wxlBCRGJYZF5GVog9gZS5l4R9jI4a8q6e1P6svzTmcfcSCa/ST
         Ekt87HkEy/ZWw7rpqq/NS4Xqle1DK6KcGuF2/lhVxlCwqxtMk+jqAby6q5CsaLpcqJ09
         Ss8WIY7YZSte5JbwfIMlspOtg1c4gDrtB8wdfUwqCdICe5048+18zuoYwqEuUO6T3Q0j
         pJZtYULPGvuraktUp+cmrFrQGqZ5SLNPdul4hjEcs4cuO9efzWKIXwKrrSTeOBDPFGEO
         +6yMmaipPp8RbwHh5ou/T+hAV6mcaVUsgqqycpYyUtCn9V9pIWAoM/CdEQOsbJqBmKa7
         i+2A==
X-Gm-Message-State: AOAM533kqLsu65sFRmODlaIWaT94ZdtGnpwqH+pDvTHEChFkKN1zoxjz
        2ijLzvtKQSxj8ECoJ1+RB8N7KtL9cZVq/w==
X-Google-Smtp-Source: ABdhPJxSYUxdXA8c+v9vtX3ccMync1CwApLKme6U2VSGJmwmzBD0aNk7VP4qCkNytZoM2buox9TvUQ==
X-Received: by 2002:a37:af02:: with SMTP id y2mr12513717qke.346.1601863902188;
        Sun, 04 Oct 2020 19:11:42 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d129sm2705207qkg.127.2020.10.04.19.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 19:11:41 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        neeraju@codeaurora.org, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2] rcu/tree: nocb: Avoid raising softirq when there are ready to execute CBs
Date:   Sun,  4 Oct 2020 22:11:32 -0400
Message-Id: <20201005021132.146534-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During testing, I see it is possible that rcu_pending() returns 1 when
offloaded callbacks are ready to execute thus raising the RCU softirq.

However, softirq does not execute offloaded callbacks. They are executed in a
kthread which is awakened independent of the softirq.

This commit therefore avoids raising the softirq in the first place. That's
probably a good thing considering that the purpose of callback offloading is to
reduce softirq activity.

Passed 30 minute tests of TREE01 through TREE09 each.

On TREE08, I notice that there is atmost 150us from when the softirq was
NOT raised when ready cbs were present, to when the ready callbacks were
invoked by the rcuop thread. This also further confirms that there is no
need to raise the softirq for ready cbs in the first place.

Cc: neeraju@codeaurora.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---

v1->v2: Also cleaned up another test of the nocb configuration macro.

 kernel/rcu/tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f78ee759af9c..2b1e1b21db92 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3652,13 +3652,13 @@ static int rcu_pending(int user)
 		return 1;
 
 	/* Does this CPU have callbacks ready to invoke? */
-	if (rcu_segcblist_ready_cbs(&rdp->cblist))
+	if (!rcu_segcblist_is_offloaded(&rdp->cblist) &&
+	    rcu_segcblist_ready_cbs(&rdp->cblist))
 		return 1;
 
 	/* Has RCU gone idle with this CPU needing another grace period? */
 	if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
-	    (!IS_ENABLED(CONFIG_RCU_NOCB_CPU) ||
-	     !rcu_segcblist_is_offloaded(&rdp->cblist)) &&
+	    (!rcu_segcblist_is_offloaded(&rdp->cblist)) &&
 	    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
 		return 1;
 
-- 
2.28.0.806.g8561365e88-goog
