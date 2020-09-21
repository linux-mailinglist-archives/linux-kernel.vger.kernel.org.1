Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2562720A8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgIUKYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgIUKUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:20:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A914CC0613DA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:20:45 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w2so11565080wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3+BODOaAXA+uCGmzHO/lJ88Q7uOk7/VYMBsUUN6E7FI=;
        b=g2ZZiy2uI7gbXpoEi2F50flRdFq1ECigCJz6wdUdIQYHcawsArICTGRu5VXPUhOqxz
         BKklg6BeS6jJvIh+HoVfJXRi8BO/7K7HR8DMlVXNXZiaiTpd8Vf1g+VJUWo2dJNys2MP
         KfN6zqWB/n+twqGa3g2MQtq79oAG83WTdYf5fzoD57GbX5gkesP+a0Zyd67xb95IAMo6
         xvWjKG8RsNkwGzxB/9ePE0g6f+Kp7UZVlgx/W4P925AP4tRS9nVSY8uJ6+r8NnWUnrxL
         KTrWooeGuI7+C4tZZ15K21pC+JofulEB+fYRSxWvKx4GuoWuqd9MMu1wTECKEvOturnL
         wzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3+BODOaAXA+uCGmzHO/lJ88Q7uOk7/VYMBsUUN6E7FI=;
        b=dAwagA8iDuPotk5ksLzUjv9OWIHdscQDi2zO7YMNVFlox0KponH5AnYH15FeF+HLQe
         z81YyCx4LvrsbqtslR4kiorjkWcHZK4JMuBxMz1NFYbNPDCo698sJXia/fRnVw+HpQn5
         KzdMi9IEDmfiGEzg+sZF9fnyIFkK5kMekmjVHAOXD2lRmNTxylVbHr6iZrMRYvRfdNOr
         C9aPaUKlrk0efcRJFzW5vxJoenw5MEzwJPC4EhEec6gvfM1KRDwnfJS1nSJDFavppk9L
         VLXypXlqRwtVqGrti27iZYAuQc/NNr7JmuEDWZa82SEkdlrNcEqBWcDXrMQDZ4aySWdn
         g8eA==
X-Gm-Message-State: AOAM533/RH+8Dfh3t2uIFU2Ut8o0J5SbQLnuiGakACPjRqdKu3w9weNo
        Tx0p2yFViUGiIALypGS0mT/FjQ==
X-Google-Smtp-Source: ABdhPJx/OW+rrphaBSknMg7GqCDSQ46jnMDP5ojIonXfLVvVb0RNJxHTiZB4zTGsRPyjTGtIWxph7w==
X-Received: by 2002:a1c:4943:: with SMTP id w64mr28400063wma.62.1600683644388;
        Mon, 21 Sep 2020 03:20:44 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l17sm18804629wme.11.2020.09.21.03.20.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 03:20:43 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, laurent.pinchart@skynet.be,
        mchehab@kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC 12/49] staging: media: zoran: zoran_device.c: convert pr_x to pci_x
Date:   Mon, 21 Sep 2020 10:19:47 +0000
Message-Id: <1600683624-5863-13-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
References: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_device.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_device.c b/drivers/staging/media/zoran/zoran_device.c
index 516a7f18ce7a..03ad3562a807 100644
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

