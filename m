Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AAB2A49A5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgKCP3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbgKCP3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:29:30 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7312C0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:29:29 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id e6so1755872wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KAOtHAc1bsJpW+rLliOxjaTckSKYVoP83N5QdT3qSsE=;
        b=doDInUwwodLhGXQs8awNNS8kXdhdZIg/tUhIdyz9t4xqY/0Mm/CcWlW4ckUbGn63PM
         nkZKOLW37j2rDl9MyotYFUDWfXtNZQ75o3MbwJ7H3xixJdrQHv0oNn0Lq9pNBCAQ7n7h
         0EE68rUTJuLMPHJgUkt1zmz2dG6K/4IlcfiC/kd9FUmWn3xD5iWrTE3dFm6HS/ADLV9t
         1woLUC5MSyOmhYkRCGrGvd+ZLNGAl3aMqCQsppZeegy/sw1+CUg5pugsgGh45ENGXOQ7
         TBdBtMAiD2bwi4YZjlqLr6KrHWoorUy0Ow7zXD6U04GhFYSQmnT12/sN6/bLqIEJg7qK
         t7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KAOtHAc1bsJpW+rLliOxjaTckSKYVoP83N5QdT3qSsE=;
        b=pmsg1GXYGFHRbLBMc6Dw6wbsypcZV3DucFx7XqdFGjD9nk/TmiWFfbNmpGOHiac7Ly
         aBwgJ+d6MWpqtpOH5Fy/L/mV3KFj94bRieoJ2rOXXuiQYpb1ucV8pfYMQxgyPFRT7P4I
         ZNv3NDOzH2Wn+atQAQrb94y8E0NS0tgGMW6xDgURpljDWx6u6co9fRE7Xe4Z0y440JFu
         5R337xthQ2BSOvDA4zYEyIvH+alfjgFULtqM7Y1idNNvAOr8jfyxwlXFd6+Nme8iE7XN
         487Wck3U7jzB8UoJ7GPFkrQWnhTYbdhUtI4/DsZk8/KuciMvBpqH0NR7DyCLqRt15nBC
         rXmg==
X-Gm-Message-State: AOAM53042hvbRXkx9wqP68hkdvJ9fWEJ87MjKu4EHoEotErYys9nXu2H
        sSf04nLGLPmClFw1qz8Ts+7XtA==
X-Google-Smtp-Source: ABdhPJzjZkSv+KzIvPwjWBSTfMSDm6x9636dav/awqODx24ADwz3jbCIg5PoHjTLCYH52ivoPVhyPA==
X-Received: by 2002:adf:c101:: with SMTP id r1mr25706240wre.87.1604417368565;
        Tue, 03 Nov 2020 07:29:28 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id j127sm3491779wma.31.2020.11.03.07.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:29:27 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ben Dooks <ben@simtec.co.uk>, linux-samsung-soc@vger.kernel.org
Subject: [PATCH 14/25] soc: samsung: s3c-pm-check: Fix incorrectly named variable 'val'
Date:   Tue,  3 Nov 2020 15:28:27 +0000
Message-Id: <20201103152838.1290217-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103152838.1290217-1-lee.jones@linaro.org>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/soc/samsung/s3c-pm-check.c:162: warning: Function parameter or member 'val' not described in 's3c_pm_runcheck'
 drivers/soc/samsung/s3c-pm-check.c:162: warning: Excess function parameter 'vak' description in 's3c_pm_runcheck'

Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ben Dooks <ben@simtec.co.uk>
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/soc/samsung/s3c-pm-check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/samsung/s3c-pm-check.c b/drivers/soc/samsung/s3c-pm-check.c
index ff3e099fc2080..439d5c3725125 100644
--- a/drivers/soc/samsung/s3c-pm-check.c
+++ b/drivers/soc/samsung/s3c-pm-check.c
@@ -151,7 +151,7 @@ static inline int in_region(void *ptr, int size, void *what, size_t whatsz)
 /**
  * s3c_pm_runcheck() - helper to check a resource on restore.
  * @res: The resource to check
- * @vak: Pointer to list of CRC32 values to check.
+ * @val: Pointer to list of CRC32 values to check.
  *
  * Called from the s3c_pm_check_restore() via s3c_pm_run_sysram(), this
  * function runs the given memory resource checking it against the stored
-- 
2.25.1

