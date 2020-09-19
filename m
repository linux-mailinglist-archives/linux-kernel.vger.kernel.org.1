Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E65270BA9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 10:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgISIEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 04:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgISIEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 04:04:45 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD40C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 01:04:44 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id r24so6934869ljm.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 01:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=74d+3zdIrItu4yPjssRFwYhLxV8d+x9MW5ISlAEwzIM=;
        b=rRvZD8N50pyTKZUu3Uq4YwvhiMedpbQfrgkiEcR6sqlFbGxRDZ0es9mmDSXY49F65c
         kHuqDBwRu2yzu8+g6L3YaN2t5FLGs0AXIVoXm5Nl6ZxFzTexLoPxVZmwvQ5+cLiHjmtX
         7TKh7LEoYgTAA6xyNKTa1toLP3hniG1Hc3RyRq7uifBfPDh7ue+cb601ENhbhyE6kf7Y
         xKqcGZq1exzBZuHT2XMrsBMghlaEP8AMzFXgXRJSm9ZwEP3+dUeMMYTwvywKqYSaVlz7
         2Ty3Aql/xVvRWyyATI5hxvgSvae5yZfmk9drBJEJnp+Nxk9OTXogsbmTGA8TWJBaCzEU
         m/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=74d+3zdIrItu4yPjssRFwYhLxV8d+x9MW5ISlAEwzIM=;
        b=CVbT5UfVHxDJcVGacnY6ZQooyS1yiUS97HqvI0v+plkcNoB7O5rKbs4QS4x55EgSxr
         iIy2cAwaB33yHOCu3KwRvvds68KeNiJE2xSZn5Or5ZmXquHS9ynv5mr2ny/R7dWeTFyT
         fqGeS0AkVRGg8tb7VkwiSHp9dL8xpczQakd0RGDox3Km3MAZQrIss/qHv7y1NoV+qjt7
         LIQOs7D0RyFy+sD/b/UNRXj7oRE++1Kfj6U4kdEIfnLgAZsKKKKqf98qVHBbQNPFxkZ2
         Ru3t82V+ZV55sd6dZj4VlW3sCina4TysFGr+1Xs1bi3d67UDXiUPgvzb8r5SBUmqzuEK
         NuFw==
X-Gm-Message-State: AOAM531afdxbjfslUKKiJU5gdin0JnXnJAD65efZ2VhWZK0xZQHch4+u
        CBxcyxXEKv3Y9oUMdF1KjHo=
X-Google-Smtp-Source: ABdhPJw99VzTK4mNA4zbDFoHai02D7/beIuY/UeI5WSDlDYUJpL1QZ6lxuec0lKqKD6xilVG6V9A4g==
X-Received: by 2002:a2e:8904:: with SMTP id d4mr14161289lji.322.1600502683030;
        Sat, 19 Sep 2020 01:04:43 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241122244.gdansk.vectranet.pl. [109.241.122.244])
        by smtp.gmail.com with ESMTPSA id c22sm1110110lff.202.2020.09.19.01.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 01:04:42 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mtd@lists.infradead.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] mtd: rawnand: ams-delta: Fix non-OF build warning
Date:   Sat, 19 Sep 2020 10:04:03 +0200
Message-Id: <20200919080403.17520-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7c2f66a960fc ("mtd: rawnand: ams-delta: Add module device
tables") introduced an OF module device table but wrapped a reference
to it with of_match_ptr() which resolves to NULL in non-OF configs.
That resulted in a clang compiler warning on unused variable in non-OF
builds.  Fix it.

drivers/mtd/nand/raw/ams-delta.c:373:34: warning: unused variable 'gpio_nand_of_id_table' [-Wunused-const-variable]
   static const struct of_device_id gpio_nand_of_id_table[] = {
                                    ^
   1 warning generated.

Fixes: 7c2f66a960fc ("mtd: rawnand: ams-delta: Add module device tables")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index fdba155416d2..0bf4cfc25147 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -400,12 +400,14 @@ static int gpio_nand_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id gpio_nand_of_id_table[] = {
 	{
 		/* sentinel */
 	},
 };
 MODULE_DEVICE_TABLE(of, gpio_nand_of_id_table);
+#endif
 
 static const struct platform_device_id gpio_nand_plat_id_table[] = {
 	{
-- 
2.26.2

