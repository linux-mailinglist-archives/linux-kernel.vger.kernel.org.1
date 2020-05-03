Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C131C2CC2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 May 2020 15:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgECN3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 09:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728631AbgECN3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 09:29:30 -0400
Received: from mail.kocurkovo.cz (unknown [IPv6:2a02:2b88:2:1::5b29:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5435EC061A0F
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 06:29:30 -0700 (PDT)
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id 25FD218FF; Sun,  3 May 2020 15:29:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz 25FD218FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1588512564;
        bh=AFyRxD9BU6cVNLrSCjghBgVzm+iB1gkng47LzmGhZ2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aF0OMyfikviv7C/CjIl/pHTSTAh4q6oI/7BtlSyDP+ioQ/Okz3Fm8qPu3c+ilbzrT
         KOanTkmi/PLdQG+bkjoI9JSbJ0wimAu5qOK2vV88uehlJbymZeMj3p2XDPG5sVNywJ
         +KzTEaaQjYSJVM5c0T/NEWe/JJ4ZnygZ42jtiWeQ=
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Stefano Brivio <sbrivio@redhat.com>,
        Briana Oursler <briana.oursler@gmail.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Matej Dujava <mdujava@kocurkovo.cz>
Subject: [PATCH 1/5] staging: vt6655: merge two switch cases in s_uGetDataDuration
Date:   Sun,  3 May 2020 15:29:08 +0200
Message-Id: <1588512552-12297-2-git-send-email-mdujava@kocurkovo.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588512552-12297-1-git-send-email-mdujava@kocurkovo.cz>
References: <1588512552-12297-1-git-send-email-mdujava@kocurkovo.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will reuse code for two cases.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/vt6655/rxtx.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 2f9c2ead3cb8..28f0cda36dec 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -296,40 +296,6 @@ s_uGetDataDuration(
 		break;
 
 	case DATADUR_A_F0:    /* DATADUR_A_F0 */
-		if (((uMACfragNum == 1)) || bLastFrag) {/* Non Frag or Last Frag */
-			if (bNeedAck) {
-				uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopOFDMBasicRate);
-				return pDevice->uSIFS + uAckTime;
-			} else {
-				return 0;
-			}
-		} else { /* First Frag or Mid Frag */
-			if (wRate < RATE_18M)
-				wRate = RATE_18M;
-			else if (wRate > RATE_54M)
-				wRate = RATE_54M;
-
-			if (byFBOption == AUTO_FB_0) {
-				uNextPktTime = s_uGetTxRsvTime(pDevice,
-							       byPktType, len,
-							       wFB_Opt0[FB_RATE0][wRate - RATE_18M],
-							       bNeedAck);
-			} else {
-				uNextPktTime = s_uGetTxRsvTime(pDevice,
-							       byPktType, len,
-							       wFB_Opt1[FB_RATE0][wRate - RATE_18M],
-							       bNeedAck);
-			}
-
-			if (bNeedAck) {
-				uAckTime = bb_get_frame_time(pDevice->byPreambleType,
-							     byPktType, 14,
-							     pDevice->byTopOFDMBasicRate);
-			}
-			return pDevice->uSIFS + uAckTime + uNextPktTime;
-		}
-		break;
-
 	case DATADUR_A_F1:    /* DATADUR_A_F1 */
 		if (((uMACfragNum == 1)) || bLastFrag) { /* Non Frag or Last Frag */
 			if (bNeedAck) {
-- 
2.26.2

