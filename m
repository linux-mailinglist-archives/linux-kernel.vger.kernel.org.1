Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D324C303A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404242AbhAZKnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732108AbhAZCFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:05:51 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F9AC06121E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 18:01:23 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id v19so10285342pgj.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 18:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j0LasHSBnsU3ALa272OyzYW+m4IQeUHlxwjuI1lE7wc=;
        b=NCktlUhEX4O6P7penXk7JVIch+RP+QFg940peYApkOKGFZZ4i1pDtCLk2woG96vnFh
         sgzRwmnZ3R+frd92avauv/rSWTpMt/+cpItp/91yFHFTarinCFAnAE8WuejO3FwNBHCX
         6xJ4KISABWuSrjD9oyQb9jHtw/ptgnd75NYRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j0LasHSBnsU3ALa272OyzYW+m4IQeUHlxwjuI1lE7wc=;
        b=g4K1e1YTVNr1896JQPKJGGKGCXs32+ru9HArQDz0kjcdEq/04lOUcv0kjBYhjUb2WB
         8L3xjUR/4XJJP72Yz4nNmDS+JkqyyWWYudsQYLWmvDKSQ7pY7ISAFGCYK3gxy5tt6o7q
         6NiC4wjflXTNkPSr0ILKfVgeXxC6VXSeBtfZJn0LkKbw1vaqWkuKJcJUW6NX4yIJPmGh
         CiSVPZpE1f5ZjVaRSHTSszgZ5bmVRyz4XEMo5c40772BSaLRsyJ9mf3GlmGQQYUxM735
         zwor1v4alp4myQJrB+xm63713AZMd3W5TIfkXCF4NFWGFJbQAsi1qLCCbhCxKl1VANdS
         nDhA==
X-Gm-Message-State: AOAM5330AGxQFVVtzUusa+zQBitlhq6V2Ejgh0p/TYZPEwgW2sDh7gm3
        9pQpVEFjnOq7xM/+5PHwiR4VuA==
X-Google-Smtp-Source: ABdhPJxWcmF/fvsaQumL7NCcKePGkxjNd9CeNvBuAmr1vn1BGm427m1c0uEu0PsEjqhGG05z64k1nA==
X-Received: by 2002:a62:7ac4:0:b029:1bc:309a:46d3 with SMTP id v187-20020a627ac40000b02901bc309a46d3mr2989448pfc.18.1611626482595;
        Mon, 25 Jan 2021 18:01:22 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:1066:b437:97cd:2278])
        by smtp.gmail.com with ESMTPSA id n2sm16975028pfu.42.2021.01.25.18.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 18:01:22 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 1/3] platform/chrome: cros_ec: Add SW_FRONT_PROXIMITY MKBP define
Date:   Mon, 25 Jan 2021 18:01:15 -0800
Message-Id: <20210126020117.2753615-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210126020117.2753615-1-swboyd@chromium.org>
References: <20210126020117.2753615-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cros ECs support a front proximity MKBP event via
'EC_MKBP_FRONT_PROXIMITY'. Add this define so it can be used in a
future patch.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/platform_data/cros_ec_commands.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 86376779ab31..776e0b2be0e9 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -3457,6 +3457,7 @@ struct ec_response_get_next_event_v1 {
 #define EC_MKBP_LID_OPEN	0
 #define EC_MKBP_TABLET_MODE	1
 #define EC_MKBP_BASE_ATTACHED	2
+#define EC_MKBP_FRONT_PROXIMITY	3
 
 /* Run keyboard factory test scanning */
 #define EC_CMD_KEYBOARD_FACTORY_TEST 0x0068
-- 
https://chromeos.dev

