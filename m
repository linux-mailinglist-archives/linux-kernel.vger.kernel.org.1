Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569062FCC99
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbhATITL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbhATIHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:07:05 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1960C061793
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:05:30 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id u17so22891528qku.17
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DHTbZHOkLsKuxtNFUubtLM+gqL6YY3qNMXB7NuoXXTA=;
        b=Il85GfxJuukw/3SvMs3zLOlirjw0U0IRX28xLvqLD/ty4nOJ9Xp2b6K/KilcjTtmQM
         l537tY9lg5rnaulxbobhsAQ4ifT7eB3rf7cPRgXY2+779zC29zzRqjwxCm/qPxoZFv/T
         YLNOmli8uuHOFGw2BPlx47YqPWcXY9rNa3RaHpibks4PcGEamflHasRmla1Xc09F3K3H
         q/XHi9O0n4NiedG60FpJA022VrFu72+DH+a6+I8VVIwjqABMUaVUYwhaJgA5/MCSpuah
         95TGfv7ff6pRPcUfPbgtt/nVwnmLY6DkE0HEZitHNxnfVAqkWg4tMJoqPW9JRwpn00BR
         AEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DHTbZHOkLsKuxtNFUubtLM+gqL6YY3qNMXB7NuoXXTA=;
        b=E/mbN9JtTt7YzCPs7qhYJMPOo5u394ZGvUio71Ff0p8drtCHGUcoeMUkdExTKSQofV
         DP2qJD8j4enc6V8r/L8TTJz2OiNzQ6LFEG1YzTB6wQ0OhB6QFse3ZI9YW0a+NsRfrNsv
         t2Dx6BIQqO6vJr/sMO1gzYDbbR7mp25zKX/BXu21XVpnzk3JES/IGMBKaCC0mpsh9Ee/
         SoN+DJOwDXIpWz1lQY22kfWSvHRWY1V0Byc959A2qQbANjmosLgq2nfvgTmpq3vRr2k3
         loS2V1bGQmpfX1SjD0aK4VZQuuEp2pBMkx4CmloRlcloc7x/XUYIVKYW1r58eoBTll2a
         mPmg==
X-Gm-Message-State: AOAM533s2MQnTfPadyTd9wZeFh/oLCt1ogwVq0XCISKxK6FC00hdAwkY
        QLLIbJ4zAHNA+I5WFJGaKbD2/81EdAWV3EU=
X-Google-Smtp-Source: ABdhPJyakDkqGvLIh+tdPGMZ1JrSamWDar9qMU1B4qiTmPWOBDxyLEdM7ux0cpDZXMRzWb92SLidW5+XN5u+0vQ=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:ad4:58c2:: with SMTP id
 dh2mr8314576qvb.4.1611129929818; Wed, 20 Jan 2021 00:05:29 -0800 (PST)
Date:   Wed, 20 Jan 2021 00:05:21 -0800
In-Reply-To: <20210120080522.471120-1-saravanak@google.com>
Message-Id: <20210120080522.471120-3-saravanak@google.com>
Mime-Version: 1.0
References: <20210120080522.471120-1-saravanak@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v1 2/2] of: property: Add fw_devlink support for interrupts
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows fw_devlink to create device links between consumers of an
interrupt and the supplier of the interrupt.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 0b256ce9d7d5..9dd9cc50e65a 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
+#include <linux/of_irq.h>
 #include <linux/string.h>
 #include <linux/moduleparam.h>
 
@@ -1289,6 +1290,15 @@ static struct device_node *parse_gpio_compat(struct device_node *np,
 	return sup_args.np;
 }
 
+static struct device_node *parse_interrupts(struct device_node *np,
+					    const char *prop_name, int index)
+{
+	if (strcmp(prop_name, "interrupts") || index)
+		return NULL;
+
+	return of_irq_find_parent(np);
+}
+
 static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_clocks, },
 	{ .parse_prop = parse_interconnects, },
@@ -1315,6 +1325,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_pinctrl7, },
 	{ .parse_prop = parse_pinctrl8, },
 	{ .parse_prop = parse_gpio_compat, },
+	{ .parse_prop = parse_interrupts, },
 	{ .parse_prop = parse_regulators, },
 	{ .parse_prop = parse_gpio, },
 	{ .parse_prop = parse_gpios, },
-- 
2.30.0.284.gd98b1dd5eaa7-goog

