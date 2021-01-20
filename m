Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D5B2FCE08
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbhATKQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731416AbhATJcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:32:15 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA56C061796
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:30:51 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l12so17142996wry.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6/9ceGuP2+USnecXvRgfX3tvKaOryov7Wtt62UymmUI=;
        b=zsUrflxnAFc3IYIoSFc8k7W7CGDz3d03oEmgRPfbTwW3ESR2Dd1HAIRTyGM1OLiVfI
         p6Y1uTIvaMxcPEMqPh/evVtCuoHbIvzxPeqSXptIr5Uo0WtScNxE0Z0ZdUGqOFpBGGhZ
         wTEXcO0uGLIFXtnwB4uVdwmzd7P36XWmOSE6JIfEZ4Bc9pE73igQ9hrjpMG0FJ9lIS2Q
         iMiLtWwNDQMYvpJDyDcGYWR7BtFEacGsBhnedZBrcm30nNzCCvl+4v6IXQ02v5ia8t+C
         4YEMjg5866/ByZseWyjDneNiGU6Qc/TBPm8wlm3Qf1xdt0vr0dM81wLvPl6sAejuOB+F
         /CMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6/9ceGuP2+USnecXvRgfX3tvKaOryov7Wtt62UymmUI=;
        b=M2qoYBalzQnxeDi8/+9S4rcWI/FeasU1x9dlZfoXhj6+cZJvaSknNvAuoIDKgWylrd
         TrI4t5Lrjj4/Clocp0oZ4EhTQwRxHyxcaKSN4JClKrBNYIs/SADFJJwtJNABq+YFwnql
         WwI4DQX5Urtzt4zKFMdrOL3LwWjJAhUWZ3isa+dqQDhmrlIk0oz5qSJsHQWYutIq3c22
         FeO3EA3Mnod8PLnFOHpkeydt3VH8sSGXpVFjfE3pLzNFBrEPAB6UXTzXN1bFAemM+uTG
         vaLmhwAWgWc8ex9ucvbo5Wc7zwaA7A/e+WE7qIMZY+o/5bzbEcRyhQXu3zx+I6RBDOnq
         9e3w==
X-Gm-Message-State: AOAM532EdtjY59YHgTXACr3PrCM1Hs87OI32V/sWEWPejbummoEGnvi8
        fi7kzDgWESPCzGcwvHODfQdArg==
X-Google-Smtp-Source: ABdhPJxWJSx1DGb1ljzPDImV+Hf4w4rCdj0LPOUIBwdeWFk2edG0+I7aroI98jI1pCvoDF6IEzLT1g==
X-Received: by 2002:adf:ded0:: with SMTP id i16mr2314632wrn.264.1611135049958;
        Wed, 20 Jan 2021 01:30:49 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id z130sm2889201wmb.33.2021.01.20.01.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 01:30:49 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 05/20] clk: bcm: clk-iproc-pll: Demote kernel-doc abuse
Date:   Wed, 20 Jan 2021 09:30:25 +0000
Message-Id: <20210120093040.1719407-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120093040.1719407-1-lee.jones@linaro.org>
References: <20210120093040.1719407-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/bcm/clk-iproc-pll.c:712: warning: Function parameter or member 'pll' not described in 'iproc_pll_sw_cfg'

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/bcm/clk-iproc-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-iproc-pll.c b/drivers/clk/bcm/clk-iproc-pll.c
index 274441e2ddb28..33da30f99c79b 100644
--- a/drivers/clk/bcm/clk-iproc-pll.c
+++ b/drivers/clk/bcm/clk-iproc-pll.c
@@ -704,7 +704,7 @@ static const struct clk_ops iproc_clk_ops = {
 	.set_rate = iproc_clk_set_rate,
 };
 
-/**
+/*
  * Some PLLs require the PLL SW override bit to be set before changes can be
  * applied to the PLL
  */
-- 
2.25.1

