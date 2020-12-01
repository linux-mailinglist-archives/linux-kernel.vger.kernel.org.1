Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8723C2CACDF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404347AbgLAT5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLAT5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:57:34 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97912C0613D4;
        Tue,  1 Dec 2020 11:56:53 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id e25so8955329wme.0;
        Tue, 01 Dec 2020 11:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qxaxg65nan58qHlFqPugD7TW0lW2OpFi76k39sX/L6s=;
        b=HyTp/jNA+4GyqidnMug+lWzvDdFRq1bShCqMp0ctawW+500N2Y1EaThkY2OmrbCNP/
         3ZOdYJDTg3ZkLRtaesN9WRTcOIDJrNUblzHlcs0tdZwWm5Fd1c5GsuP0tqiVDs8YqlzK
         yQmZfde2tSZx1i+w1r55jI3oQNhv2TuaiugbM3YBHf6wSPGKXEBx5P0Hp/YcoC91RxjD
         wp07UFBk6jJuUPhVVTg3xo6lgHTDI76M+/PP1cOkyZJE9ZdfogVi5SNrRyyqfoYSv0GI
         cHfAfle7ngtmXkminqrgDuNy0+8FHqFhZ6M8g9ewzG6OPZHJoLKicY8xcV/5pK5ON0Mi
         c0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qxaxg65nan58qHlFqPugD7TW0lW2OpFi76k39sX/L6s=;
        b=kZmNk4Y7oZ29v9D8NvzQIgehE/pBB9UpXgDyIa3FdeGbbakxRvQ2N2O/KTLcFtuCBl
         SC/4ZztPgiPOzYxEjo5SZtjg6u5aHy4CPUtD4hmUgfr4d1cLOCeAwtfUVoxYZv+8ufTQ
         973F5y1fwNUErKYLAzTmEt6hW3UPRQ9fOCgOzzwUDa540XFGNCZDd8vl2/c0nXpEK+1Z
         oD0Ti0yZkS0hHKA3QakMZTNHkkPScHf8z0HqGAFevkwWIgS1UJmXpQBPPJOAV1ZdfTwK
         oPXD3oEVxbydFTZ+xhE827fxsJ8spKM7QXHSoEbrQmF06KZQZ45b2NIOwGd+ZCdCTIr6
         jA+w==
X-Gm-Message-State: AOAM532n5OePH4606Zoc6vVHi6M/96Q2DcGyKp1ZtnC8tOd5iBgAyB+e
        3kJpf22WXTjDFWraYldmBYk=
X-Google-Smtp-Source: ABdhPJy9lXWDKuWiFqyLddO5hXPgadNjvP0CxtlhQZCF48DTf04Ba93vHe+QDlt286KHfkQCswBDxQ==
X-Received: by 2002:a1c:6205:: with SMTP id w5mr4352268wmb.26.1606852612302;
        Tue, 01 Dec 2020 11:56:52 -0800 (PST)
Received: from localhost.localdomain (host-79-13-10-171.retail.telecomitalia.it. [79.13.10.171])
        by smtp.gmail.com with ESMTPSA id w3sm1435409wma.3.2020.12.01.11.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:56:51 -0800 (PST)
From:   Elia Devito <eliadevito@gmail.com>
Cc:     mario.limonciello@dell.com, Elia Devito <eliadevito@gmail.com>,
        Alex Hung <alex.hung@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] intel-hid: add option to enable/disable switches
Date:   Tue,  1 Dec 2020 20:56:16 +0100
Message-Id: <20201201195615.22461-1-eliadevito@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add option to force enable/disable switches support.

Signed-off-by: Elia Devito <eliadevito@gmail.com>
---
 drivers/platform/x86/intel-hid.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index 5093c57102cf..54f5cbfd2189 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -147,6 +147,10 @@ static const char *intel_hid_dsm_fn_to_method[INTEL_HID_DSM_FN_MAX] = {
 
 static unsigned long long intel_hid_dsm_fn_mask;
 static guid_t intel_dsm_guid;
+static int tablet_mode_switch = -1;
+
+module_param(tablet_mode_switch, int, 0444);
+MODULE_PARM_DESC(tablet_mode_switch, "Enable/Disable tablet mode switch (0:disable, 1:enable)");
 
 static bool intel_hid_execute_method(acpi_handle handle,
 				     enum intel_hid_dsm_fn_codes fn_index,
@@ -507,9 +511,14 @@ static bool intel_button_array_has_switches(struct platform_device *device)
 	acpi_handle handle = ACPI_HANDLE(&device->dev);
 	unsigned long long vgbs;
 
-	if (!dmi_check_system(button_array_switches_table))
+	if (tablet_mode_switch == 0)
 		return false;
 
+	if (tablet_mode_switch != 1) {
+		if (!dmi_check_system(button_array_switches_table))
+			return false;
+	}
+
 	if (!intel_hid_evaluate_method(handle, INTEL_HID_DSM_VGBS_FN, &vgbs))
 		return false;
 
-- 
2.28.0

