Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0EF297A21
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 03:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757168AbgJXBEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 21:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752900AbgJXBEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 21:04:31 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261B4C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 18:04:31 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id o18so3280824edq.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 18:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3TrZ6giZbKfNISBDB1glOp0uFfqVNMz3sDITuh2vlh8=;
        b=Zw6K4ZmIuCl+yOt+zWkwDGUIUM1xCoaDw2wV5TXLNVnGqwmiKAj7sO07GlgWkzP9M1
         vQm+s+Eo778Jh7FcK8PFjGiQPwunDqaXrlcF4tPvEW/DBJ7KIdvGKbUp+Od4zgcP3Qc0
         yrcc94/xWTQIJykQfevQacf9ywQ9x1MnbPhSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3TrZ6giZbKfNISBDB1glOp0uFfqVNMz3sDITuh2vlh8=;
        b=jjuWr4nxt8fFmmoXe199b6Js+SuXQF8CPcJ7I6p1/EXKs8CbSqr2Cxv9uPe4saYO2v
         DdpUfU2LxU1wVSLq9n//lQc8yPO8wlE5xO72eHo+vXdQIF1rx/h54EM+yME8iwljLk2t
         6Zg2/jjLYq6SEMeAz6WB+1A4PElkC2LJXBgsPr5EzUjuzs53fxfB7PjDrHfZ8volDu4S
         5p7em164RNJVuouRK2L5UcfZ3PA9EVjqGkHBvQjEhUiB1oWRVKxBnfKKlNNktkeM7xLM
         Z9uQPscdcha6YWThqLBc8ASLdNumUmDa3FEAmcLjMI6OESjUy49+l7jJndiPkAAEHmTo
         miQA==
X-Gm-Message-State: AOAM533haCd8/CostARRT/Ytgw1v4vvBr6u+E5WTa4LumFr98yuBlZ5R
        vf6316275kuXjpP9SBbCBfv7xA==
X-Google-Smtp-Source: ABdhPJyW95fa8I73bvyB54A4buqImKHpYUUhkCEy3L+G9TOnyiHq4RcjUjn3r+jGNGXrSr2jgbuDHw==
X-Received: by 2002:a50:9ec6:: with SMTP id a64mr4829926edf.382.1603501469750;
        Fri, 23 Oct 2020 18:04:29 -0700 (PDT)
Received: from prevas-ravi.prevas.se (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id sd18sm1578111ejb.24.2020.10.23.18.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 18:04:29 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Liao Pingfang <liao.pingfang@zte.com.cn>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/sys.c: fix prototype of prctl_get_tid_address()
Date:   Sat, 24 Oct 2020 03:04:26 +0200
Message-Id: <20201024010427.27405-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tid_addr is not a "pointer to (pointer to int in userspace)"; it is in
fact a "pointer to (pointer to int in userspace) in userspace". So
sparse rightfully complains about passing a kernel pointer to
put_user().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 kernel/sys.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 6401880dff74a80a4594..85395f5cebc34d073cf4 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2238,12 +2238,12 @@ static int prctl_set_mm(int opt, unsigned long addr,
 }
 
 #ifdef CONFIG_CHECKPOINT_RESTORE
-static int prctl_get_tid_address(struct task_struct *me, int __user **tid_addr)
+static int prctl_get_tid_address(struct task_struct *me, int __user * __user *tid_addr)
 {
 	return put_user(me->clear_child_tid, tid_addr);
 }
 #else
-static int prctl_get_tid_address(struct task_struct *me, int __user **tid_addr)
+static int prctl_get_tid_address(struct task_struct *me, int __user * __user *tid_addr)
 {
 	return -EINVAL;
 }
@@ -2427,7 +2427,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = prctl_set_mm(arg2, arg3, arg4, arg5);
 		break;
 	case PR_GET_TID_ADDRESS:
-		error = prctl_get_tid_address(me, (int __user **)arg2);
+		error = prctl_get_tid_address(me, (int __user * __user *)arg2);
 		break;
 	case PR_SET_CHILD_SUBREAPER:
 		me->signal->is_child_subreaper = !!arg2;
-- 
2.23.0

