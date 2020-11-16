Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7E62B5217
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbgKPUMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgKPUMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:12:17 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B0EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:12:18 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id v21so1472319pgi.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TM34Y8/Xkbhi+35MDii+t1nA+9j+av7JM+nHGfjWGOI=;
        b=KuK5C60FGb0OkS1JeYNuK+sBpPP6TMURsm2/zlPeTiJsO5+A7OBpPseAaRRPbgm+po
         mtdcIf3rCYDmtf9lJIZXm9Qufu1cBEPtjIqcRP45wwj+cV/Z5vt8KoRAVazUvFqbkasA
         VUQSHgdNCJG6vSjN5SD3ALXec0K1CxZnKrfUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TM34Y8/Xkbhi+35MDii+t1nA+9j+av7JM+nHGfjWGOI=;
        b=LLeKRheDDPwBABxbo7NBmjgFmG1thUnf1j1m01yTei+kt1/c3HSA07Ch9yjX3/WQ43
         SR574LcJp49ZxQnLZ0DzgAkJBr8Podk0Gt/ZBeXqchZe+yoBrKo2+9DJYdRdi2MRr7kp
         ZfECiC3QVwBM+nWvXQpqidZwwLycOdHXat2G2xP3qOqBpvPWpykm4HgUZ5JF4fFD2Y4h
         v8cIp3N9s/ewIwMLK6+Za+b2LMxrQNpXT1xhnMym5GbpOt5q2bE0Bv9O8GbrQZw1PTdY
         lI2D3E/nbDj9llyPlteLxUDCvdk1i4DECCg4k2o4H1D/gwliP1TkCWBaKw0PtEASeFxA
         NM9A==
X-Gm-Message-State: AOAM530EcMVjThp7XQ5oFXtrt8ufzbzfbv92QZjk627PR1SdIhE0pWsw
        mhUjPZdeA4pRFBzZHLk2p8+CUsS9oH0I3A==
X-Google-Smtp-Source: ABdhPJzicRYi1Z2xIFSKRLEjWTu4BcYXPR2VlejlzbefEvEyFDtZGOM3ew/a/YjWo0tuAhBWA1EIJQ==
X-Received: by 2002:a65:560b:: with SMTP id l11mr756789pgs.63.1605557537362;
        Mon, 16 Nov 2020 12:12:17 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id a12sm234577pjh.48.2020.11.16.12.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 12:12:17 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        enric.balletbo@collabora.com
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v3 01/11] usb: pd: Add captive Type C cable type
Date:   Mon, 16 Nov 2020 12:11:38 -0800
Message-Id: <20201116201150.2919178-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201116201150.2919178-1-pmalani@chromium.org>
References: <20201116201150.2919178-1-pmalani@chromium.org>
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
Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---

Changes in v3:
- Re-arranged patch order and combined it with related series of
  patches.
- Added Reviewed-by tags

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
2.29.2.299.gdc1121823c-goog

