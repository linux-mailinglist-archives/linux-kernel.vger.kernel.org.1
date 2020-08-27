Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F27B25449C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 13:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgH0Lyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 07:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728795AbgH0Lkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:40:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5A5C06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 04:40:45 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598528444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SII/dzF1qlKGKAwSghzgCWyB6lBajZKPLa5gJMm1iAY=;
        b=1lu/7OLCK0kilASSqPn1E+QXo7wFk+3ChXTuz+wV8mkJyTUo4ank67jU48ACRdrD95avVm
        Jaiu+dnpXLqbhKUFZpbnDuXSQV8ZMkVFTFPBHWmNNgeZ0f9MiWIRCIfS+9AqZEAx+R6Og1
        c+X4E1TLxmqwzJf5evz6ptqHBg1a19oK2enR6qU/B+cV2tMi1uZg+I+LNLbV1khZxrjrsq
        B67zcngZIezMcEur+R3PMa/q3JPKMUCWL+ArnssYjgto7q7iLqzPIZiMrcUofqASBoKZny
        0UYOmmBro3VjiC0O5GuF2J0mRGZDTTG93pEHrKhSjJhZ/nXMcDOB8kRJmk/+Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598528444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SII/dzF1qlKGKAwSghzgCWyB6lBajZKPLa5gJMm1iAY=;
        b=PpqpVRFFaDPy3f6CfDdY7JLmLjwrM6f+3qzh1S8ihZ3MzDF/99E0pPpvzLrpx0Bn4LLJpn
        lIWEn4dZoSSd/XAA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v1 4/8] time/sched_clock: Use seqcount_latch_t
Date:   Thu, 27 Aug 2020 13:40:40 +0200
Message-Id: <20200827114044.11173-5-a.darwish@linutronix.de>
In-Reply-To: <20200827114044.11173-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200827114044.11173-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Latch sequence counters have unique read and write APIs, and thus
seqcount_latch_t was recently introduced at seqlock.h.

Use that new data type instead of plain seqcount_t. This adds the
necessary type-safety and ensures only latching-safe seqcount APIs are
to be used.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 kernel/time/sched_clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 8c6b5febd7a0..0642013dace4 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -35,7 +35,7 @@
  * into a single 64-byte cache line.
  */
 struct clock_data {
-	seqcount_t		seq;
+	seqcount_latch_t	seq;
 	struct clock_read_data	read_data[2];
 	ktime_t			wrap_kt;
 	unsigned long		rate;
@@ -76,7 +76,7 @@ struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
 
 int sched_clock_read_retry(unsigned int seq)
 {
-	return read_seqcount_retry(&cd.seq, seq);
+	return read_seqcount_latch_retry(&cd.seq, seq);
 }
 
 unsigned long long notrace sched_clock(void)
-- 
2.28.0

