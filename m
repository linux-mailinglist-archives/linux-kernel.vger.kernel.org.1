Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8F22D0AFD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 08:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgLGHOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 02:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgLGHOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 02:14:05 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F443C0613D3
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 23:13:19 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t37so8140673pga.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 23:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2k+oDaqkHwmbJOsWV53SyXbGKj1PMhzkgY3csI96BRU=;
        b=oXJ1NoOYPlMW8EPwkr5KV5W7GB2HvsdrBqCMY5r4qvbk+BDUSMPRe1OMN2M7tP03B2
         C0GfPKhUonqO6q3rZx2qp8qC4X11YKWfUEx9WbYPH/pxrESP7gJYjrryK8yka4HPNKD/
         GE/4dEQoeoaopap/bPW+u297D7q1a+JA0MVKJr2PRUKPTPfFNGfzWyMIq0E5J5+4CGJq
         IhlRyYdHlLwEfGOz6wksDgB9R1LEkIcy83ehwBw0FxgU+hkhRVy1peqhfl2KMahDSvDM
         w/xxzG5E6nuW9i8UXTETHvrSxpbN2o8jbpJlksyryS5gfyncAuOc+4ZsnW+coczxKsIX
         HsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2k+oDaqkHwmbJOsWV53SyXbGKj1PMhzkgY3csI96BRU=;
        b=qmkhuPi28/98mXClpXc7o+7M3H5gvZz4X5NwxCOnmEdn9CaPRilhXoIT2iLzNNVmVj
         w8YTNaDOeJBZ4diNiy3Pw44jnaPKaPCyWsRJgyvJwYMkkmoWjTAJ+k+os0Dtd1ijtk/m
         u9hokfqt1PtamrieDXh0dLhAQPGZGn9X9rnvJzHpXF7CXyEx8yVNT+UnS6lkxG2TcpXM
         vLyHXcLmXNcnZmVuW8pwPTd4IziDgxNxFRcYEXF2aUfU7RiqQ2uirLvmz3rp4sUV0CLv
         rk/gdd8d0U74m6V4U6TTLEiLYPv42+I2j8nU3T2NfvBdCAFFjStXcrX6qTky7xY4IbIP
         RlLA==
X-Gm-Message-State: AOAM533xUKKZ9W2wb/UQusv2qs0jT0HSMyc5aSXyiadKlWNBCEZKKLu4
        HBmRvGoJj5URNXrasokUW97akQ==
X-Google-Smtp-Source: ABdhPJzZRTRSqGMc6OOIiFoMV3KX46AWzZSrqEGByKB++4nGFMVLGPyGPweibxSNibfAwQsFVha9Pg==
X-Received: by 2002:a17:902:446:b029:d7:cdda:87 with SMTP id 64-20020a1709020446b02900d7cdda0087mr14754494ple.11.1607325198562;
        Sun, 06 Dec 2020 23:13:18 -0800 (PST)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id y24sm12794152pfn.176.2020.12.06.23.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 23:13:18 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     dmitry.torokhov@gmail.com, kevin@kevinlocke.name,
        hdegoede@redhat.com, limero1337@gmail.com, rajatja@google.com,
        jkosina@suse.cz
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH] Input: i8042 - add Acer laptops to the i8042 reset list
Date:   Mon,  7 Dec 2020 15:12:50 +0800
Message-Id: <20201207071250.15021-1-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The touchpad operates in Basic Mode by default in the Acer BIOS
setup, but some Aspire/TravelMate models require the i8042 to be
reset in order to be correctly detected.

Signed-off-by: Chris Chiu <chiu@endlessos.org>
---
 drivers/input/serio/i8042-x86ia64io.h | 42 +++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index a4c9b9652560..f5ce656dc73f 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -607,6 +607,48 @@ static const struct dmi_system_id __initconst i8042_dmi_reset_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "AOA150"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-332"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-132"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-432"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A315-31"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A314-31"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A114-31"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate Spin B118-RN"),
+		},
+	},
 	{
 		/* Advent 4211 */
 		.matches = {
-- 
2.20.1

