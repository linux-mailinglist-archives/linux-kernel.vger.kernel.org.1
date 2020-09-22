Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C02273F79
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgIVKUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgIVKUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:20:42 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357FBC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:20:42 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k13so11493683pfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dBXfFm02ABja54Il3Ns8zFaadLu9ijtBeVpM6C5JJKM=;
        b=d2xJ/AS0OXnGh0GB5/37HpA/0bJdQ+zvN17J5kMYdFyOBp+Y3cSce21/YWN6gqowRS
         vzK3SCVQC5FU7KZX6/0Jb89YbaD+CEELfsso8VbeFiyUfz0aKtuCzIA5upTLBi6OHYRE
         PXC5GbA8XyNbfqDVbC58LghYM7EWPh85bDmPemUdvKb3L+EbieN3Q0lCM/oxCgA9BmRB
         +1oqJuraJ8DyZV30vfBGDaPaqrvqNetcp/IH88vuTsPdngA1nCxDU8MTcZlV3PxVd09y
         sMVV1bETd5/HkDmPTOY++vxzOvZptq8Ho6YunDumsiKQiLcpeNmqwB2NwD9GtTs28M/K
         2SgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dBXfFm02ABja54Il3Ns8zFaadLu9ijtBeVpM6C5JJKM=;
        b=OsS5YKIJdgJ61cy6/7nlgbuEHKJA7HCnX//Ub/iWsn52eVJWm/NLPdlOkH50WF8L2E
         2lF4VTwrYpRhFktrI7cYbE05LelJFr8hE1MfWB3BIg3gYQjZN9yiCrLvtVJrynRSv2kv
         WC/GHYT9zoVl64WJGenz+DfvqeQq4sLjfqWoLWuaPRQYV5n5vG4pKk+ENIvVpLZ9tlFr
         WkV4+CwFU2+W+C+zPskMOMvpAZucCVuP8SyYiJKBN4kr5W7vJVWYbCbcV9Nh3kpFTGHb
         u+6bKsaRhHUHac4mfid2tetr4Mz0EF7NN1rvpyRkb2yHeGJwCJRLBCWvEO29K41bU0ER
         n+SA==
X-Gm-Message-State: AOAM5327meWABuW/kT9bd9fhqhJXSFYs7ixQ1GlX1bSfV82Ea+kouJnW
        KGgr2wEXqGJ8mySHruM1zZ5Hiimyubg=
X-Google-Smtp-Source: ABdhPJx+dbzaWf232yxuvjzFKMUa5e9oNikBx07/hKGXRREufBPy4+N/4bRtLIQ5AUPqSiOXGfeXSw==
X-Received: by 2002:aa7:8dc9:0:b029:150:e9ad:952 with SMTP id j9-20020aa78dc90000b0290150e9ad0952mr2056365pfr.61.1600770041749;
        Tue, 22 Sep 2020 03:20:41 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:489:56d9:501b:f524:c013:2733])
        by smtp.gmail.com with ESMTPSA id a15sm14859037pfi.119.2020.09.22.03.20.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2020 03:20:41 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v5 01/10] mfd: mt6360: Rearrange include file
Date:   Tue, 22 Sep 2020 18:20:09 +0800
Message-Id: <1600770019-11585-2-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Rearrange include file without sorting by alphabet.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index e9cacc2..c7a955f 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -5,15 +5,14 @@
  * Author: Gene Chen <gene_chen@richtek.com>
  */
 
+#include <linux/crc8.h>
 #include <linux/i2c.h>
-#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
-#include <linux/version.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
 
 #include <linux/mfd/mt6360.h>
 
-- 
2.7.4

