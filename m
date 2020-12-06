Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24822D0072
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 05:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgLFEMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 23:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgLFEMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 23:12:35 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D4DC0613D1
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 20:11:49 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id k4so7090485qtj.10
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 20:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6FWjizWuJRJzOHlR9/efz3H59npCauuI5HbcXIPudd8=;
        b=kFAMSx7tayFUtRXPakbWZ0IE/2OK1Y1MjRIvowPtMichMwQSxj7T+i0DMkr62qfmdk
         GIef9Z1D8JXX7uHJH00o/yiw0BqhaqOWehGHFAU0KCESnpKNkMlq8yoFa7C/BuvZfib8
         zczmDdi6SQkSGqjQeJGohP3I2gOnRaLhUM3LVdGznLz2vA7+ehwZHfa/l0p+JI2C8JMm
         SLp8atHeuz5YFCI0y2q0aIKvjK/5V8aM7q2Tg3yLHdrlmkW4CLosvMA3quGKV8kM+R7l
         OOIdx2zMTYtoj5Sd3yuy6s9gac2I2wI1wZnPCAAAZRzBdFchTV483Nw7zpMMbNBtr2uT
         fYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6FWjizWuJRJzOHlR9/efz3H59npCauuI5HbcXIPudd8=;
        b=oMFEVBukbk1BBBypeUm3lQZUhu9RcCx3OJBVReKyf1/OOD8SaF5hxD5YOq+lIb31o+
         fvm6xE7qWTVOwIdleZDu2RLLBgE/+LUsWHZSY4WEyC3ZHPyBkooKQt1umaJ8GcKB8eq2
         P+6frb0EGvSTgWAsvWcO4z9SBFnwJQTA4oNobyY5AHbRliXJoqn18E/Q2DoP3mRroQgW
         n6u0919dt8pm4eKnHNkJIERdTDpu/mgE9plSSS7VHkS8L6krJtxjAR/7tnVZNw3WZpoB
         mZ/9C9JSF988e7L+2xuabQlz2J143dhMQNxEm6J3mxfewzSVIPVvgSUKutLTrVKCBb8D
         qUCg==
X-Gm-Message-State: AOAM533wHdCQE2yx4CdMIvcLPeeVR2bLTlPpAvPlyw9f4mnzPbt/s7xL
        EHL3RK13sma4DoIxTu8IM1lQI4oQQyM=
X-Google-Smtp-Source: ABdhPJz6w18g9cLn3Lo+Lk951J+vFuG8eIYnvUdK5JjYVqtA5NOMIzc00kCvvoZ2o0/7nih/T8c1dw==
X-Received: by 2002:a02:2c3:: with SMTP id 186mr13165606jau.34.1607226329471;
        Sat, 05 Dec 2020 19:45:29 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id v63sm3908553ioe.52.2020.12.05.19.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 19:45:28 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 06/10] staging: rtl8723bs: remove WLAN_HT_CAP_SM_PS_* macros
Date:   Sat,  5 Dec 2020 21:45:13 -0600
Message-Id: <20201206034517.4276-6-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201206034517.4276-1-ross.schm.dev@gmail.com>
References: <20201206034517.4276-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WLAN_HT_CAP_SM_PS_* macro family is already defined in
linux/ieee80211.h, remove them.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/include/wifi.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index 2fb1687ecabf..2e8ca191c608 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -666,13 +666,6 @@ struct ADDBA_request {
  */
 #define IEEE80211_MIN_AMPDU_BUF 0x8
 
-
-/* Spatial Multiplexing Power Save Modes */
-#define WLAN_HT_CAP_SM_PS_STATIC		0
-#define WLAN_HT_CAP_SM_PS_DYNAMIC	1
-#define WLAN_HT_CAP_SM_PS_INVALID	2
-#define WLAN_HT_CAP_SM_PS_DISABLED	3
-
 #define HT_INFO_HT_PARAM_SECONDARY_CHNL_OFF_MASK	((u8) BIT(0) | BIT(1))
 #define HT_INFO_HT_PARAM_SECONDARY_CHNL_ABOVE		((u8) BIT(0))
 #define HT_INFO_HT_PARAM_SECONDARY_CHNL_BELOW		((u8) BIT(0) | BIT(1))
-- 
2.25.1

