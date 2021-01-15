Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FFE2F83DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388558AbhAOSRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388349AbhAOSR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:17:27 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE1AC06179A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:14 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id e15so2002068wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ei80Fpi/NHdpNAUZshztT153p4/37OmShz52J4NwQ9Q=;
        b=ez6/pCbgjiKbH4YqZyRmCG45Xt9FGesqfWhDVvuPZ+dCPSnfDTjbRXy/tYcmnfSRdE
         c2xoWUyDioc5kwwAeyghLoAe5ZKaInjA+xlyjex+ynmNz6AZH1lOvHW0rEf3ZfB6KdV9
         rP7eH36pLUBUvSeUgtxjaCLvMILiD/ZffnIIwddomGp1Dcf/E3WE7byM9VcmEZiXwx87
         W6MO0F0mtbI6FS5xzmQzHc3xc3O2e5X2t7RUuiX0lbGWNqITuvup72EyyM6BnbPSeJgk
         dNAxIqCQgnxZqrW+27ceCASfZCWQZSAw1vfd5txLzmkP8wi5l5ANmuF/SQBAW0JHj2ej
         MkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ei80Fpi/NHdpNAUZshztT153p4/37OmShz52J4NwQ9Q=;
        b=egubHM/6qrAPcUOgr6S5cfLGYqHUSdCfjmhVpNQN+1I1H4kJmLJGBSIj4GdkcCu+Db
         /9O3dYmkt5Beva0sCUEqWeVaQULAJ2mO5B0DepvMpIxsExGzSNFF4TpGWxt2IL9PhaMt
         wCwpzohkgQdR5VBWkf5fgT9UrNa+vQMojw3W2KiKLnMDP4YepgiRNqgY8Pd4ZBf15bfp
         /ii7NsLvdMlLAk3Q9jYNQsNk38kHIhpcxPeWYQdYELRSBUXRabT5S9D4bp0khecPNYY1
         RkLsunFy+h5MLbjZ+LEA7ac4q/DRopHhfn885WcPhOyfHnmtv5DaSBPcR6vIvrauR0Og
         1Nog==
X-Gm-Message-State: AOAM5332IycAkv5HzpkK8jA1slffMvrZ8a5AjhyVOqfayiUu48xnigE0
        q6bElS0Ef7E+4ql7RXZUYIGNfQ==
X-Google-Smtp-Source: ABdhPJwX4CxBwGr2oULRklZN0T24FZWYVkHWccYV92xPLHUZgBvZqYcBfBuuEtgEw1nWmEEcKHBktQ==
X-Received: by 2002:a7b:cc0f:: with SMTP id f15mr9903003wmh.29.1610734573560;
        Fri, 15 Jan 2021 10:16:13 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:12 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 05/29] drm/vmwgfx/vmwgfx_msg: Fix misspelling of 'msg'
Date:   Fri, 15 Jan 2021 18:15:37 +0000
Message-Id: <20210115181601.3432599-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c:261: warning: Function parameter or member 'msg' not described in 'vmw_send_msg'
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c:261: warning: Excess function parameter 'logmsg' description in 'vmw_send_msg'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index 15b5bde693242..609269625468d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -253,7 +253,7 @@ static unsigned long vmw_port_hb_in(struct rpc_channel *channel, char *reply,
  * vmw_send_msg: Sends a message to the host
  *
  * @channel: RPC channel
- * @logmsg: NULL terminated string
+ * @msg: NULL terminated string
  *
  * Returns: 0 on success
  */
-- 
2.25.1

