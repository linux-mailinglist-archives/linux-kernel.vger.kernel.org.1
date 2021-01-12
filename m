Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E682F3A94
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437083AbhALTa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:30:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:49516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732921AbhALTaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:30:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCB422310A;
        Tue, 12 Jan 2021 19:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610479784;
        bh=6bfA0dRvEauC/I/vK5VpOdtBbRK35I684D0i0qoe0Zg=;
        h=From:To:Cc:Subject:Date:From;
        b=tBRPAtvn9raEIOwWZvI0n+bN7mfEMCypBnUSCzHLRvl9+uZh0/G6ip1lUrKJ+FdOX
         lnnz2NfmcDJCjGu9fN0w9nwz+dhNnRWspkpegNW6g3j9M5HzwghLe3lqtR0VkVcZb+
         2U09yOsZKtPscunHFOGO6RS6ogJtmPTD4HspsXxaJ8toVB/lIy9Dtn6hFVysQfl3q+
         24rdsUk9NA0pkdfus2IGZn5sQdKdxMyIuehSj1+HGYzM081q74wHNGCpyOUpC8GLLf
         KHQDHyagJGCsLz5tzlGMbB3Z5Sh3H4k1oQ78qgUQrTvC/A3SyJjFhDC2leIRLPYMbm
         50Lmg4OFwRRsg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>, Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH RESEND] random: remove dead code left over from blocking pool
Date:   Tue, 12 Jan 2021 11:29:38 -0800
Message-Id: <20210112192938.70666-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Remove some dead code that was left over following commit 90ea1c6436d2
("random: remove the blocking pool").

Cc: linux-crypto@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---

Andrew, please consider taking this patch since the maintainer has been
ignoring it for 4 months
(https://lkml.kernel.org/lkml/20200916043652.96640-1-ebiggers@kernel.org/T/#u).


 drivers/char/random.c         | 17 ++-----
 include/trace/events/random.h | 83 -----------------------------------
 2 files changed, 3 insertions(+), 97 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index a894c0559a8cf..bbc5098b1a81f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -500,7 +500,6 @@ struct entropy_store {
 	unsigned short add_ptr;
 	unsigned short input_rotate;
 	int entropy_count;
-	unsigned int initialized:1;
 	unsigned int last_data_init:1;
 	__u8 last_data[EXTRACT_SIZE];
 };
@@ -660,7 +659,7 @@ static void process_random_ready_list(void)
  */
 static void credit_entropy_bits(struct entropy_store *r, int nbits)
 {
-	int entropy_count, orig, has_initialized = 0;
+	int entropy_count, orig;
 	const int pool_size = r->poolinfo->poolfracbits;
 	int nfrac = nbits << ENTROPY_SHIFT;
 
@@ -717,23 +716,14 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 	if (cmpxchg(&r->entropy_count, orig, entropy_count) != orig)
 		goto retry;
 
-	if (has_initialized) {
-		r->initialized = 1;
-		kill_fasync(&fasync, SIGIO, POLL_IN);
-	}
-
 	trace_credit_entropy_bits(r->name, nbits,
 				  entropy_count >> ENTROPY_SHIFT, _RET_IP_);
 
 	if (r == &input_pool) {
 		int entropy_bits = entropy_count >> ENTROPY_SHIFT;
 
-		if (crng_init < 2) {
-			if (entropy_bits < 128)
-				return;
+		if (crng_init < 2 && entropy_bits >= 128)
 			crng_reseed(&primary_crng, r);
-			entropy_bits = ENTROPY_BITS(r);
-		}
 	}
 }
 
@@ -1385,8 +1375,7 @@ static size_t account(struct entropy_store *r, size_t nbytes, int min,
 }
 
 /*
- * This function does the actual extraction for extract_entropy and
- * extract_entropy_user.
+ * This function does the actual extraction for extract_entropy.
  *
  * Note: we assume that .poolwords is a multiple of 16 words.
  */
diff --git a/include/trace/events/random.h b/include/trace/events/random.h
index 9570a10cb949b..3d7b432ca5f31 100644
--- a/include/trace/events/random.h
+++ b/include/trace/events/random.h
@@ -85,28 +85,6 @@ TRACE_EVENT(credit_entropy_bits,
 		  __entry->entropy_count, (void *)__entry->IP)
 );
 
-TRACE_EVENT(push_to_pool,
-	TP_PROTO(const char *pool_name, int pool_bits, int input_bits),
-
-	TP_ARGS(pool_name, pool_bits, input_bits),
-
-	TP_STRUCT__entry(
-		__field( const char *,	pool_name		)
-		__field(	  int,	pool_bits		)
-		__field(	  int,	input_bits		)
-	),
-
-	TP_fast_assign(
-		__entry->pool_name	= pool_name;
-		__entry->pool_bits	= pool_bits;
-		__entry->input_bits	= input_bits;
-	),
-
-	TP_printk("%s: pool_bits %d input_pool_bits %d",
-		  __entry->pool_name, __entry->pool_bits,
-		  __entry->input_bits)
-);
-
 TRACE_EVENT(debit_entropy,
 	TP_PROTO(const char *pool_name, int debit_bits),
 
@@ -161,35 +139,6 @@ TRACE_EVENT(add_disk_randomness,
 		  MINOR(__entry->dev), __entry->input_bits)
 );
 
-TRACE_EVENT(xfer_secondary_pool,
-	TP_PROTO(const char *pool_name, int xfer_bits, int request_bits,
-		 int pool_entropy, int input_entropy),
-
-	TP_ARGS(pool_name, xfer_bits, request_bits, pool_entropy,
-		input_entropy),
-
-	TP_STRUCT__entry(
-		__field( const char *,	pool_name		)
-		__field(	  int,	xfer_bits		)
-		__field(	  int,	request_bits		)
-		__field(	  int,	pool_entropy		)
-		__field(	  int,	input_entropy		)
-	),
-
-	TP_fast_assign(
-		__entry->pool_name	= pool_name;
-		__entry->xfer_bits	= xfer_bits;
-		__entry->request_bits	= request_bits;
-		__entry->pool_entropy	= pool_entropy;
-		__entry->input_entropy	= input_entropy;
-	),
-
-	TP_printk("pool %s xfer_bits %d request_bits %d pool_entropy %d "
-		  "input_entropy %d", __entry->pool_name, __entry->xfer_bits,
-		  __entry->request_bits, __entry->pool_entropy,
-		  __entry->input_entropy)
-);
-
 DECLARE_EVENT_CLASS(random__get_random_bytes,
 	TP_PROTO(int nbytes, unsigned long IP),
 
@@ -253,38 +202,6 @@ DEFINE_EVENT(random__extract_entropy, extract_entropy,
 	TP_ARGS(pool_name, nbytes, entropy_count, IP)
 );
 
-DEFINE_EVENT(random__extract_entropy, extract_entropy_user,
-	TP_PROTO(const char *pool_name, int nbytes, int entropy_count,
-		 unsigned long IP),
-
-	TP_ARGS(pool_name, nbytes, entropy_count, IP)
-);
-
-TRACE_EVENT(random_read,
-	TP_PROTO(int got_bits, int need_bits, int pool_left, int input_left),
-
-	TP_ARGS(got_bits, need_bits, pool_left, input_left),
-
-	TP_STRUCT__entry(
-		__field(	  int,	got_bits		)
-		__field(	  int,	need_bits		)
-		__field(	  int,	pool_left		)
-		__field(	  int,	input_left		)
-	),
-
-	TP_fast_assign(
-		__entry->got_bits	= got_bits;
-		__entry->need_bits	= need_bits;
-		__entry->pool_left	= pool_left;
-		__entry->input_left	= input_left;
-	),
-
-	TP_printk("got_bits %d still_needed_bits %d "
-		  "blocking_pool_entropy_left %d input_entropy_left %d",
-		  __entry->got_bits, __entry->got_bits, __entry->pool_left,
-		  __entry->input_left)
-);
-
 TRACE_EVENT(urandom_read,
 	TP_PROTO(int got_bits, int pool_left, int input_left),
 
-- 
2.30.0

