Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696A31D733A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 10:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgERIqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 04:46:01 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:35809 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbgERIp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 04:45:59 -0400
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id C8706200013;
        Mon, 18 May 2020 08:45:57 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v2 1/3] tty: n_gsm: Improve debug output
Date:   Mon, 18 May 2020 10:45:15 +0200
Message-Id: <20200518084517.2173242-5-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518084517.2173242-1-gregory.clement@bootlin.com>
References: <20200518084517.2173242-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use appropriate print helpers for debug messages.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/tty/n_gsm.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index d77ed82a4840..67c8f8173023 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -504,18 +504,8 @@ static void gsm_print_packet(const char *hdr, int addr, int cr,
 	else
 		pr_cont("(F)");
 
-	if (dlen) {
-		int ct = 0;
-		while (dlen--) {
-			if (ct % 8 == 0) {
-				pr_cont("\n");
-				pr_debug("    ");
-			}
-			pr_cont("%02X ", *data++);
-			ct++;
-		}
-	}
-	pr_cont("\n");
+	if (dlen)
+		print_hex_dump_bytes("", DUMP_PREFIX_NONE, data, dlen);
 }
 
 
-- 
2.26.2

