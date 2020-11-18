Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAA52B7454
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 03:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgKRCsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 21:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgKRCsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 21:48:41 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C236C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 18:48:41 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id f12so270600pjp.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 18:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U0A4hiVticV1l5BqvGEE7R9HBABEK4fgnMLNNOiuBJg=;
        b=KHefq22zv+bEgFPsZF2AFCWK/gy7NrJb5KRoX5dp6VQsNI57tjTAD5I2QHj9eWzLn9
         0gXrKWkoVXXEWkTSgJX2fybMBtUVNNIA7i9jRpda+7rI2OdGRs3+f6lFHkBNm8024Dg3
         xiGuldXdCNxplxosFCKcB2H7oYfSZiZ58Y6OYcno6uKscR0QOYObym68dNNeRDe8Oz8w
         yYnL9rTMkLHmRjWyi1bInRM4mfG4y9v50oPqrgEbxEw+QM35ql4lRJA1d9n1a9T/x6Qu
         Fc54vPLKwznPi3Czss4ku98tkj/5FNprZdSb4fKzNBjfLh8HI8V81WAfdy6/jyIOB++D
         89rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U0A4hiVticV1l5BqvGEE7R9HBABEK4fgnMLNNOiuBJg=;
        b=IVb3v2kH8/Xj205bS6WI42ASQY88rL0rJ6SnPufFjJ6QPkl5oY1Imm1beDzBKHCmiT
         PGu/Be+pwS5h+NibJ+b66G8z6I7mIdtPt+ce09loIGh2567xTQyvajXqdD7LgJeD8ZI6
         aPI9Fz+zjHPN4ggyZv1hS98+F5YCJJn0D1ZhwGEW8IwKimtxnLxNiycdSFhlxSgfw/UT
         QqeMKvUWghjFihPkLqkjGFvhOnMChY/GGDCVyK9SbLZRBpxJu0tGqzK/kLTP1OD/0AE4
         e/BxKOcEKroOc8z0+BaiXgg7C9BXppnK4ikO48yHaAaqDHs7VinqS9UBn/fgNi9uoarP
         H8CQ==
X-Gm-Message-State: AOAM533AWdk9dVQ/ahnG9L1vFIzwclUMStgCGuiRz+omOWeUFesCUy02
        SWu8kWjKobN6VkFAdqczOBw=
X-Google-Smtp-Source: ABdhPJxIMw3Foqrh7O45iqPiJSYAeYwg1U0lRJyJOohG4ydpCZXYN0bwy+rQq4hzPFQUd25nsJBGeA==
X-Received: by 2002:a17:902:bf43:b029:d6:8b99:3ca2 with SMTP id u3-20020a170902bf43b02900d68b993ca2mr2097731pls.43.1605667720900;
        Tue, 17 Nov 2020 18:48:40 -0800 (PST)
Received: from localhost.localdomain ([8.210.202.142])
        by smtp.gmail.com with ESMTPSA id z3sm22970686pfj.219.2020.11.17.18.48.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 18:48:40 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     khilman@baylibre.com, narmstrong@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        p.zabel@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        yejune.deng@gmail.com
Subject: [PATCH] soc: amlogic: replace devm_reset_control_array_get()
Date:   Wed, 18 Nov 2020 10:48:20 +0800
Message-Id: <1605667700-16681-1-git-send-email-yejune.deng@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_reset_control_array_get_exclusive() looks more readable

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 drivers/soc/amlogic/meson-ee-pwrc.c     | 3 +--
 drivers/soc/amlogic/meson-gx-pwrc-vpu.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
index ed7d2fb..50bf5d2 100644
--- a/drivers/soc/amlogic/meson-ee-pwrc.c
+++ b/drivers/soc/amlogic/meson-ee-pwrc.c
@@ -413,8 +413,7 @@ static int meson_ee_pwrc_init_domain(struct platform_device *pdev,
 			dev_warn(&pdev->dev, "Invalid resets count %d for domain %s\n",
 				 count, dom->desc.name);
 
-		dom->rstc = devm_reset_control_array_get(&pdev->dev, false,
-							 false);
+		dom->rstc = devm_reset_control_array_get_exclusive(&pdev->dev);
 		if (IS_ERR(dom->rstc))
 			return PTR_ERR(dom->rstc);
 	}
diff --git a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
index 8790627..b4615b2 100644
--- a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
+++ b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
@@ -304,7 +304,7 @@ static int meson_gx_pwrc_vpu_probe(struct platform_device *pdev)
 		return PTR_ERR(regmap_hhi);
 	}
 
-	rstc = devm_reset_control_array_get(&pdev->dev, false, false);
+	rstc = devm_reset_control_array_get_exclusive(&pdev->dev);
 	if (IS_ERR(rstc)) {
 		if (PTR_ERR(rstc) != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "failed to get reset lines\n");
-- 
1.9.1

