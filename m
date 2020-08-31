Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7937257BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 17:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgHaPKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 11:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbgHaPJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:09:58 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A1EC0611E1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 08:09:55 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e11so7107458ljn.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Oe4tacp/96y2oKOUNNpzoTA6Aq+PNNKI08nVOHEYABg=;
        b=fiqC6LLJSVenAjqZKrRWwcs2FxmsYmyCRHEtBDP+OxMbOsnvwhWbknefzIALIKNf/O
         Qe6iiwViNEHh5qVuIpgmiGnaf0cwEtUaAjsiJ1opIeLHvFrdwVZEL8H3MvhUGNp9XNcb
         GKqjTmUrxPK3rPT9WyZ1Q076COuDlA0ykp8+TwiXVEnC9hdkObAsbMZGviVVUddQc1/T
         iQifgD8IMnQ2+NIeOcQRshq1ZxzIogqHl+3JIBUm1307AMw8iXrDaxvgak6gzNJkTNTw
         56d3ZTBlWUwDNIqAaZz4FuIchWjdLQeO0NlKqpkDxUC8YXzCHeqHi6oEDcC2VHm/kBdI
         wERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Oe4tacp/96y2oKOUNNpzoTA6Aq+PNNKI08nVOHEYABg=;
        b=r3yet6aDuusGHCj6o2oYRe9btxPOcsulCeKmdJ8PG/AYUIVA85AOCbq58IrN8oMt5R
         UyjzaRd92AqRiwIffoDBInFXiPmF4BXDO96e4/Gn/MYHXpclUaezgBKz7cwLDpB2jy15
         ZHrqRgh5JdkPXcLhF3a33WAUPddsaBE78CHIswpXIR6PyKV4r82WwwPypZ8PnvckZijT
         KhYMXodNC3DRojxYgwmlKAh7wyWLD9GRQo194WoDkaSHp0r0B2zK0UTO7Rr+Jz0+zUQk
         u1DETnOfcULu9ArnijdGbTNolD5oWBhJbthlr+wthHlElI1QA/K6fotNBduQ8NbUMmCt
         8/xA==
X-Gm-Message-State: AOAM530dPiKWnMGsdxMdKH9Euywu/1vg59n9p1P/cYLE1sINW6X+A2TC
        LIUPRqssuJjqa3m0e5bExh5bcciLkUfBDg==
X-Google-Smtp-Source: ABdhPJzehq3pw6VOdyjpjeq4GYkB3PrJFk17PerXnTtMTcKpLGzPJMMzwDXBAdaLV5NuxAxm9BJX5g==
X-Received: by 2002:a05:651c:110d:: with SMTP id d13mr861751ljo.206.1598886594106;
        Mon, 31 Aug 2020 08:09:54 -0700 (PDT)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id w6sm2034388lfn.73.2020.08.31.08.09.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 08:09:53 -0700 (PDT)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        s-anna@ti.com
Cc:     grzegorz.jaszczyk@linaro.org, robh+dt@kernel.org,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, david@lechnology.com,
        praneeth@ti.com
Subject: [RESEND PATCH v5 4/5] irqchip/irq-pruss-intc: Implement irq_{get,set}_irqchip_state ops
Date:   Mon, 31 Aug 2020 17:09:17 +0200
Message-Id: <1598886558-16546-5-git-send-email-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598886558-16546-1-git-send-email-grzegorz.jaszczyk@linaro.org>
References: <1598886558-16546-1-git-send-email-grzegorz.jaszczyk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

This implements the irq_get_irqchip_state and irq_set_irqchip_state
callbacks for the TI PRUSS INTC driver. The set callback can be used
by drivers to "kick" a PRU by injecting a PRU system event.

Example:
     irq_set_irqchip_state(irq, IRQCHIP_STATE_PENDING, true);

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Reviewed-by: Lee Jones <lee.jones@linaro.org>
---
v4->v5:
- No change.
v3->v4:
- Update commit message
v2->v3:
- Get rid of unnecessary pruss_intc_check_write() and use
  pruss_intc_write_reg directly.
v1->v2:
- https://patchwork.kernel.org/patch/11069769/
---
 drivers/irqchip/irq-pruss-intc.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index 1a72591..15f0407 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -9,6 +9,7 @@
  * Copyright (C) 2019 David Lechner <david@lechnology.com>
  */
 
+#include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
@@ -319,6 +320,43 @@ static void pruss_intc_irq_relres(struct irq_data *data)
 	module_put(THIS_MODULE);
 }
 
+static int pruss_intc_irq_get_irqchip_state(struct irq_data *data,
+					    enum irqchip_irq_state which,
+					    bool *state)
+{
+	struct pruss_intc *intc = irq_data_get_irq_chip_data(data);
+	u32 reg, mask, srsr;
+
+	if (which != IRQCHIP_STATE_PENDING)
+		return -EINVAL;
+
+	reg = PRU_INTC_SRSR(data->hwirq / 32);
+	mask = BIT(data->hwirq % 32);
+
+	srsr = pruss_intc_read_reg(intc, reg);
+
+	*state = !!(srsr & mask);
+
+	return 0;
+}
+
+static int pruss_intc_irq_set_irqchip_state(struct irq_data *data,
+					    enum irqchip_irq_state which,
+					    bool state)
+{
+	struct pruss_intc *intc = irq_data_get_irq_chip_data(data);
+
+	if (which != IRQCHIP_STATE_PENDING)
+		return -EINVAL;
+
+	if (state)
+		pruss_intc_write_reg(intc, PRU_INTC_SISR, data->hwirq);
+	else
+		pruss_intc_write_reg(intc, PRU_INTC_SICR, data->hwirq);
+
+	return 0;
+}
+
 static struct irq_chip pruss_irqchip = {
 	.name = "pruss-intc",
 	.irq_ack = pruss_intc_irq_ack,
@@ -326,6 +364,8 @@ static struct irq_chip pruss_irqchip = {
 	.irq_unmask = pruss_intc_irq_unmask,
 	.irq_request_resources = pruss_intc_irq_reqres,
 	.irq_release_resources = pruss_intc_irq_relres,
+	.irq_get_irqchip_state = pruss_intc_irq_get_irqchip_state,
+	.irq_set_irqchip_state = pruss_intc_irq_set_irqchip_state,
 };
 
 static int pruss_intc_validate_mapping(struct pruss_intc *intc, int event,
-- 
2.7.4

