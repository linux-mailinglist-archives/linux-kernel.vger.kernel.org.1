Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4B62950A8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444578AbgJUQWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2444543AbgJUQV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:21:56 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD2AC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:21:56 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id w27so180865ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NbaOJdOhMnQWRBlP6WkK3ZzL8S9aIykVLGSDrM3lt1Y=;
        b=atuMiwpUbK1Yyl/B+DN8Fvaeg7nklmy8ZUDhvZaHpqL3qGMMtDhAgYWiCLlPwGc7a0
         UWcyK0DKuTDlS7j8AaLrgmldLACb/cy4kdThvmBt4G+mQ3GYNmxb3DxcuRmsFFB+kFfb
         aKWAN5esyrKSvQ5jR0PboxYNxDKwD7TqTonHG+wftLNZSZsGNJyWk4ENFO3/50k/JVez
         r5OB2AuadXu66MOzxx8U4SKqtWCa3dKWL7BD4m6+2IiUOBDcJ6NrVCR6atVzig7IKpP0
         MMZGk97bygy33+2y61VJ0HLaLwl8bcqZvbmWWWPejek+4j5u8RWC6DMI6OURiV/HfyME
         MFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NbaOJdOhMnQWRBlP6WkK3ZzL8S9aIykVLGSDrM3lt1Y=;
        b=poyypiCA+IwRHZpFl+hi+R5riT6c9xYC8YIexeLpbO9GFIIN6KzS8oUgT6Y6OTYMRe
         7LrYVWoLZ2wKDakXVecJwSwdRbw98Q51imWkc6t4JMytxx2PB5PEjMq6ALZI5meCYgTe
         YvmZgbk4yIRRWEJzH7Nr0Kv0kzojKPCBOb07TkYL+VUo+wcBJiqlsJDmM5JYVvNSkaGJ
         Jg59Jn0QPq/lvElNbcKWojY2W5o8IpWB7XcLAMZXMp1jsv7maEqPKsSUmlsTwG+y+Aja
         AiIDPoLpWnqTjGm8EyFXNSzjk6ywm4b0sK8Mgx+AeMPRJ88fUott5X++CpFZGu2JrSFI
         ZryQ==
X-Gm-Message-State: AOAM5336yjCOezf/PBBf3MuxJHmU9EaucpCb/Nhs6Fw3engo99ZumGxY
        F8OBP2riIS0ViArnD08TmyH7dg==
X-Google-Smtp-Source: ABdhPJzgn7NLcmefXgPTla5nK9XVbWc6TU9L61aXbeTJFTr26tzoKCNwiKGKQ9Yo08mn74gsn+j8sg==
X-Received: by 2002:a17:906:2b83:: with SMTP id m3mr4213435ejg.456.1603297314846;
        Wed, 21 Oct 2020 09:21:54 -0700 (PDT)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id 11sm2566667ejy.19.2020.10.21.09.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 09:21:54 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v2 1/3] clk: avoid devm_clk_release name clash
Date:   Wed, 21 Oct 2020 18:21:45 +0200
Message-Id: <20201021162147.563655-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201021162147.563655-1-jbrunet@baylibre.com>
References: <20201021162147.563655-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In clk-devres.c, devm_clk_release() is used to call clk_put() memory
managed clock. In clk.c the same name, in a different scope is used to call
clk_unregister().

As it stands, it is not really a problem but it does not readability,
especially if we need to call clk_put() on managed clock in clk.c

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/clk.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0a9261a099bd..88e5797bb6b4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4068,12 +4068,12 @@ void clk_hw_unregister(struct clk_hw *hw)
 }
 EXPORT_SYMBOL_GPL(clk_hw_unregister);
 
-static void devm_clk_release(struct device *dev, void *res)
+static void devm_clk_unregister_cb(struct device *dev, void *res)
 {
 	clk_unregister(*(struct clk **)res);
 }
 
-static void devm_clk_hw_release(struct device *dev, void *res)
+static void devm_clk_hw_unregister_cb(struct device *dev, void *res)
 {
 	clk_hw_unregister(*(struct clk_hw **)res);
 }
@@ -4093,7 +4093,7 @@ struct clk *devm_clk_register(struct device *dev, struct clk_hw *hw)
 	struct clk *clk;
 	struct clk **clkp;
 
-	clkp = devres_alloc(devm_clk_release, sizeof(*clkp), GFP_KERNEL);
+	clkp = devres_alloc(devm_clk_unregister_cb, sizeof(*clkp), GFP_KERNEL);
 	if (!clkp)
 		return ERR_PTR(-ENOMEM);
 
@@ -4123,7 +4123,7 @@ int devm_clk_hw_register(struct device *dev, struct clk_hw *hw)
 	struct clk_hw **hwp;
 	int ret;
 
-	hwp = devres_alloc(devm_clk_hw_release, sizeof(*hwp), GFP_KERNEL);
+	hwp = devres_alloc(devm_clk_hw_unregister_cb, sizeof(*hwp), GFP_KERNEL);
 	if (!hwp)
 		return -ENOMEM;
 
@@ -4167,7 +4167,7 @@ static int devm_clk_hw_match(struct device *dev, void *res, void *data)
  */
 void devm_clk_unregister(struct device *dev, struct clk *clk)
 {
-	WARN_ON(devres_release(dev, devm_clk_release, devm_clk_match, clk));
+	WARN_ON(devres_release(dev, devm_clk_unregister_cb, devm_clk_match, clk));
 }
 EXPORT_SYMBOL_GPL(devm_clk_unregister);
 
@@ -4182,7 +4182,7 @@ EXPORT_SYMBOL_GPL(devm_clk_unregister);
  */
 void devm_clk_hw_unregister(struct device *dev, struct clk_hw *hw)
 {
-	WARN_ON(devres_release(dev, devm_clk_hw_release, devm_clk_hw_match,
+	WARN_ON(devres_release(dev, devm_clk_hw_unregister_cb, devm_clk_hw_match,
 				hw));
 }
 EXPORT_SYMBOL_GPL(devm_clk_hw_unregister);
-- 
2.25.4

