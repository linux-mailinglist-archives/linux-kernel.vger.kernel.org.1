Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130872B4E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388031AbgKPRn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387792AbgKPRl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:58 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD88FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:58 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a65so50393wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+WLjHfl3orvIQYtFk8cWNm313KtEs9zxT+XRuqJ/3Ug=;
        b=UH/wzcYnQ6WNXlSacFEkhr/x34dgeTAKoOhIqiDcF2gN7ADQZlojGwVxCXvNJzJ42n
         mEQUdOT9UgO5o4h34H82pfTeRaIrEkywNTJgrSa/CdLTGZu//7j7iPIl+hayhj+5dDKJ
         O/VU/eKmM/U8XRLw8IM2Nzx1xzDE1NmeG3fuB6IN//4Vf9pEUsJfzqj89AxWNxMMdK4Q
         JfMfDxyvXpHlaBfEqDFP/hLaWM9pSDU+BzrUELdP8wKXEIwx7ZsCPR6IMvoZL8rmLtjT
         68FMnR0IcHE6U8XN/RPfrb3VeIOVUGFC/Al/ooOp2IcPJMYQEL79xQ0mesjsfcUZdRC3
         Wxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+WLjHfl3orvIQYtFk8cWNm313KtEs9zxT+XRuqJ/3Ug=;
        b=UKeQo/OFTtKyOrBMJOxRSd9lS2l4zR65gVYaD5c6JLEU9tgNF1WymbeB7Nmt7s78v+
         8SkIFAbFJ1hY7fJYsfrurPYCZ3YCRQAaRXptSSAD/iHYt9gFI6JL6+Q5SDExjNTNev81
         vb/kYN/YpnjLxiIq0vNdhkd8DjalQSFVZEwf8oXWFMxx8YlL8UQs7+wLQz1JFBTbnQ5T
         m0nqVGggp4n4ltQrZnk9IuRPmIzC7+YbDePIqlxDsKzkSYy5ymoHQn4qAatlTubaoAEl
         stHFzb2ybq7Zm0k0J8PbasRPQV7p/fUw6+xPYPL72WsOtFMoga5pcf4XXIvlbHK6MN+f
         KkIA==
X-Gm-Message-State: AOAM533SXUf0Czk0ZVLj7+bNQJwJetQ/UlXY2tLFee+olw6/YeozVbuk
        7xBZVWjPT8A1hRqEY4t+nyPkJQ==
X-Google-Smtp-Source: ABdhPJzJ++oU+QXxqvf2YFvLPeBzaQUSNwRBGkprWJuB8Ho9MuTxldYpIomk2Fd55/9oIMXIYP7drg==
X-Received: by 2002:a1c:9ec9:: with SMTP id h192mr49655wme.8.1605548517471;
        Mon, 16 Nov 2020 09:41:57 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:56 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Yao <mark.yao@rock-chips.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 26/42] drm/rockchip/rockchip_lvds: Fix struct document formatting
Date:   Mon, 16 Nov 2020 17:40:56 +0000
Message-Id: <20201116174112.1833368-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Must start with "struct <name>"

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/rockchip/rockchip_lvds.c:49: warning: cannot understand function prototype: 'struct rockchip_lvds_soc_data '

Cc: Sandy Huang <hjc@rock-chips.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Mark Yao <mark.yao@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index f292c6a6e20fb..8658ef82d937b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -42,7 +42,7 @@ struct rockchip_lvds;
 		container_of(c, struct rockchip_lvds, encoder)
 
 /**
- * rockchip_lvds_soc_data - rockchip lvds Soc private data
+ * struct rockchip_lvds_soc_data - rockchip lvds Soc private data
  * @probe: LVDS platform probe function
  * @helper_funcs: LVDS connector helper functions
  */
-- 
2.25.1

