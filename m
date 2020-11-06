Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AD92A8FA8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgKFGtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgKFGtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:49:23 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558FEC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 22:49:22 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id a18so243019pfl.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 22:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EhBdW5IWB8IOJUCB3Jns04hRuavBXzgRCXhTaB+mxw4=;
        b=Ic4slt0BtFKc2d/3FAW3k6CtAPGxQoplvI6cwh1JMjup8B+Dkqz50zALb2AvZFe3Om
         i0MY41Vh3HRbfjpTdbiuXt8i99hTrp1o6mObsERP820UjUm2CQlDO0fOvmModRJO0kky
         7pcBA+eZn9XWFJbpGX3zCOulMTiOgOVbl9Xn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EhBdW5IWB8IOJUCB3Jns04hRuavBXzgRCXhTaB+mxw4=;
        b=ia+1KBLaY1lAiPugjq2tOybTmohKHoMQA1FfcSn5MJSPidS6o8IqcjRUhHBIMj+gt9
         yznUTm4pBgMlEuXPuYSrUx7eLDs5UcXLxkVzqB66lsKGKzAco05/vwVA/Mcq97rMbkna
         vWlxLbbTyfnAGJNX/uGKhkLvd7QhNX2E1SM5TkK+7d5oCfBvXgg1NMIHrjtflX84bmfx
         jzD+rhS+xJQNIlEb0hZ3G8ifVHsZQy0E6NfoUP5zlEq6CK+9gSs1g1XSv7NhZbygcn6T
         TqFB8wC0mMrjkyIrDd99XfAu4fgQWt7x66cbiVh8YB3Cd2/wdX+uPeWVUvAv3DFr1bPl
         cg3Q==
X-Gm-Message-State: AOAM5309UGnKJ0kUmfJYZttu70VYvEOQQ6gq2V6PK3gr+sYkWa+RSpqe
        XeF0HANKcqZEk59qUQ0ip8xcEA==
X-Google-Smtp-Source: ABdhPJyBXwkoSLM+bO7kSq/3lwThfsFkru9vV2hsvuVAUljc1BHLWCCr94WTtY8jQEHePE2KeevGag==
X-Received: by 2002:a17:90b:4683:: with SMTP id ir3mr917982pjb.212.1604645361916;
        Thu, 05 Nov 2020 22:49:21 -0800 (PST)
Received: from kafuu-chino.c.googlers.com.com (105.219.229.35.bc.googleusercontent.com. [35.229.219.105])
        by smtp.googlemail.com with ESMTPSA id d68sm752405pfc.135.2020.11.05.22.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 22:49:21 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org (open list:VOLTAGE AND CURRENT REGULATOR
        FRAMEWORK)
Subject: [PATCH] regulator: core: don't disable regulator if is_enabled return error.
Date:   Fri,  6 Nov 2020 14:48:17 +0800
Message-Id: <20201106064817.3290927-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In regulator_late_cleanup when is_enabled failed, don't try to disable
the regulator since it would likely to fail too and causing confusing
error messages.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---

This is encountered while using drivers/regulator/cros-ec-regulator.c.
Since the driver controls the regulator through ChromeOS EC host
commands, it is not available when doing suspend / resume.

But since the regulator_late_cleanup is delayed to 30 seconds after
boot, it is possible that the regulator_late_cleanup is run during
suspend / resume, which cause the is_enabled call to fail, and printing
out some confusing error messages later when trying to disable the
regulator and fail.

This commit attempts to address part of this issue by not trying to
disable the regulator if the is_enabled call failed.

---
 drivers/regulator/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a5ad553da8cd..70168f2a53ed 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5843,13 +5843,14 @@ static int regulator_late_cleanup(struct device *dev, void *data)
 	if (rdev->use_count)
 		goto unlock;
 
-	/* If we can't read the status assume it's on. */
+	/* If we can't read the status assume it's always on. */
 	if (ops->is_enabled)
 		enabled = ops->is_enabled(rdev);
 	else
 		enabled = 1;
 
-	if (!enabled)
+	/* But if reading the status failed, assume that it's off. */
+	if (enabled <= 0)
 		goto unlock;
 
 	if (have_full_constraints()) {

base-commit: 521b619acdc8f1f5acdac15b84f81fd9515b2aff
-- 
2.29.1.341.ge80a0c044ae-goog

