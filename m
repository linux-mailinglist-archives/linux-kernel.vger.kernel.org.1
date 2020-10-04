Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DD32827C2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 03:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgJDBR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 21:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgJDBR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 21:17:58 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C28AC0613D0
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 18:17:58 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t12so4772647ilh.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 18:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v53ACvOg2NKq5fjSF/YlpjrOJIK+ze5t32HmCDN949k=;
        b=n91n+BFaU86BAtNuaMySrlHjfNT6WLFdC6btjyfyvj7w9xllGOfaTQ10bdk3dMvDd1
         UIetCZ00dBH1/B8Cl8CzGInYjuBITsRkBgHdiXzxRss/lhgLkQlD/pPGX/NOMJQyfoLr
         wLka24vdt7AFG2KhvZBrb7VxIiKGSx5dJEOL0kQwuUazViOptNkDbqAJ3SKjqf70BVrt
         DoowuFiwhaXRzfA4rFOGpQhHdS4Oo2Z/NwUuXhd9hvKsDa7DhzAaA1BHuKrzxLm/hMTQ
         RPk5B8SrKW6vMXooDl9CjmaxDM2R+K+t9f45wIF157lWHgk81a8p33r5zDmbpgjs9Whr
         WD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v53ACvOg2NKq5fjSF/YlpjrOJIK+ze5t32HmCDN949k=;
        b=BX8LR8v/HJti7FsH7DtFx6CoPB/eZ3eXz5PWALNAPB+aY9u7hNGxn9HQJYiRQwJ4qL
         t3NpfYo5mD8BuFAokx5XVxeSwWmpWftr+bdvt359P4lJNmnakdS3F5AgOjOWBnScbIMM
         EfM6DcWOnKVTC6/n90o4xoDJ7BBjgbzseqIY8GRWQ3b5WF53q/ABvPWabZ6EfCkdQQFa
         TmJ7+b8xQr61a2khDMeFCjDmydFuOeJXY7UJIM0p2pQZBMNldNOh0pS/GVxWgDPkFXoS
         vFn9eLM6on+I5hdWFBXFqiAj6LzXpy/edGHY/4Ow1MJPgsNMdIxIdOX9gy558PFKOKV8
         esAg==
X-Gm-Message-State: AOAM531tGyUuLVEqYFT3o/+HWcfM1udRnXfbIa3kzUaAY0RKLuBM+pRF
        odla3M/kwdc14vt6tmHsPuo=
X-Google-Smtp-Source: ABdhPJxeAuy6zwgnL2BAFHv4JR0l+IAQbvWyhtMSFa1EeYYn61Gu32pAFthz8U+jS2dHiL7On5p1Vg==
X-Received: by 2002:a92:c50d:: with SMTP id r13mr7052415ilg.264.1601774278072;
        Sat, 03 Oct 2020 18:17:58 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id t64sm3575194ild.10.2020.10.03.18.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 18:17:57 -0700 (PDT)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 2/8] staging: rtl8723bs: replace _RND4 with round_up()
Date:   Sat,  3 Oct 2020 20:17:37 -0500
Message-Id: <20201004011743.10750-2-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004011743.10750-1-ross.schm.dev@gmail.com>
References: <20201004011743.10750-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use round_up instead of inline _RND4.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c          |  2 +-
 drivers/staging/rtl8723bs/hal/sdio_ops.c          |  2 +-
 drivers/staging/rtl8723bs/include/osdep_service.h | 11 -----------
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index bd18d1803e27..047ec5167f86 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -469,7 +469,7 @@ int rtw_cmd_thread(void *context)
 
 		pcmdpriv->cmd_issued_cnt++;
 
-		pcmd->cmdsz = _RND4((pcmd->cmdsz));/* _RND4 */
+		pcmd->cmdsz = round_up((pcmd->cmdsz), 4);
 
 		memcpy(pcmdbuf, pcmd->parmbuf, pcmd->cmdsz);
 
diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index 544d5a093229..465f51b99d39 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -474,7 +474,7 @@ static u32 sdio_write_port(
 		return _FAIL;
 	}
 
-	cnt = _RND4(cnt);
+	cnt = round_up(cnt, 4);
 	HalSdioGetCmdAddr8723BSdio(adapter, addr, cnt >> 2, &addr);
 
 	if (cnt > psdio->block_transfer_len)
diff --git a/drivers/staging/rtl8723bs/include/osdep_service.h b/drivers/staging/rtl8723bs/include/osdep_service.h
index ea3f4f3c86d2..8f0e5cbf485b 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service.h
@@ -132,17 +132,6 @@ static inline int rtw_bug_check(void *parg1, void *parg2, void *parg3, void *par
 
 #define _RND(sz, r) ((((sz)+((r)-1))/(r))*(r))
 
-static inline u32 _RND4(u32 sz)
-{
-
-	u32 val;
-
-	val = ((sz >> 2) + ((sz & 3) ? 1 : 0)) << 2;
-
-	return val;
-
-}
-
 static inline u32 _RND8(u32 sz)
 {
 
-- 
2.26.2

