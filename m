Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A982A7193
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732921AbgKDXYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733070AbgKDXYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:24:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11375C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:24:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b7so417132ybn.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mfTizMojGYH7zl382AyPjxc3gkf67U5yOXYFJdS6QqY=;
        b=pq0CYm11Fj0UKb8qVcwbyM408+QTjFYePmO6qnWllEDVb7byscMhcaEBTLYr9cSO8O
         mqa/kKlaUfbuFzUtMT9gV+lTSCuT2f7Uok6H4EQL0PN7VzmynUXN1k7YZANVJ0i2HyF9
         kYb5OL8sAtwfjE3IwxMutSrdZm8oBQTbvTNqJEGGfkxVSd3X7N2aZkPJtOt/RQ+O+fOo
         kTrJO3BCz7HUEVuG2X1hBn5tBY7YgQhjaNjMLH0mi0NkpVP8e9ympyUxrlulBDvWBhCK
         A4ylXxsx55OxKuPmRNc5sNvMqvU9SEeum7GLWTGEosf/oHKCRtHs5RN5+Oe81WXPBjut
         3P/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mfTizMojGYH7zl382AyPjxc3gkf67U5yOXYFJdS6QqY=;
        b=dh8ZEhdHM2v+ED0IhijrMUeHlo7scS6JrZlq7kBibQzguhACi4824QnMsJ4thxe6uc
         ld37cMdIX0Xd945mb+hK+AwF3a+e8noE7b2XbKZHV+iuEYY3qC4A472PATMf4R54yiAL
         JrfRSckai9g9P9codB2cLeL0ZwFiHt5CaWZQ7JcdPhxpQVgxTpPT9kGAAT/ie7mvncm0
         Dmq5QoR/HkXnaE+pc7Z4pLrKzdg+GPheSghSvhCQfl5cmpXR0slgYURAXcS33cTsHedY
         XKlGdJElWFoy1/tZexecZXokI3nClrILa6blHRQrQKW2SyMWBmUqAtbRHrarvpHR+wvz
         Xmhg==
X-Gm-Message-State: AOAM530yCxQcln8PExNQCF2ch9ybdJA9oNEyMFVflzd2G9AAk/4q5i/t
        0jUc2kmtO0AecewcuW35W6puBkR6W6FQPvQ=
X-Google-Smtp-Source: ABdhPJwq/qmSBxreZznPwQ4n1DX1j6V4IaawuEratYZ+IGRe9YPcCLZHStla7kz1d1qZxC97x/xP/SkdJi0ocCw=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a5b:888:: with SMTP id
 e8mr284703ybq.436.1604532272321; Wed, 04 Nov 2020 15:24:32 -0800 (PST)
Date:   Wed,  4 Nov 2020 15:23:50 -0800
In-Reply-To: <20201104232356.4038506-1-saravanak@google.com>
Message-Id: <20201104232356.4038506-14-saravanak@google.com>
Mime-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v1 13/18] driver core: Add fwnode_get_next_parent_dev() helper function
From:   Saravana Kannan <saravanak@google.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        kernel-team@android.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given a fwnode, this function finds the closest ancestor fwnode that has
a corresponding struct device. The function returns this struct device.
This function will be used in a subsequent patch in this series.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index ee28d8c7ee85..4ae5f2885ac5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1562,6 +1562,31 @@ static void fw_devlink_parse_fwtree(struct fwnode_handle *fwnode)
 		fw_devlink_parse_fwtree(child);
 }
 
+/**
+ * fwnode_get_next_parent_dev - Find device of closest ancestor fwnode
+ * @fwnode: firmware node
+ *
+ * Given a firmware node (@fwnode), this function finds its closest ancestor
+ * firmware node that has a corresponding struct device and returns that struct
+ * device.
+ *
+ * The caller of this function is expected to call put_device() on the returned
+ * device when they are done.
+ */
+static struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
+{
+	struct device *dev = NULL;
+
+	fwnode_handle_get(fwnode);
+	do {
+		fwnode = fwnode_get_next_parent(fwnode);
+		if (fwnode)
+			dev = get_dev_from_fwnode(fwnode);
+	} while (fwnode && !dev);
+	fwnode_handle_put(fwnode);
+	return dev;
+}
+
 static void fw_devlink_link_device(struct device *dev)
 {
 	int fw_ret;
-- 
2.29.1.341.ge80a0c044ae-goog

