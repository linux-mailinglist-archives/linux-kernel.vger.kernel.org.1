Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F882B822D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgKRQrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgKRQrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:47:32 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1F3C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 08:47:32 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id l1so2832179wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 08:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=phf9ZvV52GFNEN8L5WYYymlvtatVhIvHxiEncnCKw4U=;
        b=bI3Q4EQzpl1ufcqzxhgyl7gcVL2PdJ3i+Rws83IlrDaUsYtMEaHheACm1U5p6a+uEr
         piqDs63Y8CGMufi7pZftctFslNOMk57QcWlJ/7hgL5zotds6kqt02PtexXpPPizccZlv
         s5Cm8LZXaRTh1J73k06MWF/RVhVlQDazaVTFRnGnmsRp9s9zsVPggHdoFuvm6cDkIH0u
         3O8WCIn2KB0a9ARiUwQMUPx/OYXR7jUKiJUwKpzdSyX/0VhGrhJD6KyInqHH4mX1lIcB
         E/2Ol3YujRlmlSPWpwiHe1FI1CiQd7wUxI+apXC+AG4xr1vdBVSnkkVqw5u/ap2Jivu0
         0DAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=phf9ZvV52GFNEN8L5WYYymlvtatVhIvHxiEncnCKw4U=;
        b=NJye5moO8xXr3In+v93ZIzGqCvZY25JJ3BIZf2KtLHrkebk9Vd34SP4axbn8Uuxwum
         VY/gy/3tO32WaG4jSH6S1jyRx/RQkX1q/qtpy+GG8GA0njAePCMS+XUW0u0s4f6I6y8S
         W6X/B6SQcP46Hl4KECvfC0GkiEW9WjLnXRIUB8xYTax42ZCG4XiA3NxGm1MaLcVqrp1K
         4N04lD7OkD0nZbqASW6ybKT2O4e1XPNP0/5BavhHZB+ttFrir0lHjJiXc9TMP80oeto8
         UHJrtyzysM+K1yB+QA2+TTgjviLZGzY/OJIknqprsTbtDQsTHGUZyqP5sS3r2guFkSZa
         w/wQ==
X-Gm-Message-State: AOAM530mXlQSzxiQ7rPBR+kyQTRlmAhq5WqLyKeJ6D1Drt1TDD38cvLF
        2r+DKzWqxUja4COWvtHrW2pY7KfeULo8HpkZ
X-Google-Smtp-Source: ABdhPJw3syt+wbzS5f/vqYR73zRrEgo/Xk/5QAeQAdM9S1iuVAd952AhN0GB3g+FGGN3rgGkWfJhLw==
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr6090100wrn.124.1605718051193;
        Wed, 18 Nov 2020 08:47:31 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id 17sm11414941wma.3.2020.11.18.08.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 08:47:30 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] mfd: core: update mfd_of_node_list list on mfd_remove_devices
Date:   Wed, 18 Nov 2020 16:47:26 +0000
Message-Id: <20201118164726.8034-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call to mfd_add_devices() after mfd_remove_devices() will always
fail in device tree use-case, because new device will find a matching node
in the global mfd_of_node_list resulting in mfd_match_of_node_to_dev()
to return -EAGAIN.

This is one of the use-case with WCD934x where mfd devices can disappear and
reappear when ADSP either restarts or its services restarts.

Fix this issue by removing the state entry in global mfd_of_node_list
during mfd_remove_devices.

Fixes: 466a62d7642f ("mfd: core: Make a best effort attempt to match devices with the correct of_nodes")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mfd/mfd-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index fc00aaccb5f7..3e845be895ac 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -359,6 +359,7 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 	struct platform_device *pdev;
 	const struct mfd_cell *cell;
 	int *level = data;
+	struct mfd_of_node_entry *of_entry, *tmp;
 
 	if (dev->type != &mfd_dev_type)
 		return 0;
@@ -372,6 +373,12 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 	regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
 					       cell->num_parent_supplies);
 
+	list_for_each_entry_safe(of_entry, tmp, &mfd_of_node_list, list)
+		if (of_entry->dev == &pdev->dev) {
+			list_del(&of_entry->list);
+			kfree(of_entry);
+		}
+
 	platform_device_unregister(pdev);
 	return 0;
 }
-- 
2.21.0

