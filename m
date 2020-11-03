Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA6B2A49CF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgKCPbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbgKCP3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:29:19 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B35C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:29:19 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id b8so19027046wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g+k7waY3+QfWzhVKGexLmvVmyJHPNqCtTC+98WzgpXQ=;
        b=IjSdgjyLA53oPRmCkUcqE9DncaAvo9Msl+j84z6LwG03L7XEelXSYEnE2hEVj4r6fX
         tswzhFM5GL+mh+oMSqvEZTi+j6x/CKr6AX79Qpl7H1C3lUVg1wtdHYNImer2t5IS31yM
         Hs78uWgfUPa4WxR6u4pIrVr6UN0Wap5ev/Sb/PqnEtj/3GUb7IIo3Q9GoboCfaf8/9Yv
         j6J1B/Y7ueW9jCNuwlNL6rpf08e9IJQk9PtjqN7YIXykryasGk87ZTrg3Gb/P1rxNEob
         gwfabOBOEE59+D4eQ4ojXtaDVZS3chXx2QVAALxEpfYuAYisZRQr086YQKWJLU0ATV+f
         EKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g+k7waY3+QfWzhVKGexLmvVmyJHPNqCtTC+98WzgpXQ=;
        b=GTTFcSW/d3IhAYttZbIIv5JkVLtoKOaP8M0kPlnjvGWcj41bPRMgpdEbnU34oCoSNQ
         Y235MIVePnJZsjZVCfDxGOqFd+k3C1A5jEpuUtgLYYxrJDgOyi0/7YGtGposqGg8cdOs
         B2Qm8qSHHVrNEjsS/l3JmaUWZwo+rwtUZcBZL4iXQzx+nuwIm9GntB2d6U8bh4rPKQkF
         w74Yxr4Mlse3XYw48L+udIPOOY2M8vcSTAOzofZydMSP3jn2FZ/iGZH1eYj1SKgYDoQu
         uW7q5Kg9jN2lPGp/USpWcnoqQGj5IZ+8Ek8NygKrekNcbBlI54M/COUEl3MUmbKpWIps
         MdaA==
X-Gm-Message-State: AOAM530yESaYjZk/D6sAprCNfW4QZSgjpRRfRw0h72jnZmT9zAoGoNxs
        Bg1h3LOYmzQ+cZGftaJoTgQrV0Wn8Ms4GU5K
X-Google-Smtp-Source: ABdhPJyZf1iQCvYS3vY2aG5u9NnlJ6CKeoiGoNrK+vkGmEIgxUKT2UMLnHx8lFwSZaOlDy8LgWxSeA==
X-Received: by 2002:adf:fc8b:: with SMTP id g11mr26960474wrr.300.1604417358112;
        Tue, 03 Nov 2020 07:29:18 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id j127sm3491779wma.31.2020.11.03.07.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:29:17 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Sandeep Nair <sandeep_n@ti.com>,
        Cyril Chemparathy <cyril@ti.com>
Subject: [PATCH 06/25] soc: ti: knav_qmss_queue: Remove set but unchecked variable 'ret'
Date:   Tue,  3 Nov 2020 15:28:19 +0000
Message-Id: <20201103152838.1290217-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103152838.1290217-1-lee.jones@linaro.org>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/soc/ti/knav_qmss_queue.c: In function ‘knav_setup_queue_pools’:
 drivers/soc/ti/knav_qmss_queue.c:1310:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Sandeep Nair <sandeep_n@ti.com>
Cc: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/soc/ti/knav_qmss_queue.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index a460f201bf8e7..f36c2dcb26911 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1307,12 +1307,11 @@ static int knav_setup_queue_pools(struct knav_device *kdev,
 				   struct device_node *queue_pools)
 {
 	struct device_node *type, *range;
-	int ret;
 
 	for_each_child_of_node(queue_pools, type) {
 		for_each_child_of_node(type, range) {
-			ret = knav_setup_queue_range(kdev, range);
 			/* return value ignored, we init the rest... */
+			knav_setup_queue_range(kdev, range);
 		}
 	}
 
-- 
2.25.1

