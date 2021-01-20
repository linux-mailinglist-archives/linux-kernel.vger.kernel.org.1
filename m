Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CB02FCE18
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbhATKRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731457AbhATJdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:33:52 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6728BC061385
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:31:07 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w5so22346967wrm.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a0eH26ZUBg4+GW3DVSJr3IUvZueqhdMA0PLfT85K6+E=;
        b=MjDM98OLBbyugGi5z9i8y3gcFvSTFvaDlzZxfuqFRWUxgSzmGg2bkwE84t92uYf3f6
         1YC5KMlqojalOqRujF0SHuZGdDwHrCiGwDMcBAg0Aj/mKmm/3KW0wRqSG/CC9X+EgW6V
         wgBJQjilcc/l3PCDgB58vftVv7zWvgFr+YarUsf0Ylf28g3UaeElmEhXEv4l+r2sPzlH
         xIhcd2qZxZ+ASJDUzSESYgjgs2SeT8Q/Y0JIbk9y2cI8JYvdm75jFkVj2RfMVFYjKxv7
         yDdPDIKrgozZvxl92hv7PGPi/lDZ9Bot2HwlsvP2CgSD5yzzRUqe3so1F0IZOk55caqh
         bJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a0eH26ZUBg4+GW3DVSJr3IUvZueqhdMA0PLfT85K6+E=;
        b=bHXmTxxGnflDBmQUEbvcHb6t5hb7LPPAuCXsiCtG3kIxECKNKtKvjzLMrAWlN0XChk
         RAeGlGxc6W81h9/e4KmbU3MTnoiRNDl4yQ7rHL+4yvJSA1ZkX15Zok4ckGUBex89RL9z
         IMS18EfPnSOnu67GEw/QL6QQ4pvlEs2g/ua72E/ah/D03u6jwY4sBtORxUEFr/D3qyoP
         4E0gmC/vd5q+D9QNwEzWehISRaV4IuF455MbzxlzaadgTzMyEvXd1C0b9EzgM7ptk3uY
         CkHSFuPRJDG1Nd6PqQDwVWYQjQmowaf0fLTLass+DuO+99xX70HXVeA3u+XyFm8vn6nB
         ZdIQ==
X-Gm-Message-State: AOAM5334ebxPp5d4mo/x8ZjAaAzlno2eTT3M1XCAV0/BVJLrWq0/Gi9W
        a/T7vtR9k8UTrqpKRggZ2n99KA==
X-Google-Smtp-Source: ABdhPJx3ZjCpUjZVjx48wSf2aRSX7D5zkaVbcdktQcNjUP6AbBni3d5m+dVFFlpKQcmNFhyVo9XKgA==
X-Received: by 2002:a05:6000:1542:: with SMTP id 2mr8360962wry.356.1611135066213;
        Wed, 20 Jan 2021 01:31:06 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id z130sm2889201wmb.33.2021.01.20.01.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 01:31:05 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH 19/20] clk: versatile: clk-icst: Fix worthy struct documentation block
Date:   Wed, 20 Jan 2021 09:30:39 +0000
Message-Id: <20210120093040.1719407-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120093040.1719407-1-lee.jones@linaro.org>
References: <20210120093040.1719407-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also demote non-worthy header to standard comment block.

Fixes the following W=1 kernel build warning(s):

 drivers/clk/versatile/clk-icst.c:53: warning: Function parameter or member 'map' not described in 'clk_icst'
 drivers/clk/versatile/clk-icst.c:53: warning: Function parameter or member 'vcoreg_off' not described in 'clk_icst'
 drivers/clk/versatile/clk-icst.c:53: warning: Function parameter or member 'lockreg_off' not described in 'clk_icst'
 drivers/clk/versatile/clk-icst.c:435: warning: cannot understand function prototype: 'const struct icst_params icst525_apcp_cm_params = '

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-clk@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/versatile/clk-icst.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/versatile/clk-icst.c b/drivers/clk/versatile/clk-icst.c
index 692be2fd9261a..fdd6aa3cb1fc8 100644
--- a/drivers/clk/versatile/clk-icst.c
+++ b/drivers/clk/versatile/clk-icst.c
@@ -36,8 +36,9 @@
 /**
  * struct clk_icst - ICST VCO clock wrapper
  * @hw: corresponding clock hardware entry
- * @vcoreg: VCO register address
- * @lockreg: VCO lock register address
+ * @map: register map
+ * @vcoreg_off: VCO register address
+ * @lockreg_off: VCO lock register address
  * @params: parameters for this ICST instance
  * @rate: current rate
  * @ctype: the type of control register for the ICST
@@ -428,7 +429,7 @@ static const struct icst_params icst307_params = {
 	.idx2s		= icst307_idx2s,
 };
 
-/**
+/*
  * The core modules on the Integrator/AP and Integrator/CP have
  * especially crippled ICST525 control.
  */
-- 
2.25.1

