Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5522A1ED3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 15:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgKAO5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 09:57:44 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:44004 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgKAO5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 09:57:43 -0500
Received: from tomoyo.flets-east.jp ([153.230.197.127])
        by mwinf5d06 with ME
        id n2xU230022lQRaH032xfSm; Sun, 01 Nov 2020 15:57:41 +0100
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sun, 01 Nov 2020 15:57:41 +0100
X-ME-IP: 153.230.197.127
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-kernel@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] cangen: flush the CAN frame at each iteration
Date:   Sun,  1 Nov 2020 23:57:12 +0900
Message-Id: <20201101145712.489795-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'frame' is declared on the stack and is reused at each
iteration of the while loop.

If not flushed, garbage data from the previous iteration of the loop
could remain causing unexpected behavior. This is the case in DLC
random mode: the field frame.len8_dlc is not cleared when the dlc is
exactly 8 and the len8_dlc value of the previous iteration will be
sent again.

This can be observed by running 'cangen -8 can0'. Once a frame of DLC
in the range 9..15 is generated, no more frames of DLC 8 show out in
the log.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 cangen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cangen.c b/cangen.c
index ab8122c..d7392b6 100644
--- a/cangen.c
+++ b/cangen.c
@@ -384,7 +384,7 @@ int main(int argc, char **argv)
 	}
 
 	while (running) {
-		frame.flags = 0;
+		memset(&frame, 0, sizeof(frame));
 
 		if (count && (--count == 0))
 			running = 0;
-- 
2.26.2

