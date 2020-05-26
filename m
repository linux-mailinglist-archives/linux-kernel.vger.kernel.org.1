Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC82A1AF63B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 03:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgDSB63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 21:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgDSB6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 21:58:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30B0222251;
        Sun, 19 Apr 2020 01:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587261491;
        bh=vMUdywOiH45RYm8rBBrCFHjXlKwxhw+nAnJjls5FQRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iUTjrZwFTApmSiQ/MUN/+utgOAjAilYJH903l9y5lrlkkPjWX+skNicYq4l7iacDy
         eUsMO0cbXotULyBjgZmaF9QZQ2yThvvjO6XE1ndx8dnV/jYU0CpVBnnFaLK599oee3
         Os6ChLbVJyzpNLy+9Ot6Q+6h39sixOmJkv2b1VMg=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 10/12] tools/lib/lockdep: New stacktrace API
Date:   Sat, 18 Apr 2020 21:57:52 -0400
Message-Id: <20200419015754.24456-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419015754.24456-1-sashal@kernel.org>
References: <20200419015754.24456-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel switched to using kernel/stacktrace.c, and the API slightly
changed.

Adjust it to make stack traces work again.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/stacktrace.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/linux/stacktrace.h b/tools/include/linux/stacktrace.h
index ae343ac35bfa7..b290b98d883aa 100644
--- a/tools/include/linux/stacktrace.h
+++ b/tools/include/linux/stacktrace.h
@@ -15,10 +15,18 @@ static inline void print_stack_trace(struct stack_trace *trace, int spaces)
 	backtrace_symbols_fd((void **)trace->entries, trace->nr_entries, 1);
 }
 
+static inline void stack_trace_print(const long unsigned int *entries, unsigned int nr, int spaces)
+{
+	backtrace_symbols_fd((void **)entries, nr, 1);
+}
+
 #define save_stack_trace(trace)	\
 	((trace)->nr_entries =	\
 		backtrace((void **)(trace)->entries, (trace)->max_entries))
 
+#define stack_trace_save(e, m, x) \
+	backtrace((void **)(e), (m))
+
 static inline int dump_stack(void)
 {
 	void *array[64];
-- 
2.20.1

