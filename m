Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335532827C6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 03:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgJDBSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 21:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgJDBSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 21:18:00 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BC3C0613E7
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 18:18:00 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id q1so4770860ilt.6
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 18:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hWcX8nDRcXPwQhru07wwR3wgE1gSI9bcbHDH0d1P4/g=;
        b=TzY7lhBrpid96fdyXG+eaDEsQSwYcgfflWa2ms+ZOibe6+4+fXXOabZN8/j6jdIdoU
         wxLZ6JLMeuySA2mCziILZQfb1a9HeQ1Fx0B5ztGm4YcRKE5aV9/e+hFVYfyHWekKxMl2
         6Y/QIEtj8UeSKGeI61MK/sYOwmWXcrDXQJ+z2RQ7weK4Kk7x08l+iTyvWFGc+jgdLE/O
         NRd7jPYkNjy82g0qIw/4TEaI43g559GrvBD3mZbTyfZzazt1kT0G/A0u205MsY7zHpWA
         de9X1B3KeGJh0f7lcc0y0l5rFYIHqqZ0J4uI+iZ7B66t2dDrtpizuM3PWQGUDntWk+XK
         eOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hWcX8nDRcXPwQhru07wwR3wgE1gSI9bcbHDH0d1P4/g=;
        b=otf2bNFqbGXJO6N3nc42jsus34UkdpNn5CvAavJfcYfmZmf+QZwffgx0L8T0KDCIf9
         HCxuH0p0Qh6L+kAkguS0wSA4Abq9tKHLTVlSA2Z1tXLZHwoq+J0wyTcbDMnNoWccV55X
         4GmInSYTQcjGWs+YjixrhZagsBPTkwAmkQWcPFqfwAd9odWBmu66PhYmcq0vbj9dFxAA
         +u0pI3B6u8TpL+iVwWX4856Tqn5vCyMD+QSHHZX+Fxb5PSBV37yP+YYAbwhu+70IO5yQ
         lbCLP8qrcjGUxkIMHrPY/tbJlUyIjgM+P7M7nWycp5zXKQ5MPyiaMeZ+H7oI7Zwv5O3A
         qsMg==
X-Gm-Message-State: AOAM533UVFlIMpSSOm8onCNGEcaQHUAkW5p+d5SUX53DR+8hhH3zHcNj
        NWJScEoAe+Q9Tp8QPJ8KPAND9e6V+1k=
X-Google-Smtp-Source: ABdhPJxMGi5K5+kmnjtsmPs7QdeWOkjrJZfOEiMPen7xyRDKJMg3CAro/Vmi+ZkDYsNpCOflSXYQ+w==
X-Received: by 2002:a92:d44f:: with SMTP id r15mr6964373ilm.236.1601774279419;
        Sat, 03 Oct 2020 18:17:59 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id t64sm3575194ild.10.2020.10.03.18.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 18:17:59 -0700 (PDT)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 4/8] staging: rtl8723bs: remove unused macros
Date:   Sat,  3 Oct 2020 20:17:39 -0500
Message-Id: <20201004011743.10750-4-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004011743.10750-1-ross.schm.dev@gmail.com>
References: <20201004011743.10750-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove several macros in osdep_service.h because they are not used.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 .../staging/rtl8723bs/include/osdep_service.h | 57 -------------------
 1 file changed, 57 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/osdep_service.h b/drivers/staging/rtl8723bs/include/osdep_service.h
index c5e9a4eebd27..da4aa3e71a4b 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service.h
@@ -151,68 +151,11 @@ extern void rtw_free_netdev(struct net_device * netdev);
 /* Macros for handling unaligned memory accesses */
 
 #define RTW_GET_BE16(a) ((u16) (((a)[0] << 8) | (a)[1]))
-#define RTW_PUT_BE16(a, val)			\
-	do {					\
-		(a)[0] = ((u16) (val)) >> 8;	\
-		(a)[1] = ((u16) (val)) & 0xff;	\
-	} while (0)
 
 #define RTW_GET_LE16(a) ((u16) (((a)[1] << 8) | (a)[0]))
-#define RTW_PUT_LE16(a, val)			\
-	do {					\
-		(a)[1] = ((u16) (val)) >> 8;	\
-		(a)[0] = ((u16) (val)) & 0xff;	\
-	} while (0)
 
 #define RTW_GET_BE24(a) ((((u32) (a)[0]) << 16) | (((u32) (a)[1]) << 8) | \
 			 ((u32) (a)[2]))
-#define RTW_PUT_BE24(a, val)					\
-	do {							\
-		(a)[0] = (u8) ((((u32) (val)) >> 16) & 0xff);	\
-		(a)[1] = (u8) ((((u32) (val)) >> 8) & 0xff);	\
-		(a)[2] = (u8) (((u32) (val)) & 0xff);		\
-	} while (0)
-
-#define RTW_GET_BE32(a) ((((u32) (a)[0]) << 24) | (((u32) (a)[1]) << 16) | \
-			 (((u32) (a)[2]) << 8) | ((u32) (a)[3]))
-#define RTW_PUT_BE32(a, val)					\
-	do {							\
-		(a)[0] = (u8) ((((u32) (val)) >> 24) & 0xff);	\
-		(a)[1] = (u8) ((((u32) (val)) >> 16) & 0xff);	\
-		(a)[2] = (u8) ((((u32) (val)) >> 8) & 0xff);	\
-		(a)[3] = (u8) (((u32) (val)) & 0xff);		\
-	} while (0)
-
-#define RTW_GET_LE32(a) ((((u32) (a)[3]) << 24) | (((u32) (a)[2]) << 16) | \
-			 (((u32) (a)[1]) << 8) | ((u32) (a)[0]))
-#define RTW_PUT_LE32(a, val)					\
-	do {							\
-		(a)[3] = (u8) ((((u32) (val)) >> 24) & 0xff);	\
-		(a)[2] = (u8) ((((u32) (val)) >> 16) & 0xff);	\
-		(a)[1] = (u8) ((((u32) (val)) >> 8) & 0xff);	\
-		(a)[0] = (u8) (((u32) (val)) & 0xff);		\
-	} while (0)
-
-#define RTW_GET_BE64(a) ((((u64) (a)[0]) << 56) | (((u64) (a)[1]) << 48) | \
-			 (((u64) (a)[2]) << 40) | (((u64) (a)[3]) << 32) | \
-			 (((u64) (a)[4]) << 24) | (((u64) (a)[5]) << 16) | \
-			 (((u64) (a)[6]) << 8) | ((u64) (a)[7]))
-#define RTW_PUT_BE64(a, val)				\
-	do {						\
-		(a)[0] = (u8) (((u64) (val)) >> 56);	\
-		(a)[1] = (u8) (((u64) (val)) >> 48);	\
-		(a)[2] = (u8) (((u64) (val)) >> 40);	\
-		(a)[3] = (u8) (((u64) (val)) >> 32);	\
-		(a)[4] = (u8) (((u64) (val)) >> 24);	\
-		(a)[5] = (u8) (((u64) (val)) >> 16);	\
-		(a)[6] = (u8) (((u64) (val)) >> 8);	\
-		(a)[7] = (u8) (((u64) (val)) & 0xff);	\
-	} while (0)
-
-#define RTW_GET_LE64(a) ((((u64) (a)[7]) << 56) | (((u64) (a)[6]) << 48) | \
-			 (((u64) (a)[5]) << 40) | (((u64) (a)[4]) << 32) | \
-			 (((u64) (a)[3]) << 24) | (((u64) (a)[2]) << 16) | \
-			 (((u64) (a)[1]) << 8) | ((u64) (a)[0]))
 
 void rtw_buf_free(u8 **buf, u32 *buf_len);
 void rtw_buf_update(u8 **buf, u32 *buf_len, u8 *src, u32 src_len);
-- 
2.26.2

