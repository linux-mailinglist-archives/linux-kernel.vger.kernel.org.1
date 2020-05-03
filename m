Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405891C2DA0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 May 2020 17:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgECPnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 11:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbgECPnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 11:43:18 -0400
Received: from mail.kocurkovo.cz (unknown [IPv6:2a02:2b88:2:1::5b29:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B69DC061A10
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 08:43:17 -0700 (PDT)
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id ED15C18FF; Sun,  3 May 2020 17:43:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz ED15C18FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1588520594;
        bh=dsnpnhjrUHSaXiLLDmToUkfJQoMhJ20hDN9zjO5mUkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dNl8rEgHTdjcTOYqUrmg3v2b5wHHcXb1BdxBabqikOyXK123vafgx2aoXqE6xWS3D
         lwtXfjrXONakQmZ+13MXj9HCpugFjjBeOsb5E+nwqpQ4RQhbJOdY3rx37EkBfX84H1
         5fMCEQbhw6lYLbpVaYJwiCwkxGoS02e251iPGFI4=
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Stefano Brivio <sbrivio@redhat.com>,
        Briana Oursler <briana.oursler@gmail.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Matej Dujava <mdujava@kocurkovo.cz>
Subject: [PATCH v2 2/2] staging: vt6655: fix LONG_LINE warning
Date:   Sun,  3 May 2020 17:42:50 +0200
Message-Id: <1588520570-14388-3-git-send-email-mdujava@kocurkovo.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588520570-14388-1-git-send-email-mdujava@kocurkovo.cz>
References: <1588520570-14388-1-git-send-email-mdujava@kocurkovo.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will fix LONG_LINE error from checkpatch, by using ternary
operator.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/vt6655/rxtx.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index dda578436e64..994c19f1de43 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -170,10 +170,14 @@ s_uGetTxRsvTime(
 	if (!bNeedAck)
 		return uDataTime;
 
-	if (byPktType == PK_TYPE_11B) /* llb,CCK mode */
-		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, (unsigned short)pDevice->byTopCCKBasicRate);
-	else /* 11g 2.4G OFDM mode & 11a 5G OFDM mode */
-		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, (unsigned short)pDevice->byTopOFDMBasicRate);
+	/*
+	 * CCK mode  - 11b
+	 * OFDM mode - 11g 2.4G & 11a 5G
+	 */
+	uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14,
+				     byPktType == PK_TYPE_11B ?
+				     pDevice->byTopCCKBasicRate :
+				     pDevice->byTopOFDMBasicRate);
 
 	return uDataTime + pDevice->uSIFS + uAckTime;
 }
-- 
2.26.2

