Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F16286C23
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 02:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgJHAot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 20:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbgJHAos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 20:44:48 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9686C0613D2;
        Wed,  7 Oct 2020 17:44:48 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k8so2563297pfk.2;
        Wed, 07 Oct 2020 17:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qfKA4EJJo7B3Dm/1fAP7OUSXsmvWBfkP6J/AdjdPFfU=;
        b=jlkBkeac72U9MsMp0yz8TbFwNpRywsBLVpbJni3On3zToCvVYK9x19wqvfc0y7VQD4
         pygxgjJZ3XqYf/iXJaSNei5urMvNcjRvQuyn6QCt6zP2UPFjNUGHRbPTXA9+hARiZnkD
         Gz5TLvU1h1NcZnqsLSwGfKEGXZXYLxesp3e54sb4WhdpSx80ONNuP+z2H1U5wYnZqjV9
         91SwmSphGUJGI9oXSwuaRCuUhuZUWKU5YSOLL97FGmTHMdMGsf2r3xlx9cfOVHFlwAyI
         Bvg8S6BY3DYeJzqS7kyBYvVyIOAcTBQgb1NesM+2aCwavxsl9USQk5kN88/wHzfdCWiM
         HNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qfKA4EJJo7B3Dm/1fAP7OUSXsmvWBfkP6J/AdjdPFfU=;
        b=EBe4Top5MSRezF/3ogH1ZiT4pGkfpw5nohbSYZhqTI1mbi5+E/YZamIXjMm3hs7Aqz
         4J1HIUMRy4PVJUHMdh7szNds6sge4lv0rh80grB2lB6dap12jyCuZ9yWgKHqySy0m5gM
         f7rOCY91tbe9uysFLxrXeFKWZYYkPtFSuJvQMIK01FkRfVsBLw6A3H/oC1DVnKItWz3R
         4TI8CreQ1O5xhgqOyF7OPzC2bjWtKnBIcgMxgeiMHHCKZD1gWalTfnITefU2kDM9f7FQ
         KRyH1MniqxfjZxOg6O5d4SBjmNICEshd5nP1F6YQvrLIEePyXMhvejf8eeopIfERFXkZ
         fygA==
X-Gm-Message-State: AOAM530xJV1Xoa56r0YJDpRlxBtlsaJ+eH9AJxCFSdiTwNSSN+6LY2CF
        U6jEg9yqNTBc1WlcZCKH9zg=
X-Google-Smtp-Source: ABdhPJwQ+625GU6hbpaB+2QrxV32N0msoHjUuRV4lCWKJsh3TvLclT204F3T0VjnhwMtrkbwQTvN/g==
X-Received: by 2002:a17:90a:7c44:: with SMTP id e4mr4867068pjl.167.1602117888315;
        Wed, 07 Oct 2020 17:44:48 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id z6sm4939922pfg.12.2020.10.07.17.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 17:44:47 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     krzk@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] memory: tegra: Correct la.reg address of seswr
Date:   Wed,  7 Oct 2020 17:37:42 -0700
Message-Id: <20201008003746.25659-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008003746.25659-1-nicoleotsuka@gmail.com>
References: <20201008003746.25659-1-nicoleotsuka@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Tegra X1 TRM, ALLOWANCE_SESWR is located in field
[23:16] of register at address 0x3e0 with a reset value of 0x80
at register 0x3e0, while bit-1 of register 0xb98 is for enable
bit of seswr. So this patch fixes it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/memory/tegra/tegra210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra210.c b/drivers/memory/tegra/tegra210.c
index 7fb8b5438bf4..088814279616 100644
--- a/drivers/memory/tegra/tegra210.c
+++ b/drivers/memory/tegra/tegra210.c
@@ -897,7 +897,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.bit = 1,
 		},
 		.la = {
-			.reg = 0xb98,
+			.reg = 0x3e0,
 			.shift = 16,
 			.mask = 0xff,
 			.def = 0x80,
-- 
2.17.1

