Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF742B4E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbgKPRme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387506AbgKPRl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:28 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71744C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:28 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id l1so19643584wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rT+IXEU28/HBDiXMRe74AzE+dn3RqXWDXkbUpL6OkoA=;
        b=lOXQP9/jWpUTVRFTXLhX/qUxrASE13UGlSufAsJNt/RZrsyQXt1Kgj/ODkG8POYrxb
         ttRKdLmv8vaQaTO570FUt6rkbqNvcuWrvkF5Snw1qKoDQhjK8AOAs9su2BJI1JuB/EZb
         Q1TX1WiamLQ6FiNETqn9/QrrR+eXntaFK0XhkR3+zIFNcM2TEjVAWAyVecWFihQAUxBd
         lOV9jjWhGmbs9Uz2AlzvdClkVdW46nM9LqPlEhUJp9iCuTgIjbIkvc58Ud57PxGCAv29
         TUlPk5GBxi8iIKWORUS5d2nTPDhGzD7fu4rq0ki04xBP3yK3SUSSa9qwcM5TquuxW9Be
         ZJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rT+IXEU28/HBDiXMRe74AzE+dn3RqXWDXkbUpL6OkoA=;
        b=Sz6uW/7Ed1Qiz29Pe70LO+bus85SA3pW3qKtOut3qGOvguU7lkgL3oydaCSNnJG09v
         ui8D9FwgAn65bGt2pXkpopvf8DLyMPk7ApPWKpapVkyr9mRHIATh+KsUk4NGSDuDucR2
         LDsALFliOIP698zHhjuCTev+mz2jJOOZWH72FPepW7TQTG0prwxJOXp0VywVZK4v3Lfs
         FL1T3c8aB7Br2ywFAjATpFMS66M1uKLblNuRflsrMLLXt2d0rispnDkbDhVfk5dkPjOg
         RJA+qd9sv3WwZphG+5KpcK5Nd9sNLcQU1ERyvmkCbAypVPkIqeNZOSbtUmoxBrumUIV5
         lFGA==
X-Gm-Message-State: AOAM533GwBlkqMhvZariEtKNhR9gRWbLrJ/8cRF6W5sKONaGICuG/UA9
        pQlWbAU5iANRF8wIH6ifAIHQR4gT1p+75yv2
X-Google-Smtp-Source: ABdhPJzk2sZtxzq55jR9/b3VYM19OME3kQ9c0B1dB6F5OZ/+fz7NgXKq2LMwoXVd4pXK97ON956dqQ==
X-Received: by 2002:a5d:42c9:: with SMTP id t9mr19786159wrr.13.1605548487217;
        Mon, 16 Nov 2020 09:41:27 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:26 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Eunchul Kim <chulspro.kim@samsung.com>,
        Jinyoung Jeon <jy0.jeon@samsung.com>,
        Sangmin Lee <lsmin.lee@samsung.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 06/42] drm/exynos/exynos_drm_gsc: Supply missing description for 'num_limits'
Date:   Mon, 16 Nov 2020 17:40:36 +0000
Message-Id: <20201116174112.1833368-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/exynos/exynos_drm_gsc.c:129: warning: Function parameter or member 'num_limits' not described in 'gsc_driverdata'

Cc: Inki Dae <inki.dae@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Eunchul Kim <chulspro.kim@samsung.com>
Cc: Jinyoung Jeon <jy0.jeon@samsung.com>
Cc: Sangmin Lee <lsmin.lee@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/exynos/exynos_drm_gsc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 45e9aee8366a8..b01f36e76eafd 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -118,6 +118,7 @@ struct gsc_context {
  * struct gsc_driverdata - per device type driver data for init time.
  *
  * @limits: picture size limits array
+ * @num_limits: number of items in the aforementioned array
  * @clk_names: names of clocks needed by this variant
  * @num_clocks: the number of clocks needed by this variant
  */
-- 
2.25.1

