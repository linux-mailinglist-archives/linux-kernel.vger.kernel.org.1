Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4002B2D9D99
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440346AbgLNRZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408509AbgLNRX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:23:58 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598D3C061794
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:23:18 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id j1so8985307pld.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ixXiJOTpChsS+4hsOynBoznKWWFukOcSg8gnLionDSc=;
        b=JR/A58L++gYOFPkthluSdjweS9CJRgdMUVOXmjprfA1QPNlbEHthNfByO0JoyKPdM/
         clkf8QWTb84hc9tw2QCU5bNTf2w5sbO5wSvwK/jU1GwJ8CC2eZo0NvMv6lJXg5c4+nRm
         vP6i3psTjbxQ2cZE2jn/VeQv44A8aaFeFxJRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ixXiJOTpChsS+4hsOynBoznKWWFukOcSg8gnLionDSc=;
        b=YzegYscrWYEACSJwOWlyoub+lmZqh/6AdjjrSn7LCqIRBYTqUeyCxoO4+wKP5iox1e
         zWrB8pI/4Xbu3UI5mbeOErQp+EwEaAxpmi/69l5eIanSeKvou+uuVR1izcWZseve9Xni
         RNX5J1QJVPZStecC9JbF3FjBpqbL2fROJcmxlv+5nWrj2LqfNiHccmX8T7rOQxIK9Ief
         MG0AxWha5rzsojCTUNIzE686vbR39jRsl5lDh+RKrLrLTA3sujwloaw4kJ7eP8F8t4gs
         Wawq6oO5/19WJDkMajAaQv/vjlf6/6ZLlcBzESEqQSwFa/cgs+EzRX5kSJvYbau9/7hK
         VwgQ==
X-Gm-Message-State: AOAM5335CBJgz+mtB+qbGFgkA09Lz4oQ/AB9hX5QnYLKVB79AOW6e6P0
        qtBcRc7Ty1kKs6KUTgPo27Mxveis/fMZdw==
X-Google-Smtp-Source: ABdhPJxnhLBxYwe6+7mjOz3eHTxWqA0+Qq10RmkZ3BR4aip0H78wl4m2aTZmzdXZNTGzKIjQ+UlDjQ==
X-Received: by 2002:a17:90a:c910:: with SMTP id v16mr26359722pjt.198.1607966597919;
        Mon, 14 Dec 2020 09:23:17 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id 7sm16013498pfh.142.2020.12.14.09.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 09:23:17 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Taniya Das <tdas@codeaurora.org>, vbadigan@codeaurora.org,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v5 1/2] mmc: sdhci-msm: Warn about overclocking SD/MMC
Date:   Mon, 14 Dec 2020 09:21:14 -0800
Message-Id: <20201214092048.v5.1.Iec3430c7d3c2a29262695edef7b82a14aaa567e5@changeid>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As talked about in commit 5e4b7e82d497 ("clk: qcom: gcc-sdm845: Use
floor ops for sdcc clks"), most clocks handled by the Qualcomm clock
drivers are rounded _up_ by default instead of down.  We should make
sure SD/MMC clocks are always rounded down in the clock drivers.
Let's add a warning in the Qualcomm SDHCI driver to help catch the
problem.

This would have saved a bunch of time [1].

NOTE: this doesn't actually fix any problems, it just makes it obvious
to devs that there is a problem and that should be an indication to
fix the clock driver.

[1] http://lore.kernel.org/r/20201210102234.1.I096779f219625148900fc984dd0084ed1ba87c7f@changeid

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

(no changes since v4)

Changes in v4:
- Emphasize in the commit message that this itself doesn't fix anything.

Changes in v3:
- Proper printf format code.

Changes in v2:
- Store rate in unsigned long, not unsigned int.
- Reuse the clk_get_rate() in the later print.

 drivers/mmc/host/sdhci-msm.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 3451eb325513..50beb407dbe9 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -353,6 +353,7 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	struct mmc_ios curr_ios = host->mmc->ios;
 	struct clk *core_clk = msm_host->bulk_clks[0].clk;
+	unsigned long achieved_rate;
 	int rc;
 
 	clock = msm_get_clock_rate_for_bus_mode(host, clock);
@@ -363,10 +364,20 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
 		       curr_ios.timing);
 		return;
 	}
+
+	/*
+	 * Qualcomm clock drivers by default round clock _up_ if they can't
+	 * make the requested rate.  This is not good for SD.  Yell if we
+	 * encounter it.
+	 */
+	achieved_rate = clk_get_rate(core_clk);
+	if (achieved_rate > clock)
+		pr_warn("%s: Card appears overclocked; req %u Hz, actual %lu Hz\n",
+			mmc_hostname(host->mmc), clock, achieved_rate);
+
 	msm_host->clk_rate = clock;
 	pr_debug("%s: Setting clock at rate %lu at timing %d\n",
-		 mmc_hostname(host->mmc), clk_get_rate(core_clk),
-		 curr_ios.timing);
+		 mmc_hostname(host->mmc), achieved_rate, curr_ios.timing);
 }
 
 /* Platform specific tuning */
-- 
2.29.2.576.ga3fc446d84-goog

