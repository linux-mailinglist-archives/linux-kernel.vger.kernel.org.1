Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4D1267A7C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 14:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgILMwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 08:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgILMwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 08:52:07 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EDE621548;
        Sat, 12 Sep 2020 12:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599915126;
        bh=hdZxjd6wROF46ulEXaL1r8Qh7vy+67B2mL/4PqcChOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=igDqGf8jouaI91hLmQoIws6wPC1jVdF9RTHtagkc0NXp4oPeY5KA1vSZiCCAg8bKU
         jTiaXqWApkfSgYM8Lz0taQYe0r7eMqE2fCp60TygTdb8KaenIq/y8J1HVzap1D3lgr
         zrR3HSUnjpls+pk7UvQ1Ficg0eUZptrVihzsMRV8=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kH50f-00BEw6-1g; Sat, 12 Sep 2020 13:52:05 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Frank Wunderlich <linux@fw-web.de>,
        John Stultz <john.stultz@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, kernel-team@android.com
Subject: [PATCH 1/6] of: Add basic infrastructure to create early probe arrays
Date:   Sat, 12 Sep 2020 13:51:43 +0100
Message-Id: <20200912125148.1271481-2-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200912125148.1271481-1-maz@kernel.org>
References: <20200912125148.1271481-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, enric.balletbo@collabora.com, linux@fw-web.de, john.stultz@linaro.org, saravanak@google.com, hanks.chen@mediatek.com, agross@kernel.org, bjorn.andersson@linaro.org, matthias.bgg@gmail.com, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, frowand.list@gmail.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently probe interrupt controller and timers that need
to be available very early using an infratstructure that creates
struct of_device_id instances in a special section. These are
individual structures that are ultimately collated by the linker.

In order to facilitate further use of this infrastructure for
drivers that can either be built modular or as an early driver,
let's add a couple of helpers that will make it look like a
"normal" device_id array, like this:

_OF_DECLARE_ARRAY_START(table, name)
_OF_DECLARE_ELMT("compat-1", probe, type)
_OF_DECLARE_ELMT("compat-2", probe, type)
_OF_DECLARE_ELMT("compat-3", other_probe, type)
_OF_DECLARE_ARRAY_END

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/of.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 5cf7ae0465d1..08f78da95378 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1291,20 +1291,35 @@ static inline int of_get_available_child_count(const struct device_node *np)
 	return num;
 }
 
+#define __OF_DECLARE_ARRAY_START(name, section)				\
+	static const struct of_device_id __of_table_##name[]		\
+		__used __section(section) = {
+
 #if defined(CONFIG_OF) && !defined(MODULE)
 #define _OF_DECLARE(table, name, compat, fn, fn_type)			\
 	static const struct of_device_id __of_table_##name		\
 		__used __section(__##table##_of_table)			\
 		 = { .compatible = compat,				\
 		     .data = (fn == (fn_type)NULL) ? fn : fn  }
+#define _OF_DECLARE_ARRAY_START(table, name)				\
+	__OF_DECLARE_ARRAY_START(name, __##table##_of_table)
 #else
 #define _OF_DECLARE(table, name, compat, fn, fn_type)			\
 	static const struct of_device_id __of_table_##name		\
 		__attribute__((unused))					\
 		 = { .compatible = compat,				\
 		     .data = (fn == (fn_type)NULL) ? fn : fn }
+#define _OF_DECLARE_ARRAY_START(table, name)				\
+	__OF_DECLARE_ARRAY_START(name, unused)
 #endif
 
+#define _OF_DECLARE_ARRAY_END	}
+#define _OF_DECLARE_ELMT(compat, fn, fn_type)				\
+	{								\
+		.compatible = compat,					\
+		.data = (fn == (fn_type)NULL) ? fn : fn,		\
+	},
+
 typedef int (*of_init_fn_2)(struct device_node *, struct device_node *);
 typedef int (*of_init_fn_1_ret)(struct device_node *);
 typedef void (*of_init_fn_1)(struct device_node *);
-- 
2.28.0

