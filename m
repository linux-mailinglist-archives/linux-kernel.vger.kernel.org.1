Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222562043DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 00:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbgFVWnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 18:43:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731352AbgFVWnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:43:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 827412083B;
        Mon, 22 Jun 2020 22:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592865799;
        bh=hdSJ0WSegTcwByJEJ9Fu9kUCV4GsRKEAjQS6V1gITUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dVyZFs1fHmjyoldaDBxcXn82XYQ78GOPQzwYnI15FlbumXlKT0CeeLkADU7CWaaQE
         6EPyhUfuDxUMVqBTlQwORuCEDa1bw2+8W7qGoPnAxZJt9/RNcVyYc2aBVAG45wy/vH
         dHtOk/ehDfVNKESeprzqigoWTRXqil7aq6n8LUo0=
From:   Sasha Levin <sashal@kernel.org>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jolsa@redhat.com, alexey.budankov@linux.intel.com,
        songliubraving@fb.com, acme@redhat.com, allison@lohutok.net,
        sashal@kernel.org
Subject: [PATCH v3 13/14] tools/lib/lockdep: explicitly declare lockdep_init_task()
Date:   Mon, 22 Jun 2020 18:42:57 -0400
Message-Id: <20200622224258.1208588-14-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622224258.1208588-1-sashal@kernel.org>
References: <20200622224258.1208588-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid a warning as we can't pull the decleration for lockdep's header.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/lockdep/preload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/lockdep/preload.c b/tools/lib/lockdep/preload.c
index 5bd58c51066c4..2928c712f87f8 100644
--- a/tools/lib/lockdep/preload.c
+++ b/tools/lib/lockdep/preload.c
@@ -92,6 +92,8 @@ static int (*ll_pthread_rwlock_trywrlock)(pthread_rwlock_t *rwlock)	= __pthread_
 static int (*ll_pthread_rwlock_wrlock)(pthread_rwlock_t *rwlock)	= __pthread_rwlock_wrlock;
 static int (*ll_pthread_rwlock_unlock)(pthread_rwlock_t *rwlock)	= __pthread_rwlock_unlock;
 
+extern void lockdep_init_task(struct task_struct *task);
+
 enum { none, prepare, done, } __init_state;
 static void init_preload(void);
 static void try_init_preload(void)
-- 
2.25.1

