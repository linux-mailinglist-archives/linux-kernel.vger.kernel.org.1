Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E59320C5E8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 06:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgF1EcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 00:32:01 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34354 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgF1Ebt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 00:31:49 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 126552970E; Sun, 28 Jun 2020 00:31:44 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Joshua Thompson <funaho@jurai.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Laurent Vivier <lvivier@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-Id: <ca5be30ba745c08c2b7a1f0618f99c61b303e983.1593318192.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1593318192.git.fthain@telegraphics.com.au>
References: <cover.1593318192.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 7/9] macintosh/via-macii: Use unsigned type for autopoll_devs
 variable
Date:   Sun, 28 Jun 2020 14:23:12 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/via-macii.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
index e143ddb81de34..447273967e1e8 100644
--- a/drivers/macintosh/via-macii.c
+++ b/drivers/macintosh/via-macii.c
@@ -125,7 +125,7 @@ static bool srq_asserted;    /* have to poll for the device that asserted it */
 static u8 last_cmd;              /* the most recent command byte transmitted */
 static u8 last_talk_cmd;    /* the most recent Talk command byte transmitted */
 static u8 last_poll_cmd; /* the most recent Talk R0 command byte transmitted */
-static int autopoll_devs;      /* bits set are device addresses to be polled */
+static unsigned int autopoll_devs;  /* bits set are device addresses to poll */
 
 /* Check for MacII style ADB */
 static int macii_probe(void)
@@ -291,7 +291,7 @@ static int macii_autopoll(int devs)
 	local_irq_save(flags);
 
 	/* bit 1 == device 1, and so on. */
-	autopoll_devs = devs & 0xFFFE;
+	autopoll_devs = (unsigned int)devs & 0xFFFE;
 
 	if (!current_req) {
 		macii_queue_poll();
-- 
2.26.2

