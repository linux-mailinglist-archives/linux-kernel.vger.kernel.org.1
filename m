Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A912FCE0E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbhATKRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbhATJc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:32:27 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF241C0617A0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:30:55 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c127so2168629wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CsKGKKyp6+81exyBoVttQ3TpJ7bs90/HzFEMaKTSJxY=;
        b=TNt0TrZJ3o4yf9t0fkrkMUJRKVjITng81FGmN1l8sq951Jd6wtuISqM6c56ItvCLqj
         nm5arKvXWrfvK6OJ/RQBbFqCPaJ+hXHnaPp9p3iYVOzuxoxLnHAm/ydwQfgDrdqGq0ZO
         h94O+qrzroPzH6h084pZTQv/oFiG6YJEZLcLHJ9D1z3Vdj/Xw0a8YmdNg+M/Dm5QvNZJ
         yNEIK/EcjOQPPhbXI2ZK7EU4lioBvU8QokXSuDVnACQ8fmfzVs+j+R5cXmWU+uoyV5lG
         XiV++42CE73yLZ2umiplORp6GgHdqthbKpUv91szf1Oy4CkPNqQWu/Ff19smErHvkieB
         /Lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CsKGKKyp6+81exyBoVttQ3TpJ7bs90/HzFEMaKTSJxY=;
        b=Vz+acoYfqMlv5HhTSlWG3xkt9HNnZkF1Ixc8tzWLflDKh7zZuDWCLkSqaieAbt7qp2
         0UWabnq1JCdca9BXTh4cJ+udJZQCe/3vclEgGMqgkZ33ih+F9cuR4lpMENxEOVwtUUfP
         /+I6cR08+7neHn/wr/TAjlC1lUtqQupyN8e0teGhTDjUT4UQ3KgGBB6VBbqQ/l1XgeNY
         RyxFAoQS8XvoMoYek0sAaHY89YcA6BNKIWDgYwJzg33O+K93iisGa1+YFU6iRcMSDGgn
         5MtQNuXbMCZxa5tAm4nUyfj3lmKpRH9ZtTLQpl/Idd5+iCJWC8wNew0lnLRZxDvwYPiL
         2VPg==
X-Gm-Message-State: AOAM532rWp4Er2gi1lO8T+0TsCZg6MFCW7/t9uaIgyeTVYfc0UWZeL2o
        bSOsn9pBLAu7/wsnMFHJ6+ZrGw==
X-Google-Smtp-Source: ABdhPJy2o9OPMNkmeQsdP33xCZcrH+7ZyANpQydcxE25NXUfXBuWqms+VN0cn/t+b3khC3qt/qxOrw==
X-Received: by 2002:a7b:c188:: with SMTP id y8mr3246197wmi.173.1611135054541;
        Wed, 20 Jan 2021 01:30:54 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id z130sm2889201wmb.33.2021.01.20.01.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 01:30:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Omri Itach <omrii@marvell.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-clk@vger.kernel.org
Subject: [PATCH 09/20] clk: mvebu: ap-cpu-clk: Demote non-conformant kernel-doc header
Date:   Wed, 20 Jan 2021 09:30:29 +0000
Message-Id: <20210120093040.1719407-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120093040.1719407-1-lee.jones@linaro.org>
References: <20210120093040.1719407-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not much effort has been put into this one.

Demote it for the time being at least.

Fixes the following W=1 kernel build warning(s):

 drivers/clk/mvebu/ap-cpu-clk.c:52: warning: Function parameter or member 'ratio_state_reg' not described in 'cpu_dfs_regs'
 drivers/clk/mvebu/ap-cpu-clk.c:52: warning: Function parameter or member 'divider_mask' not described in 'cpu_dfs_regs'
 drivers/clk/mvebu/ap-cpu-clk.c:52: warning: Function parameter or member 'cluster_offset' not described in 'cpu_dfs_regs'
 drivers/clk/mvebu/ap-cpu-clk.c:52: warning: Function parameter or member 'force_mask' not described in 'cpu_dfs_regs'
 drivers/clk/mvebu/ap-cpu-clk.c:52: warning: Function parameter or member 'divider_offset' not described in 'cpu_dfs_regs'
 drivers/clk/mvebu/ap-cpu-clk.c:52: warning: Function parameter or member 'divider_ratio' not described in 'cpu_dfs_regs'
 drivers/clk/mvebu/ap-cpu-clk.c:52: warning: Function parameter or member 'ratio_offset' not described in 'cpu_dfs_regs'
 drivers/clk/mvebu/ap-cpu-clk.c:52: warning: Function parameter or member 'ratio_state_offset' not described in 'cpu_dfs_regs'
 drivers/clk/mvebu/ap-cpu-clk.c:52: warning: Function parameter or member 'ratio_state_cluster_offset' not described in 'cpu_dfs_regs'

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Omri Itach <omrii@marvell.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/mvebu/ap-cpu-clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/ap-cpu-clk.c b/drivers/clk/mvebu/ap-cpu-clk.c
index b4259b60dcfd6..08ba59ec3fb17 100644
--- a/drivers/clk/mvebu/ap-cpu-clk.c
+++ b/drivers/clk/mvebu/ap-cpu-clk.c
@@ -30,7 +30,7 @@
 
 #define APN806_MAX_DIVIDER		32
 
-/**
+/*
  * struct cpu_dfs_regs: CPU DFS register mapping
  * @divider_reg: full integer ratio from PLL frequency to CPU clock frequency
  * @force_reg: request to force new ratio regardless of relation to other clocks
-- 
2.25.1

