Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC644303DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404138AbhAZM7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404096AbhAZMtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:49:36 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22833C08E86E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:47:48 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id 7so16323848wrz.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E3TPshJEOpUxZ52hskTlO67Qqk3Ra8/d2GtrTB1ggtY=;
        b=aufbBYTlyyVvy/8ib6Safly+lDI/cY/nGr8NsKxe/qt3uC4pkYxC73Jdn/4NSG1fuh
         QqNK6OVg91g9NI6DZBVWL8/LZmAFRBrnCA+BZx12J8zIC3zCrxJ5rJwrFkQj7/2xF6Fc
         BNJYhamHsG7W8a+wVZ5TClIQrpttkKW32/vuMM8/LlrcZrwdyNm9M0LFcfB1KiVrKwUq
         75VfIIMsS3tAtdUIXCdhStc1+S5dRGRQ646jMovViooA/bDR5fiQ6lyP/nVg7Hi9XqMV
         xrk2tZP/n4LOU4uk7gZhp8TEkz+gFFgpFDkmm6N60J27ytL4Lu7GaoFRP6+NCqVbATkc
         J4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E3TPshJEOpUxZ52hskTlO67Qqk3Ra8/d2GtrTB1ggtY=;
        b=ft/0owzxa5ENfhiFVLvy30IWXPk8+aImwgU1dkOFn57aXy+WTB/6inyeltr1aLZqwv
         7UP8Xg3jmlKdQE3wYi75cNJvWz5u268iXRliHzU/+xKcSvUrkhGPnnuBGFD7s9YMefxg
         ehFx0U1LgiaOCW5ktCE7/mcZ8VOhF80jG2OPuh7AFG7nLrLmvRQHTQRlxKZ9/KHdgvko
         D7nrnrxRMuYPdfQzeME/343rZw+efZllLc/TXbRIjVpmUGRh7c0EtMgpDG4S3KURtrXZ
         8qEgSxVNmgbwyY6EPXpBFZIIAeQpZSgsGyhMidbw+E0TxXuyhbNTQgFCgPQ2hYf1De0S
         Rg3Q==
X-Gm-Message-State: AOAM531vfbiYxQiiNXM+LOoltLk5NIjupkcs0cp+aqMrsXLYnYGXtMqA
        8XKd6vqZQGA0+yS04118yIIB4g==
X-Google-Smtp-Source: ABdhPJzNGpzPPPE7/NWFHvm/KqfZ2gdr6pBlIKgL/nfMP+CSk3BohIx1TgiEfh8ZjrIeCxjOnpX3TA==
X-Received: by 2002:adf:dd45:: with SMTP id u5mr5869371wrm.392.1611665266932;
        Tue, 26 Jan 2021 04:47:46 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:46 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 10/20] RDMA/hw/hfi1/pio_copy: Provide entry for 'pio_copy()'s 'dd' param
Date:   Tue, 26 Jan 2021 12:47:22 +0000
Message-Id: <20210126124732.3320971-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hfi1/pio_copy.c:73: warning: Function parameter or member 'dd' not described in 'pio_copy'

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hfi1/pio_copy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/hfi1/pio_copy.c b/drivers/infiniband/hw/hfi1/pio_copy.c
index 4a4ec23978579..14bfd8287f4ae 100644
--- a/drivers/infiniband/hw/hfi1/pio_copy.c
+++ b/drivers/infiniband/hw/hfi1/pio_copy.c
@@ -55,6 +55,7 @@
 
 /**
  * pio_copy - copy data block to MMIO space
+ * @dd: hfi1 dev data
  * @pbuf: a number of blocks allocated within a PIO send context
  * @pbc: PBC to send
  * @from: source, must be 8 byte aligned
-- 
2.25.1

