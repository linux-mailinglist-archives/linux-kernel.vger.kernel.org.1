Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A540303E80
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404333AbhAZNPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391856AbhAZMrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:47:22 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB4FC0698C1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:45:47 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c128so2648520wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PGeifpJKwjmOW+Ep9Ua2GRyOjoW8Ji8HLmvStTZxjac=;
        b=v/GZXImGJGb/kVvhK0npWRAIjwWvAMSPszbanie2gyQyaHIgNwv+GU3OY5PEDCFNvb
         Pdc4HM2L/mZ726eJc04eNfiTzO4Z89LCNDfVMeHPSFU3MY1VHTFI6+/myba3re2O/8Zi
         c6h/JKld/C95nLyWd2MAKMotO9aJeyjdcfO5QrDqoAchQcQg5NFB0on4wIzTMMqcT2GU
         CFT5LRCbrpOnA4+gIOhhegepdFDJMwbIYFrbkwXajcdkASOpNhqkyYtwiJ1gM8Zb7ecv
         rBjrxYe5yH1RmYRdRFxfUp/TSCEX4bn8VDsyg4XFIOKnnsI2fQ98NaAipX4yDM/ozDbO
         lpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PGeifpJKwjmOW+Ep9Ua2GRyOjoW8Ji8HLmvStTZxjac=;
        b=d8cOYel3UBCTRcmp1l1qDImQBtzqzCXd5FOkNqB6Lpuv2eDs/ObwClLwhOb5NccNBV
         e5/KchW/pMXrQPNqyvQcKZFyPuuU+W8FdSOoLl79uVTdG/ZFxSdX21zZPbZpF7nj4OYw
         tUqqcB9Hbuzz5dqnqwe/4X/N/9dLtV6h/j+P+MEKtBzN74F6Kz56V9stlME9TUZVl8v+
         3ICjSJ4Gzqp50OLN1zabyaXH3SsENN8ZTXsL89Cf5DXZwgIYrE/SaGHl3vPpAWDJ44ax
         wGNd0i3lDLCsG3+9z1LSSiFmKua0CND+RUKBpR/KS/y12RplOC8KqiU9WYCUzbN7CuP1
         jK7g==
X-Gm-Message-State: AOAM530GzxHLL5njnvTWfHgW8puvQnN5J4beC+oKw15UlhSBupRFbHJa
        7FtbmcZoWbKMdUTkKOXc5SJT/w==
X-Google-Smtp-Source: ABdhPJxXTxLgbK5EkVRfr+MJjeLWFuHWBUr/C2CyGD6BUSoJivoD9uH6eJohEpOALz25PXoDpvXWJw==
X-Received: by 2002:a1c:f706:: with SMTP id v6mr4568060wmh.85.1611665145981;
        Tue, 26 Jan 2021 04:45:45 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id i131sm3263073wmi.25.2021.01.26.04.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:45:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 01/21] clk: zynq: pll: Fix kernel-doc formatting in 'clk_register_zynq_pll's header
Date:   Tue, 26 Jan 2021 12:45:20 +0000
Message-Id: <20210126124540.3320214-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124540.3320214-1-lee.jones@linaro.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/zynq/pll.c:187: warning: Function parameter or member 'name' not described in 'clk_register_zynq_pll'
 drivers/clk/zynq/pll.c:187: warning: Function parameter or member 'parent' not described in 'clk_register_zynq_pll'
 drivers/clk/zynq/pll.c:187: warning: Function parameter or member 'pll_ctrl' not described in 'clk_register_zynq_pll'
 drivers/clk/zynq/pll.c:187: warning: Function parameter or member 'pll_status' not described in 'clk_register_zynq_pll'
 drivers/clk/zynq/pll.c:187: warning: Function parameter or member 'lock_index' not described in 'clk_register_zynq_pll'
 drivers/clk/zynq/pll.c:187: warning: Function parameter or member 'lock' not described in 'clk_register_zynq_pll'

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: "Sören Brinkmann" <soren.brinkmann@xilinx.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/zynq/pll.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/zynq/pll.c b/drivers/clk/zynq/pll.c
index dcb2037a95964..54f4184de89af 100644
--- a/drivers/clk/zynq/pll.c
+++ b/drivers/clk/zynq/pll.c
@@ -173,12 +173,12 @@ static const struct clk_ops zynq_pll_ops = {
 
 /**
  * clk_register_zynq_pll() - Register PLL with the clock framework
- * @name	PLL name
- * @parent	Parent clock name
- * @pll_ctrl	Pointer to PLL control register
- * @pll_status	Pointer to PLL status register
- * @lock_index	Bit index to this PLL's lock status bit in @pll_status
- * @lock	Register lock
+ * @name:	PLL name
+ * @parent:	Parent clock name
+ * @pll_ctrl:	Pointer to PLL control register
+ * @pll_status:	Pointer to PLL status register
+ * @lock_index:	Bit index to this PLL's lock status bit in @pll_status
+ * @lock:	Register lock
  * Returns handle to the registered clock.
  */
 struct clk *clk_register_zynq_pll(const char *name, const char *parent,
-- 
2.25.1

