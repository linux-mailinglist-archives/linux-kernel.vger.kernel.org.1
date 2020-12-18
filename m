Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FFC2DDD3A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 04:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbgLRDR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 22:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgLRDRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 22:17:55 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B09CC061282
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 19:17:15 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id x74so832339qkb.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 19:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Y5miTEEhuvngsOJcJq5G/k9DZNn9BLnkqRhZvnIGwOg=;
        b=pkvzXJ2AQha8Qa1BhK+Wcsn/9Fv5cX3Woz3DLjnZmAYiTOwkocIsErz2B3a3rzSYaW
         6rKElT7/NSbCyLnKPtMhOAKfwUuLLm1x2UpXCk0lKlBS47ZC1TCBHRbw7BE3Jzc33eJV
         xE8E0dExkWQXPsq/lGiJaYcQfMTO6P7CC0sbJSHdD+aLDQsRFKN2tfFqYp+dwWPCfMKR
         mGkTIqmPUsM6LL3elOFOij2Gj9QnUTt4UuDkaaNtx1Bx3Q/klMJYNiLOWBwPN0SnDd9x
         7AwA7rUXJb5M9u2LPebIeatNIB7M6ED++x2cU2eqQimj7CljoKewb32GjLFBF43Ubfpx
         fhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y5miTEEhuvngsOJcJq5G/k9DZNn9BLnkqRhZvnIGwOg=;
        b=NltA+nLnqwYMf4gRq3OHz0w4t98c5l1W3ToEkHN8ivW+4Wzt5YC4R/mewiWnw+kA0V
         BIYMX3HGhlz5XiQHMYTcvotJSme+p75gohIx00/tY+RC3KLG08IqVCXJnjt03MOgDh/R
         OcmlCfI44wDlBvmoX8g8amD4Imkz7uJORGS8wne4dsY0wbsR9NYiA9AgzKeevAPVcAlH
         bLVSZtkA551fV4P9Bj70ldfBS/majNwTgKLdQvo5NaeOtt0UZTjQGmrvjE4BMzRNgRNE
         newhBqdnntAehJRXO9DIWF//vf9g+Ta0jA7Fjy/2hL+8q3N/qaiA42NXcgdpcSGYc8Zo
         Q+Pw==
X-Gm-Message-State: AOAM533BNoppp/gaxy7hVAxQWMqEHHULJ7/8F0oGZZSGl+hDBS5dxnJi
        OLktd4cS1/uR8G417hMzncTzjpHLo6dZ+ZA=
X-Google-Smtp-Source: ABdhPJyY5p2xeA+FuuhY7hlgWJkWFtrDGnvSbmIwCicBtE2XQ8mSu1pLW6+ceroRLRLHMPoWqtsrKnilR0zcsPw=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a0c:9003:: with SMTP id
 o3mr2367062qvo.62.1608261434554; Thu, 17 Dec 2020 19:17:14 -0800 (PST)
Date:   Thu, 17 Dec 2020 19:17:01 -0800
In-Reply-To: <20201218031703.3053753-1-saravanak@google.com>
Message-Id: <20201218031703.3053753-4-saravanak@google.com>
Mime-Version: 1.0
References: <20201218031703.3053753-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH v1 3/5] driver core: Have fw_devlink use DL_FLAG_INFERRED
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be useful in identifying device links created only due to
fw_devlink when we need to break cyclic dependencies due to fw_devlink.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5827dbff7f21..1107d03aa6b3 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1450,7 +1450,14 @@ static void device_links_purge(struct device *dev)
 	device_links_write_unlock();
 }
 
-static u32 fw_devlink_flags = DL_FLAG_SYNC_STATE_ONLY;
+#define FW_DEVLINK_FLAGS_PERMISSIVE	(DL_FLAG_INFERRED | \
+					 DL_FLAG_SYNC_STATE_ONLY)
+#define FW_DEVLINK_FLAGS_ON		(DL_FLAG_INFERRED | \
+					 DL_FLAG_AUTOPROBE_CONSUMER)
+#define FW_DEVLINK_FLAGS_RPM		(FW_DEVLINK_FLAGS_ON | \
+					 DL_FLAG_PM_RUNTIME)
+
+static u32 fw_devlink_flags = FW_DEVLINK_FLAGS_PERMISSIVE;
 static int __init fw_devlink_setup(char *arg)
 {
 	if (!arg)
@@ -1459,12 +1466,11 @@ static int __init fw_devlink_setup(char *arg)
 	if (strcmp(arg, "off") == 0) {
 		fw_devlink_flags = 0;
 	} else if (strcmp(arg, "permissive") == 0) {
-		fw_devlink_flags = DL_FLAG_SYNC_STATE_ONLY;
+		fw_devlink_flags = FW_DEVLINK_FLAGS_PERMISSIVE;
 	} else if (strcmp(arg, "on") == 0) {
-		fw_devlink_flags = DL_FLAG_AUTOPROBE_CONSUMER;
+		fw_devlink_flags = FW_DEVLINK_FLAGS_ON;
 	} else if (strcmp(arg, "rpm") == 0) {
-		fw_devlink_flags = DL_FLAG_AUTOPROBE_CONSUMER |
-				   DL_FLAG_PM_RUNTIME;
+		fw_devlink_flags = FW_DEVLINK_FLAGS_RPM;
 	}
 	return 0;
 }
@@ -1477,7 +1483,7 @@ u32 fw_devlink_get_flags(void)
 
 static bool fw_devlink_is_permissive(void)
 {
-	return fw_devlink_flags == DL_FLAG_SYNC_STATE_ONLY;
+	return fw_devlink_flags == FW_DEVLINK_FLAGS_PERMISSIVE;
 }
 
 static void fw_devlink_parse_fwnode(struct fwnode_handle *fwnode)
@@ -1624,7 +1630,7 @@ static void __fw_devlink_link_to_consumers(struct device *dev)
 				con_dev = NULL;
 			} else {
 				own_link = false;
-				dl_flags = DL_FLAG_SYNC_STATE_ONLY;
+				dl_flags = FW_DEVLINK_FLAGS_PERMISSIVE;
 			}
 		}
 
@@ -1679,7 +1685,7 @@ static void __fw_devlink_link_to_suppliers(struct device *dev,
 	if (own_link)
 		dl_flags = fw_devlink_get_flags();
 	else
-		dl_flags = DL_FLAG_SYNC_STATE_ONLY;
+		dl_flags = FW_DEVLINK_FLAGS_PERMISSIVE;
 
 	list_for_each_entry_safe(link, tmp, &fwnode->suppliers, c_hook) {
 		int ret;
-- 
2.29.2.684.gfbc64c5ab5-goog

