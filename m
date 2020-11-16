Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3B62B4E2C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387926AbgKPRmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387676AbgKPRle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:34 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E6FC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:34 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id d142so38115wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vlKk1bN1CES0mgH+wUmCXkMlZA1CVtbOfxEG6y0GM50=;
        b=fBeX27nB366IYVH1W9juPZSpXK3wrkLndU8rdMtDvtddcQYffNN/LCMVS3P9DlfHOs
         C5uysVVIQlWEWxVvlzscOvU0YoKxFJPx62xbo8UNuLrVjxrOxb+7OsKEjsql2rq4foOz
         rqRfHEgrw79NMWdcMNTQ7jsrN2mAwn636r7qAAy1KiieowRf+XdzZfdU56Lu/WGbE9N9
         OuDX0zw3ZCX8RMZamB2HI4m6uaOZHYIexPeAlucHjoHho9jOXQv8+wVypU0AflPNRuy6
         MXcezHcvh9WjvmTZ5N/BZ44vefZaKq4vqG761nroGip4JTXBD3yPvgvqiQr4Gf1xsLc6
         ESmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vlKk1bN1CES0mgH+wUmCXkMlZA1CVtbOfxEG6y0GM50=;
        b=VuzZWjEy+o4D6KZc1KTnwPj1H20f+bhHNZfK2mUewPhCaV+uFpshE/ubNLPAz79mMa
         hk8jhiZS4WPytAX61FSz1z5s5naTBYmUcXbb5Vx2+KKNm/zxktbgjiMhItr2VgHn59oI
         COVZFdYU01hsMi6UkRvD7mDvm1avx7U5zJt6Bx/cBk388dJQ/tN6yQCFbX6GL9ifL43P
         CV/o6QUtQIpqxrrX+jkEW09enxZdN/sMnBTo+nRCDGhHzu01DccF/mqk+V4LFlaqmozh
         74aSbx6j3hYXCbmXmqs/IT45eRTcN9+K6FZOS+FdhJN9R9Qn24T5ZJBwMjatBR7D0IAZ
         GzGA==
X-Gm-Message-State: AOAM5312PKS+3n2jS79pHvXy0iRJX9knuQFyN5fPB/M7/9Gif8xxky+j
        Vqf4ybs/bqbM20sGWElwrEH5nA==
X-Google-Smtp-Source: ABdhPJx+DjhnZ+3t53J8dx2EwysUVrWUxuaviQMjGuBmn9hdukh9eFyNPCUzF5Q2JEQuhsfmK3NPfw==
X-Received: by 2002:a1c:4d0f:: with SMTP id o15mr21228wmh.142.1605548493144;
        Mon, 16 Nov 2020 09:41:33 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:32 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 10/42] drm/mediatek/mtk_disp_rdma: Fix formatting and supply missing struct member description
Date:   Mon, 16 Nov 2020 17:40:40 +0000
Message-Id: <20201116174112.1833368-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/mediatek/mtk_disp_rdma.c:66: warning: Function parameter or member 'ddp_comp' not described in 'mtk_disp_rdma'
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c:66: warning: Function parameter or member 'crtc' not described in 'mtk_disp_rdma'
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c:66: warning: Function parameter or member 'data' not described in 'mtk_disp_rdma'

Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index e04319fedf463..d46b8ae1d0800 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -56,8 +56,9 @@ struct mtk_disp_rdma_data {
 
 /**
  * struct mtk_disp_rdma - DISP_RDMA driver structure
- * @ddp_comp - structure containing type enum and hardware resources
- * @crtc - associated crtc to report irq events to
+ * @ddp_comp: structure containing type enum and hardware resources
+ * @crtc: associated crtc to report irq events to
+ * @data: local driver data
  */
 struct mtk_disp_rdma {
 	struct mtk_ddp_comp		ddp_comp;
-- 
2.25.1

