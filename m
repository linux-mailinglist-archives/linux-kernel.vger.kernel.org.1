Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F67303DE2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403783AbhAZM5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404070AbhAZMtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:49:32 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95F9C0698C6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:47:43 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v15so16308578wrx.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JqnwtQpR7zRjxIxGO7OfabuwI6zTkwI4IUC4xHbde+s=;
        b=cvBHhXkuxzLiX4OWL+cfWzUSDdd4nPQDjG7e6O1QSdyaTPN7Yt35vJ9pbIvvuVUdfp
         KM5HmyTi7kZjfI9KbsyBD9kJY2TGHCPIQ9AuVvkCyGyPf5EF52V0RnWi2Akf0/3Z8yQi
         +/aw38tTxASeKdQcOyvftC9hve/tcgnAw6k0yAAIY1Mh3pjyMRIg+AwpM/jvl9Xc8Jao
         pDF2MkqQLJ517MBxidBsH+ri6DTNvZZfTLRJUzvoTJ1ovH/W0fTAef8t2SOW8Qs1O4Kp
         GAUVCTTAvY4jxK7gZUZb0PVaHjsapSFM68bSTZi6exaViaHjAgjkplPbjJaBnPphTewQ
         bXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JqnwtQpR7zRjxIxGO7OfabuwI6zTkwI4IUC4xHbde+s=;
        b=e3w+klSJu6hCPTqqd0rAt2bwD2RppZjOt8XtfwtPo8FWIco+qrYzsLGmFvO0oh7VlE
         n1T8nprHqjqimpMHOHrfm+AS8sZf7iNIMHUlplPio6bXmyE1wTO7UWI2i0hpT1LAJ2fQ
         DFDy1JjVIFGShbKGzXoKMC+WguU+Jq3vaYFCJxWTgYl8NLRSmzwvqtk9cbprzG/hK9Sh
         kZwK6ZTe01z7WebzeL5Ehbev3+pRYuJFik0YacZ33xxz5sb93cxC4f41wLt+drsBNWNH
         2WnccbUof+gipA5c7I35ROoMetbYVlFQ6lJVzgPr/GUZAYnklesFIgcdVe/Jw4D1CFdS
         E07g==
X-Gm-Message-State: AOAM531zWw9DJEm4OptSfhG1DBJ6ZgevU0yTwM0ftgWAQSlk7mwlJ/Wd
        6OkMVmCk72hYjn6MXm5t2liImQ==
X-Google-Smtp-Source: ABdhPJypSWwMtVwU6H4CcatzRF+WbHG464YrhUgYvMZYokv2g6bW06791dituSqjsOiwOz40Kp6DMg==
X-Received: by 2002:a5d:6847:: with SMTP id o7mr5944354wrw.216.1611665262428;
        Tue, 26 Jan 2021 04:47:42 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 06/20] RDMA/sw/rdmavt/mad: Fix misspelling of 'rvt_process_mad()'s 'in_mad_size' param
Date:   Tue, 26 Jan 2021 12:47:18 +0000
Message-Id: <20210126124732.3320971-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/sw/rdmavt/mad.c:78: warning: Function parameter or member 'in_mad_size' not described in 'rvt_process_mad'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/sw/rdmavt/mad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rdmavt/mad.c b/drivers/infiniband/sw/rdmavt/mad.c
index 8cc4de9aa6644..fa5be13a43944 100644
--- a/drivers/infiniband/sw/rdmavt/mad.c
+++ b/drivers/infiniband/sw/rdmavt/mad.c
@@ -57,7 +57,7 @@
  * @in_wc: the work completion entry for this packet
  * @in_grh: the global route header for this packet
  * @in: the incoming MAD
- * @out_mad_size: size of the incoming MAD reply
+ * @in_mad_size: size of the incoming MAD reply
  * @out: any outgoing MAD reply
  * @out_mad_size: size of the outgoing MAD reply
  * @out_mad_pkey_index: unused
-- 
2.25.1

