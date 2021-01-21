Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BDA2FF2EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731853AbhAUSJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbhAUJrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:47:15 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F4FC0617BB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:45:45 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v15so1060392wrx.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bQj9Yz0LsqxFRbs970izNlVd0TnTgiu7VPZTWgmuulQ=;
        b=hm9y9/U251qJnd1mNpICdUnfsUijKIs0K8BN6Sxq6UmgDsd0Ncwa8J50V0M35XwoRc
         pQ3Kl7ovk4sfJxgy0/1xk/r4SS7x9npQ+aAtgfU4ySGCvjgrSrMpcWrRT7DUw7ykli1P
         mRF7+fxkl1S6FODlz2He88YQ8nodQAAR14XRMlcoyJAjZXeGphGEnXfDFiXvlaMaPrx9
         Ntmk6/StXCD+3q3hJ96dXv/zpX3Dv1nGN9ulokXpLLf5GxXGaZYjYftCt8+jE+HgdFh8
         KZXdjDd3x7vJsGhzyeg4+WwujH4vnHt/XU344ATGeobEekKSyTjE/GCPIGLgMifGA9KU
         bRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bQj9Yz0LsqxFRbs970izNlVd0TnTgiu7VPZTWgmuulQ=;
        b=Nk957avCQMlFk0DdRB9jR6tmIhvUJ2RkM+GLU/Q9wTvJ5dHDQ7Mq5/dMeQyNhgdqh3
         BC0DsNMZWioU8CxCFSWsxd8sZIYW0eDTaXPUyyL1OSXVkebOQQkG7SYvZgsVJPBb8AzU
         OUY8IINt4lxIX8UASDItK7KYU93Vl8eByK3vPt/GfBAGe5bKJeXMiLvAykVNVHxIoung
         sJoNstK3bIwSa1Dt/X6FDrB9OBLlpT5+rccLgYcmDHZCZrdkBaOeGjWJTh6w4rTE+cG3
         /uppSI1P7RJo5a2lQYxpmGA2pXjj85iuxGtiysYxx+4ACoeeViLl0DkvP6bg5Q0SzaM/
         pYLw==
X-Gm-Message-State: AOAM532DFmxkUEHcsuGngLZL6hCN/FKYlNmD+SmFX62UTiu+lGWPgxmi
        MC2H6DMSmQQNaMHnJJjHcHg8IA==
X-Google-Smtp-Source: ABdhPJyFMznrk9mjmBUMiZvtOK9aG393nTPehjVw8PPdCM3jpKQ/UvucvDGqnqPYKjf5weOAXCOwJA==
X-Received: by 2002:adf:efc5:: with SMTP id i5mr13033790wrp.377.1611222344559;
        Thu, 21 Jan 2021 01:45:44 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:43 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 17/30] RDMA/hw/qib/qib_tx: Provide description for 'qib_chg_pioavailkernel()'s 'rcd' param
Date:   Thu, 21 Jan 2021 09:45:06 +0000
Message-Id: <20210121094519.2044049-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/qib/qib_tx.c:383: warning: Function parameter or member 'rcd' not described in 'qib_chg_pioavailkernel'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/qib/qib_tx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/qib/qib_tx.c b/drivers/infiniband/hw/qib/qib_tx.c
index 29785eb846469..6a8148851f21d 100644
--- a/drivers/infiniband/hw/qib/qib_tx.c
+++ b/drivers/infiniband/hw/qib/qib_tx.c
@@ -377,6 +377,7 @@ void qib_sendbuf_done(struct qib_devdata *dd, unsigned n)
  * @start: the starting send buffer number
  * @len: the number of send buffers
  * @avail: true if the buffers are available for kernel use, false otherwise
+ * @rcd: the context pointer
  */
 void qib_chg_pioavailkernel(struct qib_devdata *dd, unsigned start,
 	unsigned len, u32 avail, struct qib_ctxtdata *rcd)
-- 
2.25.1

