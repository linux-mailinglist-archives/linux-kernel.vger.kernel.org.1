Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336C52CD2A6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 10:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387863AbgLCJfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 04:35:30 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:37296 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgLCJf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 04:35:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 90BAE2344E90;
        Thu,  3 Dec 2020 17:34:28 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Tn3TO5nzTCrS; Thu,  3 Dec 2020 17:34:28 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 7585F20001F5;
        Thu,  3 Dec 2020 17:34:28 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 6B80CC019FF;
        Thu,  3 Dec 2020 17:34:28 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 6E69C200756; Thu,  3 Dec 2020 17:34:28 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Jack <jack.lo@gtsys.com.hk>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Krishna Konda <kkonda@codeaurora.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mmc: core: MMC_CAP2_HS200_1_8V_SDR with mmc-hs400-1_8v
Date:   Thu,  3 Dec 2020 17:33:29 +0800
Message-Id: <20201203093338.10480-4-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201203093338.10480-1-chris.ruehl@gtsys.com.hk>
References: <20201203093338.10480-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of an independent hs400 timing select,
PATCH 2/3 the availability of the hs200 caps will not checked.
Therefore cleanup and remove MMC_CAP2_HS200_1_8V_SDR /
MMC_CAP2_HS200_1_2V_SDR from host->caps2 when mmc-hs400-1_8v
or mmc-hs400-1_2v is used in the dts.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 drivers/mmc/core/host.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 96b2ca1f1b06..46fde60a2372 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -295,9 +295,9 @@ int mmc_of_parse(struct mmc_host *host)
 	if (device_property_read_bool(dev, "mmc-hs200-1_2v"))
 		host->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
 	if (device_property_read_bool(dev, "mmc-hs400-1_8v"))
-		host->caps2 |= MMC_CAP2_HS400_1_8V | MMC_CAP2_HS200_1_8V_SDR;
+		host->caps2 |= MMC_CAP2_HS400_1_8V;
 	if (device_property_read_bool(dev, "mmc-hs400-1_2v"))
-		host->caps2 |= MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200_1_2V_SDR;
+		host->caps2 |= MMC_CAP2_HS400_1_2V;
 	if (device_property_read_bool(dev, "mmc-hs400-enhanced-strobe"))
 		host->caps2 |= MMC_CAP2_HS400_ES;
 	if (device_property_read_bool(dev, "no-sdio"))
-- 
2.20.1

