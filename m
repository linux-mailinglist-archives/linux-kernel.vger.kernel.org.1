Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3186B2827C0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 03:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgJDBR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 21:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgJDBR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 21:17:58 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8F0C0613D0
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 18:17:58 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id o18so4786121ilg.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 18:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A7kJEsNSXf0lSc+XygDrQmDFrrDW387XvWyoU/QDenU=;
        b=i8BO+sTrNaA0VdQHECUj+OqYwjYDsUcy49fRA4fpz4C6cZFS9o6A/nwIRH4VlGK5DJ
         0tshW834hKWbkeYkpdn8ahOI/VhlRkdvCci6u7N5lpcQcZoux1st93k9atsQ5Zl4V30+
         PMndkLFGJ4/mUysXSIZzhHPk0makiHkGLe01R5+x8KmCpyPvjAl5EQVCRTdppqh7Ykpu
         W7wlxY8EUe4c6Qm7ntphWhXzgG6ZJ6ZPU2RkXS4DySc8CH9sPUgz7J9kyPYbEahrlwgE
         2qQ/mr4KqfsHwhdCcLq0syioVpBRyYRSmeq+xacRB217tMg+Zs3hNZDm2j54aZzGnbS5
         uhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A7kJEsNSXf0lSc+XygDrQmDFrrDW387XvWyoU/QDenU=;
        b=K0jpoMPr0/rByAjP0Oi12WbEG3Jy1NKEkNf8ZW8yQGjbDKlts2J4fus4Dv3fQCRy5v
         LAVmBdCCUEQcAA9fD2v90JWkbmiZXgXs6/nyqBkd9rQnAAltTn8eoOpB8fbPgn524Uzy
         6DEE7uanVL15VXa0KmX5Jq7IZZPzdxHnEs/PPBEKKSZq+ZGj4pJBb6d9xibn74GscirM
         xh/W96+zUPBoZ+RpOi92SFDONSHj02aQ6QfG/nvxH+mL95hrOTsEokqEUPCxTW/Hh2i9
         QJ31+50S2YC7x2GSvyn7/JDNUTuwOcIOjByyON+jSBWjYkTeHbIYOYToxhhMEsf+T8Ox
         +VqQ==
X-Gm-Message-State: AOAM531fI9gHmXKRj5a6PKvCCextxjD+Uk/X7zn6WRnj5YoMkhTctvQu
        ulg2nY6h9JQOqSalWq/Ii9t+BdmXJN4=
X-Google-Smtp-Source: ABdhPJw8amOqhhhaYeSAI1wcCE/2hvhoLKmz5DCNCQPUeEcDN38J3IXQHnQbJpteKV+n9MZ9HjIUNA==
X-Received: by 2002:a92:980d:: with SMTP id l13mr2927634ili.244.1601774277438;
        Sat, 03 Oct 2020 18:17:57 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id t64sm3575194ild.10.2020.10.03.18.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 18:17:57 -0700 (PDT)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 1/8] staging: rtl8723bs: replace RND4 with round_up()
Date:   Sat,  3 Oct 2020 20:17:36 -0500
Message-Id: <20201004011743.10750-1-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use round_up instead of define RND4.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c     | 6 +++---
 drivers/staging/rtl8723bs/core/rtw_xmit.c         | 4 ++--
 drivers/staging/rtl8723bs/hal/sdio_ops.c          | 6 +++---
 drivers/staging/rtl8723bs/include/osdep_service.h | 1 -
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 7f74e1d05b3a..159d32ace2bc 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -260,7 +260,7 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 				arcfour_encrypt(&mycontext, payload+length, crc, 4);
 
 				pframe += pxmitpriv->frag_len;
-				pframe = (u8 *)RND4((SIZE_PTR)(pframe));
+				pframe = (u8 *)round_up((SIZE_PTR)(pframe), 4);
 			}
 		}
 
@@ -716,7 +716,7 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 					arcfour_encrypt(&mycontext, payload+length, crc, 4);
 
 					pframe += pxmitpriv->frag_len;
-					pframe = (u8 *)RND4((SIZE_PTR)(pframe));
+					pframe = (u8 *)round_up((SIZE_PTR)(pframe), 4);
 				}
 			}
 
@@ -1523,7 +1523,7 @@ u32 rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				aes_cipher(prwskey, pattrib->hdrlen, pframe, length);
 				pframe += pxmitpriv->frag_len;
-				pframe = (u8 *)RND4((SIZE_PTR)(pframe));
+				pframe = (u8 *)round_up((SIZE_PTR)(pframe), 4);
 			}
 		}
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 571353404a95..6ecaff9728fd 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -865,7 +865,7 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 			payload = pframe;
 
 			for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
-				payload = (u8 *)RND4((SIZE_PTR)(payload));
+				payload = (u8 *)round_up((SIZE_PTR)(payload), 4);
 				RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("===curfragnum =%d, pframe = 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x,!!!\n",
 					curfragnum, *payload, *(payload+1), *(payload+2), *(payload+3), *(payload+4), *(payload+5), *(payload+6), *(payload+7)));
 
@@ -1209,7 +1209,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, _pkt *pkt, struct xmit_fram
 
 		addr = (SIZE_PTR)(pframe);
 
-		mem_start = (unsigned char *)RND4(addr) + hw_hdr_offset;
+		mem_start = (unsigned char *)round_up(addr, 4) + hw_hdr_offset;
 		memcpy(mem_start, pbuf_start + hw_hdr_offset, pattrib->hdrlen);
 	}
 
diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index b6b4adb5a28a..544d5a093229 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -534,7 +534,7 @@ static s32 _sdio_local_read(
 	if (!mac_pwr_ctrl_on)
 		return _sd_cmd52_read(intfhdl, addr, cnt, buf);
 
-	n = RND4(cnt);
+	n = round_up(cnt, 4);
 	tmpbuf = rtw_malloc(n);
 	if (!tmpbuf)
 		return -1;
@@ -575,7 +575,7 @@ s32 sdio_local_read(
 	)
 		return sd_cmd52_read(intfhdl, addr, cnt, buf);
 
-	n = RND4(cnt);
+	n = round_up(cnt, 4);
 	tmpbuf = rtw_malloc(n);
 	if (!tmpbuf)
 		return -1;
@@ -859,7 +859,7 @@ static struct recv_buf *sd_recv_rxfifo(struct adapter *adapter, u32 size)
 
 	/*  Patch for some SDIO Host 4 bytes issue */
 	/*  ex. RK3188 */
-	readsize = RND4(size);
+	readsize = round_up(size, 4);
 
 	/* 3 1. alloc recvbuf */
 	recv_priv = &adapter->recvpriv;
diff --git a/drivers/staging/rtl8723bs/include/osdep_service.h b/drivers/staging/rtl8723bs/include/osdep_service.h
index be34e279670b..ea3f4f3c86d2 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service.h
@@ -131,7 +131,6 @@ static inline int rtw_bug_check(void *parg1, void *parg2, void *parg3, void *par
 }
 
 #define _RND(sz, r) ((((sz)+((r)-1))/(r))*(r))
-#define RND4(x)	(((x >> 2) + (((x & 3) == 0) ?  0 : 1)) << 2)
 
 static inline u32 _RND4(u32 sz)
 {
-- 
2.26.2

