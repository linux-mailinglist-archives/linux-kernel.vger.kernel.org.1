Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6222ECC27
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbhAGJBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbhAGJBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:01:33 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C73C0612FC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 01:00:39 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id i5so4424607pgo.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 01:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DastRFZT0YRTJbhjin4LYkaltVM19avoz7xyKVGj6Dw=;
        b=WrquiLyHqpze9casezEGrj757u5zzRnCqbtbUbvIk0QNnvRcaJNK0xR0rdxlvB7CVS
         FtN+2XUyriUFa1bhhxvy7N/Y4ric5y6tEAy/jbM37TOvErEvReLZ32l3Haj+Y7Q0n54q
         vBbYoVGOdM/cXwFGSUX3rJeoaot0xKiveejdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DastRFZT0YRTJbhjin4LYkaltVM19avoz7xyKVGj6Dw=;
        b=f8b064EoEdSWYnwTfc9U9otWizlpb75WEbxvoAnJKrVbvDEZxhlMMmteig8FShvZ1c
         FFCcek/Nh4UoFkmIqFJcPzpxAk6JmU+Okqa6wT+qQGWSX1ODa1dFT4bJBlHLqIxHYPnO
         E1btamehGLaSCM4+eEXk8fJtZRR/G6dJbpsHghwj2dSqNYdH0w+LA2DJyWUzig0MHCJu
         c6CHmC1cr29GSal5cf5nBzQt63gZRrZBvyqM0XRM1lqpn+osyVsKMh8TMFJuojokxwkR
         Z79jMGa8EbwuAoo0V4/ETRxhSUWqnW2ObOpQXeZh6w0NmeXwvBSExFRz0EmIBfkwfo2S
         Au2Q==
X-Gm-Message-State: AOAM532ahw/gR1nymZpzcOTxHzX1o8uaO4vfATSEgr3VH56rjF6BPKS7
        tBukKDQtxOqbsfKdxHT5pf4Rhg==
X-Google-Smtp-Source: ABdhPJyY+YV3V4DWR0ayGdUUpbnvU4ijK2h17JSY9FskuqIWSGOaaLwPCjnzSF8RjQYbhqKoNKhhtA==
X-Received: by 2002:a62:145:0:b029:19e:a395:bd3d with SMTP id 66-20020a6201450000b029019ea395bd3dmr7842250pfb.13.1610010038443;
        Thu, 07 Jan 2021 01:00:38 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id a29sm5022421pfr.73.2021.01.07.01.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 01:00:37 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     hsinyi@chromium.org, hoegsberg@chromium.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        boris.brezillon@collabora.com, fshao@chromium.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/4] drm/panfrost: devfreq: Disable devfreq when num_supplies > 1
Date:   Thu,  7 Jan 2021 17:00:21 +0800
Message-Id: <20210107170017.v8.3.I3af068abe30c9c85cabc4486385c52e56527a509@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20210107090022.3536550-1-drinkcat@chromium.org>
References: <20210107090022.3536550-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPUs with more than a single regulator (e.g. G72 on MT8183) will
require platform-specific handling, disable devfreq for now.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Reviewed-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v8:
 - Use DRM_DEV_INFO instead of ERROR

Changes in v7:
 - Fix GPU ID in commit message

Changes in v6:
 - New change

 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index f44d28fad085..812cfecdee3b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -92,6 +92,15 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	struct thermal_cooling_device *cooling;
 	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
 
+	if (pfdev->comp->num_supplies > 1) {
+		/*
+		 * GPUs with more than 1 supply require platform-specific handling:
+		 * continue without devfreq
+		 */
+		DRM_DEV_INFO(dev, "More than 1 supply is not supported yet\n");
+		return 0;
+	}
+
 	opp_table = dev_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
 					      pfdev->comp->num_supplies);
 	if (IS_ERR(opp_table)) {
-- 
2.29.2.729.g45daf8777d-goog

