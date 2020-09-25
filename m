Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFC4278F69
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 19:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgIYROU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 13:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgIYROU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 13:14:20 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF41C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 10:14:19 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x14so4394794wrl.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 10:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UkJQkgxlCkpkuLOE/Q3El9felYbibhXuloA7k0x4JyI=;
        b=ZlNiRIkOkXJqutxJ0ssp9r47paHkzJClbD4Tk0P4C0UD4cNUSIi7yp/EZKBDiDdpN0
         SOTDpQQQP3ikiX0wQRKxnFTpivoRtYXjF1JMfhsgO+AxALJapC6jaXXLATt76BZLHsIi
         XJOMaLM3bV7ejNeRg9nkbjSN6XXIq1WcrdZ5CxbkVA6WeGUitmZ0BfZ4EK6b8ZXuXUXB
         +g+CTTO52Nck3KXtSc0Q2hJQ6ZnNJCrSGj4cwwawEkSCBsty1wfm6hJn1XilNWAxuPDB
         nQyMgXesohPZ1GLq6/GwMSKcn4Hj2HH4nAFR4jaWj/NeZOA/rQRSi72e8p3QIjIz9afP
         wNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UkJQkgxlCkpkuLOE/Q3El9felYbibhXuloA7k0x4JyI=;
        b=HIc9zB1/dHcrOd/XdSKgNLrCYkbtpM53uX3lnupUePozegv0YYMmqeq9DkGZeUorfn
         t258M78YbBEQ1+DaxTqU4S13LqkYEEq2Q+Qib+IrM8+xu3jr9lfQzdxMrFf54an7eYKf
         KCZ/s7C/FAWcWcBSsUTE5vERCgKZ5qWefs4AAhdjD9wsxyD3TcrsIPaXHx4B4gTjWczn
         n02/4Bg76PuFMqfiC8ReUHLxi7NwYWWeoh/jJ0EzE7azz2J3ILSvKRo8sq22jgBX8Tiu
         7sLzHLwNkPJH9B+xNjVx5Vcq/YE9ynLsR9G2vC7oGDWpz49W7loAY08PVzhj0zjPxePP
         biRQ==
X-Gm-Message-State: AOAM530kakbupiy4C+YJQiUUQ3AbDL5jN6QbwSYTGL2GztSrRKmGP1zZ
        kXjMd+/8caEOfm+blWfhczlfA8QyhHs=
X-Google-Smtp-Source: ABdhPJygV5G5oqu+uRqBQxFOwPAwUnVV+BCqvHTTf+zQ5A3HeorHz8Q3O7wZhQ24hck/v2yuPzWNXQ==
X-Received: by 2002:a05:6000:151:: with SMTP id r17mr5465281wrx.311.1601054057966;
        Fri, 25 Sep 2020 10:14:17 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id a17sm3858358wra.24.2020.09.25.10.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 10:14:16 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs/gaudi: use correct define for qman init
Date:   Fri, 25 Sep 2020 20:14:15 +0300
Message-Id: <20200925171415.25663-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a copy-paste error, and the wrong define was used for
initializing the QMAN.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index a227806be328..5f65a1691551 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -2039,7 +2039,7 @@ static void gaudi_init_hbm_dma_qman(struct hl_device *hdev, int dma_id,
 		WREG32(mmDMA0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off,
 							QMAN_LDMA_SRC_OFFSET);
 		WREG32(mmDMA0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off,
-							QMAN_LDMA_SIZE_OFFSET);
+							QMAN_LDMA_DST_OFFSET);
 
 		/* Configure RAZWI IRQ */
 		dma_qm_err_cfg = HBM_DMA_QMAN_GLBL_ERR_CFG_MSG_EN_MASK;
-- 
2.17.1

