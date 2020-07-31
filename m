Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D15233C9E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 02:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbgGaAk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 20:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730892AbgGaAkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 20:40:25 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9C1C061575
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 17:40:25 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v22so15911715qtq.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 17:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IGvz6KgcHCmjoeuiCEDc9k+DvB64Lvr2o1q6GMYOtdM=;
        b=ThWhSyzmYSzoj55OO1cqOh4Z0b/5GIVOMHygYBrkz1ZgXi/T0KKcIXC/4XiP+tt/Ph
         8igXt3d5AbwIuXrIjE959nglAl+jMZF3dRnnLK7UhAF2VC8lNvjy3O9Q2jvW3xslGgBq
         rMnQpmWSwu7+BWsJuLtTkXW1Sij0M6X3Iuldg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IGvz6KgcHCmjoeuiCEDc9k+DvB64Lvr2o1q6GMYOtdM=;
        b=dfvlPtFz/zpUbzX1OPlK1Av5fhyIhinxd8yTopEQrxH0tIXLCIcM/lJ6bHImimHQYv
         Q83j7ln0Wll8w9+HDu1MqkwSv/IqC1uZkdLKM2Tz6OhNqKL4N0+PVQpxeo5ZXEPUjhUZ
         FK9csKVZM4bxL+uf0NvYVPLUOkw1irouQ5mbLySBmbl9oLMby7fPqazzTGC05moArwhq
         7MUBuqmBGPm2du1ERuUcl1oYs4W3Br9osoNPwSxNFIkLW32JTAgKhCfkjZlQwhgxrxR9
         Rv2gm1qRGb2BuKgySGI5Ve2e7H/kMu9dfdP7PLKlPv7TfG6mnYpQUVLpy26HFM5uR1IK
         Qrew==
X-Gm-Message-State: AOAM530PA47YX54t6cQeECvpCIOOF8gqMCqCoBABo9lQ32rnUKfD4gSO
        B18ESBfOxaoKuE8bCgugM+eiOdc2aFc=
X-Google-Smtp-Source: ABdhPJxitlKAKPUXjYHxM+04anYH6TpoXdjAIhxnrCPfFfio6hSv9F8Z+0kSzfIRsGuhCKL9PfL5pw==
X-Received: by 2002:ac8:6713:: with SMTP id e19mr1367740qtp.88.1596156024251;
        Thu, 30 Jul 2020 17:40:24 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id c5sm3077320qtp.62.2020.07.30.17.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 17:40:23 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 1/3] rcu/tree: Add a warning if CPU being onlined did not report QS already
Date:   Thu, 30 Jul 2020 20:40:10 -0400
Message-Id: <20200731004012.2324147-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a warning if CPU being onlined did not report QS already. This is to
simplify the code in the CPU onlining path and also to make clear about
where QS is reported. The act of QS reporting in CPU onlining path is
is likely unnecessary as shown by code reading and testing with
rcutorture's TREE03 and hotplug parameters.

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 kernel/rcu/tree.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 65e1b5e92319..6b6fc28bb670 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3996,7 +3996,19 @@ void rcu_cpu_starting(unsigned int cpu)
 	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
 	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
 	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
-	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
+
+	/*
+	 * Delete QS reporting from here, by June 2021, if warning does not
+	 * fire, in order to make the rules for reporting QS for an offline CPUs
+	 * more clear. The CPU onlining path does not need to report QS for
+	 * an offline CPU. Either the QS should have reported during CPU
+	 * offlining, or during rcu_gp_init() if it detected a race with either
+	 * CPU offlining or task unblocking on previously offlined CPUs. Note
+	 * that to avoid hotplug notifier deadlocks,the FQS loop also does not
+	 * report QS for an offline CPU any longer (unless it splats due to an
+	 * offline CPU blocking the GP for too long).
+	 */
+	if (WARN_ON_ONCE(rnp->qsmask & mask)) { /* RCU waiting on incoming CPU? */
 		rcu_disable_urgency_upon_qs(rdp);
 		/* Report QS -after- changing ->qsmaskinitnext! */
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
-- 
2.28.0.163.g6104cc2f0b6-goog

