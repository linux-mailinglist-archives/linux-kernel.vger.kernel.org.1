Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D132F16E3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 14:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbhAKN64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 08:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387908AbhAKN6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 08:58:45 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C75AC0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 05:57:21 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b2so18921434edm.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 05:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=05WhkcTFmBsr9whzq7N+CgKfu1Y8Nmz6LAwOiQkDfTI=;
        b=G3FlCdMjHDQKo4Fz17V1HFMjNMe0yhV20SwGuoyn/sN+dulQeXXYvNcQVzTdyGiN2k
         IJRGxpINn6xPGTF4227OfkMbNfWZC9/63wDRWvXbMuG822oc3kXK1lbhzcE0E8aq5SBi
         6d33VmLo2aqVKMEmn6YTHs/Go4s7HNfQDgtkN+sEErizfnF6PURrLNACnbRWYL/soHjO
         yklPhJSESqzWeVDo+UV4JqEqyzJlZrerCJ/Gh8SwGuhS3Qs9US0q85aNYiVmBvQm1Xxh
         Le6y0CjLzpBL3eMthzC5ioZWLszjStq3Z0KZDt2hW384vF6a9tQXhWQw8gEc7R7di9fw
         AA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=05WhkcTFmBsr9whzq7N+CgKfu1Y8Nmz6LAwOiQkDfTI=;
        b=ZTkJxWSdKLg6olkQbtWZG+Y9AV2EEaF3Y77/3sa0qg+GpmnaYB+z+zCCnkaEnHW0R4
         PMa9BJ0UHQLNhDWXO6TKSQjN0s6cNJoLWz7nE7/+/n13IpaB3NsnzCCjhJ7iQ+qUvmAR
         0DJTScU0jaXU1saExTnLfW9nFZQVDkLqg/Py28tkaK7DuBpVBVkAB5/O5xOkusDd0kHq
         B7jAIqHPR/XzNoBNqAigRimRqCTdKrs+Rf5ibGaPuboimqfwQh8fDx6SfvBD+JMh6vI/
         JM9LDUaeT2aBALuHa65+YYY8D/WR7zlSJR77h2efJxsDctVA9COfcw3UcFXtsa9xXKL1
         MYHg==
X-Gm-Message-State: AOAM530ZNPqeeAMIeclZTcHQArO5+DunBgXnMgkSV+AyDT6bm9o0l6IW
        Su/ZPmYaGJgHGv0xBZyxuXTKica49/kTpg==
X-Google-Smtp-Source: ABdhPJxn3AWBZlrTAtOHn2pyFbV5zfR59Ms52ZaEkkfdw0/J4RQmgY1hSYy4TtW6q2V7RQoVpVp7UA==
X-Received: by 2002:a05:6402:a52:: with SMTP id bt18mr14445544edb.228.1610373439924;
        Mon, 11 Jan 2021 05:57:19 -0800 (PST)
Received: from localhost.localdomain (dh207-97-248.xnet.hr. [88.207.97.248])
        by smtp.googlemail.com with ESMTPSA id ak17sm7176408ejc.103.2021.01.11.05.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 05:57:19 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH v4 3/3] MAINTAINERS: Add entry for Texas Instruments TPS23861 PoE PSE
Date:   Mon, 11 Jan 2021 14:57:08 +0100
Message-Id: <20210111135708.3703175-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210111135708.3703175-1-robert.marko@sartura.hr>
References: <20210111135708.3703175-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers entry for the Texas Instruments TPS23861 PoE PSE driver.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
Changes in v4:
* Add documentation file

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1feabab03fb2..527db97c42ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17607,6 +17607,15 @@ F:	include/dt-bindings/soc/ti,sci_pm_domain.h
 F:	include/linux/soc/ti/ti_sci_inta_msi.h
 F:	include/linux/soc/ti/ti_sci_protocol.h
 
+TEXAS INSTRUMENTS TPS23861 PoE PSE DRIVER
+M:	Robert Marko <robert.marko@sartura.hr>
+M:	Luka Perkov <luka.perkov@sartura.hr>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
+F:	Documentation/hwmon/tps23861.rst
+F:	drivers/hwmon/tps23861.c
+
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
-- 
2.29.2

