Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FE03045BD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393551AbhAZRwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390419AbhAZInt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:43:49 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97BAC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 00:43:08 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id f1so18694334edr.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 00:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t2z1NGbSv+92Iq3y3cHfX8r3rHSgzWMGOLngnUuImF8=;
        b=HqvMQYpbjsMs5FO0qw8p+bYpP7RjH7vBlf6l0HF5VNPGglgnOsbLVfBqJljbCsIasF
         NaYGE3B0ARKF9zXOk8iR5t9vxzgRRMOUE7jeQ4cqURu19xi64IpFfjsjuzIBdl51A+hC
         kmyXKCuwFkg/seQLV8IzyJL2tsx1vEJpZJMh5o2b5n2r1ko4f3p5zXbHSOPZiwd68r+Y
         EuLylY5VI4sLkTuc+4qAJhM/6vvPKW0T8NjQmIhBfqQ8EzuNyprvsXrov4AKw2qPm1ZO
         eWgrDM2jc3tKXYPKcV11SGdwMUuRoBXLTR/iSN8Xl6lBGJSYDPLMJUv6bQ+lcwKpb08+
         VXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t2z1NGbSv+92Iq3y3cHfX8r3rHSgzWMGOLngnUuImF8=;
        b=FbsHJLb2la1zQLbsI5KCGiYpJS7+e4X703fjkIOZ0akgVWO+GaCzKNyE1rupVKs6tu
         tRVhCO/TyUMRsFbwhKfsLPX92dJd8WUDhxEU+nwbx88aCc3In9jYrrw/f+5Mwi5wOB1e
         hRIcYQ7dmA/Om3NWUOdPi4SsXEJAfTwqJ29Y9XidcoQbNdbgylu+Dap2ZG4kRtlHrFX/
         vfGFzCrGtTQ6HhArcHGCVboS037jPaoDZgWSJo7d1HrnnHjkfGKi+pyYTfPGf2wdt1HK
         iMAVtTm0D5CB3l51IdWbbb+LO0bPiNMU19hwLsnQgileYXgeO27SqzZUy4GL/BUDwe9D
         vBcQ==
X-Gm-Message-State: AOAM532M3vRL3qE5feHrEbp0uq58iQ3AHqMa2tfMuFpn524Ad93Sf1e2
        SyWNcRvj5boP9b2gHeENgOCVGQ==
X-Google-Smtp-Source: ABdhPJwXmN0+EIt8RzL3ueMP/CCxmZVMUAxRmK9RWZ7CZYPhgMXX2MhPsEKA8AQcrWMlG54ahj8c1Q==
X-Received: by 2002:aa7:cc98:: with SMTP id p24mr3854242edt.126.1611650587275;
        Tue, 26 Jan 2021 00:43:07 -0800 (PST)
Received: from localhost.localdomain (hst-221-9.medicom.bg. [84.238.221.9])
        by smtp.gmail.com with ESMTPSA id i4sm9511524eje.90.2021.01.26.00.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 00:43:06 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] venus: core: Parse firmware-name DT property
Date:   Tue, 26 Jan 2021 10:42:52 +0200
Message-Id: <20210126084252.238078-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On production devices the firmware could be located on different
places, this path could be provided by special firmware-name DT
property.

Here we check for existence of such DT property and if it exist
take the firmware path from there. Otherwise, if the property
is missing we fallback to the predefined path from driver resource
structure.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/firmware.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index d03e2dd5808c..56c8fb5a019b 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -187,6 +187,7 @@ int venus_boot(struct venus_core *core)
 {
 	struct device *dev = core->dev;
 	const struct venus_resources *res = core->res;
+	const char *fwpath = NULL;
 	phys_addr_t mem_phys;
 	size_t mem_size;
 	int ret;
@@ -195,7 +196,12 @@ int venus_boot(struct venus_core *core)
 	    (core->use_tz && !qcom_scm_is_available()))
 		return -EPROBE_DEFER;
 
-	ret = venus_load_fw(core, core->res->fwname, &mem_phys, &mem_size);
+	ret = of_property_read_string_index(dev->of_node, "firmware-name", 0,
+					    &fwpath);
+	if (ret)
+		fwpath = core->res->fwname;
+
+	ret = venus_load_fw(core, fwpath, &mem_phys, &mem_size);
 	if (ret) {
 		dev_err(dev, "fail to load video firmware\n");
 		return -EINVAL;
-- 
2.25.1

