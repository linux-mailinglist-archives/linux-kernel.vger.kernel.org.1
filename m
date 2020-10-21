Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5772953AB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 22:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505578AbgJUUxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 16:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505571AbgJUUxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 16:53:53 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B95C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 13:53:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x13so2212193pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 13:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7GA01z5EwqjWWCIJ86y0novmQ01wOcRO4CASfzFgz0c=;
        b=dOmPxkwGh51CL6/dQ31IXZuJ7DlvpZM64PKlPJ46OjjjOomKuKH3jdUom5YiQRUG/9
         XdrGIdfDZUY8tEE8CVfvWID5+C327IF+ioCVkqHg9QuucmOV96C2ZvNstaMvzsXUW1XT
         KVWF5OBI5W3NOZoZxPP7F1tCtQcHAsotqwnD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7GA01z5EwqjWWCIJ86y0novmQ01wOcRO4CASfzFgz0c=;
        b=INZ3q/s0kzE8+x3C6++hUdgfF82kNjqQICfKRYbmpjcV2s/kafdr13k04okijw1Qi5
         ZGJouCB6y3aqbmR6UEJpLkhxjNrXKt8XP4RsAoYYnatDpleKwks42QhBUr5OMggE5sdt
         AMzfjdsHA4ReEdyY+bm8+csiRQfv/R6FsqC3Pk9k09IZAVLwJgNOZFoskQLLl76CA5XM
         ijiKphp1URRnUukG88ioJDrTKMg3aTBlQnNtAC71BuNAk4YC7hKi6EBv1X07zhJWXo1y
         c/VjSJzqTMDFUcBtx+lehUNZW9o34gCvQz96K2GHOvzsrsVnApMuSOx7rKE36wmJwc/l
         yYHg==
X-Gm-Message-State: AOAM533oBFsYZg2Fa2ARt4bz0Pp/darLP5V4aYaHx1uohHX6H2hBz1pM
        Zdx0LQgjm3gv/fkrjJ6vfEtHBL8KEvA6tg==
X-Google-Smtp-Source: ABdhPJxeadRiR2npPuimHGPlWauc/R/yO4i51ODDJEJbDfzokw0O2dBfkxOKy8LWKgNbqamGbayBKw==
X-Received: by 2002:aa7:9f0f:0:b029:155:ef07:6ae0 with SMTP id g15-20020aa79f0f0000b0290155ef076ae0mr5371267pfr.70.1603313632341;
        Wed, 21 Oct 2020 13:53:52 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id q8sm3178087pfg.118.2020.10.21.13.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 13:53:51 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>
Subject: [PATCH 2/7] platform/chrome: cros_ec_typec: Fix remove partner logic
Date:   Wed, 21 Oct 2020 13:53:11 -0700
Message-Id: <20201021205317.708008-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201021205317.708008-1-pmalani@chromium.org>
References: <20201021205317.708008-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cros_unregister_ports() function can be called in situations where
the partner has not been registered yet, and so its related data
structures would not have been initialized. Calling
cros_typec_remove_partner() in such a situation can lead to null pointer
dereferences. So, only call cros_typec_remove_partner() if there is a
valid registered partner pointer.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 49083e21317d..2665d8125910 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -190,7 +190,10 @@ static void cros_unregister_ports(struct cros_typec_data *typec)
 	for (i = 0; i < typec->num_ports; i++) {
 		if (!typec->ports[i])
 			continue;
-		cros_typec_remove_partner(typec, i);
+
+		if (typec->ports[i]->partner)
+			cros_typec_remove_partner(typec, i);
+
 		usb_role_switch_put(typec->ports[i]->role_sw);
 		typec_switch_put(typec->ports[i]->ori_sw);
 		typec_mux_put(typec->ports[i]->mux);
-- 
2.29.0.rc1.297.gfa9743e501-goog

