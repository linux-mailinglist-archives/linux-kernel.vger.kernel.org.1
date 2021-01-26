Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7549303DCA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392300AbhAZMvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392138AbhAZMt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:49:58 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48CCC08EB26
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:47:51 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m13so1882574wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4f4I65tHSu0Sevubz3lp3Zk+K7fk0+tHrgiLNeMd+Rc=;
        b=p4HdJ6LjNhnbcw4Rkb46d4O637uRz+G/y5kFGVkp3mw/I0eBw5VnPxLp4bvxxC6wPD
         GUyd4XS8uv/MF76CwjocbLJjE/kwtXYQ+If2ymHM+H/TPnFDJnXwSXLLdWBhlOJ4MQBn
         nNO/VP+yk6ec2yyGbteddQCv3ieCJxN/y5KZ+AnFkCHYtohS/SQxbSQxTaGYs3+iqI0P
         tOWUnxm8z/PTmJkNGaUVOnm9brIEBrrC6EjUD72jUJkyPtLQ5kljrZhftYjfpDSmgdec
         4yGsORj7TSSiL+/AspbTUt4v+Ni4/pBRg9UtqRw/eDSoHo/NE7EZm1Nbw+cuJCQqSOKh
         p+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4f4I65tHSu0Sevubz3lp3Zk+K7fk0+tHrgiLNeMd+Rc=;
        b=Vid0vIkAey146bglRvTcRLp1UQgVccZqTi/Fn6aNE1Wt55IU7+byx06j1f2d2giv+C
         2zjvK5KjVnfHBxvrubbxUaWSU1A6zYnn+0JH3Y3zy9apHGG1fsXqUew/d0FN56PEvOEl
         jTTPEq8F+j8i8w673VqPpEapAKlvToNHv4kOBBrmnHMR68nGxNnuIpgmy1j2sdgC/dVH
         w1gqNlsd7Tq4NDRuO5S5Wy5JEG21F/q/hnjRqqYpBIHMy0hiRcupA0BJexlkVx4IJYHi
         R9aPs+yKyyr3iCVztISlxdZMjJXK8ptivm56g6nqfp343iAI8s9E5orrYfLRG6ZdPELL
         rT4g==
X-Gm-Message-State: AOAM5329wN0AIUTuYCpQPrDtG0SeMxRRHxM6Ybt9zoSDYEweWtrERp+M
        kBFEDCYUY219DnBCa9CH9nBxaA==
X-Google-Smtp-Source: ABdhPJwFJFyJiQxPN+ieJwSG+epJ+dfgs4HDsCWwPmw6XySAq1DHWA1Fxp8sJuDlEEZ9YiFCba30Dg==
X-Received: by 2002:a5d:414c:: with SMTP id c12mr6099593wrq.251.1611665270492;
        Tue, 26 Jan 2021 04:47:50 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:49 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 13/20] RDMA/hw/hfi1/ruc: Fix a small formatting and description issues
Date:   Tue, 26 Jan 2021 12:47:25 +0000
Message-Id: <20210126124732.3320971-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hfi1/ruc.c:277: warning: Function parameter or member 'bth1' not described in 'hfi1_make_ruc_header_16B'
 drivers/infiniband/hw/hfi1/ruc.c:365: warning: Function parameter or member 'bth1' not described in 'hfi1_make_ruc_header_9B'
 drivers/infiniband/hw/hfi1/ruc.c:472: warning: Function parameter or member 'tid' not described in 'hfi1_schedule_send_yield'
 drivers/infiniband/hw/hfi1/ruc.c:472: warning: Excess function parameter 'timeout' description in 'hfi1_schedule_send_yield'

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hfi1/ruc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ruc.c b/drivers/infiniband/hw/hfi1/ruc.c
index 23ac6057b2112..c3fa1814c6a86 100644
--- a/drivers/infiniband/hw/hfi1/ruc.c
+++ b/drivers/infiniband/hw/hfi1/ruc.c
@@ -260,6 +260,7 @@ static inline void hfi1_make_ruc_bth(struct rvt_qp *qp,
  * @qp: the queue pair
  * @ohdr: a pointer to the destination header memory
  * @bth0: bth0 passed in from the RC/UC builder
+ * @bth1: bth1 passed in from the RC/UC builder
  * @bth2: bth2 passed in from the RC/UC builder
  * @middle: non zero implies indicates ahg "could" be used
  * @ps: the current packet state
@@ -348,6 +349,7 @@ static inline void hfi1_make_ruc_header_16B(struct rvt_qp *qp,
  * @qp: the queue pair
  * @ohdr: a pointer to the destination header memory
  * @bth0: bth0 passed in from the RC/UC builder
+ * @bth1: bth1 passed in from the RC/UC builder
  * @bth2: bth2 passed in from the RC/UC builder
  * @middle: non zero implies indicates ahg "could" be used
  * @ps: the current packet state
@@ -455,11 +457,10 @@ void hfi1_make_ruc_header(struct rvt_qp *qp, struct ib_other_headers *ohdr,
 /**
  * hfi1_schedule_send_yield - test for a yield required for QP
  * send engine
- * @timeout: Final time for timeout slice for jiffies
  * @qp: a pointer to QP
  * @ps: a pointer to a structure with commonly lookup values for
  *      the the send engine progress
- * @tid - true if it is the tid leg
+ * @tid: true if it is the tid leg
  *
  * This routine checks if the time slice for the QP has expired
  * for RC QPs, if so an additional work entry is queued. At this
-- 
2.25.1

