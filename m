Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825AE2FE959
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbhAULtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730198AbhAULU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:20:57 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D43C06179B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 03:19:01 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id b8so1133144plx.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 03:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xAKTZkyycba98JIw9o5yBKGTgq6RnpydF9Cba6DEkjM=;
        b=IE5cB3XUcMOfllNnwGT/K8+FysNlnl6CN4kmfCqtdtbsK6nqdVZB37NlyY+ocle3C1
         BJSbgqiGQ1RcwE/02b9qpjDCWn+//56RBxiUS9lahW8NTBSWgTBU14p8ehtxYGrcFw3J
         m/iaGhrrFw77+W7wq4k/oNokc2iEHPCcYeFueag/GTYWb6dV+LWnlQ/5a/f/SvRNvuAa
         3mjYP0rSx6c28PV2w4lAxljy/w3tDI4ULO6U74GbojEyPdXiDKRg6rLHLaz5qqU53StK
         n7sGL3faxA9KaPvLiYX4EdAkbRVZqJB3aSLBngSk/QRb7gStOyskUpFzy1eTnLGF7TZj
         /vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xAKTZkyycba98JIw9o5yBKGTgq6RnpydF9Cba6DEkjM=;
        b=hy/nDZBMtBOqWyJrle3XW17o9jziI9aqTFr2AdAFkTM7LM0VtngwJmKoz7hn8yxfnG
         I2AkPma8O7s2Q79PvnbNs8/aj94f5vftpQ0aBImBQDLbR+wcRChnznZHYYmB/EanmsOV
         eElvPytXIn2ntR1qLavftyiHikzueyOLmgjyAOLZSoLh5kLuYp/PLHW9HL5L/Cp+RIOE
         f6+jIIrmbVWSdX60YN2zCCCVWAwS5W656JTmapMtBSNBm3hLooa4qB+soWFOUIimYU3D
         CDb/zAoZ+VVNxFil/286yEsMDGsv14JvfyjaZYgeB+9DAzIf8+/RA0VId6RUH42xk5Wk
         6Ucw==
X-Gm-Message-State: AOAM530LEX5R7IxhQwBkZXhERhQUAKf2ITkm4ioGMqHWvr01ownRp7cr
        DgqEyFoy4ihcIiUgbJL9zSjZfw==
X-Google-Smtp-Source: ABdhPJzh80hJitJKGsChrc0Eudj2IFABV8NGgEDM/wNUy0FrILeXFQbCYrIaBzthFQDqE04LoZxRUw==
X-Received: by 2002:a17:90a:fd0b:: with SMTP id cv11mr11277904pjb.26.1611227940577;
        Thu, 21 Jan 2021 03:19:00 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id l12sm2255450pjg.54.2021.01.21.03.18.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 03:19:00 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/13] opp: Allow _generic_set_opp_regulator() to work for non-freq devices
Date:   Thu, 21 Jan 2021 16:47:46 +0530
Message-Id: <8f2d26305f38b52ebc46f2b0d4620e1e578fa2f2.1611227342.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611227342.git.viresh.kumar@linaro.org>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _generic_set_opp_regulator() helper will be used for devices which
don't change frequency (like power domains, etc.) later on, prepare for
that by not relying on frequency for making decisions here.

While at it, update its parameters to pass only what is necessary.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 64424dbd23c1..a96ffd9051b1 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -737,12 +737,12 @@ static inline int _generic_set_opp_clk_only(struct device *dev, struct clk *clk,
 
 static int _generic_set_opp_regulator(struct opp_table *opp_table,
 				      struct device *dev,
-				      unsigned long old_freq,
+				      struct dev_pm_opp *opp,
 				      unsigned long freq,
-				      struct dev_pm_opp_supply *old_supply,
-				      struct dev_pm_opp_supply *new_supply)
+				      int scaling_down)
 {
 	struct regulator *reg = opp_table->regulators[0];
+	struct dev_pm_opp *old_opp = opp_table->current_opp;
 	int ret;
 
 	/* This function only supports single regulator per device */
@@ -752,8 +752,8 @@ static int _generic_set_opp_regulator(struct opp_table *opp_table,
 	}
 
 	/* Scaling up? Scale voltage before frequency */
-	if (freq >= old_freq) {
-		ret = _set_opp_voltage(dev, reg, new_supply);
+	if (!scaling_down) {
+		ret = _set_opp_voltage(dev, reg, opp->supplies);
 		if (ret)
 			goto restore_voltage;
 	}
@@ -764,8 +764,8 @@ static int _generic_set_opp_regulator(struct opp_table *opp_table,
 		goto restore_voltage;
 
 	/* Scaling down? Scale voltage after frequency */
-	if (freq < old_freq) {
-		ret = _set_opp_voltage(dev, reg, new_supply);
+	if (scaling_down) {
+		ret = _set_opp_voltage(dev, reg, opp->supplies);
 		if (ret)
 			goto restore_freq;
 	}
@@ -783,12 +783,12 @@ static int _generic_set_opp_regulator(struct opp_table *opp_table,
 	return 0;
 
 restore_freq:
-	if (_generic_set_opp_clk_only(dev, opp_table->clk, old_freq))
+	if (_generic_set_opp_clk_only(dev, opp_table->clk, old_opp->rate))
 		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
-			__func__, old_freq);
+			__func__, old_opp->rate);
 restore_voltage:
 	/* This shouldn't harm even if the voltages weren't updated earlier */
-	_set_opp_voltage(dev, reg, old_supply);
+	_set_opp_voltage(dev, reg, old_opp->supplies);
 
 	return ret;
 }
@@ -1035,9 +1035,8 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 		ret = _set_opp_custom(opp_table, dev, old_freq, freq,
 				      old_opp->supplies, opp->supplies);
 	} else if (opp_table->regulators) {
-		ret = _generic_set_opp_regulator(opp_table, dev, old_freq, freq,
-						 old_opp->supplies,
-						 opp->supplies);
+		ret = _generic_set_opp_regulator(opp_table, dev, opp, freq,
+						 scaling_down);
 	} else {
 		/* Only frequency scaling */
 		ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
-- 
2.25.0.rc1.19.g042ed3e048af

