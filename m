Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7C92A499F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgKCP3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbgKCP3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:29:14 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69D3C0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:29:12 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id b8so19026684wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZKNnsnkWS6MTTEoKsqQtDIZ+4degecWTbpTZPcWfJk8=;
        b=b+gceZvO1/GgJmrQD955pgpXJRkruP0AX2yVligjCZRNpbFq7n3Ezy68+aqLYDzEKV
         OJLSrEtpaNgudNQ5MNBWQynY+iG+EthpLQiXI1KwtjFLVY9LLv7iCHPbjEONTPAKNRH7
         LmN1uBtT2wVjkgA62wWnJ03DqqLTXo4xB9IkVs5gKjSHE6xtfreHo6EgPipawL7aZkP/
         c3iQKnzgo/wqG9D1ZGfVnwUIoUJzmEncZrlKx4moNvTmUGr6fENn+nNa5b0PaPFT4pzg
         qUL47Gy4Vl2699HKxn0b+kMosNUDFEtE3gjWO8tecY7QR+0pNyAcLSAlDGboTXwmiPAa
         uY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKNnsnkWS6MTTEoKsqQtDIZ+4degecWTbpTZPcWfJk8=;
        b=D7NAmKaalbus0xnHcoinDvzbv17m1uKD1v9Wpab6X7q3z3MKprcs67nPDBObV5mIIl
         HAKzCm3ywyirXtmIPhoIV+nY3FvEdXkU3Hd8J9I4JZc7PkfBGhVQ3n7HHLRGKxqKBBot
         kQehVeIJXSm/He4KgzWHyyhZFigbz5vWgowx+0h/W7wHmRc+m9wY7b+7rfWgf6eXkm3v
         londmsMCYJqefIGUNCVyqiNPPwnGqOqrKufQUGC/X09k4oAJjvcSfTdIpjO/dFzBn8t8
         QuUdQf5GvQah3+hD0MChsSd9ms9R3sIEOLLkcoA5jdqmso8J5ma5GKrgPiN/Y6afjrjS
         bZAQ==
X-Gm-Message-State: AOAM533v4s01LiGYJegLpzWk8S5joDfJqiDJNIK5iPdlaTRdgNV1qHUJ
        /+X4i0BNTzH9rqbMHEiNxSQ5IA==
X-Google-Smtp-Source: ABdhPJzovp2vbFtDJY2ojcAcjM6l+8ZXESDvb4+bTd3xREAsY16r2NFZy3zpUu13sdE1lyQFiOLLMQ==
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr28532757wrs.342.1604417351660;
        Tue, 03 Nov 2020 07:29:11 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id j127sm3491779wma.31.2020.11.03.07.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:29:11 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 01/25] soc: bcm: brcmstb: pm: pm-arm: Provide prototype for brcmstb_pm_s3_finish()
Date:   Tue,  3 Nov 2020 15:28:14 +0000
Message-Id: <20201103152838.1290217-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103152838.1290217-1-lee.jones@linaro.org>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

brcmstb_pm_s3_finish() cannot be made static because it is referenced
from brcmstb_pm_s3(), so let's provide a prototype for it instead.

Fixes the following W=1 kernel build warning(s):

 drivers/soc/bcm/brcmstb/pm/pm-arm.c:395:14: warning: no previous prototype for ‘brcmstb_pm_s3_finish’ [-Wmissing-prototypes]

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/soc/bcm/brcmstb/pm/pm-arm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/bcm/brcmstb/pm/pm-arm.c b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
index b1062334e6089..a673fdffe2163 100644
--- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
+++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
@@ -111,6 +111,8 @@ enum bsp_initiate_command {
 
 static struct brcmstb_pm_control ctrl;
 
+noinline int brcmstb_pm_s3_finish(void);
+
 static int (*brcmstb_pm_do_s2_sram)(void __iomem *aon_ctrl_base,
 		void __iomem *ddr_phy_pll_status);
 
-- 
2.25.1

