Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B4F1BF6E8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 13:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgD3LfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 07:35:08 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44963 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgD3LfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:35:04 -0400
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B963360005;
        Thu, 30 Apr 2020 11:35:01 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 1/3] tty: n_gsm: Improve debug output
Date:   Thu, 30 Apr 2020 13:34:30 +0200
Message-Id: <20200430113433.2162886-2-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200430113433.2162886-1-gregory.clement@bootlin.com>
References: <20200430113433.2162886-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use appropriate print helpers for debug messages.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/tty/n_gsm.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index d77ed82a4840..4965e39e0223 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -459,7 +459,7 @@ static void gsm_print_packet(const char *hdr, int addr, int cr,
 	if (!(debug & 1))
 		return;
 
-	pr_info("%s %d) %c: ", hdr, addr, "RC"[cr]);
+	pr_debug("%s %d) %c: ", hdr, addr, "RC"[cr]);
 
 	switch (control & ~PF) {
 	case SABM:
@@ -504,18 +504,10 @@ static void gsm_print_packet(const char *hdr, int addr, int cr,
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
+
+	pr_debug("\n");
 }
 
 
-- 
2.26.1

