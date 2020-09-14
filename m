Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C432691BF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgINQhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgINPiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:38:16 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F5892193E;
        Mon, 14 Sep 2020 15:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600097889;
        bh=RoTPtd9qHHuk1GM7mtTLP95n0k7SzFhORIof1s3mXI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=an12vcgsLuq8dJy3avIewd9JstauxKo62seMlj12DUNw3bW7UjfEsJsX6MQnWjpUq
         ZNSgQKrQh4ZtDER7l7MUuGRfIuAhBOrjUQm/iYdmvY1VLD0rRlB14FWBcZyPlDhumj
         uRXdoq4OFhaqzm0J4VpPvm6Tc8OKPDUrUR6f/kAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, stern@rowland.harvard.ed,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Tsoy <alexander@tsoy.me>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v3 11/11] ALSA: remove calls to usb_pipe_type_check for control endpoints
Date:   Mon, 14 Sep 2020 17:37:56 +0200
Message-Id: <20200914153756.3412156-12-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200914153756.3412156-1-gregkh@linuxfoundation.org>
References: <20200914153756.3412156-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A USB device will always haev a bi-directional endpoint 0, that's just
how the devices work, so no need to check for that in a few quirk tests
as it will always pass.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Alexander Tsoy <alexander@tsoy.me>
Cc: alsa-devel@alsa-project.org
Reported-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3:
 - no change from v2

v2:
 - new patch, was not in v1 series, suggested by Alan.

 sound/usb/quirks.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 1b482848e73b..395d1ea6f03f 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -885,8 +885,6 @@ static int snd_usb_nativeinstruments_boot_quirk(struct usb_device *dev)
 {
 	int ret;
 
-	if (usb_pipe_type_check(dev, usb_sndctrlpipe(dev, 0)))
-		return -EINVAL;
 	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 				  0xaf, USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 				  1, 0, NULL, 0, 1000);
@@ -994,8 +992,6 @@ static int snd_usb_axefx3_boot_quirk(struct usb_device *dev)
 
 	dev_dbg(&dev->dev, "Waiting for Axe-Fx III to boot up...\n");
 
-	if (usb_pipe_type_check(dev, usb_sndctrlpipe(dev, 0)))
-		return -EINVAL;
 	/* If the Axe-Fx III has not fully booted, it will timeout when trying
 	 * to enable the audio streaming interface. A more generous timeout is
 	 * used here to detect when the Axe-Fx III has finished booting as the
@@ -1127,8 +1123,6 @@ static int snd_usb_motu_m_series_boot_quirk(struct usb_device *dev)
 {
 	int ret;
 
-	if (usb_pipe_type_check(dev, usb_sndctrlpipe(dev, 0)))
-		return -EINVAL;
 	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 			      1, USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 			      0x0, 0, NULL, 0, 1000);
-- 
2.28.0

