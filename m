Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BD92827C9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 03:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgJDBSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 21:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgJDBR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 21:17:59 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0152C0613D0
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 18:17:59 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k6so5668125ior.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 18:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NYqpElu1kFYTJh2MLTbd/IIRjPhEHNaagHMg3GXSek0=;
        b=umRnfVtkmnsvMffpKB8uYpxleLUwqrOcW/Rxy1xXq2AM8QvfgckOM8Ukw0PD1/LEh+
         EgZPFOTCC0+6Ck3D8X6dMEOfDVv+x81sBPU7F6sIGNFmnJRjbsGVOnaM2dsvokK0OeoS
         os09i2rkRH4NK50Xouvolw2cMd679evS/JxNOW8DuyFKyj1P8rVNtxMuaA37RGPee6sO
         ZitAAdN80Vy8AXyjzYVElJSjgYQhJU3gSueUK0gTjki+4Jppi8BwDo6ColZpLNDwYZZi
         Be8xNMbpm5+sJE2Z14FO70gm4zFdy1u9JMEOPaQGLJwlaxPU6b9gC3jD3ZI7lskoXcUK
         Q/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYqpElu1kFYTJh2MLTbd/IIRjPhEHNaagHMg3GXSek0=;
        b=JNBb2+9DOFGfhJ3IUqQYYslsZLF2H8z6dwdcuv5z7Yf47yM8kBXvXH599weEdbZkLr
         D5sOOQW1pqs6T2JkPay4tk2+vov8Xylb1cWRE8nLBZPi+cDPc8Y58WaF1K2fiHRrzcMN
         wJgx0IcDz6XOHLxQKmQbqhKq+0naTxM41vS+CKqO1FqThFfkQ3ohAZBwWLzCGxYqc+Lb
         NRJEYYgew8ddLTyiD/i/nlIJZgMs0nbLnQE8ziXsCtjSfwx03dM4eDtb34zuXjj7gLX7
         DJ3Uemg9aakFiZuDgh6ifL3ZZH06V/If4K/MzFTc7FVL1lzl/8TGF/Uph+R7ck0ojgwh
         v6TA==
X-Gm-Message-State: AOAM533dsfK0vmqe5wq2O9huNXaRi3c0msmvjEMVcwHUccMdKlpkG/o8
        UcdQDJzEPVrm+oxC2IfSjuk=
X-Google-Smtp-Source: ABdhPJzzZm/fF5UBKvteZiHQOJLZubxL3vEMwbShXgXHXLOfaIqL1jT1oPcUeIBCrD+IM6IR2LXf0A==
X-Received: by 2002:a5e:d716:: with SMTP id v22mr6616296iom.121.1601774278751;
        Sat, 03 Oct 2020 18:17:58 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id t64sm3575194ild.10.2020.10.03.18.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 18:17:58 -0700 (PDT)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 3/8] staging: rtl8723bs: replace _RND8 with round_up()
Date:   Sat,  3 Oct 2020 20:17:38 -0500
Message-Id: <20201004011743.10750-3-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004011743.10750-1-ross.schm.dev@gmail.com>
References: <20201004011743.10750-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use round_up instead of inline _RND8.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c    |  2 +-
 drivers/staging/rtl8723bs/include/osdep_service.h | 11 -----------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index b9ccaad748ea..1fbf89cb72d0 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -369,7 +369,7 @@ static void rtl8723bs_recv_tasklet(struct tasklet_struct *t)
 				}
 			}
 
-			pkt_offset = _RND8(pkt_offset);
+			pkt_offset = round_up(pkt_offset, 8);
 			precvbuf->pdata += pkt_offset;
 			ptr = precvbuf->pdata;
 			precvframe = NULL;
diff --git a/drivers/staging/rtl8723bs/include/osdep_service.h b/drivers/staging/rtl8723bs/include/osdep_service.h
index 8f0e5cbf485b..c5e9a4eebd27 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service.h
@@ -132,17 +132,6 @@ static inline int rtw_bug_check(void *parg1, void *parg2, void *parg3, void *par
 
 #define _RND(sz, r) ((((sz)+((r)-1))/(r))*(r))
 
-static inline u32 _RND8(u32 sz)
-{
-
-	u32 val;
-
-	val = ((sz >> 3) + ((sz & 7) ? 1 : 0)) << 3;
-
-	return val;
-
-}
-
 #ifndef MAC_FMT
 #define MAC_FMT "%pM"
 #endif
-- 
2.26.2

