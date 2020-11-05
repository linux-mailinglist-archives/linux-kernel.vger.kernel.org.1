Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8A32A8AE6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732805AbgKEXrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:47:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732396AbgKEXrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:25 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E9E022242;
        Thu,  5 Nov 2020 23:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620045;
        bh=m6HGv9sr5Fax/hswnWxPLtSMdHhkxBHAhbVIh72kMgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=grqP3StKyPvI6JXyKYUqIDURmh5gf5wsumkZAcD9jUKDSrfF3eO0Zlty0+w2SF7Zr
         +FHGUElVgzaI79+M0lI12oNP6f6BF9hHBRVd4wA6ixGJmFZw62fyhdRtdfKpYQ26ET
         Nql2v4a1aRn1hFqpVZzm90PCwQ4dd/hl2/tJFxoA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/28] rcuscale: Avoid divide by zero
Date:   Thu,  5 Nov 2020 15:46:59 -0800
Message-Id: <20201105234719.23307-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcuscale test module does not use batches, so there is only
ever one batch.  This commit therefore informs the kvm-recheck-rcuscale.sh
script of this fact of life.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh
index aa74515..b582113 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh
@@ -32,7 +32,7 @@ sed -e 's/^\[[^]]*]//' < $i/console.log |
 awk '
 /-scale: .* gps: .* batches:/ {
 	ngps = $9;
-	nbatches = $11;
+	nbatches = 1;
 }
 
 /-scale: .*writer-duration/ {
-- 
2.9.5

