Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9912BBEDE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 13:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbgKUMR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 07:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbgKUMR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 07:17:27 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A80C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 04:17:27 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id k7so6374418plk.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 04:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CQX3P8QPTE+LUFvbaH/yRk4StUbJcxxzzGf4e6Mvf4c=;
        b=SRnWPHT7opcBzPAAdosp2inhdjaRrfSeBtGO6noqEbEFKSqnAFf23pd1F4QZQWhPZx
         Uz0IZT8Dou66+3Vm00kQQx7CZxYmDIuF5fnly6rtHoRfyGV6XKqOOYM90xcgR9snt9zS
         +wk8lfh/VonWOJCiRkW+nyLxHYSaq1UpvmFPMLXw5zeNDlNDJ6EVRI0x3qdDifxrbhAM
         ugh40kiE7aqlwT2duVZT16Q13hG0EXu4Z+FaGIU5TGO4L3coKOY883Km8CwtoT5nIGtn
         4UEJ065nx+k3Vp0A9gwq8iv91ZMIk4TNZEyJB8Kk+TQN0Mh20JdTEkjP9MPfPTvkM7ul
         csGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CQX3P8QPTE+LUFvbaH/yRk4StUbJcxxzzGf4e6Mvf4c=;
        b=iS5gPVsEVpZjrDV49ltUI/48vf4MltqC5C1ALzcpEuEtoFrftzWzF/tvzqYAjZYFDT
         caQ3ktmInbBg44pYPMxjzuUncyJ5v3owPV+cWmyQmpQDpFJeB/WUSKX4qV7EoiFk6UWD
         XpE5Lt9KscFfFrXyoRN0gDta3qGH480BkqXdguhiwbqIa4gnkhV+4pAsIUMzz+wa48+N
         sqO1IsZtRzDvJK2nbcMxm6aWsx7ztakzo5qHdleMSI9TzkKSEokf/M5hqBLO6xF7fIyO
         Womqw8XMfv9lFjTAHGqjNP//BPSHHt/rKYaLM1YKih8M7yl9u7Jwefj7yakNzCEgPvvG
         6W7g==
X-Gm-Message-State: AOAM531y3uMHJ+cUlH51uhyuib9C/kGHQhgyjxtR4+fTP2tU/oWpPhQL
        +Jz8XmYmOIZDHZZun345nQ==
X-Google-Smtp-Source: ABdhPJyGMIN0vLrgspU86avmKyLpQHq9uhx2r0whSynwNZ1W9LtU08nJc7+moWJe6Ms3rWU64f31gQ==
X-Received: by 2002:a17:902:830a:b029:d9:e16c:663b with SMTP id bd10-20020a170902830ab02900d9e16c663bmr9563499plb.0.1605961047199;
        Sat, 21 Nov 2020 04:17:27 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id l76sm7168780pfd.82.2020.11.21.04.17.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Nov 2020 04:17:26 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] staging: rtl8723bs: remove redundant statements
Date:   Sat, 21 Nov 2020 20:17:21 +0800
Message-Id: <1605961041-12875-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The bool variable is2T is true, so the if statement is redundant.
we can directly set the variable bound to 8 and remove the if
statement.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
index 85ea535dd6e9..645f4f2a835e 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
@@ -1407,14 +1407,9 @@ static bool phy_SimularityCompare_8723B(
 	u32 i, j, diff, SimularityBitMap, bound = 0;
 	u8 final_candidate[2] = {0xFF, 0xFF}; /* for path A and path B */
 	bool bResult = true;
-	bool is2T = true;
 	s32 tmp1 = 0, tmp2 = 0;
 
-	if (is2T)
-		bound = 8;
-	else
-		bound = 4;
-
+	bound = 8;
 	SimularityBitMap = 0;
 
 	for (i = 0; i < bound; i++) {
-- 
2.20.0

