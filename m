Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA752FF2F7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389380AbhAUSLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728906AbhAUJq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:46:58 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4BCC0617A2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:45:35 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id s24so4633467wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L2I8dCKIs3PfH9t5ebM9UIW4X6/Lh18WEUkSq5oyF1c=;
        b=Nv2ll40o/1jNkvdCMnMHS8IeGvGLQxo5qX+lL0/yj3gapBl0p+YUjhj4taNi8NgJpz
         ApPYPjbxdNur+YfZYdmDtWaYIg3Vk5ZchnPrTz8+w5gPgQJ+mETHyZVCoLPOX8/rF/AQ
         +uNYfWEJnvfP9r7Saq9S5H/PixWwbStCT/7K+l6w71MIOMh1ywv1wS05Si4RopylAjZw
         YmiGSdozEKgnY9Rvb+JDyEDQZcIRGxo4y9MvP5FONJrpUzuMg7lWtD6c4RfcEihk20LE
         ZqCz9M3X66cUaHDS1XuQFZblb1DVOXSDKNR3mgFT1kLGPAU/h8W5qDJQ4Uqr626zDUGq
         JZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L2I8dCKIs3PfH9t5ebM9UIW4X6/Lh18WEUkSq5oyF1c=;
        b=OjXL9ZPSCXsabABEyA/ZGiG33Um34dDBw2pKTvM0jDLjCuH8ta/2GAdkvfuSeRclQd
         EiyeIyVcHP4PZF1M4eHjPLKWRVzuC/9ARVVxLrJAiJ5nax6wenjk85vjtSTOST52aniu
         tfAd/ouU7Ch74zkIiQLpmKys35FC7MLYaT9WqIdDAei3iYi7+x99X/uJnlQMmo4szxRg
         54uqXIyDqVK6j2szNeuGh7NxgINC6Dg46Jr5iaHxexesUCYDqGcSihvEzwyIenbT7nS6
         yYn3tmc2hxSNNc+jIAvDu/8QsTVpqKXjrfPEt0WNyk1ahLnPxeFY8b6pdRuPs2Kjh13n
         cF7A==
X-Gm-Message-State: AOAM533ByyxaiyT41Fz/NnZ8otTlPtFSRnsgmSiTuY9+5OJiFlMiYMr2
        etVH6i+oex7AULyvfoDOWXrXzQ==
X-Google-Smtp-Source: ABdhPJwQF2LMwnM2UWIfClu/IM8MwWBJ8P9C/RaSSGEx6Tgbv96zNiFUr+W7lvYe6cZlixx4F2U1zg==
X-Received: by 2002:a7b:c854:: with SMTP id c20mr7978977wml.127.1611222334495;
        Thu, 21 Jan 2021 01:45:34 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:33 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 10/30] RDMA/hw/qib/qib_intr: Fix a bunch of formatting issues
Date:   Thu, 21 Jan 2021 09:44:59 +0000
Message-Id: <20210121094519.2044049-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/qib/qib_intr.c:48: warning: Function parameter or member 'msg' not described in 'qib_format_hwmsg'
 drivers/infiniband/hw/qib/qib_intr.c:48: warning: Function parameter or member 'msgl' not described in 'qib_format_hwmsg'
 drivers/infiniband/hw/qib/qib_intr.c:48: warning: Function parameter or member 'hwmsg' not described in 'qib_format_hwmsg'
 drivers/infiniband/hw/qib/qib_intr.c:64: warning: Function parameter or member 'hwerrs' not described in 'qib_format_hwerrors'
 drivers/infiniband/hw/qib/qib_intr.c:64: warning: Function parameter or member 'hwerrmsgs' not described in 'qib_format_hwerrors'
 drivers/infiniband/hw/qib/qib_intr.c:64: warning: Function parameter or member 'nhwerrmsgs' not described in 'qib_format_hwerrors'
 drivers/infiniband/hw/qib/qib_intr.c:64: warning: Function parameter or member 'msg' not described in 'qib_format_hwerrors'
 drivers/infiniband/hw/qib/qib_intr.c:64: warning: Function parameter or member 'msgl' not described in 'qib_format_hwerrors'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/qib/qib_intr.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_intr.c b/drivers/infiniband/hw/qib/qib_intr.c
index 65c3b964ad1bf..85c3187d796d9 100644
--- a/drivers/infiniband/hw/qib/qib_intr.c
+++ b/drivers/infiniband/hw/qib/qib_intr.c
@@ -40,9 +40,9 @@
 
 /**
  * qib_format_hwmsg - format a single hwerror message
- * @msg message buffer
- * @msgl length of message buffer
- * @hwmsg message to add to message buffer
+ * @msg: message buffer
+ * @msgl: length of message buffer
+ * @hwmsg: message to add to message buffer
  */
 static void qib_format_hwmsg(char *msg, size_t msgl, const char *hwmsg)
 {
@@ -53,11 +53,11 @@ static void qib_format_hwmsg(char *msg, size_t msgl, const char *hwmsg)
 
 /**
  * qib_format_hwerrors - format hardware error messages for display
- * @hwerrs hardware errors bit vector
- * @hwerrmsgs hardware error descriptions
- * @nhwerrmsgs number of hwerrmsgs
- * @msg message buffer
- * @msgl message buffer length
+ * @hwerrs: hardware errors bit vector
+ * @hwerrmsgs: hardware error descriptions
+ * @nhwerrmsgs: number of hwerrmsgs
+ * @msg: message buffer
+ * @msgl: message buffer length
  */
 void qib_format_hwerrors(u64 hwerrs, const struct qib_hwerror_msgs *hwerrmsgs,
 			 size_t nhwerrmsgs, char *msg, size_t msgl)
-- 
2.25.1

