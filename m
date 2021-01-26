Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD557303DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392173AbhAZMvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391934AbhAZMt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:49:56 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC73C08EB23
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:47:50 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a1so16329465wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bWXDn1Q9e79o1Ahbq11jdzTrjLD5igFdf2jngDni798=;
        b=GPuwh5UMbRYTIAqxWcuNWJoL/UZWeUSNS+EYoNcJ91J1TkfsGI0YNqhubB8RQGeReP
         neR90OV2gzOy6VqYlffob/ri5kelHkNcePX6VgL5r6gjn53vWKYh1VhkWeVMupGxgm6L
         Kyk2/aynygYowh/ZUb+kJT+/UzEgzQh8/S39Aj5luzRPazsi5gYNnVxOy25nQ2hIWfrW
         oEqQPDq0lO6Fu0Mc+7vHtAf6nkQJaDUyF6Lz4A2Ljfwt/JxlLysavqwwH2dYXWr97Er0
         tP+eCmUz7yoWJoSEEQm/BxcMxpvB5T0xjZLLveUJp5jFyX56K967T7uxSIKonfYu4t1T
         mj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bWXDn1Q9e79o1Ahbq11jdzTrjLD5igFdf2jngDni798=;
        b=CcZ3jAtZ/CVRNIehRejPYDpduWaKtwO4pxlkD7kbPiKPct59RQ9pir45QowbtNv6ly
         p7/WjpDMVAMqvgBfrvSK9ASMKkEKnGqdXsIMid2cSVZ11Q4Rp4+MQ+ku/I6EQ9oO5EER
         FDMNFyF08sCsiEt0pOfa8yqz6lyv+DboB5Ei9gbyZOBb26xpFIl2ItXcAd5UH8WMJKJr
         /WQdpnyS6U04p+yo+8VW3y0nErcETAz0oSKfNIi+F7QalAFvcQ0SV47eKpVS24vmtra7
         GejrzoMw4J6EREl3xx4KWZ+JcTtaVCPwld+yYEjzb294O6/3+r/OL978bRUuOYi0YeA1
         r56w==
X-Gm-Message-State: AOAM532x2SMll+AHSUmpEVL2p1LLNEguw+k4aeIoq+cbVRXr99y+urMg
        HojEvr4eY1NubMHzby59jxBz8w==
X-Google-Smtp-Source: ABdhPJyoqraqYP5Lncuk2TmsiQknmS5tV0xjuVaaRBE6kIXCodS8Icxj6NLW9Dse8QaRWrHHIWGA5g==
X-Received: by 2002:adf:f403:: with SMTP id g3mr5943566wro.212.1611665269305;
        Tue, 26 Jan 2021 04:47:49 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:48 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 12/20] RDMA/hw/hfi1/qp: Fix some formatting issues and demote kernel-doc abuse
Date:   Tue, 26 Jan 2021 12:47:24 +0000
Message-Id: <20210126124732.3320971-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hfi1/qp.c:195: warning: Function parameter or member 'dev' not described in 'verbs_mtu_enum_to_int'
 drivers/infiniband/hw/hfi1/qp.c:195: warning: Function parameter or member 'mtu' not described in 'verbs_mtu_enum_to_int'
 drivers/infiniband/hw/hfi1/qp.c:306: warning: Function parameter or member 'qp' not described in 'hfi1_setup_wqe'
 drivers/infiniband/hw/hfi1/qp.c:306: warning: Function parameter or member 'wqe' not described in 'hfi1_setup_wqe'
 drivers/infiniband/hw/hfi1/qp.c:306: warning: Function parameter or member 'call_send' not described in 'hfi1_setup_wqe'
 drivers/infiniband/hw/hfi1/qp.c:922: warning: Function parameter or member 'qp' not described in 'hfi1_qp_iter_cb'
 drivers/infiniband/hw/hfi1/qp.c:922: warning: Function parameter or member 'v' not described in 'hfi1_qp_iter_cb'

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hfi1/qp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/qp.c b/drivers/infiniband/hw/hfi1/qp.c
index 681bb4e918c92..e037df9115127 100644
--- a/drivers/infiniband/hw/hfi1/qp.c
+++ b/drivers/infiniband/hw/hfi1/qp.c
@@ -186,7 +186,7 @@ static void flush_iowait(struct rvt_qp *qp)
 	write_sequnlock_irqrestore(lock, flags);
 }
 
-/**
+/*
  * This function is what we would push to the core layer if we wanted to be a
  * "first class citizen".  Instead we hide this here and rely on Verbs ULPs
  * to blindly pass the MTU enum value from the PathRecord to us.
@@ -289,9 +289,9 @@ void hfi1_modify_qp(struct rvt_qp *qp, struct ib_qp_attr *attr,
 
 /**
  * hfi1_setup_wqe - set up the wqe
- * @qp - The qp
- * @wqe - The built wqe
- * @call_send - Determine if the send should be posted or scheduled.
+ * @qp: The qp
+ * @wqe: The built wqe
+ * @call_send: Determine if the send should be posted or scheduled.
  *
  * Perform setup of the wqe.  This is called
  * prior to inserting the wqe into the ring but after
@@ -595,7 +595,7 @@ struct sdma_engine *qp_to_sdma_engine(struct rvt_qp *qp, u8 sc5)
 	return sde;
 }
 
-/*
+/**
  * qp_to_send_context - map a qp to a send context
  * @qp: the QP
  * @sc5: the 5 bit sc
@@ -912,8 +912,8 @@ void notify_error_qp(struct rvt_qp *qp)
 
 /**
  * hfi1_qp_iter_cb - callback for iterator
- * @qp - the qp
- * @v - the sl in low bits of v
+ * @qp: the qp
+ * @v: the sl in low bits of v
  *
  * This is called from the iterator callback to work
  * on an individual qp.
-- 
2.25.1

