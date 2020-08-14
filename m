Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C36244E8F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 20:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgHNSug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 14:50:36 -0400
Received: from mail.manjaro.org ([176.9.38.148]:50836 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgHNSuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 14:50:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 922D7E1446;
        Fri, 14 Aug 2020 20:50:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XD5iMQt1uVXx; Fri, 14 Aug 2020 20:50:31 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH] mmc: mmc_spi: fix timeout calculation
Date:   Fri, 14 Aug 2020 20:50:11 +0200
Message-Id: <20200814185011.3252020-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the cycle timeout was converted to a microsecond value but
then incorrectly treated as a nanosecond timeout. This patch changes
the code to convert both the nanosecond timeout and the cycle timeout
to a microsecond value and use that directly.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 drivers/mmc/host/mmc_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 39bb1e30c2d7..f85e0ad896a9 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -882,9 +882,9 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 	else
 		clock_rate = spi->max_speed_hz;
 
-	timeout = data->timeout_ns +
+	timeout = data->timeout_ns / 1000 +
 		  data->timeout_clks * 1000000 / clock_rate;
-	timeout = usecs_to_jiffies((unsigned int)(timeout / 1000)) + 1;
+	timeout = usecs_to_jiffies((unsigned int)timeout) + 1;
 
 	/* Handle scatterlist segments one at a time, with synch for
 	 * each 512-byte block
-- 
2.28.0

