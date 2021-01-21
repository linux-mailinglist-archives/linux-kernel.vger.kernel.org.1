Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B25E2FF30F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388134AbhAUSUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbhAUJqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:46:05 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49739C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:45:25 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id v184so938658wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XqHnJ2PCqY0GDD9E/M7j7TZIcrnsj5geJs7YkKXUyyQ=;
        b=RTUKiq8Os5P5UyzCC/cUjVpVnM5DorMjaNn+QkLgBUSmF/z/Onh3iZAYn+of7tsD5T
         oZNB2XQtiosWQEzjBU4S7sraSsPlxge80pYuBywKY+agV/0tfHSLbKKwuwKMYQGcPYS9
         7Fw7BcHG1/fzSbVYb6DHGfdUNNsoyN6ak+SC9yEn6m9a3mRp/yFY6hAx9cSjZRl59v+P
         RzMbbG/FHz/yfOm6cM0O/4TUSjiWpCSGZ1hLM2RU0Fj4TSxKlvzPmmfBiPXKm+WHTJPg
         Z9L1r5lJs82BSrmnaBxeIklNWH5VFelO+F4FJBSTtqmv1JiCGo8xDGwTEVxTpgxmCRag
         LGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XqHnJ2PCqY0GDD9E/M7j7TZIcrnsj5geJs7YkKXUyyQ=;
        b=ZDIgOKJL/mO/c97SA3Y3jpW/Bf99ObOeXiaRGakYkXSWALDNwUuT6+2mbxyms5b/5i
         hH5ePbXdIK9yQQ+26o7MnLVIG/04LxQwfV9D6WxAKcV2/FATi4GxGUWpJs5F/0CeULmh
         bFeyNn/fOOH0qvY1LrxORaD8JS7kJjXHC0Vh+DRmj0KETD9g71OhdKBveSL7O1xKVQZQ
         4HrSvuWGy1Sqk1LioqEJkQYmCUv9QnDPEI+zi+SeortitJdNnLB/W1qRku4PkzwGW/ar
         eVI2iswD6SWLQ8neP+1COEn+l6Dg/XI+jQ8ua9VbdGU5kYeobaxd27zL792pspkNfLh2
         7uGA==
X-Gm-Message-State: AOAM531dqgc5drFabn/RcaqNa62g/vtBWoq8Iv8fXpNUvvj8+jJbjsnn
        EfOK4obr+CoUK87y1Q6NmO7Bww==
X-Google-Smtp-Source: ABdhPJxZCaAzCae2wKCuVCpT+4ho7qtdoImSFpg9c2BEz0qXsuK08X7w5N74AR8JZOUHinI5F+y9ow==
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr7997443wmj.117.1611222323296;
        Thu, 21 Jan 2021 01:45:23 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:22 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 01/30] RDMA/hw/mlx5/odp: Fix formatting and add missing descriptions in 'pagefault_data_segments()'
Date:   Thu, 21 Jan 2021 09:44:50 +0000
Message-Id: <20210121094519.2044049-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/mlx5/odp.c:1062: warning: Function parameter or member 'dev' not described in 'pagefault_data_segments'
 drivers/infiniband/hw/mlx5/odp.c:1062: warning: Function parameter or member 'pfault' not described in 'pagefault_data_segments'
 drivers/infiniband/hw/mlx5/odp.c:1062: warning: Function parameter or member 'wqe' not described in 'pagefault_data_segments'
 drivers/infiniband/hw/mlx5/odp.c:1062: warning: Function parameter or member 'wqe_end' not described in 'pagefault_data_segments'
 drivers/infiniband/hw/mlx5/odp.c:1062: warning: Function parameter or member 'bytes_mapped' not described in 'pagefault_data_segments'
 drivers/infiniband/hw/mlx5/odp.c:1062: warning: Function parameter or member 'total_wqe_bytes' not described in 'pagefault_data_segments'
 drivers/infiniband/hw/mlx5/odp.c:1062: warning: Function parameter or member 'receive_queue' not described in 'pagefault_data_segments'

Cc: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/mlx5/odp.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index aa2413b50adc9..7b30be6aeb167 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1040,16 +1040,18 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 /**
  * Parse a series of data segments for page fault handling.
  *
- * @pfault contains page fault information.
- * @wqe points at the first data segment in the WQE.
- * @wqe_end points after the end of the WQE.
- * @bytes_mapped receives the number of bytes that the function was able to
- *               map. This allows the caller to decide intelligently whether
- *               enough memory was mapped to resolve the page fault
- *               successfully (e.g. enough for the next MTU, or the entire
- *               WQE).
- * @total_wqe_bytes receives the total data size of this WQE in bytes (minus
- *                  the committed bytes).
+ * @dev:  Pointer to mlx5 IB device
+ * @pfault: contains page fault information.
+ * @wqe: points at the first data segment in the WQE.
+ * @wqe_end: points after the end of the WQE.
+ * @bytes_mapped: receives the number of bytes that the function was able to
+ *                map. This allows the caller to decide intelligently whether
+ *                enough memory was mapped to resolve the page fault
+ *                successfully (e.g. enough for the next MTU, or the entire
+ *                WQE).
+ * @total_wqe_bytes: receives the total data size of this WQE in bytes (minus
+ *                   the committed bytes).
+ * @receive_queue: receive WQE end of sg list
  *
  * Returns the number of pages loaded if positive, zero for an empty WQE, or a
  * negative error code.
-- 
2.25.1

