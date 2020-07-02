Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC830211A93
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 05:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgGBDQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 23:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgGBDQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 23:16:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F83C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 20:16:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c17so28255781ybf.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 20:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xDLelKXWa6n/sCGeqxnzltZlZ1vS9m9Ynk21BdAZCSk=;
        b=HzbdSZv0NNEG2jR7vhCYiFUN9B3EAKDX8y5Ni0VDrAmUEhJIxTZJpBEkIJwoKrEgJ3
         1O2OGhhnX/ywvYb2j2XvoRWK4LIpm1uf29xqCnusy2Atlqy0SJ/CnDE+vR9Y7JYl13JW
         x7xpvuy8+3cjhHmAou12BjUAftI5/9HXqxi3RXFXXHsErGfAIgaTf/NGOnt1boZF7PZK
         aomikeBmbwMIbXFhlaaVybRSmtuj9nuSLwWTfknOXGLUkDIdp/lNUzqAz0mn3XYguGRo
         SVveQxs1EXULlSehkYoSizs/fGC0DKLjc35OZZ4Hq5sTiboohN6yYfAQhCSbdcutUMCn
         lgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xDLelKXWa6n/sCGeqxnzltZlZ1vS9m9Ynk21BdAZCSk=;
        b=XiGi/A9VXRIxCqhwUt1tFNx+DaSUZ4R/JU47zzeMoMWb9YXRuDdkK1fspTLNZ1m+g2
         gqVUgVidz9zH7oish1SUw4e5i42+s9KQgbYQHciSE4ZJz+enpo4zbkni5k/gs5QLGAp0
         C1qEfSA7Yww7EQqfAeeh9Y6RgY1QDpAeEtlNLoyU1LYiz1qEr/yuOWHNGB8ez3qsErnw
         2bJndBp033RzgLDvk3H2sN/jUiVXA+bgTYtEjhJ/iMsz6+dK2t9CgAV1dZSZ+7ReOGtk
         eyM87+DdbnxHY2KLU7b9lZMJ4xh3dnkkpAH95YWs3CD98tLNhzstuLW1/G8LwhQBMwtI
         mKKQ==
X-Gm-Message-State: AOAM531ud5Q+vT8gaQIMyHsJYmnZEv5X3XUzVfx0x21w3W8XrgEePd3g
        ictAhk5Q+2NvKuZgIohuB0xkmjmFX6Gk
X-Google-Smtp-Source: ABdhPJwAZ6JdGkzz0JV79Fl51uiKv8dPLjkIR5F8vFIGnlOnDhvxSMkJn0cZ+8nVvQzq/HnDfzwpKuV5QOWE
X-Received: by 2002:a25:3849:: with SMTP id f70mr47240812yba.135.1593659764955;
 Wed, 01 Jul 2020 20:16:04 -0700 (PDT)
Date:   Thu,  2 Jul 2020 13:15:24 +1000
In-Reply-To: <20200702031525.2662441-1-amistry@google.com>
Message-Id: <20200702131350.3.I6a0bc18fcdb2fe13e838a31e6d034d0e095368bc@changeid>
Mime-Version: 1.0
References: <20200702031525.2662441-1-amistry@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 3/4] regulator: da9211: Implement of_map_mode
From:   Anand K Mistry <amistry@google.com>
To:     linux-mediatek@lists.infradead.org
Cc:     hsinyi@chromium.org, drinkcat@chromium.org,
        Anand K Mistry <amistry@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementing of_map_mode is necessary to be able to specify operating
modes in the devicetree using 'regulator-allowed-modes', and to change
regulator modes.

Signed-off-by: Anand K Mistry <amistry@google.com>
---

 drivers/regulator/da9211-regulator.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index 1f9b75b41346..297b3aa7c753 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -86,6 +86,20 @@ static const int da9215_current_limits[] = {
 	5600000, 5800000, 6000000, 6200000, 6400000, 6600000, 6800000, 7000000
 };
 
+static unsigned int da9211_map_buck_mode(unsigned int mode)
+{
+	switch (mode) {
+	case DA9211_BUCK_MODE_SLEEP:
+		return REGULATOR_MODE_STANDBY;
+	case DA9211_BUCK_MODE_SYNC:
+		return REGULATOR_MODE_FAST;
+	case DA9211_BUCK_MODE_AUTO:
+		return REGULATOR_MODE_NORMAL;
+	default:
+		return REGULATOR_MODE_INVALID;
+	}
+}
+
 static unsigned int da9211_buck_get_mode(struct regulator_dev *rdev)
 {
 	int id = rdev_get_id(rdev);
@@ -233,6 +247,7 @@ static const struct regulator_ops da9211_buck_ops = {
 	.vsel_reg = DA9211_REG_VBUCKA_A + DA9211_ID_##_id * 2,\
 	.vsel_mask = DA9211_VBUCK_MASK,\
 	.owner = THIS_MODULE,\
+	.of_map_mode = da9211_map_buck_mode,\
 }
 
 static struct regulator_desc da9211_regulators[] = {
@@ -242,8 +257,14 @@ static struct regulator_desc da9211_regulators[] = {
 
 #ifdef CONFIG_OF
 static struct of_regulator_match da9211_matches[] = {
-	[DA9211_ID_BUCKA] = { .name = "BUCKA" },
-	[DA9211_ID_BUCKB] = { .name = "BUCKB" },
+	[DA9211_ID_BUCKA] = {
+		.name = "BUCKA",
+		.desc = &da9211_regulators[DA9211_ID_BUCKA],
+	},
+	[DA9211_ID_BUCKB] = {
+		.name = "BUCKB",
+		.desc = &da9211_regulators[DA9211_ID_BUCKB],
+	},
 	};
 
 static struct da9211_pdata *da9211_parse_regulators_dt(
-- 
2.27.0.212.ge8ba1cc988-goog

