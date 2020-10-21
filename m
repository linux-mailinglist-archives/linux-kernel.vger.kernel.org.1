Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF6D2950EF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503046AbgJUQjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503028AbgJUQi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:38:56 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE930C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:38:54 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l16so3254134eds.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ohk60Lc9axvVM7bujOFXofpFFhnugPw9JS+9Z6gwq/w=;
        b=GEMLmHMccDitjDiVntpcbZF4/ew82oBOAS/eJriDByqKp2mIvoV8csZuJ7ElVfET9c
         PcaD8VqWlzbIRSW7GeMKFmipRdrjfP9P5SkTvHYbvBqJNuLrh/fpgiCp6PuNPthlU6qb
         K+GSVliaw3BAKJrjsM8UPy1GTY3Ja1KGuxWg4+ir3SE6hlUH7Y3OUV7O0Rnyqdws/kU0
         vtjpHpbFYF9HcXDDD2n7+hrmmu3KE3i+LFQYFw3hae/6G7U3Md+xFv+3afEd1aBsC77v
         eL7fL6EIdwgZ6qg/5wHkXPLJhFsaXsxBUWI5rkrZTGJZYGy2N2izaxPvYtDFKUEVeKjs
         gc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ohk60Lc9axvVM7bujOFXofpFFhnugPw9JS+9Z6gwq/w=;
        b=eK4/Zxc+dgjNSIswGh2bnynPDbcfHOlE5LmweiPmJ42/Q1prdCYmmtAiQsvGPMOqvM
         ZIYXpz1Vi5DEzO6B5mp9p14750U4/oHeqi1NnnT9xCJyUdNLfCNRjVFD8bGcJi0onoGo
         TjAgudv9h0HshNoS3TFB1PSBLnDClE/MSYIFAZuxih8moWUehUDSE/PFxmgLRkenGiaC
         /rlMNgmFX69mkq5N0D77iW+d2o0vYdfqRYgQIi50BPh3isyEIadKAT/EYjfljwPXNDi/
         wanf64CTJ9rb/mK6KA+NMqV3XgwcRM7AXfCSZ4dGpYiJGHO9uDivoFEwnMO7UMlc+ZQU
         j3xg==
X-Gm-Message-State: AOAM5308UYToDA7GDtlKRSUt7udNkK/zYeY1Ej06E9aYbfpWbclLJkPJ
        ODqBHhvXJN3lnlBeKADlhXYx8w==
X-Google-Smtp-Source: ABdhPJz/xI5mua9UlK4b08PjCq49mDh1kU1oEbpF6dQ0ewYrgkI8rTu2uFdxP/IyjaR8K1h8hzrHCA==
X-Received: by 2002:a05:6402:22e3:: with SMTP id dn3mr2970696edb.205.1603298333562;
        Wed, 21 Oct 2020 09:38:53 -0700 (PDT)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id f26sm2549747ejx.23.2020.10.21.09.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 09:38:53 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 1/2] clk: add devm variant of clk_notifier_register
Date:   Wed, 21 Oct 2020 18:38:46 +0200
Message-Id: <20201021163847.595189-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201021163847.595189-1-jbrunet@baylibre.com>
References: <20201021163847.595189-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a memory managed variant of clk_notifier_register() to make life easier
on clock consumers using notifiers

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/clk.c   | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/clk.h | 10 ++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d27153f26fa9..e9fdd1d9b3f5 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4395,6 +4395,42 @@ int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(clk_notifier_unregister);
 
+struct clk_notifier_devres {
+	struct clk *clk;
+	struct notifier_block *nb;
+};
+
+static void devm_clk_notifier_release(struct device *dev, void *res)
+{
+	struct clk_notifier_devres *devres = res;
+
+	clk_notifier_unregister(devres->clk, devres->nb);
+}
+
+int devm_clk_notifier_register(struct device *dev, struct clk *clk,
+			       struct notifier_block *nb)
+{
+	struct clk_notifier_devres *devres;
+	int ret;
+
+	devres = devres_alloc(devm_clk_notifier_release,
+			      sizeof(*devres), GFP_KERNEL);
+
+	if (!devres)
+		return -ENOMEM;
+
+	ret = clk_notifier_register(clk, nb);
+	if (!ret) {
+		devres->clk = clk;
+		devres->nb = nb;
+	} else {
+		devres_free(devres);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_clk_notifier_register);
+
 #ifdef CONFIG_OF
 static void clk_core_reparent_orphans(void)
 {
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 7fd6a1febcf4..79fb52f93053 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -109,6 +109,16 @@ int clk_notifier_register(struct clk *clk, struct notifier_block *nb);
  */
 int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb);
 
+/**
+ * devm_clk_notifier_register: register a managed rate-change notifier callback
+ * @dev: device for clock "consumer"
+ * @clk: clock whose rate we are interested in
+ * @nb: notifier block with callback function pointer
+ *
+ * Returns 0 on success, -EERROR otherwise
+ */
+int devm_clk_notifier_register(struct device *dev, struct clk *clk, struct notifier_block *nb);
+
 /**
  * clk_get_accuracy - obtain the clock accuracy in ppb (parts per billion)
  *		      for a clock source.
-- 
2.25.4

