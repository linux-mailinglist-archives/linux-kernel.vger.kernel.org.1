Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF722F9735
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 02:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbhARBPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 20:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730684AbhARBLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 20:11:24 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7820C061574
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 17:10:42 -0800 (PST)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4DJty934QMz8t2t;
        Mon, 18 Jan 2021 02:10:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1610932241; bh=n0czzUvvt3SkCFICCpWB9oK3QXru4vyuSDr/GChrA1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=dVmrQVRFrOGr2o3Uj+D8e7g5iqo8kHyw1vggN42Jx2CP2P4/Mg0pGh6SEDzq0CDBE
         Uz3R+wJEVqCLYIpCE3d70QDA41zLtfhEkdpCHn9x9XJcntEWeXxbqQecnlQuDa412h
         szESW+Do/sZTrFm0yHATjsX5eXaipuqhdVWJye99CQ0dB2cwWjfwlS3QkbxC6TsEGH
         r5qgP+jP+ln57sL6Ia4+tpRhrhlApYX+EGCrFpE5Li4UmciFZfnu2i+FJ+5aBd6yjL
         wG1lURpDnoPAF4ZU1tCzhbYXZHkVYWqLaOXODXfi9fWmsXV7vc5ikKWAX4VGCvR5Yg
         FBPMxODRalZ/Q==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:a62:19b2:a701:a9ea:94f8:dbd1:5695
Received: from shaun-PC.fritz.box (unknown [IPv6:2001:a62:19b2:a701:a9ea:94f8:dbd1:5695])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1+R1aihkTEQ2UXjbBWOjrjWzJVBRo+GUAc=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4DJty66HCyz8spV;
        Mon, 18 Jan 2021 02:10:38 +0100 (CET)
From:   Johannes Czekay <johannes.czekay@fau.de>
To:     gregkh@linuxfoundation.org
Cc:     nicolai.fischer@fau.de, johannes.czekay@fau.de, jbwyatt4@gmail.com,
        rkovhaev@gmail.com, hqjagain@gmail.com, gustavo@embeddedor.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de
Subject: [PATCH 2/6] wlan-ng: clean up spinlock_t definition
Date:   Mon, 18 Jan 2021 02:09:52 +0100
Message-Id: <20210118010955.48663-3-johannes.czekay@fau.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118010955.48663-1-johannes.czekay@fau.de>
References: <20210118010955.48663-1-johannes.czekay@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up a "spinlock_t definition without comment" warning in
hfa384x.h.

Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
Co-developed-by: Nicolai Fischer <nicolai.fischer@fau.de>
Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
---
 drivers/staging/wlan-ng/hfa384x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/hfa384x.h b/drivers/staging/wlan-ng/hfa384x.h
index 88e894dd3568..13ab9545a066 100644
--- a/drivers/staging/wlan-ng/hfa384x.h
+++ b/drivers/staging/wlan-ng/hfa384x.h
@@ -1184,7 +1184,7 @@ struct hfa384x_usbctlx {
 };
 
 struct hfa384x_usbctlxq {
-	spinlock_t lock;
+	spinlock_t lock;	/* Lock for CTLX que */
 	struct list_head pending;
 	struct list_head active;
 	struct list_head completing;
-- 
2.25.1

