Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E158A303E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391989AbhAZNHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391982AbhAZMtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:49:01 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AE2C035434
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:46:10 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m13so1877112wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hwOEDN9pFoMRn0bPIH5AwWEBMRWoq5VkGdsYNSR9FGE=;
        b=cZz01X+VWuBj+9uDKkkXPXM9//fkRR9GHvUotrvnK/n1yjzEnawXB+dGxsS7z9inSF
         WgG0hLmw8aPkRHv2dpc44VQiBduw1TiWcMJP3SJBGYIs7h3MQ441bXddZcUs0LI6hr+L
         /jOxSZcoUciHMHscXa1VxI9h9IsFwA20YgG3ApzWADK/Ks5WmuiVESxKQrjI52wsgxjz
         /+D/Uk6PjuvauamZ7S6/332je+0L8ICB5iLI8emZUdBKZzxo4fsE1pKTt8BMHnxKtKdt
         Vf9+KwYyK135SHqf8I6fWJkHsF3QmX7LsVpgIIIYzcLiQ0ay4mUcrqpt4n/KLGDWeH/L
         qfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hwOEDN9pFoMRn0bPIH5AwWEBMRWoq5VkGdsYNSR9FGE=;
        b=uEVT3qbDEu5CYwN4oGWbpyuub68PpYfxE5vVmhnORRmdwFNQ1gTphqlS/9JhEbYCew
         3ZvPgkxUNYXfjgXMuhbYAkAgBUQWMXvgEQRLLTVfw99URbd56oatEigFVZQ2d5uKDRV7
         zyOKkkYBsiJJNh/N2I3sWArlkgpZp8VRKp6E/DLvNpfLUympvap4aBMbOru++mSgDBey
         xv/waHcte1ymo1xvzxwnVa7bHNw1jZH1e6J5NUKs8Qn2YEF8Q/X0hDUmwCdjEJr3b8r5
         KkiDbfe2sg4wZRZ0sFOm/nM6l2p7CuV4xX2wx58JG+5OaMXciVrT6cQaUz0u6DFK2M4a
         2RKQ==
X-Gm-Message-State: AOAM533mhvYqbiChm7+5hFOEtdG38nKDrWwCGuSD/iDWZkAK2Iimpmt1
        QH1rU4Hbd8HabI9mgWBQvlBQ45+cZ5N4XXtm
X-Google-Smtp-Source: ABdhPJzSQDfP81pbHTeNqSO7T6XdRtI37YTtqJ1RLv7NXMg826rJtq9xTgY1rh1yu6cBbuWypkDCeg==
X-Received: by 2002:a5d:6347:: with SMTP id b7mr5805047wrw.233.1611665169480;
        Tue, 26 Jan 2021 04:46:09 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id i131sm3263073wmi.25.2021.01.26.04.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:46:08 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 21/21] clk: zynqmp: divider: Add missing description for 'max_div'
Date:   Tue, 26 Jan 2021 12:45:40 +0000
Message-Id: <20210126124540.3320214-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124540.3320214-1-lee.jones@linaro.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/zynqmp/divider.c:46: warning: Function parameter or member 'max_div' not described in 'zynqmp_clk_divider'

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Rajan Vaja <rajan.vaja@xilinx.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/zynqmp/divider.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 66da02b83d393..e9bf7958b8218 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -35,6 +35,7 @@
  * @is_frac:	The divider is a fractional divider
  * @clk_id:	Id of clock
  * @div_type:	divisor type (TYPE_DIV1 or TYPE_DIV2)
+ * @max_div:	maximum supported divisor (fetched from firmware)
  */
 struct zynqmp_clk_divider {
 	struct clk_hw hw;
-- 
2.25.1

