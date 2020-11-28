Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A182C71E3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbgK1Vu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730942AbgK1SPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:15:38 -0500
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAF4C0254A4;
        Sat, 28 Nov 2020 08:54:25 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id i30so1765047ooh.9;
        Sat, 28 Nov 2020 08:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eamRpZz1ZqJByTBkkjNUF2hDN29PEll052WwYiSB7Xc=;
        b=gjCwHA9fn8Qb+x+7r9E/5GnJhCHU0XV8MNTyUQB5N0rbtpXy9bSq6PDT0ZxpnYl8MV
         +HKUqgcKvk6dNqhTzWU9rFiLVLmdXi1lpcVOkiuKLhWOP4E/5t8z5augybhIfm9sESNZ
         jAaqIzuTsA9XzZtLZCSajLVsThPuhoLURiPeq3IMn4MLl8JnF6Sc/ncrz6lUttNJZWBO
         RRSX7wF2nMV54eIrqrf6nqzBTh++cY160NjF+Tvv+c22HtlAWZCi2TINFmOY3MMHIz/K
         5kj404l0+RjW6GuZdq4EunZJSSe3O9pLhiYowp38I1kWo+50vUCZPnH8PhWOaCx8HDYV
         KwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eamRpZz1ZqJByTBkkjNUF2hDN29PEll052WwYiSB7Xc=;
        b=pQFXmbLlsAjfhUV8miRVK965dI1+WprwikVdQ+WH7Yc7hokjGskQsUbwTCf7zt5u8Q
         tyN7CmPzwmjYglG85hOao56zILr1H8crCy7zNW0flcCcPkQ01JPndus8gkkM+zIjTuMy
         BIX+OZVw7A/KRRq2Qq/fHpXwZzjtfki+lymaQ7ontuS3KKTjGM0dcLK/cMHt38yQsRN0
         ad73IpzWFWfJVhxscRaXyGxrvy4n6l0PzSSMPfp1FM68gBfvwTJ/QttvWlGf/Wrwz4k0
         ayyWFAcHiRTdPXhrP9L8RBW3rmmLn0XhDh7nqsy9gC/EsK0OudkfFQYSvi/F/47xsxcn
         4Yxg==
X-Gm-Message-State: AOAM533NgwpbS1zaUHA3fhzNNw8yxaQ1XvmbtPhf0/veiMj0E2pgBXDe
        Iz8fPhzIu1nv3F6/7j2RH/o/KUXnWwGLlZ1o
X-Google-Smtp-Source: ABdhPJyVSwEiKmHcEOW7w27hGw6ZrHPriqTWxQxnHmXN5vsDzGP3WgfV/xDU0xCSP3Lc0nOdTrECcw==
X-Received: by 2002:a4a:a8c8:: with SMTP id r8mr9944850oom.9.1606582464499;
        Sat, 28 Nov 2020 08:54:24 -0800 (PST)
Received: from DESKTOP-OG3B567.jamisontribe.com (cpe-173-174-149-136.satx.res.rr.com. [173.174.149.136])
        by smtp.googlemail.com with ESMTPSA id 8sm6632306otv.26.2020.11.28.08.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 08:54:23 -0800 (PST)
From:   Joe Jamison <joejamison717@gmail.com>
X-Google-Original-From: Joe Jamison <joe@smaklab.com>
To:     rydberg@bitmath.org, jdelvare@suse.com, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     joe@smaklab.com, joeJamison717@gmail.com
Subject: [PATCH] hwmon: (applesmc) Add DMI product matches for Intel-based Xserves (non-RackMac*)
Date:   Sat, 28 Nov 2020 10:54:03 -0600
Message-Id: <20201128165403.2075-1-joe@smaklab.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the DMI Product ID for Intel-based Xserve machines.
They use the same SMC accessible from the same data ports.

The 'Xserve' product ID only resolves to SMC-containing
Intel-based Xserves, as the PowerPC machines are identified
by the 'RackMac' identifier.

Tested on: Xserve3,1

Tested-by: Joe Jamison <joe@smaklab.com> # Xserve3,1
Signed-off-by: Joe Jamison <joe@smaklab.com>
---
 drivers/hwmon/applesmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 79b498f816fe..89207af81c48 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -1299,6 +1299,10 @@ static const struct dmi_system_id applesmc_whitelist[] __initconst = {
 	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
 	  DMI_MATCH(DMI_PRODUCT_NAME, "iMac") },
 	},
+	{ applesmc_dmi_match, "Apple Xserve", {
+	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
+	  DMI_MATCH(DMI_PRODUCT_NAME, "Xserve") },
+	},
 	{ .ident = NULL }
 };
 
-- 
2.20.1

