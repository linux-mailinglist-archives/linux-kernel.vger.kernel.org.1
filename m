Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21CA232A38
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 05:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgG3DCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 23:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgG3DCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 23:02:32 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEECDC0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 20:02:31 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id o2so11875765qvk.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 20:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QahY/9HMVaM3fXtDIHLh10tOlgXtwkItMDEdu9i8774=;
        b=f1TfqRn1SoO6CPLCa3CInrbLgwlMviXEm0dtWty03sFyhCYMhIFP4URm2bdiIRowPk
         t9mEek0Fu7zJEj1RzfVByOgHUpKs4s1tbhyAqGIR4SDZjHUqJ9DK+sJADyalWanDam6y
         Q8tTD0yesxeXCQgPoezTdbTQjS2phNDlOctiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QahY/9HMVaM3fXtDIHLh10tOlgXtwkItMDEdu9i8774=;
        b=g78/1f1lD82LajknMGR3DXKqVDbWIBGPl4IhsJBAQJUZUSF9lz+mPhwdZAr9pHkxkt
         heduQC5HIx8uhlGcDHPfdDYTsk2IIBmDDoOSsDRICZRpOZb2ziA9tEllV6g/IV+6lz2F
         045ChQFtsuYmk0npNb9HuGAZoB5PlBKjggvfD/K2QzNpdLcixoKsPeo1oTLqMmJBbQPy
         5f8vGMSQc86+agAQ79+w8kDJ/uxaRrdViFnro3qF1nuN3P4PdcrLvA1uoM/E/7pEUOX2
         VvsnG1XHnknhM/5/qN8Y3E+jNbWZZHZ0RUi28vGFt5QQvoSMViE31CnxPJxNIMfp45s8
         rnBQ==
X-Gm-Message-State: AOAM531tMT9l8tD3nsRTwMnfioRpofSgcMhLWgScduJDCry/Knp2ZYPQ
        aQ1XrxQbOC/aP/GyUATWgFX3PpNa33g=
X-Google-Smtp-Source: ABdhPJwU11T0hSFJFM8Lfqmv1ZiKG9hcF33D0qVnmJJ8eB+zH8kZCgnZke55bteVffYCb6CKulUGeA==
X-Received: by 2002:a05:6214:1709:: with SMTP id db9mr964563qvb.142.1596078150702;
        Wed, 29 Jul 2020 20:02:30 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id f7sm3122044qkj.32.2020.07.29.20.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 20:02:30 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/2] rcu/tree: Add a warning if CPU being onlined did not report QS already
Date:   Wed, 29 Jul 2020 23:02:20 -0400
Message-Id: <20200730030221.705255-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
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
index 65e1b5e92319..1e51962b565b 100644
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
+	 * fire. Let us make the rules for reporting QS for an offline CPUs
+	 * more explicit. The CPU onlining path does not need to report QS for
+	 * an offline CPU. Either the QS should have reported during CPU
+	 * offlining, or during rcu_gp_init() if it detected a race with either
+	 * CPU offlining or task unblocking on previously offlined CPUs. Note
+	 * that the FQS loop also does not report QS for an offline CPU any
+	 * longer (unless it splats due to an offline CPU blocking the GP for
+	 * too long).
+	 */
+	if (WARN_ON_ONCE(rnp->qsmask & mask)) { /* RCU waiting on incoming CPU? */
 		rcu_disable_urgency_upon_qs(rdp);
 		/* Report QS -after- changing ->qsmaskinitnext! */
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
-- 
2.28.0.rc0.142.g3c755180ce-goog

