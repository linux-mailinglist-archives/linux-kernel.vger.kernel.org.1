Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DEC29F7F2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 23:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgJ2W2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 18:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgJ2W2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 18:28:16 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6CCC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:28:16 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t6so1978132plq.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5KKaFyJwLwRzD3/IcJW8pGVSfEdftS81GR+xSNbLl58=;
        b=UG3qVgBBUqb7s00RzxtPmTY0atXP8UPKzzRd0WzLoqecLLo2mf8uWqxjxErwcfdnNJ
         fs+QW/noQ9RVbPrtNe4TmBTNaXiAaRq73vURu3kgbvlUofwhqkOtcEn+dDj9anvYWA2u
         Tvk17XHOwWQJt3/n540sH3T22EKpa4K5cSxTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5KKaFyJwLwRzD3/IcJW8pGVSfEdftS81GR+xSNbLl58=;
        b=d7T+X/zmctJ4NkZ9aVtu/Ac3/39SYsyKLdKrIB0HoaaP5RE+LjNCJEaFxKW/l+0guz
         xP35TrU/S6dk07pXnX7mzqoxEtJiiTcInYdCPLn4LPtWT5lPIdWEtd0NCKKp5WhUAbov
         A/FeLW16EDwZ+RQSNSD1+VKWYlDJA/75pJzBmbnuuYk3NA42vmQguHVz+cLIWPT01HU4
         iQ3pwBYDYT0O7C8HdY3D1Z/soRFNFmzzimTvKniftr9revwwGxK563LAyxdF6a5Ns0D5
         8S69I6pzpKAGYoLdWuaGGsriv8pzWKIDwTuJrt9+XOSiXsd0aiPZTiYA3LnkDU1rhheJ
         GNoA==
X-Gm-Message-State: AOAM531r0dAz1ZzbR3wd3spY5ohQjRaYAdsUjMrdSA7HB8u5smIrGcdk
        WcsUx+t5gdzGro0FAtUgegyU8SMR5tTmXw==
X-Google-Smtp-Source: ABdhPJx1O1M0ivzU8nruqkyToYUiYtV5EorNJ+CSYE2THPBng9XNcyDiY0ejj3J+L+XUau8KDoVuTQ==
X-Received: by 2002:a17:902:9a43:b029:d6:224e:5396 with SMTP id x3-20020a1709029a43b02900d6224e5396mr5968141plv.30.1604010495260;
        Thu, 29 Oct 2020 15:28:15 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id f5sm3573886pgi.86.2020.10.29.15.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 15:28:14 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, dzigterman@chromium.org,
        alevkoy@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>
Subject: [PATCH v2 2/7] platform/chrome: cros_ec_typec: Fix remove partner logic
Date:   Thu, 29 Oct 2020 15:27:32 -0700
Message-Id: <20201029222738.482366-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201029222738.482366-1-pmalani@chromium.org>
References: <20201029222738.482366-1-pmalani@chromium.org>
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

Changes in v2:
- No changes.

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
2.29.1.341.ge80a0c044ae-goog

