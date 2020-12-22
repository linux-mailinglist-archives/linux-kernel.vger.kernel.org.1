Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7352E0BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 15:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgLVObc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 09:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgLVOba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:31:30 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9422CC0611E4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 06:30:23 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id dk8so13132907edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 06:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W7MQknUNgfLi/fumFEQOeiLKRWIy/aG8D1EJYUy6tL8=;
        b=jBX9nztfQcPXEjVMwnk21ruKkoLxUS1MgYhJj3wDAkcRcf9KXbhVt7pHh0977ou7Wr
         54Q9X6bMFiYM4VtrH/LSWoIC7q3Bkq1K4T+IjizolTH7Glze2ZrB8wetmkUVQnhMMDKj
         fzOW5UnqaSajFTTSmCplT53xwYb72LNhCKhOh1cO1tAf2WjhrA6GC3aun0amICb7TOQt
         WBwazbfIATu4U1ub0vaTfrsy87Du8TITu2vkIM2UNzJ5raMjnDI0erTr6DtkRAisYVRc
         ioYatjSELhgFQU3GpXbFgazQ+9TNr8C8gnUHoTVhMGqg2lwXsS5CN3EGhhioUGnhrkaP
         bHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W7MQknUNgfLi/fumFEQOeiLKRWIy/aG8D1EJYUy6tL8=;
        b=KpD4ZJ/9R/936/XYJdzWubDXeXHneqrfDL6f+xknMduvux+JCtVd5U85Hdcg34YFU9
         KWxY4xAQ6rLU7uvbIGQDj1BaVZwzepXnH4MZYvcGyB7ikypBxYKVqWuWP7fIdnSB0qgL
         X77EgtAKelkeemrPGdaFFmScLn/6xw3U8d3Qf2kHW4Ibds3W3o7Xj70DpVN5D9FpjM09
         20++k+owzidccrrhTpt17mlQpnqyw7C0EHwX95uU5DyOLA1i/UO6Wc/tK1wzPj65lI52
         zWsKN75g33ILKzLVgUZGJj7VxUnsA8rq/P10XF//2eLNGhdICwcM7pmlSlGZIEHYjphT
         ox+A==
X-Gm-Message-State: AOAM531uL00nkb2iuH38+VVmco+JXu/xPOCsfBgLnD2xTyHMPCkMmd+r
        8JRzl9YeymQAHQHUcvltsn03mw==
X-Google-Smtp-Source: ABdhPJy++1Le2msaWn/K1l3VFk+h7JwyCtlOkwbkNSRlLVe1Eqdy3NF5D45K12eS/cRumAwt813IQQ==
X-Received: by 2002:a05:6402:2207:: with SMTP id cq7mr20427116edb.310.1608647422296;
        Tue, 22 Dec 2020 06:30:22 -0800 (PST)
Received: from localhost.localdomain (dh207-99-167.xnet.hr. [88.207.99.167])
        by smtp.googlemail.com with ESMTPSA id z1sm8434896edm.89.2020.12.22.06.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 06:30:21 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH v3 3/3] MAINTAINERS: Add entry for Texas Instruments TPS23861 PoE PSE
Date:   Tue, 22 Dec 2020 15:30:12 +0100
Message-Id: <20201222143012.1618807-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201222143012.1618807-1-robert.marko@sartura.hr>
References: <20201222143012.1618807-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers entry for the Texas Instruments TPS23861 PoE PSE driver.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 830244166a7c..5441be7a5c26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17336,6 +17336,14 @@ F:	include/dt-bindings/soc/ti,sci_pm_domain.h
 F:	include/linux/soc/ti/ti_sci_inta_msi.h
 F:	include/linux/soc/ti/ti_sci_protocol.h
 
+TEXAS INSTRUMENTS TPS23861 PoE PSE DRIVER
+M:	Robert Marko <robert.marko@sartura.hr>
+M:	Luka Perkov <luka.perkov@sartura.hr>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
+F:	drivers/hwmon/tps23861.c
+
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
-- 
2.29.2

