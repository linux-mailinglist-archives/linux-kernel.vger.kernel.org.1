Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CDA2C47B1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 19:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732700AbgKYSeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 13:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbgKYSeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 13:34:20 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A49BC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 10:34:20 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id u2so1519983pls.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 10:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yWQcjslDzYzKvIp9nzAc38QNror6q58kNCdn1VdyzRc=;
        b=CRLuRxjVc/WeMACD0S2gg9CwudFOVjuJwbHz+rEqyOE95i0lsZ6K2VsP3v+YmB8tt3
         ctvpk5AkxYjAMMHo0eAZwm6r3xsVtNTK1FfaApbei0usWntPksiHO/FU92+krrbZl/AC
         uphYR5uWTmH+5wFPoE5E68WE2rVq76p8pDF3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yWQcjslDzYzKvIp9nzAc38QNror6q58kNCdn1VdyzRc=;
        b=BszGrUhnwq6nSRhtowfZ37t3Dd3OqUSCwnPFVxEXBXBARhykPQ1idQEwRwmCNuaHkN
         ThxyWycKkqv4AjLkAzoIdAg4+L9C9QkF/pJ5PxRobOKqtxAOVK5b/Oyd2jqsTbKss1Ow
         Bcpr5R3CLnHC66vqjzsV3Jw3nwFQXBNP2XpS2O9ZZoHRbgZoV7pj7XLkYoGwBRpHbnKe
         wkwX0JFmne4/JPOZDRewpHyMZ+tM2x/Kri9q79vGbFpfwDwxOyPiKOEN/j4ampAKZgMe
         0UWX5alAEBIonUPtpduc8J1pFGJ+OYno/fwEOvwHXeeDtQ9tMfaGyA+MJYPEcbhTuaWZ
         wnag==
X-Gm-Message-State: AOAM5313bEupFbeUjC3xJednxpZaDAQiiUtiiy8IkB71U7Lbs1PbqmKt
        g68lt/kbm1+apfSgBrQxN8h9o7IBmdL/Tg==
X-Google-Smtp-Source: ABdhPJyl0UhKkoZlTxHiiKq0i33pBci2gW+UZ00DDoQLeuGx/6izaeyzMXqcdpEoP8yTJURjy5TUgQ==
X-Received: by 2002:a17:902:a5c7:b029:d8:edae:f4ea with SMTP id t7-20020a170902a5c7b02900d8edaef4eamr3553297plq.75.1606329259296;
        Wed, 25 Nov 2020 10:34:19 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id t85sm2428675pgb.29.2020.11.25.10.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 10:34:18 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec_typec: Decouple cable remove on disconnect
Date:   Wed, 25 Nov 2020 10:34:08 -0800
Message-Id: <20201125183408.1259669-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Type C cable objects are independent of partner objects. Don't return
if a partner object is not registered (mostly in the case of an error
while registering a partner), and instead treat the removal of partner
and cable objects on disconnect independently.

Cc: Benson Leung <bleung@chromium.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

This patch should be applied on top of the series[1] which adds support
for cable & plugs to cros-ec-typec.

[1]
https://lore.kernel.org/linux-usb/20201116201150.2919178-1-pmalani@chromium.org/

 drivers/platform/chrome/cros_ec_typec.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 65c5d0090ccd..8294486908ca 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -626,9 +626,8 @@ static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
 				 "Failed to register partner on port: %d\n",
 				 port_num);
 	} else {
-		if (!typec->ports[port_num]->partner)
-			return;
-		cros_typec_remove_partner(typec, port_num);
+		if (typec->ports[port_num]->partner)
+			cros_typec_remove_partner(typec, port_num);
 
 		if (typec->ports[port_num]->cable)
 			cros_typec_remove_cable(typec, port_num);
-- 
2.29.2.454.gaff20da3a2-goog

