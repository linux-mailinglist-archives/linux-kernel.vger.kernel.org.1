Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A87269A55
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 02:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgIOASv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 20:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgIOASm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:18:42 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74D1C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:18:42 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r25so2203171ioj.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MVXFq86Wzjq/2JiJKgUy5nszyPP/+FNZubjrZtz+U0E=;
        b=CiM5tvdCNkr0lm6UjCHD4rwh1bsdj1Z2cmrZ42EMj7BgLAg4dJTnRvapCjD+QP4nbo
         u0f277kQ1FudohbdLVuySFkP+AuXgs4G5PDVXkV6MVdadFlK3cQMg2cjVRsI+4ylMkDG
         ITYdnUrpjxmrADi5urho9PCP2Yh17TZXSN+dpy88jzkAA4Q86Z9FY46NZP+ACdh1VYQz
         +NoPYf5mDUcP5NqbO/Df3xzqtXxDXA0MTWVOGqFP01CvPRZvYNmk7mtTKnnHpm2Z0zZF
         jlQdjYwdmiWKgyMoT8wZSRDCaYIQAEJzSufWoqCA1Sg/xqTFTNNr+hulYLsLB/xfONxD
         +SkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MVXFq86Wzjq/2JiJKgUy5nszyPP/+FNZubjrZtz+U0E=;
        b=TZUQ2IPosRvdIpOV+yu5ctY+e5j6Jk9BBogar340ajehyoTsF52Dk4IAYP+IE1Kc0/
         RJkXy9V2AyGcKhe/9V2CiX84zNYfxH4/7yRSYwlmDmwbdv1p7IVFDcI6421FNeH/3Fa3
         mxErVcT+hkEVKOxZADKX5SXso/VIrDvitv2og+M7Sgsy0vvzIPb84FjiMz44T1J5MNsD
         ke+Bu6OuniOgvZaW0cvLNYSL98XHY0liZVUe1K/EDVsBl5XqVVZH7r1TSKHNiNRvT8IQ
         hyS+8YFrqPxFVT/DOqYjvO2HnDiAH/blWnHymJMKb1Uz8tR8FrQB1aS9a9yS2Ynz6q+j
         X6NQ==
X-Gm-Message-State: AOAM532rigUFUurwFS8wP2lZ+J0tyi8HTF5cmD5rD7hWbxvrKb2cwDpQ
        oKPnML8Fw4t6eRUIhbv9IMw=
X-Google-Smtp-Source: ABdhPJxuXc88y9/0sq8TNKqREs2kXFcAs2Xcnn82Xd+G37iawrl8PvEdH7vF+UakPDUyyT6ItiXXJA==
X-Received: by 2002:a5e:9809:: with SMTP id s9mr13458565ioj.171.1600129122054;
        Mon, 14 Sep 2020 17:18:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id l131sm6728975ioa.31.2020.09.14.17.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 17:18:41 -0700 (PDT)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 2/3] staging: rtl8723bs: os_dep: fixed bracing issue
Date:   Mon, 14 Sep 2020 19:17:30 -0500
Message-Id: <20200915001731.28986-2-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200915001731.28986-1-ross.schm.dev@gmail.com>
References: <20200915001731.28986-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue by removing unnecessary braces in
sdio_ops_linux.c to fix checkpatch warnings.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
index bc8cef5589b8..87fc87662075 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
@@ -275,9 +275,8 @@ u32 sd_read32(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 				break;
 			} else {
 				DBG_871X(KERN_ERR "%s: (%d) addr = 0x%05x, val = 0x%x, try_cnt =%d\n", __func__, *err, addr, v, i);
-				if ((-ESHUTDOWN == *err) || (-ENODEV == *err)) {
+				if ((-ESHUTDOWN == *err) || (-ENODEV == *err))
 					padapter->bSurpriseRemoved = true;
-				}
 
 				if (rtw_inc_and_chk_continual_io_error(psdiodev) == true) {
 					padapter->bSurpriseRemoved = true;
@@ -367,9 +366,8 @@ void sd_write32(struct intf_hdl *pintfhdl, u32 addr, u32 v, s32 *err)
 				break;
 			} else {
 				DBG_871X(KERN_ERR "%s: (%d) addr = 0x%05x, val = 0x%x, try_cnt =%d\n", __func__, *err, addr, v, i);
-				if ((-ESHUTDOWN == *err) || (-ENODEV == *err)) {
+				if ((-ESHUTDOWN == *err) || (-ENODEV == *err))
 					padapter->bSurpriseRemoved = true;
-				}
 
 				if (rtw_inc_and_chk_continual_io_error(psdiodev) == true) {
 					padapter->bSurpriseRemoved = true;
@@ -436,9 +434,9 @@ s32 _sd_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 	}
 
 	err = sdio_memcpy_fromio(func, pdata, addr, cnt);
-	if (err) {
+	if (err)
 		DBG_871X(KERN_ERR "%s: FAIL(%d)! ADDR =%#x Size =%d\n", __func__, err, addr, cnt);
-	}
+
 	return err;
 }
 
@@ -538,9 +536,9 @@ s32 _sd_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 
 	size = cnt;
 	err = sdio_memcpy_toio(func, addr, pdata, size);
-	if (err) {
+	if (err)
 		DBG_871X(KERN_ERR "%s: FAIL(%d)! ADDR =%#x Size =%d(%d)\n", __func__, err, addr, cnt, size);
-	}
+
 	return err;
 }
 
-- 
2.26.2

