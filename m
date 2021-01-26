Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3003F303DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404021AbhAZM63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404084AbhAZMte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:49:34 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA49C035437
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:47:44 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f16so2328969wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mFF2QQVIxFNp90Nwp9Ycl+uVfrjIiAZ/XTfl8r5ymZw=;
        b=NXFo+MjsuwTE93TK1DXo22fdhXCsOJIX5os6D2un8k+TfF0W44WoEx8MopsRfuCdFP
         pIn3+whREwoX42q32xde47Zzi8jcBHeSBj8KhF2hGXRuY5TEnqgNLP0pz2qmZx54wzbZ
         0jOPdZxcPF1X0mEDAY0EGa5YheyaWiwkhkftdIx2p2j49lsQFhd7j95rIxZ4XCYnzuZe
         7DRDSVMUa3Fvj1LwXMU1aIp04wUxnyoO2kKVMylJrKaa+ZhJM3tGMyXKRN0xlU/p88r2
         Go7KHM9PALmv9xdbU5dG1UiG9BTBIqz+vpu5ohnoNfBrFNOWNlEZzZ6S3RUdSgKQLe5j
         gx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mFF2QQVIxFNp90Nwp9Ycl+uVfrjIiAZ/XTfl8r5ymZw=;
        b=JL3NKfkrc89EjSZMx/5JKN2vkA164gv4RxdFnvuNyFl+bRQa1wPZV5mV1/oRL8HVQt
         ELklFi1zfOQ3u/HU+SLsyGJBOrFx2FRXBSIYrqgsfqa01NS56hdduLWPCJ9CXniRrmXJ
         49WfdbRbWtcXmfrAU7TeJLSS0nl4fahmin/KGlxjEsshbbnzl9pDD53Vlu6o49bGx1/w
         yVJ4Na3nZsPt9FCjZ0GdS6ht8au9pA+GMK1P2gEAa6z99CacF9Hh3vDi4VMrjHiWbZn+
         kw3RmMuhEd0c4z9rSQBLc2K7qiB4s0q8m2/UWlwsdqKLJ1/uRq4hr8X/5hZPYUKwUDig
         EBdA==
X-Gm-Message-State: AOAM531YLXvBI9fhSiyFgMD/jVO5rpKWakicSp+HdV7pCqtRAOTlnAKD
        DBb0S3/upfZUOR5HlZCzbtbTlA==
X-Google-Smtp-Source: ABdhPJxtqqXwmCwTwN6bwBokU5s+qmzfaQug5nE09DpjSUdLE2Dv+s4i9mbjVL986WtG7WXLmHmm4Q==
X-Received: by 2002:a1c:2c0b:: with SMTP id s11mr4371432wms.13.1611665263563;
        Tue, 26 Jan 2021 04:47:43 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:42 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 07/20] RDMA/sw/rdmavt/qp: Fix kernel-doc formatting problem
Date:   Tue, 26 Jan 2021 12:47:19 +0000
Message-Id: <20210126124732.3320971-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/sw/rdmavt/qp.c:1929: warning: Function parameter or member 'post_parms' not described in 'rvt_qp_valid_operation'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/sw/rdmavt/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 76d6bbfbec50c..9d13db68283c2 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1907,7 +1907,7 @@ int rvt_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 /**
  * rvt_qp_valid_operation - validate post send wr request
  * @qp: the qp
- * @post_parms_ the post send table for the driver
+ * @post_parms: the post send table for the driver
  * @wr: the work request
  *
  * The routine validates the operation based on the
-- 
2.25.1

