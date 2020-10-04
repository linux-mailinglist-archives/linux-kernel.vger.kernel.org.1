Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029CA282D4D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 21:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgJDTcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 15:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgJDTcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 15:32:14 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CDDC0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 12:32:14 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y2so8320446lfy.10
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 12:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qhauSopptLNBc+OR0n7fVV6XnvFZaF/B7bYzlnmpBUo=;
        b=BO5B7tDY/cSglMlx1r8wStOkm7IAgOmEP8LvlDs9OeCfAzUDNhAr2C+xmct1pn4LYb
         YDi+iBqzBx4Mx0OZwQ7JFB2CWwbW8AjUyGuwPpZOg6PvvNi6bnskf84EJgBmj04msm3Z
         mVOcWotPGf4bPL6UpLSAr6P6YXxJ4dZfLDBUy9ogiZpxdyk74kYIQJdjH00GLgrHvDMC
         zkPysxeL2P4GiSYdaPaGEVojEoPoi4QGOs6f7hBmbGORA7XlxzOOnRWRcaScfjTl+ZC4
         dgVHVrkAUk5znGTPrF/4gQhsCuo2yZapaU5eyUNAfFy30l9jRS7l2KbXwEgo9ASpCLYO
         RqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhauSopptLNBc+OR0n7fVV6XnvFZaF/B7bYzlnmpBUo=;
        b=NnQqL0dv+aLPE+iFaTA9RKW4svxmn7iQQMRWuiI/lM4qDJUs7OD7jpSzKFtmJKgdge
         COEudqvWwsAwXFdD4WWtGU8kaKd/Tjgd5OVuOfwC6DvwkW+1KuFGO4xDi5XJwJ70I7dm
         SOVCq9UBJdLUobJPb4OSuw9JMmrCRw/JcMX6RL94e64Qjz2gy8hE1AHPvP/aF5+JaO2H
         NStXLoNxNcZn06wm3ysNdGskTAOgyjza6h1TTlh97wM4xgRCPyNNGHZdX1/ZGHs7YNch
         aWH5IAFYLlo4QPKfK924VTPmTK6skhLIM6G875o2wi1NGTF9tUGpPCu9GDuFms4x5lce
         ryQQ==
X-Gm-Message-State: AOAM532tMmk7UNwa+ofl1AelJhfdAbLn3X/51/qYex4vWWlaUm0sBhni
        qDdPEMf+XwX5CSkYKk5vTfk=
X-Google-Smtp-Source: ABdhPJyqxX3/+EOI8Xe4XtjzkH8Ao9wH4DfPimgFtQJPmKnAwhuAoQE1vD+H2z7BhEJ4q0yOB0A2+A==
X-Received: by 2002:a05:6512:403:: with SMTP id u3mr4032892lfk.10.1601839932441;
        Sun, 04 Oct 2020 12:32:12 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-221-232.NA.cust.bahnhof.se. [155.4.221.232])
        by smtp.gmail.com with ESMTPSA id h22sm2298220ljl.101.2020.10.04.12.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 12:32:11 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Akira Shimahara <akira215corp@gmail.com>,
        Evgeniy Polyakov <zbr@ioremap.net>
Subject: [PATCH 2/3] w1: Constify static w1_family_ops structs
Date:   Sun,  4 Oct 2020 21:32:01 +0200
Message-Id: <20201004193202.4044-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004193202.4044-1-rikard.falkeborn@gmail.com>
References: <20201004193202.4044-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of these structs is to assign their address to the fops
field in the w1_family struct, which is a const pointer. Make them const
to allow the compiler to put them in read-only memory.

This was done with the following Coccinelle semantic patch
(http://coccinelle.lip6.fr/):

// <smpl>
@r1 disable optional_qualifier @
identifier i;
position p;
@@
static struct w1_family_ops i@p = {...};

@ok1@
identifier r1.i;
position p;
identifier s;
@@
static struct w1_family s = {
	.fops=&i@p,
};

@bad1@
position p!={r1.p,ok1.p};
identifier r1.i;
@@
i@p

@depends on !bad1 disable optional_qualifier@
identifier r1.i;
@@
static
+const
struct w1_family_ops i={};
// </smpl>

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/w1/slaves/w1_ds2405.c  | 2 +-
 drivers/w1/slaves/w1_ds2406.c  | 2 +-
 drivers/w1/slaves/w1_ds2408.c  | 2 +-
 drivers/w1/slaves/w1_ds2413.c  | 2 +-
 drivers/w1/slaves/w1_ds2423.c  | 2 +-
 drivers/w1/slaves/w1_ds2430.c  | 2 +-
 drivers/w1/slaves/w1_ds2431.c  | 2 +-
 drivers/w1/slaves/w1_ds2433.c  | 2 +-
 drivers/w1/slaves/w1_ds2438.c  | 2 +-
 drivers/w1/slaves/w1_ds250x.c  | 2 +-
 drivers/w1/slaves/w1_ds2780.c  | 2 +-
 drivers/w1/slaves/w1_ds2781.c  | 2 +-
 drivers/w1/slaves/w1_ds2805.c  | 2 +-
 drivers/w1/slaves/w1_ds28e04.c | 2 +-
 drivers/w1/slaves/w1_ds28e17.c | 2 +-
 drivers/w1/slaves/w1_therm.c   | 6 +++---
 drivers/w1/w1.c                | 2 +-
 17 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2405.c b/drivers/w1/slaves/w1_ds2405.c
index 86cd97309d87..1d9a1183e83f 100644
--- a/drivers/w1/slaves/w1_ds2405.c
+++ b/drivers/w1/slaves/w1_ds2405.c
@@ -206,7 +206,7 @@ static struct attribute *w1_ds2405_attrs[] = {
 
 ATTRIBUTE_GROUPS(w1_ds2405);
 
-static struct w1_family_ops w1_ds2405_fops = {
+static const struct w1_family_ops w1_ds2405_fops = {
 	.groups = w1_ds2405_groups
 };
 
diff --git a/drivers/w1/slaves/w1_ds2406.c b/drivers/w1/slaves/w1_ds2406.c
index 762e5e4e2b48..6c269af73c80 100644
--- a/drivers/w1/slaves/w1_ds2406.c
+++ b/drivers/w1/slaves/w1_ds2406.c
@@ -138,7 +138,7 @@ static void w1_f12_remove_slave(struct w1_slave *sl)
 			&(w1_f12_sysfs_bin_files[i]));
 }
 
-static struct w1_family_ops w1_f12_fops = {
+static const struct w1_family_ops w1_f12_fops = {
 	.add_slave      = w1_f12_add_slave,
 	.remove_slave   = w1_f12_remove_slave,
 };
diff --git a/drivers/w1/slaves/w1_ds2408.c b/drivers/w1/slaves/w1_ds2408.c
index 83f8d94bb814..ad102c577122 100644
--- a/drivers/w1/slaves/w1_ds2408.c
+++ b/drivers/w1/slaves/w1_ds2408.c
@@ -336,7 +336,7 @@ static const struct attribute_group *w1_f29_groups[] = {
 	NULL,
 };
 
-static struct w1_family_ops w1_f29_fops = {
+static const struct w1_family_ops w1_f29_fops = {
 	.add_slave      = w1_f29_disable_test_mode,
 	.groups		= w1_f29_groups,
 };
diff --git a/drivers/w1/slaves/w1_ds2413.c b/drivers/w1/slaves/w1_ds2413.c
index f1fb18afbcea..c8cfac555b48 100644
--- a/drivers/w1/slaves/w1_ds2413.c
+++ b/drivers/w1/slaves/w1_ds2413.c
@@ -143,7 +143,7 @@ static const struct attribute_group *w1_f3a_groups[] = {
 	NULL,
 };
 
-static struct w1_family_ops w1_f3a_fops = {
+static const struct w1_family_ops w1_f3a_fops = {
 	.groups		= w1_f3a_groups,
 };
 
diff --git a/drivers/w1/slaves/w1_ds2423.c b/drivers/w1/slaves/w1_ds2423.c
index f4367282dcc1..b6bd18d5b3f6 100644
--- a/drivers/w1/slaves/w1_ds2423.c
+++ b/drivers/w1/slaves/w1_ds2423.c
@@ -117,7 +117,7 @@ static struct attribute *w1_f1d_attrs[] = {
 };
 ATTRIBUTE_GROUPS(w1_f1d);
 
-static struct w1_family_ops w1_f1d_fops = {
+static const struct w1_family_ops w1_f1d_fops = {
 	.groups		= w1_f1d_groups,
 };
 
diff --git a/drivers/w1/slaves/w1_ds2430.c b/drivers/w1/slaves/w1_ds2430.c
index 75bb8a88620b..0ea7d779d17a 100644
--- a/drivers/w1/slaves/w1_ds2430.c
+++ b/drivers/w1/slaves/w1_ds2430.c
@@ -279,7 +279,7 @@ static const struct attribute_group *w1_f14_groups[] = {
 	NULL,
 };
 
-static struct w1_family_ops w1_f14_fops = {
+static const struct w1_family_ops w1_f14_fops = {
 	.groups	= w1_f14_groups,
 };
 
diff --git a/drivers/w1/slaves/w1_ds2431.c b/drivers/w1/slaves/w1_ds2431.c
index e5bd7e2354d7..6856b1c29e17 100644
--- a/drivers/w1/slaves/w1_ds2431.c
+++ b/drivers/w1/slaves/w1_ds2431.c
@@ -278,7 +278,7 @@ static const struct attribute_group *w1_f2d_groups[] = {
 	NULL,
 };
 
-static struct w1_family_ops w1_f2d_fops = {
+static const struct w1_family_ops w1_f2d_fops = {
 	.groups		= w1_f2d_groups,
 };
 
diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index 1f805c86517a..0f72df15a024 100644
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -288,7 +288,7 @@ static void w1_f23_remove_slave(struct w1_slave *sl)
 #endif	/* CONFIG_W1_SLAVE_DS2433_CRC */
 }
 
-static struct w1_family_ops w1_f23_fops = {
+static const struct w1_family_ops w1_f23_fops = {
 	.add_slave      = w1_f23_add_slave,
 	.remove_slave   = w1_f23_remove_slave,
 	.groups		= w1_f23_groups,
diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index d199e5a25cc0..5cfb0ae23e91 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -412,7 +412,7 @@ static const struct attribute_group *w1_ds2438_groups[] = {
 	NULL,
 };
 
-static struct w1_family_ops w1_ds2438_fops = {
+static const struct w1_family_ops w1_ds2438_fops = {
 	.groups		= w1_ds2438_groups,
 };
 
diff --git a/drivers/w1/slaves/w1_ds250x.c b/drivers/w1/slaves/w1_ds250x.c
index e507117444d8..7592c7050d1d 100644
--- a/drivers/w1/slaves/w1_ds250x.c
+++ b/drivers/w1/slaves/w1_ds250x.c
@@ -215,7 +215,7 @@ static int w1_eprom_add_slave(struct w1_slave *sl)
 	return PTR_ERR_OR_ZERO(nvmem);
 }
 
-static struct w1_family_ops w1_eprom_fops = {
+static const struct w1_family_ops w1_eprom_fops = {
 	.add_slave	= w1_eprom_add_slave,
 };
 
diff --git a/drivers/w1/slaves/w1_ds2780.c b/drivers/w1/slaves/w1_ds2780.c
index c689b1b987b8..c281fe5ed688 100644
--- a/drivers/w1/slaves/w1_ds2780.c
+++ b/drivers/w1/slaves/w1_ds2780.c
@@ -141,7 +141,7 @@ static void w1_ds2780_remove_slave(struct w1_slave *sl)
 	platform_device_unregister(pdev);
 }
 
-static struct w1_family_ops w1_ds2780_fops = {
+static const struct w1_family_ops w1_ds2780_fops = {
 	.add_slave    = w1_ds2780_add_slave,
 	.remove_slave = w1_ds2780_remove_slave,
 	.groups       = w1_ds2780_groups,
diff --git a/drivers/w1/slaves/w1_ds2781.c b/drivers/w1/slaves/w1_ds2781.c
index 84d6ceec5da5..f0d393ae070b 100644
--- a/drivers/w1/slaves/w1_ds2781.c
+++ b/drivers/w1/slaves/w1_ds2781.c
@@ -138,7 +138,7 @@ static void w1_ds2781_remove_slave(struct w1_slave *sl)
 	platform_device_unregister(pdev);
 }
 
-static struct w1_family_ops w1_ds2781_fops = {
+static const struct w1_family_ops w1_ds2781_fops = {
 	.add_slave    = w1_ds2781_add_slave,
 	.remove_slave = w1_ds2781_remove_slave,
 	.groups       = w1_ds2781_groups,
diff --git a/drivers/w1/slaves/w1_ds2805.c b/drivers/w1/slaves/w1_ds2805.c
index ccb753a474b1..206186db727d 100644
--- a/drivers/w1/slaves/w1_ds2805.c
+++ b/drivers/w1/slaves/w1_ds2805.c
@@ -281,7 +281,7 @@ static void w1_f0d_remove_slave(struct w1_slave *sl)
 	sysfs_remove_bin_file(&sl->dev.kobj, &w1_f0d_bin_attr);
 }
 
-static struct w1_family_ops w1_f0d_fops = {
+static const struct w1_family_ops w1_f0d_fops = {
 	.add_slave      = w1_f0d_add_slave,
 	.remove_slave   = w1_f0d_remove_slave,
 };
diff --git a/drivers/w1/slaves/w1_ds28e04.c b/drivers/w1/slaves/w1_ds28e04.c
index 8a640f159078..e4f336111edc 100644
--- a/drivers/w1/slaves/w1_ds28e04.c
+++ b/drivers/w1/slaves/w1_ds28e04.c
@@ -410,7 +410,7 @@ static void w1_f1C_remove_slave(struct w1_slave *sl)
 	sl->family_data = NULL;
 }
 
-static struct w1_family_ops w1_f1C_fops = {
+static const struct w1_family_ops w1_f1C_fops = {
 	.add_slave      = w1_f1C_add_slave,
 	.remove_slave   = w1_f1C_remove_slave,
 	.groups		= w1_f1C_groups,
diff --git a/drivers/w1/slaves/w1_ds28e17.c b/drivers/w1/slaves/w1_ds28e17.c
index 046ddda83df9..6b00db7169ab 100644
--- a/drivers/w1/slaves/w1_ds28e17.c
+++ b/drivers/w1/slaves/w1_ds28e17.c
@@ -741,7 +741,7 @@ static void w1_f19_remove_slave(struct w1_slave *sl)
 
 
 /* Declarations within the w1 subsystem. */
-static struct w1_family_ops w1_f19_fops = {
+static const struct w1_family_ops w1_f19_fops = {
 	.add_slave = w1_f19_add_slave,
 	.remove_slave = w1_f19_remove_slave,
 	.groups = w1_f19_groups,
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index c1b4eda16719..54f84f2d5064 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -409,21 +409,21 @@ static const struct hwmon_chip_info w1_chip_info = {
 
 /* Family operations */
 
-static struct w1_family_ops w1_therm_fops = {
+static const struct w1_family_ops w1_therm_fops = {
 	.add_slave	= w1_therm_add_slave,
 	.remove_slave	= w1_therm_remove_slave,
 	.groups		= w1_therm_groups,
 	.chip_info	= W1_CHIPINFO,
 };
 
-static struct w1_family_ops w1_ds18s20_fops = {
+static const struct w1_family_ops w1_ds18s20_fops = {
 	.add_slave	= w1_therm_add_slave,
 	.remove_slave	= w1_therm_remove_slave,
 	.groups		= w1_ds18s20_groups,
 	.chip_info	= W1_CHIPINFO,
 };
 
-static struct w1_family_ops w1_ds28ea00_fops = {
+static const struct w1_family_ops w1_ds28ea00_fops = {
 	.add_slave	= w1_therm_add_slave,
 	.remove_slave	= w1_therm_remove_slave,
 	.groups		= w1_ds28ea00_groups,
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 6bd64bcb6316..15a2ee32f116 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -160,7 +160,7 @@ static const struct attribute_group *w1_slave_default_groups[] = {
 	NULL,
 };
 
-static struct w1_family_ops w1_default_fops = {
+static const struct w1_family_ops w1_default_fops = {
 	.groups		= w1_slave_default_groups,
 };
 
-- 
2.28.0

