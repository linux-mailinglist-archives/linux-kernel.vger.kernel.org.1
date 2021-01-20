Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1A32FCE0A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbhATKQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731431AbhATJcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:32:17 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74615C06179B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:30:53 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a12so22347158wrv.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3zpDeTOsD2P7WN1NPJVgpjl7R+7fXK52sr/TrTLf7sk=;
        b=TZckWmIVkN9la2W25N7ghd/3t5LriuUBnVMaMg75aBQ2i9AcMnOJKMgCqJ+1HMhWVW
         DubqCpSoYLpwIzbGp/DbqA44ErDaScHCrx60lKcgaI3/lQ+djsTnXDHLTCzJhXgfhNN5
         2ruy4joVgMK6TIjwr5DUGhfwda3+XJayRxso4n/0lf/J8+ab9/Di8+8r7PGoyhA6YH9l
         m7+Hr9Gn4giYDEWpSAKIZ1XmXi+EetNXS9dnTJtpZFtJa5BLFR+Zxf7ToPGNfzGDhGNU
         deDlXxIITd4AlTUYXjWjnLIOPuDZXG8Vw/rKPCCjhekXmbFoj1WXi5pJHGO4CXR4VoXQ
         kYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3zpDeTOsD2P7WN1NPJVgpjl7R+7fXK52sr/TrTLf7sk=;
        b=s8tXkqel4cWxUUxd+O8oq6pBD5n6Jm1k/lNEspJFogoxpcVCEjKE7MHnuAn8inQepL
         WpYA7sOnvjEowZglmr6ImytaKgmA5Hl4TsnHSlyVLfJeUlSlmVt+SXqNxhWQz0kWYPKK
         r5S7jQDk2T5Ahx9IReMy1N53fIo79vf9IvPsfjCBxdM6I2mrAVmY4d1YL+MyZtxAD+wS
         1nmmuZJYrAwfA4a5GA5+22jWTPEf5cKdUovjRe16iotmkzcLxQflrhhvdQzXLMxIPigo
         JmMZF/rJ/67oufcWQa9VjnWYULXSZ4Hk9PAGF1OWN/G558F15z3WAkjFd4U/3aBa65Ds
         XPlA==
X-Gm-Message-State: AOAM532rGSz9fKjSC4AIixVS76hBfKt4elO6wuxWKk1LWVVilbZif53y
        TBqqQWSNc/4U1AeQx6dK3zdHpA==
X-Google-Smtp-Source: ABdhPJyd+2c72Z2W8MYn9ewofWd/BnR52BttYOgrM7aSaNTdNRx3Nyr23GgWLZxJ67da2cldjYhcsA==
X-Received: by 2002:a5d:6902:: with SMTP id t2mr8274810wru.214.1611135052283;
        Wed, 20 Jan 2021 01:30:52 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id z130sm2889201wmb.33.2021.01.20.01.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 01:30:51 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH 07/20] clk: socfpga: clk-pll: Remove unused variable 'rc'
Date:   Wed, 20 Jan 2021 09:30:27 +0000
Message-Id: <20210120093040.1719407-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120093040.1719407-1-lee.jones@linaro.org>
References: <20210120093040.1719407-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/socfpga/clk-pll.c: In function ‘__socfpga_pll_init’:
 drivers/clk/socfpga/clk-pll.c:83:6: warning: variable ‘rc’ set but not used [-Wunused-but-set-variable]

Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/socfpga/clk-pll.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/socfpga/clk-pll.c b/drivers/clk/socfpga/clk-pll.c
index e5fb786843f39..3cf99df7d0056 100644
--- a/drivers/clk/socfpga/clk-pll.c
+++ b/drivers/clk/socfpga/clk-pll.c
@@ -80,7 +80,6 @@ static __init struct clk *__socfpga_pll_init(struct device_node *node,
 	const char *parent_name[SOCFPGA_MAX_PARENTS];
 	struct clk_init_data init;
 	struct device_node *clkmgr_np;
-	int rc;
 
 	of_property_read_u32(node, "reg", &reg);
 
@@ -111,7 +110,7 @@ static __init struct clk *__socfpga_pll_init(struct device_node *node,
 		kfree(pll_clk);
 		return NULL;
 	}
-	rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
 	return clk;
 }
 
-- 
2.25.1

