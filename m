Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108C0249371
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 05:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgHSDfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 23:35:05 -0400
Received: from regular1.263xmail.com ([211.150.70.197]:52944 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgHSDfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 23:35:04 -0400
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id C5764D3F;
        Wed, 19 Aug 2020 11:34:50 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from localhost.localdomain (250.19.126.124.broad.bjtelecom.net [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P25957T140260100654848S1597808091034256_;
        Wed, 19 Aug 2020 11:34:51 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <a04c9f09ffb779a6d53edaaf716d81cf>
X-RL-SENDER: penghao@uniontech.com
X-SENDER: penghao@uniontech.com
X-LOGIN-NAME: penghao@uniontech.com
X-FST-TO: perex@perex.cz
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 5
X-System-Flag: 0
From:   penghao <penghao@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alexander@tsoy.me, dan.carpenter@oracle.com, crwulff@gmail.com,
        penghao@uniontech.com, gustavoars@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Add prevent wakeup from s3 state trig by Lenovo ThinkCentre TI024Gen3 USB-audio
Date:   Wed, 19 Aug 2020 11:34:46 +0800
Message-Id: <20200819033446.7897-1-penghao@uniontech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI024Gen3 USB-audio is controlled by TI024Gen3,when TI024Gens
enter sleep mode, USB-audio will disconnect from USB bus port,
wakup form s3 state

Signed-off-by: penghao <penghao@uniontech.com>
---
 sound/usb/card.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 696e788c5d31..6bdbb34009b3 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -658,6 +658,12 @@ static int usb_audio_probe(struct usb_interface *intf,
 	}
 
 	dev_set_drvdata(&dev->dev, chip);
+	/*
+	 *ALSA: usb-audio: Add prevent wakeup from s3 state trig by Lenovo
+	 *ThinkCentre TI024Gen3 usb-audio
+	 */
+	if ((usb_id->idVendor == 0x17ef) && (usb_id->idProduct == 0xa012))
+		device_set_wakeup_enable(＆dev->dev, 0);
 
 	/*
 	 * For devices with more than one control interface, we assume the
-- 
2.11.0



