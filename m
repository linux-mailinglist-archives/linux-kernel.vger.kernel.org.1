Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250F02DFFF4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgLUShT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgLUShO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:37:14 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8B5C061248;
        Mon, 21 Dec 2020 10:36:34 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id g24so10527492edw.9;
        Mon, 21 Dec 2020 10:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oNd3Cj9ofLW7wsKsWYoo4m+jvoyCrPWYva0lGSx6HLI=;
        b=iS2yVEm0mrQBkSIzs31UmsZ8tWjNIpcJE29cPmW6sbugzwVDkaARPZkD3lgzrlAFhe
         3Z3qqcrfvufI8FsD0iCzzr4fw58v3BSxMyAlGMdWldSoL6Hl6fki+72imeQHD+cqVYSg
         6s+gDNUd4j2JRU0pAghzMbys1e8uFqkTyCavTSfJ5rSJYWXgyQCxLPAyvbocG5vDhbgO
         XRYNdF20Mn4R/jnfRnTyObyUl0cksHEMOLNb8UX4b+0TYWADoWcg4JRaoenze1t9LLPF
         u9uobKiLp3exk3Bg6VOQMlXXqxQrY5aKTVzoHfS8CXAWIq1PU1neVlWjPsVP/FmANnft
         aAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oNd3Cj9ofLW7wsKsWYoo4m+jvoyCrPWYva0lGSx6HLI=;
        b=Ik23OK5FAbNHEhh6vDjfXZzvJdo9OnnQzEu+kFM0RO/ApoX3dfumeB5BXxtqWMru85
         U8reea62EcS9BDuEKkNCjrVp0c8WDGvEyg7ytaUetO2HkYOaH+brILSmqNHJe5B+4qNV
         4BGgyABPm34BbRGqAtkKuA1jPFKg5ixzIJquFpsRUVApHyacO73JfgGnBFDkSpal39d4
         oPeeRiJtb1NpGOfxVX/xUET4EaxOkPxqsxF5oDPFH/j3lj6dibi7Gw2lc7TGVYMls/lf
         KpqghpF4MFcEUDHHRVMJGBIKeUHvFuYHpBTrm3xUxq8U+qEF6wtagoKwdwO6tH6Hogbo
         BEDA==
X-Gm-Message-State: AOAM530cgGnqw1d7KgmCBie4otbv4ndrnbBSQLVqTjSMH61jxjhmWLSV
        dWcKoFIvWiX6/WwRfg6P/CIwy5WNB9I=
X-Google-Smtp-Source: ABdhPJyD0W/TddTDIYPKP1wBicmpB8JUJSeMPnIuBd+Ypyt07Y/3n769MYyET0XEuVsR4qEKglpLXA==
X-Received: by 2002:a05:6402:308b:: with SMTP id de11mr16882835edb.205.1608575793147;
        Mon, 21 Dec 2020 10:36:33 -0800 (PST)
Received: from localhost.localdomain (p200300f137019000428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3701:9000:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id ld2sm9390408ejb.73.2020.12.21.10.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 10:36:32 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] dt-bindings: clock: meson8b: remove non-existing clock macros
Date:   Mon, 21 Dec 2020 19:36:24 +0100
Message-Id: <20201221183624.932649-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201221183624.932649-1-martin.blumenstingl@googlemail.com>
References: <20201221183624.932649-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CLKID_UNUSED and CLKID_XTAL aren't valid clocks. Remove them since
there are no consumers of this anymore.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 include/dt-bindings/clock/meson8b-clkc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/dt-bindings/clock/meson8b-clkc.h b/include/dt-bindings/clock/meson8b-clkc.h
index 4c5965ae1df4..f33781338eda 100644
--- a/include/dt-bindings/clock/meson8b-clkc.h
+++ b/include/dt-bindings/clock/meson8b-clkc.h
@@ -6,8 +6,6 @@
 #ifndef __MESON8B_CLKC_H
 #define __MESON8B_CLKC_H
 
-#define CLKID_UNUSED		0
-#define CLKID_XTAL		1
 #define CLKID_PLL_FIXED		2
 #define CLKID_PLL_VID		3
 #define CLKID_PLL_SYS		4
-- 
2.29.2

