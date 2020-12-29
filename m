Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0DD2E6EB4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 08:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgL2HQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 02:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgL2HQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 02:16:10 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE44FC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 23:15:29 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id r4so6795664pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 23:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qqHVeipAAn5HMfg4BGEG2R4b8Vu+PvqL+WIcqgINTlo=;
        b=fNXxRobba/lDNvHQfOn9zTFnWrjkap5kX646v9VVly9oR+iwfkdTNs9jlWfmp625VD
         Ecs3VY0t2CW1/XIp+y+u9wJrc0ZwLUJz7DBMd+GWXj/6cj3Hs+WSDaLjJ40TKZINyXKj
         mqWQPjWNuXK7lI0A2qtJuApAP3REoqdWWeZ/f2SVT4PI0hhvx8o5SwZlDMOzPCKJABwb
         yr8lgWJ2+w2piJkmBpEPN6W8DCBz6qGXm6W176wB8Cgo/Zi+jxLVhmUy/lwan05jaJ4W
         UneiJrHiGuhkGenYqQhcOeEZFQPjXWkALqPT3C9Owdmt4oV2lkLEUbE/UpudWPkA/YdK
         RGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qqHVeipAAn5HMfg4BGEG2R4b8Vu+PvqL+WIcqgINTlo=;
        b=MIq778mfrzhTyEvIxh5O2iSe1V4M3SjELbV7G8UHPR5ULpJKajjvddLHQzd2NflYCx
         u2mK0jWraKQ8jxEeqbMzEjPShtcED0g23uEqBKRmgz49o1qzDGI3KVY0FO7Ti7Wi+D8z
         THa5aeZiaZ8GYx67+eVOUJv2uketuQv+WpmSAZ+Can21wNIaC6Szpqo+OelR9Rt56D0D
         PA8MlY9FVckodg/ZCTzUrHUSWObFx9kKCi3YQ8Ixa/EO8L9vw64N7IvGgyg8LUFpn+fX
         9GFGSn2jmD/ROKt2vAUKcBwgEUhjxUZNxkh9oFlaXtVJPXZpfzI4kJU/CyIuc8yO7TxH
         3Gsw==
X-Gm-Message-State: AOAM533kw/WHpMQvSoB5Ezv9k4yNdjKlFLlC0GLVZOkSkOKcTHaX8uuq
        O4vptgfxSbHdXRRt3JjOcHE=
X-Google-Smtp-Source: ABdhPJzqiubZiiuCOfqMNAP3uxVTxacLgFyzmkAxjb8swHRYXexV/o2C3iZL7Z2c77uUQSMQMGqpjQ==
X-Received: by 2002:a17:902:d202:b029:dc:3b92:f4e0 with SMTP id t2-20020a170902d202b02900dc3b92f4e0mr38630967ply.69.1609226129434;
        Mon, 28 Dec 2020 23:15:29 -0800 (PST)
Received: from localhost.localdomain ([122.10.161.207])
        by smtp.gmail.com with ESMTPSA id p9sm1929261pjb.3.2020.12.28.23.15.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Dec 2020 23:15:28 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     tglx@linutronix.de, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org, yejune.deng@gmail.com
Subject: [PATCH] irqchip/gic: add WARN_ON() to facilitate backtracking
Date:   Tue, 29 Dec 2020 15:15:14 +0800
Message-Id: <1609226114-32933-1-git-send-email-yejune.deng@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is two function gic_of_init() and gic_of_init_child() called
gic_of_setup(),so add WARN_ON() to facilitate backtracking.

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 drivers/irqchip/irq-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index b1d9c22..7c11705 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1380,7 +1380,7 @@ static bool gic_check_eoimode(struct device_node *node, void __iomem **base)
 
 static int gic_of_setup(struct gic_chip_data *gic, struct device_node *node)
 {
-	if (!gic || !node)
+	if (WARN_ON(!gic || !node))
 		return -EINVAL;
 
 	gic->raw_dist_base = of_iomap(node, 0);
-- 
1.9.1

