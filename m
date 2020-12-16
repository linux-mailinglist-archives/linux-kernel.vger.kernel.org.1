Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E1E2DC049
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 13:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgLPM1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 07:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLPM1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 07:27:53 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C156C061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 04:27:12 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id h205so4335534lfd.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 04:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NlkdKrDzJvW8dj27dCDKyFQHFw0nTmtHbFxqUcIKWA0=;
        b=pRFwY7myfSQXhI2lzMsKwsRSETQKUEbExLsNegZaFAZ23q02lusDmgpYJmkMmjPWbm
         qoF39+uaLxIxKr4prrBoZRaYvfjsu8yfso2vpHdm33mO9xl56D1FsDdRfxu9FiQCf8MT
         OjoAwJL0aXUbqY9GyfJ/Np53uH9791RhA2av9/RnKSMaVpR6ceWbbmNEgxmmyVvOgSby
         YbKiYDzwZ20eN8Plh51WC9BlivlWmunZs7ILYqUqQ7C0WXD1zsoIzR1v3NB/9L8BCOC8
         jcPxpbfw1jFsLkvk1kGxUrwGnhkrsssv3hcAiT2gpkUTMx+RtrQYmma4SRIS3+tvLGKK
         zE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NlkdKrDzJvW8dj27dCDKyFQHFw0nTmtHbFxqUcIKWA0=;
        b=QER+MdMZaVS6XnS2h1MRfZSIM+baC4S+GHB4TkNRcEElrCDmSO1v+XpoAQvx4v2Kjt
         DbhyI73GOdIlBuy5IhZSCiI8nUKxocXerQ+yEVufe7lEnsY9qn0kvvFIFCUvtp+24MA/
         lhfnH1B+ex651iSBzzbZsY2Qbu1GBVWtRIyok6eDLr6ZZiGdIwA1IRdRJC74pmLpvgdF
         bCjcuVQqXpCpoO4mhItZt8Xxfj4/6CHnJJUMFlEusnUWcn0qGDR8GA1Bo/gZUI6lg8gU
         EzJ6iU10Xi53qqif20J4AzWXRheCfyJH2r0pCArgRRshEU5OqDGTSNd0N3yskIOyVdZW
         59AA==
X-Gm-Message-State: AOAM532LYtR9fDGIT6zIvez/5cGsYWhTlJQMnLy6fCtY+uTbq339UuZ4
        1wPUncrtyTb1w/sCAbbu3Io=
X-Google-Smtp-Source: ABdhPJzuHtAuGKFrbqvNY8HG4xWVr5snTjE3uD0EitFoPXhQ+abO1kzcCNozYVgO+Wbh07bZqjV6yg==
X-Received: by 2002:a2e:a36a:: with SMTP id i10mr6004463ljn.342.1608121630659;
        Wed, 16 Dec 2020 04:27:10 -0800 (PST)
Received: from localhost.localdomain (host-81-190-219-224.dynamic.mm.pl. [81.190.219.224])
        by smtp.googlemail.com with ESMTPSA id w13sm264740ljw.28.2020.12.16.04.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 04:27:10 -0800 (PST)
From:   Vasyl Gomonovych <gomonovych@gmail.com>
To:     ssantosh@kernel.org
Cc:     Vasyl Gomonovych <gomonovych@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: ti: knav_qmss: Put refcount for dev node in failure case
Date:   Wed, 16 Dec 2020 13:26:52 +0100
Message-Id: <20201216122652.5825-1-gomonovych@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for_each_child_of_node increases refcount for each device_node and decreases previous one
in a loop, but in case jump out of a loop current node refcount has no chnase for decreases
so requires an of_node_put for jupm out cases.

Fix based on raport from
scripts/coccinelle/iterators/for_each_child.cocci

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 drivers/soc/ti/knav_dma.c        | 1 +
 drivers/soc/ti/knav_qmss_queue.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index 8c863ecb1c60..9d25546e4d96 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -757,6 +757,7 @@ static int knav_dma_probe(struct platform_device *pdev)
 	for_each_child_of_node(node, child) {
 		ret = dma_init(node, child);
 		if (ret) {
+			of_node_put(child);
 			dev_err(&pdev->dev, "init failed with %d\n", ret);
 			break;
 		}
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index a460f201bf8e..f9fc639abad2 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1086,6 +1086,7 @@ static int knav_queue_setup_regions(struct knav_device *kdev,
 	for_each_child_of_node(regions, child) {
 		region = devm_kzalloc(dev, sizeof(*region), GFP_KERNEL);
 		if (!region) {
+			of_node_put(child);
 			dev_err(dev, "out of memory allocating region\n");
 			return -ENOMEM;
 		}
@@ -1399,6 +1400,7 @@ static int knav_queue_init_qmgrs(struct knav_device *kdev,
 	for_each_child_of_node(qmgrs, child) {
 		qmgr = devm_kzalloc(dev, sizeof(*qmgr), GFP_KERNEL);
 		if (!qmgr) {
+			of_node_put(child);
 			dev_err(dev, "out of memory allocating qmgr\n");
 			return -ENOMEM;
 		}
@@ -1498,6 +1500,7 @@ static int knav_queue_init_pdsps(struct knav_device *kdev,
 	for_each_child_of_node(pdsps, child) {
 		pdsp = devm_kzalloc(dev, sizeof(*pdsp), GFP_KERNEL);
 		if (!pdsp) {
+			of_node_put(child);
 			dev_err(dev, "out of memory allocating pdsp\n");
 			return -ENOMEM;
 		}
-- 
2.17.1

