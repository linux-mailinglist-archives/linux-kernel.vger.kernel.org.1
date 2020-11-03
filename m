Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65662A49B7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgKCP3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbgKCP3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:29:31 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A96C0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:29:31 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id b3so13090824wrx.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F5XEFxf3V3a/7KJuxM4jGDFH/VFMglui44AFEjsXTa8=;
        b=TWneApmGdiFuxJnI307W1fbIDdA3pgj4MFQbUWbEY5qVeFgEVompzAecKUyLT0YHSq
         Br8HxIFcSCzUouyHOtW6ibcdKXWIsjnysbKv+KN+xw9ZdkMPm8gW1MQ/bqOmQGKUnyxN
         RyItJwLxjp5HcpWcJPSEUFaUfCte7diB/Hsu37Ae7h6xsBKHJ5pUgeAFtGfOt9t3uV8b
         T0lvNYaqGBlBO9MP20TzPHtZuBOa34rPEXoYHyIw5hD92oNwCt4BsMSrZv53PdmJW9mI
         aRGlU3c7SiT/lwdEtToWYkvLdMJRrh8MNzfGg9vozs3PIU/90iz8kZzoamn/Dbbb2mbn
         iF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F5XEFxf3V3a/7KJuxM4jGDFH/VFMglui44AFEjsXTa8=;
        b=S5QVABfr2dOIa03LOAunNfIv0YhgbWQSH8LBUKO0efvYA3dS3ptAQv0XS/f96CTw1O
         xruTbI4PytFfW0CSVUC5qR6Re+xuH0M2ntTeIaJLsDoUbcps8K7fg6GzQFK7mOD05BiI
         dcSm5wktbDHlBG08yQgb1atSRwopOPZJ0rd/u6OAq/pxu7u4Fago7aX4OdGlbrUOQNhN
         zOOaWUVA8eDtAi5DCH/F8KKdoTky0D1g9uDGWO4uJ+iwcpU0OKsxc37Rzaze3iBHbH5N
         0iw3P2Q4LalEL+wHR3U+PgBiS6XMJroh4Y5mhRCyAMe3TlOrYU/JHLogtoZdj8zMVCWZ
         vh0g==
X-Gm-Message-State: AOAM531mh03y8oigY2tplZqijBLWRtHE5BQVU/VKm99OcmXAKg04hr3c
        szpqnOZ17EQyQdsNCpiZNWWgyCLFXFLF02Wu
X-Google-Smtp-Source: ABdhPJzMxnEx44QOmexRXCOsJZJfTIEAa7PuWZb3XF7kaMsp8G0uEviimi1EFwiDd3bvXYdgC5XU1g==
X-Received: by 2002:adf:eb4c:: with SMTP id u12mr24896182wrn.73.1604417369783;
        Tue, 03 Nov 2020 07:29:29 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id j127sm3491779wma.31.2020.11.03.07.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:29:29 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 15/25] soc: qcom: rpmh: Fix possible doc-rot in rpmh_write()'s header
Date:   Tue,  3 Nov 2020 15:28:28 +0000
Message-Id: <20201103152838.1290217-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103152838.1290217-1-lee.jones@linaro.org>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/soc/qcom/rpmh.c:266: warning: Function parameter or member 'dev' not described in 'rpmh_write'
 drivers/soc/qcom/rpmh.c:266: warning: Excess function parameter 'rc' description in 'rpmh_write'

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/soc/qcom/rpmh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index b61e183ede694..ad1f062620ff8 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -254,7 +254,7 @@ EXPORT_SYMBOL(rpmh_write_async);
 /**
  * rpmh_write: Write a set of RPMH commands and block until response
  *
- * @rc: The RPMH handle got from rpmh_get_client
+ * @dev: The device making the request
  * @state: Active/sleep set
  * @cmd: The payload data
  * @n: The number of elements in @cmd
-- 
2.25.1

