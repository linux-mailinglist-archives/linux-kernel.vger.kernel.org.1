Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B884F2827C5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 03:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgJDBSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 21:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgJDBSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 21:18:00 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3737C0613E8
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 18:18:00 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k25so5647159ioh.7
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 18:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JnEGoA5xXMzr4zubHgCyguDO16qzGvYww5beEHnGANM=;
        b=uEUrmjYvOJSQRxtSF14MzvXuH7uBedssv1EudSFx2sx/xCuaOVNS29b39U+AOv28Od
         0JVahnbGscfCceKh8KFO7bAXDK7nHN8Ws+Iz3etIQSJ7PXNUtt3SVtEtlclUpOFV4rzc
         SWqzor48/hZozfsljJOVUwDSKdP+ZDcorOUAN5fejfKcEh2x6WZE5ZWvSHqqtg7p5b1L
         P7+yNHTPl4jeX3mfoz45ave8WN3dPEy1Rc/kbNgv91OHCd8AY08pCEpXX9UKYEBD9ixY
         M9K2H7WKYFkdQ85Y7pdvVYrZoWJHRuv52wSLo3bkJ8z3wQ1PGhRpm+M/S+KzKQviOCzr
         Nlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JnEGoA5xXMzr4zubHgCyguDO16qzGvYww5beEHnGANM=;
        b=AmFpGhsDmzC++FYuUnYpUlovWJnCOwFCStBMcProoftPSzQvouYtthEq8Wbnsrfdea
         BaAVq8IoR1//WlKXgQDxJ+GcMfuakBkE2LvjIBIRh+GaFNgY9hGbKDyiVqhFyu65ZC74
         mH4JA/SmxNBAHrwMJgVYplZ+D0SvT+jhBjmcWrdyfYaXOzSg7jTsEiutKfjBGbc8yDpv
         W/Ryzr2e+tRpQpbylx06+oHiWwGbqAhgLO4948+hcCwdX0qLvfts5iqaF5FGRZzxDGLN
         vxSk1N1bafpcwVDp/r4wgyr4eZ8qWERLJAl9q0gM3KZ5h+BDNxnVTLmacJjWXAGuEJYo
         rZow==
X-Gm-Message-State: AOAM532USTA/Db9KTeb8rL/FpLY8TemR6HTleJD2oTw+H9XeF0hEzg7f
        TyeeYcUA5mANDiJtP+K56Ds=
X-Google-Smtp-Source: ABdhPJz/NeyUj+w1aC3oS1j10pQyw+ApuT8okYFcq8daF2YIxhUXvw2+rVGh2yY1BXFOXLgRANWhcg==
X-Received: by 2002:a5d:9717:: with SMTP id h23mr1447066iol.7.1601774280120;
        Sat, 03 Oct 2020 18:18:00 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id t64sm3575194ild.10.2020.10.03.18.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 18:17:59 -0700 (PDT)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 5/8] staging: rtl8723bs: replace RTW_GET_BE24 with get_unaligned_be24
Date:   Sat,  3 Oct 2020 20:17:40 -0500
Message-Id: <20201004011743.10750-5-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004011743.10750-1-ross.schm.dev@gmail.com>
References: <20201004011743.10750-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace RTW_GET_BE24 macro with get_unaligned_be24.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c    | 3 ++-
 drivers/staging/rtl8723bs/include/osdep_service.h | 3 ---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index ca98274ae390..977f0ed53ad7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -9,6 +9,7 @@
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <linux/of.h>
+#include <asm/unaligned.h>
 
 u8 RTW_WPA_OUI_TYPE[] = { 0x00, 0x50, 0xf2, 1 };
 u16 RTW_WPA_VERSION = 1;
@@ -874,7 +875,7 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 		return -1;
 	}
 
-	oui = RTW_GET_BE24(pos);
+	oui = get_unaligned_be24(pos);
 	switch (oui) {
 	case OUI_MICROSOFT:
 		/* Microsoft/Wi-Fi information elements are further typed and
diff --git a/drivers/staging/rtl8723bs/include/osdep_service.h b/drivers/staging/rtl8723bs/include/osdep_service.h
index da4aa3e71a4b..a26c8db302e0 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service.h
@@ -154,9 +154,6 @@ extern void rtw_free_netdev(struct net_device * netdev);
 
 #define RTW_GET_LE16(a) ((u16) (((a)[1] << 8) | (a)[0]))
 
-#define RTW_GET_BE24(a) ((((u32) (a)[0]) << 16) | (((u32) (a)[1]) << 8) | \
-			 ((u32) (a)[2]))
-
 void rtw_buf_free(u8 **buf, u32 *buf_len);
 void rtw_buf_update(u8 **buf, u32 *buf_len, u8 *src, u32 src_len);
 
-- 
2.26.2

