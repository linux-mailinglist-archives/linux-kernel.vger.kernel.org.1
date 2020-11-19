Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A002B9BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 20:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgKSTxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 14:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbgKSTxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 14:53:03 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CB3C0613CF;
        Thu, 19 Nov 2020 11:53:02 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id u22so1684755qtw.4;
        Thu, 19 Nov 2020 11:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7S/5MWDMjdajarfdTqOLA2n8yq2i+b3zMxZHmMoo6Rs=;
        b=Vn4OOjo2ycsAqPRthUzLIMNPySfRsUiUG8Ff3APPVrpbtUTfXBoMsMMaCLio3YkWO4
         Lxr9NmGbodiRW+mz21tkbswW/qr1Ng2+3CM+Kl6Eegb82iUgoB/zfO1jzcvZNI///oF/
         FI1Sc4H0CML0kP7bRd0q9VFiMwuiB4k3KY4pcj/YZ/63JBGBPBbY8G+04TLEVu29UdDB
         +LPIZtrkmw+//AWUzE63egh2rPnn0s7bPqCdZ2u36XuUU67lVPa1ZnPkvnO2XpJFPirV
         FBFLgrwCcq6KcJDh5Ch6zcrQEM1OAFc8+huLrsCXy4oLWRtkO0HX8KSDHR4d9tMfRhTy
         rP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7S/5MWDMjdajarfdTqOLA2n8yq2i+b3zMxZHmMoo6Rs=;
        b=lw7a9svB1ceSnZ/JbcjOwyUMZs6Mq4ofreTLt59LiFwi4fcHC6t7jpcCCaO6gCqcaL
         jr3w/7tNT1bQeHTwjxWbF81QUcJF6J4NKb+XwAhgOGgyJDG9W4mZJWBv3vdpdpPMYFSX
         69C2oAgm4VDGj7heRheQf9FMiBMaYKySxaorrfd8mog+id05fPfMw8J4XBhoC8SqRvgh
         iuLaRaAmy0JCd+gkmFuFwtY7rtuqJkqSxdJki0Fm9QGeU9LITDVggOauy4CdeMmCUjAE
         cXoL1xatKH25ZwcS2Iqew842Eon4eNnXABX/3oqlS+YPLtjM6O0OMoYHwWWKZayos7Ik
         LHqw==
X-Gm-Message-State: AOAM533YugPF9vi51dyfMRGx8JXuc7T9ClFH7dUqmWvdZ1xZwDV6i1RA
        bZdUlbZj8RXe/hPfvUc25Do=
X-Google-Smtp-Source: ABdhPJzJlw02fSuUlPACTULyiASbsbyRFTNoZ09SU20Km5FiDjnoIpSNh24UAi417JrqZEN1Xqbfwg==
X-Received: by 2002:ac8:6d03:: with SMTP id o3mr12953600qtt.305.1605815581413;
        Thu, 19 Nov 2020 11:53:01 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id h26sm566543qkh.127.2020.11.19.11.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 11:53:00 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] memory: tegra30-emc: Remove unnecessary of_node_put in tegra_emc_probe
Date:   Thu, 19 Nov 2020 12:52:44 -0700
Message-Id: <20201119195244.1517236-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/memory/tegra/tegra30-emc.c:1275:15: warning: variable 'np' is
uninitialized when used here [-Wuninitialized]
                of_node_put(np);
                            ^~
drivers/memory/tegra/tegra30-emc.c:1269:24: note: initialize the
variable 'np' to silence this warning
        struct device_node *np;
                              ^
                               = NULL
1 warning generated.

There does not need to be an of_node_put call in this error handling
block after the shuffling of the np assignment. Remove it so there is
no use of uninitialized memory.

Fixes: 5e00fd90183a ("memory: tegra30-emc: Continue probing if timings are missing in device-tree")
Link: https://github.com/ClangBuiltLinux/linux/issues/1203
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/memory/tegra/tegra30-emc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 3488786da03b..93f9002d32ad 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -1271,10 +1271,8 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	int err;
 
 	emc = devm_kzalloc(&pdev->dev, sizeof(*emc), GFP_KERNEL);
-	if (!emc) {
-		of_node_put(np);
+	if (!emc)
 		return -ENOMEM;
-	}
 
 	emc->mc = devm_tegra_memory_controller_get(&pdev->dev);
 	if (IS_ERR(emc->mc))

base-commit: 5e00fd90183ab0103b9f403ce73cb8407ebeb145
-- 
2.29.2

