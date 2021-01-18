Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DAD2F9737
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 02:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbhARBQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 20:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730718AbhARBL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 20:11:29 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3993EC061575
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 17:10:48 -0800 (PST)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4DJtyG5Vv9z8t4L;
        Mon, 18 Jan 2021 02:10:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1610932246; bh=tOU5+u5r+PpeOQ4Ja2zy94y275lWs5rKsrFHWuB9Amc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=nVahcojRcQQBJ+t15c0nNZJbP63aJQ3idIU/B7zXL1SCSyXFy9pNrM/Ktsi14rTGl
         eCmV6fQGwsWP4hMijqemb3LoVYwLB5+L82c5fc0oizDoBhLgcc70h0hInwp15NP/tN
         8sB7bTdYt1GemHkD4MNOrNBimjvibIPNRQqZoLTE2N6wL63M5JCSk8X6Z0xmBf8Uj7
         HUT1maxlYmkNw+ksrTDEp4Klht19IFO8SPShWktohaV9c3X7pzP3h+MTPEtSCFULno
         tJbK/aXep3R+USTbglJpxK4Nx2m5d77++C4But75UN8kA8Ket3I/s+TeFUyWnLQzrn
         /3DXO4gZD7rGg==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:a62:19b2:a701:a9ea:94f8:dbd1:5695
Received: from shaun-PC.fritz.box (unknown [IPv6:2001:a62:19b2:a701:a9ea:94f8:dbd1:5695])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1+YfPOzNh6NBtIIVDVIXWNyBXjHSf2OTDQ=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4DJtyD1mKVz8t3m;
        Mon, 18 Jan 2021 02:10:44 +0100 (CET)
From:   Johannes Czekay <johannes.czekay@fau.de>
To:     gregkh@linuxfoundation.org
Cc:     nicolai.fischer@fau.de, johannes.czekay@fau.de, jbwyatt4@gmail.com,
        rkovhaev@gmail.com, hqjagain@gmail.com, gustavo@embeddedor.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de
Subject: [PATCH 4/6] wlan-ng: clean up line length
Date:   Mon, 18 Jan 2021 02:09:54 +0100
Message-Id: <20210118010955.48663-5-johannes.czekay@fau.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118010955.48663-1-johannes.czekay@fau.de>
References: <20210118010955.48663-1-johannes.czekay@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up all remaining line length related warnings.

Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
Co-developed-by: Nicolai Fischer <nicolai.fischer@fau.de>
Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
---
 drivers/staging/wlan-ng/cfg80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index bdb1e6677cc7..0e44a0f73a6a 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -365,7 +365,8 @@ static int prism2_scan(struct wiphy *wiphy,
 					  msg2.beaconperiod.data,
 					  ie_buf,
 					  ie_len,
-					  (msg2.signal.data - 65536) * 100, /* Conversion to signed type */
+					  /* Conversion to signed type */
+					  (msg2.signal.data - 65536) * 100,
 					  GFP_KERNEL);
 
 		if (!bss) {
-- 
2.25.1

