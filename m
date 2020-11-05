Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C67F2A8AF6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732958AbgKEXsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:48:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:45970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732396AbgKEXrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:32 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DC98221FE;
        Thu,  5 Nov 2020 23:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620051;
        bh=p7BCROET9ehqPb8WwWhA7jHG87zNPujM1AIJ22NSe1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NtOHkGLQNQjvcKaCAe+Kd9o7SblqTsMy0QSvDQMrMf6aEiM5wbv+jns+B1fb4MzBs
         qiFNblj2SJDCTTAJwzemsB1zXoTz5pBZL6pfnz6QaJ49CIBAuatNM3NkTAVdFSelwK
         vBN6OU+4NsNUzbmKrHdblpfz+co21xMYP2eSpldM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 27/28] tools/nolibc:  Fix a spelling error in a comment
Date:   Thu,  5 Nov 2020 15:47:18 -0800
Message-Id: <20201105234719.23307-27-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Fix a spelling in the comment line.

s/memry/memory/p

This is on linux-next.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index d6d2623..e61d36c 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -107,7 +107,7 @@ static int errno;
 #endif
 
 /* errno codes all ensure that they will not conflict with a valid pointer
- * because they all correspond to the highest addressable memry page.
+ * because they all correspond to the highest addressable memory page.
  */
 #define MAX_ERRNO 4095
 
-- 
2.9.5

