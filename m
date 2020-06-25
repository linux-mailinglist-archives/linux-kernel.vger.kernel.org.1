Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806BD20A317
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 18:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406249AbgFYQgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 12:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406177AbgFYQg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:36:28 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1798DC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:36:28 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so6616218wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oh0M2XxgEicv/4L6G4xS9du1OgGWivqgmfvme6DT5xQ=;
        b=I8pv1DA7VP8oubQxBsgNdI+KcUYKxD021qWb3WnX0GN9F9PSAMbqBYJ/YqRdkDr+i+
         2I95wk1mNvFrWPiQy1Au8GIenTEuoISlV2qYFDZL9H7fzYS7HvnDaySxgj2jXTS8Jc0l
         uTyuMCOeYzZIrXokNQlhSODbZahqjKEjR+RP6RgNere7Lz4VGAReCjlp4iGr+bqF2DE3
         AwbB0elZeh6pZgayQ1Qzk5spE69Kc3P/Vw40ZMeGKrbrePX71GSNnWQiyjFmjdi/JeCM
         AUsAYl6iZ7awNTzLQs8yYhRRJmY7p6QLwTn2LcuEfdUh6neOKfuycHUAxzg1mNtji7+N
         1iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oh0M2XxgEicv/4L6G4xS9du1OgGWivqgmfvme6DT5xQ=;
        b=aSzape2qQ7XeHSvPCZ+ddvoeR3ApSlmYlTdwNZmKiYxQW6rOrqKIKtRvDM/Ng1Giax
         ykr8sPIxrA4v/A3ah98rcvBuEN9PcRSLFwvomRMM3WRBP9GR8ivWQUB7dO2etoxa9ufz
         APjY7i1PAem5eDgh6BWO7onfLv8eISwfHMhVHudCBuuvSGumBampVx3cF/szZIYmyhc6
         5xyBpz9kG83l63pqNn9pjJwk+OS51gmzS1kDklWz6omTWtrfo6Krqrhk8Sk4FkTaJg2B
         jSntMJS47qSEcyKeVh8K+CnOJDK7TmA1kUwAZaPBPtD+pOQH17051OPHc72wsYCB/eA0
         QJsA==
X-Gm-Message-State: AOAM531KkFW90b2k+OEiGsdNhzAmtTPaRdqxmfVsfrqwkR46bzjiFiuU
        /O9q3sRu+dxe1WcpVYD4HmvaVA==
X-Google-Smtp-Source: ABdhPJxSQnTa9XMAO/CZ/o9al09/awtgMaCIbfouAqjZz5Zpg5xQYQP3AY71vBaNPnpoiaKHxVlTTA==
X-Received: by 2002:a1c:dd86:: with SMTP id u128mr4269069wmg.123.1593102986847;
        Thu, 25 Jun 2020 09:36:26 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id a15sm36729089wrh.54.2020.06.25.09.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:36:26 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 03/10] regulator: of_regulator: Add missing colon for rdev kerneldoc argument
Date:   Thu, 25 Jun 2020 17:36:07 +0100
Message-Id: <20200625163614.4001403-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625163614.4001403-1-lee.jones@linaro.org>
References: <20200625163614.4001403-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc validation gets confused if syntax isn't "@.*: ".

Adding the missing colons squashes the following W=1 warnings:

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/of_regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 87637eb6bcbcb..292e68c818ea1 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -532,7 +532,7 @@ static bool of_coupling_find_node(struct device_node *src,
 /**
  * of_check_coupling_data - Parse rdev's coupling properties and check data
  *			    consistency
- * @rdev - pointer to regulator_dev whose data is checked
+ * @rdev: - pointer to regulator_dev whose data is checked
  *
  * Function checks if all the following conditions are met:
  * - rdev's max_spread is greater than 0
-- 
2.25.1

