Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8141227A1DC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 18:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgI0Qfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 12:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgI0Qfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 12:35:31 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4527C0613CE;
        Sun, 27 Sep 2020 09:35:30 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 197so6160848pge.8;
        Sun, 27 Sep 2020 09:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0C5Gjq9HDGphAUKTprSwLydq67owdjsJTm+aKkh5laY=;
        b=KjaYB/5G2q2kbCuTFvEezBi7+X8RrHgnqaOl7utkH819j1wnF47zRahvsmttOVk4k+
         PuqOqhWZBLffVp7cN0wDC8aj0EZCPtLzBc56N7B0V1ggr8637yuD0d3fz9eMwz3ijsGB
         RkrVTGUNeScMSz0FbaZOY8PjCRcYnVvtTOOi1oNpAJd5fm5SmN5dQXmAHmzFYnEa8P8W
         n53pxgi5XHRvrFR8IU1B6lQbUeC9ZrJpb+8oFx9F7ALq5p80sGCrpd/xvLpSK8il7NQ+
         BSj0yfjhCCn6C4+fZkq2tCOlqutkjqD2h3PSw8N/Zy0JuOE0uaQnXEzbZnR23mB84Mzi
         iK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0C5Gjq9HDGphAUKTprSwLydq67owdjsJTm+aKkh5laY=;
        b=H5J+Ja0+TXs9gseBcUzDqkin6DpPfgfndO3eY14NmGpYvMlwZt+FkGYWehG4pAUOIG
         Kc2BaSlDY7bsFBh09jpKks6FaSprLeCymXU2ztcPesNrczM7g1rs23FDNMxgX8pGKQPr
         vkIF4XI2BXkeIiY2a6JFyFS3Ol64lwxlLj+too3i0gSxhiNipAGTDYoGkN12vUlSJhXy
         KUFm/8kChdWmqCK0n/iMRNpKzS0gyWhGoXNFaPTc/FWo3rhEnzO2kN9DeJDx1QW9t2A+
         NwBQOO16AJiB9iqkXE6il51MXzwf1PZiahQXp7Y+pMN5OyttnOwoHw10YY0Lat5orPrr
         kNtw==
X-Gm-Message-State: AOAM531yYkvmlaaWQEvanIAkRIdzOpVsilHZXVr8OK2BoaI+Er6v77Sh
        kDRrVtz6gS5ccXJ3D7WM6ts=
X-Google-Smtp-Source: ABdhPJxi17BidG3zA7awFrVtAaRHMYW0KLI7H2kwkVNIrJNMAkLZF4LndDjyq4SfILAq4d4+5P7YTQ==
X-Received: by 2002:a63:e94a:: with SMTP id q10mr6233305pgj.189.1601224530512;
        Sun, 27 Sep 2020 09:35:30 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-95-82-187.san.res.rr.com. [70.95.82.187])
        by smtp.gmail.com with ESMTPSA id u15sm4635313pjx.50.2020.09.27.09.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 09:35:29 -0700 (PDT)
From:   Ryan Kosta <ryanpkosta@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     marvin24@gmx.de, p.zabel@pengutronix.de, ac100@lists.launchpad.net,
        linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Ryan Kosta <ryanpkosta@gmail.com>
Subject: [PATCH v2] Staging: nvec: nvec: fix double next comment
Date:   Sun, 27 Sep 2020 09:35:04 -0700
Message-Id: <20200927163504.7546-1-ryanpkosta@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
 * Made commit message more clear
 * Added description
Note: previous patch named
 "[PATCH] fix double next comment in drivers/staging/nvec/nvec.c"
>8------------------------------------------------------8<
Fixes a comment typo.

Signed-off-by: Ryan Kosta <ryanpkosta@gmail.com>
---
 drivers/staging/nvec/nvec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index 360ec040774..a80996b2f5c 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -289,7 +289,7 @@ EXPORT_SYMBOL(nvec_write_async);
  * interrupt handlers.
  *
  * Returns: 0 on success, a negative error code on failure.
- * The response message is returned in @msg. Shall be freed with
+ * The response message is returned in @msg. Shall be freed
  * with nvec_msg_free() once no longer used.
  *
  */
-- 
2.20.1

