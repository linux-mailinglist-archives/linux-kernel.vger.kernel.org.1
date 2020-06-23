Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52F32045D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732184AbgFWAiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:38:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732071AbgFWAh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:56 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCC8320857;
        Tue, 23 Jun 2020 00:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872675;
        bh=eO9Q3V7983tc3kcuBt9Bg7GH/DNVxDpMAkG8JcRHURI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1nQiwRZwxNf9aCxzUh7zFQO65vmznR//RwBEDvZ7h8U5Q2guLVI1Mu/vYH3NMD5MP
         KhihZfnzDcDqlpoxN11vnKg8ax3gOOf7ffqYuzu5FgcukREAX1B/HZGmHiA3GfBmu4
         kC2rmQxUiQ6ZvH5r0+u1HKAl5YyyxyU2gEhu4sCc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/23] torture: Add --allcpus argument to the kvm.sh script
Date:   Mon, 22 Jun 2020 17:37:38 -0700
Message-Id: <20200623003752.26872-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Leaving off the kvm.sh script's --cpus argument results in the script
testing the scenarios sequentially, which can be quite slow.  However,
having to specify the actual number of CPUs can be error-prone.
This commit therefore adds a --allcpus argument that causes kvm.sh to
use all available CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index c279cf9..7dbce7a 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -73,6 +73,10 @@ usage () {
 while test $# -gt 0
 do
 	case "$1" in
+	--allcpus)
+		cpus=$TORTURE_ALLOTED_CPUS
+		max_cpus=$TORTURE_ALLOTED_CPUS
+		;;
 	--bootargs|--bootarg)
 		checkarg --bootargs "(list of kernel boot arguments)" "$#" "$2" '.*' '^--'
 		TORTURE_BOOTARGS="$2"
-- 
2.9.5

