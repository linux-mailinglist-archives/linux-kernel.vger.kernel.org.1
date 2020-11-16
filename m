Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564D42B4E20
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387885AbgKPRmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387876AbgKPRmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:42:19 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB7AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:19 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a3so30950wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ni2p/a1qgnbLwmmB/hD7NYV4hNmI7rYb9FSLzDt4vrQ=;
        b=y1M2raZYDC6gpB5Mcfn5HK0VPQYg/d3IyD5wEaZ8lpNqOJ116kFE2YrxPfyHAozLtM
         hEXxXKHNRbcq6vandz+s4QemQu3/P9TcUDbZ70WoYmHa8GOB46snl+Ax8TnKoHuicMGZ
         91IPIjMeNrgJwGKZpTI2VyeaQGSxHmVEelyKEm9o/SMpAnxQlfbWxpn8Jr7+o+29PJW6
         ubTwCOUpNz2j6ZEI2xVpMDLezNp3wZcAizCwG/68wOUAO+2R7rangWf0/PN481oDOWM9
         1MQj6SKA/ZoK4skFes92k/8voPQoMJEk1u17QeonkE4xiSKLnfEonfyZzBUyVlDjAK/T
         uAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ni2p/a1qgnbLwmmB/hD7NYV4hNmI7rYb9FSLzDt4vrQ=;
        b=C2omgLVj8cKIqtNp4xmj1rUJ6K8V+msVdRnLzn/IVvzWBGaZROghxRkJ6154dZSYHl
         smLo8RKIR+yzd0hm+jrpdSwa4MRj9bNxZSTc5OvYEVTfdXiqulZ3mIJGFjMAWhhVPLjI
         zFfC/xU8RsICjZ1QTw6VeN70OYqzaydrqHO8iyq5U1EPADVaGLnzqeS3ZOh99Wuv+69g
         1tpzrM+MZLjDDafgyhEP79AJcTsRdqX2wL+on5r2nMeMExD8L3wb+E8Yw6hZddP+yqk6
         xIO6NRSSq9a8d/sNSU+9SF/VHtnpaUiWp5wErziAU2AIOHeiGq9CRW3axc5DxgR3oTXd
         6EHQ==
X-Gm-Message-State: AOAM531FXiA64Jxjn4g0Vu2k/bIz0Nm+GO0F0Pb3QSnXaQppeM0U+OsQ
        NqhtXBGQ2MmDttNcMXyheNRsjQ==
X-Google-Smtp-Source: ABdhPJxETsZD33sKO702FEhtaRxNZu5IBxrtx1EC2eTn8ldtL85csSK0HWNMrB9syRBqVFIZIwdWdg==
X-Received: by 2002:a1c:b644:: with SMTP id g65mr15974374wmf.145.1605548538118;
        Mon, 16 Nov 2020 09:42:18 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:42:17 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 41/42] gpu/ipu-v3/ipu-di: Strip out 2 unused 'di_sync_config' entries
Date:   Mon, 16 Nov 2020 17:41:11 +0000
Message-Id: <20201116174112.1833368-42-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They're taking up too much space on the stack.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/ipu-v3/ipu-di.c: In function ‘ipu_di_sync_config_noninterlaced’:
 drivers/gpu/ipu-v3/ipu-di.c:391:1: warning: the frame size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/ipu-v3/ipu-di.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-di.c b/drivers/gpu/ipu-v3/ipu-di.c
index b4a31d506fccf..e617f60afeea3 100644
--- a/drivers/gpu/ipu-v3/ipu-di.c
+++ b/drivers/gpu/ipu-v3/ipu-di.c
@@ -310,10 +310,6 @@ static void ipu_di_sync_config_noninterlaced(struct ipu_di *di,
 			/* unused */
 		} , {
 			/* unused */
-		} , {
-			/* unused */
-		} , {
-			/* unused */
 		},
 	};
 	/* can't use #7 and #8 for line active and pixel active counters */
-- 
2.25.1

