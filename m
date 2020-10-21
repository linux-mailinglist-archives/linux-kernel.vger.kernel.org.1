Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696372953AC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 22:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505586AbgJUUyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 16:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505571AbgJUUyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 16:54:00 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0B8C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 13:53:58 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id e7so2191804pfn.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 13:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JJxaion4PRsh/UJLRpXSDkoX2SykqPQRFZqt+cfIUGU=;
        b=IOhUEu7vTTlycKyWytoCUwnseGh/5991tEAbwieHPkw44npqk5r58um1e8OJkn3Cl6
         yqk2DmGBE0I2jwiLeV3mFB2gZ8Awws58Wfzd21XiicKH2muT+WKoX7aYNl6MtchKqj7L
         Z170P0NAI20lrcrDXm2olgrwemNEnwE/Phv2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JJxaion4PRsh/UJLRpXSDkoX2SykqPQRFZqt+cfIUGU=;
        b=QiTdzF5Elp6Xh/EWgxO1jnDy0fWRAhh6kTWkGrS1trlS3mI296XLBsGw/HoCnJH6wp
         Olwjt9cvhbppeg73lHLJN51xfqIjvN9QUe/FH/MfBxxIh822T00FZ3JROVnHAi98HUtM
         H8JT/Ih7szqCZrTCowFjzzaTI3aqHf6IewTVgn2Q2PFFpaQAHkJw1uCklM63NgrkhLBM
         NTXhdhMQk7tbJgjFxOCAdWnfOTS7R20bTP++sTlcEQW0Yw1zyEkXpDKWjnb/oeFgwZRd
         SiidZ6Y8yWpj/0NjVnBoBhmHJSWtyXks+7Cd2Gjl0fJF52vU2si6z+qbI66+IBP7mdd1
         Vlhg==
X-Gm-Message-State: AOAM533HcI9wcd46IgO4Rgizg79hLu1Ffr98ZkEKIuk53lnvlQt18ZOS
        bUO+g2GFy8kpokZc895ta+PozqGW2P/42w==
X-Google-Smtp-Source: ABdhPJwqv9966TtS5rtgX21/aFkB4dwtioZSxI8mnURZs2+y/2e+fyIvYf8LkYx4wh6bJDuSa1hTew==
X-Received: by 2002:aa7:85c3:0:b029:156:78e8:1455 with SMTP id z3-20020aa785c30000b029015678e81455mr5335264pfn.68.1603313637961;
        Wed, 21 Oct 2020 13:53:57 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id q8sm3178087pfg.118.2020.10.21.13.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 13:53:57 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 3/7] platform/chrome: cros_ec_typec: Clear partner identity on device removal
Date:   Wed, 21 Oct 2020 13:53:12 -0700
Message-Id: <20201021205317.708008-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201021205317.708008-1-pmalani@chromium.org>
References: <20201021205317.708008-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The partner identity struct isn't reset when a partner is removed,
meaning a subsequent partner can inherit an old partner's identity VDOs
before discovery is complete. So, clear that struct when a partner
removal is detected.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 2665d8125910..faef56bcb9c5 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -181,6 +181,7 @@ static void cros_typec_remove_partner(struct cros_typec_data *typec,
 
 	typec_unregister_partner(port->partner);
 	port->partner = NULL;
+	memset(&port->p_identity, 0, sizeof(port->p_identity));
 }
 
 static void cros_unregister_ports(struct cros_typec_data *typec)
-- 
2.29.0.rc1.297.gfa9743e501-goog

