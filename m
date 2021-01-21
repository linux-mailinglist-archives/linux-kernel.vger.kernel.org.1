Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AE22FF439
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 20:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbhAUTUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 14:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbhAUTR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:17:58 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959A5C06178C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 11:16:46 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b62so3152640ybg.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 11:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=uK0Guj4THP5+g44Z1zImR7+l85HfUzHMOtHW5TTbFrQ=;
        b=HiztyWdLbkgYcFv6WI3Unq6vudbgU7me8+Ss2Aq2NQk62DprdNSfE9jEagIGbk+/bJ
         ka1KO+MylJ8+SdgkyrGAzeBuM17C5SsklQIEpG55Ug9tC7yB4KwxLS7xZLTS9zd5a6Q0
         Uc21zxpAMbaghDXNpV2uekJqo+jLkXLJV/px6yZN0P+OZJV0VSisgwKdlt+KXJaSFOM3
         7SdGFO0AN+bjsBu7Ou2hwquGxDunHFUVccgYhTaFI3g2oat/hu4lZl3Ce3fEwu3g9BJX
         lq0yjYbQFwGfmRUgtfdGbW31NhfkmnGz4UDWmqueQsO4nAHCyVebnbEVP5TxM9MKczTW
         Iweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uK0Guj4THP5+g44Z1zImR7+l85HfUzHMOtHW5TTbFrQ=;
        b=N5G/qvFpOt7VnrXU7hwLWQvQNA6fos6ocDvGsyqaZDeeKPEWdKFVs/d8tZjAHSfEsp
         A9s6pn6dCZuXY2aWIx7RjTz3pYy7qqKmFiypTgJdtUNzR0u9yZaT3G0pL37/7fowiDZe
         lOqTl8rNrplIdsVHuV5rMR7E67MFT/d7zZV1gmnOefRgxkY9sXvNcHvkLgLZsHyQK/tt
         wunAUo8G9BoQsk62/X5Va3wAfk7acxblZg0xm5t+oePaBxJWyqrt2YfPGk/CJGmRgrxb
         EeZH2fVorSgYi/7UWCP7Wl3Hka2ZjhcCYHikmEXe3zjX76utpwnPYdgtl/lg7tb/4WH5
         /yhg==
X-Gm-Message-State: AOAM530qaJ6p9yfkP159RoycfI1QecSAqZpPwJyT9vcmEQNB7vpwpp1Y
        aR6a4/rUfdoRUtSeqIucMR3JC3SGeFV+5zQ=
X-Google-Smtp-Source: ABdhPJyUemQAJXY8nzryZtCsB60uZjupNAv4YI4PC+RzIjWIRcVQ+2QjLagtA781ikmAiOLDKPS8WXMh9mLTtbo=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:6ed7:: with SMTP id
 j206mr1185941ybc.312.1611256605841; Thu, 21 Jan 2021 11:16:45 -0800 (PST)
Date:   Thu, 21 Jan 2021 11:16:37 -0800
In-Reply-To: <20210121191637.1067630-1-saravanak@google.com>
Message-Id: <20210121191637.1067630-3-saravanak@google.com>
Mime-Version: 1.0
References: <20210121191637.1067630-1-saravanak@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH v2 2/2] of: property: Add fw_devlink support for interrupts
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows fw_devlink to create device links between consumers of an
interrupt and the supplier of the interrupt.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index b2ea1951d937..6287c6d60bb7 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
+#include <linux/of_irq.h>
 #include <linux/string.h>
 #include <linux/moduleparam.h>
 
@@ -1293,6 +1294,15 @@ static struct device_node *parse_gpio_compat(struct device_node *np,
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
@@ -1319,6 +1329,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_pinctrl7, },
 	{ .parse_prop = parse_pinctrl8, },
 	{ .parse_prop = parse_gpio_compat, },
+	{ .parse_prop = parse_interrupts, },
 	{ .parse_prop = parse_regulators, },
 	{ .parse_prop = parse_gpio, },
 	{ .parse_prop = parse_gpios, },
-- 
2.30.0.296.g2bfb1c46d8-goog

