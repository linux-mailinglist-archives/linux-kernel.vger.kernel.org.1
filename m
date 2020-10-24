Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25844297A90
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 05:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759432AbgJXDye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 23:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754841AbgJXDyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 23:54:33 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA64C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 20:54:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 126so2527687pfu.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 20:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DHxWsys+dsHZlYbTCgm4K5sedJ6MYP3oaeNFmkALrqM=;
        b=UNSecyD70DJbdoa3nEKStvo16idn3uPBVMvv8wciCKz/CZ9XLg49oc8I3gUJm1XHyf
         LBiIKrAbhaElf2C78Cnv7M0oxeBmaDsBCL6JQ5NgtRzBFkip40NcvFg2N97N5WeycBpw
         9p89xyh5DFXVCowIdoEbOk1wh2yMRPnUxkUtbAkryY44N2zs5Za7EOLbaMBnVwfQhHZN
         Raafp8ETUVeMOEFj06PQTqWZmZJeFc3PsU1VqxNNFAbu0tFEJmTYTK/sxDOQ53EIzcTy
         7FN91bJl7snVlH7bPIxB5bxnG3e1zADNpzAPhXVqOuTLH/ysbHQ6d3dmKCVhRHAk5Gmo
         K4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DHxWsys+dsHZlYbTCgm4K5sedJ6MYP3oaeNFmkALrqM=;
        b=GOoyXepbfWOia48XUhtyMlSv+37JYn45GWBXYVoFkINeLLTEKTY49NTS2jx54LzcQX
         6GPfLlCk0ElY4YHEQQZiT8ny8ODqeb9JI8GQutxI/N7gEUNYyERmcdixp647aEaaSPHe
         op8ocMBUTFTkrkCzcSdx1wOOWq1Lu1uE0uBfml8EPGM69lBCbVAPGxBs0lgB9oP3/yXA
         e3ykrMqzaGNu+1BOLsZBMv2jDdGEELNfpy8Zy+hOg3Cjq14Ypuflsdq58KbWPn452zZG
         /d/HjTa9MjYQLNQizf5n1QCKxnV5zos2Sxz9Yub/gsCQZ9T17Wf2XQwkZ9b6mKLURs5Y
         4TTg==
X-Gm-Message-State: AOAM531tThSb0tHUgzip1hwZRBK+0+srirmyitsODJWP/8jeFJX4yZf2
        HQb4P3CK+RWK4aEYp4TZfZU=
X-Google-Smtp-Source: ABdhPJxnaoZIHSyeaLHOggKuQPc6R2MJHs3zj6tNNwoEkVIMlDjR5/Bgui16x+FHxJUCspKSGIZoVA==
X-Received: by 2002:aa7:8498:0:b029:160:190:327b with SMTP id u24-20020aa784980000b02901600190327bmr1953801pfn.61.1603511673103;
        Fri, 23 Oct 2020 20:54:33 -0700 (PDT)
Received: from 119-18-5-146.771205.syd.nbn.aussiebb.net (119-18-5-146.771205.syd.nbn.aussiebb.net. [119.18.5.146])
        by smtp.gmail.com with ESMTPSA id c187sm4083870pfc.153.2020.10.23.20.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 20:54:32 -0700 (PDT)
From:   Jonathan Liu <net147@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan Liu <net147@gmail.com>
Subject: [PATCH] drm/rockchip: dw_hdmi: fix incorrect clock in vpll clock error message
Date:   Sat, 24 Oct 2020 14:53:21 +1100
Message-Id: <20201024035321.4898-1-net147@gmail.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error message incorrectly refers to grf clock instead of vpll clock.

Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 23de359a1dec..830bdd5e9b7c 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -202,7 +202,7 @@ static int rockchip_hdmi_parse_dt(struct rockchip_hdmi *hdmi)
 	} else if (PTR_ERR(hdmi->vpll_clk) == -EPROBE_DEFER) {
 		return -EPROBE_DEFER;
 	} else if (IS_ERR(hdmi->vpll_clk)) {
-		DRM_DEV_ERROR(hdmi->dev, "failed to get grf clock\n");
+		DRM_DEV_ERROR(hdmi->dev, "failed to get vpll clock\n");
 		return PTR_ERR(hdmi->vpll_clk);
 	}
 
-- 
2.29.1

