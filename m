Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7537A2A9F2F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgKFVhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728586AbgKFVhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:37:19 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A3EC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:37:19 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d142so2814057wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=agE410NhHkG/VilLjKYAizauXJMrtB10xUIGh/10Z74=;
        b=fPUVZrZJSo95eRMxWSlqADih2GCG8nwGdvu6O3QjQhQ3dpQrgZamfSmZsA6Yjfb8ED
         2F8ZiRkTUeBOXMFtchtdYi+CmlkfcCH/qy/PWfMoqXgROheKldXQ3s96xPGt+smVvpNB
         QCwEgP7PO7Qv7EyEP8rFl6KEr1nd2qBsnPQficJ10laLTMOjXfYHhNTQVBCk7N13RP8y
         ekSjri1cGcLsH6emIAM4G5ZKAik3tDSqJp/XQzk/rPaaXzZafAeW2icIMXQvaBa5epCA
         cZ/tiV5hmSSQeC5LBnb5nSnwwksMbBgAt6xVAeZ2WOLtKUaO+dUYUV/pej6/Cu9LGkBq
         YWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=agE410NhHkG/VilLjKYAizauXJMrtB10xUIGh/10Z74=;
        b=NlSt7ZNwq51yTWKDm1AmBZ/daKwSXUdHJpz63E6B9DJwVrqEzKAGmymmL3tBLdWavV
         PWvusQV6CiSAUvykOSk/7q7wDNv7MmoWSG1kfM9zgNw3aqN7QmgDf8v7Shzl8ayc7kkQ
         tN1HynQNLSQMPqJ6laNg1cqA/nyGtPXCScmfz+1BzRKO52Ao0xFt3wkn8UXFIUzGHu3c
         /6Rp9g7PLpLj2TNx4CQmmTN0sGdGatJu2rig5DmMy9sxRwaIkRQtdKpKSrGBAVRnFHyU
         NpCHG/OVX6qmR8lWlYGPQsVjnDIAnKfA53Rcp+OjixDa+5uUnAO5SxkH9/xJGUqpTlh5
         /pXw==
X-Gm-Message-State: AOAM531zP3+M4CWrUs68Dkxv6LM4LKvWzN7lVNdqMxV6w+sxcHbcLMli
        QOoLXSraeD9OZ8cgDWVexPMldA==
X-Google-Smtp-Source: ABdhPJyzOEuHoKw535qtQUVyuiYW5iGsQoWXMkoj85ik1O84tNuz+3qxn2olypB2cX2woe0o7qQ/nA==
X-Received: by 2002:a05:600c:22d7:: with SMTP id 23mr1596579wmg.67.1604698638184;
        Fri, 06 Nov 2020 13:37:18 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id d16sm3984942wrw.17.2020.11.06.13.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:37:17 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 14/23] mtd: ubi: gluebi: Fix misnamed function parameter documentation
Date:   Fri,  6 Nov 2020 21:36:46 +0000
Message-Id: <20201106213655.1838861-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106213655.1838861-1-lee.jones@linaro.org>
References: <20201106213655.1838861-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/ubi/gluebi.c:446: warning: Function parameter or member 'ns_ptr' not described in 'gluebi_notify'
 drivers/mtd/ubi/gluebi.c:446: warning: Excess function parameter 'ptr' description in 'gluebi_notify'

Cc: Richard Weinberger <richard@nod.at>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/ubi/gluebi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/gluebi.c b/drivers/mtd/ubi/gluebi.c
index cc547b37cace5..1b980d15d9fbf 100644
--- a/drivers/mtd/ubi/gluebi.c
+++ b/drivers/mtd/ubi/gluebi.c
@@ -439,7 +439,7 @@ static int gluebi_resized(struct ubi_volume_info *vi)
  * gluebi_notify - UBI notification handler.
  * @nb: registered notifier block
  * @l: notification type
- * @ptr: pointer to the &struct ubi_notification object
+ * @ns_ptr: pointer to the &struct ubi_notification object
  */
 static int gluebi_notify(struct notifier_block *nb, unsigned long l,
 			 void *ns_ptr)
-- 
2.25.1

