Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE87B22FD36
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 01:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgG0XZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 19:25:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:64301 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728621AbgG0XZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:25:27 -0400
IronPort-SDR: HmUWTz+ZV2E1mnBdL3nQjhmmfdbqFT5myWMbLlSvtDd+fi164dOxpwu+DmyRLW31AXlAdkLblc
 NS9R2GZf/DcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="148991034"
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; 
   d="scan'208";a="148991034"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 16:25:26 -0700
IronPort-SDR: I5hFIpPRz/MeeKxICmXiippEuDFNU0wUnicuq5fVYa6zq9TQWr0NVMUAkCrQmKnDWq7igeBT8H
 C/gGqr5NAhng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; 
   d="scan'208";a="434114739"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Jul 2020 16:25:24 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k0CUl-00025h-Fv; Mon, 27 Jul 2020 23:25:23 +0000
Date:   Tue, 28 Jul 2020 07:24:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chun-Hung Wu <chun-hung.wu@mediatek.com>
Cc:     kbuild-all@lists.01.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] mmc: mediatek: msdc_cqe_disable() can be
 static
Message-ID: <20200727232451.GA16371@cc981e2e651b>
References: <202007280704.Sbr6LVoE%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007280704.Sbr6LVoE%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 88bd652b3c74 ("mmc: mediatek: command queue support")
Signed-off-by: kernel test robot <lkp@intel.com>
---
 mtk-sd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 734e403a142e4..4e2583f69a631 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2266,7 +2266,7 @@ static void msdc_cqe_enable(struct mmc_host *mmc)
 	msdc_set_timeout(host, 1000000000ULL, 0);
 }
 
-void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
+static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
 {
 	struct msdc_host *host = mmc_priv(mmc);
 
