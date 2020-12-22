Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2EA2E1049
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 23:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgLVW3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 17:29:40 -0500
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:43489 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728094AbgLVW3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 17:29:37 -0500
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Dec 2020 17:29:36 EST
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4D0rRP3rYGzPkYV;
        Tue, 22 Dec 2020 23:21:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1608675713; bh=tOU5+u5r+PpeOQ4Ja2zy94y275lWs5rKsrFHWuB9Amc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=Bah0e8jQ0V6xd7s3/2CxooLQ+tkUDK41nujDQdmWJYdo46aIRTw0Cbm2tI1t1hMpa
         T7+CJ9xdYfN9h6lSRUsBnQXCAVHKSG5FpGcw7zUjVtSBDTWq7R77wZQoy0oQxBgvmg
         xeG+a/Vn8zN6bXZ+/eAWlwQX6y4rpDRRNCVBsaNCVQZDKzZYPsmhv/CRE4HWgcPg3y
         qt9Xh1L758Q3IvmN5woeWbfHL6zxHKHjis4kIHRyuA90O3RM2mlDxg254vSvjzswEm
         erBh02hYO6ImqZxt0/ikfN9nS6OvymUuFvwJ3DTq7LiwI+ePGw9g8MYbWmG0Z0QKsF
         qZGgPZJXNMo2Q==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:a62:19fa:6f01:10d5:3d50:1797:6266
Received: from shaun-PC.fritz.box (unknown [IPv6:2001:a62:19fa:6f01:10d5:3d50:1797:6266])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX18HSbREgD5KdeYSFWnRIISS19Xk+6z6FsE=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4D0rRL6HXVzPkgy;
        Tue, 22 Dec 2020 23:21:50 +0100 (CET)
From:   Johannes Czekay <johannes.czekay@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     johannes.czekay@fau.de, nicolai.fischer@fau.de,
        gustavo@embeddedor.com, hannes@cmpxchg.org, longman@redhat.com,
        mhocko@suse.com, adawesomeguy222@gmail.com,
        igormtorrente@gmail.com, sylphrenadin@gmail.com,
        izabela.bakollari@gmail.com, colin.king@canonical.com,
        steff.richards.the.third@gmail.com
Subject: [PATCH 4/6] wlan-ng: clean up line length
Date:   Tue, 22 Dec 2020 23:20:15 +0100
Message-Id: <20201222222015.20558-5-johannes.czekay@fau.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201222222015.20558-1-johannes.czekay@fau.de>
References: <20201222222015.20558-1-johannes.czekay@fau.de>
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

