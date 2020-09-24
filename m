Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F1927715B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgIXMqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgIXMpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:45:42 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4699C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:41 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e17so3416807wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HPzKPqgKTaC+c4dKHoIGgkQqLuuLy1eGCUBepiGybzo=;
        b=EDzQhN6+3MhbwhbiWnsXIzCMt/0ygeuAPYwa4X2BvXrnO69+RGiACMLk0e+WXyKIMQ
         BqqubfzMrRVISKpLEZHccDjLvL4e8icTrn/eC8Hth/i/6rU8AczabLTae2iVWpftmHu0
         bRDCpJ1cwA94kP93eN8ROza6YHE3mOOBdDyH0hFBscvLd9yfV2yRjDQZCtKChAUUUe6V
         9NnwHqCLuqoFGg2Lo+hyU0uMBMCH3dAB1jSg6QtEk+3IpxvL2kGpb5pZVVO9Rmzj6F0a
         pePwNn0H1KNhrhnk4lILy1ksVh++PvSMp1pa/xJDMeLSQYXexiaPUQQZZc2+INh7PVil
         JX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HPzKPqgKTaC+c4dKHoIGgkQqLuuLy1eGCUBepiGybzo=;
        b=PhqNfprdiWOt7NqwwZsbsAD46XU/fWmWsuCzErC1IjEXFd0ddYgNGDEGesjb6Wfsrn
         6cxtBNFeQ+ZTTAmiI7KCthvSiJSMn3oyRpObWN/0p4qmmdlij7gED8F7bjTs7YAqbm4s
         NVya5ITrMhg7iv31pMWkW6pNgVfYh77UKxSIZHS4s+BuaAQ7p8X6z1+48kpxl8Zx344/
         3fDRdB8aYaKBAqAdZyDxcyHFu1MXSKPI0H7kY2cyxodFF5E+jRCE5/L3LnfAXS9mT6Of
         +wmcmT1LD6SCa8rkDY6sGVi2GCX+iWTsutUy8jew0gW1Su8FfVqm4M48ZgdtaaCsuwiO
         g8jA==
X-Gm-Message-State: AOAM5307yd5GtGnFeZ8fkGsacyRTytt6WHsoYqJA1LSH6mDiCNMTUhw+
        SpF6vnNC1xdua2DYO35pOT+I/eEpXfqi/w==
X-Google-Smtp-Source: ABdhPJyHPv/Gfo8fWSk6LNIyllV6fFj7peRVmhFYOmFXYUX+3AbIg7Wdvr/FrcplO951HwXVHbDWVA==
X-Received: by 2002:a1c:ed05:: with SMTP id l5mr4626293wmh.106.1600951540649;
        Thu, 24 Sep 2020 05:45:40 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id 9sm3316834wmf.7.2020.09.24.05.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:45:39 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 05/12] samples: configfs: improve alignment of broken lines
Date:   Thu, 24 Sep 2020 14:45:19 +0200
Message-Id: <20200924124526.17365-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200924124526.17365-1-brgl@bgdev.pl>
References: <20200924124526.17365-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Improve the coding style by correctly aligning broken lines where
possible.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 samples/configfs/configfs_sample.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/samples/configfs/configfs_sample.c b/samples/configfs/configfs_sample.c
index e339404dce1c..924b57258af0 100644
--- a/samples/configfs/configfs_sample.c
+++ b/samples/configfs/configfs_sample.c
@@ -58,7 +58,7 @@ static ssize_t childless_storeme_show(struct config_item *item, char *page)
 }
 
 static ssize_t childless_storeme_store(struct config_item *item,
-		const char *page, size_t count)
+				       const char *page, size_t count)
 {
 	struct childless *childless = to_childless(item);
 	unsigned long tmp;
@@ -141,7 +141,7 @@ static ssize_t simple_child_storeme_show(struct config_item *item, char *page)
 }
 
 static ssize_t simple_child_storeme_store(struct config_item *item,
-		const char *page, size_t count)
+					  const char *page, size_t count)
 {
 	struct simple_child *simple_child = to_simple_child(item);
 	unsigned long tmp;
@@ -192,7 +192,7 @@ static inline struct simple_children *to_simple_children(struct config_item *ite
 }
 
 static struct config_item *simple_children_make_item(struct config_group *group,
-		const char *name)
+						     const char *name)
 {
 	struct simple_child *simple_child;
 
@@ -209,7 +209,7 @@ static struct config_item *simple_children_make_item(struct config_group *group,
 }
 
 static ssize_t simple_children_description_show(struct config_item *item,
-		char *page)
+						char *page)
 {
 	return sprintf(page,
 "[02-simple-children]\n"
@@ -270,8 +270,8 @@ static struct configfs_subsystem simple_children_subsys = {
  * children of its own.
  */
 
-static struct config_group *group_children_make_group(
-		struct config_group *group, const char *name)
+static struct config_group *
+group_children_make_group(struct config_group *group, const char *name)
 {
 	struct simple_children *simple_children;
 
-- 
2.17.1

