Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391AA267ED7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 10:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgIMImV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 04:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgIMIlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 04:41:52 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297CCC061573
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 01:41:51 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b22so6637107lfs.13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 01:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4L0xgGGFfM+PVtzTUoJQwaOaibiUkwrpgxA9eehYQ6A=;
        b=hNVrMqOJf8D11KfcqbFvHUB+7z36kzO+Aq7bint4577gRSVdoVGEoMj8M9weZoC1Xv
         fH/HeQ9NEp6do2BbEb1+ytvL+28Rf5Pc2uk2isxQp9+sbOjzhuoz3QjIuLszccOvBGDL
         t2xPXRxYHHVxZRjqYUIBwkEd7F7wUegmB6zt63rLejadaVHKBF/Mn1BCDM7Eab0MfK33
         kAo1X1lXCswUz6gQR+WiO8VJYw/mciE8dHrocy6cR+Vt/ufl5HnlL8IfBGyazC17alb2
         NZAqiPOC+0Km3BD0+bpV5rRSSZ/ArEPf3k7mPKfC5Bhkg+zylAJHQom2ZURonP1Z9ruE
         DjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4L0xgGGFfM+PVtzTUoJQwaOaibiUkwrpgxA9eehYQ6A=;
        b=ZJXOtyGLoTJn4Z+euPmY+KlcHyrEtXMNo4JZSr2YB2BnaT38MVpS7tJaxCwQYkWW3D
         u/7d7f2v6J8VNl8K0gfJAqFpr6Ja0S0OA/fZXtIK8n0ZL7wwV2ILxUyG5X+2iBKSaWjo
         ReQnc2CMxLcuPLO9FPQj72YH8iN8wGCom7u94Za8/cXrSqsOkyhMirie+myYtCMvLICE
         7Bgxl24CGLYHczgUlfnyiZ5O3X1K6iFuDySSK60SaxIwLwcK6mbqDYbC0p36FUHBb98+
         kNCQzf52i5C/9AqIIxKaCt6CErGsqR2/0nxUIKG8WC1Dvg9aXU7refTziaz8AM8d7pUY
         KfMQ==
X-Gm-Message-State: AOAM5314boBu9xYqLlJbI2DA2TPXpB5C0iTzX/Qre81otjdtRaxQuQ7i
        FX+OFOx+l5WaIu31kEqJ7QU=
X-Google-Smtp-Source: ABdhPJz4aPXd5yZINYitYZoRQkwfyG/WYx4ZtXco7Jj5WI5ASmnRfQQh6lgckcEvUcabOhfTyVHfmA==
X-Received: by 2002:ac2:420f:: with SMTP id y15mr2562133lfh.489.1599986509671;
        Sun, 13 Sep 2020 01:41:49 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id n9sm2081099lfd.215.2020.09.13.01.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 01:41:49 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 4/5] regulator: pca9450: Constify static regulator_ops
Date:   Sun, 13 Sep 2020 10:41:13 +0200
Message-Id: <20200913084114.8851-5-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200913084114.8851-1-rikard.falkeborn@gmail.com>
References: <20200913084114.8851-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usages of these is to assign their address to the ops field in
the regulator_desc struct, which is a const pointer. Make them const to
allow the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/regulator/pca9450-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index eb5822bf53e0..cb29421d745a 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -90,7 +90,7 @@ static int pca9450_dvs_set_ramp_delay(struct regulator_dev *rdev,
 				  BUCK1_RAMP_MASK, ramp_value << 6);
 }
 
-static struct regulator_ops pca9450_dvs_buck_regulator_ops = {
+static const struct regulator_ops pca9450_dvs_buck_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -101,7 +101,7 @@ static struct regulator_ops pca9450_dvs_buck_regulator_ops = {
 	.set_ramp_delay = pca9450_dvs_set_ramp_delay,
 };
 
-static struct regulator_ops pca9450_buck_regulator_ops = {
+static const struct regulator_ops pca9450_buck_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -111,7 +111,7 @@ static struct regulator_ops pca9450_buck_regulator_ops = {
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
 };
 
-static struct regulator_ops pca9450_ldo_regulator_ops = {
+static const struct regulator_ops pca9450_ldo_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
-- 
2.28.0

