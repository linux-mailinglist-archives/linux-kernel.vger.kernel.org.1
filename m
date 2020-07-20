Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC182265A5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 17:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbgGTPzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 11:55:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58716 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731721AbgGTPzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:55:48 -0400
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595260546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lxj2BSbfHGhHMuFbOE5Dp6tKgfMEdQXkX/SHFacv524=;
        b=TfWsK5LlJxWN6ogr8If+8LGufidgHyJaPnvcGfE8x4ZZFbLui/neaVuJqayIY53HiHGx4I
        htFziISbkiGjSV4RWYuIua9e1ifjkOjzj2fw36GppnQAK2Y07wFVkiqQe1GUXqeh9HqPjl
        lrFyPb9ez8PE6S7VCf7bz5TTbyTX9mgWB4KwHmioWckLtolsZYSezl5pUJji6NO043YSaq
        Ttr2LZ7ALYzL1DDgk2gN7Sl9uOUyrEf2M5KO2oq1FppRkHfyvsaxWeJKzzaMA0wJjfraf0
        xolWe3mYvBiM7/bytIniWUnXGgqrrCUfXmB8lBtfNwuhY4cb7eLDWS/kKVZKTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595260546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lxj2BSbfHGhHMuFbOE5Dp6tKgfMEdQXkX/SHFacv524=;
        b=LzpcNZ4JxHs46EEF+FUaEbcYTy1ebAgod5Csz7yWQvGeFvA9bf4+kEVqi0cl/9gIvNVK08
        Mh6t75PSEypVFXDw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v4 03/24] seqlock: seqcount_t latch: End read sections with read_seqcount_retry()
Date:   Mon, 20 Jul 2020 17:55:09 +0200
Message-Id: <20200720155530.1173732-4-a.darwish@linutronix.de>
In-Reply-To: <20200720155530.1173732-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The seqcount_t latch reader example at the raw_write_seqcount_latch()
kernel-doc comment ends the latch read section with a manual smp memory
barrier and sequence counter comparison.

This is technically correct, but it is suboptimal: read_seqcount_retry()
already contains the same logic of an smp memory barrier and sequence
counter comparison.

End the latch read critical section example with read_seqcount_retry().

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/seqlock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 6c4f68ef1393..d724b5e5408d 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -363,8 +363,8 @@ static inline int raw_read_seqcount_latch(seqcount_t *s)
  *			idx = seq & 0x01;
  *			entry = data_query(latch->data[idx], ...);
  *
- *			smp_rmb();
- *		} while (seq != latch->seq);
+ *		// read_seqcount_retry() includes needed smp_rmb()
+ *		} while (read_seqcount_retry(&latch->seq, seq));
  *
  *		return entry;
  *	}
-- 
2.20.1

