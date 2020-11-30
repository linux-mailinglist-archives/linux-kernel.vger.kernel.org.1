Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F386B2C8BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbgK3RvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:51:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:48398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729370AbgK3RvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:51:22 -0500
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C1D32076E;
        Mon, 30 Nov 2020 17:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606758641;
        bh=sHhl8wgf/QCE90wWuC9pCCCM81pcUy4YIEDu7ynKdlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ayisZKvvvaq7LyZ8Hm35MJ2LQ2jUJ2PBeHbaUPRrs9UCRU0lswwBhUJGiksZbhcbs
         AvYSIgaUd7q4hpcTEcZ6A6maCoEa1b9vTSvN2tIt5HmU1j6BgBCXwJaT1olYxr4si5
         oEv9X6vue5mPXOEjHDeLcGQQF2MMKaeT6jz4oHGg=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anton Blanchard <anton@ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/3] membarrier: Add an actual barrier before rseq_preempt()
Date:   Mon, 30 Nov 2020 09:50:34 -0800
Message-Id: <c67b85690f9cb42d1e92db30e19c78e872bdd0e4.1606758530.git.luto@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606758530.git.luto@kernel.org>
References: <cover.1606758530.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to be that most RSEQ membarrier users will expect any
stores done before the membarrier() syscall to be visible to the
target task(s).  While this is extremely likely to be true in
practice, nothing actually guarantees it by a strict reading of the
x86 manuals.  Rather than providing this guarantee by accident and
potentially causing a problem down the road, just add an explicit
barrier.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 kernel/sched/membarrier.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index e23e74d52db5..7d98ef5d3bcd 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -40,6 +40,14 @@ static void ipi_mb(void *info)
 
 static void ipi_rseq(void *info)
 {
+	/*
+	 * Ensure that all stores done by the calling thread are visible
+	 * to the current task before the current task resumes.  We could
+	 * probably optimize this away on most architectures, but by the
+	 * time we've already sent an IPI, the cost of the extra smp_mb()
+	 * is negligible.
+	 */
+	smp_mb();
 	rseq_preempt(current);
 }
 
-- 
2.28.0

