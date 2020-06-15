Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CBE1FA3F6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 01:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgFOXNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 19:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgFOXNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:13:08 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CD8D2068E;
        Mon, 15 Jun 2020 23:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592262788;
        bh=HGJzoC5XExSt4wsgEPUS6ZDs+czaXfcrRPmazD8rgiE=;
        h=Date:From:To:Cc:Subject:From;
        b=TSVprE2cHcnj3VQS/DYhJcGT/tVAu1KwGLoLZG0+K6bFoqo5kxrPn2ZR0CtyC1ZG1
         VwEEJLiIfovpjuTT/DXSnK1hdpgl0YFErq/nrn8qaVNarJjqrMdhIb7mIgaZ9Dnhzx
         KBk9ABBgvakiwxpgZBObfI+bmaBcHHYwNryUiudw=
Date:   Mon, 15 Jun 2020 18:18:27 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Thomas Winischhofer <thomas@winischhofer.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] usb: sisusb_con: Use array_size() helper in memcpy()
Message-ID: <20200615231827.GA21348@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use array_size() helper instead of the open-coded version in memcpy().
These sorts of multiplication factors need to be wrapped in array_size().

This issue was found with the help of Coccinelle and, audited and fixed
manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/usb/misc/sisusbvga/sisusb_con.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index cd0155310fea..586d6b01c3c4 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -1226,7 +1226,7 @@ sisusbcon_font_set(struct vc_data *c, struct console_font *font,
 		sisusb->font_backup = vmalloc(array_size(charcount, 32));
 
 	if (sisusb->font_backup) {
-		memcpy(sisusb->font_backup, font->data, charcount * 32);
+		memcpy(sisusb->font_backup, font->data, array_size(charcount, 32));
 		sisusb->font_backup_size = charcount;
 		sisusb->font_backup_height = font->height;
 		sisusb->font_backup_512 = (charcount == 512) ? 1 : 0;
-- 
2.27.0

