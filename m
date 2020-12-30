Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34282E75AD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 03:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgL3Cbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 21:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgL3Cba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 21:31:30 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB9EC061799
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 18:30:50 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id p18so10533388pgm.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 18:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dg1+8/YFBVrssIqKkO90NVArJGznkH2ISVfNpKVOHe0=;
        b=hgkSFVeFVX/W10bbqCSyfEtryTQ2m08elSy0cSzbKBYiHgTDFNS8nWQQZYKqfPaULR
         ErrmBEikw0RnJd1nVz3vCyiuHVwQXwG4g5C0OSEqDFRm3/5v8PzUAZ2ppDRZM7Hc/w0k
         GtvBdD0rOPfjqBxAFBixHrDQpdGCgXABklOjkyCHNyzXi2afQj1Zhjow+D/LFIfK3epk
         3dxRQgtmo8OXLByzyiCYWAbmQx1r+He3P/BLE9mHMnuQiWcg2ELztk3X+DqSa41zQWOn
         Shsf7wRlblMCIaK+NfFwcXoWafsHF13LHBbbbY3y5i0BZmOZaEC9ydjKdNwuWBEe0WJu
         9mdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dg1+8/YFBVrssIqKkO90NVArJGznkH2ISVfNpKVOHe0=;
        b=Nxo70raMoXek7vSRqVhFYGE8xQ11dglh7xvLr7tmNqr3j8xLun1sbVckQuCsH0U4CY
         uXysrAvR7vBcIVVTECVSvbYCoazUL7s1ClPmXMVPrEuZulV+josyUkF1RqDxzcP46hLg
         /zDYRdRyYO7e1sPtT5iuhpEUQj6yYOFOSd0wrzafv+sDUrPv3EY3dY4cd68txlzZ0Z6f
         VbsGVgU1bjhQJPV4tbQ/HOJookMHPufpsWQujjipcC0pTlMIP2eUfHg0SLFP458St0H8
         CuqMyM/6x/xESF0MoPT8A2LMF+5FyPmVN/icyEkNIUvj1lbhkac0KzTqIsCru/u6xGPN
         uHKg==
X-Gm-Message-State: AOAM531r0cEh3/br6WDQ+7CO77ZsXZn5o+jsYXdGzJT5j92/Bm+UQtfF
        zhEz1O9w8eOmcxph29Sw3mc=
X-Google-Smtp-Source: ABdhPJwAVhmaQX1DJ+sEhw1OX5AW8F2Avnnz6jzIOuihpmtI5SWfL+swqVLLNxK3s9wICDtlm80yyA==
X-Received: by 2002:a65:4347:: with SMTP id k7mr39650205pgq.186.1609295450039;
        Tue, 29 Dec 2020 18:30:50 -0800 (PST)
Received: from localhost.localdomain ([122.10.161.207])
        by smtp.gmail.com with ESMTPSA id a131sm34848687pfd.171.2020.12.29.18.30.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2020 18:30:49 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     tglx@linutronix.de, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org, yejune.deng@gmail.com
Subject: [PATCH] irqchip/gic: remove a if in gic_of_setup()
Date:   Wed, 30 Dec 2020 10:30:41 +0800
Message-Id: <1609295441-36288-1-git-send-email-yejune.deng@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is two function gic_of_init() and gic_of_init_child() called
gic_of_setup(),both gic and node never fail,so remove
if (!gic || !node) is safe.

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 drivers/irqchip/irq-gic.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index b1d9c22..a65678f0 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1380,9 +1380,6 @@ static bool gic_check_eoimode(struct device_node *node, void __iomem **base)
 
 static int gic_of_setup(struct gic_chip_data *gic, struct device_node *node)
 {
-	if (!gic || !node)
-		return -EINVAL;
-
 	gic->raw_dist_base = of_iomap(node, 0);
 	if (WARN(!gic->raw_dist_base, "unable to map gic dist registers\n"))
 		goto error;
-- 
1.9.1

