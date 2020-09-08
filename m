Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E85261F7C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 22:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbgIHUEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 16:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730415AbgIHPXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:23:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61861C09B050
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 08:19:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so19539189wrx.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 08:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O5HUPZey23fpZ7O0ISBcnmoDeQoSvAOa5PK6DE6zp90=;
        b=ORyY4ZqfDcrdXYjsjTXTEtrUaQe1RJldbGO+pqANb858Ya+JjB4iH1ncEJwkByFE3d
         cvYPX+8JBt8+2Wov00EdDqAMHvKSEsRwmOVae7HKFzAi8a9LM7+VE9WE6w4pARa9Ox1x
         /ahRnbLC4gcZoGEORtUuxneW2DLP1pdu8Ol/m53qs6fnlTkDYEodVKtywKTDBQzApoU1
         GQlb0LTW7BmwiHtiu2r/3kR4FFdu4bFblA3jYjH2vVIAP3WNcxTFgYY3IKzl4j7ojkEK
         mYooRqXepx9HdE+veBwBnbnNIubUixtUQd1iCTaBJhk1jxmYyWfkQCIc1ZTaHlMQiRg+
         ITOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O5HUPZey23fpZ7O0ISBcnmoDeQoSvAOa5PK6DE6zp90=;
        b=OfGPj69P3sETtpmQ2ereAdXRpnxWjkzpe9ZY1UQQiY+rZfSrApKnc0Iq5KrdR57grg
         Ez6JwTJC3G45+S/1MHEsCxKeV/zfz/srkXENpRn0jCrue/kw7cem9OCNdaAOw71aB24E
         dJEZvbVq8RdvfHNL+m4WC3etVP8faHl5OS+kIbWpICU+uuEkIkKARENHT05re972Q40i
         SUktN1hcoywQso3iQ9DOZd//jbMFEut7p24b5pnxkyJNI39tWcQIta3Em81u7SLKrF8N
         ZptP9X6FDMgKRTPBsr3Xlb7iWk590OdJH4qvulTlnSjl/LrNbH2CrGpSFbVjww8gZw/K
         QL+A==
X-Gm-Message-State: AOAM53186Xw3ve0KMpcLGC7qjD0hVWKR9QBGoRy3joNDQgIQRmzVv24Y
        gSuGik58sLIXwmmaJViojZzddA==
X-Google-Smtp-Source: ABdhPJzcrzBmN5nUV5nRaVbaFFXi/hKg4wRQw/mW6OU7rGvxpIpYuoFbrS9YqopA0v/jdvJCmxWXjQ==
X-Received: by 2002:a5d:67d2:: with SMTP id n18mr119063wrw.223.1599578340777;
        Tue, 08 Sep 2020 08:19:00 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id d25sm10004886wra.25.2020.09.08.08.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 08:19:00 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/5] drm/panfrost: add support specifying pgtbl quirks
Date:   Tue,  8 Sep 2020 17:18:50 +0200
Message-Id: <20200908151853.4837-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200908151853.4837-1-narmstrong@baylibre.com>
References: <20200908151853.4837-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a pgtbl_quirks entry in the compatible specific table to permit specyfying IOMMU
quirks for platforms.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.h | 3 +++
 drivers/gpu/drm/panfrost/panfrost_mmu.c    | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 953f7536a773..2cf1a6a13af8 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -70,6 +70,9 @@ struct panfrost_compatible {
 	int num_pm_domains;
 	/* Only required if num_pm_domains > 1. */
 	const char * const *pm_domain_names;
+
+	/* IOMMU quirks flags */
+	unsigned long pgtbl_quirks;
 };
 
 struct panfrost_device {
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index e8f7b11352d2..55a846c70e46 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -368,6 +368,7 @@ int panfrost_mmu_pgtable_alloc(struct panfrost_file_priv *priv)
 	mmu->as = -1;
 
 	mmu->pgtbl_cfg = (struct io_pgtable_cfg) {
+		.quirks = pfdev->comp ? pfdev->comp->pgtbl_quirks : 0,
 		.pgsize_bitmap	= SZ_4K | SZ_2M,
 		.ias		= FIELD_GET(0xff, pfdev->features.mmu_features),
 		.oas		= FIELD_GET(0xff00, pfdev->features.mmu_features),
-- 
2.22.0

