Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961FB2EFC0C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 01:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbhAIASi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 19:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbhAIASh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 19:18:37 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC69C061573
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 16:17:57 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id s26so27041816lfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 16:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzcscj//mpOGcYGQutZ6YI5vQxHkSdR93o+WV08wP50=;
        b=stMeMPjOp5t7xtTEUDOj4306bXiX1ET2L6sNZ4aDkt6ivdIY+i/eHhD23CVV0quep9
         nf3NaxtrvPSJKmj1gS7q5Dy5iJ6nm5vy0N1pxyPC2tALKhrd65pTznr2rYR23hw72G32
         FVvzsJfpweVh0IHo31fcNRr/fSCnKkxhee1S/7ShfjeEjH3TO/Owuwx+rrK9hDRMdbAt
         tnNL0AugKjyQ0Nd9vi7W0NBlxc+jn8C7UxmMkLfn5UIs7l6Pi1mvJPITkvElQFX0Y3cT
         y/5ncLKv1ph8FQRm+TF3Mfd/Os5eC/ZCEHNn/5P7qcb4OL9+8X0v1Fw1UDzR9eGCZcg9
         xAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzcscj//mpOGcYGQutZ6YI5vQxHkSdR93o+WV08wP50=;
        b=bofP2KLOPsP62XJtd5uGvlotM3/n3JTUovh51ocMwSIjyF9QX0Bk46SlTnPf7SOrzf
         8Dzh7B4I3p9mYThyXB/kJCjtPWS+Xjtc92v/LR4GYVeMfpDnWdYR3EnPAfDTnpej+Lj3
         bLAWtv4e6+MgrGDT4Tv8HUVjdC1L5NsSh8k55/a7x3IMyZAgwEts+i5FqlAQZRCt2L5R
         fu/qajQfjJ9SdBPqiUldN6FSi+m0tO6XNL01eDktgD1+TDR2AVcgqYUttPPR2vAOEc8U
         IK2wdvcnn/+djwA9vXWDJ+nAX+WNC9u9HEGxn1HLxsXH93gUPyDvohuN0rIEd+Jk6At0
         qjbg==
X-Gm-Message-State: AOAM533YJxLEYBDXP6UM1+uH02G2lhONfybbqxZuDSYvHM3UGieV6Or4
        QqZ7ClsKijQO7Er1SjgR3l8=
X-Google-Smtp-Source: ABdhPJwuB6dc7p0cs/sOH6OtJ7rNeswoM1TNaZToLE+ANYYTNxBvJ52G7q/6LMsuoTc0Gun8G9vIJQ==
X-Received: by 2002:ac2:5086:: with SMTP id f6mr2446158lfm.593.1610151475634;
        Fri, 08 Jan 2021 16:17:55 -0800 (PST)
Received: from localhost.localdomain (h-98-128-228-148.NA.cust.bahnhof.se. [98.128.228.148])
        by smtp.gmail.com with ESMTPSA id v21sm2390877ljk.73.2021.01.08.16.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 16:17:54 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] platform/chrome: Constify static attribute_group structs
Date:   Sat,  9 Jan 2021 01:17:48 +0100
Message-Id: <20210109001748.58036-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of these is to print their name in a dev_err-message, and
to pass their address to sysfs_create_group() and sysfs_remove_group(),
both which takes pointers to const. Make them const to allow the compiler
to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/platform/chrome/cros_ec_lightbar.c | 2 +-
 drivers/platform/chrome/cros_ec_sysfs.c    | 2 +-
 drivers/platform/chrome/cros_ec_vbc.c      | 2 +-
 drivers/platform/chrome/wilco_ec/sysfs.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index de8dfb12e486..469dfc7a4a03 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -523,7 +523,7 @@ static struct attribute *__lb_cmds_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group cros_ec_lightbar_attr_group = {
+static const struct attribute_group cros_ec_lightbar_attr_group = {
 	.name = "lightbar",
 	.attrs = __lb_cmds_attrs,
 };
diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index f521a5c65091..fc8681f80aba 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -329,7 +329,7 @@ static umode_t cros_ec_ctrl_visible(struct kobject *kobj,
 	return a->mode;
 }
 
-static struct attribute_group cros_ec_attr_group = {
+static const struct attribute_group cros_ec_attr_group = {
 	.attrs = __ec_attrs,
 	.is_visible = cros_ec_ctrl_visible,
 };
diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
index f3a70a312b43..c859c862d7ac 100644
--- a/drivers/platform/chrome/cros_ec_vbc.c
+++ b/drivers/platform/chrome/cros_ec_vbc.c
@@ -101,7 +101,7 @@ static struct bin_attribute *cros_ec_vbc_bin_attrs[] = {
 	NULL
 };
 
-static struct attribute_group cros_ec_vbc_attr_group = {
+static const struct attribute_group cros_ec_vbc_attr_group = {
 	.name = "vbc",
 	.bin_attrs = cros_ec_vbc_bin_attrs,
 };
diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
index 3c587b4054a5..79a5e8fa680f 100644
--- a/drivers/platform/chrome/wilco_ec/sysfs.c
+++ b/drivers/platform/chrome/wilco_ec/sysfs.c
@@ -236,7 +236,7 @@ static struct attribute *wilco_dev_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group wilco_dev_attr_group = {
+static const struct attribute_group wilco_dev_attr_group = {
 	.attrs = wilco_dev_attrs,
 };
 
-- 
2.30.0

