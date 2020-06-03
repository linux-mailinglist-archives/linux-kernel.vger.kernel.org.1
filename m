Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3486D1ED280
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 16:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgFCOur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 10:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgFCOuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:50:23 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0772C08C5C1;
        Wed,  3 Jun 2020 07:50:22 -0700 (PDT)
Received: from [5.158.153.53] (helo=debian-buster-darwi.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <a.darwish@linutronix.de>)
        id 1jgUie-0001zr-3o; Wed, 03 Jun 2020 16:50:16 +0200
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org
Subject: [PATCH v2 5/6] block: nr_sects_write(): Disable preemption on seqcount write
Date:   Wed,  3 Jun 2020 16:49:48 +0200
Message-Id: <20200603144949.1122421-6-a.darwish@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200603144949.1122421-1-a.darwish@linutronix.de>
References: <20200603144949.1122421-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For optimized block readers not holding a mutex, the "number of sectors"
64-bit value is protected from tearing on 32-bit architectures by a
sequence counter.

Disable preemption before entering that sequence counter's write side
critical section. Otherwise, the read side can preempt the write side
section and spin for the entire scheduler tick. If the reader belongs to
a real-time scheduling class, it can spin forever and the kernel will
livelock.

Fixes: c83f6bf98dc1 ("block: add partition resize function to blkpg ioctl")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 block/blk.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index 0a94ec68af32..151f86932547 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -470,9 +470,11 @@ static inline sector_t part_nr_sects_read(struct hd_struct *part)
 static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
 {
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+	preempt_disable();
 	write_seqcount_begin(&part->nr_sects_seq);
 	part->nr_sects = size;
 	write_seqcount_end(&part->nr_sects_seq);
+	preempt_enable();
 #elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPTION)
 	preempt_disable();
 	part->nr_sects = size;
-- 
2.20.1

