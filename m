Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528D426B4C4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 01:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbgIOXbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 19:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbgIOXbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 19:31:15 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A716C06174A;
        Tue, 15 Sep 2020 16:31:15 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k13so2158812plk.3;
        Tue, 15 Sep 2020 16:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7Z09eYaCc/CIae1Sq3zxvtZJUX+ossSY9hwOHisjfq0=;
        b=Ho4tJJkk1ZBSfesk8sKYG7kdl5fqQN0s5A4sA17HhEa4zl2s75EImMpbu/8CqHA9N5
         omJ/GKrzdKezLV+kW1/tD0k3kG/vYA4OE5pIpjd3m4nGhxRJfkIPY1JiwNBNhL/8455W
         g2lKMcKVRlV2dDq7R8Ui5q5Fge1D3xZxv26/nPgbWb36284ji9tEs/x+7FCynADn9kDU
         zz1a7NpgsbbnH7jTjVX4bnJYeVjjnMvqHr7c8JrlPWUkEQG41Karwh0lSKTHdL1wSc4q
         48kzZu4E5lF/A+gIWBbclUMlVvaKBIPJ9l8KSk4GVHc7JdrOK+yKyFS4MPaMo5iCTALy
         MyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7Z09eYaCc/CIae1Sq3zxvtZJUX+ossSY9hwOHisjfq0=;
        b=tiLWmOs7dFBIrefNrinjM58LnOgfE8ZIzL07qMAls9aKmDazOGuoXuQf8i6AC6VKhq
         qdamBnhauhUWg8Gv6IRBEXVWgwLxmeusMoWZ1KNMMWuJFdShjZEl6jXVtdC71FzH6Eue
         SgSftUqemK8okcveHC1Yr6/x02NEmKTPQxre71lafKzKTgMks2lzEKHBtT+xDHO/+D3E
         d+PF/1IMbjS0tT6UrXAxw8DaKEw/+hRR4JKNBXaZavDTPNqOMLEa4miZsMjgQ5pnT1DF
         5UAPItDUEjABfU/khkV1MTQJC8tBH/W4Xu8cUXj579AzzZbRMaJWyX/sWHDb0gNvGJSP
         S61Q==
X-Gm-Message-State: AOAM533WV/Bz3WrYaL7s5MjV6jVXwLFh4R8w60+NnnaRj+SZedBM+bn7
        rP0S166/2mg7wxXet3mSUkFKtc6YmY0=
X-Google-Smtp-Source: ABdhPJy5kLuSYa3gGuc4HA+hssYOfBHuBtsj+etWZNl/2+BfPEs1LsU5pvdz3mKM9/GoybtUoR307g==
X-Received: by 2002:a17:90a:f010:: with SMTP id bt16mr1421238pjb.143.1600212674400;
        Tue, 15 Sep 2020 16:31:14 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id gq14sm501795pjb.44.2020.09.15.16.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 16:31:14 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     thierry.reding@gmail.com, krzk@kernel.org
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com
Subject: [PATCH] memory: tegra: Correct num_tlb_lines for tegra210
Date:   Tue, 15 Sep 2020 16:28:03 -0700
Message-Id: <20200915232803.26163-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Tegra210 TRM, the default value of TLB_ACTIVE_LINES
field of register MC_SMMU_TLB_CONFIG_0 is 0x30. So num_tlb_lines
should be 48 (0x30) rather than 32 (0x20).

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/memory/tegra/tegra210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra210.c b/drivers/memory/tegra/tegra210.c
index 51b537cfa5a7..4fbf8cbc6666 100644
--- a/drivers/memory/tegra/tegra210.c
+++ b/drivers/memory/tegra/tegra210.c
@@ -1074,7 +1074,7 @@ static const struct tegra_smmu_soc tegra210_smmu_soc = {
 	.num_groups = ARRAY_SIZE(tegra210_groups),
 	.supports_round_robin_arbitration = true,
 	.supports_request_limit = true,
-	.num_tlb_lines = 32,
+	.num_tlb_lines = 48,
 	.num_asids = 128,
 };
 
-- 
2.17.1

