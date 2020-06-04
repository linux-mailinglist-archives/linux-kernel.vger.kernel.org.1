Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525D81EDAE8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 03:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgFDBxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 21:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbgFDBxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 21:53:23 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5478AC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 18:53:23 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d27so3969501qtg.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 18:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ol8M2KCtVTfhjIudQ80yoAA541E23GCrsvIpBzMufk8=;
        b=g+JVXvVEhHBGXKk2wAZGtNuoP1FYpvjvUuC5MOwY3es9FBBcxhVq6st1ofsoIOh7+e
         2eFVCjT62+hMAWz2US1Slf0/Wzf6zyrhKXZ7XXrIwxVYhhLty0DDItF+ZpBm5FB4Eqon
         7uv+DEl4e5steUBdILty/uqHIbznxb8XXwua4wBLyTUX1Ln0ENC4YgiE7rXkPKrqw/U+
         oYXNL+FC6xTjKapLxYXEgp9prko8EXbVw4RR7+kADWkJgyS/CfIvgcU4mIYg+ez2B4jR
         ouIkuZGdHNwOWxpM8m4GtThiXkCxZTYLikuEoLjVRopgs8ZAqm6hkSFQj1UNuSzaG9r4
         hCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ol8M2KCtVTfhjIudQ80yoAA541E23GCrsvIpBzMufk8=;
        b=SSO5XvwaZ5+RXZjBkuZzEG5gbsmVgbxCojzFZiKlsklCkWZ+vy7gHRAEHwTeawj6BL
         hCAvQHBIKXJ/9k2uvwrAON2EhNt/Ee1wkRcUn6CMJputG+Kn01CNJEvsnjkPe5VHhT0v
         Z/YhWoe9EmJ7Xro6W6Z7Pn/7woUYDZbkaR//IGsO7hSNCssunG3W5LUHIiJGm5rmvVQg
         nYfakLWcQsKGOopi2N5lN+y5gGJbRzQqPXe4AiBIEofdE6lTlIggtsFTcQdIA4E6iFxD
         tOYgOKiJhk4KP8N/BHBcYBI9OSl0WviOHSHX0yqYiNTjv7NjR0BPxeN2GuBrbfkIwAKq
         QJFg==
X-Gm-Message-State: AOAM53353PLOOt6Eh4gusaE//DRiRGeUVoY4+zvVvT1R8Tc5ylYRPtDr
        UbGyJA1GtNDH3cV4QZdwjf26qg==
X-Google-Smtp-Source: ABdhPJwV+BvFStA1v5/UAqO4fihvZU5fJ58FDImcRujQQp1tu0wGpU2ow31ZMbF7tSXu0JwSuJkq6A==
X-Received: by 2002:ac8:2bc1:: with SMTP id n1mr2332050qtn.382.1591235602521;
        Wed, 03 Jun 2020 18:53:22 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id t74sm2986439qka.21.2020.06.03.18.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 18:53:21 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/6] soc: qcom: rpmhpd: Introduce function to retrieve power domain performance state count
Date:   Wed,  3 Jun 2020 21:53:13 -0400
Message-Id: <20200604015317.31389-3-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200604015317.31389-1-thara.gopinath@linaro.org>
References: <20200604015317.31389-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Populate .get_performance_state_count in genpd ops to retrieve the count of
performance states supported by a rpmh power domain.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/soc/qcom/rpmhpd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index e72426221a69..a9c597143525 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -362,6 +362,13 @@ static unsigned int rpmhpd_get_performance_state(struct generic_pm_domain *genpd
 	return dev_pm_opp_get_level(opp);
 }
 
+static int rpmhpd_performance_states_count(struct generic_pm_domain *domain)
+{
+	struct rpmhpd *pd = domain_to_rpmhpd(domain);
+
+	return pd->level_count;
+}
+
 static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
 {
 	int i;
@@ -450,6 +457,7 @@ static int rpmhpd_probe(struct platform_device *pdev)
 		rpmhpds[i]->pd.power_on = rpmhpd_power_on;
 		rpmhpds[i]->pd.set_performance_state = rpmhpd_set_performance_state;
 		rpmhpds[i]->pd.opp_to_performance_state = rpmhpd_get_performance_state;
+		rpmhpds[i]->pd.get_performance_state_count = rpmhpd_performance_states_count;
 		pm_genpd_init(&rpmhpds[i]->pd, NULL, true);
 
 		data->domains[i] = &rpmhpds[i]->pd;
-- 
2.20.1

