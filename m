Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB81E2C7171
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390988AbgK1Vvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:51:45 -0500
Received: from relay-us1.mymailcheap.com ([51.81.35.219]:51596 "EHLO
        relay-us1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbgK1SyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:54:12 -0500
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 6923C20E7F
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 12:53:35 +0000 (UTC)
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.156])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 89660260EB
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 12:53:33 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id 485993F162;
        Sat, 28 Nov 2020 13:53:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 6A7EC2A0E7;
        Sat, 28 Nov 2020 07:53:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1606568011;
        bh=haVbWWtOlmfffJSZ2e1CSTbj+zcqJYd/xyQWDJ2MCtk=;
        h=From:To:Cc:Subject:Date:From;
        b=uTPNSS3uTThsnAL3ljU2Y3pHsA/OFScmEHqRmeNAYR5/+V5+ohz6XiW9oTcKV7D3q
         1CsOzpW7Fun6vhY4ZD5amyC4Fuld3Qvw4MafbyIP/gWiDieqG3VjfeMqXBKHnj35HQ
         H2DxPVB0rYqBxyRXYiTQhNUhWsZoxdDNkR8sjf6Q=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BbM23_V9wgP1; Sat, 28 Nov 2020 07:53:30 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Sat, 28 Nov 2020 07:53:30 -0500 (EST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id C0F53400D3;
        Sat, 28 Nov 2020 12:53:28 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="Q+2gjec4";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.160.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id A1AFB400D3;
        Sat, 28 Nov 2020 12:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1606568004; bh=haVbWWtOlmfffJSZ2e1CSTbj+zcqJYd/xyQWDJ2MCtk=;
        h=From:To:Cc:Subject:Date:From;
        b=Q+2gjec4r2+daWzwCGSAM6bOPavOPnTSgDAi8khHoeQwlB1IzUqFNk3OnF+dRVZ9S
         vAWJATwxnu6aSrEcrREzsZhuQGl4TR3XjHHVqhD2pPfBVXSvGa+qeZJELIGOt8rIsa
         iXwHTlvRZJ+w9ZpD9mTrDAaPHx6Pl54mwirbLrQg=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH] drm/panel: feiyang-fy07024di26a30d: cleanup if panel attaching failed
Date:   Sat, 28 Nov 2020 20:52:57 +0800
Message-Id: <20201128125257.1626588-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C0F53400D3
X-Spamd-Result: default: False [6.40 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[8];
         FREEMAIL_TO(0.00)[amarulasolutions.com,gmail.com,ravnborg.org,linux.ie,ffwll.ch];
         RCVD_NO_TLS_LAST(0.10)[];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.160.1:received];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         FROM_HAS_DN(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         MID_CONTAINS_FROM(1.00)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attaching the panel can fail, so cleanup work is necessary, otherwise
a pointer to freed struct drm_panel* will remain in drm_panel code.

Do the cleanup if panel attaching failed.

Fixes: 69dc678abc2b ("drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD panel")
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
index 581661b506f8..f9c1f7bc8218 100644
--- a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
+++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
@@ -227,7 +227,13 @@ static int feiyang_dsi_probe(struct mipi_dsi_device *dsi)
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->lanes = 4;
 
-	return mipi_dsi_attach(dsi);
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		drm_panel_remove(&ctx->panel);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int feiyang_dsi_remove(struct mipi_dsi_device *dsi)
-- 
2.28.0
