Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E038301418
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 10:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbhAWJN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 04:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbhAWJML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 04:12:11 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBB1C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 01:11:31 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 11so5411037pfu.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 01:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xz2PbVIxBwK7kshC7Ju1wrOt7DLM4YPE97Z1qOQFS+Y=;
        b=gZcAjMwnk8BHCdasr7Y53F2ocrJaro8jHE38e9q4Uw4iqf7SwttCYAHj9wOsdOW0Yc
         NyViWFX/gEDgTeOQNn/7dsopiZs30/ULyyb/KLL9UMXiEFIaumD/eVkqpGo9amHqo1ez
         fjQ+tEcodOVJAP2+Hu1UuZnNT5mU+bPtpjNex1LwZJN/LUhheGXfKhP0KeTfwZj7+GfG
         cpfcu5q3/mf8G+hB7Q7eoYFSvmPaI3NNMPkjb3BevOl3losRTXY8dkvoSH81g3dkgxVC
         /mRe2VUHOi4yuBvLrL2smMgzqdjSVeLWOmq19GwsKmOH+Ya07tkUvO38BW181gmILqUR
         yA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xz2PbVIxBwK7kshC7Ju1wrOt7DLM4YPE97Z1qOQFS+Y=;
        b=quxk9y7Vrp3JcaI/UwwRgSHaKlfelJNKowhWxujeP5MahTDYLbnjmORcjVpPnaJqx2
         kBtF/3zUbyahgPWgayP7OotrJwsoSNrjEJDBvoZAMQtJV6XcwMbAVpIV/OLXEHacQvCJ
         JBh8DQiVtGQLNEpyhWJbQiFl5dVeVxJPhV3w+DzbTCfkY6Y85XgJ7eYHC8d3ItZTIg9I
         uv4pGzhloc+LpJ0vL399sFNPEKrpWAJuYp7Pixf+Dcjpuw6vWdI10eqqFZtPEQFkTkGd
         2nEzV7M7qYAs/Ev0ua83gb67Ks6wtZDduwzxALQVu6VVgn25P9hubSX6QUSTllLkNIkb
         2R5A==
X-Gm-Message-State: AOAM530k51f4/TvKxrUDWXvWWgBHtfnBAMUdbbXVNMnqiCkmtcUZKzQX
        wrXuhgCG1oUdeoD5myjQGA0=
X-Google-Smtp-Source: ABdhPJyMMN+16Up9em57LDl+ZEK1K0ZEn+r4ZB48NPvIsfqP5bfe1icjciG0lm/tyQW9Pkj20WrEXg==
X-Received: by 2002:a63:dc06:: with SMTP id s6mr8841146pgg.358.1611393090746;
        Sat, 23 Jan 2021 01:11:30 -0800 (PST)
Received: from localhost.localdomain ([125.227.22.95])
        by smtp.gmail.com with ESMTPSA id l13sm11864506pjh.2.2021.01.23.01.11.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jan 2021 01:11:30 -0800 (PST)
From:   Stephen Zhang <stephenzhangzsd@gmail.com>
To:     maz@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Stephen Zhang <stephenzhangzsd@gmail.com>
Subject: [PATCH] genirq/irqdomain: Fix debugging information in irq_create_mapping_affinity()
Date:   Sat, 23 Jan 2021 17:11:23 +0800
Message-Id: <1611393083-6037-1-git-send-email-stephenzhangzsd@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the function name with __func__ in case of changes.

Signed-off-by: Stephen Zhang <stephenzhangzsd@gmail.com>
---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 6aacd34..2cad63e 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -661,7 +661,7 @@ unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
 	struct device_node *of_node;
 	int virq;
 
-	pr_debug("irq_create_mapping(0x%p, 0x%lx)\n", domain, hwirq);
+	pr_debug("%s(0x%p, 0x%lx)\n",  __func__, domain, hwirq);
 
 	/* Look for default domain if nececssary */
 	if (domain == NULL)
-- 
1.8.3.1

