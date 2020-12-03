Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0C02CE094
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 22:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbgLCVW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 16:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgLCVW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:22:56 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1C5C061A4F;
        Thu,  3 Dec 2020 13:22:15 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id t4so3306560wrr.12;
        Thu, 03 Dec 2020 13:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zIwz4kMfc7t6lpkiBG3igVGFEHaTI3leni+rbGlAWBA=;
        b=aSZwLsCbG02upmomplwSwSwedmZwwjJ2J87bLrAIO2GcFJzaQG+0Wb01avh4sbV1aX
         JfvWpiwdBCQcMxEvBPoxM/0LuYCwrVhKqlbgu96pCocW9svi2FZLekGsHO3eHpKB/K2g
         aav//ckZ9MWBuzXHVjzeKEVHsaEua3v4ncxjzReJp/Cx4WGRI4yR7ckO2MMvmUwENBmr
         cSfLo3HFhIAlIp9sTbwcJPpl4mMnO1ojInMvdGkKmFJVdtchjmv/LzgXTYx6blA+9Nle
         tc9ddsfdFUAdZ+qJAhFyREKHi9kxaJ5YprVQ4X0/MlaiqPeoYlqsYcy9EZemEHr6YK83
         9sNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zIwz4kMfc7t6lpkiBG3igVGFEHaTI3leni+rbGlAWBA=;
        b=pnuegFjuHOWRdz7tw5wSdqpUcXexxe85TCpZHfIzx9xLn2ZOpk4i6mZeEI3/a6PMec
         TYKczmlPxPr3L/O0B+aRvkd2dvqSJBrX+qSs/GT7O267V08H6p9YmPMfqQ96v2I0t3vx
         5np1D/FDyMT6f7ifBi2DWUWQtcnHSEb/Bjpgz5dmw6GotFZCCilqVJhMOjEq3C+8irhZ
         c3r4S8uNyyuUUEJN5tG1T8eEvXRjYXEH9Fku7TDd6ZvmXFRvC8x2DHJbiTtF/Gd8OVbQ
         b4PZtWjc5FTFKMXvwDNUIQDtGsBwDxAgkEuUXBAM1D3b4QFk2XKCpOGPDkb90Fr6msJu
         /srA==
X-Gm-Message-State: AOAM530Aqlkn6KsLg63357AW+TGWud20/+8nC7OPgABXPFwe1HgnhxrN
        6M5Mejq+ytN0AB+k9/K0q8U=
X-Google-Smtp-Source: ABdhPJxEMlsjN43WtUPneFgokIswrABxZVUkEZcg7hyOpI93SFaEgx8MPhjl9LgAeabPO6eB45gY7Q==
X-Received: by 2002:a5d:60cb:: with SMTP id x11mr1307927wrt.0.1607030534225;
        Thu, 03 Dec 2020 13:22:14 -0800 (PST)
Received: from localhost.localdomain (host-79-13-10-171.retail.telecomitalia.it. [79.13.10.171])
        by smtp.gmail.com with ESMTPSA id g78sm633649wme.33.2020.12.03.13.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:22:13 -0800 (PST)
From:   Elia Devito <eliadevito@gmail.com>
Cc:     Elia Devito <eliadevito@gmail.com>,
        Alex Hung <alex.hung@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] intel-hid: add alternative method to enable switches
Date:   Thu,  3 Dec 2020 22:21:49 +0100
Message-Id: <20201203212148.36039-1-eliadevito@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <69f340f6-4301-6546-f14a-47d90208d44b@redhat.com>
References: <69f340f6-4301-6546-f14a-47d90208d44b@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some convertible have unreliable VGBS return, in these cases we enable
support when receiving the first event.

Signed-off-by: Elia Devito <eliadevito@gmail.com>
---
 drivers/platform/x86/intel-hid.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index fed24d4f28b8..3cc8f8ac48b2 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -404,6 +404,19 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 	struct platform_device *device = context;
 	struct intel_hid_priv *priv = dev_get_drvdata(&device->dev);
 	unsigned long long ev_index;
+	int err;
+
+	/*
+	 * Some convertible have unreliable VGBS return which could cause incorrect
+	 * SW_TABLET_MODE report, in these cases we enable support when receiving
+	 * the first event instead of during driver setup.
+	 */
+	if (!priv->switches && (event == 0xcc || event == 0xcd)) {
+		dev_info(&device->dev, "switch event received, enable switches supports\n");
+		err = intel_hid_switches_setup(device);
+		if (err)
+			pr_err("Failed to setup Intel HID switches\n");
+	}
 
 	if (priv->wakeup_mode) {
 		/*
-- 
2.28.0

