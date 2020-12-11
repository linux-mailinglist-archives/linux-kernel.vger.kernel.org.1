Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959B22D77AB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 15:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405993AbgLKOS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 09:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405932AbgLKOSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:18:10 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DE0C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:17:30 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id y19so13484214lfa.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=11tRxXmcRL83hT4n8MDtkMiTQdUv9JJoYgN481wECQI=;
        b=k0kUp77H54YOwO3WS2omVR2voAv6qo8ArgdgCMds49n1YSaD7GuIp8Kp7JYvox+ClU
         DR2B+zlfdwqMuJbwVnlT3UYxRTQVPbCT/1IudphcxguNGX0XfRvxUGX+lJHHqRxxWvve
         VhfKecBaBaOFnzng8IdpkNxVTUzQn2gOfzl8QF0ntIlEZ/Eqj0DujouJUjbXEizlXkrM
         LrHOaJroY+22897sBE3zIQk/FuAhf3rUjjUc65Byd7Ss3LciH+mxsh3O5ikkk9hmSzyK
         VjEBpqF8er+25VhF6ZJJ1i7cder4kvsywh+1ihQLjaekPzWFoBFaDtM5CA/ea1XLGoIS
         yGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=11tRxXmcRL83hT4n8MDtkMiTQdUv9JJoYgN481wECQI=;
        b=kLVrK6keO9OdH/JahfGQVLWvBtkwgcjkTMSJhrMoh35o5jAeUF8PvF8CteCaZbtDWS
         i8qObOZgHfC+6QS/lSkRh8m/sLjtDJv8OfSdUPKco+VQa1VINbxpbe0YLBMHcWNdvmYo
         GyxhJDE9g10STHd1M3ct89W+U+kDgdil6wAr9f1JKBHrz4bUzjqB1xXVScWSSzKyUsl0
         EtTyOWjGYWTU1TytAoFUnUDSd5rXsiT0vwVQphFF+2WU3A+SZz0yk/beQS429XFJ9Ucp
         5OB9dniIRe21hinBZW5dab09qpNBBuxr7MnRB/E9UI5b1cstSvaELVV6ABHIfIRL8SeS
         pP4A==
X-Gm-Message-State: AOAM533VGJnjsVH6is1m92iN3mMXvqU7GhzlZWcPeNI3Vv0+pq+V7aoV
        adjeGg82GJKfmiH+92q/61BLB3y3m8+Z/Ml/
X-Google-Smtp-Source: ABdhPJwtKCFc4Mm8+N3WHfMuoJAo+6NALou7GDnjewzGye7r3r4uJGEcXCbgK6gp0u5VMiYIWQ+l4w==
X-Received: by 2002:ac2:48b2:: with SMTP id u18mr4917512lfg.313.1607696248053;
        Fri, 11 Dec 2020 06:17:28 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id q16sm903019lfb.8.2020.12.11.06.17.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Dec 2020 06:17:27 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, huziji@marvell.com,
        adrian.hunter@intel.com, jaz@semihalf.com, tn@semihalf.com,
        kostap@marvell.com, Alex Leibovich <alexl@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>, stable@vger.kernel.org
Subject: [PATCH] mmc: sdhci-xenon: fix 1.8v regulator stabilization
Date:   Fri, 11 Dec 2020 15:16:56 +0100
Message-Id: <20201211141656.24915-1-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Leibovich <alexl@marvell.com>

Automatic Clock Gating is a feature used for the power
consumption optimisation. It turned out that
during early init phase it may prevent the stable voltage
switch to 1.8V - due to that on some platfroms an endless
printout in dmesg can be observed:
"mmc1: 1.8V regulator output did not became stable"
Fix the problem by disabling the ACG at very beginning
of the sdhci_init and let that be enabled later.

Fixes: 3a3748dba881 ("mmc: sdhci-xenon: Add Marvell Xenon SDHC core functionality")
Signed-off-by: Alex Leibovich <alexl@marvell.com>
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Cc: stable@vger.kernel.org
---
 drivers/mmc/host/sdhci-xenon.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index c67611fdaa8a..4b05f6fdefb4 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -168,7 +168,12 @@ static void xenon_reset_exit(struct sdhci_host *host,
 	/* Disable tuning request and auto-retuning again */
 	xenon_retune_setup(host);
 
-	xenon_set_acg(host, true);
+	/*
+	 * The ACG should be turned off at the early init time, in order
+	 * to solve a possile issues with the 1.8V regulator stabilization.
+	 * The feature is enabled in later stage.
+	 */
+	xenon_set_acg(host, false);
 
 	xenon_set_sdclk_off_idle(host, sdhc_id, false);
 
-- 
2.29.0

