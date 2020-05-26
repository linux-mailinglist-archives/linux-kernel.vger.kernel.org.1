Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AE21C2CC4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 May 2020 15:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgECN3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 09:29:37 -0400
Received: from mail.kocurkovo.cz ([185.8.236.170]:59400 "EHLO
        mail.kocurkovo.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgECN3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 09:29:35 -0400
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id 77F6D18CB; Sun,  3 May 2020 15:29:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz 77F6D18CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1588512573;
        bh=E/M1+fpZ9BWdUh/UPu/JUV9VouoTHOw3qfqD6bm6qFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NSkfRasV8wbXhtoGVac4YMgEwq4Y5n4+UvpJ8aO0K2ZmqK29Y0YeD5hiChJ3+f1cE
         Ipuii6E9gE83MW289WXXXzR4ociHbBamYmX6pCVh7o+41KjNrgBV62XP+mYz1uLqTO
         wXZ+dMqxBvfCLysmFMJhnl6fjkaDPcddhSv7ClbU=
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Stefano Brivio <sbrivio@redhat.com>,
        Briana Oursler <briana.oursler@gmail.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Matej Dujava <mdujava@kocurkovo.cz>
Subject: [PATCH 5/5] staging: vt6655: extract index manupulation out of function call
Date:   Sun,  3 May 2020 15:29:12 +0200
Message-Id: <1588512552-12297-6-git-send-email-mdujava@kocurkovo.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588512552-12297-1-git-send-email-mdujava@kocurkovo.cz>
References: <1588512552-12297-1-git-send-email-mdujava@kocurkovo.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will remove if/else by selecting proper argument before
function call, also index is updated before function call.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/vt6655/rxtx.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index c4d62c27f1c1..1e025bb72810 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -266,7 +266,8 @@ s_uGetDataDuration(
 				return 0;
 		} else {
 			/* First Frag or Mid Frag */
-			uNextPktTime = s_uGetTxRsvTime(pDevice, byPktType, len, wRate, bNeedAck);
+			uNextPktTime = s_uGetTxRsvTime(pDevice, byPktType,
+						       len, wRate, bNeedAck);
 		}
 
 		return pDevice->uSIFS + uAckTime + uNextPktTime;
@@ -283,8 +284,8 @@ s_uGetDataDuration(
 				return 0;
 		} else {
 			/* First Frag or Mid Frag */
-			uNextPktTime = s_uGetTxRsvTime(pDevice, byPktType, len,
-						       wRate, bNeedAck);
+			uNextPktTime = s_uGetTxRsvTime(pDevice, byPktType,
+						       len, wRate, bNeedAck);
 		}
 
 		return pDevice->uSIFS + uAckTime + uNextPktTime;
@@ -307,17 +308,15 @@ s_uGetDataDuration(
 			else if (wRate > RATE_54M)
 				wRate = RATE_54M;
 
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
+			wRate -= RATE_18M;
+
+			if (byFBOption == AUTO_FB_0)
+				wRate = wFB_Opt0[FB_RATE0][wRate];
+			else
+				wRate = wFB_Opt1[FB_RATE0][wRate];
+
+			uNextPktTime = s_uGetTxRsvTime(pDevice, byPktType,
+						       len, wRate, bNeedAck);
 		}
 
 		return pDevice->uSIFS + uAckTime + uNextPktTime;
-- 
2.26.2

