Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E43B2C3B58
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 09:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgKYItV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 03:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgKYItV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 03:49:21 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B562FC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 00:49:19 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w6so1690495pfu.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 00:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nFwhSlS+Pvo/ma1TQw3B7yiFr0R2qAwmXx/iKMM6vms=;
        b=frWQrn9pB0jVThrEPqb3eSmYoAF/DmAkevYHE/b7Kb/MtEMwg1wEoyUVPvDzVdkC7S
         awjLFmy08lOwdUKcSB+RSaSRR3V1etU592zZ2lQlCCMiwE8qRBnv8yXfdWi121+Dn8Uo
         UK5w1RYog3/O+B/byNkYgyltobyOUOKSijY0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nFwhSlS+Pvo/ma1TQw3B7yiFr0R2qAwmXx/iKMM6vms=;
        b=r3CQn8Lka9fALRvz8wSgWciHf+s0j9uBgfPfRkEoqKQzovLhh8mK4dzCsqHrAo6GJN
         8dgNXT8iz7M1TjGMhbKOINmWOZ/eXw/0GU4RdgBSoGZc5ryizjIQCS/jmqErYcy4E3jI
         t090cWyMotRuHcNaEpzZBlO+6ZsQ6b8y+IC+eOGu1XBVqxDtgKqrqa+XJfAUqI9x4doI
         cdygHQSPxj+bRlAheW58HnE3Yc2TfGl0XDM0kGmnFMS2My8BIjgKwGg2CJ7uhwKEW54O
         AKKbVd8dvq/OkEt99tKu/78CmcG48i2OFEUU3fMzWCf+jIwiZTjhouAGAl3uBKConEoi
         QtrA==
X-Gm-Message-State: AOAM532VWEgwz9G8JrYIMTieafF12VireWpvLyuLd7+RBdV/I31bVTXR
        fHQY7OPHYU7jmiexiMErikG7dYYkuV4T2Q==
X-Google-Smtp-Source: ABdhPJx+iqGZOhgaw4SyQsTcTvCYlAyqdoKyfeekSxIq7yqnD+XM7aGa51oCMv9CwhVXGSCgT3rE7A==
X-Received: by 2002:a63:575a:: with SMTP id h26mr2270634pgm.228.1606294158950;
        Wed, 25 Nov 2020 00:49:18 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id x30sm1554565pgc.86.2020.11.25.00.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 00:49:18 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v5 1/2] usb: typec: Consolidate sysfs ABI documentation
Date:   Wed, 25 Nov 2020 00:49:09 -0800
Message-Id: <20201125084911.1077462-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both partner and cable have identity VDOs. These are listed separately
in the Documentation/ABI/testing/sysfs-class-typec. Factor these out
into a common location to avoid the duplication.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---

Changes in v5:
- Corrected the email address in the Acked-by tag.

Changes in v4:
- Rebased on top of the usb-next tree.
- Added Acked-by tag from pevious version's review.
- Corrected a typo ('syfs' -> 'sysfs') in the subject line.

Patch first introduced in v3.

 Documentation/ABI/testing/sysfs-class-typec | 59 ++++++---------------
 1 file changed, 17 insertions(+), 42 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
index 4eccb343fc7b..88ffc14d4cd2 100644
--- a/Documentation/ABI/testing/sysfs-class-typec
+++ b/Documentation/ABI/testing/sysfs-class-typec
@@ -147,42 +147,6 @@ Description:
 		during Power Delivery discovery. This file remains hidden until a value
 		greater than or equal to 0 is set by Type C port driver.
 
-What:		/sys/class/typec/<port>-partner>/identity/
-Date:		April 2017
-Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
-Description:
-		This directory appears only if the port device driver is capable
-		of showing the result of Discover Identity USB power delivery
-		command. That will not always be possible even when USB power
-		delivery is supported, for example when USB power delivery
-		communication for the port is mostly handled in firmware. If the
-		directory exists, it will have an attribute file for every VDO
-		in Discover Identity command result.
-
-What:		/sys/class/typec/<port>-partner/identity/id_header
-Date:		April 2017
-Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
-Description:
-		ID Header VDO part of Discover Identity command result. The
-		value will show 0 until Discover Identity command result becomes
-		available. The value can be polled.
-
-What:		/sys/class/typec/<port>-partner/identity/cert_stat
-Date:		April 2017
-Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
-Description:
-		Cert Stat VDO part of Discover Identity command result. The
-		value will show 0 until Discover Identity command result becomes
-		available. The value can be polled.
-
-What:		/sys/class/typec/<port>-partner/identity/product
-Date:		April 2017
-Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
-Description:
-		Product VDO part of Discover Identity command result. The value
-		will show 0 until Discover Identity command result becomes
-		available. The value can be polled.
-
 
 USB Type-C cable devices (eg. /sys/class/typec/port0-cable/)
 
@@ -219,17 +183,28 @@ Description:
 		This file remains hidden until a value greater than or equal to 0
 		is set by Type C port driver.
 
-What:		/sys/class/typec/<port>-cable/identity/
+
+USB Type-C partner/cable Power Delivery Identity objects
+
+NOTE: The following attributes will be applicable to both
+partner (e.g /sys/class/typec/port0-partner/) and
+cable (e.g /sys/class/typec/port0-cable/) devices. Consequently, the example file
+paths below are prefixed with "/sys/class/typec/<port>-{partner|cable}/" to
+reflect this.
+
+What:		/sys/class/typec/<port>-{partner|cable}/identity/
 Date:		April 2017
 Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
 Description:
 		This directory appears only if the port device driver is capable
 		of showing the result of Discover Identity USB power delivery
 		command. That will not always be possible even when USB power
-		delivery is supported. If the directory exists, it will have an
-		attribute for every VDO returned by Discover Identity command.
+		delivery is supported, for example when USB power delivery
+		communication for the port is mostly handled in firmware. If the
+		directory exists, it will have an attribute file for every VDO
+		in Discover Identity command result.
 
-What:		/sys/class/typec/<port>-cable/identity/id_header
+What:		/sys/class/typec/<port>-{partner|cable}/identity/id_header
 Date:		April 2017
 Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
 Description:
@@ -237,7 +212,7 @@ Description:
 		value will show 0 until Discover Identity command result becomes
 		available. The value can be polled.
 
-What:		/sys/class/typec/<port>-cable/identity/cert_stat
+What:		/sys/class/typec/<port>-{partner|cable}/identity/cert_stat
 Date:		April 2017
 Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
 Description:
@@ -245,7 +220,7 @@ Description:
 		value will show 0 until Discover Identity command result becomes
 		available. The value can be polled.
 
-What:		/sys/class/typec/<port>-cable/identity/product
+What:		/sys/class/typec/<port>-{partner|cable}/identity/product
 Date:		April 2017
 Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
 Description:
-- 
2.29.2.454.gaff20da3a2-goog

