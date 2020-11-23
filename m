Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199E42C110A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgKWQss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732619AbgKWQsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:48:47 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF88FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:48:46 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id 7so24278631ejm.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z/tF5poT76lVimYwOBAMGxXGQWVzbrYoEj53HUWsOIQ=;
        b=XE29xlhnR6VK47kfP2UO7XOGjZc95xrkhMFuB9aze8DpKy+ZzVVVjchWEcRx+bpbOh
         vOR6BOubVDszynkgo+QwJHXJJZEsF1tzUoY2V9s98hUpm3C9DyPIzeUX3AUJ/4M9i1Zh
         7LumduBuxX6RzETPjMHMiqDQLKX3rE6OnnmYWu/cNB+hAf2j3cF4bSi1+IZOO53K14HE
         90QTrT2TLR7mUSuEyI2inhG3fL4TxVVc1F5wH/Z561XUdeMdb+zBP++XIfFKyVhcbftF
         1DKapC2+RfXA5rwlQwz9oIAGlpT23XgY1i+iNmCs74u1n0omKo5erv88pNtb+QdSnAiw
         TE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z/tF5poT76lVimYwOBAMGxXGQWVzbrYoEj53HUWsOIQ=;
        b=SabAUbg5p2fScyiXYU+ANOV4BaEx5E2beOYqIFMmiKXHs4yMiXv83UqxnwshuTIa5/
         wo7mXLVWPhtgOQfqIyoOBhwbQiy2xbeonqTp4ERoPRvnqFgHlfU+7Q/dusxXK1vV+gT3
         fP7XjrJJHFAJrQUuGZiA1SCj7CyaOi3ATA5WXCpBDASkCSrd8KDSHxpZvDP8APRTHBJH
         QIIAjcMuRNrZm8X6kVbNHhs81HrpH4s6gPUM7jqOzZ6EnIQ+OMolJfFRyqsL9W3vH7Y5
         5VMkRiKLJJT7ACZtn3XJYpVtceWnu7+RKH7QHYBpEEdnWIEBZV/DiaMLuCtxOObz6+Nk
         9w5w==
X-Gm-Message-State: AOAM533TbrhPovyW1CXZIXs33wJZ6NolUEY6YpGDtf00kPwibjTQt0On
        vKKA8/BkFg/SgHvhAvnGaN8=
X-Google-Smtp-Source: ABdhPJz0S4XP158KUp4NR9HLz1Nz+81qbFwfL2WNPHRGre7Vd7Gru9NFd68ZAKq/aYAb/oOwGJPqHA==
X-Received: by 2002:a17:906:b292:: with SMTP id q18mr434808ejz.93.1606150125565;
        Mon, 23 Nov 2020 08:48:45 -0800 (PST)
Received: from yoga-910.localhost ([188.25.2.177])
        by smtp.gmail.com with ESMTPSA id a8sm5442241edb.71.2020.11.23.08.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 08:48:44 -0800 (PST)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     laurentiu.tudor@nxp.com, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH] bus: fsl-mc: simplify DPRC version check
Date:   Mon, 23 Nov 2020 18:48:39 +0200
Message-Id: <20201123164839.1668409-1-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Because the minimum supported DPRC version is 6.0, there is no need to
check for incompatible 6.x versions lower to the minimum one.  Just
remove the second half of the check to simplify the logic.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 91dc015963a8..68488a7ad0d6 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -670,9 +670,7 @@ int dprc_setup(struct fsl_mc_device *mc_dev)
 		goto error_cleanup_open;
 	}
 
-	if (major_ver < DPRC_MIN_VER_MAJOR ||
-	    (major_ver == DPRC_MIN_VER_MAJOR &&
-	     minor_ver < DPRC_MIN_VER_MINOR)) {
+	if (major_ver < DPRC_MIN_VER_MAJOR) {
 		dev_err(&mc_dev->dev,
 			"ERROR: DPRC version %d.%d not supported\n",
 			major_ver, minor_ver);
-- 
2.28.0

