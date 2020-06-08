Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF881F318E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 03:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgFIBKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 21:10:17 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:60753 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726897AbgFHXGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:06:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 139F688A;
        Mon,  8 Jun 2020 19:06:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Jun 2020 19:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ZGq3nTnSp7PpM
        9kF5nuQMko1H0xARme55YpGS8/IntA=; b=I+aS+3xyaUeNQxeJHKU5OUlAbqa97
        J75x8iWoT3JwZlh3ZeQwXmHFXINyZdjaeDsfCWO4EoXPPcsKv5+DDDiAK/Gy38A6
        HANLbqJl9ckBsC06Vv6kwug0ARhThBL9onJ/yL2MHeAnUKiTm9rctpWhqy5pA2K1
        GSOJfyjRyFqvqA1q3YCpLI2U7MjS6INzDoppLJJqHEUxGsMzzPma4ahzHuPOTTWx
        BwkVIacmxILFj9NQaHiKqK7qPZvll8CKdY+Vtka/B53vGISH2IUggsTYbLliZGKM
        httT9WjLsE6LEnT1LDOyNx4KuMKoW7uyVvii1APyl2SiM/XsDCuBj1E/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ZGq3nTnSp7PpM9kF5nuQMko1H0xARme55YpGS8/IntA=; b=If+bK3Hw
        lqnIP7n+1dd3Dz9MbXz8F5sF+2xjDeWMbiBDr3xs8AacdLuO3PXH2HYc16kXtZi2
        DKyNQbvjUya5uqU7NsignzFPBkOlAD5cnFEr5Nyn95N2kzq7+IiVRhBBxypXo6M5
        0z/5qMFP2IMH+sSMteOw9zCz9KRWJd3w9zUxysE2TWoNJ/aUxlZY4+yHoStJuYaE
        lQSbNqAF5t0pDKx1EdBSgbYbTho9qEzbTcw3RPozGzEYdz8k3A9cKKnRim51cgE7
        T4xA1OAHqinCgIWxeQJI7PqGItngq16KdasfJEaB5EcHT8HkRx2H6M7H1odtz2GE
        uOam9jsE664WqA==
X-ME-Sender: <xms:ZsTeXovSUBY-SJArjO87LdkxTwcsOrqnWuNFPkDNg3Cg1UUs2Y14FQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehfedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    hmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnecujfgurhephffvufffkffojghf
    ggfgsedtkeertdertddtnecuhfhrohhmpegjucfrrghrihhttghhvghruceohidrlhhinh
    hugiesphgrrhhithgthhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepjeegfeetleeu
    leevteejteetieffgffgfedvffffvddtvddvveevhffhtdehudeknecukfhppeeijedrke
    egrdduleegrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhephidrlhhinhhugiesphgrrhhithgthhgvrhdrtghomh
X-ME-Proxy: <xmx:ZsTeXlejrAdIyy2ZCm6yuZAzQT2gsdvSL4r83gUDRMYo-Y-BfUdJaA>
    <xmx:ZsTeXjwO1lwcB8SkgEoqGebhQjyXVwORL-VJBuVU5yNnzeee9zav2w>
    <xmx:ZsTeXrNjIUTnLLDyM4Reernm-CK6ppJ49LPJhZr4piSwy8_0jmI3ZQ>
    <xmx:ZsTeXmkScDbH2vwuszwFenDx2KwsSoeJdwFROnY2HYUl-PKcP9q24Q>
Received: from localhost.localdomain (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 34C7D3280063;
        Mon,  8 Jun 2020 19:06:14 -0400 (EDT)
From:   Y Paritcher <y.linux@paritcher.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Mario.Limonciello@dell.com
Subject: [PATCH v2 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
Date:   Mon,  8 Jun 2020 19:05:29 -0400
Message-Id: <74fdb288757cf5970a558f920f531b3bd1c51b47.1591656154.git.y.linux@paritcher.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591656154.git.y.linux@paritcher.com>
References: <cover.1591584631.git.y.linux@paritcher.com> <cover.1591656154.git.y.linux@paritcher.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are events with extended data. The extended data is
currently ignored as userspace does not have a way to deal
it.

Ignore event with a type of 0x0012 and a code of 0xe035, as
the keyboard controller takes care of Fn lock events by itself.
This silences the following messages being logged when
pressing the Fn-lock key on a Dell Inspiron 5593:

dell_wmi: Unknown WMI event type 0x12
dell_wmi: Unknown key with type 0x0012 and code 0xe035 pressed

This is consistent with the behavior for the Fn-lock key
elsewhere in this file.

Signed-off-by: Y Paritcher <y.linux@paritcher.com>
---
 drivers/platform/x86/dell-wmi.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index 0b2edfe2767d..6b510f8431a3 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -334,6 +334,15 @@ static const struct key_entry dell_wmi_keymap_type_0011[] = {
 	{ KE_IGNORE, KBD_LED_AUTO_100_TOKEN, { KEY_RESERVED } },
 };
 
+/*
+ * Keymap for WMI events of type 0x0012
+ * They are events with extended data
+ */
+static const struct key_entry dell_wmi_keymap_type_0012[] = {
+	/* Fn-lock button pressed */
+	{ KE_IGNORE, 0xe035, { KEY_RESERVED } },
+};
+
 static void dell_wmi_process_key(struct wmi_device *wdev, int type, int code)
 {
 	struct dell_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
@@ -418,10 +427,11 @@ static void dell_wmi_notify(struct wmi_device *wdev,
 
 		switch (buffer_entry[1]) {
 		case 0x0000: /* One key pressed or event occurred */
+		case 0x0012: /* Event with extended data occurred */
 			if (len > 2)
 				dell_wmi_process_key(wdev, 0x0000,
 						     buffer_entry[2]);
-			/* Other entries could contain additional information */
+			/* Extended data is currently ignored */
 			break;
 		case 0x0010: /* Sequence of keys pressed */
 		case 0x0011: /* Sequence of events occurred */
@@ -556,6 +566,7 @@ static int dell_wmi_input_setup(struct wmi_device *wdev)
 			 ARRAY_SIZE(dell_wmi_keymap_type_0000) +
 			 ARRAY_SIZE(dell_wmi_keymap_type_0010) +
 			 ARRAY_SIZE(dell_wmi_keymap_type_0011) +
+			 ARRAY_SIZE(dell_wmi_keymap_type_0012) +
 			 1,
 			 sizeof(struct key_entry), GFP_KERNEL);
 	if (!keymap) {
@@ -600,6 +611,13 @@ static int dell_wmi_input_setup(struct wmi_device *wdev)
 		pos++;
 	}
 
+	/* Append table with events of type 0x0012 */
+	for (i = 0; i < ARRAY_SIZE(dell_wmi_keymap_type_0012); i++) {
+		keymap[pos] = dell_wmi_keymap_type_0012[i];
+		keymap[pos].code |= (0x0012 << 16);
+		pos++;
+	}
+
 	/*
 	 * Now append also table with "legacy" events of type 0x0000. Some of
 	 * them are reported also on laptops which have scancodes in DMI.
-- 
2.27.0

