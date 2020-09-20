Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7912713FE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 13:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgITLid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 07:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgITLid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 07:38:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56562C061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 04:38:33 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bg9so5439634plb.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 04:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5x36St2SR/MgGGnXM1YGsEJzys3Xt76zn0yUDw5rE1k=;
        b=NILqLBcF9SKSwAdqqV5Un7GhlOORkz/YqJFZ3wntq8QGN4WilIbSD3OEZWdOfMMjYq
         dkEdXsBGISMGUjWrWgX94N5sCWIFByvJU85QskpVmNUqjO47N4DuztawHMpLslTpaxIX
         5M9PNnbeOp+lwR2vdOyy5LrX/rHDaudE4snszJjkDDZ6lFnWh9yZmmFrHSjs6vEwJAvt
         OL+2DfIaV9tJGS6ckmgPb3RxG0bUYtc3VJv05f4eUFNeUxDAq4ETof9FO421xbFTS+Zq
         n5zVoL5dQN9H4fYlGFomOzvfApwlgDbzu4t14gjbgBvWVNui4ZdL6vrxLD+kIjAXWAsx
         OLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5x36St2SR/MgGGnXM1YGsEJzys3Xt76zn0yUDw5rE1k=;
        b=VaSQf9PrSWN0TOCa5hDOWN5ZVRVdnW+ndVyGG4nqRszv1odYhsMKPVwKw9v1uA9zS1
         EnQkluTd56GjPh2+1DNVWHzzI46lBW9GhZOgcnjR6YoqtpBgoKcG+nepHiLE1y5gu9Vy
         T2Aop6rscoFzGYaObHD8pBUpYev4lZedt5s0J27sCvO8wxiLxIUPZbJu4M9LSOk8JEk7
         Alk1SVtLeUCnlD7hvSgr+5WuK/q0EhcSgypwpBeWEre47yuCOwzKl6s7UHSFhH0vEF7N
         TIanyWQ2LncG3FGxAehRuDuHpnTeUdDEkhFfk7c7EPf5sJ5XX6gvriGneqabzn/fIpol
         74pg==
X-Gm-Message-State: AOAM532mFtKexape32VeQTovJE/VO4gsNinzF3L0IMt5TnkU+2l5P1cl
        SXIoQN1KEQbfLqEB7FDawsg=
X-Google-Smtp-Source: ABdhPJzDW+o0q3GjfRovDgH6CbTwQWyvzdqEI3Xmu65STTT7HUHJfe6P1e48XIx7clYRPdNUmFVEwA==
X-Received: by 2002:a17:902:ee93:b029:d2:1425:7c90 with SMTP id a19-20020a170902ee93b02900d214257c90mr5459348pld.30.1600601912833;
        Sun, 20 Sep 2020 04:38:32 -0700 (PDT)
Received: from localhost.localdomain ([1.200.101.36])
        by smtp.gmail.com with ESMTPSA id y24sm9041702pfn.161.2020.09.20.04.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 04:38:31 -0700 (PDT)
From:   pierre Kuo <vichy.kuo@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, pierre Kuo <vichy.kuo@gmail.com>
Subject: [PATCH 1/2] lib: devres: provide devm_iounremap_resource()
Date:   Sun, 20 Sep 2020 19:38:07 +0800
Message-Id: <20200920113808.22223-1-vichy.kuo@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver doesn't have a single helper function to release memroy
allocated by devm_ioremap_resource(). That mean it needs respectively
to call devm_release_mem_region() and devm_iounmap() for memory release.

This patch creates a helper, devm_iounremap_resource(), to combine above
operations.

Signed-off-by: pierre Kuo <vichy.kuo@gmail.com>
---
 include/linux/device.h |  2 ++
 lib/devres.c           | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 9e6ea8931a52..33ec7e54c1a9 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -240,6 +240,8 @@ void devm_free_pages(struct device *dev, unsigned long addr);
 
 void __iomem *devm_ioremap_resource(struct device *dev,
 				    const struct resource *res);
+void devm_iounremap_resource(struct device *dev,
+			     const struct resource *res, void __iomem *addr);
 void __iomem *devm_ioremap_resource_wc(struct device *dev,
 				       const struct resource *res);
 
diff --git a/lib/devres.c b/lib/devres.c
index ebb1573d9ae3..cdda0cd0a263 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -113,6 +113,31 @@ void devm_iounmap(struct device *dev, void __iomem *addr)
 }
 EXPORT_SYMBOL(devm_iounmap);
 
+/**
+ * devm_iounremap_resource() - release mem region, and unremap address
+ * @dev: generic device to handle the resource for
+ * @res: resource of mem region to be release
+ * @addr: address to unmap
+ *
+ * Release memory region and unmap address.
+ */
+void devm_iounremap_resource(struct device *dev,
+			     const struct resource *res, void __iomem *addr)
+{
+	resource_size_t size;
+
+	BUG_ON(!dev);
+	if (!res || resource_type(res) != IORESOURCE_MEM) {
+		dev_err(dev, "invalid resource\n");
+		return;
+	}
+
+	size = resource_size(res);
+	devm_release_mem_region(dev, res->start, size);
+	devm_iounmap(dev, addr);
+}
+EXPORT_SYMBOL(devm_iounremap_resource);
+
 static void __iomem *
 __devm_ioremap_resource(struct device *dev, const struct resource *res,
 			enum devm_ioremap_type type)
-- 
2.17.1

