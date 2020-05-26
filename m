Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E171CF4F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 14:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbgELMyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 08:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729919AbgELMyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:54:12 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160B1C05BD0A
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:54:11 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id m24so12022405wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ajq1/CzNblXv+RM50/78rYUghtc/wnGS+X5x8yODyro=;
        b=sO7XfySXe80lnwqkM0HWalZ/ES2oFzxHC7xem4vOYv+YNGQ6ZdL81IDKCWGRDYfo0K
         AIuWbCIrg5La5wCRDU2tJVS4DgFc4wCRbB6qfTOAeTyqMYZlg2VZaW+copxuN+tcappx
         IuMRgLabKURL8TLvRpsSTyWAzjpVwbUMLwc0VPYo7NzOqGT1qcj5lQ6VT/ZlAltjSLbe
         FSBTGWNX19PpIanyCGJPjsAd/QKzg+8cSl7cg13/lrwi54mXTWI8SfsQ8zpneQZZBtdi
         5FpDn2wm5oPgJImqxZQYO6p3LvBY/IvBBd3lsGCb7YLa0bMxREUTf1p5wqFbjpk6DEsd
         rjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ajq1/CzNblXv+RM50/78rYUghtc/wnGS+X5x8yODyro=;
        b=qd7D7e2rStWf048uxfNMqXEVamH19uobyMX12/ID5dbsrxxOh2DTF72FTXYMIhmd3W
         aJIBHL8H07hxJ1vyqz6uSVK0Kpa2ueQa5gvJn1MWMj8diQ8CZKx6z8eiDDvuBNHPJdZS
         OpEdd3coFC2t7NSwq256OdJE2o2ngncJam75hX4Cl0iTD782CLqVhZuVMDq+/ZmDWTlb
         WyVGtrTPghkTg3hQp2XB1uKp2VcZObRq86mu8R2+9DGtpgTIIMOneF18sf9OlPT+RVnr
         bBfcf8mWx8tZZcooEz8z4UNsSMuKYkug40FSOZ2DD/yUkPQ38/89CSMMmgZF0OQ6p7QJ
         uB0A==
X-Gm-Message-State: AGi0PuY19dl+yH1smJz1lZWaNsEpNhfcqc1f17o/fBZNYwSebVoGsWQf
        12r7Drq9g85IYjyxSDwhm8wuuw==
X-Google-Smtp-Source: APiQypI9T2ok8lrlawVLg9C+vh31VJV/7SAheVI1C66BCWNhBoiMINsaNb/Pq91MS1pb1eZXRFnVwg==
X-Received: by 2002:a05:600c:21d6:: with SMTP id x22mr39074416wmj.95.1589288049805;
        Tue, 12 May 2020 05:54:09 -0700 (PDT)
Received: from localhost.localdomain (212-39-89-66.ip.btc-net.bg. [212.39.89.66])
        by smtp.googlemail.com with ESMTPSA id n13sm2433938wrs.2.2020.05.12.05.54.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 05:54:09 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, mka@chromium.org
Cc:     robh+dt@kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v8 08/10] cpufreq: dt: Validate all interconnect paths
Date:   Tue, 12 May 2020 15:53:25 +0300
Message-Id: <20200512125327.1868-9-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512125327.1868-1-georgi.djakov@linaro.org>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when we check for the available resources, we assume that there
is only one interconnect path, but in fact it could be more than one. Do
some validation to determine the number of paths and verify if each one
of them is available.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
v8:
* New patch.

 drivers/cpufreq/cpufreq-dt.c | 49 ++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 4ecef3257532..3dd28c2c1633 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -91,12 +91,54 @@ static const char *find_supply_name(struct device *dev)
 	return name;
 }
 
+static int find_icc_paths(struct device *dev)
+{
+	struct device_node *np;
+	struct icc_path **paths;
+	int i, count, num_paths;
+	int ret = 0;
+
+	np = of_node_get(dev->of_node);
+	if (!np)
+		return 0;
+
+	count = of_count_phandle_with_args(np, "interconnects",
+					   "#interconnect-cells");
+	of_node_put(np);
+	if (count < 0)
+		return 0;
+
+	/* two phandles when #interconnect-cells = <1> */
+	if (count % 2) {
+		dev_err(dev, "%s: Invalid interconnects values\n", __func__);
+		return -EINVAL;
+	}
+
+	num_paths = count / 2;
+	paths = kcalloc(num_paths, sizeof(*paths), GFP_KERNEL);
+	if (!paths)
+		return -ENOMEM;
+
+	for (i = 0; i < num_paths; i++) {
+		paths[i] = of_icc_get_by_index(dev, i);
+		ret = PTR_ERR_OR_ZERO(paths[i]);
+		if (ret)
+			break;
+	}
+
+	while (i--)
+		icc_put(paths[i]);
+
+	kfree(paths);
+
+	return ret;
+}
+
 static int resources_available(void)
 {
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
-	struct icc_path *cpu_path;
 	int ret = 0;
 	const char *name;
 
@@ -123,8 +165,7 @@ static int resources_available(void)
 
 	clk_put(cpu_clk);
 
-	cpu_path = of_icc_get(cpu_dev, NULL);
-	ret = PTR_ERR_OR_ZERO(cpu_path);
+	ret = find_icc_paths(cpu_dev);
 	if (ret) {
 		if (ret == -EPROBE_DEFER)
 			dev_dbg(cpu_dev, "defer icc path: %d\n", ret);
@@ -134,8 +175,6 @@ static int resources_available(void)
 		return ret;
 	}
 
-	icc_put(cpu_path);
-
 	name = find_supply_name(cpu_dev);
 	/* Platform doesn't require regulator */
 	if (!name)
