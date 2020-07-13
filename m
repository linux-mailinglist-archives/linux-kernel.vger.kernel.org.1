Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB86A218970
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 15:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgGHNq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 09:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbgGHNqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:46:25 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7F8C08C5CE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 06:46:25 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y18so26910017lfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 06:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yokX6/GqNfCJVra9vogfMzW7oEaeEABdbokc5LYRIwI=;
        b=RlNUnYwYCZObU1qK4ULsAxSxIXkTG7mMUyf77VNDSVZC4Xi6DQ4dCOW2m4BXHu+HCL
         nwfiJhi9CyF7hG35p4U+XBd8E71/Fl/59SCIYtqWsNfPTf5d1rHJSZxd/SYHEHZ8XxPY
         2rDi6EuVbK0iMGwhD2fvX8QpM5iO9TsO6sUDMGQq0FXnC0MhfaW8NgV+kEABTllp3BKf
         4n4ZUFiG1Zfj2vk7+ooDH9kOeaugMGbqOzT1unF1S9ydZ/6CWuWeUcbE8l59bZxQiCuR
         FuMJD9nTgSZ7bN2O5sU1ctPUWsjcmKeDp43MghNoo8oKtgoFYt6OE1wcGaNFhau9/FcW
         RJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yokX6/GqNfCJVra9vogfMzW7oEaeEABdbokc5LYRIwI=;
        b=oxyBoXctaq79c4yQjC3iS+RQndtfWejJjGtBnA6pDaoLHgnjupC+hyegcLLWkYDiTi
         mtSmrYUnIipuA0s6o8tBXckzaDnR3DoCb+G4drpBGjvvcs2MekCibvMFiZrpLSiFarDT
         3fWfo+0FFfj6LaJwCyU9GIrZHCa0sojXrUQnPHOaVRV9EZQ+yW3ngfZSML8/tdh5RAm2
         RBjDj4dhy56jrtaLQL2nTTIgTSoeEtlQ0fyhjodc+aGXdURg5biLWFjfn/N1YJmcAHVe
         hJT6mB3EDqTbHUkb7O7JFLOx5Dl8+VBqIqezAjthTOZMR+MbFT3fXY4Z0I6wE0xysPMv
         BnOA==
X-Gm-Message-State: AOAM531og+9fnURR4wwcb7R2WpHuOGYowJpxJDOOHnpH0S3h0DRZXMvY
        pFXz3TXhgoRCmP+7wFB6oc4XYg==
X-Google-Smtp-Source: ABdhPJyWX/2LEyXuL3gCobpVJKTemEzBK880Mx2uxw2/QqlMJrw22x14dTEHFtlA6zdr2cVdoqvECQ==
X-Received: by 2002:ac2:47e7:: with SMTP id b7mr36026094lfp.68.1594215983911;
        Wed, 08 Jul 2020 06:46:23 -0700 (PDT)
Received: from fedora.toya.net.pl (staticline-31-182-130-176.toya.net.pl. [31.182.130.176])
        by smtp.gmail.com with ESMTPSA id i22sm924902ljb.19.2020.07.08.06.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 06:46:23 -0700 (PDT)
From:   Bartosz Szczepanek <bsz@semihalf.com>
To:     Matthew Garrett <mjg59@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Pandruvada Srinivas <srinivas.pandruvada@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        Alex Levin <levinale@google.com>,
        Bartosz Szczepanek <bsz@semihalf.com>
Subject: [PATCH] thermal/int340x_thermal: Prevent page fault on .set_mode() op
Date:   Wed,  8 Jul 2020 15:46:13 +0200
Message-Id: <20200708134613.131555-1-bsz@semihalf.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from commit "thermal/int340x_thermal: Don't require IDSP to
exist", priv->current_uuid_index is initialized to -1. This value may
be passed to int3400_thermal_run_osc() from int3400_thermal_set_mode,
contributing to page fault when accessing int3400_thermal_uuids array
at index -1.

This commit adds a check on uuid value to int3400_thermal_run_osc.

Signed-off-by: Bartosz Szczepanek <bsz@semihalf.com>
---
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 0b3a62655843..12448ccd27f1 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -216,11 +216,16 @@ static int int3400_thermal_run_osc(acpi_handle handle,
 	acpi_status status;
 	int result = 0;
 	struct acpi_osc_context context = {
-		.uuid_str = int3400_thermal_uuids[uuid],
+		.uuid_str = NULL,
 		.rev = 1,
 		.cap.length = 8,
 	};
 
+	if (uuid < 0 || uuid >= INT3400_THERMAL_MAXIMUM_UUID)
+		return -EINVAL;
+
+	context.uuid_str = int3400_thermal_uuids[uuid];
+
 	buf[OSC_QUERY_DWORD] = 0;
 	buf[OSC_SUPPORT_DWORD] = enable;
 
-- 
2.17.1

