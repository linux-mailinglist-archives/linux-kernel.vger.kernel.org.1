Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACED2A49C0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgKCPaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbgKCP3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:29:40 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C82C0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:29:40 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 23so137382wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4T0Q2fKVzM+6dPcaAgGMklorWQEU7HaqxaYHJUTOC68=;
        b=bBcEJwdjfFz83XUUXZ3Q3w7mVRpuMDZKH2/FPREerwx9nuk0c+WOaA0XFc3Xe2RL6r
         c6sQPjwBJuchB2D9O9LtRjdP0iA80Ffd1mEZH3/wDZIH3Njz9/UEhDbLz4FEVUcL9Upi
         b6JT9JcVmgdgTV+3VdYBgsG4cIt+ubSBQFIOU0LCAalDtOylIeo3z5ITti8cg/EENLv+
         OOT33omYWVgbNCzhlYpS7Y5JN+vktaMYxzMzQ1vBd2GGI3ulTk7AlM6AazoPthRdLZLT
         MYkwDZuG4+eNAsGZZSmvua4wAXLB7MqKphfBmx3GaEaa5Fh0KBeBnZHalHTrHwA/hj36
         kysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4T0Q2fKVzM+6dPcaAgGMklorWQEU7HaqxaYHJUTOC68=;
        b=rpJrWz8oZeyZCcHvv3SoNQj9/Q33zi0nooBVtrOnBkPXqY0cTTRA3gVCzH4zxIK/i3
         B+qyK1NPeBAG2r9Ao1AzOg0OmLpkntm2wm/EH38ixnzdQOv9ejTB5JPYF9qbaaLrU4xf
         JH8PZIdOvz9kDxC1zxCWSj9pxLCeJy28YL+JtKOT5nNiFwlPnWyEm0f4gH7Klrm8eFTY
         tfKfsKpUS4lVvhrHc+RcxDjbawUf0EZ/Z78O2myfFkUdD0qEf1IGvzqaO/u8oCDuCXq6
         blo0XIN+r0O1wxsSAXU/WUEhg+RIcoqc71v/K5np2Rj8Fdn5mpnhQuuk1NyQ3Xwi5koq
         HA+g==
X-Gm-Message-State: AOAM5313niulZwcULqXIPnUhh6E29XCSxOijxB1LsQ3pIDfi4M7q1gc0
        AfsmgVf9bQUyvEleirpCQphW4w==
X-Google-Smtp-Source: ABdhPJwusafJZ0amR6pAz0lr++rVpxzG15N+K+PdGqJJDXzljZX4oA8r/13RefeVZmAUGzUYB/wwpw==
X-Received: by 2002:a1c:8194:: with SMTP id c142mr321305wmd.94.1604417379221;
        Tue, 03 Nov 2020 07:29:39 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id j127sm3491779wma.31.2020.11.03.07.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:29:38 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 22/25] soc: qcom: kryo-l2-accessors: Fix misnaming of 'val'
Date:   Tue,  3 Nov 2020 15:28:35 +0000
Message-Id: <20201103152838.1290217-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103152838.1290217-1-lee.jones@linaro.org>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/soc/qcom/kryo-l2-accessors.c:25: warning: Function parameter or member 'val' not described in 'kryo_l2_set_indirect_reg'
 drivers/soc/qcom/kryo-l2-accessors.c:25: warning: Excess function parameter 'value' description in 'kryo_l2_set_indirect_reg'

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/soc/qcom/kryo-l2-accessors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/kryo-l2-accessors.c b/drivers/soc/qcom/kryo-l2-accessors.c
index c20cb92077c03..7886af4fd7267 100644
--- a/drivers/soc/qcom/kryo-l2-accessors.c
+++ b/drivers/soc/qcom/kryo-l2-accessors.c
@@ -16,7 +16,7 @@ static DEFINE_RAW_SPINLOCK(l2_access_lock);
 /**
  * kryo_l2_set_indirect_reg() - write value to an L2 register
  * @reg: Address of L2 register.
- * @value: Value to be written to register.
+ * @val: Value to be written to register.
  *
  * Use architecturally required barriers for ordering between system register
  * accesses, and system registers with respect to device memory
-- 
2.25.1

