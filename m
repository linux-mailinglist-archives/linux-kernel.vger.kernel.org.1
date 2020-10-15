Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AA028EA50
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389236AbgJOBjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389203AbgJOBjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:39:39 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA649C0F26DF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 17:23:13 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id k1so2022061ilc.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 17:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r29xpTf6pvYM7gD58XVxOmq2IxwCczlKKPsLjfq0wY8=;
        b=KHZxHPt6wIS2EIC6+g6Kc2+u9s6sj9IprZGUn/lUToLDA0H9JPuf68sgMH615RcYV5
         2KPQ53rnHBPMIyEcqXIwDoAqJAoUwR6YvYeTUsmqwh8Trv4v5MYa+KBCJrJtYp4Qd8DO
         7xQqxM2quYkYjDou9hx3Gc0fm2RcgCe5XSlmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r29xpTf6pvYM7gD58XVxOmq2IxwCczlKKPsLjfq0wY8=;
        b=gmCgEf6+anU2vfgdxIwmCvTA/hHmi6hUnRCMAdaSECQh3aRmsm5zxWl9UniZ1irV3F
         XTX9oywrbhOZly/QWRf0wKSCvWeAxP0XvNEczvOcEgyTkjmkEe+SYXc4Swn9haNdGnld
         iOR2X+7ACWKYtev+hgvkvB/peQHxEZ4APXp6GSZhPajOWQrXS7rCQ8FYbTTjqmZowDjF
         MPxW+0olPAnL9DvJis84M42FdpCT70/X2vG2cSqAUs+5UTyH6qljc0gik+cLEbQar3s9
         jftJ4QRCFiu3yTgrJnchCWglPlwp2srPoSwVCQCgIXes5ZOP+SPZWVeUjK5jYYIzBQH6
         fNqw==
X-Gm-Message-State: AOAM533F5lC3BUUdlPj1YJdK98lj09162XSJs44mwRjwOYQ0lgyUn6zJ
        WlB+KaoiKv/Uw64/AMneFjia5/ubVDyN0Q==
X-Google-Smtp-Source: ABdhPJzpXsMpawpBva537F45BAEL+dWfZtKhDdPmyxDV30In3qYw4avOkfAgI8DUhD6kF+BknXSCyg==
X-Received: by 2002:a92:c213:: with SMTP id j19mr1288001ilo.205.1602721392906;
        Wed, 14 Oct 2020 17:23:12 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id r4sm1075622ilc.32.2020.10.14.17.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 17:23:12 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: [PATCH v7 5/6] rcu/tree: Remove redundant smp_mb() in rcu_do_batch
Date:   Wed, 14 Oct 2020 20:23:00 -0400
Message-Id: <20201015002301.101830-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
In-Reply-To: <20201015002301.101830-1-joel@joelfernandes.org>
References: <20201015002301.101830-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This memory barrier is not needed as rcu_segcblist_add_len() already
includes a memory barrier.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 346a05506935..6c6d3c7036e6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2525,7 +2525,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	/* Update counts and requeue any remaining callbacks. */
 	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
-	smp_mb(); /* List handling before counting for rcu_barrier(). */
 	rcu_segcblist_add_len(&rdp->cblist, -count);
 
 	/* Reinstate batch limit if we have worked down the excess. */
-- 
2.28.0.1011.ga647a8990f-goog

