Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FB82DEAD0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 22:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgLRVIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 16:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgLRVIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 16:08:37 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC38C0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 13:07:56 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z1so4778028ybg.22
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 13:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=t638+7+HwCPMmPZN8BttAu4YYFBZRz0rNr0gnq7g6kQ=;
        b=X3K1oA1NNGSEagu1/19qhOlEw2wzeX+pTdeitiFiKfBl/0vRXoXSli4nPvDlj86s+X
         s4V1X30EZgeNlYMAsIRUs4Lk+EBU6wBbW8a0+/E8cxTyO5TXKd+Qq/cbbl3KGC3dp1Jw
         zHjxfG2DHtUMZgDGW19yVH5m/r9XBeHzbZy8s9c0MeAYYwvCnL2diQwyZ/5JTP9naB21
         7XWrwAUWXez3hSRRpJaY9U+B4WihIa+sCk/DuVPHuCreri5qKPw3Agb791Xkazj7LHqa
         Ol++VY12w1aNwvbEHmECXlPSaCC4tHzmXQgZv8MR6jA5SZwGtQLJcIhHIcQVDfmFpBYY
         QiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=t638+7+HwCPMmPZN8BttAu4YYFBZRz0rNr0gnq7g6kQ=;
        b=TXSCI0BcHGkt8vtBPYqwuotYD5towiTQWZYwdn9PfF6mX11SFDqYNcnnKxiO74EKqr
         BKAyAU5UjkTntTAKllm3uJSqElezwONsnzsF2ywmryYTnLYeEPBnaXph0yjAudWUsUbM
         MOm2eq+mRmUuKyIAoLta+4Y4qzNq83niQuvOCxA/Hs3NJUzea6SaWUy+lc3HZdPorHeA
         yrFsMeP7eMYaUyKIvpBCXu73DrE0emsqPePeVT6q8LoKbWQSnUsTnWOY/spX6N16VbJ9
         JpN471frud8CixlMvW+wC8Kr7hTWQVwJwzshTw4AXhzZ7UhvSRl1zQcN/FNxte1ww6eM
         dWDg==
X-Gm-Message-State: AOAM532COFi2m5u/UrSXtjGYLQT0ujCIwjrr5RBcf7O2he6jj8h/SUAw
        GPm1FmrPChXQSDA/gkfjkFwvWF4+Mi4kaMU=
X-Google-Smtp-Source: ABdhPJx3FgmJDWeNm5zfdx0Y9sCCHts79Ft0KxctC8O+IgVj9pVl074vaJoAM7DoRFYel11ggk4LZAvZ6IKdvh0=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a05:6902:100f:: with SMTP id
 w15mr8173561ybt.25.1608325675917; Fri, 18 Dec 2020 13:07:55 -0800 (PST)
Date:   Fri, 18 Dec 2020 13:07:50 -0800
Message-Id: <20201218210750.3455872-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH] of: property: Add device link support for interrupts
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for creating device links out of interrupts property.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
Rob/Greg,

This might need to go into driver-core to avoid conflict
due to fw_devlink refactor series that merged there.

Thanks,
Saravana


 drivers/of/property.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 5f9eed79a8aa..e56a5eae0a0b 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1271,6 +1271,22 @@ static struct device_node *parse_iommu_maps(struct device_node *np,
 	return of_parse_phandle(np, prop_name, (index * 4) + 1);
 }
 
+static struct device_node *parse_interrupts(struct device_node *np,
+					    const char *prop_name, int index)
+{
+	struct device_node *sup;
+
+	if (strcmp(prop_name, "interrupts") || index)
+		return NULL;
+
+	of_node_get(np);
+	while (np && !(sup = of_parse_phandle(np, "interrupt-parent", 0)))
+		np = of_get_next_parent(np);
+	of_node_put(np);
+
+	return sup;
+}
+
 static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_clocks, },
 	{ .parse_prop = parse_interconnects, },
@@ -1296,6 +1312,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_pinctrl6, },
 	{ .parse_prop = parse_pinctrl7, },
 	{ .parse_prop = parse_pinctrl8, },
+	{ .parse_prop = parse_interrupts, },
 	{ .parse_prop = parse_regulators, },
 	{ .parse_prop = parse_gpio, },
 	{ .parse_prop = parse_gpios, },
-- 
2.29.2.684.gfbc64c5ab5-goog

