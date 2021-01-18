Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC7E2FA7A1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 18:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436560AbhARRew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 12:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393038AbhARR04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:26:56 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11014C061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 09:26:15 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id h17so14100690wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 09:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yhk/oISJ+nYku/7IYAoUh1vkRwRoCLFL91AqrKzzDys=;
        b=SSB2dTcPHh87ewV/4f8tJVLeZ9h86IB/CeTreE2CiKHIMQ9KuYOaSNlditt5y34sVi
         KpyE+2ULO0qH4k/+Ptrckwn7pw+kMFgATAE/eJpcr0YsdYsi8HRFJTfiYs4FrkbMRdK7
         ksJIV+BqR9KUGctQdYbXk1YBRfvpuR7EQRoZFXiBAFFW7oIkJTrW3HZhcse9XEk3fJmg
         A0JSpcVdpZ6La9OhvXf7JWQ02UFFb0snjumBQCnUicPdhtjpkatZ7BZ3dgfMAHNkuz40
         NnVUPMBtkWOe2RwTEagGPpxV7wpS5LpRhpV1HwqvZNjqBbYFp9jkQlEO3VBVjEejOkqj
         yZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yhk/oISJ+nYku/7IYAoUh1vkRwRoCLFL91AqrKzzDys=;
        b=epxqByjwlwNTChcgtkCr7+NHhviXbrfpOvsOTRvpOWl4nGt1O6hsm8R+1vVy2EaOEZ
         LMvNSV7u/FiKrv3Q6pjqDUXtFoKNUUQ2JSVfecFh15MMwnhpOoxbQXqGGSU+RPhtOoXa
         rTRrHWAK/QLm5Nq3kCO4cKItNtyFO5Z7uKg1MsZx6EdzDojIrNnqleO6Evct+oCaehnO
         qNSXv/1LA21RKEGhXfcz3dX0YRoOFg2xKZ16oBsEHCNDkIpulKUWFcmecYPHwGIypIFG
         ZQjor/8L+rcIjocvrVih9Z9xxzFoqKP0VgTN6eFmBEH1mimkacuEN4g/3orXr8MtNkvY
         z2tw==
X-Gm-Message-State: AOAM5319sVwwIIFPyvhJEU1g+/zp+P3RodSyCB6lj3LyaPmJ2oqI9rxZ
        3/LGCu6CXGQ9iJJ6pu7ATqnQHKr3bhBMR24pm4s=
X-Google-Smtp-Source: ABdhPJxIl3PJ6SBycyJbk8Ms0zaRl5EPmrmaN8NWOyCXq3AT6Ou8nRT+AF5qzoNRW3PrsQiBUy/bng==
X-Received: by 2002:a05:600c:2219:: with SMTP id z25mr396938wml.27.1610990773859;
        Mon, 18 Jan 2021 09:26:13 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:222:220b::2])
        by smtp.gmail.com with ESMTPSA id c16sm30710766wrx.51.2021.01.18.09.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 09:26:13 -0800 (PST)
From:   Isaac Chen <tingyi364@gmail.com>
To:     TonyWWang-oc@zhaoxin.com
Cc:     linux-kernel@vger.kernel.org, Isaac Chen <tingyi364@gmail.com>
Subject: [PATCH] x86/cpu/zhaoxin: Fix wrong lowercase naming and indent
Date:   Tue, 19 Jan 2021 01:25:58 +0800
Message-Id: <20210118172558.19426-1-tingyi364@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is printed during kernel boot, match it with other supported x86 cpus.
    [    0.000000] KERNEL supported cpus:
    [    0.000000]   Intel GenuineIntel
    [    0.000000]   AMD AuthenticAMD
    [    0.000000]   Hygon HygonGenuine
    [    0.000000]   Centaur CentaurHauls
    [    0.000000]   zhaoxin   Shanghai

Signed-off-by: Isaac Chen <tingyi364@gmail.com>
---
 arch/x86/kernel/cpu/zhaoxin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
index 05fa4ef63490..f155bbd2aa97 100644
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -120,8 +120,8 @@ zhaoxin_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 #endif
 
 static const struct cpu_dev zhaoxin_cpu_dev = {
-	.c_vendor	= "zhaoxin",
-	.c_ident	= { "  Shanghai  " },
+	.c_vendor	= "Zhaoxin",
+	.c_ident	= { "Shanghai" },
 	.c_early_init	= early_init_zhaoxin,
 	.c_init		= init_zhaoxin,
 #ifdef CONFIG_X86_32
-- 
2.27.0

