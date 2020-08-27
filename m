Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41DC25461B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 15:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgH0Njj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 09:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgH0NeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:34:23 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C488DC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 06:34:22 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k18so3509673pfp.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 06:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7FCj4eo3j3GbtsvklB0HEapcPiKhwE+p6XCZdQG51e0=;
        b=YksGN/Klz2U+5jSTHMCPwt8j9/PccIZtdyUnCZPwiqSlVHBB11ioUNakcTTduFyQ1y
         3J3ryZ6OL/8b/1G4InuP8fts5scbP9Rz+uVvn07RU/CiWdWpz/hUraeORbm/9Pqsit8t
         MqV63uHdwpuilQpBtjmGOE+Qz2Pq8NkRtGzzH2UplzOkGcjaXfWVewgS+sI7FRIFDjhE
         fXqT6333zDssmhtV7ZdJds10qlWWv+UgN/kZHjtMjf2q1Y1NHOCBJWmTv5bJole94Dl3
         flpUIjSVbZ69engbbNzyXrrtDASe0RHxwX0TR+3CVbeIcekxBno+13S3JuNZYPHAnqNf
         9OGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7FCj4eo3j3GbtsvklB0HEapcPiKhwE+p6XCZdQG51e0=;
        b=mz5krUo0laj+BphsLXoNTbUmTkU6osq5Emcq2tO5KPAQbYTyEFpjvsAE11qOxV+4+H
         X7SJs1t0OoyIw7pg9j0jgNzCVhWEsJ8ODZ6yn1pXiX6UAODCcluF+Lkug5hqqoYzmHPu
         E8vklcAdEsixdpBT7Gn5+N1ZmiTmlf9t6Y55l5ln4/CtPrtnQjzPK4xsLQ+AWVOOUY2Z
         BEmaP7ELW95IxWFsazgZYnVHPeWDVXf6JkXpQL6jsOfQpXFdTneODC2pQ4LU+c7q0boa
         i5RdZ5QcKw3zpknF6yXPrxzMYhNit8V6LIrDwwf41f2s40bQ84TcHams3L1pt4FDq8bJ
         w6NQ==
X-Gm-Message-State: AOAM530rLrlB3v49w9S/zmxcWrFRUatpM07usTmaAsVaI1ANTjb7t9Ka
        megXsnoYQMZ8EUM3i6peJiZJcUwU+c/2BQ==
X-Google-Smtp-Source: ABdhPJy++A+Fs7bmmkIIIXiQU73QEHegDmjLB1wLcIEz7+TuVA5U8OYW5f3vRllozVKeE/uPCntAXg==
X-Received: by 2002:a17:902:bb93:: with SMTP id m19mr15808911pls.77.1598535262252;
        Thu, 27 Aug 2020 06:34:22 -0700 (PDT)
Received: from localhost ([2405:201:4007:804a:5550:a563:c2bb:823e])
        by smtp.gmail.com with ESMTPSA id 65sm2815345pfc.218.2020.08.27.06.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 06:34:21 -0700 (PDT)
From:   Piyush Goyal <piyushgoyaliit@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH][next] regulator: mt6360: fix spelling mistake: "regulaotr" -> "regulator"
Date:   Thu, 27 Aug 2020 19:04:19 +0530
Message-Id: <20200827133419.36151-1-piyushgoyaliit@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some spelling mistakes in two dev_err messages. Fix these.

Signed-off-by: Piyush Goyal <piyushgoyaliit@gmail.com>
---
 drivers/regulator/mt6360-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/mt6360-regulator.c b/drivers/regulator/mt6360-regulator.c
index 89ce379520ed..15308ee29c13 100644
--- a/drivers/regulator/mt6360-regulator.c
+++ b/drivers/regulator/mt6360-regulator.c
@@ -424,14 +424,14 @@ static int mt6360_regulator_probe(struct platform_device *pdev)
 
 		rdev = devm_regulator_register(&pdev->dev, &rdesc->desc, &config);
 		if (IS_ERR(rdev)) {
-			dev_err(&pdev->dev, "Failed to register  %d regulaotr\n", i);
+			dev_err(&pdev->dev, "Failed to register  %d regulator\n", i);
 			return PTR_ERR(rdev);
 		}
 
 		ret = mt6360_regulator_irq_register(pdev, rdev, rdesc->irq_tables,
 						    rdesc->irq_table_size);
 		if (ret) {
-			dev_err(&pdev->dev, "Failed to register  %d regulaotr irqs\n", i);
+			dev_err(&pdev->dev, "Failed to register  %d regulator irqs\n", i);
 			return ret;
 		}
 	}
-- 
2.25.1

