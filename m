Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C54E2B8C19
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 08:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgKSHNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 02:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgKSHNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 02:13:38 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8B8C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 23:13:38 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id q10so3595852pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 23:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=268k75iGgPwajGOaY5d0Of03PhQtD6bYvRMlc9HmW4g=;
        b=G/p2/8TgOM+86w/05s8sQwFulz0SPcg1s110p4Y5VrMY53CxA7P1YrGyKhG8Hcevmo
         x9+HHdxGxVPrZLI4GxC6iCh0/mFSGTuBemeeyhMyrNbER+aYPclv7+p6GCoqJG78exmw
         PDFtAvEB39hnhS5L93Qcpd8rN78NDXuOfrhqiZ35SwzNfVlggchfM0dU32bXJqPBZ1xw
         xBBNh2DoMA7Jz/nIDF/yTCjNVpeHN1GFVV27NasRvn74NQPSUhEYLd3RHqT25M5m/5qY
         IxxklrtsQOjw5puK4oiO+NlbTzo53b/XQfORfU3bN4vppwxzT4M4uKMy6TTVLPeFzx0i
         hYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=268k75iGgPwajGOaY5d0Of03PhQtD6bYvRMlc9HmW4g=;
        b=dnsC0Q33YqFSo5zZ5mQ2nyXoBi6cX9r7zxkZH2JqoOJ+KY2OgVlqS7DXu5jKoQHbsx
         kgDWwhahq18rLhgD+YNf/ZmXZ4phqaAdjcqQn0dfqYubk3vUwmsiLP7eI8lqkh61aNDX
         u2iVC2EcYwKnyhKETuJM6IDmJARaWDMG/QS9/iVlQAVMQUOWGv99CjKYDW1ej6VLKAFz
         ONIuJ53mIga94dGwI7IC7kZN5yw8jHpyRv9p0up81SQUqzuMlqHf/cWnPZrlyQsUD0A4
         2ldAOJRtIOk45KoiXJhH7+wq3nKvMVVUb1xH0O/EhPQJUac2ShYBuaEqSElQKeCHYtR5
         ii1w==
X-Gm-Message-State: AOAM5314hT8vgSKVcCrm4lYaRajUQSv7OtOb9D3g8nVagjW7zFI0Ztpx
        dt1f/WiOlN/Z0ZVwMl3Jjl1y
X-Google-Smtp-Source: ABdhPJy8oDTW4wlGS6Td9PK4FFriSN4iIuF7GsjvFAltMxzfxpFZExZ3OT4DANy17qtHPVOAgF/lxg==
X-Received: by 2002:aa7:9af7:0:b029:197:bfa8:abaa with SMTP id y23-20020aa79af70000b0290197bfa8abaamr646747pfp.26.1605770017530;
        Wed, 18 Nov 2020 23:13:37 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id 12sm5491577pjt.25.2020.11.18.23.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 23:13:36 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 3/4] mtd: rawnand: qcom: Add support for Qcom SMEM parser
Date:   Thu, 19 Nov 2020 12:43:07 +0530
Message-Id: <20201119071308.9292-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119071308.9292-1-manivannan.sadhasivam@linaro.org>
References: <20201119071308.9292-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for using Qualcomm SMEM based flash partition parser in
Qualcomm NAND controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 777fb0de0680..1b031aeac18b 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2797,6 +2797,8 @@ static int qcom_nandc_setup(struct qcom_nand_controller *nandc)
 	return 0;
 }
 
+static const char * const probes[] = { "qcomsmem", NULL };
+
 static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
 					    struct qcom_nand_host *host,
 					    struct device_node *dn)
@@ -2860,7 +2862,7 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
 		}
 	}
 
-	ret = mtd_device_register(mtd, NULL, 0);
+	ret = mtd_device_parse_register(mtd, probes, NULL, NULL, 0);
 	if (ret)
 		nand_cleanup(chip);
 
-- 
2.17.1

