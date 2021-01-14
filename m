Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7687B2F6F08
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 00:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbhANXlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 18:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730755AbhANXla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 18:41:30 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA66AC061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 15:40:50 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id b8so3725173plh.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 15:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KwOjwyg6i4iA1UJ1S2Hj9B446AoSw0O4Qio8BG/OuQM=;
        b=Yo6HU+GsLdc4Gahgl+nfm4NocqQdafahxS/Vy3BfbRYl3bgPmcG6TSygnYPzXrNXeu
         CRDUVqqTqJvsei4ONiyztLN9CEtAv3hcZZktGya9ZbG3dQBAj4BGykJtAztwLAeIwN/n
         VrfRce4jDw7P8biviuBPvVBlVU7wfOHpmAdKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KwOjwyg6i4iA1UJ1S2Hj9B446AoSw0O4Qio8BG/OuQM=;
        b=CGr6bSsiC4n25bQ4rrDYBH8xD4sKXesq4Hd9qkeJmsFfDbbOjXTmohcUC9NecHDAIP
         pf4Bf6yw0cZNUUJNDQVajYsxpAEM7fhV3zX7TGYFUDUajlzwEUHPoKx+wlxDCWuxD8Is
         RmAV1NPRehjbSRcfeQZL/bnEvK+Rjl7zdq/7wanJ34mo8RbxCaWVHswapia9NLLswDtr
         XxpZ/ddqldN3wuhbNV0ZNExknA92fWlatv22qMl2Aqt+zQVIerTX1Ll0exrP1JWjFB4m
         dgefdh555TULVuKHZFB3unURaefDAjOVBexW/2aspqcoR8q1KIMO9cB/HEJTq670Wpqg
         V7+A==
X-Gm-Message-State: AOAM532EC1KeP3P9tnnjNFkBDHjV1VK5zxJx//YN006obnhUUR5c8PsU
        hO8ENHxVw6sZHlkapikcU2aduQ==
X-Google-Smtp-Source: ABdhPJyK2hTjgJqcjghcPAjC14/kP/FnaiRkzCCIPV1ht4vchLlBt1rWXpO8h+VZXa4U0HFKpDBIuw==
X-Received: by 2002:a17:902:7007:b029:dc:e89:50f1 with SMTP id y7-20020a1709027007b02900dc0e8950f1mr9940803plk.72.1610667650223;
        Thu, 14 Jan 2021 15:40:50 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id x1sm6498804pfj.95.2021.01.14.15.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 15:40:49 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Neeraj Upadhyay <neeraju@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        linux-gpio@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/4] pinctrl: qcom: Allow SoCs to specify a GPIO function that's not 0
Date:   Thu, 14 Jan 2021 15:40:24 -0800
Message-Id: <20210114154004.v6.1.I3ad184e3423d8e479bc3e86f5b393abb1704a1d1@changeid>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's currently a comment in the code saying function 0 is GPIO.
Instead of hardcoding it, let's add a member where an SoC can specify
it.  No known SoCs use a number other than 0, but this just makes the
code clearer.  NOTE: no SoC code needs to be updated since we can rely
on zero-initialization.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Maulik Shah <mkshah@codeaurora.org>
Tested-by: Maulik Shah <mkshah@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes in v6:
- Don't wrap line; bust through 80 columns!

 drivers/pinctrl/qcom/pinctrl-msm.c | 3 +--
 drivers/pinctrl/qcom/pinctrl-msm.h | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index e051aecf95c4..d1261188fb6e 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -210,8 +210,7 @@ static int msm_pinmux_request_gpio(struct pinctrl_dev *pctldev,
 	if (!g->nfuncs)
 		return 0;
 
-	/* For now assume function 0 is GPIO because it always is */
-	return msm_pinmux_set_mux(pctldev, g->funcs[0], offset);
+	return msm_pinmux_set_mux(pctldev, g->funcs[pctrl->soc->gpio_func], offset);
 }
 
 static const struct pinmux_ops msm_pinmux_ops = {
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index 333f99243c43..e31a5167c91e 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -118,6 +118,7 @@ struct msm_gpio_wakeirq_map {
  * @wakeirq_dual_edge_errata: If true then GPIOs using the wakeirq_map need
  *                            to be aware that their parent can't handle dual
  *                            edge interrupts.
+ * @gpio_func: Which function number is GPIO (usually 0).
  */
 struct msm_pinctrl_soc_data {
 	const struct pinctrl_pin_desc *pins;
@@ -134,6 +135,7 @@ struct msm_pinctrl_soc_data {
 	const struct msm_gpio_wakeirq_map *wakeirq_map;
 	unsigned int nwakeirq_map;
 	bool wakeirq_dual_edge_errata;
+	unsigned int gpio_func;
 };
 
 extern const struct dev_pm_ops msm_pinctrl_dev_pm_ops;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

