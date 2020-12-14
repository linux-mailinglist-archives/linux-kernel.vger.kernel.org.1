Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132A52DA44C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 00:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgLNXmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 18:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgLNXlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 18:41:08 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7D2C0611CB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 15:40:05 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c133so3271398wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 15:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PSByTdwbrz5R7qZA9VLp4ym5fJNRgGAvRPN2xEy9pYc=;
        b=CZFN82uNsZFeVmQ53zeRrnt1l/X2Jj8+DX5FzlDXKpXWD3WuApL+vW3EEsM+94jZXL
         +WetBXnywuq+Nhw9bDEicP7d+eAT/qyxjWmF3WAjpriilMWOta7OnkgnPgOhubaBPUnR
         pzw53cjcVpw1gTxsLR99aAPIhlwtLljL5N0KcGepVJ5OR6Ong/Hwsvy/lwnWJYUBv4fA
         A0T3C1fVowfp53e7/uYgiW0VTaDdMP3UTwxg2A/x0Wtel7BRu+op7E+MzcjqCqVtHW93
         MkrBtSZNAISG1UDb6Cm0dNj4sGN9P+lUrocJb9pQF0/6CK80iL2OLwwvK31g2nsWsSyA
         EUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PSByTdwbrz5R7qZA9VLp4ym5fJNRgGAvRPN2xEy9pYc=;
        b=Spq8NJZlQd+YxmLm0xxNgZJfgxVZLaEMQ3U8yzPjPmD2VBS2wI1ZetTCQhVyTpTVfe
         XM2cReC7jhhZTx4Ase299fu9PbbiNv1nQJPfHyovOcyqTgFXq5nQf7NMTWLAzyUeQRKu
         bonKoW3IlRozPMJx9/HCz20V9LIQAT2nHu2ApbXHoEsWC9r7cDuNoovjZ7zc5Vz+x/By
         8//KL39qfxffpOP4DXhT/UJmfBbds69aUR0Q+s/jcbOYRXCoF5Ko00CJjIojHhdrei9M
         GnJiODNtrJZdJDTKPcEiKFTb3YS2IZzkVhFpsmITQpM131Z/DGUaeJSEoRSAR/qi+Eiy
         y6vA==
X-Gm-Message-State: AOAM531fGGa3NA4uQx8zgTFBNhT5rGo9FIXDR48JBhAFIFWbfAI4yDN4
        tL4LPKvfH2VVcbYgyOVCQZKZOQ==
X-Google-Smtp-Source: ABdhPJyYYo40fmjDa7Hlr1N45geKrbY5E8NN0SueU2uo9I/J/B1TtR9SIYJKvVWM9EbryRzkhv+rMg==
X-Received: by 2002:a7b:cd91:: with SMTP id y17mr29358339wmj.171.1607989203664;
        Mon, 14 Dec 2020 15:40:03 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:e842:4086:6f24:55a6])
        by smtp.gmail.com with ESMTPSA id h3sm34145075wmm.4.2020.12.14.15.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 15:40:02 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     mjg59@codon.org.uk, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amitk@kernel.org,
        thara.gopinath@linaro.org
Subject: [PATCH 5/6] thermal/core: Remove THERMAL_TRIPS_NONE test
Date:   Tue, 15 Dec 2020 00:38:08 +0100
Message-Id: <20201214233811.485669-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201214233811.485669-1-daniel.lezcano@linaro.org>
References: <20201214233811.485669-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last site calling the thermal_zone_bind_cooling_device() function
with the THERMAL_TRIPS_NONE parameter was removed.

We can get rid of this test as no user of this function is calling
this function with this parameter.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index a0f0c33c8d9c..bcc2ea4f5482 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -710,7 +710,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	unsigned long max_state;
 	int result, ret;
 
-	if (trip >= tz->trips || (trip < 0 && trip != THERMAL_TRIPS_NONE))
+	if (trip >= tz->trips || trip < 0)
 		return -EINVAL;
 
 	list_for_each_entry(pos1, &thermal_tz_list, node) {
-- 
2.25.1

