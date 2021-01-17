Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22F52F95AD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 22:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbhAQV5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 16:57:04 -0500
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21472 "EHLO
        sender4-of-o54.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbhAQV5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 16:57:02 -0500
X-Greylist: delayed 982 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jan 2021 16:57:01 EST
ARC-Seal: i=1; a=rsa-sha256; t=1610919597; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=nyJ24zOxPiKzVNbDBlG60xspzOBS7ff56308ZBwX06tAJldoSAbFAhjKTh1BEe2BVoWzxnQZbols/iRPQuf/Cn+45ecX4AkxPYZGooihaBuwGGOP0pE/FuHR61jbbCyDoJmdPm1P3YIZPfJ5c9sPy3R5R7RXo3Du1CwAvjfzE9A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1610919597; h=Content-Type:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=2UkjfWZ+OoxPT4m00Bj28JkWgSAu+k2ri07tPeK/R90=; 
        b=mvufrIV66gtSxLJHsqCIb6YT6K9tahMQnxsDsZ67ChD4WDs59pnCcjq9jbhfn7FbZNl9+IbRiNI193cTwsKnLg80DacK0sgSIRoc0Cy713qLIyFXGDWMWKkAuOBT2+CFwMZe/W5oBMhiK9YcaDv0cHCshbr2ah3AJMF/K2y7+YM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=jeremyfiggins.com;
        spf=pass  smtp.mailfrom=jeremy@jeremyfiggins.com;
        dmarc=pass header.from=<kernel@jeremyfiggins.com> header.from=<kernel@jeremyfiggins.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1610919597;
        s=zoho; d=jeremyfiggins.com; i=kernel@jeremyfiggins.com;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        bh=2UkjfWZ+OoxPT4m00Bj28JkWgSAu+k2ri07tPeK/R90=;
        b=S1Zpa4JF0Kk9wxKvPCZn5Yt2w0LXRingMoVxFLS8fG7N+fzQBdoElzssGVcG8Ysq
        6KIN0xL8WlVhnfFUW21qikqsmdlFXbSdscHAyEOxGeDrVUTr4PTVSkvc04CTCQ74Trz
        r0wr2VQUSwoQcCjz1yR0pS8vipggPkJyf5KI/qHY=
Received: from watson (cpe-173-174-84-94.austin.res.rr.com [173.174.84.94]) by mx.zohomail.com
        with SMTPS id 161091959521946.328997998992236; Sun, 17 Jan 2021 13:39:55 -0800 (PST)
Date:   Sun, 17 Jan 2021 15:39:53 -0600
From:   Jeremy Figgins <kernel@jeremyfiggins.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] USB: usblp: add USBLP_QUIRK_NO_SET_INTF flag
Message-ID: <YASuqbvHyxvPzqhP@watson>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain devices such as Winbond Virtual Com Port,
which is used in some usb printers, will stop
responding after the usb_control_msg_send()
calls in usb_set_interface(). These devices work
fine without having usb_set_interface() called, so
this flag prevents that call.

The naming is designed to mirror the existing
USB_QUIRK_NO_SET_INTF flag, but that flag is
not sufficient to make these devices work.

Signed-off-by: Jeremy Figgins <kernel@jeremyfiggins.com>
---
 drivers/usb/class/usblp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/class/usblp.c b/drivers/usb/class/usblp.c
index 134dc2005ce9..6e2d58813d7d 100644
--- a/drivers/usb/class/usblp.c
+++ b/drivers/usb/class/usblp.c
@@ -209,6 +209,7 @@ struct quirk_printer_struct {
 #define USBLP_QUIRK_BIDIR	0x1	/* reports bidir but requires unidirectional mode (no INs/reads) */
 #define USBLP_QUIRK_USB_INIT	0x2	/* needs vendor USB init string */
 #define USBLP_QUIRK_BAD_CLASS	0x4	/* descriptor uses vendor-specific Class or SubClass */
+#define USBLP_QUIRK_NO_SET_INTF	0x8	/* device can't handle Set-Interface requests */
 
 static const struct quirk_printer_struct quirk_printers[] = {
 	{ 0x03f0, 0x0004, USBLP_QUIRK_BIDIR }, /* HP DeskJet 895C */
@@ -227,6 +228,7 @@ static const struct quirk_printer_struct quirk_printers[] = {
 	{ 0x0482, 0x0010, USBLP_QUIRK_BIDIR }, /* Kyocera Mita FS 820, by zut <kernel@zut.de> */
 	{ 0x04f9, 0x000d, USBLP_QUIRK_BIDIR }, /* Brother Industries, Ltd HL-1440 Laser Printer */
 	{ 0x04b8, 0x0202, USBLP_QUIRK_BAD_CLASS }, /* Seiko Epson Receipt Printer M129C */
+	{ 0x0416, 0x5011, USBLP_QUIRK_NO_SET_INTF }, /* Winbond Electronics Corp. Virtual Com Port */
 	{ 0, 0 }
 };
 
@@ -1332,7 +1334,11 @@ static int usblp_set_protocol(struct usblp *usblp, int protocol)
 	alts = usblp->protocol[protocol].alt_setting;
 	if (alts < 0)
 		return -EINVAL;
-	r = usb_set_interface(usblp->dev, usblp->ifnum, alts);
+	if (usblp->quirks & USBLP_QUIRK_NO_SET_INTF) {
+		r = 0;
+	} else {
+		r = usb_set_interface(usblp->dev, usblp->ifnum, alts);
+	}
 	if (r < 0) {
 		printk(KERN_ERR "usblp: can't set desired altsetting %d on interface %d\n",
 			alts, usblp->ifnum);
-- 
2.29.0

