Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66AA29E863
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgJ2KHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgJ2KHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:07:22 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A118C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:07:22 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n16so1909324pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kaco/2CftYFGu/eFXJkHw/L2xwMEatEIbvMFbMDpekc=;
        b=EqbJY2MCnQ7Cozanruz5iXdLHkbQbFIBBKD2Ck20OXnX9C1Dn9a3oIGFzDXrZxJSKA
         yDCHNbA8C7lR++xqh6TnLiz36OKqP5n8up9Lw8hhSm+YYU9TUm9z4DK2GEdaqTF+tvCT
         Vs+LIBq+9Jab6w4QsQWpSqf3S8FPvmPiRSQH0kFwkrzgcyjvWFxQkUSiaoaOu1MZvxJz
         57CfmlBAdrJq5sQkYlhkK3cM287nftmz26nAA4VH6t20eqCQnvOUjuFidUsJW6YsCZy1
         L1h/R19+fN2uO18DdCo8MzDKB06+UaebNJN1bHv4eH773K3EHHBu2mHisWBVLemuX01c
         Q1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kaco/2CftYFGu/eFXJkHw/L2xwMEatEIbvMFbMDpekc=;
        b=Y2Oc9MJJPiDEsxCNwlMHsLRqUl5cqXnOo9TveNPzNp8zNXjU+QHNMGT0N3hemciZ2Q
         qNmbgKAclugX67ptABEJXE8N9favdWRYO7MqYG+U6HVY6HIG0D4nGeGBLbCoAh6Fr3TC
         VYJAdd7aRNvC2v8ti0ErnxIiHs7QaTwmfNUqtaVBHq39DqcxoRNH5L367DgTc46Kf8jZ
         Odg167KIvUI9YcZFAOmO0mxLHuGhmlgsPzRH2UB3RcJ4na2LOgRo9VemSuzw2EcwmQPD
         +1Ht+rI2uXYT6Pye5Yd4QfSXzcg+BvEMWYcsF65AHzC4By6YVaEQX/DwXlfKsOIafCZL
         M4Qw==
X-Gm-Message-State: AOAM530CNOVB2FHi056ATCkuSwvXaMZUbSts08WUrIy5h14DtKFEdqes
        pQFaNUjZ8LBLVJAzEsFHiFkFO2DxOUomCnci
X-Google-Smtp-Source: ABdhPJyr/bUDOTcBfdDN6DuOlVOEfCvFWz3rS/WVi83TBgDOSFBdGgxN5ti429gsRPGoT2yNtu/PbQ==
X-Received: by 2002:a63:da4e:: with SMTP id l14mr3440872pgj.131.1603966042021;
        Thu, 29 Oct 2020 03:07:22 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id j20sm2121784pgl.40.2020.10.29.03.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 03:07:21 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/9] mfd: max77620: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 18:06:42 +0800
Message-Id: <20201029100647.233361-4-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029100647.233361-1-coiby.xu@gmail.com>
References: <20201029100647.233361-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SET_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 drivers/mfd/max77620.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index fec2096474ad..17ea0ae6408d 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -574,7 +574,6 @@ static int max77620_probe(struct i2c_client *client,
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int max77620_set_fps_period(struct max77620_chip *chip,
 				   int fps_id, int time_period)
 {
@@ -681,7 +680,6 @@ static int max77620_i2c_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct i2c_device_id max77620_id[] = {
 	{"max77620", MAX77620},
-- 
2.28.0

