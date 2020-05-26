Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4D71AD855
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 10:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbgDQIMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 04:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729626AbgDQIMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 04:12:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E6CC061A0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 01:12:19 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so1997621wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 01:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tvakS3Q1pErt74Ey/8HB1NoTJzsrnVjlY4jXc80KzI0=;
        b=IKd6F4bWA7WDLrZgc2/6LrZcaXCOq0Y2jTar7smrNtnWPCXewaNPWJ0LFCfGVZxctP
         mVAtIdPUzDSxdpSFVpLNUVqesoTJpD5c+cThZKaNGMvQsY/VHG5K2yDWoN99DBtkyjwv
         K/kj22LEhbSBphsT9eVKHE2p59eV3MV0y2rLlZdBck6/raxTg13Yd1bzdMj2zC1V8fVo
         uImyp3wfedtwwKcDGIH/30APkNPWkyIXatXKpdOyooiPtioHv0tk/30JqaE4QTPlrFBj
         6C7OfSQW7j3xI0h17d1w88weIDToS+PNUWRFguYrVz/dMiA7QsuyyryblykhCkgLknrY
         V5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tvakS3Q1pErt74Ey/8HB1NoTJzsrnVjlY4jXc80KzI0=;
        b=KYugkJuf+hHZxlD4mlOKKFaA9BpWB3amevLNeq/SLR26ZSCxGsS8C02s8J+UmZtoXw
         iO3a1A1H5Fak1DEddTMkksh6eemM4caxtpChaAUvTawHhnImSoGoZUvGvmYuwLbM7BUx
         ZxVOwjA6wpZX9VVbyE+TULnOFS12JA2JyaOsBHZdQhn2u4d345+KPfDmjRWNOV6o5ZjM
         9wpG8xvd8Jk0tseAAjn86bS26AsNuHRMlXbR7G8pZr1k9dIPnRhJ8LPKhlWc9IuRtv0V
         uWJEKTn5kKyUfU7SKJVKGIXg8fIly+3cEJSlSkKUi8qVmQz/lLtHktbUOPeRXo101TGK
         QYew==
X-Gm-Message-State: AGi0PuZY+TF6SX6MJXFu3tyPiAjjGekTQypD6D2DkJuPvCKCi6CUAYIq
        6jd9yM9lbG8GLGKG+kyiwjF2x8mxisE=
X-Google-Smtp-Source: APiQypJwT4Q0hCYipPDC2QfGJ+x7V+WnSu9vTp7m+D3Vh6ytki4rOtSRRVlFbI0W00wBcdSje3GJhA==
X-Received: by 2002:adf:9564:: with SMTP id 91mr2638000wrs.246.1587111138514;
        Fri, 17 Apr 2020 01:12:18 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id o129sm1078078wme.16.2020.04.17.01.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 01:12:17 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 1/2] irq: make irq_domain_reset_irq_data() available even for non-V2 users
Date:   Fri, 17 Apr 2020 10:05:48 +0200
Message-Id: <20200417080549.23751-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200417080549.23751-1-brgl@bgdev.pl>
References: <20200417080549.23751-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

irq_domain_reset_irq_data() doesn't modify the parent data, so it can be
made available even if irq domain hierarchy is not being built. We'll
subsequently use it in irq_sim code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/irqdomain.h |  4 ++--
 kernel/irq/irqdomain.c    | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 8d062e86d954..ca3849224059 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -450,6 +450,7 @@ extern void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
 				irq_hw_number_t hwirq, struct irq_chip *chip,
 				void *chip_data, irq_flow_handler_t handler,
 				void *handler_data, const char *handler_name);
+extern void irq_domain_reset_irq_data(struct irq_data *irq_data);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 extern struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
 			unsigned int flags, unsigned int size,
@@ -475,7 +476,6 @@ extern int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 extern void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs);
 extern int irq_domain_activate_irq(struct irq_data *irq_data, bool early);
 extern void irq_domain_deactivate_irq(struct irq_data *irq_data);
-
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)
 {
@@ -491,7 +491,7 @@ extern int irq_domain_set_hwirq_and_chip(struct irq_domain *domain,
 					 irq_hw_number_t hwirq,
 					 struct irq_chip *chip,
 					 void *chip_data);
-extern void irq_domain_reset_irq_data(struct irq_data *irq_data);
+
 extern void irq_domain_free_irqs_common(struct irq_domain *domain,
 					unsigned int virq,
 					unsigned int nr_irqs);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 35b8d97c3a1d..e2aa128ea3ee 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1047,6 +1047,18 @@ int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq,
 	return virq;
 }
 
+/**
+ * irq_domain_reset_irq_data - Clear hwirq, chip and chip_data in @irq_data
+ * @irq_data:	The pointer to irq_data
+ */
+void irq_domain_reset_irq_data(struct irq_data *irq_data)
+{
+	irq_data->hwirq = 0;
+	irq_data->chip = &no_irq_chip;
+	irq_data->chip_data = NULL;
+}
+EXPORT_SYMBOL_GPL(irq_domain_reset_irq_data);
+
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 /**
  * irq_domain_create_hierarchy - Add a irqdomain into the hierarchy
@@ -1247,18 +1259,6 @@ void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
 }
 EXPORT_SYMBOL(irq_domain_set_info);
 
-/**
- * irq_domain_reset_irq_data - Clear hwirq, chip and chip_data in @irq_data
- * @irq_data:	The pointer to irq_data
- */
-void irq_domain_reset_irq_data(struct irq_data *irq_data)
-{
-	irq_data->hwirq = 0;
-	irq_data->chip = &no_irq_chip;
-	irq_data->chip_data = NULL;
-}
-EXPORT_SYMBOL_GPL(irq_domain_reset_irq_data);
-
 /**
  * irq_domain_free_irqs_common - Clear irq_data and free the parent
  * @domain:	Interrupt domain to match
-- 
2.25.0

