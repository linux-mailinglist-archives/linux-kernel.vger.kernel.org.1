Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB65023DD4F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 19:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgHFRIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 13:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbgHFRGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:06:40 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3381C002157
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 08:55:18 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d6so37030988ejr.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 08:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P2isjLZ0JPuBERYLPVsRRFizdiIqjElG9tzLkwc7/+4=;
        b=shJQXwNSQr5EhI41kfaTjiC67sCJkV9h4LOd+Fzw0w6acAGvSkL9CjhygQ8bf3PSr3
         mpFkMdZTJ/NRCYfP9rIck09KxS8n9u/MfoMPGqmjjQGnIlXg9BDkXpgev0ihqs77yrbD
         pnoG44nQC7t3BRIMgm4jYjdI8e/+pVkZjenCuTWuq/G0JJvMnU6MqIUl9fmjq6XDeeeM
         FsSUyZJ4H5TyimiRsgipfoV4A9BqzjDhGXDuj0JLvi90xSP0R5LeMYA84p7Ve+H7aoDj
         gjv6hZ1BuwRW3ofrxkK4cQKJMgNg6ZuEBSw6fFpFwn2qigtBneKQtII7kQoom2mmcWMg
         sg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P2isjLZ0JPuBERYLPVsRRFizdiIqjElG9tzLkwc7/+4=;
        b=jE70B6P1cIK/sksaDObRzoXGdrfPgb6PfwmgQ2KEdmqXbbAj1HEs6zOdTbY67ugDRb
         X2Hs3oFxTf5BuiBGF53GfcKZOp7Q3480vlhqXI0KwNP066kCBjUF+bnLsosfCA+qTqQi
         k7CDQAPSyWtQWa8D/7DgJHTnt3twF1JzIdPh81tJhMiFZs9ZP7Q/Hhrld9MfqvhMQPP3
         5ngTpVmBtjKoDfhyrhr4uFvgWYuHaUUwXxLAgWd63leT8NCwnXC/sTD/QmE7WJehQjES
         GPbBf+bnaP/3l34yu0+CB92kXJjI0ROxbSgM1gNVcFy6vhjE5i151BL4UTXMDDtmEu9m
         k+PQ==
X-Gm-Message-State: AOAM530dyx+Dyp7dEztFRYKw3gUPZpeP5l7PMDoTCtcNmFb24DkrLZNh
        2CbRhdxyqPLhbdN/9upxnGURGApV
X-Google-Smtp-Source: ABdhPJyyOVXJ2BfZbMU0k3lG9Ksgo/vg9llnsmn4xbtJvvWgp25mE1Qz/tQiycTjNY162QaRhcpwRg==
X-Received: by 2002:a17:906:1c0e:: with SMTP id k14mr4881023ejg.479.1596729317720;
        Thu, 06 Aug 2020 08:55:17 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id n5sm4044600eja.105.2020.08.06.08.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 08:55:16 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: pwm: Do not print error on probe deferral
Date:   Thu,  6 Aug 2020 17:55:15 +0200
Message-Id: <20200806155515.3936329-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

When the pwm-regulator driver fails to find the enable GPIO because of
probe deferral, prevent it from potentially spamming the kernel log with
error messages that are not useful.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/regulator/pwm-regulator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 3234b118b53e..dc99ac9b0cdf 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -370,7 +370,9 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 						    gpio_flags);
 	if (IS_ERR(drvdata->enb_gpio)) {
 		ret = PTR_ERR(drvdata->enb_gpio);
-		dev_err(&pdev->dev, "Failed to get enable GPIO: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to get enable GPIO: %d\n", ret);
+
 		return ret;
 	}
 
-- 
2.27.0

