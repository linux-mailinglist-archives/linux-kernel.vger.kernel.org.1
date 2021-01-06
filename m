Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900E02EC24D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbhAFRco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:32:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727372AbhAFRcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:32:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 563B323142;
        Wed,  6 Jan 2021 17:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954282;
        bh=znbMpQSZm97v9n8HNzzS39xBCUPz10kcVkJ2FZrtp18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fWILQ13JsIzqG4+x6zJ9KOo50+nXHHVLf+96dHVkr8eXhY0AFL/M0Jjd1o+Hbu0VP
         Ria/BJoDbrbPNndgfnE0P828jllxdgxFdhaNOheFIZ/dFoKnH9Qdh9oh9uAOpIfR09
         Cq5bk0HW5a14lixVSVTQeo5+LSQR+nS997hD0kTLsIyltzlnt7Tml8AI1huqTA2CWu
         V0eyjwcGjmZ5cqDn1YZ9W/izaUX+LxO+U7D+B/eVME8yhnrCH3wptx04EdNtHfRM3M
         r6rmQPQGTIOUsI7UBh/X6LTrMXsUlW9H3SfkFjMuDrBoPS/4Ol4Nvmlz32hauDy9Nd
         EPR57oY2DhNgg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/18] torture: Make torture.sh rcuscale and refscale deal with allmodconfig
Date:   Wed,  6 Jan 2021 09:31:09 -0800
Message-Id: <20210106173119.23159-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106173056.GA23035@paulmck-ThinkPad-P72>
References: <20210106173056.GA23035@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The .mod.c files created by allmodconfig builds interfers with the approach
torture.sh uses to enumerate types of rcuscale and refscale runs.  This
commit therefore tightens the pattern matching to avoid this interference.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 8e66797..a89b521 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -302,7 +302,7 @@ fi
 
 if test "$do_refscale" = yes
 then
-	primlist="`grep '\.name[ 	]*=' kernel/rcu/refscale*.c | sed -e 's/^[^"]*"//' -e 's/".*$//'`"
+	primlist="`grep '\.name[ 	]*=' kernel/rcu/refscale.c | sed -e 's/^[^"]*"//' -e 's/".*$//'`"
 else
 	primlist=
 fi
@@ -314,7 +314,7 @@ done
 
 if test "$do_rcuscale" = yes
 then
-	primlist="`grep '\.name[ 	]*=' kernel/rcu/rcuscale*.c | sed -e 's/^[^"]*"//' -e 's/".*$//'`"
+	primlist="`grep '\.name[ 	]*=' kernel/rcu/rcuscale.c | sed -e 's/^[^"]*"//' -e 's/".*$//'`"
 else
 	primlist=
 fi
-- 
2.9.5

