Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4004429AB0A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899445AbgJ0LlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:41:21 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:46938 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899427AbgJ0LlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:41:20 -0400
Received: by mail-ej1-f67.google.com with SMTP id t25so1709812ejd.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 04:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3/wYkEIdKWYXJ7kNDamm5GXkJZDwOHBhS+XfxKLG6sk=;
        b=ZE7fjC60eVK2+kr06vcefzy9RmoNTZcsHKV/KcIS6zz5AJjM7kmzqFfDhYl+n9sPtj
         xrtYoR8dzAX+4eUyA93br1d0Xu0FdJZLEObXbCbbst19zu9lAKDsZWk3B8KmbadfqnrV
         vEnMrEwT8bNzLNnoT9vHPfglClE2cgpNys1Qrwo7EjutP2Tn3GWYfJX3FZNHtSGmkd7r
         ICLG3PVyzffsJXC4rp1gqEpuNk1ZuuqivtQmYfaIt/8oD/fGWIXyIizoUrSrvC7ms1pg
         aFpauqvX1U5M0eMintF53Q3Wq7Mfzkb1a7uQraYuv1YIRERmmQO2oB37UCKjBUHuB/Sb
         hTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3/wYkEIdKWYXJ7kNDamm5GXkJZDwOHBhS+XfxKLG6sk=;
        b=Q6TwarkOicxUONBV7FSFJUZ+/LgvQVje7FhDYrJlH/7pWRJhSmNt6QAyXUlr9M0S9v
         aIM3xsrn+uh+X/AJ1kdFHLapzS7NTpnPDSl/4RIlNl9S3sU6LhfWg2OgJp3Ti1MDJn4Q
         7WYQkS7wwcWkzl0fokS2TOkXW6ucvjxzihUT5FAO+/WTbNkaEWG+OUI+t1YghoPEeJ3y
         Z07wujEJMX0LjDW4R6C1YhhXYvZa5WJwgK7d5ylTt1S05KA1tIK3WBlrb7q+ZRv+0qsZ
         ZPabDTsBmlbUwPazgb6u7zCN1+Ru5a6R4fntpvRwPmaPLX4jjnqSft4eF6kUeXVApTjc
         EN3A==
X-Gm-Message-State: AOAM5334VT4Dz5IUMna4rCkl8MyO4zZlzjxOAJiReGR/IyOAhUUycipN
        4twSP/s3CBG7xvTnE8WpjW8=
X-Google-Smtp-Source: ABdhPJxrYIvtub/cBlTtMWYQK0FXvqTA9bAYHcnyNyQ2oGvgq9XLPhZtMF549IQ1auqT0MlzRQSqig==
X-Received: by 2002:a17:906:1e45:: with SMTP id i5mr1886739ejj.203.1603798879087;
        Tue, 27 Oct 2020 04:41:19 -0700 (PDT)
Received: from localhost.localdomain (dslb-002-204-140-230.002.204.pools.vodafone-ip.de. [2.204.140.230])
        by smtp.gmail.com with ESMTPSA id l12sm804848edt.46.2020.10.27.04.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 04:41:18 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove commented defines
Date:   Tue, 27 Oct 2020 12:40:43 +0100
Message-Id: <20201027114043.22318-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove commented defines from ioctl_linux.c. They are included from
include/uapi/linux/wireless.h. Also clears a checkpatch warning.

WARNING: Block comments use * on subsequent lines

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 6ac904ceb95e..6f42f13a71fa 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -906,17 +906,6 @@ static int rtw_wx_get_range(struct net_device *dev,
 /*  If the driver doesn't provide this capability to network manager, */
 /*  the WPA/WPA2 routers can't be chosen in the network manager. */
 
-/*
-#define IW_SCAN_CAPA_NONE		0x00
-#define IW_SCAN_CAPA_ESSID		0x01
-#define IW_SCAN_CAPA_BSSID		0x02
-#define IW_SCAN_CAPA_CHANNEL		0x04
-#define IW_SCAN_CAPA_MODE		0x08
-#define IW_SCAN_CAPA_RATE		0x10
-#define IW_SCAN_CAPA_TYPE		0x20
-#define IW_SCAN_CAPA_TIME		0x40
-*/
-
 	range->enc_capa = IW_ENC_CAPA_WPA | IW_ENC_CAPA_WPA2 |
 			  IW_ENC_CAPA_CIPHER_TKIP | IW_ENC_CAPA_CIPHER_CCMP;
 
-- 
2.29.0

