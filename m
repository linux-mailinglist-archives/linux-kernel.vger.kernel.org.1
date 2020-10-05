Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29467283857
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgJEOqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:46:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57667 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726849AbgJEOqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601909178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ptyKuh8WxjRCHezLemPMrH21hGCsiTIELZD7s9BSjQE=;
        b=DPEHuD+womOA2lb1nwiAWYUp/aOvKZI7+QWIeQ8GJ107XzXcb2UJd9zmErhMapak6uSZ1R
        wmTHdt5ZdqXZTmlcwQ9oVB4eWFGSHto5fNSYW9Z/sb0Krjt8NCPB0xbkQIvVqDc51QHmt3
        8tAiaUte4s1Pvag06iBiMAY1on2B+M4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-YHgSlCVZMiidS94yKOrePg-1; Mon, 05 Oct 2020 10:46:16 -0400
X-MC-Unique: YHgSlCVZMiidS94yKOrePg-1
Received: by mail-qk1-f198.google.com with SMTP id w126so6794276qka.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 07:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ptyKuh8WxjRCHezLemPMrH21hGCsiTIELZD7s9BSjQE=;
        b=RkO970RCpexkZAV7gHhE9duXic5Xd7kPZxahEcSOkTPrh2hExvy8aZ8mJycMYMAvF8
         H3huYU/Pb/1mq25GPctqWjI2R2Ec3VVZdPelr0WZk+cXhUbsSyjKq6VOyC/qApJlArfx
         AkBnOlEBhXrZI1pyrJXrhuyp70fmjxOs1uhSOQ3Dp046ZCCs1hUnEY9VjB6jALNGiU7A
         YydRChCJgXaaOEtNgLLhr1stZOKEr4dnBgUxhjKFwNH5VNLyvdmpRRE5PXZ5bu4c0U6F
         i9L7QrUejS9QawIEq9CnkQ+1bRx3favrOx0C7OM8awDlhZ4MgGbwQZ5v5md50u9Hkilz
         TDGg==
X-Gm-Message-State: AOAM530pS1eefzDNzfqOqna3bH8m3wHf+yiFeiuIlx8qFQI/MgP+Pkv0
        V+Pt0UgmAYDx7796RxE+GPzeyWRwSWkAM3omn9DoU/pOXKehfKayYdxyI5X61qJLw9N4dgTGeRh
        vJfx4h5pVavWQuN/HetPrZq8u
X-Received: by 2002:a37:62d6:: with SMTP id w205mr289253qkb.229.1601909176252;
        Mon, 05 Oct 2020 07:46:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRfTKS3+jTPIJZ4QlireY6tUWjq/ctyLnV1eg1G0RryjdqD9T03AY8QFV8BktptD3/3u4pFw==
X-Received: by 2002:a37:62d6:: with SMTP id w205mr289222qkb.229.1601909175969;
        Mon, 05 Oct 2020 07:46:15 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i90sm303450qtd.92.2020.10.05.07.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 07:46:15 -0700 (PDT)
From:   trix@redhat.com
To:     njavali@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, natechancellor@gmail.com,
        ndesaulniers@google.com
Cc:     GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] scsi: qla2xxx: initialize value
Date:   Mon,  5 Oct 2020 07:45:44 -0700
Message-Id: <20201005144544.25335-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem:

qla_nx2.c:694:3: warning: 6th function call argument is
  an uninitialized value
        ql_log(ql_log_fatal, vha, 0xb090,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In qla8044_poll_reg(), when reading the reg fails, the
error is reported by reusing the timeout error reporter.
Because the value is unset, a garbage value will be
reported.  So initialize the value.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/scsi/qla2xxx/qla_nx2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_nx2.c b/drivers/scsi/qla2xxx/qla_nx2.c
index 3a415b12dcec..01ccd4526707 100644
--- a/drivers/scsi/qla2xxx/qla_nx2.c
+++ b/drivers/scsi/qla2xxx/qla_nx2.c
@@ -659,7 +659,7 @@ static int
 qla8044_poll_reg(struct scsi_qla_host *vha, uint32_t addr,
 	int duration, uint32_t test_mask, uint32_t test_result)
 {
-	uint32_t value;
+	uint32_t value = 0;
 	int timeout_error;
 	uint8_t retries;
 	int ret_val = QLA_SUCCESS;
-- 
2.18.1

