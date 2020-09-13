Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A515267ED5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 10:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgIMImC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 04:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgIMIls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 04:41:48 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD50C061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 01:41:47 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x69so10214704lff.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 01:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+zKv1OlqyIwABxp/P0SwjGapRQ6ENUrSFIRNJ+pZoxs=;
        b=i+yH8MvFeQ7TOtkEIMlByzZnOdDeqUaL6pMt7Z99Jp7XhF0x6U8+Kuk6w4BgLk3/k/
         ipQw2HS6Q/K795msM72GyAmPyfFo5ieP9GEOeCeS6aQbcJANkGk05tecn+iRi7QyKwo5
         jGq1STSc/GbCIBnNQf4BswotmKj3E3N0dbssNOh/T/RWDhS6x4mbq+YGOXBCYQlSp2d8
         TplNLNZce6N67HVSsuL6rE7okGxVXkLy5t0A+MdXYxoNSQSA+XiFLDCxAwIJIhZZZR96
         lyLQRdPLxSCawOkFyFkvXc2y4PAzN5gAIL0ejCe3sIleFCa8Zi2Xd9PEOAS74hFoLFaV
         wcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+zKv1OlqyIwABxp/P0SwjGapRQ6ENUrSFIRNJ+pZoxs=;
        b=RJJFDFg/oh4IT59C+j2LYvvrsuPa1X3ekf85ZgqiB8NXWmDF1cCYEAFKdSrp4SvzKR
         J+wH3qq+PRp/4rvF8zpvgBxXWWClVdA6Y9Lr9I3k+c3MYy443gvEv1gYLnOjVO+f4e9P
         WrCCzyecpwqNNcOCAi/fP8JMAR3cywaOHKW6pBcSf3sv4jLj37l39mBNvglP/GcOoYwT
         XQ5FnCiT7diXMBtNEsUVUT8xj9sc6hM8N4o0O2ozIPdWoeEzrhy+WAs64Zu0YXrN5shd
         gTe3rGS/Ap8QOnFgGbDTlBqZsdAWQZb7snjzr2Ug6L8nbfw2RVwELEHv/9Gm2++MyS7t
         pN2A==
X-Gm-Message-State: AOAM530rnrnK3iI6u1ooA7yUIP9kwJCOvuAG1/6MzCfXymkW5sGt4xYi
        9z/+Mgui6IDdLfxq95Fa0rQiSNa9Z7h+lw==
X-Google-Smtp-Source: ABdhPJx30qh1xNQetWtODORbE8sUHg4GYSIJjyv+0Hy71kAUvC8ugI+NXPA7df3uBWD42PC4TUvUIw==
X-Received: by 2002:a19:ed17:: with SMTP id y23mr3041878lfy.595.1599986506431;
        Sun, 13 Sep 2020 01:41:46 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id n9sm2081099lfd.215.2020.09.13.01.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 01:41:45 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 1/5] regulator: dummy: Constify dummy_initdata and dummy_ops
Date:   Sun, 13 Sep 2020 10:41:10 +0200
Message-Id: <20200913084114.8851-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200913084114.8851-1-rikard.falkeborn@gmail.com>
References: <20200913084114.8851-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of dummy_initdata is to assign its address to the
init_data field of the regulator_config struct and the only usage
dummy_ops is to assign its address to the ops field in the
regulator_desc struct, both which are const pointers. Make them const to
allow the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/regulator/dummy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/dummy.c b/drivers/regulator/dummy.c
index 74de6983c61a..d8059f596391 100644
--- a/drivers/regulator/dummy.c
+++ b/drivers/regulator/dummy.c
@@ -21,13 +21,13 @@
 
 struct regulator_dev *dummy_regulator_rdev;
 
-static struct regulator_init_data dummy_initdata = {
+static const struct regulator_init_data dummy_initdata = {
 	.constraints = {
 		.always_on = 1,
 	},
 };
 
-static struct regulator_ops dummy_ops;
+static const struct regulator_ops dummy_ops;
 
 static const struct regulator_desc dummy_desc = {
 	.name = "regulator-dummy",
-- 
2.28.0

