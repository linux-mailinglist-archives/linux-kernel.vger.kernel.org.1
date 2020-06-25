Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9B6209A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 09:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390237AbgFYHgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 03:36:53 -0400
Received: from out20-39.mail.aliyun.com ([115.124.20.39]:54219 "EHLO
        out20-39.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390040AbgFYHgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 03:36:53 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436287|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0910485-0.000687188-0.908264;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03310;MF=aiden.leong@aibsd.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.HsCAlbk_1593070608;
Received: from ubuntu(mailfrom:aiden.leong@aibsd.com fp:SMTPD_---.HsCAlbk_1593070608)
          by smtp.aliyun-inc.com(10.147.42.197);
          Thu, 25 Jun 2020 15:36:48 +0800
From:   Aiden Leong <aiden.leong@aibsd.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
Subject: [RFC v2] Reed-Solomon Code: Update no_eras to the actual number of errors
Date:   Thu, 25 Jun 2020 00:36:01 -0700
Message-Id: <20200625073621.4919-1-aiden.leong@aibsd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corr and eras_pos are updated to actual correction pattern and erasure
positions, but no_eras is not.

When this library is used to recover lost bytes, we normally memset the
lost trunk of bytes to zero as a placeholder. Unfortunately, if the lost
byte is zero, b[i] is zero too. Without correct no_eras, users won't be
able to determine the valid length of corr and eras_pos.

Signed-off-by: Aiden Leong <aiden.leong@aibsd.com>
---
 drivers/md/dm-verity-fec.c      |  2 +-
 include/linux/rslib.h           |  4 ++--
 lib/reed_solomon/decode_rs.c    | 20 ++++++++++++++------
 lib/reed_solomon/reed_solomon.c |  4 ++--
 lib/reed_solomon/test_rslib.c   | 18 ++++++++++++------
 5 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index fb41b4f23c48..ae8366a50244 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -50,7 +50,7 @@ static int fec_decode_rs8(struct dm_verity *v, struct dm_verity_fec_io *fio,
 	for (i = 0; i < v->fec->roots; i++)
 		par[i] = fec[i];
 
-	return decode_rs8(fio->rs, data, par, v->fec->rsn, NULL, neras,
+	return decode_rs8(fio->rs, data, par, v->fec->rsn, NULL, &neras,
 			  fio->erasures, 0, NULL);
 }
 
diff --git a/include/linux/rslib.h b/include/linux/rslib.h
index 238bb85243d3..80662abc9af7 100644
--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -64,7 +64,7 @@ int encode_rs8(struct rs_control *rs, uint8_t *data, int len, uint16_t *par,
 #endif
 #ifdef CONFIG_REED_SOLOMON_DEC8
 int decode_rs8(struct rs_control *rs, uint8_t *data, uint16_t *par, int len,
-		uint16_t *s, int no_eras, int *eras_pos, uint16_t invmsk,
+		uint16_t *s, int *no_eras, int *eras_pos, uint16_t invmsk,
 	       uint16_t *corr);
 #endif
 
@@ -75,7 +75,7 @@ int encode_rs16(struct rs_control *rs, uint16_t *data, int len, uint16_t *par,
 #endif
 #ifdef CONFIG_REED_SOLOMON_DEC16
 int decode_rs16(struct rs_control *rs, uint16_t *data, uint16_t *par, int len,
-		uint16_t *s, int no_eras, int *eras_pos, uint16_t invmsk,
+		uint16_t *s, int *no_eras, int *eras_pos, uint16_t invmsk,
 		uint16_t *corr);
 #endif
 
diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 805de84ae83d..44136ea33d16 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -24,6 +24,7 @@
 	int count = 0;
 	int num_corrected;
 	uint16_t msk = (uint16_t) rs->nn;
+	int no_eras_local = no_eras ? *no_eras : 0;
 
 	/*
 	 * The decoder buffers are in the rs control struct. They are
@@ -106,11 +107,11 @@
 	memset(&lambda[1], 0, nroots * sizeof(lambda[0]));
 	lambda[0] = 1;
 
-	if (no_eras > 0) {
+	if (no_eras_local > 0) {
 		/* Init lambda to be the erasure locator polynomial */
 		lambda[1] = alpha_to[rs_modnn(rs,
 					prim * (nn - 1 - (eras_pos[0] + pad)))];
-		for (i = 1; i < no_eras; i++) {
+		for (i = 1; i < no_eras_local; i++) {
 			u = rs_modnn(rs, prim * (nn - 1 - (eras_pos[i] + pad)));
 			for (j = i + 1; j > 0; j--) {
 				tmp = index_of[lambda[j - 1]];
@@ -129,8 +130,8 @@
 	 * Begin Berlekamp-Massey algorithm to determine error+erasure
 	 * locator polynomial
 	 */
-	r = no_eras;
-	el = no_eras;
+	r = no_eras_local;
+	el = no_eras_local;
 	while (++r <= nroots) {	/* r is the step number */
 		/* Compute discrepancy at the r-th step in poly-form */
 		discr_r = 0;
@@ -158,8 +159,8 @@
 				} else
 					t[i + 1] = lambda[i + 1];
 			}
-			if (2 * el <= r + no_eras - 1) {
-				el = r + no_eras - el;
+			if (2 * el <= r + no_eras_local - 1) {
+				el = r + no_eras_local - el;
 				/*
 				 * 2 lines below: B(x) <-- inv(discr_r) *
 				 * lambda(x)
@@ -312,14 +313,21 @@
 				eras_pos[j++] = loc[i] - pad;
 			}
 		}
+		if (no_eras)
+			*no_eras = j;
 	} else if (data && par) {
 		/* Apply error to data and parity */
+		j = 0;
 		for (i = 0; i < count; i++) {
 			if (loc[i] < (nn - nroots))
 				data[loc[i] - pad] ^= b[i];
 			else
 				par[loc[i] - pad - len] ^= b[i];
+			if (b[i])
+				j++;
 		}
+		if (no_eras)
+			*no_eras = j;
 	}
 
 	return  num_corrected;
diff --git a/lib/reed_solomon/reed_solomon.c b/lib/reed_solomon/reed_solomon.c
index bbc01bad3053..b2c811674c98 100644
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -359,7 +359,7 @@ EXPORT_SYMBOL_GPL(encode_rs8);
  *  errors. The count includes errors in the parity.
  */
 int decode_rs8(struct rs_control *rsc, uint8_t *data, uint16_t *par, int len,
-	       uint16_t *s, int no_eras, int *eras_pos, uint16_t invmsk,
+	       uint16_t *s, int *no_eras, int *eras_pos, uint16_t invmsk,
 	       uint16_t *corr)
 {
 #include "decode_rs.c"
@@ -410,7 +410,7 @@ EXPORT_SYMBOL_GPL(encode_rs16);
  *  errors. The count includes errors in the parity.
  */
 int decode_rs16(struct rs_control *rsc, uint16_t *data, uint16_t *par, int len,
-		uint16_t *s, int no_eras, int *eras_pos, uint16_t invmsk,
+		uint16_t *s, int *no_eras, int *eras_pos, uint16_t invmsk,
 		uint16_t *corr)
 {
 #include "decode_rs.c"
diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
index 4eb29f365ece..b30a4aea8796 100644
--- a/lib/reed_solomon/test_rslib.c
+++ b/lib/reed_solomon/test_rslib.c
@@ -258,7 +258,7 @@ static void compute_syndrome(struct rs_control *rsc, uint16_t *data,
 
 /* Test up to error correction capacity */
 static void test_uc(struct rs_control *rs, int len, int errs,
-		int eras, int trials, struct estat *stat,
+		int *eras, int trials, struct estat *stat,
 		struct wspace *ws, int method)
 {
 	int dlen = len - rs->codec->nroots;
@@ -327,8 +327,11 @@ static int ex_rs_helper(struct rs_control *rs, struct wspace *ws,
 		pr_info("  %s\n", desc[method]);
 
 	for (errs = 0; errs <= nroots / 2; errs++)
-		for (eras = 0; eras <= nroots - 2 * errs; eras++)
-			test_uc(rs, len, errs, eras, trials, &stat, ws, method);
+		for (eras = 0; eras <= nroots - 2 * errs; eras++) {
+			int no_eras = ers;
+
+			test_uc(rs, len, errs, &no_eras, trials, &stat, ws, method);
+		}
 
 	if (v >= V_CSUMMARY) {
 		pr_info("    Decodes wrong:        %d / %d\n",
@@ -364,7 +367,7 @@ static int exercise_rs(struct rs_control *rs, struct wspace *ws,
 
 /* Tests for correct behaviour beyond error correction capacity */
 static void test_bc(struct rs_control *rs, int len, int errs,
-		int eras, int trials, struct bcstat *stat,
+		int *eras, int trials, struct bcstat *stat,
 		struct wspace *ws)
 {
 	int nroots = rs->codec->nroots;
@@ -420,8 +423,11 @@ static int exercise_rs_bc(struct rs_control *rs, struct wspace *ws,
 			eras = 0;
 
 		cutoff = nroots <= len - errs ? nroots : len - errs;
-		for (; eras <= cutoff; eras++)
-			test_bc(rs, len, errs, eras, trials, &stat, ws);
+		for (; eras <= cutoff; eras++) {
+			int no_eras = eras;
+
+			test_bc(rs, len, errs, &no_eras, trials, &stat, ws);
+		}
 	}
 
 	if (v >= V_CSUMMARY) {
-- 
2.25.1

