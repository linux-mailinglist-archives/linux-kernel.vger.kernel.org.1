Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7022CACE1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404360AbgLAT7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbgLAT64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:58:56 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC70C0613D4;
        Tue,  1 Dec 2020 11:58:10 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a6so6440531wmc.2;
        Tue, 01 Dec 2020 11:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sx151eVFdKbQ1FGGvTx77Q/mZ/E2lniXFLlJGHiTSnI=;
        b=Pvz/lS4c9QXLFe1Yk7HIcOHDHEBSiawoNHGFValrhHUMrnl6ei0gP8pECPQA+/raPF
         fIV/il0YrhBgbIRdCOXRQVnQL47lTWAXgUIWxzfJ+spvUt5nMBKaCacpgV4M+/QUztV3
         6nHjdYBaummAb41xBORzwDlJuCSF6sBe9jMP+hTOABseSzuLl76MS2Zy9UYchcYHUqEM
         peHG5oA/NWKeSIFi964lBEQWueahSsfdtmaLRmq42ITwN9I0tX1uyKyQsFXK90ASUnJp
         YmpgUGFA9n1hxz7qf/St1rphSbCZpjElW1vc3u4ZpsuBBT1bnsw5/ESXBSIeNNWxLr0A
         PTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sx151eVFdKbQ1FGGvTx77Q/mZ/E2lniXFLlJGHiTSnI=;
        b=k4kH3Fd3WcrI9L8B7zDeR3LhdXwVq8aNAWUECo+NL4c3hhTHpZY0eA/8bpvrumoUt9
         NUVstmaO/Lrn2Ks5j674Hr8cjuDEM7oR2vKWfHG427y0T8nfgRm6XozP9WU5SbBd4riV
         yGD14E94JGGZ1DfVmgi0RML0s87tdUCfbQf6xa/YjhLYgzpkR4HcivhXctXpaT0WUmJe
         og+J40tJjMrWVSsZClkXUx6GAtPau4x4T26YMXbwgwljsQ1oAqijiSCeCRTwcbHGGMdn
         TbOiUveSbvhv6R+w/Pz6mFw3SWC4ytrZhUIU1w4LfRKtldaMiuETfZ/Epso99bEWORu1
         Cvmg==
X-Gm-Message-State: AOAM5311jyNskWHRbb0NECfa9HQyFX1t58ktk0+G8MDGt7Zfu1wPkV4D
        K5pRiUhzSPq8wOhTLii8nYU=
X-Google-Smtp-Source: ABdhPJwSBzCIhPxIW9NcSnKvoC6jERchWPjAwtqPdnAIZ5+8pjWkzIRCJGrZh9+xYMs9KMIdlQo3cA==
X-Received: by 2002:a1c:bc88:: with SMTP id m130mr2476345wmf.82.1606852688768;
        Tue, 01 Dec 2020 11:58:08 -0800 (PST)
Received: from localhost.localdomain (host-79-13-10-171.retail.telecomitalia.it. [79.13.10.171])
        by smtp.gmail.com with ESMTPSA id 2sm1177793wrq.87.2020.12.01.11.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:58:07 -0800 (PST)
From:   Elia Devito <eliadevito@gmail.com>
Cc:     mario.limonciello@dell.com, Elia Devito <eliadevito@gmail.com>,
        Alex Hung <alex.hung@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] intel-hid: disable switches on Dell Latitute 7410 2in1
Date:   Tue,  1 Dec 2020 20:57:00 +0100
Message-Id: <20201201195659.22568-1-eliadevito@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable switches on Dell Latitute 7410 2in1 due firmware bug

Signed-off-by: Elia Devito <eliadevito@gmail.com>
---
maybe Mario Limonciello can help on this

 drivers/platform/x86/intel-hid.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index 54f5cbfd2189..dc82415abd24 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -105,6 +105,22 @@ static const struct dmi_system_id button_array_switches_table[] = {
 	{ }
 };
 
+static const struct dmi_system_id button_array_switches_disable[] = {
+	{
+		/*
+		 * Dell Latitute 7410 2in1 emit wrong event and VGBS method return wrong
+		 * value when booted with AC adapter plugged-in, disable switches to
+		 * prevent wrong beaviour.
+		 */
+		.ident = "Dell Latitute 7410 2in1",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Latitude 7410"),
+		},
+	},
+	{ }
+};
+
 #define KEYMAP_LEN \
 	(ARRAY_SIZE(intel_array_keymap) + ARRAY_SIZE(intel_array_switches) + 1)
 
@@ -515,7 +531,8 @@ static bool intel_button_array_has_switches(struct platform_device *device)
 		return false;
 
 	if (tablet_mode_switch != 1) {
-		if (!dmi_check_system(button_array_switches_table))
+		if (!dmi_check_system(button_array_switches_table) ||
+				dmi_check_system(button_array_switches_disable))
 			return false;
 	}
 
-- 
2.28.0

