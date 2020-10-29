Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7DB29E4EF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732152AbgJ2Ht6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731752AbgJ2Hno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:43:44 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6C1C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:43:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r10so1639669pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bmwHyHUIe/uWSPHK3YvMcr+QNlICBVXmu7Dmq71Pi0M=;
        b=TW8C3K8ZXzrnZ/kDBmjrdImT1Eh0azgxxqO8H4AGCR1kRROB0CStWcbr6WtfqSABhy
         kXCczW2+hlMauiG/YErbKtsw2wdcj5jzplWFyl7Xpe90BQ7TPzpYJJm11fAEGCBVgQvh
         RYegV/nuBaTdc55uXOQJETTYXuWFacSw6LZhiek/ePJ881lATgHSeSob9TowpLuX/OPq
         U7gVEy/pznph5meEOt8okdP06Oe6K03C1LI8VkSWDJ8kP2hJ9a4AH/M9sSmNV2XvFMga
         2N2PW80BUq2R3aXQi2z6ZKzxxUTMzexnuru3+jnEVGgT+x4ZzwclB5Vv5765mfWOkhXp
         0X5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bmwHyHUIe/uWSPHK3YvMcr+QNlICBVXmu7Dmq71Pi0M=;
        b=cBx6o+WWiiCA8aRI83tRVMH5Z6y7S6fP+7Un/ntIDemVBMbxy9bYgxUY3dvoodIhJh
         QHyxFZpexfFFvrwRWwOI9GbTuZ1NCxoWm8WKWux40CAAHrF+/0Gvc0EbEquBIBKrDaY1
         KoVv418nBLsaplS3tNz37XtC7YK8FDcLs9xHWWVRj47PKJDESvzBRqd3HHkL3x/lpu2a
         C8FkHWFTNv5BY8Vh/WH03I/whcyLE/kzwRwcEATNO5n/GtuEKXJtJz8003T2hE5Gr+se
         zchPHQ66mu3WQdM+dO5BVTZgFsp8LXfhE08YEFvhIco1U5iJDi5mBy4b7KZzEZx9WmJ0
         lc8Q==
X-Gm-Message-State: AOAM5303+4mj0ZJGVz846TN9TaAQUid4L0ZO600vfy9dCNVe6CqKThle
        tb8WB5OfAr54Cq59QnWDJEc=
X-Google-Smtp-Source: ABdhPJy0skDQDIihaScK9yxAZVkcjC9QRMMPRrKoqNU1oPRXmYHp15+NFjKFrr9TjeWjwlnY8B2wVQ==
X-Received: by 2002:a62:8f4d:0:b029:163:d24d:e0ae with SMTP id n74-20020a628f4d0000b0290163d24de0aemr2904319pfd.49.1603957423589;
        Thu, 29 Oct 2020 00:43:43 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id z10sm1837779pff.218.2020.10.29.00.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:43:43 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 04/25] ASoC: rockchip: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:42:40 +0800
Message-Id: <20201029074301.226644-4-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029074301.226644-1-coiby.xu@gmail.com>
References: <20201029074301.226644-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SET_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 sound/soc/rockchip/rockchip_pdm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 5adb293d0435..f3c19310aeeb 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -574,7 +574,6 @@ static int rockchip_pdm_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int rockchip_pdm_suspend(struct device *dev)
 {
 	struct rk_pdm_dev *pdm = dev_get_drvdata(dev);
@@ -601,7 +600,6 @@ static int rockchip_pdm_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
 static const struct dev_pm_ops rockchip_pdm_pm_ops = {
 	SET_RUNTIME_PM_OPS(rockchip_pdm_runtime_suspend,
-- 
2.28.0

