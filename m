Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8F2256A99
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 00:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgH2WME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 18:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgH2WLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 18:11:21 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C15C061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 15:11:20 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y17so1531444lfa.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 15:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UwYAujw/GZl9mCzJmhOye+cxfD8zW0EDrZxVkiTf/Vk=;
        b=UhnUdE50baobXwOuSB7K+feAsDeSkLDg+AadntjA8sB3BcCxerfYlAvwInGVKeHdxq
         IRMt6J3/5QAdVP1Vg+UFMyXra5TtkAk25vFaEsT0CQY2GR+4qIAMahJ8SYkBoQsLd3tk
         /2unQdNvVrpHS90h3V3ZmTQu4NoxNoikiOCs+nUZs8Rr0v2vNONan3vGexKJ0yk4z4F1
         59ia/gx4zwCxZEFSJJTwRAT68p/ij7QokdQWKGnsEQAE8pr77NWMJGOADlbWEsY4dnpT
         UlHcRADXFatY+p+9KI8ciN0pm7Z0yIDrOLJk8lZpvjHoVBSasxJE7lnkUQBOBwTatsQJ
         GmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UwYAujw/GZl9mCzJmhOye+cxfD8zW0EDrZxVkiTf/Vk=;
        b=IPImxqWqfcbqzvO496+DnI+3XtZ3iQawo3NB78coyRHelNWi2qyo+gdHUvIOVYj33o
         +R9m03IJjSodyZt8e7I0uqHktrEzQK4820PltmLiaKHlF2Cnsrx04nhocQRgO9x4MxUT
         XWN5z252EkKzMm3JQP7PL9SyADtLUQX4WBbTUB7prHorBxVG0c2zByXgWqWv3VfQmv8a
         3LDyBYQC8SqCARvnx3tqb1wIC73HePZSL4zdMU7RZBJ8inO/0OpvVB5RzLfZXg/2a89d
         PrITbSFLnYWh0bbKak9vCgnhY9uflDSowlLt0PhanpGDYAz66AYBDSDRj3Os3IAWn3Sd
         6mfA==
X-Gm-Message-State: AOAM53245q+LIKQp7RrBy5tLDZa+7uz9XaYLJVdtoRwLxPyC8BRzTSqB
        G+gO/E2u99DOIn2B+Y3+ow9nxG1qmRA=
X-Google-Smtp-Source: ABdhPJzZ2ki8TwDNT/1dYklgr7qPEeiqPs2Us8YktiPQw6xJnQEKb1nZ241yosCzcQbZUolxEwGDZg==
X-Received: by 2002:a19:cca:: with SMTP id 193mr2357061lfm.208.1598739078895;
        Sat, 29 Aug 2020 15:11:18 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id 4sm697546ljq.92.2020.08.29.15.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 15:11:18 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 6/8] regulator: tps6586x: Constify static regulator_ops
Date:   Sun, 30 Aug 2020 00:11:02 +0200
Message-Id: <20200829221104.20870-7-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200829221104.20870-1-rikard.falkeborn@gmail.com>
References: <20200829221104.20870-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of these are to assign their address to the ops field in
the regulator_desc struct, which is a const pointer. Make them const to
allow the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/regulator/tps6586x-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/tps6586x-regulator.c b/drivers/regulator/tps6586x-regulator.c
index 09e994e1f9a9..18bf4b885b08 100644
--- a/drivers/regulator/tps6586x-regulator.c
+++ b/drivers/regulator/tps6586x-regulator.c
@@ -60,7 +60,7 @@ struct tps6586x_regulator {
 	int enable_reg[2];
 };
 
-static struct regulator_ops tps6586x_rw_regulator_ops = {
+static const struct regulator_ops tps6586x_rw_regulator_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
@@ -71,7 +71,7 @@ static struct regulator_ops tps6586x_rw_regulator_ops = {
 	.disable = regulator_disable_regmap,
 };
 
-static struct regulator_ops tps6586x_rw_linear_regulator_ops = {
+static const struct regulator_ops tps6586x_rw_linear_regulator_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
@@ -81,7 +81,7 @@ static struct regulator_ops tps6586x_rw_linear_regulator_ops = {
 	.disable = regulator_disable_regmap,
 };
 
-static struct regulator_ops tps6586x_ro_regulator_ops = {
+static const struct regulator_ops tps6586x_ro_regulator_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
@@ -91,7 +91,7 @@ static struct regulator_ops tps6586x_ro_regulator_ops = {
 	.disable = regulator_disable_regmap,
 };
 
-static struct regulator_ops tps6586x_sys_regulator_ops = {
+static const struct regulator_ops tps6586x_sys_regulator_ops = {
 };
 
 static const unsigned int tps6586x_ldo0_voltages[] = {
-- 
2.28.0

