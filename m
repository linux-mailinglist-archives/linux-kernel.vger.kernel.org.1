Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047AA2A9C99
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 19:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgKFSmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 13:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgKFSmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 13:42:19 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE645C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 10:42:17 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id r10so1595907pgb.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 10:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DPZFud9+2AdS3xX2fJ3kB9txFUGh/iGWRXP+Nhtqe4E=;
        b=Ms0ZORNWLognrlgAgG2IcsJuwRwKUXVZAbKDQRnRMNeMnNUpUlg8e4k7hi/p49wIHk
         pBYdJmYaljTng7N4Lq812ZHZ0/G1XM27dEMv2Fv+l33lLfLCTaDe1+6Cx/za2xvSj/DG
         uyGWhDC5yqjJ9kFYZViOtik+IjntEHI+Sh0Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DPZFud9+2AdS3xX2fJ3kB9txFUGh/iGWRXP+Nhtqe4E=;
        b=Ogu3uDx2/PVVH5pQuqEFWqBJ0gR1i/xL8QIQuH8/+FV5wycKphPK6Cj/BCbjbV3TAZ
         WjD0kP1Ouc2YsCcxTrjyqhINOovH4Z92f+X1aV81RcPis+tDYAjvnh8SvtHDVXYGvQNw
         NyeUGamYnevYaybo4xhdT/cwxpOveZqBZEmJnuLnF6/w4K8DeknKMs3QP3ROPSZ6Mc1O
         bmEq7YS9DlYMuwK3TwJxZUQNhUJ1qklTqkDndbb59P1DLAlHaETvo5dNcbqc7POaw8ZE
         M65RHCLq0MFqM8CsbM3q4VfFcY8iwl/UirpMww3CO9TeND8BTR+UzXCJiS/aoX5mBSki
         Qnjw==
X-Gm-Message-State: AOAM530gRbonwl+VXCV4OBvrqCvxe2k/6NlaCYmRfKyVgsjNNYicin+y
        IrRgrXmegWhp0hHzn92+hPJVslwZMGmo0w==
X-Google-Smtp-Source: ABdhPJxfJ4xolEPygoxqHZkReo4KRySZlr82c/DktCivdHuHhSaP6qlZp0vUI+hE/geAq1USEYaw5Q==
X-Received: by 2002:a17:90b:316:: with SMTP id ay22mr1005715pjb.8.1604688137310;
        Fri, 06 Nov 2020 10:42:17 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id b6sm3246143pjq.42.2020.11.06.10.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:42:16 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v2 5/6] usb: pd: Add captive Type C cable type
Date:   Fri,  6 Nov 2020 10:41:08 -0800
Message-Id: <20201106184104.939284-6-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106184104.939284-1-pmalani@chromium.org>
References: <20201106184104.939284-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB Power Delivery Specification R3.0 adds a captive cable type
to the "USB Type-C plug to USB Type-C/Captive" field (Bits 19-18,
Passive/Active Cable VDO, Table 6-38 & 6-39).

Add the corresponding definition to the Cable VDO header. Also add a
helper macro to get the Type C cable connector type, when provided
the cable VDO.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- No changes.

 include/linux/usb/pd_vdo.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
index 68bdc4e2f5a9..8c5cb5830754 100644
--- a/include/linux/usb/pd_vdo.h
+++ b/include/linux/usb/pd_vdo.h
@@ -177,7 +177,7 @@
  * <31:28> :: Cable HW version
  * <27:24> :: Cable FW version
  * <23:20> :: Reserved, Shall be set to zero
- * <19:18> :: type-C to Type-A/B/C (00b == A, 01 == B, 10 == C)
+ * <19:18> :: type-C to Type-A/B/C/Captive (00b == A, 01 == B, 10 == C, 11 == Captive)
  * <17>    :: Type-C to Plug/Receptacle (0b == plug, 1b == receptacle)
  * <16:13> :: cable latency (0001 == <10ns(~1m length))
  * <12:11> :: cable termination type (11b == both ends active VCONN req)
@@ -193,6 +193,7 @@
 #define CABLE_ATYPE		0
 #define CABLE_BTYPE		1
 #define CABLE_CTYPE		2
+#define CABLE_CAPTIVE		3
 #define CABLE_PLUG		0
 #define CABLE_RECEPTACLE	1
 #define CABLE_CURR_1A5		0
@@ -208,6 +209,7 @@
 	 | (tx1d) << 10 | (tx2d) << 9 | (rx1d) << 8 | (rx2d) << 7	\
 	 | ((cur) & 0x3) << 5 | (vps) << 4 | (sopp) << 3		\
 	 | ((usbss) & 0x7))
+#define VDO_TYPEC_CABLE_TYPE(vdo)	(((vdo) >> 18) & 0x3)
 
 /*
  * AMA VDO
-- 
2.29.1.341.ge80a0c044ae-goog

