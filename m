Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7548257BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 17:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgHaPK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 11:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgHaPKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:10:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1CAC0619C0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 08:09:57 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s205so2615701lja.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=frzL2DLHwYvpLbcVF+BQ0a2PY0Hd2ua7rlCrnnnS4iw=;
        b=v/SH+3DcvjR6ncLV6tiH90znZNadKgQC+vIO4xIGh55/i38oQEvRJ+I9L5caIWB+6i
         0456I8RmmJffge+GR9BGkZZXSdTiumx2SEvuYnVP6MH2sSJoertZupabCrYNe2uaouAv
         iyIxc0rRUcMhFWhqQwAjUWr0xNEezSSj+1daCse0Ib2TRrDdz6U+3yqKR0mxPqczsJdl
         vRwYwkxg7KI+o1LKUc7zD33JvV4A4wSDDBHfG8KOOVTpUU9GgAARErQEm8/7FgXkcAcy
         0ta6CVkGJJWkOvH7q5sBBg9qi59qZwgJDEWyAX7Xe1ZpRgcGC4o6ZYQnXAumCqhXSgVK
         u4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=frzL2DLHwYvpLbcVF+BQ0a2PY0Hd2ua7rlCrnnnS4iw=;
        b=jmCX+/VLZN6GxqnnqU6vQbh0oLeYhV18KQHmG/4rrN0sUE8FlBYHcr81Wq3CR3QD7B
         7wq/PBKHp4umlduSP1S2nKKRw3qGSi/gvPKd2GnyeIrgMjKDXMOXm4JuoX3OuXjVKSMI
         pBBnGHlYGRy91VP+vljFMQrzWvg3kUllPiw/KPNeo5++1ADPiEr5GcCcIbqCmb6m9PPd
         N5MidBZBn007/N3C9RXKjsueVtV92JyDMbHgzdV6ap92dgsa38/XliGbv4VQy6zK95SE
         IT/pWwl07M+X4U5kD/505UGmA+vLAy4R/uz8lMNIaEEWhYIdoZSAE7+nbvercV4Bs2/1
         vpeg==
X-Gm-Message-State: AOAM533Ii+q3PXv4ibTC1hY10PlTz0LY/l1hBsxu7onubhrtWejwsQtq
        Nui+fPbb2mbL3EvpAjayGCW3Rw==
X-Google-Smtp-Source: ABdhPJz07F4VlC7McLT2OjOH/sZpc6gEG831IqYKJVqFpDZMOYn0X51CueDemMsEvXZ1Fsqq2YIuJw==
X-Received: by 2002:a2e:9e16:: with SMTP id e22mr842894ljk.389.1598886596019;
        Mon, 31 Aug 2020 08:09:56 -0700 (PDT)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id w6sm2034388lfn.73.2020.08.31.08.09.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 08:09:55 -0700 (PDT)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        s-anna@ti.com
Cc:     grzegorz.jaszczyk@linaro.org, robh+dt@kernel.org,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, david@lechnology.com,
        praneeth@ti.com
Subject: [RESEND PATCH v5 5/5] irqchip/irq-pruss-intc: Add support for ICSSG INTC on K3 SoCs
Date:   Mon, 31 Aug 2020 17:09:18 +0200
Message-Id: <1598886558-16546-6-git-send-email-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598886558-16546-1-git-send-email-grzegorz.jaszczyk@linaro.org>
References: <1598886558-16546-1-git-send-email-grzegorz.jaszczyk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The K3 AM65x and J721E SoCs have the next generation of the PRU-ICSS IP,
commonly called ICSSG. The PRUSS INTC present within the ICSSG supports
more System Events (160 vs 64), more Interrupt Channels and Host Interrupts
(20 vs 10) compared to the previous generation PRUSS INTC instances. The
first 2 and the last 10 of these host interrupt lines are used by the
PRU and other auxiliary cores and sub-modules within the ICSSG, with 8
host interrupts connected to MPU. The host interrupts 5, 6, 7 are also
connected to the other ICSSG instances within the SoC and can be
partitioned as per system integration through the board dts files.

Enhance the PRUSS INTC driver to add support for this ICSSG INTC
instance.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
---
v4->v5:
- Rename: s/num_host_intrs/num_host_events/ regarding to change
  introduced in patch #2.
v3->v4:
- Move generic part to "irqchip/irq-pruss-intc: Add a PRUSS irqchip
  driver for PRUSS interrupts" patch and leave only platform related
  code.
v2->v3:
- Change patch order: use it directly after "irqchip/irq-pruss-intc:
  Implement irq_{get,set}_irqchip_state ops" and before new
  "irqchip/irq-pruss-intc: Add event mapping support" in order to reduce
  diff.
v1->v2:
- https://patchwork.kernel.org/patch/11069773/
---
 drivers/irqchip/Kconfig          | 2 +-
 drivers/irqchip/irq-pruss-intc.c | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index a112a76..7fe4e30 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -495,7 +495,7 @@ config TI_SCI_INTA_IRQCHIP
 
 config TI_PRUSS_INTC
 	tristate "TI PRU-ICSS Interrupt Controller"
-	depends on ARCH_DAVINCI || SOC_AM33XX || SOC_AM43XX || SOC_DRA7XX || ARCH_KEYSTONE
+	depends on ARCH_DAVINCI || SOC_AM33XX || SOC_AM43XX || SOC_DRA7XX || ARCH_KEYSTONE || ARCH_K3
 	select IRQ_DOMAIN
 	help
 	   This enables support for the PRU-ICSS Local Interrupt Controller
diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index 15f0407..9e540af 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -622,11 +622,20 @@ static const struct pruss_intc_match_data pruss_intc_data = {
 	.num_host_events = 10,
 };
 
+static const struct pruss_intc_match_data icssg_intc_data = {
+	.num_system_events = 160,
+	.num_host_events = 20,
+};
+
 static const struct of_device_id pruss_intc_of_match[] = {
 	{
 		.compatible = "ti,pruss-intc",
 		.data = &pruss_intc_data,
 	},
+	{
+		.compatible = "ti,icssg-intc",
+		.data = &icssg_intc_data,
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, pruss_intc_of_match);
-- 
2.7.4

