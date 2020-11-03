Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC892A49BB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgKCP31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbgKCP3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:29:18 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A683C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:29:18 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id x7so19025893wrl.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aFpE8TWyRb/8lJ+wQ6DztKwPdlVGvH7F9yr1Famwf80=;
        b=O2KkbM844GlxoBJeeA8IiEb+C8pbG1IF+APG9qRsXnBzbNzZrztStr7i7P3fDcjSl7
         ATxlms6R7tTkKNMTSbqFca74AYdlfCkww8nMZsBvKzJbLBA6WdopKV/7ZqjZPrjAIOLp
         dg/5PdOP84t6BVsweSC50HSZTBkgIyaMRe2Ug1KtcadpAkiOoARGbf9Hq+ysVTpPYNBg
         W0zc/siWTrUL4r46Rkso2k2roN/oD3oAPOq+8N6SY5yvb70pUJzhRhnMAURDPlRpdiaN
         1XVQs/FTUHrLWZ1KPIP8mCCRdFId2IaFq3YEySOU+y9IRTOHhfnKb5d38Dp07Rf+yJ+f
         QRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFpE8TWyRb/8lJ+wQ6DztKwPdlVGvH7F9yr1Famwf80=;
        b=gxSS0Uivkd9tp4vG+wkqQ60u2RFELCy26gFUVtMmOiBadXbX5xHAii6JQKEdCc60VJ
         pPqJui2wHlQhDdyeLHBSs7NcW+MzL8ERTF3qexk9ZkUJ14tIxcAY+l1Aop0J0OB175xw
         8XT26Dw59iYfTul+oN0RPwJS2To3ldUsyIRlxhphJtQIJmaL1NSkh62t9N+GIRYWswZ7
         y8Uxle3wrP7GoekZRMf8kStkQtwYs3se8HWCkP0z5wmQQkeiCD3ewtv70ec1R1mosZFj
         A4bImDLEcvt/G+8kElEJ166qpPaFVFWbouwOt+CFi+JLAsAhPQuWBIoxssTDKN/aq559
         uAlA==
X-Gm-Message-State: AOAM531Q10LLL6PHGbB7quCIhJGN2kmwb5jjIA5tWUqys2yWmTm6Jj9e
        YujW4uWXP2D8nXsw9sSCOwitFg==
X-Google-Smtp-Source: ABdhPJzj/L32Nzhr35Iq/JNk+9EtSLNL/wng8uuuXmJxAVqXtSjiv6Hl8+RbW4GErg3nuxcOBHtUYg==
X-Received: by 2002:a5d:5106:: with SMTP id s6mr26077213wrt.51.1604417356740;
        Tue, 03 Nov 2020 07:29:16 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id j127sm3491779wma.31.2020.11.03.07.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:29:16 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Doug Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 05/25] soc: rockchip: io-domain: Remove incorrect and incomplete comment header
Date:   Tue,  3 Nov 2020 15:28:18 +0000
Message-Id: <20201103152838.1290217-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103152838.1290217-1-lee.jones@linaro.org>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/soc/rockchip/io-domain.c:57: warning: Cannot understand  * @supplies: voltage settings matching the register bits.

Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/soc/rockchip/io-domain.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/soc/rockchip/io-domain.c b/drivers/soc/rockchip/io-domain.c
index eece97f97ef8f..d13d2d497720b 100644
--- a/drivers/soc/rockchip/io-domain.c
+++ b/drivers/soc/rockchip/io-domain.c
@@ -53,9 +53,6 @@
 
 struct rockchip_iodomain;
 
-/**
- * @supplies: voltage settings matching the register bits.
- */
 struct rockchip_iodomain_soc_data {
 	int grf_offset;
 	const char *supply_names[MAX_SUPPLIES];
-- 
2.25.1

