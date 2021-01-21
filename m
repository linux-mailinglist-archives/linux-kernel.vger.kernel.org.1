Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468202FF2E5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389527AbhAUSIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbhAUJrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:47:16 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4D1C0617BE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:45:46 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id b5so1045524wrr.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BeYhM/gH7brge1QkCSipQ9tBDSDjW9MlS8bPaE7B1A8=;
        b=s9i6jxDv4DkGnMgES+kvI+EHj5xw6cQL4eG5xYhN4oM1HkzqyoYJV0Ao0jFg8JOYEw
         aZnw1pTt3BZXyFRP0+K0nifWKcv58QfF4O1GuVXA4VZL4Qq7M+IwDwnIHHII3uNGXRO/
         GfXnfPhRJbp1mzdCsNgM63dXcTBQToZIjd9vxbEx1YzHHLkX/BQOkg0+1QpnsKBaIOKP
         LpNZygecWRovslicC8zBYIVSOtYBFyBInuyEQG7h/DOTiQEL+tL6cDYPoZMY8ZD7l5gf
         Mm7zcCeK4pXqwsN2NSQEBqpOoP509zpHNux4USeBfMkbJr5WruIdeSDbopcUDPC5A8J/
         BiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BeYhM/gH7brge1QkCSipQ9tBDSDjW9MlS8bPaE7B1A8=;
        b=Fdp26MBjB0SPCqol8oc23EV1bMCJTmMv7yYVWyUTRcuRI3nRB53VqzPubPdpggJs6C
         0SG3PymTSHw80R1NuoFXj7+QgTMH1jLWdw+IWLBpKonUeRQJGZAKCz0/DjRUb5XrfzSm
         URJCAC0XDqzF0Dh3gxF2Mxii71x1T4SwoPEQgWzr1Nmv+EGi1kXXyhPcQmUtebwaUfeR
         bhuzTk5ZiLuqdT6NqZj3QS2zoSImRksOOdg8JzZduCXLK0FqRFESbNBYdD0EOQxA35pQ
         2HqNvRNSW2rAhg/XVA5Gz/5kk55lVh1SYKmqZV2PD8HPzL27SVJ25FrmiCsRtnHlsL84
         l+6A==
X-Gm-Message-State: AOAM530JE07VoYKXQ0ouNPpvuLNqPlef2Ox5828Yx1d5kY7c1WQY0kOS
        P6/ML3WTFo9tDKs5lDeSnT1sng==
X-Google-Smtp-Source: ABdhPJxQDZ4TDz20U4Hz/CUPoBCqpHFrj1gif6aIbNNCTV3hySivt6MTDBAN20GqXnEtYA3PqrHfYg==
X-Received: by 2002:adf:f684:: with SMTP id v4mr13529216wrp.387.1611222345752;
        Thu, 21 Jan 2021 01:45:45 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 18/30] RDMA/hw/qib/qib_uc: Provide description for missing 'flags' param
Date:   Thu, 21 Jan 2021 09:45:07 +0000
Message-Id: <20210121094519.2044049-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/qib/qib_uc.c:49: warning: Function parameter or member 'flags' not described in 'qib_make_uc_req'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/qib/qib_uc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/qib/qib_uc.c b/drivers/infiniband/hw/qib/qib_uc.c
index 554af4273a131..8e2bda77d8b9c 100644
--- a/drivers/infiniband/hw/qib/qib_uc.c
+++ b/drivers/infiniband/hw/qib/qib_uc.c
@@ -40,6 +40,7 @@
 /**
  * qib_make_uc_req - construct a request packet (SEND, RDMA write)
  * @qp: a pointer to the QP
+ * @flags: unused
  *
  * Assumes the s_lock is held.
  *
-- 
2.25.1

