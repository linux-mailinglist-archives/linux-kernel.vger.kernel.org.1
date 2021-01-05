Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529492EAC7A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbhAEN5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbhAEN5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:57:09 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DCEC061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 05:56:29 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r3so36296461wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 05:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QvgsfPRwrrfjVEJ2UatG4ysYY2qO90ZN+qbflKAlwaI=;
        b=MUCGc12vaYoAV6vDCddsbGxIXU/aX5CGurXVVFSlKeXqLaJePFEEoFEiuYummNawZS
         OfT5N1TKBT0+3UjToyMQxq4nVJbhY4NouQHZPJAiulQO/ZwJkja3BFPeUcfbD55zxiSf
         z71peECidTkbi/rSDlWcBuor3XlqxTqnvzhrykK7vu8JQvWmb9At07Sh5fZL0akltZOv
         eTxxiaFGqY0ZYm0YL+GC7x7kLrP0fziJgVtXNksclUH33mjRcvLeY+K1MvqKeVT7rq+0
         5hWUPZZVy2hDM7Uf1GoFl0otOAmmAYi/kvciupq+c8/HYY6fHsSlPYFe3ik0juhk0HNo
         Ag0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QvgsfPRwrrfjVEJ2UatG4ysYY2qO90ZN+qbflKAlwaI=;
        b=KuiqrCYe9B3kTd+jLvB5SK1uqpYfunBdk0OD/1506WB2Wo5gRg+6NGQxol+syqNYEp
         WZFkHWhLeeE0TedfTG43VyDMmACtNsOZiWiYS7atSGJKMCOSxbEgsF1yqs4/t43Ie/Nj
         CV39kjjYvO+XNSN6ZnQB/zAuB07kGm9FtLsQHqgiT/M9GqjnrANiSqP7NN9Ees4YtlHR
         vWRaHWxrQ9tFp9sRfkAM042uMFb16XPd9jX3R2MfeqNp1QpqqVkSkTut/hueEBIRkPs1
         SaGv3RX9coz6mwgdgSHbdX6YgMtXKCxjrV3FBbDDlbo55yKFRc3cM6K/FpIe7mUDkUUd
         8lqw==
X-Gm-Message-State: AOAM533ekmTM0GcwSo3NYLZFIcB0FKMbnDdy67V8PgjpsI7m1UGjVymR
        HqCpSFHG7dxalz1ZxPubHUJak1QlEOUOUw==
X-Google-Smtp-Source: ABdhPJwWQobe1NUocF4pm7TjN/4OZV+R+dEWSS7fCKMBZvfjdKb0KQKJ0H7qf4mYAxVd+luDNRAXqg==
X-Received: by 2002:adf:a3ca:: with SMTP id m10mr84567516wrb.228.1609854988317;
        Tue, 05 Jan 2021 05:56:28 -0800 (PST)
Received: from localhost.localdomain (pop.92-184-112-247.mobile.abo.orange.fr. [92.184.112.247])
        by smtp.gmail.com with ESMTPSA id r20sm107358547wrg.66.2021.01.05.05.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 05:56:27 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] irq/irq_sim: shrink devm_irq_domain_create_sim()
Date:   Tue,  5 Jan 2021 14:56:14 +0100
Message-Id: <20210105135614.32104-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We don't have to use a custom devres structure if all we manage is a
single pointer - we can use devm_add_action_or_reset() for that and
shrink the code a bit.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 kernel/irq/irq_sim.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 48006608baf0..6e935d4d1ec5 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -24,10 +24,6 @@ struct irq_sim_irq_ctx {
 	struct irq_sim_work_ctx	*work_ctx;
 };
 
-struct irq_sim_devres {
-	struct irq_domain	*domain;
-};
-
 static void irq_sim_irqmask(struct irq_data *data)
 {
 	struct irq_sim_irq_ctx *irq_ctx = irq_data_get_irq_chip_data(data);
@@ -216,11 +212,11 @@ void irq_domain_remove_sim(struct irq_domain *domain)
 }
 EXPORT_SYMBOL_GPL(irq_domain_remove_sim);
 
-static void devm_irq_domain_release_sim(struct device *dev, void *res)
+static void devm_irq_domain_remove_sim(void *data)
 {
-	struct irq_sim_devres *this = res;
+	struct irq_domain *domain = data;
 
-	irq_domain_remove_sim(this->domain);
+	irq_domain_remove_sim(domain);
 }
 
 /**
@@ -238,20 +234,17 @@ struct irq_domain *devm_irq_domain_create_sim(struct device *dev,
 					      struct fwnode_handle *fwnode,
 					      unsigned int num_irqs)
 {
-	struct irq_sim_devres *dr;
+	struct irq_domain *domain;
+	int ret;
 
-	dr = devres_alloc(devm_irq_domain_release_sim,
-			  sizeof(*dr), GFP_KERNEL);
-	if (!dr)
-		return ERR_PTR(-ENOMEM);
+	domain = irq_domain_create_sim(fwnode, num_irqs);
+	if (IS_ERR(domain))
+		return domain;
 
-	dr->domain = irq_domain_create_sim(fwnode, num_irqs);
-	if (IS_ERR(dr->domain)) {
-		devres_free(dr);
-		return dr->domain;
-	}
+	ret = devm_add_action_or_reset(dev, devm_irq_domain_remove_sim, domain);
+	if (ret)
+		return ERR_PTR(ret);
 
-	devres_add(dev, dr);
-	return dr->domain;
+	return domain;
 }
 EXPORT_SYMBOL_GPL(devm_irq_domain_create_sim);
-- 
2.29.1

