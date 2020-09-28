Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EB827AE20
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgI1Mqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgI1Mqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:46:40 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E8CC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 05:46:40 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id n10so581723qtv.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 05:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dbSiDedMj6Fi2FYAEkzpCM05qVLOKb0E2B69e7H8fn8=;
        b=TEKdCS8Dxi3PrABwVjZpWaEAS70Pbf9sgKwKP0IbyLaSRsiBQ6U3DRPSQ9YYx8UrYI
         3b4PiAXkBJDmaSXNL6H5E6k68j2iTaYCDj6E6a8oWULeBDCXdMcBjUkwDmZwLIolrbib
         J/2bbA9sjUn8ymiri3oABrQ4Kin+zyioWXMm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dbSiDedMj6Fi2FYAEkzpCM05qVLOKb0E2B69e7H8fn8=;
        b=V7Yyo5/iQJhxjpptZlbKXNw3cQMzvKaitUrOjwWNfo+Td1iHEfvGb8cCbcJy6KVaOi
         8p/GEqNy9keZj0jdVXBUi6J/l3ymkJe3diIvO7L0tAZwJRbKYe0LJtcOBPvkGFU/52Wg
         SCGzBvR+CywRBfEHXD6rC48QkzfMywSxHZCr2hLh6qnmtAizJ2YhlFyerSoegbwN6HYg
         vflQn7V/WpqXo9V7U/4TyoMFep9NWVLblYTvqlgTuN7Se+QzzwjeibLlXdmWw382C/r4
         gGpw7ebA6XtO3jXk0t9PbYi2UkLbTJkuZv+jI/cIe9f1Yiaajf9CxPfJAYMc8771J4Kq
         Zyqg==
X-Gm-Message-State: AOAM531wlS+5LRNVp+3pxeQZzw4STfWObXRLBCxfT65jbC8Xc4Ycsy4b
        bP2a0Y7RrG+cEIIL9s8G2MFVW24kM5jHtg==
X-Google-Smtp-Source: ABdhPJyV1m9Uu4p9yfBBOaGtJeqDobIT55/QnD00o4ONcmno3VrccZPI2W8JOdyLO0F0LiIyGpLLIw==
X-Received: by 2002:ac8:18da:: with SMTP id o26mr568249qtk.92.1601297199518;
        Mon, 28 Sep 2020 05:46:39 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id g5sm974902qtx.43.2020.09.28.05.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 05:46:38 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        neeraju@codeaurora.org, fweisbec@gmail.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, peterz@infradead.org
Subject: [PATCH] rcu/tree: nocb: Avoid raising softirq when CBs ready to execute
Date:   Mon, 28 Sep 2020 08:46:25 -0400
Message-Id: <20200928124625.1677571-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During testing, I see it is possible that rcu_pending() returns 1 when
offloaded callbacks are ready to execute thus raising the RCU softirq.

However, softirq does not execute offloaded callbacks. They are executed in a
kthread which is awakened independent of the softirq. The softirq ignores the
request.

This commit therefore avoids raising the softirq in the first place.
Considering that the purpose of callback offloading is to reduce softirq
activity, avoiding the softirq in the first place is the right thing to do
especially for systems that employ callback offloading to reduce real-time
jitter.

Passed 30 minute tests of TREE01 through TREE09 each.

Cc: neeraju@codeaurora.org
Cc: fweisbec@gmail.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 kernel/rcu/tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 55d3700dd1e7..caea5bfec2c0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3759,7 +3759,8 @@ static int rcu_pending(int user)
 		return 1;
 
 	/* Does this CPU have callbacks ready to invoke? */
-	if (rcu_segcblist_ready_cbs(&rdp->cblist))
+	if (!rcu_segcblist_is_offloaded(&rdp->cblist) &&
+	    rcu_segcblist_ready_cbs(&rdp->cblist))
 		return 1;
 
 	/* Has RCU gone idle with this CPU needing another grace period? */
-- 
2.28.0.709.gb0816b6eb0-goog

