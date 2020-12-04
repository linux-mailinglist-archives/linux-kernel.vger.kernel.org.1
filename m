Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EB22CF17C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbgLDQDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbgLDQDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:03:41 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA5FC061A4F;
        Fri,  4 Dec 2020 08:02:55 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a6so5942252wmc.2;
        Fri, 04 Dec 2020 08:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q1yfTlb9bBZ0gNH36CjYMIoHV//7gjPmTR0/ONE5eBo=;
        b=Fq5VRsGUzKL1rNfyyfzfPtKgF154pn72SL/iiLNp7wtl4FTufNsrsdy77+jBAZlS71
         ODL1sXYk6CI0OtIji0/B0qSyUu6V8g+c0q0un8rLBh8g3nJjtOmomf317Mo84dsEGWuo
         1bMW1mniAfZt+8Vt4+MMdCAxXfCGaDFFd62O8hYwhy07xHBB7Y+kFba8u4QDL50SbuNN
         LV1PndF02tm+fKyIU9B8+GXam3yDZjB/CYKbgltAw0xtxJtiBdpkbVq6uFPYG4o7gL+l
         AqVFnYeFkuYPrEf9JOwnKlrHkdsEdQXEP9SLg6uVUv6H4icDVzOCx/shQIBLq2tDDAO7
         6qLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q1yfTlb9bBZ0gNH36CjYMIoHV//7gjPmTR0/ONE5eBo=;
        b=a2n9XJbMGZnXTZCAbqcGW6vY1eE3///hXOwp7WU0CDdFoSJws8/6Jsi3h289bZnCoe
         TObLQ78mEszPXyXFqCEq/4fwBRvDSsMlTk7kooBaD0eMxn74O0aIBosGpJH8Izax/MWz
         TYg6Nup05aBdUWYZEMLpCarnozlELZJNMvF0L6/yW8O9bboj3DMTq7JQWMGHB8ss5LAo
         O9krJaTfpXSk7TDOIDFHFAlR+kuOIwYFqzsZWiRQUUL8XyRMu0wXPb3NxTw/4UdWDTXS
         VD7atLCQNz5+2JjTw6++W47KtOuAs117GoyewjfnMOuljjzc1OBVyC4gQ3073FoMr1fm
         crwQ==
X-Gm-Message-State: AOAM531rpKDQtGiwsD4qWXIoNtY1BpIj4DOQM4jRCliaM0Wake7utoG2
        Oqu5DRrePPtgEJQwU06n/ZZNR1UqLqPIT4DP
X-Google-Smtp-Source: ABdhPJzctET2f7fFmeWCjVPWYE5J25cDkCuQaq+8jtixNgpsflmmv+PzlEU28cXsDvls9scQjdw3Jg==
X-Received: by 2002:a1c:9a4d:: with SMTP id c74mr5189275wme.5.1607097774126;
        Fri, 04 Dec 2020 08:02:54 -0800 (PST)
Received: from localhost.localdomain (host-79-13-10-171.retail.telecomitalia.it. [79.13.10.171])
        by smtp.gmail.com with ESMTPSA id d15sm4350075wrx.93.2020.12.04.08.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 08:02:53 -0800 (PST)
From:   Elia Devito <eliadevito@gmail.com>
X-Google-Original-From: Elia Devito <elia@xvalue.it>
Cc:     Elia Devito <eliadevito@gmail.com>,
        Alex Hung <alex.hung@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] intel-hid: add alternative method to enable switches
Date:   Fri,  4 Dec 2020 17:02:35 +0100
Message-Id: <20201204160234.36832-1-elia@xvalue.it>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201203212000.35898-1-eliadevito@gmail.com>
References: <20201203212000.35898-1-eliadevito@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elia Devito <eliadevito@gmail.com>

Some convertible have unreliable VGBS return, in these cases we enable
support when receiving the first event.

Signed-off-by: Elia Devito <eliadevito@gmail.com>
---
 drivers/platform/x86/intel-hid.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index d2f892665ec6..054bc37da2cf 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -423,6 +423,19 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
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

