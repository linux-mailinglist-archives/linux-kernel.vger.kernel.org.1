Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE85A27DD72
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 02:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgI3Afq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 20:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgI3Afq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 20:35:46 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BFCC0613D0;
        Tue, 29 Sep 2020 17:35:45 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id o20so6533287pfp.11;
        Tue, 29 Sep 2020 17:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ieGK1piaFJ3x1ASrTXBWUe7WNEu41fomUmQ319XUfAE=;
        b=cYP6dVXNanrhoQbRMFkC7pgWEOb7q+vMr9eSN4XWX6HagPZa0wvlfWLzA8lupcwtLQ
         V/yoEtJFQc0kTloP6A1xP8yBzOJdcVKK5Z9m4dsv5KXqnUz88bQN5iXBda31HpDCb5HL
         wHI8YKMrgRI+SMHJFDhtfdsSH6KQ/PcmSNUJnwQFi0gCZJ7unpT7SdfqRCMSYy3nUQqj
         tP4U4MvpUTgaXpW09OzOLhTP59DyETshquEFbu2mNAEjrIKRPMq0ff0vAikVdtUdXSh1
         296EggXRHUSldGpN2NfQAB+1ERoYKZDVa5sqkJzLEBZmPaLAodaft02H+ICGMdPMx71M
         zXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ieGK1piaFJ3x1ASrTXBWUe7WNEu41fomUmQ319XUfAE=;
        b=HFuPwRxYoXIJ9HQ2myCfzl+35aSdrjZ+FlV+DFHxGePCD1WQaS0PFLxlqN+qbrrFmy
         IxykAmtKt/MqeHgnzpoDFlG2zIcKnWjy/xlFAwblV2bt0OysgIgvsCXIVbg1oI42anRV
         X4o8W7wm1C4lvQhNXlPcWJmpPdhiqKoDuQ39tlm5hl77vknjuHLUdGsxck5BTjAuzNqO
         gnBjiANyqEfciXfyquANmo15fyTZQ2AHgFkMGVxRd6Q9aceIB6nBdbpoq7rhR2U0BzMo
         n6bgG8HXmyIfvWBUrc+LBJoT6ZQJZZMPsn4Zj4o4WYaFxpjOUg4ikb0FH3jpfVDtV2sY
         /ubw==
X-Gm-Message-State: AOAM532NdNfVZhZSE+YAlUzMnCskv5+G4mcZComdhfd1d53Ocjp2UFFX
        lYErAllZHFTQxa5+rhHpUxg=
X-Google-Smtp-Source: ABdhPJz3X5UmoZnmvzXt9ned7FDpg71Qagha65Tza0ya481tSpAeKXhOV1ieT6Vvsli7UvTn1d84xA==
X-Received: by 2002:a17:902:8643:b029:d1:920c:c1db with SMTP id y3-20020a1709028643b02900d1920cc1dbmr134821plt.42.1601426145485;
        Tue, 29 Sep 2020 17:35:45 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id x185sm6904738pfc.188.2020.09.29.17.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 17:35:45 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     thierry.reding@gmail.com, joro@8bytes.org, krzk@kernel.org,
        digetx@gmail.com
Cc:     vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] memory: tegra: Add helper function tegra_get_memory_controller
Date:   Tue, 29 Sep 2020 17:30:11 -0700
Message-Id: <20200930003013.31289-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930003013.31289-1-nicoleotsuka@gmail.com>
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can be used by both tegra-smmu and tegra20-devfreq drivers.

Suggested-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---

Changelog
v1->v2
 * N/A

 drivers/memory/tegra/mc.c | 23 +++++++++++++++++++++++
 include/soc/tegra/mc.h    |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index ec8403557ed4..09352ad66dcc 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -42,6 +42,29 @@ static const struct of_device_id tegra_mc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra_mc_of_match);
 
+struct tegra_mc *tegra_get_memory_controller(void)
+{
+	struct platform_device *pdev;
+	struct device_node *np;
+	struct tegra_mc *mc;
+
+	np = of_find_matching_node_and_match(NULL, tegra_mc_of_match, NULL);
+	if (!np)
+		return ERR_PTR(-ENOENT);
+
+	pdev = of_find_device_by_node(np);
+	of_node_put(np);
+	if (!pdev)
+		return ERR_PTR(-ENODEV);
+
+	mc = platform_get_drvdata(pdev);
+	if (!mc)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return mc;
+}
+EXPORT_SYMBOL_GPL(tegra_get_memory_controller);
+
 static int tegra_mc_block_dma_common(struct tegra_mc *mc,
 				     const struct tegra_mc_reset *rst)
 {
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 1238e35653d1..c72718fd589f 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -183,5 +183,6 @@ struct tegra_mc {
 
 int tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long rate);
 unsigned int tegra_mc_get_emem_device_count(struct tegra_mc *mc);
+struct tegra_mc *tegra_get_memory_controller(void);
 
 #endif /* __SOC_TEGRA_MC_H__ */
-- 
2.17.1

