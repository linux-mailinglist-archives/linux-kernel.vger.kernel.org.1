Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B702EEAC2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 02:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbhAHBLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 20:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbhAHBLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 20:11:39 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA071C0612FE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 17:10:30 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x18so4805938pln.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 17:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xxRssKJ9dAC1Cxvvi5KyIPIbeBOqG6VrSD6Gdw3ud3Y=;
        b=n0zubLTLrm2Wv7t/owFX7AFemCfdq4PFQy8VbP2q+HzxunvaKkUrlYYCuvHcIKdlB/
         IzGTQT7lFsgeWUt4WseXOYynCHdwqzFEJunICyF+mzSmnnyz9AFQszAhyl100jUrQBM5
         wbBA5BwbE6dqbswU8n9ezNAp3SijeWFSFegg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xxRssKJ9dAC1Cxvvi5KyIPIbeBOqG6VrSD6Gdw3ud3Y=;
        b=I2yTLrcAhQHN9CAS2uSQgB65fbiv9XoXglgId+QM+IjS2rjIm+IytTlTCRtybCDFyw
         na82QmWDWutPG+zgAUiRe5caZHCl/t+Vu/odxlTRxVMZDD6Hy5/0S5wU5r+8Sb5NbeK5
         0xrOByXmNFR2Qp8/aPTpqhAs8bEhCwrbKuFGBQvPeCeFWZU9Q8STavUmc+sdBKJGlBnl
         ZRb6Ev5AsV6TjSmel54J3Nd3DmqfCy5JW8lPcOzX9dfIYSeCWii+HfFH9UlNOdiIJN7w
         4BIIcXcXbaqzM2nOIEGM33BlBLKYYrCIRKYWlKIELeJBaouj1tXLy64TBDpCAfgE0fqd
         JX2g==
X-Gm-Message-State: AOAM533R1cZdV/WoOzT6yCTDR1j0naS5OSYaorsTW+wX8Tc20MsWG21g
        y0MPqa+eUZ0LuSPKL23RMcqZ5w==
X-Google-Smtp-Source: ABdhPJxDJLhEExP7v8L1Yb3lej7+5pDFBeQ9kztKaACVW2NvEKvbWvqudR5ghwxWFFmhMX181+yCkg==
X-Received: by 2002:a17:90a:6f01:: with SMTP id d1mr1129382pjk.155.1610068230563;
        Thu, 07 Jan 2021 17:10:30 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id s1sm6400083pfb.103.2021.01.07.17.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 17:10:30 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     fshao@chromium.org, hoegsberg@chromium.org, hsinyi@chromium.org,
        boris.brezillon@collabora.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v9 4/4] drm/panfrost: Add mt8183-mali compatible string
Date:   Fri,  8 Jan 2021 09:10:11 +0800
Message-Id: <20210108091005.v9.4.I5f6b04431828ec9c3e41e65f3337cec6a127480d@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20210108011011.4061575-1-drinkcat@chromium.org>
References: <20210108011011.4061575-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MT8183's G72 Bifrost.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Reviewed-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

(no changes since v7)

Changes in v7:
 - Fix GPU ID in commit message

Changes in v6:
 - Context conflicts, reflow the code.
 - Use ARRAY_SIZE for power domains too.

Changes in v5:
 - Change power domain name from 2d to core2.

Changes in v4:
 - Add power domain names.

Changes in v3:
 - Match mt8183-mali instead of bifrost, as we require special
   handling for the 2 regulators and 3 power domains.

 drivers/gpu/drm/panfrost/panfrost_drv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 83a461bdeea8..ca07098a6141 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -665,6 +665,15 @@ static const struct panfrost_compatible amlogic_data = {
 	.vendor_quirk = panfrost_gpu_amlogic_quirk,
 };
 
+const char * const mediatek_mt8183_supplies[] = { "mali", "sram" };
+const char * const mediatek_mt8183_pm_domains[] = { "core0", "core1", "core2" };
+static const struct panfrost_compatible mediatek_mt8183_data = {
+	.num_supplies = ARRAY_SIZE(mediatek_mt8183_supplies),
+	.supply_names = mediatek_mt8183_supplies,
+	.num_pm_domains = ARRAY_SIZE(mediatek_mt8183_pm_domains),
+	.pm_domain_names = mediatek_mt8183_pm_domains,
+};
+
 static const struct of_device_id dt_match[] = {
 	/* Set first to probe before the generic compatibles */
 	{ .compatible = "amlogic,meson-gxm-mali",
@@ -681,6 +690,7 @@ static const struct of_device_id dt_match[] = {
 	{ .compatible = "arm,mali-t860", .data = &default_data, },
 	{ .compatible = "arm,mali-t880", .data = &default_data, },
 	{ .compatible = "arm,mali-bifrost", .data = &default_data, },
+	{ .compatible = "mediatek,mt8183-mali", .data = &mediatek_mt8183_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
-- 
2.29.2.729.g45daf8777d-goog

