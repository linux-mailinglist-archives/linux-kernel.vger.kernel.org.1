Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AD7267ED6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 10:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgIMImR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 04:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgIMIlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 04:41:50 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B83C061757
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 01:41:50 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s205so15976356lja.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 01:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sJNFUcUXZRjiFZyjvmURXXoVgPbHFappN/dL/chWE1E=;
        b=renEE23Do/qBPVPTA2uFx1X+S3Ji6Tqb97DIR1MznWTgu+DksSB6ea8IiPy/C7HDEM
         pHj1zgRuiNATfkhnE22Hfqh3YxDRm+wzK97M6ueHj3ceaUASvgL3J3BhJSueczURfwOl
         hSeN/twVzzUD2yJHxud+o8hSU6YR3jYXOgngFC9792c4mQTU/7eYGvycMan8NwLbdEYT
         qrRrVGYMmkSvMW8xbaVxrhC1nq3vQaJv1V9EvkUF+am0bIl85WtlOnmFgUvDZoIx7Zrh
         yUy7aX7RceUgjo7f8cIm5XvbpAJI2Ae/cHnMPK23z8ZQ8THPEywvTriX8T4rA95c8cCV
         yWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sJNFUcUXZRjiFZyjvmURXXoVgPbHFappN/dL/chWE1E=;
        b=gyexKgIXVnDE9JnWlH79D/2OgQmbLtOpkS5EVXCKyO0rFlPpVjdqizOykDB3uTv2Gd
         QLZyrT9xmJVxOFxVoGREBz99lKxF+eS67AsDG0u/vGCxmqH6gdUvLp3pzAUzBBePvaGm
         v5yfIuF4f9azQeTpK9kvIGnyjLIti3FwIEf0oCaO1njS/0nGmtjx89XoonGoiPYka6EG
         wFAdNRpa26lljqY5iAQ2/uDZgxsFCOAViuDo1v8yqirYsat5rsnXxlVJREnjIAygi2IW
         b33L/YKpuO4RFEMGjALTqhGZUmO8smi6spR++SQZnSgo8YpNjl3ZTKDprOV7B00J2oML
         PBQQ==
X-Gm-Message-State: AOAM531acXlqtW0DGSuPQbuPbwOUoflXXJQmlkCnmPbbL/j5jP5apZID
        DThWFHPT34ZfSuDRTi2wQs4=
X-Google-Smtp-Source: ABdhPJxBk3nXRrH3oDOwvaWlL6VDeJ26k7vfEc8tuNowhHJ95aiSvLVCKiVwNLtdRlYK+l1I7gqwSA==
X-Received: by 2002:a2e:8882:: with SMTP id k2mr3228840lji.202.1599986508665;
        Sun, 13 Sep 2020 01:41:48 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id n9sm2081099lfd.215.2020.09.13.01.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 01:41:47 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 3/5] regulator: stw481x-vmmc: Constify static structs
Date:   Sun, 13 Sep 2020 10:41:12 +0200
Message-Id: <20200913084114.8851-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200913084114.8851-1-rikard.falkeborn@gmail.com>
References: <20200913084114.8851-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of stw481x_vmmc_ops is to assign its address to the ops
field in the regulator_desc struct which is a const pointer.

The only usage of vmmc_regulator is to pass its address to
of_get_regulator_init_data() and devm_regulator_register(), both which
take const pointers.

Make both of them const to allow the compiler to put them in read-only
memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/regulator/stw481x-vmmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/stw481x-vmmc.c b/drivers/regulator/stw481x-vmmc.c
index 6dc2316daad3..127ab43add49 100644
--- a/drivers/regulator/stw481x-vmmc.c
+++ b/drivers/regulator/stw481x-vmmc.c
@@ -27,7 +27,7 @@ static const unsigned int stw481x_vmmc_voltages[] = {
 	3300000,
 };
 
-static struct regulator_ops stw481x_vmmc_ops = {
+static const struct regulator_ops stw481x_vmmc_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.enable      = regulator_enable_regmap,
 	.disable     = regulator_disable_regmap,
@@ -36,7 +36,7 @@ static struct regulator_ops stw481x_vmmc_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 };
 
-static struct regulator_desc vmmc_regulator = {
+static const struct regulator_desc vmmc_regulator = {
 	.name = "VMMC",
 	.id   = 0,
 	.ops  = &stw481x_vmmc_ops,
-- 
2.28.0

