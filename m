Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D52727907A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 20:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbgIYSc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 14:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729892AbgIYScX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 14:32:23 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18E8C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 11:32:23 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d6so3991113pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 11:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4I9TKrK8mQBfL74FGJ3Y6iU/hZdg+xeVUjtNAbqFIqo=;
        b=EkKxpyyCRQPfwk6tXtTWIusqt+JYTltBhuFOOWuz4kGG9Wl/zoWEDRE1lJeFYaKuLG
         XLoWFDKz5Ae/e4YLOU1XF8kjfuZdheZSUd+7/JTJ+VND1lRcI4KszM2gZDxiAWkdmPgV
         HrgginFUx1ntgbOqw8lnfhBrRVTjLCq+2Akz5/9dMw0BtOrk0Vt4gZIoKbwokhQ4EUjH
         xtITe3MdQElPM6tMED9R+gJfSBYpxyw6aG4hXYZHgf9nfWULxXqZcAzjqvU8VNwsPjtz
         r4kb8AIiXSIJArQ+uipptmyg7i/pOtwBLuhs9NP2erzGL1lExoQFYeb5/W8XFJT1ghH1
         B+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4I9TKrK8mQBfL74FGJ3Y6iU/hZdg+xeVUjtNAbqFIqo=;
        b=tPv9AyO1LqO9Cn5tLLMA9cDRvYFYZwc+ohU4DEm/R3/Re579l6944Hhe0MTgwUR910
         KNQIZEoVew5XqqABs3vIGnZ3y08KSLjQ+Mxo47E3sEEeeW1HWcBe90qMkMVjjzDehwqN
         PSsMcBJAKaX/OV7DhxhWTqjsj2FJPPVlwvOrkr7dCNvU80pzSci06cwyJiO68HB+30wV
         VnWIKSJ9StaPD5ibSsXaPSSQjMd6aDvBgLNUpB8MoDWBEWnt538styHFelA6Ip4OLvxF
         5+lbJCY9emmMSuGn1cDUYRn8QHMjmtOFHp6a11kjDc0ux15UyAnVTgwKCxaZpaojeCKe
         BRRA==
X-Gm-Message-State: AOAM533jH5S/FA5by9A0d2q2qY7ZXjWf046w/i/tetS4yAoBdFmFt446
        u0V9hcdh2AlRDrc5ld2hkBWdRQ==
X-Google-Smtp-Source: ABdhPJwmQKSNHbj3FK9SVRlV13a+dFjKhinVBBkgWkygxcDqc1dh6TOjxWo6eXKRNPJRs9yVoNYYZA==
X-Received: by 2002:a63:ea15:: with SMTP id c21mr225421pgi.446.1601058743233;
        Fri, 25 Sep 2020 11:32:23 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id r16sm2554546pjo.19.2020.09.25.11.32.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 11:32:22 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, mchehab@kernel.org, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC v2 11/47] staging: media: zoran: zoran_device.c: convert pr_x to pci_x
Date:   Fri, 25 Sep 2020 18:30:21 +0000
Message-Id: <1601058657-14042-12-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601058657-14042-1-git-send-email-clabbe@baylibre.com>
References: <1601058657-14042-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_device.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_device.c b/drivers/staging/media/zoran/zoran_device.c
index 61b4cfccc168..e50153218f72 100644
--- a/drivers/staging/media/zoran/zoran_device.c
+++ b/drivers/staging/media/zoran/zoran_device.c
@@ -162,7 +162,7 @@ static void dump_guests(struct zoran *zr)
 		for (i = 1; i < 8; i++) /* Don't read jpeg codec here */
 			guest[i] = post_office_read(zr, i, 0);
 
-		pr_info("%s: Guests: %*ph\n", ZR_DEVNAME(zr), 8, guest);
+		pci_info(zr->pci_dev, "Guests: %*ph\n", 8, guest);
 	}
 }
 
@@ -172,7 +172,7 @@ void detect_guest_activity(struct zoran *zr)
 	ktime_t t0, t1;
 
 	dump_guests(zr);
-	pr_info("%s: Detecting guests activity, please wait...\n", ZR_DEVNAME(zr));
+	pci_info(zr->pci_dev, "Detecting guests activity, please wait...\n");
 	for (i = 1; i < 8; i++) /* Don't read jpeg codec here */
 		guest0[i] = guest[i] = post_office_read(zr, i, 0);
 
@@ -198,15 +198,14 @@ void detect_guest_activity(struct zoran *zr)
 			break;
 	}
 
-	pr_info("%s: Guests: %*ph\n", ZR_DEVNAME(zr), 8, guest0);
+	pci_info(zr->pci_dev, "Guests: %*ph\n", 8, guest0);
 
 	if (j == 0) {
-		pr_info("%s: No activity detected.\n", ZR_DEVNAME(zr));
+		pci_info(zr->pci_dev, "No activity detected.\n");
 		return;
 	}
 	for (i = 0; i < j; i++)
-		pr_info("%s: %6d: %d => 0x%02x\n", ZR_DEVNAME(zr),
-			change[i][0], change[i][1], change[i][2]);
+		pci_info(zr->pci_dev, "%6d: %d => 0x%02x\n", change[i][0], change[i][1], change[i][2]);
 }
 
 /*
-- 
2.26.2

