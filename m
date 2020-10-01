Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4026127FA3A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 09:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbgJAH0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 03:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAH0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 03:26:41 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EAAC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 00:26:40 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t16so4539240edw.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 00:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ZKtKXKnlI9OQcR2INMab6gGaMD1rqgWs4v7ImAsS28=;
        b=HMB3bWupFtyFqFrornu8LUPR+eKE69dlVbICTJOY/SqNpN9xiYB9o2yv7Dyv2mTPG7
         i+x+eA1ISs5n2Kdg19TcVbecjGO9xtOPQ8mB4bKmOs/2TxZHCw+qb5n+nX3i9uAkUOsz
         wRHKepAKszXXpvWU1Unj958sPuv9hyUurzV+6qvDxRzUqNXezxDbGZbAsuV+fQdmCU9g
         NEHtqSC0fZ/OwZy9spmtR8K616SlJdzqB8CdnfjFXVF1ovF6AlB1EdmQgOfDfvg9F9PG
         ZMfTszWQeX9dv7DxB8cwt+4HlnepN6xH9pH8X25lr/koji5cJVuKRKPshDcrZgL/FHBh
         u0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ZKtKXKnlI9OQcR2INMab6gGaMD1rqgWs4v7ImAsS28=;
        b=ljqC/0HaDVe04YGTy8uL965JCCLRLgOysxICjurLpiO5Q+jb2zi34yIilqdibuyHP4
         Xzr4U+gnR9J+jkAkgZV7b9Uom0atiMkGczsrOwJWBHr4vmEHRikaEffdaIv5kSIg8JAD
         Tn/HOOUWFLuZmH4sFH1cSlzC+J7P8eNb0rFoalMOr7c4JYX0h8xUo4U5VVlZpSALZ9W2
         w7+A3Vh+cWjlX855yyQpwmfsdBOQkGoWmwTR4V0gdyIhXJ9LaiaqHf7J0nmWfjeGodFz
         OcCspBNPbRrRDxX9/v+u85hwH3J9mJSNE0dkXLzDcT0DyWhRtTPTX5//8RdTx3cP06Mh
         3Saw==
X-Gm-Message-State: AOAM532MFRFCfLiSHrVBkDYuf4IEjCcGwXsOqvbU7nIbtJxb/1bz6CXl
        e/wFKdy+bjrPu0hy4r2GqAlL5Q==
X-Google-Smtp-Source: ABdhPJxyKpDexrlR5gMm/WeckDH1ZOsNlTfR/gExRTc2c1FoTc2vsFAzyR5/OatKyVjOnxHleBRPuw==
X-Received: by 2002:a50:ee10:: with SMTP id g16mr7114902eds.258.1601537199589;
        Thu, 01 Oct 2020 00:26:39 -0700 (PDT)
Received: from gkim-laptop.pb.local ([2001:1438:4010:2558:4cea:8c37:1548:493c])
        by smtp.googlemail.com with ESMTPSA id jr9sm3436230ejb.87.2020.10.01.00.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 00:26:39 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@cloud.ionos.com>
X-Google-Original-From: Gioh Kim <gi-oh.kim@clous.ionos.com>
To:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH 1/2] RDMA/rtrs: remove unnecessary argument dir of rtrs_iu_free
Date:   Thu,  1 Oct 2020 09:26:37 +0200
Message-Id: <20201001072637.16121-1-gi-oh.kim@clous.ionos.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

The direction of DMA operation is already in the rtrs_iu.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 14 ++++++--------
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |  3 +--
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 14 ++++++--------
 drivers/infiniband/ulp/rtrs/rtrs.c     | 10 +++++-----
 4 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 776e89231c52..7af5f1559451 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1236,8 +1236,7 @@ static void free_sess_reqs(struct rtrs_clt_sess *sess)
 		if (req->mr)
 			ib_dereg_mr(req->mr);
 		kfree(req->sge);
-		rtrs_iu_free(req->iu, DMA_TO_DEVICE,
-			      sess->s.dev->ib_dev, 1);
+		rtrs_iu_free(req->iu, sess->s.dev->ib_dev, 1);
 	}
 	kfree(sess->reqs);
 	sess->reqs = NULL;
@@ -1605,8 +1604,7 @@ static void destroy_con_cq_qp(struct rtrs_clt_con *con)
 
 	rtrs_cq_qp_destroy(&con->c);
 	if (con->rsp_ius) {
-		rtrs_iu_free(con->rsp_ius, DMA_FROM_DEVICE,
-			      sess->s.dev->ib_dev, con->queue_size);
+		rtrs_iu_free(con->rsp_ius, sess->s.dev->ib_dev, con->queue_size);
 		con->rsp_ius = NULL;
 		con->queue_size = 0;
 	}
@@ -2245,7 +2243,7 @@ static void rtrs_clt_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct rtrs_iu *iu;
 
 	iu = container_of(wc->wr_cqe, struct rtrs_iu, cqe);
-	rtrs_iu_free(iu, DMA_TO_DEVICE, sess->s.dev->ib_dev, 1);
+	rtrs_iu_free(iu, sess->s.dev->ib_dev, 1);
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
 		rtrs_err(sess->clt, "Sess info request send failed: %s\n",
@@ -2374,7 +2372,7 @@ static void rtrs_clt_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
 
 out:
 	rtrs_clt_update_wc_stats(con);
-	rtrs_iu_free(iu, DMA_FROM_DEVICE, sess->s.dev->ib_dev, 1);
+	rtrs_iu_free(iu, sess->s.dev->ib_dev, 1);
 	rtrs_clt_change_state(sess, state);
 }
 
@@ -2436,9 +2434,9 @@ static int rtrs_send_sess_info(struct rtrs_clt_sess *sess)
 
 out:
 	if (tx_iu)
-		rtrs_iu_free(tx_iu, DMA_TO_DEVICE, sess->s.dev->ib_dev, 1);
+		rtrs_iu_free(tx_iu, sess->s.dev->ib_dev, 1);
 	if (rx_iu)
-		rtrs_iu_free(rx_iu, DMA_FROM_DEVICE, sess->s.dev->ib_dev, 1);
+		rtrs_iu_free(rx_iu, sess->s.dev->ib_dev, 1);
 	if (unlikely(err))
 		/* If we've never taken async path because of malloc problems */
 		rtrs_clt_change_state(sess, RTRS_CLT_CONNECTING_ERR);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index 0a93c87ef92b..63b128c6eb04 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -288,8 +288,7 @@ struct rtrs_msg_rdma_hdr {
 struct rtrs_iu *rtrs_iu_alloc(u32 queue_size, size_t size, gfp_t t,
 			      struct ib_device *dev, enum dma_data_direction,
 			      void (*done)(struct ib_cq *cq, struct ib_wc *wc));
-void rtrs_iu_free(struct rtrs_iu *iu, enum dma_data_direction dir,
-		  struct ib_device *dev, u32 queue_size);
+void rtrs_iu_free(struct rtrs_iu *iu, struct ib_device *dev, u32 queue_size);
 int rtrs_iu_post_recv(struct rtrs_con *con, struct rtrs_iu *iu);
 int rtrs_iu_post_send(struct rtrs_con *con, struct rtrs_iu *iu, size_t size,
 		      struct ib_send_wr *head);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index a219bd1bdbc2..b8763fe9152f 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -575,8 +575,7 @@ static void unmap_cont_bufs(struct rtrs_srv_sess *sess)
 		struct rtrs_srv_mr *srv_mr;
 
 		srv_mr = &sess->mrs[i];
-		rtrs_iu_free(srv_mr->iu, DMA_TO_DEVICE,
-			      sess->s.dev->ib_dev, 1);
+		rtrs_iu_free(srv_mr->iu, sess->s.dev->ib_dev, 1);
 		ib_dereg_mr(srv_mr->mr);
 		ib_dma_unmap_sg(sess->s.dev->ib_dev, srv_mr->sgt.sgl,
 				srv_mr->sgt.nents, DMA_BIDIRECTIONAL);
@@ -680,8 +679,7 @@ static int map_cont_bufs(struct rtrs_srv_sess *sess)
 			sgt = &srv_mr->sgt;
 			mr = srv_mr->mr;
 free_iu:
-			rtrs_iu_free(srv_mr->iu, DMA_TO_DEVICE,
-				      sess->s.dev->ib_dev, 1);
+			rtrs_iu_free(srv_mr->iu, sess->s.dev->ib_dev, 1);
 dereg_mr:
 			ib_dereg_mr(mr);
 unmap_sg:
@@ -733,7 +731,7 @@ static void rtrs_srv_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct rtrs_iu *iu;
 
 	iu = container_of(wc->wr_cqe, struct rtrs_iu, cqe);
-	rtrs_iu_free(iu, DMA_TO_DEVICE, sess->s.dev->ib_dev, 1);
+	rtrs_iu_free(iu, sess->s.dev->ib_dev, 1);
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
 		rtrs_err(s, "Sess info response send failed: %s\n",
@@ -859,7 +857,7 @@ static int process_info_req(struct rtrs_srv_con *con,
 	if (unlikely(err)) {
 		rtrs_err(s, "rtrs_iu_post_send(), err: %d\n", err);
 iu_free:
-		rtrs_iu_free(tx_iu, DMA_TO_DEVICE, sess->s.dev->ib_dev, 1);
+		rtrs_iu_free(tx_iu, sess->s.dev->ib_dev, 1);
 	}
 rwr_free:
 	kfree(rwr);
@@ -904,7 +902,7 @@ static void rtrs_srv_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
 		goto close;
 
 out:
-	rtrs_iu_free(iu, DMA_FROM_DEVICE, sess->s.dev->ib_dev, 1);
+	rtrs_iu_free(iu, sess->s.dev->ib_dev, 1);
 	return;
 close:
 	close_sess(sess);
@@ -927,7 +925,7 @@ static int post_recv_info_req(struct rtrs_srv_con *con)
 	err = rtrs_iu_post_recv(&con->c, rx_iu);
 	if (unlikely(err)) {
 		rtrs_err(s, "rtrs_iu_post_recv(), err: %d\n", err);
-		rtrs_iu_free(rx_iu, DMA_FROM_DEVICE, sess->s.dev->ib_dev, 1);
+		rtrs_iu_free(rx_iu, sess->s.dev->ib_dev, 1);
 		return err;
 	}
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index ff1093d6e4bc..5163e662f86f 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -31,6 +31,8 @@ struct rtrs_iu *rtrs_iu_alloc(u32 queue_size, size_t size, gfp_t gfp_mask,
 		return NULL;
 	for (i = 0; i < queue_size; i++) {
 		iu = &ius[i];
+		iu->direction = dir;
+
 		iu->buf = kzalloc(size, gfp_mask);
 		if (!iu->buf)
 			goto err;
@@ -41,17 +43,15 @@ struct rtrs_iu *rtrs_iu_alloc(u32 queue_size, size_t size, gfp_t gfp_mask,
 
 		iu->cqe.done  = done;
 		iu->size      = size;
-		iu->direction = dir;
 	}
 	return ius;
 err:
-	rtrs_iu_free(ius, dir, dma_dev, i);
+	rtrs_iu_free(ius, dma_dev, i);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(rtrs_iu_alloc);
 
-void rtrs_iu_free(struct rtrs_iu *ius, enum dma_data_direction dir,
-		   struct ib_device *ibdev, u32 queue_size)
+void rtrs_iu_free(struct rtrs_iu *ius, struct ib_device *ibdev, u32 queue_size)
 {
 	struct rtrs_iu *iu;
 	int i;
@@ -61,7 +61,7 @@ void rtrs_iu_free(struct rtrs_iu *ius, enum dma_data_direction dir,
 
 	for (i = 0; i < queue_size; i++) {
 		iu = &ius[i];
-		ib_dma_unmap_single(ibdev, iu->dma_addr, iu->size, dir);
+		ib_dma_unmap_single(ibdev, iu->dma_addr, iu->size, iu->direction);
 		kfree(iu->buf);
 	}
 	kfree(ius);
-- 
2.20.1

