Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434402E0C90
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 16:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgLVPQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 10:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbgLVPQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 10:16:58 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD461C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 07:16:17 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id n9so12324591ili.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 07:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vFVTJ+0eHU766NlPjzayRjSs+Vk0hqn0SrA9Il/j3JU=;
        b=sSZ3NgXR3fJvfO5KGnv/psaGcLEYQx0ftL8WbaYkt8YldWrlXDxO++LjxIQlaQp2Gc
         OgeLUUG3UQ2h2zHrrl3apTSKHaGHKooKuTysvMaGtrWMsGBMFVHJzrzJank70A3eNjRE
         VE0x6tKeooyjNNQzhdzDM8H5Hcp85GyoldwT3wfua1IK6NehDHUti7oaQ8+DgzV0gFUA
         pB0OJ8mYiHHYhJfiVti+d93k7FG3ri+F2MxaCtnXXVM9YFBF6K4CM9HGJavi4cDbVGbm
         DWjzXdINbuB/YhGtk8jPzqwbAmzRq/4d+f79gnv67on9zioICf8uxrHr4QFwZH2wRIJv
         LExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vFVTJ+0eHU766NlPjzayRjSs+Vk0hqn0SrA9Il/j3JU=;
        b=OOuHdUAhVjq0HJxyp2EOyzZv3NjP1UxeipRdS1Hj/b8NFKy9wud/9LjnZTA27uP4VF
         zud+0TdLpz2R+r8rw0KcxZZrgHEDtMKfVLiij1w37SCMt6FXQ9qBxjjyWrG0cXPc8u7g
         iUSkJxiqvEK2gG6NlzHR6hme+HWTGGRPiUdC9fbMXva6RJy/LnuPiXVogT15j7cjc8OE
         866AQMYQauxgcEULfDhRYz+krvziS11KZCsvU+i3jenfT1tez/DAwyW/cI/CDWb9K0ui
         M5oU/1KSyZN83FUqkfQMDYs9G9dua4ITvQdt74LFN1wDCbg1Ot9NTfhXtp/of5XQK7cG
         m04Q==
X-Gm-Message-State: AOAM531IjjKnuoeZMP4sD1ZDggNmvXehc34fjtYZPhDXaUEfaWLUB2dV
        8of9b4zSmlP85ELx5D52huq5ig==
X-Google-Smtp-Source: ABdhPJwaOHaof7kWQzq09EHsW3c4mVjlyzv7VpeJxVjjJGoRP/WrHHG5ESBgvzgjiV+0jk1k664e9A==
X-Received: by 2002:a05:6e02:1bcb:: with SMTP id x11mr20217449ilv.32.1608650177174;
        Tue, 22 Dec 2020 07:16:17 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id e25sm24018458iom.40.2020.12.22.07.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 07:16:16 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, cpratapa@codeaurora.org,
        bjorn.andersson@linaro.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: ipa: fix interconnect enable bug
Date:   Tue, 22 Dec 2020 09:16:13 -0600
Message-Id: <20201222151613.5730-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the core clock rate and interconnect bandwidth specifications
were moved into configuration data, a copy/paste bug was introduced,
causing the memory interconnect bandwidth to be set three times
rather than enabling the three different interconnects.

Fix this bug.

Fixes: 91d02f9551501 ("net: ipa: use config data for clocking")
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/ipa_clock.c b/drivers/net/ipa/ipa_clock.c
index 9dcf16f399b7a..135c393437f12 100644
--- a/drivers/net/ipa/ipa_clock.c
+++ b/drivers/net/ipa/ipa_clock.c
@@ -115,13 +115,13 @@ static int ipa_interconnect_enable(struct ipa *ipa)
 		return ret;
 
 	data = &clock->interconnect_data[IPA_INTERCONNECT_IMEM];
-	ret = icc_set_bw(clock->memory_path, data->average_rate,
+	ret = icc_set_bw(clock->imem_path, data->average_rate,
 			 data->peak_rate);
 	if (ret)
 		goto err_memory_path_disable;
 
 	data = &clock->interconnect_data[IPA_INTERCONNECT_CONFIG];
-	ret = icc_set_bw(clock->memory_path, data->average_rate,
+	ret = icc_set_bw(clock->config_path, data->average_rate,
 			 data->peak_rate);
 	if (ret)
 		goto err_imem_path_disable;
-- 
2.20.1

