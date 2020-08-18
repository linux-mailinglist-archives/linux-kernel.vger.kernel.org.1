Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E30248B16
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 18:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgHRQHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 12:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgHRQHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:07:04 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA00C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:07:04 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w9so15498538qts.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y386kLDluYhTkeZZcoth4CmBIL7yeTWq5GsKaF+vTi0=;
        b=L+AiYF7wIH6A3JnmlEsCVFMWKj6Hc1oNQjevz0x+hQXBWjTNitoWNoLLzaXhN5P8nY
         T+c+cRfXlO4rvNAITs9KG9JqnfcLDy4LbF8D0XK7v3BDPJFPRJmnobWbigymyJQMD+sm
         hN/yBUuqb7V2bBFwGrywJtvL4jafxPgUvplu2LVLaZg8yoyrnv9XU88+xc/Y4f2yZ9kh
         FTfq668It2Sji0vHv5sbgV2k0+ehS6gXUXMx16hT3w6uzNOjKfPail1bkxE8FRz2Cb/u
         plJ9paM72XzvcM+elxADP/wGQ+hLpgkLte7sIZNRQhhzmYZoeJ75XoFx5LSA6HsUUU3b
         ZFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y386kLDluYhTkeZZcoth4CmBIL7yeTWq5GsKaF+vTi0=;
        b=FtYotjGk4r2JKZ6sJvVZivVnq4NcpEB5HbeBWPgRdSunQML16kj9MbXATylG16zuc/
         Iw1EvBOCa6jDwTI4jtOKOWUgxNsviCrTpN60oNrZ3XDPME9lQtqgNqByf9oZHnbDGDAi
         KoN7LTvYtfJkpA8PX1j1oZtDdup1lgDOY5mRcjzU0wXoBHVLbOLAUUqoDA3RVUkNs3M4
         K61pjuwbpW2fvajaVnhsUchC9Wud8u2gkfLFZpZ5wBtuBriSDxjj61qID2Pgw0p/sdXj
         fm4dXVqf/TySs680/8OA6N97UyezHa5J0ikT6AHp3szE2fCHzjF/W5vg/7v8qOq7LliB
         AZaw==
X-Gm-Message-State: AOAM531HVp9R+tJH3vlu3yNjwbPcIIPL1ILvzzoBxWWFby+jefESvdZx
        zzypNaFkERc1bmQi/My14/M1OZU573Tev1nt
X-Google-Smtp-Source: ABdhPJw6YK6zbb7lcw9y5lvgjXDy9DqHhKgTNBaFMkwYLP14JDsE/uxgxu5Qty/6l6GsILNdk5DfMA==
X-Received: by 2002:ac8:1b0f:: with SMTP id y15mr19000781qtj.144.1597766823586;
        Tue, 18 Aug 2020 09:07:03 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id q68sm21096654qke.123.2020.08.18.09.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 09:07:03 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list:VOLTAGE AND CURRENT REGULATOR
        FRAMEWORK)
Subject: [PATCH] regulator: set of_node for qcom vbus regulator
Date:   Tue, 18 Aug 2020 12:06:49 -0400
Message-Id: <20200818160649.19585-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the regulator to be found by devm_regulator_get().

Fixes: 4fe66d5a62fb ("regulator: Add support for QCOM PMIC VBUS booster")
---
 drivers/regulator/qcom_usb_vbus-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/qcom_usb_vbus-regulator.c b/drivers/regulator/qcom_usb_vbus-regulator.c
index 8ba947f3585f..457788b50572 100644
--- a/drivers/regulator/qcom_usb_vbus-regulator.c
+++ b/drivers/regulator/qcom_usb_vbus-regulator.c
@@ -63,6 +63,7 @@ static int qcom_usb_vbus_regulator_probe(struct platform_device *pdev)
 	qcom_usb_vbus_rdesc.enable_mask = OTG_EN;
 	config.dev = dev;
 	config.init_data = init_data;
+	config.of_node = dev->of_node;
 	config.regmap = regmap;
 
 	rdev = devm_regulator_register(dev, &qcom_usb_vbus_rdesc, &config);
-- 
2.26.1

