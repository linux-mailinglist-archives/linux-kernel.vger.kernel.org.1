Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93C427E664
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgI3KTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgI3KTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:19:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F31AC061755;
        Wed, 30 Sep 2020 03:19:00 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k13so893432pfg.1;
        Wed, 30 Sep 2020 03:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kbcNPf2FnaimbYNu8mZt61aQbxjrHO1kHPwcw7TixwU=;
        b=TnAO3VtAH6qGuUotLS41T91OsAlhsJy7SB2QbFSEmPrZ8X8uSqpKbCD+qGWSnmwNsl
         JB9YIyKNmURvHT0B/ZwPJ+bevdfji9LYFhvfH9JMSAa+kKuQkfWE2eBFJIrYu3QrcVCx
         Xkspe9MKXBGR2WzC0m3dsmwrFlZtkaYBsKQz/aE5YN3YdzMj0YrEfBchA/OlhI8puSEh
         //DCghikkqT/wn5thCQVo4irIjFXZte+gHKYmt6aLTWOwhODzGrjA0sCvxm6v2nDE8cR
         Z3b8PFLMKHjiVwXjgtmpmfJp/LUMifMAd5yeYioPai+pYXTANemcv9b5qS5wYinf96Oq
         X/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kbcNPf2FnaimbYNu8mZt61aQbxjrHO1kHPwcw7TixwU=;
        b=FhIyqYYGgttZ1dY6LFOG7NdkarEgVl9NBLpLtUaKqHOdnjfyQH4VMR96NgRes1uCKd
         8hyNOZceKFFH4kF4/VBt8pEx5xn/TZjGstxWZ84OOPFVJ5V0I865oPlipCt/2JRp69Dj
         NvliJmWQ6L3/DB2UEXzszvLQQ/TYIUkj7AIPG7Il46P95qeWN5rPCBsY7e3wYn1CvB0j
         7y0K0lD20ErjOBAHt/xn+hRHqvOCMvANX0VZblf1sqXxO6yLqUfhm1ydLqipyawOjuUk
         OvCMvD5ZkuxQATrW7K64OPu2CXy8eEOJD0Nkurl1a8TMqDyBaY6+8aDr9QRHX5e82ia6
         NA4A==
X-Gm-Message-State: AOAM532MQBcxV6EKymmAPhSR6Wde857tor413zdnvbibn71oa9QqeTwq
        1nszmvRyiMhSOq8y1SiPJhA=
X-Google-Smtp-Source: ABdhPJyifpDRR3IA6zAGGv1C9PADlLiEAdUnsPbK4RqMk4QeqJQeyz2GQYSaFqKf2m8S5KUry0xWtQ==
X-Received: by 2002:a63:786:: with SMTP id 128mr1606485pgh.69.1601461140095;
        Wed, 30 Sep 2020 03:19:00 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46b:9c58:dff:2627:f8ff:93b4])
        by smtp.gmail.com with ESMTPSA id b2sm1966566pfp.3.2020.09.30.03.18.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Sep 2020 03:18:59 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] regulator: rtmv20: Add missing regcache cache only before marked as dirty
Date:   Wed, 30 Sep 2020 18:18:52 +0800
Message-Id: <1601461132-15251-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add missing regcache cache only before masked as dirty.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/rtmv20-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/rtmv20-regulator.c b/drivers/regulator/rtmv20-regulator.c
index 1075b10..0a07598 100644
--- a/drivers/regulator/rtmv20-regulator.c
+++ b/drivers/regulator/rtmv20-regulator.c
@@ -321,6 +321,7 @@ static int rtmv20_probe(struct i2c_client *i2c)
 	 * keep in shutdown mode to minimize the current consumption
 	 * and also mark regcache as dirty
 	 */
+	regcache_cache_only(priv->regmap, true);
 	regcache_mark_dirty(priv->regmap);
 	gpiod_set_value(priv->enable_gpio, 0);
 
-- 
2.7.4

