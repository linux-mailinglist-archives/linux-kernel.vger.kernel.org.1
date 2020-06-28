Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DC620C5E7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 06:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgF1Eb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 00:31:57 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34356 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgF1Ebt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 00:31:49 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 7CEFD2972A; Sun, 28 Jun 2020 00:31:45 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Joshua Thompson <funaho@jurai.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Laurent Vivier <lvivier@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-Id: <a40f80dde90991757007b6962c386a208c970586.1593318192.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1593318192.git.fthain@telegraphics.com.au>
References: <cover.1593318192.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 8/9] macintosh/via-macii: Use the stack for reset request
 storage
Date:   Sun, 28 Jun 2020 14:23:12 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adb_request struct can be stored on the stack because the request
is synchronous and is completed before the function returns.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/via-macii.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
index 447273967e1e8..2f9be4ec7d345 100644
--- a/drivers/macintosh/via-macii.c
+++ b/drivers/macintosh/via-macii.c
@@ -313,7 +313,7 @@ static void macii_poll(void)
 /* Reset the bus */
 static int macii_reset_bus(void)
 {
-	static struct adb_request req;
+	struct adb_request req;
 
 	/* Command = 0, Address = ignored */
 	adb_request(&req, NULL, ADBREQ_NOSEND, 1, ADB_BUSRESET);
-- 
2.26.2

