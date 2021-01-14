Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9F42F5F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 11:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbhANKyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 05:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbhANKyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:54:12 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A467FC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:53:31 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id v24so731401lfr.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TtJJqihqg8TljPTmlKfMBOpdyeHSyZrkR2kPWFJ/n6U=;
        b=vJjFZopyYcnwjGM3fETkICzrdhwrsxQJe1EPzVqeYT/Bxoi4dFOLhJ0oYJ15LN7BBs
         Cu85LN5ytVuitHdpRZgHYFCCFvvdvJPf8EqYBL8Qo6Kx8RgC1CVDXawRlBe65q5xNakH
         QBk67GFKbV/xm7toznyig82/9RaXivLbKa/i4VAiCob+biV0svz4+8ci1maDizQ/tj5T
         xWBfvwuCtPfWDNegHyWhGP8Bobm7a7FoRmq/IlzW++Mo4eR7hg6HsQ0Ck3beRfgS+Zjk
         PW+LVcmULmQwlL8ubihe9sOXtIskLgoBpAFcAVAmcyMzLWqMu5IdfK4d9e/dHQi+SLAZ
         GQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TtJJqihqg8TljPTmlKfMBOpdyeHSyZrkR2kPWFJ/n6U=;
        b=IXPmZwLpQ1JbEm97Gxqo5NYmqKB73+4oVHaEdo5pIC6sVkMDkCmUIXsMnNn6mhdFjo
         DflXPHz6Y/yt9TwmVfP7gaSrIfviyqW5BRfqz67Fjyzp/BdafqVgmS0odMXu951GrPpu
         lP4dM0R8NbNpgjD6w4B022+wx2XXI/rC+/KXbwFs5RqQqlzRRTL3eRJEdSfdp+0nMMs0
         36lY5yb5JB1f+k4QiryUosj/2NpBZmBsdZ7PZvugvThSSyqbcntC9jovTpwfDhpKd3El
         NkCE69oq+T2ZotFWKvxKUxiP5hTaw6z/vZ85Po+Tt/ERDiMC1m3KXAbwh5UfADlu6rCz
         NKdw==
X-Gm-Message-State: AOAM530GR60aWXTCV9PP8P+vR1E+0EIfqef3F0YbNyKZOdLGmQm2cY80
        /PPGBVaCXpq+mBmhGX7nkF0=
X-Google-Smtp-Source: ABdhPJwiwowstSeZxLTO0iSke52AorCIyZpC7GXb1XU7yhtkzApj1TIELKvD9is8cChOlxiIeEUjog==
X-Received: by 2002:ac2:5cac:: with SMTP id e12mr2937017lfq.216.1610621610086;
        Thu, 14 Jan 2021 02:53:30 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id 10sm510411lfh.208.2021.01.14.02.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 02:53:29 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH Broadcom/stblinux] soc: brcmstb: add stubs for getting platform IDs
Date:   Thu, 14 Jan 2021 11:53:18 +0100
Message-Id: <20210114105318.14970-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Some brcmstb drivers may be shared with other SoC families. E.g. the
same USB PHY block is shared by brcmstb and BCM4908.

To avoid building brcmstb common code on non-brcmstb platforms we need
stubs for:
1. brcmstb_get_family_id()
2. brcmstb_get_product_id()
(to avoid "undefined reference to" errors).

With this change PHY_BRCM_USB will not have to unconditionally select
SOC_BRCMSTB anymore.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 include/linux/soc/brcmstb/brcmstb.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/soc/brcmstb/brcmstb.h b/include/linux/soc/brcmstb/brcmstb.h
index 8e884e0dda0a..9433f5c8fd94 100644
--- a/include/linux/soc/brcmstb/brcmstb.h
+++ b/include/linux/soc/brcmstb/brcmstb.h
@@ -12,6 +12,8 @@ static inline u32 BRCM_REV(u32 reg)
 	return reg & 0xff;
 }
 
+#ifdef CONFIG_SOC_BRCMSTB
+
 /*
  * Helper functions for getting family or product id from the
  * SoC driver.
@@ -19,4 +21,18 @@ static inline u32 BRCM_REV(u32 reg)
 u32 brcmstb_get_family_id(void);
 u32 brcmstb_get_product_id(void);
 
+#else
+
+static inline u32 brcmstb_get_family_id(void)
+{
+	return 0;
+}
+
+static inline u32 brcmstb_get_product_id(void)
+{
+	return 0;
+}
+
+#endif
+
 #endif /* __BRCMSTB_SOC_H */
-- 
2.26.2

