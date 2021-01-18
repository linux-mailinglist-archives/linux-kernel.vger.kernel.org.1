Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A734D2F9B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 09:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387702AbhARITT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 03:19:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387572AbhARIS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610957849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8p71lFNP7FXrIuyl6skw0ASk5esBQ6KVEaZUK9bQhEI=;
        b=JRIApjMddu30MNshfek+jWhC2y7NpHGB1NB9NnhRRSmPbSyEa0vOV2eadn8UUrkuElHQKv
        SdMWqjTvRZtYNjEDnI/wuZcCsY1fyTCvNDuk9QGJsICr4DLiOqr51XfTKnDGSNw+2jsEwF
        bZbm1rlLfjWS9eZPpt+sgscWC86kKWA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-RyavO7BoPcSUSkiY8quevw-1; Mon, 18 Jan 2021 03:17:26 -0500
X-MC-Unique: RyavO7BoPcSUSkiY8quevw-1
Received: by mail-wm1-f72.google.com with SMTP id u67so1486222wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 00:17:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8p71lFNP7FXrIuyl6skw0ASk5esBQ6KVEaZUK9bQhEI=;
        b=Q/ai4OlqC64XgKxT47WpKTrLKYvJQqrK//j9wiFhMEFgMhGCG9JX/kRdgJ6jQ7KoV/
         X4IkXZCt79wpcwfugCJlIb4A1c+aeUsymMIqej/LmrXjpY370SjStlpTTQJ6Uo4/n1O1
         9mz40+rt46470OgkX/UJYXCpN1VR9GBNgf2DvxDGbIUY9zrmRhXtKkWNBYgBW/xvuyyt
         0kJzVaRJ0YkN3exl5jJXGqVdXybsU07PHKsHe+I4pWhNokiXpDAvnAF8mZXyJ9vw6l90
         OMtet5j7mNoaj8ikZ8JWX5kxmdzhGuheKJkLVvqEhqnIpmGLQpD5wuNTscxKkeziZUsR
         +Qlg==
X-Gm-Message-State: AOAM530LHC4smKvu4pB0faY5sViv50bgCrHzTXqO9pzQ10queSXOOyV+
        r6LvIvGShoAZqN0wB75ZZ+QSryHORsBQ2iO4x8zocrQk3xij8HF+L936L9kIH0YE7yOzoa4jvZ2
        9LrvWs1tU69YoGa0awJ8254P7W1PjMa62qlC/e8ZnPpW9DT8B7wT0qM50+cQhstjxw2JyxbIBmT
        8=
X-Received: by 2002:a1c:7d8e:: with SMTP id y136mr19233396wmc.25.1610957844882;
        Mon, 18 Jan 2021 00:17:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWNpmRpqtOwIwpRwr9ajm9ng9gHciOz2/IHbrBx5b2wdpPFb2jiNCZIdjtb8rJFTA5f1KwGQ==
X-Received: by 2002:a1c:7d8e:: with SMTP id y136mr19233369wmc.25.1610957844580;
        Mon, 18 Jan 2021 00:17:24 -0800 (PST)
Received: from minerva.redhat.com ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id l8sm4906002wmi.8.2021.01.18.00.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 00:17:23 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: [PATCH] ARM: dts: omap3-igep: Change email address in copyright notice
Date:   Mon, 18 Jan 2021 09:17:07 +0100
Message-Id: <20210118081707.160596-1-javierm@redhat.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've switched employer a long time ago and the mentioned email address no
longer exists. Use my personal address to prevent the issue in the future.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 arch/arm/boot/dts/omap3-igep.dtsi            | 2 +-
 arch/arm/boot/dts/omap3-igep0020-common.dtsi | 2 +-
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts   | 2 +-
 arch/arm/boot/dts/omap3-igep0020.dts         | 2 +-
 arch/arm/boot/dts/omap3-igep0030-common.dtsi | 2 +-
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts   | 2 +-
 arch/arm/boot/dts/omap3-igep0030.dts         | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index 5de2be9bbe6..99f5585097a 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -2,7 +2,7 @@
 /*
  * Common device tree for IGEP boards based on AM/DM37x
  *
- * Copyright (C) 2012 Javier Martinez Canillas <javier@osg.samsung.com>
+ * Copyright (C) 2012 Javier Martinez Canillas <javier@dowhile0.org>
  * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
  */
 /dts-v1/;
diff --git a/arch/arm/boot/dts/omap3-igep0020-common.dtsi b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
index af8aa5f0feb..73d8f471b9e 100644
--- a/arch/arm/boot/dts/omap3-igep0020-common.dtsi
+++ b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
@@ -2,7 +2,7 @@
 /*
  * Common Device Tree Source for IGEPv2
  *
- * Copyright (C) 2014 Javier Martinez Canillas <javier@osg.samsung.com>
+ * Copyright (C) 2014 Javier Martinez Canillas <javier@dowhile0.org>
  * Copyright (C) 2014 Enric Balletbo i Serra <eballetbo@gmail.com>
  */
 
diff --git a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
index 567232584f0..9dca5bfc87a 100644
--- a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
+++ b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for IGEPv2 Rev. F (TI OMAP AM/DM37x)
  *
- * Copyright (C) 2012 Javier Martinez Canillas <javier@osg.samsung.com>
+ * Copyright (C) Javier Martinez Canillas <javier@dowhile0.org>
  * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
  */
 
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index e341535a716..c6f863bc03a 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for IGEPv2 Rev. C (TI OMAP AM/DM37x)
  *
- * Copyright (C) 2012 Javier Martinez Canillas <javier@osg.samsung.com>
+ * Copyright (C) 2012 Javier Martinez Canillas <javier@dowhile0.org>
  * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
  */
 
diff --git a/arch/arm/boot/dts/omap3-igep0030-common.dtsi b/arch/arm/boot/dts/omap3-igep0030-common.dtsi
index 71b0ae807ec..742e3e14706 100644
--- a/arch/arm/boot/dts/omap3-igep0030-common.dtsi
+++ b/arch/arm/boot/dts/omap3-igep0030-common.dtsi
@@ -2,7 +2,7 @@
 /*
  * Common Device Tree Source for IGEP COM MODULE
  *
- * Copyright (C) 2014 Javier Martinez Canillas <javier@osg.samsung.com>
+ * Copyright (C) 2014 Javier Martinez Canillas <javier@dowhile0.org>
  * Copyright (C) 2014 Enric Balletbo i Serra <eballetbo@gmail.com>
  */
 
diff --git a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts b/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
index df6ba121983..8e9c12cf51a 100644
--- a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
+++ b/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for IGEP COM MODULE Rev. G (TI OMAP AM/DM37x)
  *
- * Copyright (C) 2014 Javier Martinez Canillas <javier@osg.samsung.com>
+ * Copyright (C) 2014 Javier Martinez Canillas <javier@dowhile0.org>
  * Copyright (C) 2014 Enric Balletbo i Serra <eballetbo@gmail.com>
  */
 
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index 32f31035daa..5188f96f431 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for IGEP COM MODULE Rev. E (TI OMAP AM/DM37x)
  *
- * Copyright (C) 2012 Javier Martinez Canillas <javier@osg.samsung.com>
+ * Copyright (C) 2012 Javier Martinez Canillas <javier@dowhile0.org>
  * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
  */
 
-- 
2.29.2

