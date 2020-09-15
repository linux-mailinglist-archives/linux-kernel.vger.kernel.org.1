Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D4A26A232
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 11:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgIOJcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 05:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIOJcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:32:03 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE8AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 02:32:02 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id b79so2698808wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 02:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mzjxk6Z1eBrJN1ZjH1a+7+cmqXARPYvjYL126a4N7s8=;
        b=V8pFeg/GpWzpHfmH6r2/l3YP0qMrgVmfaaP7hSqnG26Ak9Q02anebh3MBGWiRc0Whj
         1d3MhU/cusjU88L3dYhPCCophjl5G2IWatce1ynFfhYStWt/80HBd0rAYGMIlKWR/v2/
         Jw1tQGu9m23/ZSrnzs2kyTdcL/m42y7kWZ5Sc3JS8n7XKbRRAH7x+24TTmniXh8FP84R
         Xn3C6R+Z4HjWBxbd+9rGCiRvUeSDLRtzzc/U7z/yvAxvbyYWBfsewRUIT8hvAQc45yoA
         dhLgAbVHDOpW/P0DKhuyinMy8ft1guzC8s4cIX9NotIi6vG8K55cz/YuLYF3M+FnJ+bg
         hwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mzjxk6Z1eBrJN1ZjH1a+7+cmqXARPYvjYL126a4N7s8=;
        b=G3F4m6QgMXOkl7i3SrsyY3JLHq+axwswbTwA+eeZd3Teijb2z9dM0FZdnT2/Ci0IsR
         iJxmxXZ9fuJ7nbw9fItjn88q77HU2eoJoXLisbGSv2SO+jUit4I4RDjoEjX9I+OKvWZJ
         SZFG5wON83bXhkQ81K3h2tn6ArX1x3Dw6v79pZbQKdHqQgoyhvb+90XysRXFu9P9CkDD
         lifBFut5VyzdewFG+/5mEDBbLAgHwjwEc64MvQPJP6RrhUCKizjPEA/f8ojgfE5vauZX
         9uEWKXalN2hvmcVprHW49pWJ44YHciq/Eo0FKIwev3JELVIvImS08eX6+rz7eWFXKFOI
         V0DA==
X-Gm-Message-State: AOAM533u1bMSSjTvgHRRv9Y1XBM4h3VUmRSavcNeIaiUuNH+bsfYoadc
        CfKRQliY16R2UUfr5J/jO8BV65uRiPe6rQ==
X-Google-Smtp-Source: ABdhPJw1TT5auEHEOxsMaDaNIKHnSoCzmxorwYj7pD5I60UNLOyyz6jDh9rwq3HSZDDewfzFKE7g0w==
X-Received: by 2002:a1c:94:: with SMTP id 142mr2540529wma.25.1600162320915;
        Tue, 15 Sep 2020 02:32:00 -0700 (PDT)
Received: from localhost.localdomain ([85.153.229.188])
        by smtp.gmail.com with ESMTPSA id f14sm25642477wrv.72.2020.09.15.02.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 02:32:00 -0700 (PDT)
From:   Necip Fazil Yildiran <fazilyildiran@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, paul@pgazz.com, jeho@cs.utexas.edu,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: [PATCH] staging: rtl8192e: fix kconfig dependency warning for RTLLIB_CRYPTO_TKIP
Date:   Tue, 15 Sep 2020 12:30:34 +0300
Message-Id: <20200915093033.20130-1-fazilyildiran@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When RTLLIB_CRYPTO_TKIP is enabled and CRYPTO is disabled, it results in
the following Kbuild warning:

WARNING: unmet direct dependencies detected for CRYPTO_ARC4
  Depends on [n]: CRYPTO [=n]
  Selected by [m]:
  - RTLLIB_CRYPTO_TKIP [=m] && STAGING [=y] && RTLLIB [=m]

WARNING: unmet direct dependencies detected for CRYPTO_MICHAEL_MIC
  Depends on [n]: CRYPTO [=n]
  Selected by [m]:
  - RTLLIB_CRYPTO_TKIP [=m] && STAGING [=y] && RTLLIB [=m]

The reason is that RTLLIB_CRYPTO_TKIP selects CRYPTO_ARC4 and
CRYPTO_MICHAEL_MIC without depending on or selecting CRYPTO while both
CRYPTO_ARC4 and CRYPTO_MICHAEL_MIC are subordinate to CRYPTO.

Honor the kconfig menu hierarchy to remove kconfig dependency warnings.

Fixes: e0e3daddad36 ("staging: r8192e: Fix possible error in configuration")
Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 drivers/staging/rtl8192e/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8192e/Kconfig b/drivers/staging/rtl8192e/Kconfig
index 1007eea6c8fc..fd237dda8be4 100644
--- a/drivers/staging/rtl8192e/Kconfig
+++ b/drivers/staging/rtl8192e/Kconfig
@@ -25,6 +25,7 @@ config RTLLIB_CRYPTO_CCMP
 config RTLLIB_CRYPTO_TKIP
 	tristate "Support for rtllib TKIP crypto"
 	depends on RTLLIB
+	select CRYPTO
 	select CRYPTO_ARC4
 	select CRYPTO_MICHAEL_MIC
 	default y
-- 
2.25.1

