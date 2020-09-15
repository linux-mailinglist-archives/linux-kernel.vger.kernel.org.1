Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A8A269A56
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 02:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgIOAS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 20:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgIOASq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:18:46 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CB1C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:18:45 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id a19so1309843ilq.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MmoIpKO9u8/MGDcv7dF5sCcIl2ECWGlhyePRw59SR0Q=;
        b=J7DLiPFL3r6NJdNp3jhIVDQM55D8MabLMgsUsrlLgYfVTGM4MhuoTpOT4K4UsJHsMI
         qqk+kPwMuegh2q6clarPqE/A47FtzuSm7IjHxeHN0qrEVFr9Cw5wUlB2Kl4yxscp+chk
         O4gvbwyNhKiyuwV5GQP/uhUB38/YXaL5IAOMt0qmXOEdEpE+9p5pU/RztTdP5lMTc5YB
         uJc9uKq9ZJoh17mmY4MSjZTEg8p6p0kpW3/llUESADRAibPVl9r0nak2ZEQJoIJO3swb
         cU0vo812xo1WGm6UxZP6C63U1ddxEJtYuonVj6eEuNQHPH6EoDWVGkQgR50SrUk+nvTh
         yJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MmoIpKO9u8/MGDcv7dF5sCcIl2ECWGlhyePRw59SR0Q=;
        b=VKEVIjfvcdMf8XmrQa3w0V83m2+OlIowudCcsQIXVNhtJK+mmESVe5HGEt0FFbsC0q
         2k6cl4OadWI0Ey9HA8pn1Bk+x7QBBjSEtjoqqaU3XeRf9oZg6TecM40gdSH9caFjgmZv
         xMs0XdI70dJUqfaLUmFFwDbud2kBuLUe/N6EvQMuwMaNmu3z3s50ImfJLnMyiCWX0MKg
         R3NAjSehEgshhCt9YNph6+OKp70VZVIgCE5XPbZF/JlHa/UsojHzwBtNzycjlAgL7oXb
         PzkQ8ksqdRDulA2JIBg3HV264z91G5UCOhkmCjEsxguzTzRzXYj8Hb2bhV1+44XbR1lq
         rjpA==
X-Gm-Message-State: AOAM532PWZ6A+MoyK3HEBhc2B5a+2+0RejKvSWBGTlH3Iv1Sfvjvz29e
        HZF3N/Iuxvu40UqHSD/6zmw=
X-Google-Smtp-Source: ABdhPJy/kANWeCVpULaUnfWIQE5veCGUnONI8giikde+74OVSeOm1ekE6xKEi4Ao4jAtFw/NUfAD5Q==
X-Received: by 2002:a92:db42:: with SMTP id w2mr2167037ilq.247.1600129125034;
        Mon, 14 Sep 2020 17:18:45 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id l131sm6728975ioa.31.2020.09.14.17.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 17:18:44 -0700 (PDT)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 3/3] staging: rtl8723bs: os_dep: fixed spacing around operators issue
Date:   Mon, 14 Sep 2020 19:17:31 -0500
Message-Id: <20200915001731.28986-3-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200915001731.28986-1-ross.schm.dev@gmail.com>
References: <20200915001731.28986-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue by adding spaces around operators in
sdio_ops_linux.c to fix checkpatch checks.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 .../staging/rtl8723bs/os_dep/sdio_ops_linux.c    | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
index 87fc87662075..079da433d811 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
@@ -84,9 +84,9 @@ s32 _sd_cmd52_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 	func = psdio->func;
 
 	for (i = 0; i < cnt; i++) {
-		pdata[i] = sdio_readb(func, addr+i, &err);
+		pdata[i] = sdio_readb(func, addr + i, &err);
 		if (err) {
-			DBG_871X(KERN_ERR "%s: FAIL!(%d) addr = 0x%05x\n", __func__, err, addr+i);
+			DBG_871X(KERN_ERR "%s: FAIL!(%d) addr = 0x%05x\n", __func__, err, addr + i);
 			break;
 		}
 	}
@@ -154,9 +154,10 @@ s32 _sd_cmd52_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 	func = psdio->func;
 
 	for (i = 0; i < cnt; i++) {
-		sdio_writeb(func, pdata[i], addr+i, &err);
+		sdio_writeb(func, pdata[i], addr + i, &err);
 		if (err) {
-			DBG_871X(KERN_ERR "%s: FAIL!(%d) addr = 0x%05x val = 0x%02x\n", __func__, err, addr+i, pdata[i]);
+			DBG_871X(KERN_ERR "%s: FAIL!(%d) addr = 0x%05x val = 0x%02x\n", __func__,
+				 err, addr + i, pdata[i]);
 			break;
 		}
 	}
@@ -423,7 +424,7 @@ s32 _sd_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 		u8 *pbuf = pdata;
 
 		for (i = 0; i < cnt; i++) {
-			*(pbuf+i) = sdio_readb(func, addr+i, &err);
+			*(pbuf + i) = sdio_readb(func, addr + i, &err);
 
 			if (err) {
 				DBG_871X(KERN_ERR "%s: FAIL!(%d) addr = 0x%05x\n", __func__, err, addr);
@@ -524,9 +525,10 @@ s32 _sd_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 		u8 *pbuf = pdata;
 
 		for (i = 0; i < cnt; i++) {
-			sdio_writeb(func, *(pbuf+i), addr+i, &err);
+			sdio_writeb(func, *(pbuf + i), addr + i, &err);
 			if (err) {
-				DBG_871X(KERN_ERR "%s: FAIL!(%d) addr = 0x%05x val = 0x%02x\n", __func__, err, addr, *(pbuf+i));
+				DBG_871X(KERN_ERR "%s: FAIL!(%d) addr = 0x%05x val = 0x%02x\n",
+					 __func__, err, addr, *(pbuf + i));
 				break;
 			}
 		}
-- 
2.26.2

