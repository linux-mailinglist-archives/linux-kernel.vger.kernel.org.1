Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583BA301062
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbhAVW43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbhAVWz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:55:26 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B852C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:54:46 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id x18so4136903pln.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j0LasHSBnsU3ALa272OyzYW+m4IQeUHlxwjuI1lE7wc=;
        b=l61fsFVT55ER/uY1P3mwzHyLwC1W87awzd6Dp/3lk2Y7nNXpW3DC4xruHcQJAalb1f
         PGppOOO1PdS7l4oOIKiBgleTHh417oAwkkf7JPsscyjAouEeJR5DegS6Haj/YE2APhO5
         rayVlkq07lYMJv1XJbOEQLiF7dn72sobkigVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j0LasHSBnsU3ALa272OyzYW+m4IQeUHlxwjuI1lE7wc=;
        b=eCYbD9uHw3ONZr1cKDsGm0eCKxba4B4Y0v55Ab2lZ7886zrskiVWpJjdSsXUz9jnyX
         urzWUZRYqtHOPQeZb2+HE0QHIa/hQMeG+Pd70XU5s0QT+oT+MO41rGOd0HrMhyYrZkDL
         1Y4duNlSV9Rkw6LdlHe8ceG8aoKckNoSP5GSe7+YjXr1IpbcsCXuRqDo5Z+F4gEbUpXb
         j2tOK6/5dv8YQbBsJeQdA4E08yxC5X9mmgVIgQP6M2rzZ53FhwuKgcaMfdVZgki2SEeX
         EjdRP8YI/imuBg8X8Db59YF5VZHslivj50UBNmp7AkacxaGNPYeDBRdpHxz8Faw2oW8O
         dkSQ==
X-Gm-Message-State: AOAM530JkYSTorkSj+E6tmLCAFo605l6zbHSUcTFDUIvv9SpgE3GB3vf
        nBwIzw08ehsF24/Ip7nn4qvdUQ==
X-Google-Smtp-Source: ABdhPJx1GE+cAzohLx9FhplLoHll9MTQgivrWMFfHJ1Lw/J7mw7P7OmVZC+yjTHq0PzBMSSTeE6tHA==
X-Received: by 2002:a17:902:ed88:b029:de:86f9:3e09 with SMTP id e8-20020a170902ed88b02900de86f93e09mr6934856plj.38.1611356086257;
        Fri, 22 Jan 2021 14:54:46 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id i62sm6433509pfe.84.2021.01.22.14.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 14:54:45 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 1/3] platform/chrome: cros_ec: Add SW_FRONT_PROXIMITY MKBP define
Date:   Fri, 22 Jan 2021 14:54:41 -0800
Message-Id: <20210122225443.186184-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210122225443.186184-1-swboyd@chromium.org>
References: <20210122225443.186184-1-swboyd@chromium.org>
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

