Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8682D7EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 19:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437077AbgLKSu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 13:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436794AbgLKStK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 13:49:10 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2348FC0611CA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 10:48:36 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id q8so12019129ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 10:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8EDSgNyu6IgaeBQKoeFyD6qLBqoz4cEoQmcNe8L/mqU=;
        b=Xovfjv2eUSzSO44meUSG4hzRoVIBRQkhuv4mNlvZ8xHhln76wJF5HYI9mbOIwOxX4s
         Svqrn2IdOqCmMHtbOhTzR1htB8j9u1CuVLMQoAL+np9GOa/0EoRBivpwhqtOCvV8t7+A
         6BxTF9mIANhGnfxLJcQH5AsHMiUR7qJ6R0XnIOW1yYzsW7cuUcimT3PJ+D5aE3esLrFJ
         kNBkmlkBtQXOZtyw71y3ucfYEVzd0GQY0x88gYGD3aJVFdrKPSxx4xS/rQHoGEXHsa5G
         jbfiQgqD0QV4+8iPhmzaWcKap6MIrPhbBX4+2RE8n+YyNHjCFF59egFY2pubmQhTEAiS
         recw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8EDSgNyu6IgaeBQKoeFyD6qLBqoz4cEoQmcNe8L/mqU=;
        b=tIgLax60p6aaGxxKeQuACxdQDJ+KGVN/LzmHvbs6gzYnmwfDSPvev716fYDhxL+lty
         a09WjdmXa2fgYClkDl2UWj/F2ftApRMjD/XCazqSHYqHosSArh3LAPty7nKPHAMc1Kxm
         ZAM0mvKktTwzJSqo4Z/84err3mF7kDa80PLXtZdgBw7X3T8BAjy/5vst3tM/5gWPNizR
         btakc+ahBQL6bkHVrM+zzA/jhs/GFUUgJFJVJiERbhE18SHQJ/H08NcuLX6MVay8aFbp
         eHBzHiQc5Hb4V3wbWdfd4o22YUJRQ7lxQskDTRzscWphsmZwqY5p01Z/ogTJbyBrWkpx
         o2Cg==
X-Gm-Message-State: AOAM533C4xNpnKO3JkDsBPT0b6lU2Z7jESn7DawGjhOqPVONtjlsGZJ9
        ntanU9XTF4nLAZpjUkAbmvIifg==
X-Google-Smtp-Source: ABdhPJxTEkPSi27jlyi0C+c6sKtrMqklycUO84dF5+kpiWcD+P7WpyoCohYUFpJXPFvQtqK1JTgcLQ==
X-Received: by 2002:a2e:86d1:: with SMTP id n17mr4291920ljj.120.1607712514591;
        Fri, 11 Dec 2020 10:48:34 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id b12sm903316lfb.139.2020.12.11.10.48.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Dec 2020 10:48:34 -0800 (PST)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     ssantosh@kernel.org, s-anna@ti.com
Cc:     grzegorz.jaszczyk@linaro.org, santosh.shilimkar@oracle.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        praneeth@ti.com, tony@atomide.com,
        linux-remoteproc@vger.kernel.org, mathieu.poirier@linaro.org
Subject: [PATCH 4/6] soc: ti: pruss: Add helper functions to set GPI mode, MII_RT_event and XFR
Date:   Fri, 11 Dec 2020 19:48:09 +0100
Message-Id: <20201211184811.6490-5-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201211184811.6490-1-grzegorz.jaszczyk@linaro.org>
References: <20201211184811.6490-1-grzegorz.jaszczyk@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The PRUSS CFG module is represented as a syscon node and is currently
managed by the PRUSS platform driver. Add easy accessor functions to set
GPI mode, MII_RT event enable/disable and XFR (XIN XOUT) enable/disable
to enable the PRUSS Ethernet usecase. These functions reuse the generic
pruss_cfg_update() API function.

Signed-off-by: Suman Anna <s-anna@ti.com>
Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
---
 include/linux/pruss.h | 55 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/linux/pruss.h b/include/linux/pruss.h
index 9cef536c6cb5..c8d73cc6baa9 100644
--- a/include/linux/pruss.h
+++ b/include/linux/pruss.h
@@ -235,4 +235,59 @@ static inline bool is_pru_rproc(struct device *dev)
 	return true;
 }
 
+/**
+ * pruss_cfg_gpimode() - set the GPI mode of the PRU
+ * @pruss: the pruss instance handle
+ * @pru_id: id of the PRU core within the PRUSS
+ * @mode: GPI mode to set
+ *
+ * Sets the GPI mode for a given PRU by programming the
+ * corresponding PRUSS_CFG_GPCFGx register
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+static inline int pruss_cfg_gpimode(struct pruss *pruss,
+				    enum pruss_pru_id pru_id,
+				    enum pruss_gpi_mode mode)
+{
+	if (pru_id < 0 || pru_id >= PRUSS_NUM_PRUS)
+		return -EINVAL;
+
+	return pruss_cfg_update(pruss, PRUSS_CFG_GPCFG(pru_id),
+				PRUSS_GPCFG_PRU_GPI_MODE_MASK,
+				mode << PRUSS_GPCFG_PRU_GPI_MODE_SHIFT);
+}
+
+/**
+ * pruss_cfg_miirt_enable() - Enable/disable MII RT Events
+ * @pruss: the pruss instance
+ * @enable: enable/disable
+ *
+ * Enable/disable the MII RT Events for the PRUSS.
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+static inline int pruss_cfg_miirt_enable(struct pruss *pruss, bool enable)
+{
+	u32 set = enable ? PRUSS_MII_RT_EVENT_EN : 0;
+
+	return pruss_cfg_update(pruss, PRUSS_CFG_MII_RT,
+				PRUSS_MII_RT_EVENT_EN, set);
+}
+
+/**
+ * pruss_cfg_xfr_enable() - Enable/disable XIN XOUT shift functionality
+ * @pruss: the pruss instance
+ * @enable: enable/disable
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+static inline int pruss_cfg_xfr_enable(struct pruss *pruss, bool enable)
+{
+	u32 set = enable ? PRUSS_SPP_XFER_SHIFT_EN : 0;
+
+	return pruss_cfg_update(pruss, PRUSS_CFG_SPP,
+				PRUSS_SPP_XFER_SHIFT_EN, set);
+}
+
 #endif /* __LINUX_PRUSS_H */
-- 
2.29.0

