Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA91926CD92
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 23:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgIPVBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 17:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgIPQaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:30:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CCBC0D9432
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:01:58 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z4so7302697wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yvushcHgW5x8Ci13qV/eVljqWihhBxbnLqYrlJGnnQM=;
        b=aIi8RU3GfifGkaYbMW1MYLTxAkS9nN6U2v50gcwQKZKksSLDZajirW7gQTn2LLnktm
         CyI0tpHPNTv19Qc5/cJj43pTaueffg0aGDYRumwLvKkRtOHUAMiREXV/heRedSuF6bWi
         NKtLgvbCgtSXb0fVCOqvyo4yoEHswt6g3uH95KDxuMtJ43vxcihOQoHgi+oi7fMYQmsp
         PORvN1HxIp9wQj9v8KwaJh/G4mvc4xhXRlymBrmVNwN6Dc1nER9V2ceAKr/nKyre1STa
         LxAQLCy9ECvJfm8GVhR8ZEAjgdg1Z7VDe2nYFT3HOojjlMjRmblgctWj9erSX2AImZ/6
         y98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yvushcHgW5x8Ci13qV/eVljqWihhBxbnLqYrlJGnnQM=;
        b=askDR4ERSP9LI5qYF9TSEb3+dXeYr4KB+PquK1qMWG/GIvCu9ynHMQbjODXFNESzTr
         D312kgknj/QWp5tUoAois22oVI6ky7suJuh1qE+/n/qnlB21uHZ3hnW+srNfSEDjvG70
         7+FRDUEzBlXbap7fnRCAkaWyWJhURn11s+d3QR2eauhAgRTnd3QckJ1TMHiU4LfPrUEc
         K5sMBXnWSjhLXvDUVXO5QvGbvR1ipYWKgdPspd5PzdV2Sd+w3ypc7syU/u8YrVsKRGRq
         F343fg2vfqqWlishO9Cjd2ak2ojBorn6xIvojvicpD83Zy7HYSHyuLK/BZJBKbwaPMzP
         lzgQ==
X-Gm-Message-State: AOAM532F4YFqixwI+GvJ0n12VbPCKJXYzz+P8OBZ0TMrapvg0onG7G/Y
        v2N0eySu5xo3U7dFFjJEPJNgZg==
X-Google-Smtp-Source: ABdhPJxoKhG14BSFQVVyTSDxEWd6rrCYlRRTJeLtOKT+FsHY/62gPCBcNexsNdCeXVc2WChrJeebzQ==
X-Received: by 2002:adf:e292:: with SMTP id v18mr26961296wri.256.1600268517315;
        Wed, 16 Sep 2020 08:01:57 -0700 (PDT)
Received: from bender.baylibre.local (home.beaume.starnux.net. [82.236.8.43])
        by smtp.gmail.com with ESMTPSA id m3sm33275243wrs.83.2020.09.16.08.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 08:01:56 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 3/3] drm/panfrost: add Amlogic GPU integration quirks
Date:   Wed, 16 Sep 2020 17:01:47 +0200
Message-Id: <20200916150147.25753-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200916150147.25753-1-narmstrong@baylibre.com>
References: <20200916150147.25753-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the required GPU quirks, including the quirk in the PWR registers at the GPU
reset time and the IOMMU quirk for shareability issues observed on G52 in Amlogic G12B SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 7c8a87d164c3..6e5dedacb777 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -658,7 +658,18 @@ static const struct panfrost_compatible default_data = {
 	.pm_domain_names = NULL,
 };
 
+static const struct panfrost_compatible amlogic_data = {
+	.num_supplies = ARRAY_SIZE(default_supplies),
+	.supply_names = default_supplies,
+	.vendor_quirk = panfrost_gpu_amlogic_quirk,
+};
+
 static const struct of_device_id dt_match[] = {
+	/* Set first to probe before the generic compatibles */
+	{ .compatible = "amlogic,meson-gxm-mali",
+	  .data = &amlogic_data, },
+	{ .compatible = "amlogic,meson-g12a-mali",
+	  .data = &amlogic_data, },
 	{ .compatible = "arm,mali-t604", .data = &default_data, },
 	{ .compatible = "arm,mali-t624", .data = &default_data, },
 	{ .compatible = "arm,mali-t628", .data = &default_data, },
-- 
2.22.0

