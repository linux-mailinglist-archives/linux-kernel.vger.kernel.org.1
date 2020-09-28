Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D85B27A5C6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 05:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgI1Dbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 23:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI1Dbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 23:31:40 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB0AC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 20:31:40 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k13so8097712pfg.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 20:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N/EpoZQfstu+PtLpJpKosc5sDI8cNsjHAqKjuh09dpU=;
        b=TPnACvqkAuZKzWjdeh9nwNFuQlDeml7iNwfm7yiuUMD+fLPKDKiPV0d3OUxkF/4nwv
         YOJkoUckvY6C5DCSyiXEGg3vqREv67TrjRFIQE1BZBezidWKQ63ALmygtJhiX5bbMOeX
         IUrlHOhAv38J+fNOK5OpVSZth44dtAChBiCSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N/EpoZQfstu+PtLpJpKosc5sDI8cNsjHAqKjuh09dpU=;
        b=JOAmpqFMLPQAkVdBLTg1m1fBC1vcNhEfOvyi2zSFVNOaMjiiT/a4Oi2LZZ98MB46aI
         h6lFHp3Rk+SSJmRsVZntMMTVAt7DXFWGvkRu2DyPQ74WzvL/ikoKoYvOsnEd3VgrLNfs
         W0bYCibL1t9zWoTCLJQCe+zA6TlGgGvxdmTyt1zl1Oga3x3oqAY5E45Mk5b7Jc7EITXz
         pEdm65BgzjD9FYzTkfdKhdNdYkSa3wN8gFoxLut/N/7RFwSYvPhT/YYlizTDeaB80ldT
         wEJ90uzsP3kgEZUiwM6PbhzFtGEu2saujPqaZ6lCGfYTxWWd7f1FcBC5xw6uFLSSlzgy
         G0JA==
X-Gm-Message-State: AOAM530Z/JR2KduM/gRF1Zczs6N7WFbze3JJIbc/nIOYc+bOIcAiIajj
        XyMagCLKX5HK34Vjuc+PXxkQww==
X-Google-Smtp-Source: ABdhPJzTJGzCeQ9lvnJeSH23CAuBjJ+xu7mtkCHRt4CPpwRzS5FlrwfY9s2qHfFca9qJY+TDrd/WXA==
X-Received: by 2002:aa7:8249:0:b029:142:2501:34db with SMTP id e9-20020aa782490000b0290142250134dbmr9395510pfn.52.1601263900127;
        Sun, 27 Sep 2020 20:31:40 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id z8sm8201440pgr.70.2020.09.27.20.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 20:31:39 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2] soc: mediatek: Check if power domains can be powered on at boot time
Date:   Mon, 28 Sep 2020 11:31:35 +0800
Message-Id: <20200928113107.v2.1.I5e6f8c262031d0451fe7241b744f4f3111c1ce71@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the error case, where a power domain cannot be powered on
successfully at boot time (in mtk_register_power_domains),
pm_genpd_init would still be called with is_off=false, and the
system would later try to disable the power domain again, triggering
warnings as disabled clocks are disabled again (and other potential
issues).

Also print a warning splat in that case, as this should never
happen.

Fixes: c84e358718a66f7 ("soc: Mediatek: Add SCPSYS power domain driver")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

Changes in v2:
 - Add WARN_ON if the domain can't be powered on, to make it more
   obvious that this should not happen (there is already an error
   message).

 drivers/soc/mediatek/mtk-scpsys.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index f669d3754627..ca75b14931ec 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -524,6 +524,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
 	for (i = 0; i < num; i++) {
 		struct scp_domain *scpd = &scp->domains[i];
 		struct generic_pm_domain *genpd = &scpd->genpd;
+		bool on;
 
 		/*
 		 * Initially turn on all domains to make the domains usable
@@ -531,9 +532,9 @@ static void mtk_register_power_domains(struct platform_device *pdev,
 		 * software.  The unused domains will be switched off during
 		 * late_init time.
 		 */
-		genpd->power_on(genpd);
+		on = !WARN_ON(genpd->power_on(genpd) < 0);
 
-		pm_genpd_init(genpd, NULL, false);
+		pm_genpd_init(genpd, NULL, !on);
 	}
 
 	/*
-- 
2.28.0.681.g6f77f65b4e-goog

