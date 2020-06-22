Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9318202FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 08:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbgFVGPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 02:15:21 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:62533 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731231AbgFVGPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 02:15:18 -0400
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Jun 2020 23:15:16 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 21 Jun 2020 23:15:13 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id E301E218BE; Mon, 22 Jun 2020 11:45:11 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        stanimir.varbanov@linaro.org, ardb@kernel.org,
        sivaprak@codeaurora.org, cotequeiroz@gmail.com,
        ebiggers@google.com, horia.geanta@nxp.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] crypto: qce: re-initialize context on import
Date:   Mon, 22 Jun 2020 11:45:05 +0530
Message-Id: <1592806506-23978-3-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592806506-23978-1-git-send-email-sivaprak@codeaurora.org>
References: <1592806506-23978-1-git-send-email-sivaprak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crypto testmgr deliberately corrupts the request context while passing
vectors to the import. This is to make sure that drivers do not rely on
request but they take all the necessary input from io vec passed to it.

qce casts the request context from request parameter, since it is corrupted
the sub squent hash request fails and qce hangs.

To avoid this re-initialize request context on import. The qce import
API alreasy takes care of taking the input vectors from passed io vec.

Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
 drivers/crypto/qce/sha.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index ed82520203f9..9e54a667d72f 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -203,10 +203,18 @@ static int qce_import_common(struct ahash_request *req, u64 in_count,
 
 static int qce_ahash_import(struct ahash_request *req, const void *in)
 {
-	struct qce_sha_reqctx *rctx = ahash_request_ctx(req);
-	unsigned long flags = rctx->flags;
-	bool hmac = IS_SHA_HMAC(flags);
-	int ret = -EINVAL;
+	struct qce_sha_reqctx *rctx;
+	unsigned long flags;
+	bool hmac;
+	int ret;
+
+	ret = qce_ahash_init(req);
+	if (ret)
+		return ret;
+
+	rctx = ahash_request_ctx(req);
+	flags = rctx->flags;
+	hmac = IS_SHA_HMAC(flags);
 
 	if (IS_SHA1(flags) || IS_SHA1_HMAC(flags)) {
 		const struct sha1_state *state = in;
-- 
2.7.4

