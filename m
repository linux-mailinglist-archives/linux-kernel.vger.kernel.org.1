Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABB829F588
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgJ2TrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgJ2TrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:47:21 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EFAC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:47:19 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id r4so2567587qta.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=DM2UgOFHo//AreOdqVZsv1HPnyLVmD2DIdKtCbtXmYA=;
        b=cp2RUY7eGgson2wdDBb4suSeLc+awuv4u+/EZAbJNWm0LQ3S2aZwn0c4vvTsqhCWok
         4Z/l13Fpehow2YX2GXT9NqdWN90xS7oWSOwCCx3xo2ajIJv++AqKXE8HzPJroJY2NuH/
         b7ANTWDej7SN2Ab+PzJdijDIsWfkWUP443BoCi4sdO+3hO0cMHfnL/9QTa0jx0euLaaT
         H9w0b1rywB7bKPAq6Fgs6oQTFE/QSAWZhEmHFJZbyzbl853A772wyrYJ7UKhxiXYNIKH
         l6fwmzKeK9Z0fc7ZaH/sA/0JlzQWQ9HidumlUKyAwCrKuYyOBaJvunsnqBDgw/UmMVa4
         3axw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=DM2UgOFHo//AreOdqVZsv1HPnyLVmD2DIdKtCbtXmYA=;
        b=qqDZzvLnVInwWzsHu3L/5whLdjtxlsUFB3pus727/suoCCUa189PVSMhSmXqXgP3mK
         +YeLSa6fzxylOZme3D5CZCD1FrEbJv2WxRJFZJS8Ud2Ma9h6WUbZ1GOsVYh0gg4pz7rP
         94qrUTltjLZOIufBqHucRTspmQqOJc66o5m1Pm6Yb0adJ6nk2MEhmqLNltO4vswqCok/
         JZkKTZ/RIKApCMgQXDuiZxjHyJYhL52ALBnvadujfs9nxNb1Z65yEC5uczZCyo6MB5jF
         owN4B8zL2kbf4RLUqu7oVb0EmjIrlmuopNsTIdmI1zRWMEU1EM5+DDoddo2Jd8Iu1U6Z
         ynFg==
X-Gm-Message-State: AOAM531W+P2ewyI0Rr0XvX/+0RPrEuQMq0jIq0jD+Cos/cjQ/H8nA7N+
        rbt3ahirdTQdvSHXoczG6fIJAi+Q
X-Google-Smtp-Source: ABdhPJwO4qZQPgqRybdB4Iubsfb2dfLrQqqqinTbGiPavxL3I8kpgq/xWGyIdFc1CtIvZbgnCgfGFnad
Sender: "lzye via sendgmr" <lzye@chrisye.mtv.corp.google.com>
X-Received: from chrisye.mtv.corp.google.com ([2620:15c:211:2:f693:9fff:fef4:4323])
 (user=lzye job=sendgmr) by 2002:a0c:e054:: with SMTP id y20mr5839816qvk.30.1604000838752;
 Thu, 29 Oct 2020 12:47:18 -0700 (PDT)
Date:   Thu, 29 Oct 2020 12:47:14 -0700
Message-Id: <20201029194714.1613308-1-lzye@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH] Add devices for HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE
From:   Chris Ye <lzye@google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        linux-input@vger.kernel.org, linzhao.ye@gmail.com,
        Chris Ye <lzye@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 5.4 introduces HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE, devices
need to be set explicitly with this flag.

Signed-off-by: Chris Ye <lzye@google.com>
---
 drivers/hid/hid-ids.h    | 4 ++++
 drivers/hid/hid-quirks.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 74be76e848bf..cf55dca494f3 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -449,6 +449,10 @@
 #define USB_VENDOR_ID_FRUCTEL	0x25B6
 #define USB_DEVICE_ID_GAMETEL_MT_MODE	0x0002
 
+#define USB_VENDOR_ID_GAMEVICE	0x27F8
+#define USB_DEVICE_ID_GAMEVICE_GV186	0x0BBE
+#define USB_DEVICE_ID_GAMEVICE_KISHI	0x0BBF
+
 #define USB_VENDOR_ID_GAMERON		0x0810
 #define USB_DEVICE_ID_GAMERON_DUAL_PSX_ADAPTOR	0x0001
 #define USB_DEVICE_ID_GAMERON_DUAL_PCS_ADAPTOR	0x0002
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 0440e2f6e8a3..36d94e3485e3 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -84,6 +84,10 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_FREESCALE, USB_DEVICE_ID_FREESCALE_MX28), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_FUTABA, USB_DEVICE_ID_LED_DISPLAY), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GREENASIA, USB_DEVICE_ID_GREENASIA_DUAL_USB_JOYPAD), HID_QUIRK_MULTI_INPUT },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_GAMEVICE, USB_DEVICE_ID_GAMEVICE_GV186),
+		HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMEVICE, USB_DEVICE_ID_GAMEVICE_KISHI),
+		HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FIGHTING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FLYING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
-- 
2.29.1.341.ge80a0c044ae-goog

