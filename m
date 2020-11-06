Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F342A8CC1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgKFC2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgKFC2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:28:07 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946DBC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 18:28:06 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id f21so1724989plr.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 18:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kxtn2tv4u7bnPJ1IBZRdbU16YLLAD3BvCHIEx+fGmCc=;
        b=RtjEQNH+ub9yP3HG5/0wESf0GkMMsrWd5B9RNqMCieK5gQb7I/lJ1roDbJeqfFtQEs
         jSiZR7s5D0LlvApzIULrfWNteZNka3Af6HF2iTHLSiwT2xK4cySGnza7N70fyy8amRjc
         P9BfYpZpGobcBtRABvCTNTMHjgH2DLr8/4ekiLMEk5jwmGMdN2l231QpJYzaUe1idy8t
         osXwYskw3ZTXkTLuVN2oEO0ACPXWjQ8ILvsCFftWtcWPVfIkL5Z2W9hH5fNRfldpqMXX
         HtiIjRfGBJoaPJFoghqTZ/f9+X7+EiqsiEQjfTZmZ1jRZ8qc9pIK7+bO8e2L9Uh/oFv0
         RlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kxtn2tv4u7bnPJ1IBZRdbU16YLLAD3BvCHIEx+fGmCc=;
        b=cZ0g8vfd4TdDsVPqivqSjxz0B4gc1UMySOKGuFLeOZFwqYMXyAo3U5mZ34nPD/laAh
         DbF/Y9icsjE37xCL4awRzasE5XLSDDZgqsBfrD4tO6DIHRZeFao/geF6WfdS1cp67QPN
         1H4N/uC1ksl016VZtUWEF9UoKkqzxaJaZSBbYrReTxBflk3f0lfRildDW568dC6GwH6V
         ex+fD1cmEz5LGRxRLm6x5SzRTZgzsHoTS2djE+KOmUgFaAq4sTXUhoC8ZWHtSmHQqXlu
         tiKkRPEmeJpQhEzz1sPpsJw4Wa2V4D4TfdFkwfdRsHmHFjAAb/7EBSZN7BXDe6A7mxrk
         CMfA==
X-Gm-Message-State: AOAM53149pgD70UEV6tth/ZBN4SjU8kje9F84QeF6A1erhEtte5gKROU
        X/VveVr4VMwrShZY5b+nyzCn3A==
X-Google-Smtp-Source: ABdhPJzh6FMka8y/xFkLHA4CPWwTsQ+mA0zVxRKA9lvNgc5K/xiYnUMj7ZPlLmdkpGArWPM03lPE2g==
X-Received: by 2002:a17:902:aa47:b029:d6:ac0f:fe76 with SMTP id c7-20020a170902aa47b02900d6ac0ffe76mr7462plr.42.1604629686096;
        Thu, 05 Nov 2020 18:28:06 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:28:05 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 03/27] mmc: core: UHS-II support, skip set_chip_select()
Date:   Fri,  6 Nov 2020 11:27:02 +0900
Message-Id: <20201106022726.19831-4-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmc_set_chip_select() should be called only in UHS-II mode,
and not for UHS-II mode.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/core/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5541ed956c4d..4e12bd98fc08 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -898,8 +898,10 @@ static inline void mmc_set_ios(struct mmc_host *host)
  */
 void mmc_set_chip_select(struct mmc_host *host, int mode)
 {
-	host->ios.chip_select = mode;
-	mmc_set_ios(host);
+	if (!(host->flags & MMC_UHS2_INITIALIZED)) {
+		host->ios.chip_select = mode;
+		mmc_set_ios(host);
+	}
 }
 
 /*
-- 
2.28.0

