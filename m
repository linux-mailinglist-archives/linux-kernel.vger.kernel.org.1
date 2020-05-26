Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72961CF3C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 13:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgELLxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 07:53:33 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:59057 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729560AbgELLxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 07:53:31 -0400
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 22C3540010;
        Tue, 12 May 2020 11:53:30 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v2 2/3] tty: n_gsm: Fix SOF skipping
Date:   Tue, 12 May 2020 13:53:22 +0200
Message-Id: <20200512115323.1447922-3-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512115323.1447922-1-gregory.clement@bootlin.com>
References: <20200512115323.1447922-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For at least some modems like the TELIT LE910, skipping SOF makes
transfers blocking indefinitely after a short amount of data
transferred.

Given the small improvement provided by skipping the SOF (just one
byte on about 100 bytes), it seems better to completely remove this
"feature" than make it optional.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/tty/n_gsm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 67c8f8173023..d8d196645500 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -667,7 +667,6 @@ static void gsm_data_kick(struct gsm_mux *gsm)
 {
 	struct gsm_msg *msg, *nmsg;
 	int len;
-	int skip_sof = 0;
 
 	list_for_each_entry_safe(msg, nmsg, &gsm->tx_list, list) {
 		if (gsm->constipated && msg->addr)
@@ -689,15 +688,10 @@ static void gsm_data_kick(struct gsm_mux *gsm)
 			print_hex_dump_bytes("gsm_data_kick: ",
 					     DUMP_PREFIX_OFFSET,
 					     gsm->txframe, len);
-
-		if (gsm->output(gsm, gsm->txframe + skip_sof,
-						len - skip_sof) < 0)
+		if (gsm->output(gsm, gsm->txframe, len) < 0)
 			break;
 		/* FIXME: Can eliminate one SOF in many more cases */
 		gsm->tx_bytes -= msg->len;
-		/* For a burst of frames skip the extra SOF within the
-		   burst */
-		skip_sof = 1;
 
 		list_del(&msg->list);
 		kfree(msg);
-- 
2.26.2

