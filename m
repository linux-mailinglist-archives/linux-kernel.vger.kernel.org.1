Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B0F2EB68D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 00:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbhAEX4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 18:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbhAEX4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 18:56:13 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333E2C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 15:55:33 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id p187so1075364iod.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 15:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P9cxczu5SWz8K1Y8wh3jbN1kCg9PCTdSsNoKF/csdlw=;
        b=qmNvR6Y/mZMkV6xILKuddIBlO+MgpZ1uOjExFkQI7O3ZtG3D4htKuT+nhTw2Woju73
         BBYSDSi1wgJNMcEDvZqYZlQjcfGA7YEPkNaoEUMHd7p4c/6F3XY4/+ED9arPqqvbVt92
         A75zfWz4A3zw6/dB1NE09vYCvq+/WH1AWWmvASlOKfCeLGn5ROr6V9wLcKsGR7xJKyrY
         BmDpRISIOchC7Ldtj6+DKjH6twXii0PxPzTJiLYF21W5ifrt3dCHR5YC3I2X0V/5d/1M
         7f16lvU2pmb8vsnQlafiaMXfmlSWiXqc3K3LIMvzWwhSSTbbulHzapjjIMtOg/kEcxzB
         xv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P9cxczu5SWz8K1Y8wh3jbN1kCg9PCTdSsNoKF/csdlw=;
        b=TomMDfmNVeAy/om6QCAqvzML4qsB/PF7G0jRZ+SmZv5rqzjDpQIgBNcnJeC9hnoR/p
         Nj68pTNyYv0mKmXmT5ChpkvJA1ru8UquIONEsXjJqrZkxtQ+/185X4vx8Fceub+M2PMD
         rI+I5uEQXPGQTtGXEhH/Of27XHiTiMawjLdzVPS5j1TvRe08gy8psEcYYutDBM/cjdk4
         BD+WIuVSQqiyRYB0AbsvFdvjbURPBpTTtQmHnWXgbP8e81GPUII/SbX+1JVuvyVdsRmW
         bX+7gdNU5KQ5mZ811sGeo2k6Sdud00eTk3aq0vzVTv2FIGAQKr7BOEwaVqzgpp69olbf
         1HdQ==
X-Gm-Message-State: AOAM533TOe5JEXoh8s8Ei1BBauOyAzTRFqSbFHrXlK35Vk67OuR4xd9T
        J2nOD9EQenarbdpiv87lv9vCQQ==
X-Google-Smtp-Source: ABdhPJzW0+1wnI9+dPf7LC4hQ8rzEpvmwauqfoEQSeWVbbF2/K0RUMfJbui7qv5jnsQNWqNZ6ZlyTw==
X-Received: by 2002:a5d:959a:: with SMTP id a26mr1194505ioo.94.1609890932533;
        Tue, 05 Jan 2021 15:55:32 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id a18sm543488ilt.52.2021.01.05.15.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 15:55:31 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org, ohad@wizery.com
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rpmsg: glink: add a header file
Date:   Tue,  5 Jan 2021 17:55:28 -0600
Message-Id: <20210105235528.32538-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With an x86_64 architecture W=1 build, qcom_glink_ssr_notify() is
reported as having no previous prototype.  The prototype is found in
"qcom_glink.h", so we just need "qcom_glink_ssr.c" to include that
file.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/rpmsg/qcom_glink_ssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rpmsg/qcom_glink_ssr.c b/drivers/rpmsg/qcom_glink_ssr.c
index dcd1ce6169747..4da6c7d985568 100644
--- a/drivers/rpmsg/qcom_glink_ssr.c
+++ b/drivers/rpmsg/qcom_glink_ssr.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/notifier.h>
 #include <linux/rpmsg.h>
+#include <linux/rpmsg/qcom_glink.h>
 #include <linux/remoteproc/qcom_rproc.h>
 
 /**
-- 
2.20.1

